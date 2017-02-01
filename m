Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Wed, 1 Feb 2017 16:03:54 +0000
From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v31 04/12] arm64: mm: allow for unmapping part of kernel
 mapping
Message-ID: <20170201160354.GF4756@leverpostej>
References: <20170201124218.5823-1-takahiro.akashi@linaro.org>
 <20170201124630.6016-3-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20170201124630.6016-3-takahiro.akashi@linaro.org>
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
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: geoff@infradead.org, catalin.marinas@arm.com, will.deacon@arm.com, james.morse@arm.com, bauerman@linux.vnet.ibm.com, dyoung@redhat.com, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

Hi,

On Wed, Feb 01, 2017 at 09:46:23PM +0900, AKASHI Takahiro wrote:
> A new function, remove_pgd_mapping(), is added.
> It allows us to unmap a specific portion of kernel mapping later as far as
> the mapping is made using create_pgd_mapping() and unless we try to free
> a sub-set of memory range within a section mapping.

I'm not keen on adding more page table modification code. It was painful
enough to ensure that those worked in all configurations.

Why can't we reuse create_pgd_mapping()? If we pass page_mappings_only,
and use an invalid prot (i.e. 0), what is the problem?

I can see that we wouldn't free/reallocate the pud or pmd entries, but
the "wasted" memory should be small. If anything, I'd argue that it's
preferable to keep that around so that we don't have to allocate memory
when we need to map the crashkernel region.

Is there another problem I'm missing?

> +static bool pgtable_is_cleared(void *pgtable)
> +{
> +	unsigned long *desc, *end;
> +
> +	for (desc = pgtable, end = (unsigned long *)(pgtable + PAGE_SIZE);
> +	     desc < end; desc++)
> +		if (*desc)
> +			return false;
> +
> +	return true;
> +}

If nothing else, we should be using the normal accessors for this, e.g.
{pte,pmd,pud}_none().

As above, I'd very much like to reuse our existing page table routines
if we can.

Thanks,
Mark.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
