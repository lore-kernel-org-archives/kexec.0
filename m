Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out03.mta.xmission.com ([166.70.13.233])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1covv7-0006EY-I6
 for kexec@lists.infradead.org; Fri, 17 Mar 2017 17:44:12 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <1489746150-28364-1-git-send-email-xlpang@redhat.com>
Date: Fri, 17 Mar 2017 12:38:49 -0500
In-Reply-To: <1489746150-28364-1-git-send-email-xlpang@redhat.com> (Xunlei
 Pang's message of "Fri, 17 Mar 2017 18:22:30 +0800")
Message-ID: <8737ebg5w6.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [PATCH] x86_64,
 kexec: Avoid unnecessary identity mappings for kdump
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
To: Xunlei Pang <xlpang@redhat.com>
Cc: Baoquan He <bhe@redhat.com>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, akpm@linux-foundation.org, Dave Young <dyoung@redhat.com>

Xunlei Pang <xlpang@redhat.com> writes:

> kexec setups identity mappings for all the memory mapped in 1st kernel,
> this is not necessary for the kdump case. Actually it can cause extra
> memory consumption for paging structures, which is quite considerable
> on modern machines with huge memory.
>
> E.g. On our 24TB machine, it will waste around 96MB (around 4MB/TB)
> from the reserved memory range if setting all the identity mappings.
>
> It also causes some trouble for distributions that use an intelligent
> policy to evaluate the proper "crashkernel=X" for users.
>
> To solve it, in case of kdump, we only setup identity mappings for the
> crash memory and the ISA memory(may be needed by purgatory/kdump
> boot).

How about instead we detect the presence of 1GiB pages and use them
if they are available.  We already use 2MiB pages.  If we can do that
we will only need about 192K for page tables in the case you have
described and this all becomes a non-issue.

I strongly suspect that the presence of 24TiB of memory in an x86 system
strongly correlates to the presence of 1GiB pages.

In principle we certainly can use a less extensive mapping but that
should not be something that differs between the two kexec cases.

I can see forcing the low 1MiB range in.  But calling it ISA range is
very wrong and misleading.  The reasons that range are special during
boot-up have nothing to do with ISA.  But have everything to do with
where legacy page tables are mapped, and where we need identity pages to
start other cpus.  I think the only user that actually cares is
purgatory where it plays swapping games with the low 1MiB because we
can't preload what we need to down there or it would mess up the running
kernel.  So saying anything about the old ISA bus is wrong and
misleading.  At the very very least we need accurate comments.

Eric


>
> Signed-off-by: Xunlei Pang <xlpang@redhat.com>
> ---
>  arch/x86/kernel/machine_kexec_64.c | 34 ++++++++++++++++++++++++++++++----
>  1 file changed, 30 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
> index 857cdbd..db77a76 100644
> --- a/arch/x86/kernel/machine_kexec_64.c
> +++ b/arch/x86/kernel/machine_kexec_64.c
> @@ -112,14 +112,40 @@ static int init_pgtable(struct kimage *image, unsigned long start_pgtable)
>  
>  	level4p = (pgd_t *)__va(start_pgtable);
>  	clear_page(level4p);
> -	for (i = 0; i < nr_pfn_mapped; i++) {
> -		mstart = pfn_mapped[i].start << PAGE_SHIFT;
> -		mend   = pfn_mapped[i].end << PAGE_SHIFT;
>  
> +	if (image->type == KEXEC_TYPE_CRASH) {
> +		/* Always map the ISA range */
>  		result = kernel_ident_mapping_init(&info,
> -						 level4p, mstart, mend);
> +				level4p, 0, ISA_END_ADDRESS);
>  		if (result)
>  			return result;
> +
> +		/* crashk_low_res may not be initialized when reaching here */
> +		if (crashk_low_res.end) {
> +			mstart = crashk_low_res.start;
> +			mend = crashk_low_res.end + 1;
> +			result = kernel_ident_mapping_init(&info,
> +					level4p, mstart, mend);
> +			if (result)
> +				return result;
> +		}
> +
> +		mstart = crashk_res.start;
> +		mend = crashk_res.end + 1;
> +		result = kernel_ident_mapping_init(&info,
> +				level4p, mstart, mend);
> +		if (result)
> +			return result;
> +	} else {
> +		for (i = 0; i < nr_pfn_mapped; i++) {
> +			mstart = pfn_mapped[i].start << PAGE_SHIFT;
> +			mend   = pfn_mapped[i].end << PAGE_SHIFT;
> +
> +			result = kernel_ident_mapping_init(&info,
> +					 level4p, mstart, mend);
> +			if (result)
> +				return result;
> +		}
>  	}
>  
>  	/*

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
