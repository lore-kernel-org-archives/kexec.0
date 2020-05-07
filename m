Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH v9 16/18] arm64: kexec: configure trans_pgd page table for
 kexec
References: <20200326032420.27220-1-pasha.tatashin@soleen.com>
 <20200326032420.27220-17-pasha.tatashin@soleen.com>
From: James Morse <james.morse@arm.com>
Message-ID: <5ed92d16-123c-8b79-0fc1-4cefdee65d5d@arm.com>
Date: Thu, 7 May 2020 17:22:36 +0100
MIME-Version: 1.0
In-Reply-To: <20200326032420.27220-17-pasha.tatashin@soleen.com>
Content-Language: en-GB
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
Cc: sashal@kernel.org, mark.rutland@arm.com, vladimir.murzin@arm.com, corbet@lwn.net, catalin.marinas@arm.com, bhsharma@redhat.com, steve.capper@arm.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, jmorris@namei.org, linux-mm@kvack.org, rfontana@redhat.com, ebiederm@xmission.com, maz@kernel.org, matthias.bgg@gmail.com, tglx@linutronix.de, will@kernel.org, selindag@gmail.com, linux-arm-kernel@lists.infradead.org

Hi Pavel,

On 26/03/2020 03:24, Pavel Tatashin wrote:
> Configure a page table located in kexec-safe memory that has
> the following mappings:
> 
> 1. identity mapping for text of relocation function with executable
>    permission.
> 2. linear mappings for all source ranges
> 3. linear mappings for all destination ranges.

Its taken this long to work out your definition of linear here doesn't match the way the
rest of the arch code uses the term.

You are using the MMU to re-assemble the scattered kexec image in VA space, so that the
relocation code doesn't have to walk the list.

While its a cool trick, I don't think this is a good idea, it makes it much harder to
debug as we have a new definition for VA->PA, instead of re-using the kernels. We should
do the least surprising thing. The person debugging a problem's first assumptions should
be correct. Doing this means any debug information printed before kexec() is suddenly
useless for debugging a problem that occurs during relocation.

...

Let me hack together what I've been describing and we can discuss whether its simpler.
(most of next week is gone already though...)

(some Nits below)

> diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
> index 0f758fd51518..8f4332ac607a 100644
> --- a/arch/arm64/include/asm/kexec.h
> +++ b/arch/arm64/include/asm/kexec.h
> @@ -108,6 +108,12 @@ extern const unsigned long kexec_el2_vectors_offset;
>   * el2_vector	If present means that relocation routine will go to EL1
>   *		from EL2 to do the copy, and then back to EL2 to do the jump
>   *		to new world.
> + * trans_ttbr0	idmap for relocation function and its argument
> + * trans_ttbr1	linear map for source/destination addresses.
> + * trans_t0sz	t0sz for idmap page in trans_ttbr0

You should be able to load the TTBR0_EL1 (and corresponding TCR_EL1.T0SZ) before kicking
off the relocation code. There should be no need to pass it in to assembly.

For example, hibernate sets TTBR0_EL1 in create_safe_exec_page().


> + * src_addr	linear map for source pages.
> + * dst_addr	linear map for destination pages.
> + * copy_len	Number of bytes that need to be copied
>   */
>  struct kern_reloc_arg {
>  	phys_addr_t head;

> @@ -70,10 +71,90 @@ static void *kexec_page_alloc(void *arg)
>  	return page_address(page);
>  }
>  
> +/*
> + * Map source segments starting from src_va, and map destination
> + * segments starting from dst_va, and return size of copy in
> + * *copy_len argument.
> + * Relocation function essentially needs to do:
> + * memcpy(dst_va, src_va, copy_len);
> + */
> +static int map_segments(struct kimage *kimage, pgd_t *pgdp,
> +			struct trans_pgd_info *info,
> +			unsigned long src_va,
> +			unsigned long dst_va,
> +			unsigned long *copy_len)
> +{
> +	unsigned long *ptr = 0;
> +	unsigned long dest = 0;
> +	unsigned long len = 0;
> +	unsigned long entry, addr;
> +	int rc;
> +
> +	for (entry = kimage->head; !(entry & IND_DONE); entry = *ptr++) {
> +		addr = entry & PAGE_MASK;
> +
> +		switch (entry & IND_FLAGS) {
> +		case IND_DESTINATION:
> +			dest = addr;
> +			break;

So we hope to always find a destination first?


> +		case IND_INDIRECTION:
> +			ptr = __va(addr);
> +			if (rc)
> +				return rc;

Where does rc come from?

> +			break;

> +		case IND_SOURCE:
> +			rc = trans_pgd_map_page(info, pgdp, __va(addr),
> +						src_va, PAGE_KERNEL);
> +			if (rc)
> +				return rc;
> +			rc = trans_pgd_map_page(info, pgdp, __va(dest),
> +						dst_va, PAGE_KERNEL);
> +			if (rc)
> +				return rc;
> +			dest += PAGE_SIZE;
> +			src_va += PAGE_SIZE;
> +			dst_va += PAGE_SIZE;
> +			len += PAGE_SIZE;
> +		}
> +	}
> +	*copy_len = len;
> +
> +	return 0;
> +}
> +
> @@ -89,9 +170,18 @@ int machine_kexec_post_load(struct kimage *kimage)
>  		kern_reloc_arg->el2_vector = __pa(reloc_code)
>  						+ kexec_el2_vectors_offset;
>  	}
> +
> +	/*
> +	 * If relocation is not needed, we do not need to enable MMU in

Strictly you aren't enabling it, but disabling it _after_ the relocation.


> +	 * relocation routine, therefore do not create page tables for
> +	 * scenarios such as crash kernel
> +	 */
> +	if (!(kimage->head & IND_DONE))
> +		rc = mmu_relocate_setup(kimage, reloc_code, kern_reloc_arg);
> +
>  	kexec_image_info(kimage);
>  
> -	return 0;
> +	return rc;
>  }


Thanks,

James

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
