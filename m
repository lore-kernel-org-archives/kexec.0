Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-vk0-x241.google.com ([2607:f8b0:400c:c05::241])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dTpIz-0006co-Ve
 for kexec@lists.infradead.org; Sat, 08 Jul 2017 12:57:51 +0000
Received: by mail-vk0-x241.google.com with SMTP id 191so3737934vko.1
 for <kexec@lists.infradead.org>; Sat, 08 Jul 2017 05:57:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170707133925.29711.39301.stgit@tlendack-t1.amdoffice.net>
References: <20170707133804.29711.1616.stgit@tlendack-t1.amdoffice.net>
 <20170707133925.29711.39301.stgit@tlendack-t1.amdoffice.net>
From: Brian Gerst <brgerst@gmail.com>
Date: Sat, 8 Jul 2017 08:57:27 -0400
Message-ID: <CAMzpN2h=AAF6OVfeGJnf5va2Msmd_BPU5BrVENvs0zGQtRMdzQ@mail.gmail.com>
Subject: Re: [PATCH v9 07/38] x86/mm: Remove phys_to_virt() usage in ioremap()
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
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-efi@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>, Toshimitsu Kani <toshi.kani@hpe.com>, linux-doc@vger.kernel.org, Matt Fleming <matt@codeblueprint.co.uk>, the arch/x86 maintainers <x86@kernel.org>, Linux-MM <linux-mm@kvack.org>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Alexander Potapenko <glider@google.com>, "H. Peter Anvin" <hpa@zytor.com>, Larry Woodman <lwoodman@redhat.com>, linux-arch <linux-arch@vger.kernel.org>, kvm@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Joerg Roedel <joro@8bytes.org>, "Michael S. Tsirkin" <mst@redhat.com>, kasan-dev@googlegroups.com, Ingo Molnar <mingo@redhat.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Dave Young <dyoung@redhat.com>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Dmitry Vyukov <dvyukov@google.com>, Juergen Gross <jgross@suse.com>, kexec@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, xen-devel@lists.xen.org, iommu@lists.linux-foundation.org, Thomas Gleixner <tglx@linutronix.de>, Paolo Bonzini <pbonzini@redhat.com>

On Fri, Jul 7, 2017 at 9:39 AM, Tom Lendacky <thomas.lendacky@amd.com> wrote:
> Currently there is a check if the address being mapped is in the ISA
> range (is_ISA_range()), and if it is, then phys_to_virt() is used to
> perform the mapping. When SME is active, the default is to add pagetable
> mappings with the encryption bit set unless specifically overridden. The
> resulting pagetable mapping from phys_to_virt() will result in a mapping
> that has the encryption bit set. With SME, the use of ioremap() is
> intended to generate pagetable mappings that do not have the encryption
> bit set through the use of the PAGE_KERNEL_IO protection value.
>
> Rather than special case the SME scenario, remove the ISA range check and
> usage of phys_to_virt() and have ISA range mappings continue through the
> remaining ioremap() path.
>
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  arch/x86/mm/ioremap.c |    7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
> index 4c1b5fd..bfc3e2d 100644
> --- a/arch/x86/mm/ioremap.c
> +++ b/arch/x86/mm/ioremap.c
> @@ -13,6 +13,7 @@
>  #include <linux/slab.h>
>  #include <linux/vmalloc.h>
>  #include <linux/mmiotrace.h>
> +#include <linux/mem_encrypt.h>
>
>  #include <asm/set_memory.h>
>  #include <asm/e820/api.h>
> @@ -106,12 +107,6 @@ static void __iomem *__ioremap_caller(resource_size_t phys_addr,
>         }
>
>         /*
> -        * Don't remap the low PCI/ISA area, it's always mapped..
> -        */
> -       if (is_ISA_range(phys_addr, last_addr))
> -               return (__force void __iomem *)phys_to_virt(phys_addr);
> -
> -       /*
>          * Don't allow anybody to remap normal RAM that we're using..
>          */
>         pfn      = phys_addr >> PAGE_SHIFT;
>

Removing this also affects 32-bit, which is more likely to access
legacy devices in this range.  Put in a check for SME instead
(provided you follow my recommendations to not set the SME feature bit
on 32-bit even when the processor supports it).

--
Brian Gerst

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
