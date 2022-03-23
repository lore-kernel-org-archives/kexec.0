From: Tobias Powalowski <tobias.powalowski@googlemail.com>
Date: Wed, 23 Mar 2022 12:14:59 +0100
Subject: running into OOM killer with kexec loading large ramdisk
Message-ID: <CAHfPjO8XBp5C_kTaifPjLVJxS3Z7W5V+qHEm6-zh2_Jv8Ydyew@mail.gmail.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Hi,
again me,
I try to load a 900MB ramdisk on a ramfs rootfs  with kexec and a 10MB kernel.
With 2800MB RAM assigned to qemu.
Memory free by /proc/memstat: 2.2GB
It keeps on OOM killed while executing:
kexec -l kernel --initrd=initrd.img
I can safely unpack the initrd in the ramfs without getting OOM killed.
What is kexec doing wrong here?
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

