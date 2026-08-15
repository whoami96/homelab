# Homelab (Podman Edition)

Repository containing the infrastructure and container configuration for my homelab environment, powered by **Podman**, **Rootless Containers**, **systemd/journald**, and **Proxmox**.

---

## 🏗️ Architektura i Koncepcja

* **Podman (Rootless):** Wszystkie usługi działają domyślnie w trybie rootless pod dedykowanym użytkownikiem (UID `1000`), co zapewnia izolację i wysoki poziom bezpieczeństwa.
* **Logowanie do Journald:** Kontenery przekazują logi bezpośrednio do systemd `journald` (`logging.driver: journald`), co umożliwia centralne zbieranie logów przez Promtail/Loki.
* **Podman Socket:** Włączony socket użytkownika (`/run/user/1000/podman/podman.sock`) oraz root (`/run/podman/podman.sock`) do integracji z narzędziami monitorującymi, Diun, Portainerem oraz Nextcloud.
* **Sieci Bridge i izolacja:** Usługi z bazami danych lub wieloma komponentami posiadają dedykowane sieci wewnętrzne.

---

## 📁 Struktura Usług (`podman/`)

| Katalog | Usługa | Opis | Główne Porty |
| :--- | :--- | :--- | :--- |
| [`podman/diun`](file:///home/whoami/Git/personal/homelab/podman/diun) | **Diun** | Docker Image Update Notifier (powiadomienia o aktualizacjach przez Discord) | Socket |
| [`podman/koinsight`](file:///home/whoami/Git/personal/homelab/podman/koinsight) | **KoInsight** | Panel statystyk i synchronizacji czytników KOReader | `3005` |
| [`podman/monitoring`](file:///home/whoami/Git/personal/homelab/podman/monitoring) | **Monitoring Stack** | Prometheus, Alertmanager, Grafana, Loki, Promtail, Exportery (Podman, Node, Speedtest, UPS) | `3000`, `9080`, `3100`, `9093` |
| [`podman/navidrome`](file:///home/whoami/Git/personal/homelab/podman/navidrome) | **Navidrome** | Serwer streamingu muzyki (Subsonic API) | `4533` |
| [`podman/nextcloud`](file:///home/whoami/Git/personal/homelab/podman/nextcloud) | **Nextcloud AIO** | Chmura osobista + MariaDB + Redis | `8080` |
| [`podman/npm`](file:///home/whoami/Git/personal/homelab/podman/npm) | **Nginx Proxy Manager** | Reverse proxy z automatycznymi certyfikatami SSL (Let's Encrypt) | `80`, `81`, `443` |
| [`podman/pihole`](file:///home/whoami/Git/personal/homelab/podman/pihole) | **Pi-hole + Unbound** | Blokowanie reklam DNS + rekurencyjny resolver DNS | `53`, `8070` |
| [`podman/portainer`](file:///home/whoami/Git/personal/homelab/podman/portainer) | **Portainer CE** | Panel graficzny zarządzania kontenerami przez socket Podmana | `9000`, `9443` |
| [`podman/semaphore`](file:///home/whoami/Git/personal/homelab/podman/semaphore) | **Semaphore UI** | Webowy interfejs do uruchamiania playbooków Ansible + MariaDB | `4000` |
| [`podman/transmission`](file:///home/whoami/Git/personal/homelab/podman/transmission) | **Transmission** | Klient BitTorrent z interfejsem webowym | `9091`, `51413` |
| [`podman/wallabag`](file:///home/whoami/Git/personal/homelab/podman/wallabag) | **Wallabag** | Self-hosted "Read-it-Later" + MariaDB + Redis | `8088` |
| [`podman/wireguard`](file:///home/whoami/Git/personal/homelab/podman/wireguard) | **WireGuard VPN** | Bezpieczny dostęp zdalny do sieci domowej + Prometheus Exporter | `51820/udp`, `9586` |

---

## 🚀 Uruchamianie Usług

### Wymagania wstępne
Włączenie gniazda Podmana (User Socket) dla bieżącego użytkownika:
```bash
systemctl --user enable --now podman.socket
```

### Uruchomienie wybranej usługi
Przejdź do katalogu wybranej usługi, skonfiguruj zmienne środowiskowe w `.env` i uruchom stos:
```bash
cd podman/<nazwa_uslugi>

# Kopiowanie szablonu zmiennych (jeśli dostępny):
cp .env.example .env

# Uruchomienie w tle:
podman-compose up -d

# Podgląd logów w czasie rzeczywistym:
podman-compose logs -f
```

---

## 🛡️ Dobre Praktyki Podman Rootless

1. **Uprawnienia do wolumenów (`:Z` / `:z`):**
   * Przy montowaniu lokalnych katalogów w systemach z SELinux, stosuj flagę `:Z` (prywatny unshared) lub `:z` (współdzielony).
2. **Utrzymywanie sesji (Linger):**
   * Aby kontenery użytkownika startowały wraz z systemem i działały w tle po wylogowaniu:
     ```bash
     loginctl enable-linger $USER
     ```
3. **Logi kontenerów w systemd:**
   * Logi wszystkich kontenerów są dostępne przez standardowe narzędzie `journalctl`:
     ```bash
     journalctl --user -u container-<nazwa_kontenera> -f
     # lub
     journalctl CONTAINER_NAME=<nazwa_kontenera> -f
     ```