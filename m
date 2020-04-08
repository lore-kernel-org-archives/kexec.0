Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Wed, 8 Apr 2020 17:24:12 +0200
From: Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: Re: Trying to kexec on Allwinner A80
Message-ID: <20200408152412.GA3621@Red>
References: <20200407100203.GK25745@shell.armlinux.org.uk>
 <20200407101912.GL25745@shell.armlinux.org.uk>
 <20200407113454.GA457@Red>
 <20200407122243.GN25745@shell.armlinux.org.uk>
 <20200407130559.GB457@Red>
 <20200407132602.GO25745@shell.armlinux.org.uk>
 <20200407134849.GC457@Red>
 <20200407181740.GP25745@shell.armlinux.org.uk>
 <20200408084029.GA1859@Red>
 <20200408093320.GQ25745@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200408093320.GQ25745@shell.armlinux.org.uk>
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
To: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mripard@kernel.org, wens@csie.org, ebiederm@xmission.com, linux-arm-kernel@lists.infradead.org

On Wed, Apr 08, 2020 at 10:33:20AM +0100, Russell King - ARM Linux admin wrote:
> On Wed, Apr 08, 2020 at 10:40:29AM +0200, Corentin Labbe wrote:
> > This is the last boot:
> > ## Loading init Ramdisk from Legacy Image at 2a000000 ...
> >    Image Name:   
> >    Image Type:   ARM Linux RAMDisk Image (uncompressed)
> >    Data Size:    8031928 Bytes = 7.7 MiB
> >    Load Address: 00000000
> >    Entry Point:  00000000
> >    Verifying Checksum ... OK
> > ## Flattened Device Tree blob at 23000000
> >    Booting using the fdt blob at 0x23000000
> >    Loading Ramdisk to 29857000, end 29fffeb8 ... OK
> >    Loading Device Tree to 2984e000, end 29856fd1 ... OK
> > Starting kernel ...
> > ID:0x00000000 DT:0x2984E000
> > Uncompressing Linux... done, booting the kernel.
> > [...]
> > fake uboot stuff
> > [...]
> > DEBUG: bootz: run kexec with --debug --kexec-syscall --force --initrd /tmp/ramdisk --dtb /tmp/dtb --command-line='console=ttyS0,115200n8 root=/dev/ram0 earlycon=uart,mmio32,0x7000000 earlyprintk ip=dhcp'
> > Set DEBUG!
> > main:1417 OPT_KEXEC_SYSCALL
> > main:1422 OPT_KEXEC_SYSCALL_AUTO
> > arch_process_options:119
> > main:1500
> > main:1517 res=0 do_load=1
> > main:1519 res=0 do_kexec_file_syscall=0
> > my_load:713
> > Try gzip decompression.
> > kernel: 0xb6931008 kernel_size: 0x444fc8
> > get_memory_ranges:36
> > MEMORY RANGES
> > 0000000020000000-000000009fffffff (0)
> > zImage_arm_load:423
> > zImage header: 0x016f2818 0x00000000 0x00444fc8
> > zImage size 0x444fc8, file size 0x444fc8
> > zImage requires 0x00455fc8 bytes
> >   offset 0x00006738 tag 0x5a534c4b size 8
> > Decompressed kernel sizes:
> >  text+data 0x00b77958 bss 0x0003d428 total 0x00bb4d80
> > Resulting kernel space: 0x00fcd920
> > Kernel: address=0x20008000 size=0x00fcd920
> > Initrd: address=0x20fd6000 size=0x016a6b97
> > DT    : address=0x2267d000 size=0x00006043
> > kexec_load: entry = 0x20008000 flags = 0x280000
> > nr_segments = 3
> > segment[0].buf   = 0xb6931008
> > segment[0].bufsz = 0x444fcc
> > segment[0].mem   = 0x20008000
> > segment[0].memsz = 0x445000
> > segment[1].buf   = 0xb528a008
> > segment[1].bufsz = 0x16a6b97
> > segment[1].mem   = 0x20fd6000
> > segment[1].memsz = 0x16a7000
> > segment[2].buf   = 0x4ef88
> > segment[2].bufsz = 0x6043
> > segment[2].mem   = 0x2267d000
> > segment[2].memsz = 0x7000
> > main:1568 res=0[   32.098439] sun7i-dwmac 830000.ethernet eth0: Link is Down
> > main:1582 res=0 do_exec=1
> > [   32.113191] kexec_core: Starting new kernel
> > [   32.460412] Bye!
> > ID:0xFFFFFFFF DT:0x2267D000
> > C:0x200080C0-0x2044CFE0->0x20B80500-0x20FC5420
> > ID:0xFFFFFFFF DT:0x2267D000
> > Uncompressing Linux... done, booting the kernel.
> 
> Okay, that looks fine:
> - the DT is out of the way, so shouldn't be corrupted by the
>   decompression process.
> - the decompressor writes the kernel image to 0x20008000 to 0x20b7f958
>   which is clear of the decompressor itself (which relocated itself
>   to 0x20b80500).
> - the ID doesn't matter for DT booting purposes.
> 
> I see you've gone back to using your own dtb rather than one derived
> from the booting kernel. I strongly recommend against giving your own
> dtb to kexec as if the boot loader modifies the DTB when calling the
> first kernel (such as adding memory region information, adding MAC
> addresses, enabling or disabling various devices) those modifications
> will be lost if you supply your own DTB to kexec.
> 
> Please drop "--dtb /tmp/dtb".
> 

Thanks it works now.

With a working setup I diffed dtb and the one given by uboot and it seems the missing node for booting was /memory.
So now I am able to boot the same kernel as the "fake uboot".

For booting a different kernel, I fdtput the dtb (for memory and bootargs), and it works until it try to mount the roofs which it find corrupt.
Since the rootfs I get by the fakeuboot is a "uboot legacy image" (rootfs.cpio.gz modified by mkimage), I drop the first 64bytes but it seems not sufficiant. (even if file say it is a good rootfs.cpio.gz)
Or perhaps the kernel get an invalid initrd address.

Anyway the main issue is fixed.
Thanks for your help

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
