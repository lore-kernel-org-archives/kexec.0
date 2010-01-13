Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from va3ehsobe005.messaging.microsoft.com ([216.32.180.15]
	helo=VA3EHSOBE005.bigfish.com)
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1NV70r-0002Bl-Ov
	for kexec@lists.infradead.org; Wed, 13 Jan 2010 17:28:13 +0000
Message-ID: <4B4E029E.4020404@am.sony.com>
Date: Wed, 13 Jan 2010 09:27:58 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
Subject: Re: Problems compiling kexec-tools
References: <BAY114-W49E2846C6D653AB15A9A03DD6C0@phx.gbl>
In-Reply-To: <BAY114-W49E2846C6D653AB15A9A03DD6C0@phx.gbl>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Zitt Zitterkopf <zittware@hotmail.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On 01/11/2010 04:01 PM, Zitt Zitterkopf wrote:
> All,
> I'm attempting to compile kexec-tools so I can compile kboot from source.
> 
> I've obtained the kexec-tools-2.0.0 source from RPM.

Maybe you could try just using the 2.0.1 sources from here:

  http://www.kernel.org/pub/linux/kernel/people/horms/kexec-tools/

> I've done:
> ./configure
> make
> 
> which I receive the following errors:
> gcc -lz   -g -O2 -static -fno-strict-aliasing -Wall -Wstrict-prototypes -o build/sbin/kexec kexec/kexec.o kexec/ifdown.o kexec/kexec-elf.o kexec/kexec-elf-exec.o kexec/kexec-elf-core.o kexec/kexec-elf-rel.o kexec/kexec-elf-boot.o kexec/kexec-iomem.o kexec/firmware_memmap.o kexec/crashdump.o kexec/crashdump-xen.o kexec/phys_arch.o kexec/proc_iomem.o kexec/virt_to_phys.o kexec/add_segment.o kexec/add_buffer.o kexec/arch_reuse_initrd.o kexec/arch/i386/kexec-x86.o kexec/arch/i386/kexec-x86-common.o kexec/arch/i386/kexec-elf-x86.o kexec/arch/i386/kexec-elf-rel-x86.o kexec/arch/i386/kexec-bzImage.o kexec/arch/i386/kexec-multiboot-x86.o kexec/arch/i386/kexec-beoboot-x86.o kexec/arch/i386/kexec-nbi.o kexec/arch/i386/x86-linux-setup.o kexec/arch/i386/crashdump-x86.o kexec/purgatory.o libutil.a
> kexec/kexec.o: In function `slurp_decompress_file':
> /home/moblin/rpmbuild/BUILD/kexec-tools-2.0.0/kexec/kexec.c:485: undefined reference to `gzopen'
> /home/moblin/rpmbuild/BUILD/kexec-tools-2.0.0/kexec/kexec.c:501: undefined reference to `gzread'
> /home/moblin/rpmbuild/BUILD/kexec-tools-2.0.0/kexec/kexec.c:506: undefined reference to `gzerror'
> /home/moblin/rpmbuild/BUILD/kexec-tools-2.0.0/kexec/kexec.c:515: undefined reference to `gzclose'
> /home/moblin/rpmbuild/BUILD/kexec-tools-2.0.0/kexec/kexec.c:517: undefined reference to `gzerror'
> /home/moblin/rpmbuild/BUILD/kexec-tools-2.0.0/kexec/kexec.c:487: undefined reference to `gzerror'
> collect2: ld returned 1 exit status
> make: *** [build/sbin/kexec] Error 1
> 
> I've installed zlib:
> zlib-1.2.3-29.4.moblin2.i586.rpm
> zlib-devel-1.2.3-29.4.moblin2.i586.rpm
> so I'm unsure what I've done wrong.

You could try passing the verbose flags and see what
headers and libs get used during the build.  Maybe
you'll find some problem there.  I think those would
be something like:

  gcc -v -Wl,--verbose ...

Or maybe just use:

  ld --verbose ...

BTW, have you looked at the petitboot bootloader? For
the most part it is a better choice than kboot.
It provides essentially all the functionality that
kboot does, plus more, it is easier to build, and it
is a currently maintained project.

The petitboot package can be built for x86.  That is
how much of its development is done, but OpenWRT does
not yet support an x86 build of petitboot (that
would create a grub second stage image).  My plan is
to add x86 PC support next.  I don't think it is very
difficult to do, I just have not had time to do it.

You can see some screen shots of petitboot built for
the PS3 here:

  http://www.kernel.org/pub/linux/kernel/people/geoff/cell/ps3-petitboot/

My petitboot development repo is here:

  http://git.kernel.org/?p=linux/kernel/git/geoff/petitboot-dev.git

-Geoff


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
