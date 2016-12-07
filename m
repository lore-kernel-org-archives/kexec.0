Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.85_2 #1 (Red Hat Linux))
 id 1cEZwl-0005Kh-Uk
 for kexec@lists.infradead.org; Wed, 07 Dec 2016 10:59:37 +0000
Date: Wed, 7 Dec 2016 11:59:11 +0100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [ANNOUNCE] kexec-tools v2.0.14 preparation
Message-ID: <20161207105911.GD29752@verge.net.au>
References: <20161202082424.GD32351@verge.net.au>
 <20161207094717.GA8047@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20161207094717.GA8047@dhcp-128-65.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: kexec@lists.infradead.org

On Wed, Dec 07, 2016 at 05:47:17PM +0800, Dave Young wrote:
> On 12/02/16 at 09:24am, Simon Horman wrote:
> > Hi all,
> > 
> > I am planning to release kexec-tools v2.0.14 around the time that
> > the v4.9 kernel is released.
> > 
> > I would like to ask interested parties to send any patches they would like
> > included in v2.0.14 within one week so that I can make an rc release.
> 
> Hi, Simon
> 
> I saw a kexec -p load error, below patch fixes it, I have no time
> today, will check the details, do more test and send it out tomorrow.

Hi Dave,

lets hold the rc lease for a day or so to give you a little
time to get to the bottom of this.

> Thanks
> Dave
> 
> ---
>  kexec/arch/i386/crashdump-x86.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- kexec-tools.orig/kexec/arch/i386/crashdump-x86.c
> +++ kexec-tools/kexec/arch/i386/crashdump-x86.c
> @@ -205,7 +205,7 @@ static int get_kernel_vaddr_and_size(str
>  			unsigned long long size;
>  
>  			/* Look for kernel text mapping header. */
> -			if (saddr < stext_sym && eaddr > stext_sym) {
> +			if (saddr <= stext_sym && eaddr > stext_sym) {
>  				saddr = _ALIGN_DOWN(saddr, X86_64_KERN_VADDR_ALIGN);
>  				elf_info->kern_vaddr_start = saddr;
>  				size = eaddr - saddr;
> 
> > 
> > For reference the patches queued up since v2.0.13 are as follows:
> > 
> > 0a7fba8b1453 purgatory: Change default sha256 optimization to -O2
> > ec271d6c2988 arm64: Add support of R_AARCH64_PREL32 relocation in purgatory
> > c743758d77b8 arm64: Add support for additional relocations in the kexec purgatory code
> > e345e27417db arm64: Add missing kexec dist files
> > 402cf1427293 arm64: Cleanup kexec Makefile
> > 16fd64af363b kexec/fs2dt: Check for NULL pointer in dt_copy_old_root_param()
> > 6e8804f9ca67 multiboot: Use the "reserved" type for non-ram zones
> > 53634c3e9a0c multiboot: Fix length computation for the memory zones
> > 97b6f5f78d95 kexec elf: Sanity check on the note header before accessing it
> > 1574ff1aae4f arm: include phys_to_virt.h and iomem.h in distribution
> > 29086f45a45f kexec: socket not released when error situation occur.
> > 9fd57cad8a0f kexec: fix mem_regions_sort()
> > 9f62cbddddfc kexec/arch/i386: Add support for KASLR memory randomization
> > abdfe97736f8 arm64: Add support for binary image files
> > 522df5f7217f arm64: Add arm64 kexec support
> > 217bcc00c930 kexec: Add common device tree routines
> > f7a0ff52e04d kexec-tools 2.0.13.git
> > 
> > _______________________________________________
> > kexec mailing list
> > kexec@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/kexec
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
