Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-io0-x22b.google.com ([2607:f8b0:4001:c06::22b])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cijT7-0005aQ-Oa
 for kexec@lists.infradead.org; Tue, 28 Feb 2017 15:13:40 +0000
Received: by mail-io0-x22b.google.com with SMTP id l7so11108856ioe.3
 for <kexec@lists.infradead.org>; Tue, 28 Feb 2017 07:13:16 -0800 (PST)
MIME-Version: 1.0
From: Mahesh V <maheshvenkateshwaran@gmail.com>
Date: Tue, 28 Feb 2017 20:43:15 +0530
Message-ID: <CAEwzPJ3G2CekQF9QRCdyv5HdSH861Hb8q+wA3vrTCeF-SEOz2g@mail.gmail.com>
Subject: ARM crash kernel does not load - kexec
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

Hello Folks,
I have reserved about 150MB of crash kernel
space and was trying to test
loading the crash kernel using kexec. As it so happens,
crash kernel never boots. I tried using zImage,
uImage or vmlinux as well. After the message "Bye",
nothing happens and the u-boot for the main kernel takes over
after some time(10 seconds or so), loading the main kernel image again.
How can I debug this further?
Any pointers will help.

regards
Mahesh

Kernel version: 3.4.0, arch = ARM.
Image size is : 13450816 bytes

cat /proc/iomem
...
...
37a00000-37bfffff : registers
41500000-445fffff : System RAM
41508000-41cd2acb : Kernel code
42708000-428db69b : Kernel data
44800000-5fbfffff : System RAM
44800000-4ddfffff : Crash kernel


# kexec -t zImage -d -p crash_kernel_zImage
--command-line="console=ttymxc2,115200 init=/init rw rootfstype=ext4
rootwait"  --atags --mem-min=0x44800000
 kexec_flags == 1
kernel: 0x364008 kernel_size: 0xcd0390
MEMORY RANGES
0000000041500000-00000000445fffff (0)
0000000044800000-000000005fbfffff (0)
zImage header: 0x016f2818 0x00000000 0x00cd0390
zImage size 0xcd0390, file size 0xcd0390
Reserved memory ranges
0000000044800000-000000004ddfffff (0)
Coredump memory ranges
0000000041500000-00000000445fffff (0)
000000004de00000-000000005fbfffff (0)
kernel symbol _stext vaddr = 0xc0008180
phys offset = 0x41500000, page offset = c0000000
Crash kernel memory [0x44800000-0x4ddfffff]
Using 32-bit ELF core format
get_crash_notes_per_cpu: crash_notes addr = 5f5c80b4, size = 1024
Elf header: p_type = 4, p_offset = 0x5f5c80b4 p_paddr = 0x5f5c80b4
p_vaddr = 0x0 p_filesz = 0x400 p_memsz = 0x400
get_crash_notes_per_cpu: crash_notes addr = 5f5c70b4, size = 1024
Elf header: p_type = 4, p_offset = 0x5f5c70b4 p_paddr = 0x5f5c70b4
p_vaddr = 0x0 p_filesz = 0x400 p_memsz = 0x400
vmcoreinfo header: p_type = 4, p_offset = 0x428a2a6c p_paddr =
0x428a2a6c p_vaddr = 0x0 p_filesz = 0x1000 p_memsz = 0x1000
Elf header: p_type = 1, p_offset = 0x41500000 p_paddr = 0x41500000
p_vaddr = 0xc0000000 p_filesz = 0x3100000 p_memsz = 0x3100000
Elf header: p_type = 1, p_offset = 0x4de00000 p_paddr = 0x4de00000
p_vaddr = 0xcc900000 p_filesz = 0x11e00000 p_memsz = 0x11e00000
elfcorehdr: 0x4dd00000
crashkernel: [0x44800000 - 0x4ddfffff] (150M)
memory range: [0x41500000 - 0x445fffff] (49M)
memory range: [0x4de00000 - 0x5fbfffff] (286M)
 base 1149239296l, start 1149239296 end 1306525695
kexec_load: entry = 0x44808000 flags = 0x280001
nr_segments = 3
segment[0].buf   = 0x1034c00
segment[0].bufsz = 0x14c
segment[0].mem   = 0x44801000
segment[0].memsz = 0x1000
segment[1].buf   = 0x364008
segment[1].bufsz = 0xcd0390
segment[1].mem   = 0x44808000
segment[1].memsz = 0xcd1000
segment[2].buf   = 0x10347a8
segment[2].bufsz = 0x400
segment[2].mem   = 0x4dd00000
segment[2].memsz = 0x1000
#



# echo c > /proc/sysrq-trigger
[17609.062168] SysRq : Trigger a crash
[17609.091846] Unable to handle kernel NULL pointer dereference at
virtual address 00000000
[17609.188722] pgd = d3c84000
[17609.221025] [00000000] *pgd=55105831, *pte=00000000, *ppte=00000000
[17609.296001] Internal error: Oops: 817 [#1] SMP ARM
[17609.353296] Modules linked in: ath_pktlog(PO) umac(O) ath_dev(PO)
ath_spectral(PO) ath_dfs(PO) ath_rate_atheros(PO) ath_hal(PO) asf(PO)
adf(PO) asap_mod(PO) drvlog_mod(PO) bonding qca_nss_crypto(O)
qca_nss_drv(O) qca_nss_gmac(O) [last unloaded: crc_ccitt]
[17609.624149] CPU: 0    Tainted: P           O  (3.4.103
#maheshvenkateshwaran@mv_iap43_2-ENG.0000)
[17609.730397] PC is at sysrq_handle_crash+0x18/0x20
[17609.786629] LR is at __handle_sysrq+0xac/0x160
[17609.839769] pc : [<c01ded88>]    lr : [<c01df274>]    psr: 20000093
[17609.839769] sp : d3c97f18  ip : fa001028  fp : 00000038
[17609.977257] r10: 00000007  r9 : 00000000  r8 : 00000000
[17610.039769] r7 : 60000013  r6 : c12e72f8  r5 : 00000063  r4 : c12d6128
[17610.117901] r3 : 00000000  r2 : 00000001  r1 : 20000093  r0 : 00000063
[17610.196033] Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM
Segment user
[17610.282474] Control: 10c5787d  Table: 5518406a  DAC: 00000015
[17610.351234]
[17610.351234] PC: 0xc01ded88:
[17610.402281] ed88  e5c32000 e12fff1e e92d4038 e2405030 e3064128
e34c412d e1a01005 e30d0d90
[17610.500187] eda8  e34c0076 e3a03007 e5843000 eb066665 e5845000
e8bd8038 e92d4038 e1a05000
[17610.598094]
[17610.598094] LR: 0xc01df274:
[17610.649141] f274  ea000019 e59f0094 e3a05000 eb066532 e59f608c
e5b63004 e3530000 1a000002
[17610.747079] f294  ea00000b e2811001 ea000001 e59f2070 e3a01000
e5b20004 e1530000 1afffff8
[17610.844986]
[17610.844986] SP: 0xd3c97f18:
[17610.896033] 7f18  d3c90000 00000002 c01df328 d9955240 402e86e4
00000002 d3c97f80 c01df360
[17610.993939] 7f38  de184080 c0120b04 d3c97f80 d9955240 00000002
402e86e4 d3c97f80 00000000
[17611.091846]
[17611.091846] IP: 0xfa001028:
[17611.142893] 1028  a09eb01d 00000001 00000000 00000003 00000000
00000000 00000000 0006b3f0
[17611.240831] 1048  00000c7c 00190000 00000000 00000000 14ed482b
00230000 00000000 00000000
[17611.338738]
[17611.338738] R4: 0xc12d6128:
[17611.389784] 6128  00000007 00000004 00000001 00000007 00000000
0afa0afa dead4ead ffffffff
[17611.487691] 6148  ffffffff 00170017 dead4ead ffffffff ffffffff
d9647f78 d9647f78 00000004
[17611.585598]
[17611.585630] R6: 0xc12e72f8:
[17611.636645] 72f8  c01ded70 c076defc c076df04 00000008 c01df088
c076df14 c076df2c 00000040
[17611.734583] 7318  c01def70 c076df40 c076df58 00000040 c01df068
c076df70 c076df84 00000040
[17611.832490] Process busybox (pid: 25437, stack limit = 0xd3c902f0)
[17611.906436] Stack: (0xd3c97f18 to 0xd3c98000)
[17611.958544] 7f00:
    d3c90000 00000002
[17612.056451] 7f20: c01df328 d9955240 402e86e4 00000002 d3c97f80
c01df360 de184080 c0120b04
[17612.154358] 7f40: d3c97f80 d9955240 00000002 402e86e4 d3c97f80
00000000 00000000 c00e2cac
[17612.252296] 7f60: d5ac2680 d5ac2680 d9955240 402e86e4 00000002
00000004 00000000 c00e2f08
[17612.350203] 7f80: 00000000 00000000 ffffffff 00000000 402e6278
00000002 402e86e4 c000e104
[17612.448110] 7fa0: d3c90000 c000df80 402e6278 00000002 00000001
402e86e4 00000002 402bd2c8
[17612.546048] 7fc0: 402e6278 00000002 402e86e4 00000004 402e6000
00000020 00000100 00000038
[17612.643955] 7fe0: 00000002 befb4ba0 402bc834 402d792c 60000010
00000001 00000000 00000000
[17612.741862] cpu0
[17612.763761] [<c01ded88>] (sysrq_handle_crash+0x18/0x20) from
[<c01df274>] (__handle_sysrq+0xac/0x160)
[17612.874164] [<c01df274>] (__handle_sysrq+0xac/0x160) from
[<c01df360>] (write_sysrq_trigger+0x38/0x48)
[17612.985630] [<c01df360>] (write_sysrq_trigger+0x38/0x48) from
[<c0120b04>] (proc_reg_write+0x80/0x94)
[17613.096064] [<c0120b04>] (proc_reg_write+0x80/0x94) from
[<c00e2cac>] (vfs_write+0xb4/0x134)
[17613.197095] [<c00e2cac>] (vfs_write+0xb4/0x134) from [<c00e2f08>]
(sys_write+0x40/0x6c)
[17613.292940] [<c00e2f08>] (sys_write+0x40/0x6c) from [<c000df80>]
(ret_fast_syscall+0x0/0x30)
[17613.393971] Code: e3a02001 e5832000 f57ff04f e3a03000 (e5c32000)
[17613.468479] Loading crashdump kernel...
[17613.512715] image->start 44808000
[17613.552296]  kexec start address 44808000,
[17613.602281]  reboot_code_buffer 0xc3300000,
[17613.653327]  reboot_code_buffer_phys 44800000,
[17613.707498]  kexec_mach_type 4704
[17613.748141] Bye!

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
