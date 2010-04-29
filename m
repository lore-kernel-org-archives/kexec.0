Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]
	helo=mx02.colomx.prod.int.phx2.redhat.com)
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1O7Xxd-000157-Ff
	for kexec@lists.infradead.org; Thu, 29 Apr 2010 17:55:42 +0000
Date: Thu, 29 Apr 2010 13:55:39 -0400 (EDT)
From: Dave Anderson <anderson@redhat.com>
Message-ID: <629410099.21721272563739293.JavaMail.root@zmail05.collab.prod.int.phx2.redhat.com>
In-Reply-To: <610318244.20851272563381903.JavaMail.root@zmail05.collab.prod.int.phx2.redhat.com>
Subject: Re: [PATCH 1/2] kexec: add phys_offset field
MIME-Version: 1.0
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
To: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
Cc: kexec@lists.infradead.org


----- "Mika Westerberg" <ext-mika.1.westerberg@nokia.com> wrote:

> So how about following? This allows ARM (and maybe some future archs as well) to
> redefine phys_to_virt() but default implementation should work with
> others.
> 
> Thanks,
> MW

Looks like a reasonable approach to me.  

BTW, your phys_to_virt() function comments read: "virt_to_phys".

Thanks,
  Dave

> 
> >From dcfda0e78ae9bfe3c9ff5d186c660e5ce1892fbb Mon Sep 17 00:00:00 2001
> From: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
> Date: Thu, 29 Apr 2010 11:07:14 +0300
> Subject: [PATCH] kexec: introduce phys_to_virt() function
> 
> This function is used by ELF crashdump code which prepares crash memory headers
> for the dump capture kernel. Most architecture can use default version which
> just adds PAGE_OFFSET to the virtual address but some architectures might need
> some special handling.
> 
> Signed-off-by: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
> ---
>  kexec/Makefile        |    2 ++
>  kexec/crashdump-elf.c |    2 +-
>  kexec/crashdump.h     |    3 +++
>  kexec/phys_to_virt.c  |   16 ++++++++++++++++
>  4 files changed, 22 insertions(+), 1 deletions(-)
>  create mode 100644 kexec/phys_to_virt.c
> 
> diff --git a/kexec/Makefile b/kexec/Makefile
> index 4e091ba..77f37ae 100644
> --- a/kexec/Makefile
> +++ b/kexec/Makefile
> @@ -39,6 +39,8 @@ $(ARCH)_PROC_IOMEM		= kexec/proc_iomem.c
>  KEXEC_SRCS += $($(ARCH)_PROC_IOMEM)
>  $(ARCH)_VIRT_TO_PHYS		= kexec/virt_to_phys.c
>  KEXEC_SRCS += $($(ARCH)_VIRT_TO_PHYS)
> +$(ARCH)_PHYS_TO_VIRT		= kexec/phys_to_virt.c
> +KEXEC_SRCS += $($(ARCH)_PHYS_TO_VIRT)
>  $(ARCH)_ADD_SEGMENT		= kexec/add_segment.c
>  KEXEC_SRCS += $($(ARCH)_ADD_SEGMENT)
>  $(ARCH)_ADD_BUFFER		= kexec/add_buffer.c
> diff --git a/kexec/crashdump-elf.c b/kexec/crashdump-elf.c
> index 6bcef8d..f000e42 100644
> --- a/kexec/crashdump-elf.c
> +++ b/kexec/crashdump-elf.c
> @@ -236,7 +236,7 @@ int FUNC(struct kexec_info *info,
>  		 * memory region.
>  		 */
>  		phdr->p_paddr = mstart;
> -		phdr->p_vaddr = mstart + elf_info->page_offset;
> +		phdr->p_vaddr = phys_to_virt(elf_info, mstart);
>  		phdr->p_filesz	= phdr->p_memsz	= mend - mstart + 1;
>  		/* Do we need any alignment of segments? */
>  		phdr->p_align	= 0;
> diff --git a/kexec/crashdump.h b/kexec/crashdump.h
> index 30d6f29..b6e60cc 100644
> --- a/kexec/crashdump.h
> +++ b/kexec/crashdump.h
> @@ -46,6 +46,9 @@ int crash_create_elf64_headers(struct kexec_info
> *info,
>  
>  unsigned long crash_architecture(struct crash_elf_info *elf_info);
>  
> +unsigned long phys_to_virt(struct crash_elf_info *elf_info,
> +			   unsigned long paddr);
> +
>  int xen_present(void);
>  unsigned long xen_architecture(struct crash_elf_info *elf_info);
>  int xen_get_nr_phys_cpus(void);
> diff --git a/kexec/phys_to_virt.c b/kexec/phys_to_virt.c
> new file mode 100644
> index 0000000..2370e56
> --- /dev/null
> +++ b/kexec/phys_to_virt.c
> @@ -0,0 +1,16 @@
> +#include "kexec.h"
> +#include "crashdump.h"
> +
> +/**
> + * virt_to_phys() - translate physical address to virtual address
> + * @paddr: physical address to translate
> + *
> + * For most architectures physical address is simply virtual address minus
> + * PAGE_OFFSET. Architectures that don't follow this convention should provide
> + * their own implementation.
> + */
> +unsigned long
> +phys_to_virt(struct crash_elf_info *elf_info, unsigned long paddr)
> +{
> +	return paddr + elf_info->page_offset;
> +}
> -- 
> 1.5.6.5

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
