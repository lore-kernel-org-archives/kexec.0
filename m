Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo162.gate.nec.co.jp ([114.179.232.162])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUwEG-00018t-KJ
 for kexec@lists.infradead.org; Thu, 06 Dec 2018 16:10:24 +0000
From: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Subject: RE: [PATCH] makedumpfile/ppc64: increase MAX_PHYSMEM_BITS to 2PB
Date: Thu, 6 Dec 2018 16:09:15 +0000
Message-ID: <4AE2DC15AC0B8543882A74EA0D43DBEC035643AE@BPXM09GP.gisp.nec.co.jp>
References: <154392057860.8770.14995516431234212273.stgit@hbathini.in.ibm.com>
In-Reply-To: <154392057860.8770.14995516431234212273.stgit@hbathini.in.ibm.com>
Content-Language: en-US
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Hari Bathini <hbathini@linux.ibm.com>
Cc: Dave Young <dyoung@redhat.com>, Petr Tesarik <ptesarik@suse.cz>, Kexec-ml <kexec@lists.infradead.org>

> -----Original Message-----
> * Required for kernel 4.20
> 
> With kernel commit 4ffe713b7587 ("powerpc/mm: Increase the max addressable
> memory to 2PB"), MAX_PHYSMEM_BITS is bumped up to 51 for SPARSEMEM_VMEMMAP
> and SPARSEMEM_EXTREME case. Make the appropriate update here.
> 
> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>

Applied to the devel branch.

Thanks,
Kazu

> ---
>  arch/ppc64.c   |    5 +++++
>  makedumpfile.h |    1 +
>  2 files changed, 6 insertions(+)
> 
> diff --git a/arch/ppc64.c b/arch/ppc64.c
> index 947a125..5b8231e 100644
> --- a/arch/ppc64.c
> +++ b/arch/ppc64.c
> @@ -486,6 +486,11 @@ set_ppc64_max_physmem_bits(void)
>  		|| (array_len == (NR_MEM_SECTIONS() / _SECTIONS_PER_ROOT())))
>  		return TRUE;
> 
> +	info->max_physmem_bits  = _MAX_PHYSMEM_BITS_4_20;
> +	if ((array_len == (NR_MEM_SECTIONS() / _SECTIONS_PER_ROOT_EXTREME()))
> +		|| (array_len == (NR_MEM_SECTIONS() / _SECTIONS_PER_ROOT())))
> +		return TRUE;
> +
>  	return FALSE;
>  }
> 
> diff --git a/makedumpfile.h b/makedumpfile.h
> index 73813ed..d49f1f1 100644
> --- a/makedumpfile.h
> +++ b/makedumpfile.h
> @@ -672,6 +672,7 @@ unsigned long get_kvbase_arm64(void);
>  #define _MAX_PHYSMEM_BITS_ORIG  (44)
>  #define _MAX_PHYSMEM_BITS_3_7   (46)
>  #define _MAX_PHYSMEM_BITS_4_19  (47)
> +#define _MAX_PHYSMEM_BITS_4_20  (51)
>  #define REGION_SHIFT            (60UL)
>  #define VMEMMAP_REGION_ID       (0xfUL)
> 
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
