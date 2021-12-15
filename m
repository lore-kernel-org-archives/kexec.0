Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mxURE-000wLx-3x
 for kexec@lists.infradead.org; Wed, 15 Dec 2021 13:35:21 +0000
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 26E131006AA4
 for <kexec@lists.infradead.org>; Wed, 15 Dec 2021 13:35:17 +0000 (UTC)
Date: Wed, 15 Dec 2021 14:35:12 +0100
From: Philipp Rudo <prudo@redhat.com>
Subject: Re: [PATCH 2/3] arm64/crashdump: unify routine to get page_offset
Message-ID: <20211215143512.4b0d745c@rhtmp>
In-Reply-To: <20211210030735.53155-3-piliu@redhat.com>
References: <20211210030735.53155-1-piliu@redhat.com>
 <20211210030735.53155-3-piliu@redhat.com>
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
To: Pingfan Liu <piliu@redhat.com>
Cc: kexec@lists.infradead.org

Hi Pinfang,

On Fri, 10 Dec 2021 11:07:34 +0800
Pingfan Liu <piliu@redhat.com> wrote:

> There are two funcs to get page_offset:
>   get_kernel_page_offset()
>   get_page_offset()
> 
> Since get_kernel_page_offset() does not observe the kernel formula, and
> remove it. Unify them in order to introduce 52-bits VA kernel more
> easily in the coming patch.
> 
> Signed-off-by: Pingfan Liu <piliu@redhat.com>
> ---
>  kexec/arch/arm64/crashdump-arm64.c | 23 +----------------------
>  kexec/arch/arm64/kexec-arm64.c     |  4 ++--
>  kexec/arch/arm64/kexec-arm64.h     |  1 +
>  3 files changed, 4 insertions(+), 24 deletions(-)
> 
> diff --git a/kexec/arch/arm64/crashdump-arm64.c b/kexec/arch/arm64/crashdump-arm64.c
> index a02019a..0a8d44c 100644
> --- a/kexec/arch/arm64/crashdump-arm64.c
> +++ b/kexec/arch/arm64/crashdump-arm64.c

[...]

> diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
> index 7373fa3..bd650e6 100644
> --- a/kexec/arch/arm64/kexec-arm64.c
> +++ b/kexec/arch/arm64/kexec-arm64.c
> @@ -909,7 +909,7 @@ static int get_va_bits(void)
>   * get_page_offset - Helper for getting PAGE_OFFSET
>   */
>  
> -static int get_page_offset(void)
> +int get_page_offset(unsigned long *page_offset)
>  {
>  	int ret;
>  

The new page_offset is never used in this patch. There's still the line
left with the global page_offset but that will cause a type miss-match
(unsigend long vs unsigned log *). In the next patch you do the update
(page_offset -> *page_offset) but in the meantime the code is broken.

Thanks
Philipp

> @@ -954,7 +954,7 @@ int get_phys_base_from_pt_load(long *phys_offset)
>  	unsigned long long phys_start;
>  	unsigned long long virt_start;
>  
> -	ret = get_page_offset();
> +	ret = get_page_offset(&page_offset);
>  	if (ret < 0)
>  		return ret;
>  
> diff --git a/kexec/arch/arm64/kexec-arm64.h b/kexec/arch/arm64/kexec-arm64.h
> index 1844b67..ed99d9d 100644
> --- a/kexec/arch/arm64/kexec-arm64.h
> +++ b/kexec/arch/arm64/kexec-arm64.h
> @@ -69,6 +69,7 @@ extern struct arm64_mem arm64_mem;
>  
>  uint64_t get_phys_offset(void);
>  uint64_t get_vp_offset(void);
> +int get_page_offset(unsigned long *offset);
>  
>  static inline void reset_vp_offset(void)
>  {


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
