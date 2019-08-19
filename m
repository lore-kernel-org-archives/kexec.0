Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Mon, 19 Aug 2019 16:50:14 +0100
From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 02/14] arm64, hibernate: create_safe_exec_page cleanup
Message-ID: <20190819155014.GD9927@lakrids.cambridge.arm.com>
References: <20190817024629.26611-1-pasha.tatashin@soleen.com>
 <20190817024629.26611-3-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190817024629.26611-3-pasha.tatashin@soleen.com>
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
To: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: sashal@kernel.org, vladimir.murzin@arm.com, corbet@lwn.net, marc.zyngier@arm.com, catalin.marinas@arm.com, bhsharma@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, jmorris@namei.org, linux-mm@kvack.org, james.morse@arm.com, ebiederm@xmission.com, matthias.bgg@gmail.com, will@kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Aug 16, 2019 at 10:46:17PM -0400, Pavel Tatashin wrote:
> create_safe_exec_page() is going to be split into two parts in preparation
> of moving page table handling code out of hibernate.c
> 
> Remove allocator parameter, and rename dst to page. Also, remove the
> goto's, as we can return directly without cleanups.

It would be nice if you could do the goto/allocator/rename changes as
separate patches, since it's vastly easier to verify each change in
isolation that way.

What's the point of the rename? It's inconsistent with the phys_dst_addr
that you leave as-is, so I'm not sure that's worthwhile.

> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> ---
>  arch/arm64/kernel/hibernate.c | 60 +++++++++++++++--------------------
>  1 file changed, 26 insertions(+), 34 deletions(-)
> 
> diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
> index 9341fcc6e809..96b6f8da7e49 100644
> --- a/arch/arm64/kernel/hibernate.c
> +++ b/arch/arm64/kernel/hibernate.c
> @@ -196,57 +196,51 @@ EXPORT_SYMBOL(arch_hibernation_header_restore);
>   */
>  static int create_safe_exec_page(void *src_start, size_t length,
>  				 unsigned long dst_addr,
> -				 phys_addr_t *phys_dst_addr,
> -				 void *(*allocator)(gfp_t mask),
> -				 gfp_t mask)
> +				 phys_addr_t *phys_dst_addr)
>  {
> -	int rc = 0;
> +	void *page = (void *)get_safe_page(GFP_ATOMIC);
> +	pgd_t *trans_table;

The addition of this trans_table variable wasn't mentioned in the commit
message...

> +	trans_table = (void *)get_safe_page(GFP_ATOMIC);
> +	if (!trans_table)
> +		return -ENOMEM;
>  
> -	pgdp = pgd_offset_raw(allocator(mask), dst_addr);
> +	pgdp = pgd_offset_raw(trans_table, dst_addr);

> -	write_sysreg(phys_to_ttbr(virt_to_phys(pgdp)), ttbr0_el1);
> +	write_sysreg(phys_to_ttbr(virt_to_phys(trans_table)), ttbr0_el1);


... and I guess you're trying to ensure that we program the TTBR with
the correct base address, without the offset of whatever pgd entry we
happen to have plumbed in?

I think that's a fix, and should come before any other cleanup or
rework.

If you can respin that specific change with s/trans_table/pgdir/, that
would make sense to me.

Thanks,
Mark.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
