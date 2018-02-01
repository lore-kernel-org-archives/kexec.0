Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-it0-x230.google.com ([2607:f8b0:4001:c0b::230])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1ehJXu-0003ia-5s
 for kexec@lists.infradead.org; Thu, 01 Feb 2018 18:25:15 +0000
Received: by mail-it0-x230.google.com with SMTP id x128so5396716ite.0
 for <kexec@lists.infradead.org>; Thu, 01 Feb 2018 10:25:02 -0800 (PST)
MIME-Version: 1.0
From: William Larson <wlarsong@gmail.com>
Date: Thu, 1 Feb 2018 11:25:00 -0700
Message-ID: <CAF=B_pUnyT_T5f8M5fkLmnGXQ07qkpZe+B5gYtvu4tS2YQQCVg@mail.gmail.com>
Subject: kexec Cannot Locate hole of 0x1000 bytes...
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

Hello
I am trying to use kexec on an armv5 board to load a crash kernel.
Loading a non crash kernel works ok.

bootargs for uboot are
console=ttySAC0,115200 root=/dev/mmcblk0p2 rw rootwait init=/linuxrc
panic=2 mac=00:12:E5:04:81:93 crashkernel=60M@32M

kexec version is 2.0.16

kexec -p -t zImage /mnt/zImage-ramdisk  --append="console=ttySAC0,115200 root=
/dev/mmcblk0p2 initrd rw rootwait init=/linuxrc panic=2
mac=00:12:E5:04:81:93 crashkernel=60M@32M"

kexec documentation says that crashkernel for arm processors isn't
required but when I tried to run kexec without this parameter it said
it could not load it.

I have played around with this code intensively trying to get it to
work but alas it isn't
Here is the output:

# kexec -d -p -t zImage /mnt/zImage-ramdisk  --append="console=ttySAC0,115200 ro
ot=/dev/mmcblk0p2 initrd rw rootwait init=/linuxrc panic=2
mac=00:12:E5:04:81:93"
Try gzip decompression.
kernel: 0x402d1008 kernel_size: 0x69f928
MEMORY RANGES
0000000030000000-0000000033ffffff (0)
0000000038000000-000000003bffffff (0)
zImage header: 0x016f2818 0x00000000 0x0069f928
zImage size 0x69f928, file size 0x69f928
Reserved memory ranges
0000000002000000-0000000005bfffff (0)
Coredump memory ranges
0000000030000000-0000000033ffffff (0)
0000000038000000-000000003bffffff (0)
kernel symbol _stext vaddr =         c0008400
phys offset = 0x30000000, page offset = c0000000
Using 32-bit ELF core format
get_crash_notes_per_cpu: crash_notes addr = 3061417c, size = 1024
Elf header: p_type = 4, p_offset = 0x3061417c p_paddr = 0x3061417c
p_vaddr = 0x0 p_filesz = 0x400 p_memsz = 0x400
vmcoreinfo header: p_type = 4, p_offset = 0x30486dc0 p_paddr =
0x30486dc0 p_vaddr = 0x0 p_filesz = 0x1000 p_memsz = 0x1000
Elf header: p_type = 1, p_offset = 0x30000000 p_paddr = 0x30000000
p_vaddr = 0xc0000000 p_filesz = 0x4000000 p_memsz = 0x4000000
Elf header: p_type = 1, p_offset = 0x38000000 p_paddr = 0x38000000
p_vaddr = 0xc8000000 p_filesz = 0x4000000 p_memsz = 0x4000000
Could not find a free area of memory of 0x1000 bytes...
locate_hole failed

I have also tried with --mem-min and --mem-max arguements as well

# cat /proc/iomem
02000000-05bfffff : Crash kernel
08000004-08000007 : dm9000
  08000004-08000007 : dm9000
08000008-0800000b : dm9000
  08000008-0800000b : dm9000
30000000-33ffffff : System RAM
  30008000-3040e65b : Kernel text
  3044c000-30490fff : Kernel data
38000000-3bffffff : System RAM
49000000-490000ff : s3c2410-ohci
  49000000-490000ff : ohci_hcd
4a800000-4a800fff : s3c-sdhci.1
  4a800000-4a800fff : mmc1
4ac00000-4ac00fff : s3c-sdhci.0
  4ac00000-4ac00fff : mmc0
4c800000-4c803fff : s3c-fb
  4c800000-4c803fff : s3c-fb
4e000000-4e0fffff : s3c2412-nand
  4e000000-4e0fffff : s3c2412-nand
50000000-50003fff : s3c2440-uart.0
  50000000-500000ff : s3c2440-uart
50004000-50007fff : s3c2440-uart.1
  50004000-500040ff : s3c2440-uart
50008000-5000bfff : s3c2440-uart.2
  50008000-500080ff : s3c2440-uart
5000c000-5000ffff : s3c2440-uart.3
  5000c000-5000c0ff : s3c2440-uart
52000000-52100000 : s3c64xx-spi.0
  52000000-52100000 : s3c64xx-spi
53000000-530003ff : s3c2410-wdt
54000000-54000fff : s3c2410-i2c
  54000000-54000fff : s3c2440-i2c
55000000-550fffff : s3c2412-iis
5b000000-5b0fffff : samsung-ac97
  5b000000-5b0fffff : ac97

#free
             total         used         free       shared      buffers
Mem:        125452        21744       103708            0         1320
-/+ buffers:              20424       105028
Swap:            0            0            0


I tried messing around with the kexec to get the holes to align
properly and this is the output

 kexec -p --mem-min=38000000 -t zImage /mnt/zImage-ramdisk  --append="console=t
tySAC0,115200 root=/dev/mmcblk0p2 initrd rw rootwait init=/linuxrc panic=2 mac=0
0:12:E5:04:81:93"
hole_size:1000, hole_align:100000,hole_min:2000000, hole_max5bfffff hole_end:-1
=============mem_ranges:0 mstart30000000
******mem_ranges:0 mstart:30000000 mem_range[0].start:30000000
=============mem_ranges:0 mend33ffffff
******mem_ranges:0 mend:33ffffff mem_range[0].end:33ffffff
=============mem_ranges:1 mstart38000000
******mem_ranges:1 mstart:38000000 mem_range[1].start:38000000
=============mem_ranges:1 mend3bffffff
******mem_ranges:1 mend:3bffffff mem_range[1].end:3bffffff
mem_range[0].start:30000000 mem_range[0].end:33ffffff
start:30000000 mem_min:243d580 hole_min:2000000 end:33ffffff i:0
+++start:30000000 hole_align:100000
===start:30000000 hole_align:100000
end > hole_max
end:33ffffff - start:30000000 = size:3ffffff
hole_end:ffffffff
Align Down
hole_base:33f00000
mem_range[1].start:38000000 mem_range[1].end:3bffffff
start:38000000 mem_min:243d580 hole_min:2000000 end:3bffffff i:1
+++start:38000000 hole_align:100000
===start:38000000 hole_align:100000
end > hole_max
end:3bffffff - start:38000000 = size:3ffffff
hole_end:ffffffff
Align Down
hole_base:3bf00000
last=3bf00fff base=3bf00000 memsz=1000
for loop
mstart:30000000 sstart:3bf00000 mend:33ffffff send:3bf00fff
mstart:30000000 sstart:3bf00000 mend:33ffffff send:3bf00fff
return 1
last=4127fff base=4127000 memsz=1000
for loop
mstart:30000000 sstart:4127000 mend:33ffffff send:4127fff
mstart:30000000 sstart:4127000 mend:33ffffff send:4127fff
for loop
mstart:38000000 sstart:4127000 mend:3bffffff send:4127fff
mstart:38000000 sstart:4127000 mend:3bffffff send:4127fff
Out of loop failure
398
last=26a7fff base=2008000 memsz=6a0000
send > mem_max or sstart < mem_min398
for loop
mstart:30000000 sstart:3bf00000 mend:33ffffff send:3bf00fff
mstart:30000000 sstart:3bf00000 mend:33ffffff send:3bf00fff
return 1
for loop
mstart:30000000 sstart:4127000 mend:33ffffff send:4127fff
mstart:30000000 sstart:4127000 mend:33ffffff send:4127fff
for loop
mstart:38000000 sstart:4127000 mend:3bffffff send:4127fff
mstart:38000000 sstart:4127000 mend:3bffffff send:4127fff
Out of loop failure
kexec_load failed: Cannot assign requested address
entry       = 0x2008000 flags = 0x280001
nr_segments = 3
segment[0].buf   = 0x4029a008
segment[0].bufsz = 0x69f928
segment[0].mem   = 0x2008000
segment[0].memsz = 0x6a0000
segment[1].buf   = 0x1b1b678
segment[1].bufsz = 0x48
segment[1].mem   = 0x4127000
segment[1].memsz = 0x1000
segment[2].buf   = 0x1b1b220
segment[2].bufsz = 0x400
segment[2].mem   = 0x3bf00000
segment[2].memsz = 0x1000

Any help much appriciated

-- 
-William Larson

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
