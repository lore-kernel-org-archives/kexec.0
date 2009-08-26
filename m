Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1MgC2W-0007VM-Qo
	for kexec@lists.infradead.org; Wed, 26 Aug 2009 06:31:29 +0000
Date: Wed, 26 Aug 2009 16:31:20 +1000
From: Simon Horman <horms@verge.net.au>
Subject: Re: kexec-tools-2.0.1 and CFLAGS
Message-ID: <20090826063117.GB18761@verge.net.au>
References: <aec7e5c30908200614j68c1ad6ci7a3d8d1b9f98d08b@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aec7e5c30908200614j68c1ad6ci7a3d8d1b9f98d08b@mail.gmail.com>
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
To: Magnus Damm <magnus.damm@gmail.com>
Cc: kexec@lists.infradead.org

On Thu, Aug 20, 2009 at 10:14:19PM +0900, Magnus Damm wrote:
> Hi Simon, Everyone,
> 
> Kexec-tools 2.0.1 seems to build only with optimization enabled. If I
> set CFLAGS before calling configure and remove the "-O2" then the code
> won't link properly. I found it while cross compiling for SuperH, but
> it's most likely an issue on other platforms as well. Have a look at
> the "-O0" below:
> 
>  $ AR=_ar CC=_gcc CFLAGS="-O0" LDFLAGS="-static" ./configure
> --prefix=/ --host="sh3-linux" --without-zlib --without-xen
> ....
> $ make
> ...
> _gcc -static  -o build/sbin/kexec kexec/kexec.o kexec/ifdown.o
> kexec/kexec-elf.o kexec/kexec-elf-exec.o kexec/kexec-elf-core.o
> kexec/kexec-elf-rel.o kexec/kexec-elf-boot.o kexec/kexec-iomem.o
> kexec/firmware_memmap.o kexec/crashdump.o kexec/crashdump-xen.o
> kexec/phys_arch.o kexec/proc_iomem.o kexec/arch_reuse_initrd.o
> kexec/arch/sh/kexec-sh.o kexec/arch/sh/kexec-zImage-sh.o
> kexec/arch/sh/kexec-netbsd-sh.o kexec/arch/sh/kexec-elf-sh.o
> kexec/arch/sh/kexec-elf-rel-sh.o kexec/arch/sh/netbsd_booter.o
> kexec/arch/sh/crashdump-sh.o kexec/purgatory.o libutil.a
> kexec/arch/sh/kexec-elf-rel-sh.o: In function `machine_apply_elf_rel':
> kexec-elf-rel-sh.c:(.text+0x1b0): undefined reference to
> `bad_unaligned_access_length'
> kexec-elf-rel-sh.c:(.text+0x288): undefined reference to
> `bad_unaligned_access_length'
> collect2: ld returned 1 exit status
> make: *** [build/sbin/kexec] Error 1
> 
> This issue is most likely related to get_unaligned() and
> put_unaligned() having bad_unaligned_access_length() in their default
> case that never gets optimized away.
> 
> Anyway, not very important. But at least you know now. =)

Hi Magnus,

I'm some what dubious about this, but it appears to be intentional that
get_unaligned() doesn't exist:

---- From kexec/kexec.h ----

/*
 * This function doesn't actually exist.  The idea is that when someone
 * uses the macros below with an unsupported size (datatype), the linker
 * will alert us to the problem via an unresolved reference error.
 */
extern unsigned long bad_unaligned_access_length (void);

#define get_unaligned(loc) \
({ \
	__typeof__(*(loc)) _v; \
	size_t size = sizeof(*(loc)); \
	switch(size) {  \
	case 1: case 2: case 4: case 8: \
		memcpy(&_v, (loc), size); \
		break; \
	default: \
		_v = bad_unaligned_access_length(); \
		break; \
	} \
	_v; \
})

#define put_unaligned(value, loc) \
do { \
	size_t size = sizeof(*(loc)); \
	__typeof__(*(loc)) _v = value; \
	switch(size) { \
	case 1: case 2: case 4: case 8: \
		memcpy((loc), &_v, size); \
		break; \
	default: \
		bad_unaligned_access_length(); \
		break; \
	} \
} while(0)

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
