From: Sean Christopherson <seanjc@google.com>
Date: Mon, 7 Feb 2022 22:03:52 +0000
Subject: [PATCH v3 04/10] x86/sev: Cache AP Jump Table Address
In-Reply-To: <20220127101044.13803-5-joro@8bytes.org>
References: <20220127101044.13803-1-joro@8bytes.org>
 <20220127101044.13803-5-joro@8bytes.org>
Message-ID: <YgGXSKAsi4aLxFMg@google.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Thu, Jan 27, 2022, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Store the physical address of the AP jump table in kernel memory so
> that it does not need to be fetched from the Hypervisor again.

This doesn't explain why the kernel would retrieve the jump table more than once,
e.g. at this point in the series, this can only ever be called once.

> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  arch/x86/kernel/sev.c | 28 +++++++++++++++-------------
>  1 file changed, 15 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> index 8a4317fa699a..969ef9855bb5 100644
> --- a/arch/x86/kernel/sev.c
> +++ b/arch/x86/kernel/sev.c
> @@ -43,6 +43,9 @@ static struct ghcb boot_ghcb_page __bss_decrypted __aligned(PAGE_SIZE);
>   */
>  static struct ghcb __initdata *boot_ghcb;
>  
> +/* Cached AP jump table Address */
> +static phys_addr_t jump_table_pa;
> +
>  /* #VC handler runtime per-CPU data */
>  struct sev_es_runtime_data {
>  	struct ghcb ghcb_page;
> @@ -523,12 +526,14 @@ void noinstr __sev_es_nmi_complete(void)
>  	__sev_put_ghcb(&state);
>  }
>  
> -static u64 get_jump_table_addr(void)
> +static phys_addr_t get_jump_table_addr(void)

Not new, but I believe this can be tagged __init.

>  {
>  	struct ghcb_state state;
>  	unsigned long flags;
>  	struct ghcb *ghcb;
> -	u64 ret = 0;
> +
> +	if (jump_table_pa)
> +		return jump_table_pa;
>  
>  	local_irq_save(flags);
>  
> @@ -544,39 +549,36 @@ static u64 get_jump_table_addr(void)
>  
>  	if (ghcb_sw_exit_info_1_is_valid(ghcb) &&
>  	    ghcb_sw_exit_info_2_is_valid(ghcb))
> -		ret = ghcb->save.sw_exit_info_2;
> +		jump_table_pa = (phys_addr_t)ghcb->save.sw_exit_info_2;
>  
>  	__sev_put_ghcb(&state);
>  
>  	local_irq_restore(flags);
>  
> -	return ret;
> +	return jump_table_pa;
>  }
>  
>  int sev_es_setup_ap_jump_table(struct real_mode_header *rmh)

__init here too.

>  {
>  	u16 startup_cs, startup_ip;
> -	phys_addr_t jump_table_pa;
> -	u64 jump_table_addr;
>  	u16 __iomem *jump_table;
> +	phys_addr_t pa;
>  
> -	jump_table_addr = get_jump_table_addr();
> +	pa = get_jump_table_addr();
>  
>  	/* On UP guests there is no jump table so this is not a failure */

Does anything actually check that the jump table is valid for SMP guests?

> -	if (!jump_table_addr)
> +	if (!pa)

Using '0' for "not valid" is funky because '0' isn't technically an illegal GPA,
and because it means the address (or lack thereof) isn't cached on a single-vCPU
guest.

