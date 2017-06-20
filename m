Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457])
 by bombadil.infradead.org with esmtp (Exim 4.87 #1 (Red Hat Linux))
 id 1dNL7x-0006Um-Fg
 for kexec@lists.infradead.org; Tue, 20 Jun 2017 15:31:40 +0000
Date: Tue, 20 Jun 2017 17:30:56 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v7 14/36] x86/mm: Insure that boot memory areas are
 mapped properly
Message-ID: <20170620153056.bz2kvgvshnat6345@pd.tnic>
References: <20170616184947.18967.84890.stgit@tlendack-t1.amdoffice.net>
 <20170616185232.18967.61753.stgit@tlendack-t1.amdoffice.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20170616185232.18967.61753.stgit@tlendack-t1.amdoffice.net>
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
Cc: linux-efi@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>, Toshimitsu Kani <toshi.kani@hpe.com>, linux-doc@vger.kernel.org, Matt Fleming <matt@codeblueprint.co.uk>, x86@kernel.org, linux-mm@kvack.org, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Alexander Potapenko <glider@google.com>, "H. Peter Anvin" <hpa@zytor.com>, Larry Woodman <lwoodman@redhat.com>, linux-arch@vger.kernel.org, kvm@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Joerg Roedel <joro@8bytes.org>, "Michael S. Tsirkin" <mst@redhat.com>, kasan-dev@googlegroups.com, Ingo Molnar <mingo@redhat.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Dave Young <dyoung@redhat.com>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andy Lutomirski <luto@kernel.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Dmitry Vyukov <dvyukov@google.com>, Juergen Gross <jgross@suse.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, xen-devel@lists.xen.org, iommu@lists.linux-foundation.org, Thomas Gleixner <tglx@linutronix.de>, Paolo Bonzini <pbonzini@redhat.com>

On Fri, Jun 16, 2017 at 01:52:32PM -0500, Tom Lendacky wrote:
> The boot data and command line data are present in memory in a decrypted
> state and are copied early in the boot process.  The early page fault
> support will map these areas as encrypted, so before attempting to copy
> them, add decrypted mappings so the data is accessed properly when copied.
> 
> For the initrd, encrypt this data in place. Since the future mapping of
> the initrd area will be mapped as encrypted the data will be accessed
> properly.
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  arch/x86/include/asm/mem_encrypt.h |    6 +++
>  arch/x86/include/asm/pgtable.h     |    3 ++
>  arch/x86/kernel/head64.c           |   30 +++++++++++++--
>  arch/x86/kernel/setup.c            |    9 +++++
>  arch/x86/mm/kasan_init_64.c        |    2 +
>  arch/x86/mm/mem_encrypt.c          |   70 ++++++++++++++++++++++++++++++++++++
>  6 files changed, 115 insertions(+), 5 deletions(-)

...

> diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
> index b7671b9..ea5e3a6 100644
> --- a/arch/x86/mm/mem_encrypt.c
> +++ b/arch/x86/mm/mem_encrypt.c
> @@ -19,6 +19,8 @@
>  
>  #include <asm/tlbflush.h>
>  #include <asm/fixmap.h>
> +#include <asm/setup.h>
> +#include <asm/bootparam.h>
>  
>  /*
>   * Since SME related variables are set early in the boot process they must
> @@ -101,6 +103,74 @@ void __init sme_early_decrypt(resource_size_t paddr, unsigned long size)
>  	__sme_early_enc_dec(paddr, size, false);
>  }
>  
> +static void __init __sme_early_map_unmap_mem(void *vaddr, unsigned long size,
> +					     bool map)
> +{
> +	unsigned long paddr = (unsigned long)vaddr - __PAGE_OFFSET;
> +	pmdval_t pmd_flags, pmd;
> +
> +	/* Use early_pmd_flags but remove the encryption mask */
> +	pmd_flags = __sme_clr(early_pmd_flags);
> +
> +	do {
> +		pmd = map ? (paddr & PMD_MASK) + pmd_flags : 0;
> +		__early_make_pgtable((unsigned long)vaddr, pmd);
> +
> +		vaddr += PMD_SIZE;
> +		paddr += PMD_SIZE;
> +		size = (size <= PMD_SIZE) ? 0 : size - PMD_SIZE;
> +	} while (size);
> +
> +	write_cr3(__read_cr3());

local_flush_tlb() or __native_flush_tlb(). Probably the native variant
since this is early fun.

> +}
> +
> +static void __init __sme_map_unmap_bootdata(char *real_mode_data, bool map)
> +{
> +	struct boot_params *boot_data;
> +	unsigned long cmdline_paddr;
> +
> +	/* If SME is not active, the bootdata is in the correct state */
> +	if (!sme_active())
> +		return;
> +
> +	if (!map) {
> +		/*
> +		 * If unmapping, get the command line address before
> +		 * unmapping the real_mode_data.
> +		 */
> +		boot_data = (struct boot_params *)real_mode_data;
> +		cmdline_paddr = boot_data->hdr.cmd_line_ptr |
> +				((u64)boot_data->ext_cmd_line_ptr << 32);

Let it stick out:

	cmdline_paddr = bd->hdr.cmd_line_ptr | ((u64)bd->ext_cmd_line_ptr << 32);

> +	}
> +
> +	__sme_early_map_unmap_mem(real_mode_data, sizeof(boot_params), map);
> +
> +	if (map) {
> +		/*
> +		 * If mapping, get the command line address after mapping
> +		 * the real_mode_data.
> +		 */
> +		boot_data = (struct boot_params *)real_mode_data;
> +		cmdline_paddr = boot_data->hdr.cmd_line_ptr |
> +				((u64)boot_data->ext_cmd_line_ptr << 32);
> +	}
> +
> +	if (!cmdline_paddr)
> +		return;
> +
> +	__sme_early_map_unmap_mem(__va(cmdline_paddr), COMMAND_LINE_SIZE, map);

Ok, so from looking at this function now - it does different things
depending on whether we map or not. So it doesn't look like a worker
function anymore and you can move the stuff back to the original callers
below. Should make the whole flow more readable.

> +}
> +
> +void __init sme_unmap_bootdata(char *real_mode_data)
> +{
> +	__sme_map_unmap_bootdata(real_mode_data, false);
> +}
> +
> +void __init sme_map_bootdata(char *real_mode_data)
> +{
> +	__sme_map_unmap_bootdata(real_mode_data, true);
> +}
> +
>  void __init sme_early_init(void)
>  {
>  	unsigned int i;
> 

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
