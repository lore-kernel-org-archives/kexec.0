Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73] helo=mx1.redhat.com)
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fXXMq-0004qB-Kc
 for kexec@lists.infradead.org; Mon, 25 Jun 2018 19:41:42 +0000
Subject: Re: [PATCH] makedumpfile/ppc64: Increase the VA range
References: <152941950897.27658.15976744741411711134.stgit@hbathini.in.ibm.com>
From: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Message-ID: <96850b7d-473b-4a9d-5886-ee5ec854b84d@redhat.com>
Date: Mon, 25 Jun 2018 15:41:11 -0400
MIME-Version: 1.0
In-Reply-To: <152941950897.27658.15976744741411711134.stgit@hbathini.in.ibm.com>
Content-Language: en-US
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
Cc: Masaki Tachibana <mas-tachibana@vf.jp.nec.com>, Daisuke Nishimura <dai-nishimura@rc.jp.nec.com>, piliu@redhat.com, ptesarik@suse.cz, Kexec-ml <kexec@lists.infradead.org>, andrej.skvortzov@gmail.com, Takuya Nakayama <tak-nakayama@tg.jp.nec.com>, Dave Young <dyoung@redhat.com>

Hi Hari,

Sorry for the late response.
I'm taking over the maintainer role of makedumpfile from Tachibana-san.

This patch is queued for v1.6.4.

Thanks,
Kazu

On 6/19/2018 10:45 AM, Hari Bathini wrote:
> * Required for kernel 4.17
> 
> Since kernel commit c2b4d8b7417a ("powerpc/mm/hash64: Increase the VA
> range"), the max virtual (effective) address value has been increased
> to 4PB. Update page table index values accordingly.
> 
> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
> ---
>  arch/ppc64.c   |    5 ++++-
>  makedumpfile.h |    1 +
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/ppc64.c b/arch/ppc64.c
> index 8bdbcc5..8b6f7d5 100644
> --- a/arch/ppc64.c
> +++ b/arch/ppc64.c
> @@ -248,7 +248,10 @@ ppc64_vmalloc_init(void)
>  
>  			if (info->kernel_version >= KERNEL_VERSION(4, 12, 0)) {
>  				info->l2_index_size = PMD_INDEX_SIZE_L4_64K_4_12;
> -				info->l3_index_size = PUD_INDEX_SIZE_L4_64K_4_12;
> +				if (info->kernel_version >= KERNEL_VERSION(4, 17, 0))
> +					info->l3_index_size = PUD_INDEX_SIZE_L4_64K_4_17;
> +				else
> +					info->l3_index_size = PUD_INDEX_SIZE_L4_64K_4_12;
>  				info->l4_index_size = PGD_INDEX_SIZE_L4_64K_4_12;
>  			} else {
>  				info->l2_index_size = PMD_INDEX_SIZE_L4_64K_4_6;
> diff --git a/makedumpfile.h b/makedumpfile.h
> index 121eab2..4960e43 100644
> --- a/makedumpfile.h
> +++ b/makedumpfile.h
> @@ -703,6 +703,7 @@ unsigned long get_kvbase_arm64(void);
>  #define PMD_INDEX_SIZE_L4_64K_4_12 10
>  #define PUD_INDEX_SIZE_L4_64K_4_12 7
>  #define PGD_INDEX_SIZE_L4_64K_4_12 8
> +#define PUD_INDEX_SIZE_L4_64K_4_17 10
>  #define PTE_INDEX_SIZE_RADIX_64K  5
>  #define PMD_INDEX_SIZE_RADIX_64K  9
>  #define PUD_INDEX_SIZE_RADIX_64K  9
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
