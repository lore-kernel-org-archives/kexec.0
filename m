Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Fri, 15 Jan 2016 19:55:18 +0000
From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 09/19] Revert "arm64: remove dead code"
Message-ID: <20160115195517.GP3262@leverpostej>
References: <cover.1452884156.git.geoff@infradead.org>
 <81d9f2f035e6ae0e1a121f3eddeaef915d761e2d.1452884156.git.geoff@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <81d9f2f035e6ae0e1a121f3eddeaef915d761e2d.1452884156.git.geoff@infradead.org>
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
To: Geoff Levand <geoff@infradead.org>
Cc: marc.zyngier@arm.com, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, James Morse <james.morse@arm.com>, linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org, christoffer.dall@linaro.org

Hi,

On Fri, Jan 15, 2016 at 07:18:37PM +0000, Geoff Levand wrote:
> This reverts commit b08d4640a3dca68670fc5af2fe9205b395a02388.
> 
> Add back the setup_mm_for_reboot() needed for kexec.

My pagetable rework series [1,2] adds cpu_install_idmap() [3], which
supersedes setup_mm_for_reboot, and differs only in name.

I intend to rebase once v4.5-rc1 comes out. Unless there are substantial
changes or new comments, I expect that to be on a stable branche shortly
thereafter. When that happens, it should be possible to drop this patch.

Thanks,
Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-January/397095.html
[2] https://git.kernel.org/cgit/linux/kernel/git/mark/linux.git/log/?h=arm64/pagetable-rework
[3] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-January/397101.html

> 
> Signed-off-by: Geoff Levand <geoff@infradead.org>
> ---
>  arch/arm64/include/asm/mmu.h |  1 +
>  arch/arm64/mm/mmu.c          | 11 +++++++++++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
> index 990124a..6326d11 100644
> --- a/arch/arm64/include/asm/mmu.h
> +++ b/arch/arm64/include/asm/mmu.h
> @@ -29,6 +29,7 @@ typedef struct {
>  #define ASID(mm)	((mm)->context.id.counter & 0xffff)
>  
>  extern void paging_init(void);
> +extern void setup_mm_for_reboot(void);
>  extern void __iomem *early_io_map(phys_addr_t phys, unsigned long virt);
>  extern void init_mem_pgprot(void);
>  extern void create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 873e363..afcf1ee 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -466,6 +466,17 @@ void __init paging_init(void)
>  }
>  
>  /*
> + * Enable the identity mapping to allow the MMU disabling.
> + */
> +void setup_mm_for_reboot(void)
> +{
> +	cpu_set_reserved_ttbr0();
> +	flush_tlb_all();
> +	cpu_set_idmap_tcr_t0sz();
> +	cpu_switch_mm(idmap_pg_dir, &init_mm);
> +}
> +
> +/*
>   * Check whether a kernel address is valid (derived from arch/x86/).
>   */
>  int kern_addr_valid(unsigned long addr)
> -- 
> 2.5.0
> 
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
