#define MAX_QUEUE 100 // Jumlah maksimal pemain dalam antrean
#define MAX_TRUCKER_MISSIONS 10 // Jumlah total jenis misi

// Variabel Global yang dibutuhkan (pastikan ini di bagian atas script Anda)
new g_MissionQueue[MAX_QUEUE]; // Menyimpan playerid dalam antrean
new g_QueueSize = 0; // Ukuran antrean saat ini

new bool:DialogMissions[MAX_TRUCKER_MISSIONS]; // Status misi: true jika rute misi ini sedang diambil oleh SESEORANG
new TrailerMission[MAX_PLAYERS]; // ID kendaraan trailer yang di-spawn untuk pemain
new PlayerMissions[MAX_PLAYERS]; // Indeks misi TruckerMissions[] yang sedang diambil pemain
new bool:PlayerTakeMissions[MAX_PLAYERS]; // TRUE jika pemain ini sudah dapat giliran untuk take missions (boleh pakai /takemissions)
new bool:InMissionQueue[MAX_PLAYERS]; // TRUE jika pemain ini ada di dalam antrean (Menjaga agar pemain tidak double masuk antrean)

enum truckerMissions {
  issuerName[32],
  salaryCost,
  Float:takeTrailerX,
  Float:takeTrailerY,
  Float:takeTrailerZ,
  Float:trailerAngle,
  Float:sendTrailerX,
  Float:sendTrailerY,
  Float:sendTrailerZ
};

new const TruckerMissions[MAX_TRUCKER_MISSIONS][truckerMissions] = {
  {"Ocean Docks Import", 1000, 2791.4016, -2494.5452, 14.2522, 89.5366, -2471.2942, 783.0248, 35.1719},
  {"Ocean Docks Import", 900, 2784.3132, -2456.6299, 14.2415, 89.4938, -576.2687, 2569.0842, 53.5156},
  {"Angel Pine Export", 300, -1963.0142, -2436.3079, 31.2311, 226.1548, 1424.8624, 2333.4939, 10.8203},
  {"Angel Pine Export", 800, -1966.5603, -2439.9380, 31.2306, 225.5799, 1198.7153, 165.4331, 20.5056},
  {"Chilliad Deport", 950, -1863.1541, -1720.5603, 22.3558, 122.1463, 1201.5385, 171.6184, 20.5035},
  {"Chilliad Deport", 750, -1855.7255, -1726.0389, 22.3566, 124.4187, 2786.8313, -2417.9558, 13.6339},
  {"Easter Import", 950, -1053.6145, -658.6473, 32.6319, 260.6392, 1613.7815, 2236.2046, 10.3787},
  {"Blueberry Export", 980, -459.3511, -48.3457, 60.5507, 182.7280, 2415.7803, -2470.1309, 13.6300},
  {"Las Venturas Deport", 850, 847.0450, 921.0422, 13.9579, 201.2555, -980.1684, -713.3505, 32.0078},
  {"Las Venturas Fuel & Gas", 775, 249.6713, 1395.7150, 11.1923, 269.0699, -2226.1292, -2315.1055, 30.6045}
};

// --- Fungsi Helper Antrean ---

stock AddToMissionQueue(playerid) {
    if (InMissionQueue[playerid]) { // Cek jika pemain sudah dalam antrean
        return -1; // Pemain sudah ada di antrean
    }
    if (g_QueueSize >= MAX_QUEUE) {
        return 0; // Antrean penuh
    }

    g_MissionQueue[g_QueueSize] = playerid;
    g_QueueSize++;
    InMissionQueue[playerid] = true;
    return g_QueueSize; // Mengembalikan posisi pemain yang baru ditambahkan
}

stock IsInMissionQueue(playerid) {
    return InMissionQueue[playerid]; // Lebih efisien, langsung cek flag
}

stock GetQueuePosition(playerid) {
    for (new i = 0; i < g_QueueSize; i++) {
        if (g_MissionQueue[i] == playerid) {
            return i + 1; // Posisi 1-based (jadi kalau di indeks 0, dikembalikan 1)
        }
    }
    return 0; // Mengembalikan 0 jika pemain tidak ditemukan di antrean
}

stock RemoveFromMissionQueue(playerid) {
    new playerPos = -1;
    for (new i = 0; i < g_QueueSize; i++) {
        if (g_MissionQueue[i] == playerid) {
            playerPos = i;
            break;
        }
    }

    if (playerPos == -1) {
        return 0; // Pemain tidak ditemukan di antrean
    }

    // Geser elemen setelah pemain yang dihapus ke depan
    for (new i = playerPos; i < g_QueueSize - 1; i++) {
        g_MissionQueue[i] = g_MissionQueue[i+1];
    }
    g_QueueSize--;
    InMissionQueue[playerid] = false;
    
    // Setelah pemain dihapus, cek apakah ada pemain yang harus diberi giliran
    if (g_QueueSize > 0) {
        new nextPlayerId = g_MissionQueue[0]; // Pemain pertama di antrean
        if (!PlayerTakeMissions[nextPlayerId] && !pData[nextPlayerId][pMissions]) { // Jika belum punya giliran dan tidak dalam misi aktif
            GivePlayerMission(nextPlayerId); // Berikan giliran
        }
    }
    return 1;
}

// --- Fungsi GivePlayerMission (Direvisi) ---
stock GivePlayerMission(playerid) {
    // Pastikan pemain belum dalam misi dan belum punya giliran
    if (pData[playerid][pMissions] || PlayerTakeMissions[playerid]) {
        return 0; // Pemain sudah dalam misi atau sudah diberi giliran
    }

    // Cek apakah pemain ini benar-benar yang pertama di antrean
    if (g_QueueSize > 0 && g_MissionQueue[0] == playerid) {
        PlayerTakeMissions[playerid] = true;
        // InMissionQueue[playerid] tetap true sampai dia ambil misi dan dihapus dari antrean
        Custom(playerid, "TRUCKING", "Anda mendapatkan giliran pertama. Gunakan "YELLOW"/takemissions");
        return 1;
    }
    return 0; // Bukan giliran pemain ini
}

// --- Dialog Utama: DIALOG_MISSIONS ---
// Ini adalah dialog saat pemain pertama kali mengetik /missions
Dialog:DIALOG_MISSIONS(playerid, response, listitem, inputtext[]) {
    if (!response) { // Jika pemain menekan "Batal"
        return 1;
    }

    if (listitem == 0) { // Memilih "Ambil Antrean Misi"
        if(pData[playerid][pSkillTrucker] < 5) {
            return Error(playerid, "Anda harus memiliki skill trucker level 5.");
        }
        
        // Pemain pertama yang masuk antrean dan TIDAK ADA YANG SEDANG DALAM MISI, akan langsung dapat misi
        if (g_QueueSize == 0) { // Jika antrean kosong
            // Cek apakah ada pemain lain yang sedang dalam misi aktif.
            // Loop semua pemain, jika ada yang pMissions = true, berarti ada misi aktif.
            new bool:activeMissionExists = false;
            for (new i = 0; i < MAX_PLAYERS; i++) {
                if (IsPlayerConnected(i) && pData[i][pMissions]) {
                    activeMissionExists = true;
                    break;
                }
            }

            if (!activeMissionExists) { // Jika tidak ada misi aktif di server
                // Langsung berikan giliran dan instruksikan /takemissions
                PlayerTakeMissions[playerid] = true;
                Custom(playerid, "TRUCKING", "Anda mendapatkan giliran pertama. Gunakan "YELLOW"/takemissions");
                return 1;
            }
        }

        // Jika antrean tidak kosong ATAU ada misi aktif, pemain akan masuk antrean
        if (pData[playerid][pMissions]) { // Jika pemain ini sudah dalam misi aktif
            return Error(playerid, "Anda sedang dalam misi aktif. Selesaikan misi Anda saat ini.");
        }

        new addResult = AddToMissionQueue(playerid);
        if (addResult == -1) { // Pemain sudah di antrean
            return Error(playerid, "Kamu sudah dalam antrean.");
        } else if (addResult == 0) { // Antrean penuh
            return Error(playerid, "Antrean misi penuh. Coba lagi nanti.");
        }

        new pos = GetQueuePosition(playerid); // Dapatkan posisi setelah ditambahkan
        Custom(playerid, "TRUCKING", "Kamu masuk antrean. Posisi saat ini: "LIGHTGREEN"%d", pos);
        Custom(playerid, "NOTE", "Kamu akan mendapat notifikasi saat giliran.");
        PlayerTakeMissions[playerid] = false; // Pastikan status take missions FALSE saat masuk antrean
    }
    else if (listitem == 1) { // Memilih "Lihat Gudang"
        callcmd::warehouse(playerid, "");
    }
    return 1;
}

// --- Dialog Pilihan Rute Misi: TruckMissions ---
// Ini adalah dialog yang muncul setelah pemain menggunakan /takemissions
Dialog:TruckMissions(playerid, response, listitem, inputtext[]) {
    if (response && listitem != -1) {
        // Cek kembali status giliran
        if (!PlayerTakeMissions[playerid] || pData[playerid][pMissions]) {
            // Ini bisa terjadi jika timing tidak pas atau pemain mencoba exploit.
            // Seharusnya dia tidak bisa sampai sini tanpa PlayerTakeMissions = true
            return Error(playerid, "Anda tidak memiliki giliran atau sudah dalam misi.");
        }

        if (DialogMissions[listitem] == true) { // Jika rute misi ini sudah diambil oleh orang lain
            return Error(playerid, "Rute Trucking ini sudah diambil oleh orang lain!");
        }

        // Misi berhasil diambil
        DialogMissions[listitem] = true; // Tandai rute misi ini sebagai diambil
        PlayerMissions[playerid] = listitem; // Simpan indeks misi yang diambil pemain
        pData[playerid][pMissions] = true; // Tandai pemain ini sedang dalam misi aktif

        // Set checkpoint dan spawn trailer
        SetPlayerMissionsCP(playerid);
        Custom(playerid, "MISSIONS", "Pergi ke checkpoint yang ditandai di peta Anda.");

        // Hapus pemain dari antrean SETELAH dia berhasil mengambil misi
        RemoveFromMissionQueue(playerid);
        PlayerTakeMissions[playerid] = false; // Reset status giliran karena sudah mengambil misi
    }
    return 1;
}

#include <YSI\y_hooks>

// --- Hook: OnPlayerEnterRaceCP (Logika Selesai Misi) ---
hook OnPlayerEnterRaceCP(playerid) {
    // Checkpoint pengambilan trailer
    if (pData[playerid][pMissions] && !pData[playerid][pTrailer]) {
        new index = PlayerMissions[playerid];

        DisablePlayerRaceCheckpoint(playerid);
        Custom(playerid, "TRUCKING]","Pasang trailer ke kendaraan Anda untuk memesan");

        pData[playerid][pTrailer] = true; // Tandai pemain sudah dapat trailer

        SetPlayerRaceCheckpoint(playerid, 1,
            TruckerMissions[index][sendTrailerX],
            TruckerMissions[index][sendTrailerY],
            TruckerMissions[index][sendTrailerZ],
            0.0, 0.0, 0.0, 10.0
        );
        return 1;
    }

    // Checkpoint penyelesaian misi (pengiriman trailer)
    if (pData[playerid][pTrailer] && pData[playerid][pMissions]) {
        if (IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid))) {
            new index = PlayerMissions[playerid];

            DisablePlayerRaceCheckpoint(playerid);
            if (IsValidVehicle(TrailerMission[playerid])) {
                DestroyVehicle(TrailerMission[playerid]);
            }

            TrailerMission[playerid] = INVALID_VEHICLE_ID;
            pData[playerid][pTrailer] = false;
            pData[playerid][pMissions] = false; // Misi selesai
            pData[playerid][pTruckerHaulingTime] = 600;

            DialogMissions[index] = false; // Misi rute ini sekarang tersedia lagi

            AddPlayerSalary(playerid, "Trucker Missions", TruckerMissions[index][salaryCost]);

            Custom(playerid, "TRUCKING", "Misi selesai: "YELLOW"%s. "WHITE"Dapat: "GREEN"%s", TruckerMissions[index][issuerName], FormatMoney(TruckerMissions[index][salaryCost]));

            PlayerMissions[playerid] = -1; // Reset mission ID pemain
            PlayerTakeMissions[playerid] = false; // Reset status giliran

            // !!! BAGIAN PENTING: Panggil pemain berikutnya di antrean !!!
            // Loop melalui antrean untuk menemukan pemain berikutnya yang valid
            // RemoveFromMissionQueue sudah dipanggil saat pemain mengambil misi
            // Jadi di sini, kita hanya perlu memanggil GivePlayerMission untuk pemain pertama di antrean
            if (g_QueueSize > 0) {
                new nextPlayerInQueue = g_MissionQueue[0];
                if (IsPlayerConnected(nextPlayerInQueue)) {
                    GivePlayerMission(nextPlayerInQueue);
                } else {
                    // Jika pemain pertama di antrean disconnect, hapus dia dan coba lagi
                    RemoveFromMissionQueue(nextPlayerInQueue); // Ini akan memicu rekursif untuk memberi giliran ke pemain valid berikutnya
                }
            }
        }
    }
    return 1;
}

// --- Hook: OnPlayerConnect ---
hook OnPlayerConnect(playerid) {
    PlayerMissions[playerid] = -1;
    PlayerTakeMissions[playerid] = false;
    InMissionQueue[playerid] = false;
    TrailerMission[playerid] = INVALID_VEHICLE_ID;
    return 1;
}

// --- Hook: OnPlayerDisconnect ---
hook OnPlayerDisconnect(playerid) {
    if (pData[playerid][pMissions]) {
        if (IsValidVehicle(TrailerMission[playerid])) {
            DestroyVehicle(TrailerMission[playerid]);
        }
        DialogMissions[PlayerMissions[playerid]] = false; // Rute misi yang diambil pemain ini tersedia lagi
    }

    // Reset semua status dan hapus dari antrean
    PlayerMissions[playerid] = -1;
    PlayerTakeMissions[playerid] = false;
    InMissionQueue[playerid] = false;
    RemoveFromMissionQueue(playerid); // Ini akan memicu pemain berikutnya di antrean
    
    return 1;
}

// --- CMD:takemissions (Direvisi) ---
CMD:takemissions(playerid, params[]) {
    if(pData[playerid][pJob] != 4 && pData[playerid][pJob2] != 4) { // Cek pekerjaan trucker
        return Error(playerid, "Anda bukan pekerjaan trucker.");
    }
    
    if(pData[playerid][pMissions]) { // Jika sudah dalam misi aktif
        return Error(playerid, "Anda sudah dalam misi aktif. Selesaikan misi Anda saat ini.");
    }

    if(PlayerTakeMissions[playerid] == false) { // Jika belum dapat giliran
        new pos = GetQueuePosition(playerid);
        if (pos > 0) {
            return Error(playerid, "Belum giliran Anda. Anda di posisi %d dalam antrean.", pos);
        } else {
            return Error(playerid, "Anda tidak memiliki giliran atau tidak dalam antrean misi.");
        }
    }

    // Jika sudah giliran (PlayerTakeMissions == true) dan tidak dalam misi
    new str[640];
    format(str, sizeof(str), "Order\tPrice\n");
    for (new i = 0; i < MAX_TRUCKER_MISSIONS; i ++) {
        format(str, sizeof(str), "%s%s\t%s\n", str, TruckerMissions[i][issuerName], 
               (DialogMissions[i] == true) ? (RED"TAKEN") : (FormatMoney(TruckerMissions[i][salaryCost])));
    }
    Dialog_Show(playerid, TruckMissions, DIALOG_STYLE_TABLIST_HEADERS, "Missions", str, "Take", "Close");
    
    return 1;
}

// --- Fungsi SetPlayerMissionsCP ---
stock SetPlayerMissionsCP(playerid) {
    if((pData[playerid][pJob] == 4 || pData[playerid][pJob2] == 4) && pData[playerid][pMissions]) {
        new index = PlayerMissions[playerid];

        // Set checkpoint pengambilan trailer
        SetPlayerRaceCheckpoint(playerid, 1, TruckerMissions[index][takeTrailerX], TruckerMissions[index][takeTrailerY], TruckerMissions[index][takeTrailerZ], 0.0, 0.0, 0.0, 10.0);
        
        // Spawn trailer
        TrailerMission[playerid] = CreateVehicle(435, TruckerMissions[index][takeTrailerX], TruckerMissions[index][takeTrailerY], TruckerMissions[index][takeTrailerZ], TruckerMissions[index][trailerAngle], 1, 1, -1);
    }
    return 1;
}

CMD:attachtrailer(playerid, params[]) 
{
    if(pData[playerid][pJob] == 4 || pData[playerid][pJob2] == 4)
    {
        if (!pData[playerid][pMissions]) return Error(playerid, "Kamu tidak sedang melakukan truck missions!");

        new vehicleid = TrailerMission[playerid], Float:vPos[3];
        GetVehiclePos(vehicleid, vPos[0], vPos[1], vPos[2]);
        
        if(vehicleid == INVALID_VEHICLE_ID) return Error(playerid, "Anda saat tidak mempunyai angkutan/trailer");
        if (!IsPlayerInRangeOfPoint(playerid, 10.0, vPos[0], vPos[1], vPos[2])) return Error(playerid, "Trailer truck kamu tidak berada didekatmu!");
        if (!IsPlayerInAnyVehicle(playerid)) return Error(playerid, "Kamu harus di kendaraan untuk menggunakan perintah ini!");

        AttachTrailerToVehicle(vehicleid, GetPlayerVehicleID(playerid));
        Custom(playerid, "TRAILER", "You has successfully attach your trailer!");
    }
    return 1;
}

CMD:findtrailer(playerid) 
{
    if(pData[playerid][pJob] == 4 || pData[playerid][pJob2] == 4)
    {
        if (!pData[playerid][pMissions]) return Error(playerid, "Kamu tidak sedang melakukan truck missions!");

        new vehicleid = TrailerMission[playerid], Float:vPos[3];

        if (IsValidVehicle(vehicleid)) {
            if (IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)))
            return Error(playerid, "Your Trailer has already attached to your truck");

            GetVehiclePos(vehicleid, vPos[0], vPos[1], vPos[2]);
            SetPlayerRaceCheckpoint(playerid, 0, vPos[0], vPos[1], vPos[2], 0.0, 0.0, 0.0, 5.0);
            Custom(playerid, "FINDTRAILER", "Your trailer is on marked location");
        }
    }
    return 1;
}

public OnTrailerHooked(playerid,vehicleid,trailerid)
{
    if(pData[playerid][pJob] == 4 || pData[playerid][pJob2] == 4 && pData[playerid][pMissions])
    {
        if (TrailerMission[playerid] == trailerid) {
            new index = PlayerMissions[playerid];

            DisablePlayerRaceCheckpoint(playerid);
            Custom(playerid, "MISSIONS]","Please send the trailer to order");
            SetPlayerRaceCheckpoint(playerid, 1, TruckerMissions[index][sendTrailerX], TruckerMissions[index][sendTrailerY], TruckerMissions[index][sendTrailerZ], 0.0, 0.0, 0.0, 10.0);
        }
    }
    return 1;
}