From: Tobias Powalowski <tobias.powalowski@googlemail.com>
Date: Wed, 16 Mar 2022 11:57:41 +0100
Subject: Qemu does not like kexec initrd
Message-ID: <CAHfPjO_Ln_yzU5_Crgk+SWyXWU=KALwTx6tWa7PSN2Wag-si-A@mail.gmail.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Hi
I just discovered this:
https://githubhot.com/repo/talos-systems/talos/issues/4947
I also suffer from this in my project:
Loading zstd initrd will cause an error:
ZSTD-data is corrupt error on qemu.
Is there a fix or workaround for this issue?

greetings
tpowa
-- 
Tobias Powalowski
Arch Linux Developer & Package Maintainer (tpowa)
https://www.archlinux.org
tpowa at archlinux.org

St. Martin-Apotheke
Herzog-Georg-Str. 25
89415 Lauingen
https://www.st-martin-apo.de
info at st-martin-apo.de

