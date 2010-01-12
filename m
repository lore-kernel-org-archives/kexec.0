Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NUUnG-00029q-Rv
	for kexec@lists.infradead.org; Tue, 12 Jan 2010 00:39:39 +0000
Date: Tue, 12 Jan 2010 11:39:30 +1100
From: Simon Horman <horms@verge.net.au>
Subject: Re: Problems compiling kexec-tools
Message-ID: <20100112003930.GB20676@verge.net.au>
References: <BAY114-W49E2846C6D653AB15A9A03DD6C0@phx.gbl>
MIME-Version: 1.0
Content-Disposition: inline
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
Cc: kexec@lists.infradead.org

On Mon, Jan 11, 2010 at 04:01:59PM -0800, Zitt Zitterkopf wrote:
> 
> All,
> 
> I'm attempting to compile kexec-tools so I can compile kboot from source.
> 
>  
> 
> I've obtained the kexec-tools-2.0.0 source from RPM.
> 
>  
> 
> I've done:
> 
> ./configure
> 
> make
> 
>  
> 
> which I receive the following errors:
> 
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
> 
> I've installed zlib:
> 
> zlib-1.2.3-29.4.moblin2.i586.rpm
> 
> zlib-devel-1.2.3-29.4.moblin2.i586.rpm
> 
> so I'm unsure what I've done wrong.

Just a guess, but do you have a static version of libz installed?
That is, did zlib-devel install a libz.a file?


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
