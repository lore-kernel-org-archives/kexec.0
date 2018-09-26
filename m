Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo162.gate.nec.co.jp ([114.179.232.162])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1g5GKh-0004GR-EZ
 for kexec@lists.infradead.org; Wed, 26 Sep 2018 20:22:59 +0000
From: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Subject: RE: [PATCH] makedumpfile/ppc64: increase MAX_PHYSMEM_BITS to 128TB
Date: Wed, 26 Sep 2018 20:21:27 +0000
Message-ID: <4AE2DC15AC0B8543882A74EA0D43DBEC0355C8FA@BPXM09GP.gisp.nec.co.jp>
References: <153798098618.3701.11236762967901266676.stgit@hbathini.in.ibm.com>
In-Reply-To: <153798098618.3701.11236762967901266676.stgit@hbathini.in.ibm.com>
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
Cc: Dave Young <dyoung@redhat.com>, Kexec-ml <kexec@lists.infradead.org>, Petr Tesarik <ptesarik@suse.cz>

On 9/26/2018 12:56 PM, Hari Bathini wrote: 
> * Required for kernel 4.19
> 
> With kernel commit 7d4340bb92a9 ("powerpc/mm: Increase MAX_PHYSMEM_BITS
> to 128TB with SPARSEMEM_VMEMMAP config"), MAX_PHYSMEM_BITS is bumped up
> to 47. Make the appropriate update here.
> 
> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
> ---
>  arch/ppc64.c   |    5 +++++
>  makedumpfile.h |    1 +
>  2 files changed, 6 insertions(+)
> 
> diff --git a/arch/ppc64.c b/arch/ppc64.c
> index 8b6f7d5..947a125 100644
> --- a/arch/ppc64.c
> +++ b/arch/ppc64.c
> @@ -481,6 +481,11 @@ set_ppc64_max_physmem_bits(void)
>  		|| (array_len == (NR_MEM_SECTIONS() / _SECTIONS_PER_ROOT())))
>  		return TRUE;
> 
> +	info->max_physmem_bits  = _MAX_PHYSMEM_BITS_4_19;
> +	if ((array_len == (NR_MEM_SECTIONS() / _SECTIONS_PER_ROOT_EXTREME()))
> +		|| (array_len == (NR_MEM_SECTIONS() / _SECTIONS_PER_ROOT())))
> +		return TRUE;
> +
>  	return FALSE;
>  }
> 
> diff --git a/makedumpfile.h b/makedumpfile.h
> index d1fcd87..46ebe2e 100644
> --- a/makedumpfile.h
> +++ b/makedumpfile.h
> @@ -673,6 +673,7 @@ unsigned long get_kvbase_arm64(void);
>  #define _SECTION_SIZE_BITS	(24)
>  #define _MAX_PHYSMEM_BITS_ORIG  (44)
>  #define _MAX_PHYSMEM_BITS_3_7   (46)
> +#define _MAX_PHYSMEM_BITS_4_19  (47)
>  #define REGION_SHIFT            (60UL)
>  #define VMEMMAP_REGION_ID       (0xfUL)
> 
> 

Thanks Hari, applied to the devel branch.

Kazu



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
