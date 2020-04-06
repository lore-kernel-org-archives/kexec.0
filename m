Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Mon, 6 Apr 2020 10:27:20 +0200
From: Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: Trying to kexec on Allwinner A80
Message-ID: <20200406082720.GA31279@Red>
MIME-Version: 1.0
Content-Disposition: inline
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
To: ebiederm@xmission.com, kexec@lists.infradead.org
Cc: wens@csie.org, linux-arm-kernel@lists.infradead.org, mripard@kernel.org, linux-kernel@vger.kernel.org

Hello

I am trying to add the last missing Allwinner Soc in kernelci: the A80.
But this SoC does not have any way to be used in kernelci, no USB nor network in uboot.
So I have tried to fake uboot since the kernel has network support and run the new kernel via kexec.

But kexec 2.0.18 fail to work:
kexec --force /tmp/kernel --initrd /tmp/ramdisk --dtb /tmp/dtb --command-line='console=ttyS0,115200n8 root=/dev/ram0 earlycon=uart,mmio32,0x7000000 ip=dhcp'
syscall kexec_file_load not available.
Try gzip decompression.
kernel: 0xb6535008 kernel_size: 0x853200
MEMORY RANGES
0000000020000000-000000009fffffff (0)
zImage header: 0x016f2818 0x00000000 0x00853200
zImage size 0x853200, file size 0x853200
zImage requires 0x00864200 bytes
  offset 0x0000bae4 tag 0x5a534c4b size 8
Decompressed kernel sizes:
 text+data 0x0158b3a0 bss 0x000632f0 total 0x015ee690
Resulting kernel space: 0x01def5a0
Kernel: address=0x20008000 size=0x01def5a0
Initrd: address=0x21df8000 size=0x0090b6fa
DT    : address=0x22704000 size=0x00005c09
kexec_load: entry = 0x20008000 flags = 0x280000
nr_segments = 3
segment[0].buf   = 0xb6535008
segment[0].bufsz = 0x853204
segment[0].mem   = 0x20008000
segment[0].memsz = 0x854000
segment[1].buf   = 0xb5c29008
segment[1].bufsz = 0x90b6fa
segment[1].mem   = 0x21df8000
segment[1].memsz = 0x90c000
segment[2].buf   = 0x4db50
segment[2].bufsz = 0x5c09
segm[   71.039126] kexec_core: Starting new kernel
ent[2].mem   = 0[   71.044712] Disabling non-boot CPUs ...
x22704000
segment[2].memsz = 0x6000
[   71.489070] Bye!


I have tried also kexec-2.0.20
Try gzip decompression.
zImage header: 0x00000000 0x000019b4 0x00001000
zImage requires 0x008641c0 bytes
Could not find a free area of memory of 0x86c1c0 bytes...
Cannot load /tmp/kernel

What can I do for made it working ? I probably need to give it some memory address, but I am a bit loss.

Thanks
Regards

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
