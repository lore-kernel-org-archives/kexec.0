Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEB6606A31C
	for <kexec@archiver.kernel.org>; Thu, 12 Nov 2026 06:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=TnfmWp6m;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EiRz0mJG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=lNjzCkgXtfexLjozyq2Y9l2D4DehQKcLgP4hhpEJaxk=; b=TnfmWp6mmMQuDT
	Hbv3hoE1sxMD+SW6B/y8QsdCcKqLSmCMZ6pFVppa+1ZrVWrde9bMJbSO5O28MHMGCJHqk81IUuyHj
	6cjn46/DlUEquybFSxtLrEQov2XNlABGGe0R/JF2dkaZ0PDKVbDIeCqU0k68zXD77CpDHRcb8jJY/
	gnXBO3h2PifupYsYgIBBYcFCOnOcl6mChPa3WZOa2/LM3luNzxaXUb91Qvg3jDDgv85nOAQlXE9Z5
	DO5jPcX2+Cb8EXecGd2WYSVjJmIG+UDJhZ0s1cO9byQZXuzhjE02DBTqSpGg4xsNU3TPywR9YnR0I
	6YAbPWbItNGFZ/iTfD7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xROMI-00000008pXn-0AQK;
	Thu, 12 Nov 2026 06:32:30 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xROMA-00000008pXJ-3gaV
	for kexec@lists.infradead.org;
	Thu, 12 Nov 2026 06:32:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794465135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lNjzCkgXtfexLjozyq2Y9l2D4DehQKcLgP4hhpEJaxk=;
	b=EiRz0mJGQCB3AlumGLarDCSSjb2e9Dg7ocBk+JVriOYSc4nhRmIwxTRCTOURxM1au2fyF4
	JM25U7uKtWRb0QwQ0Lc9ZUja/KA0/H3hSf9dMNaQsJkQ4DTrLzP+dm6ktyEWk12ySg23lG
	0FpmELz/sQIY7T8iO28PJm4FxhwOgBE=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-6p5O4qn3Mgyu2-e3fUIk7Q-1; Thu, 12 Nov 2026 01:32:13 -0500
X-MC-Unique: 6p5O4qn3Mgyu2-e3fUIk7Q-1
X-Mimecast-MFC-AGG-ID: 6p5O4qn3Mgyu2-e3fUIk7Q_1794465132
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3ad704d4760so4538503a91.3
        for <kexec@lists.infradead.org>; Wed, 11 Nov 2026 22:32:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794465132; x=1795069932;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lNjzCkgXtfexLjozyq2Y9l2D4DehQKcLgP4hhpEJaxk=;
        b=njQlTGmvIN/JcHTXi7ZB4BxJixKaguFG5Y25OMWLi6KGMw5LbbYR7MJf3r2pjmxR6Z
         RepVN2ePxpNB5QVMwGYY4pCoghGp6t9ALvG63y1xwCecKtfnQDh86FHzycuGA1VIn7UL
         G5soQdlrGFBAGFC6aKR96As3FP7wvNEYu/QGVplojTLATZlVQgVSxAaskkVStt+zCQiJ
         7FjUl0fIddvkwmmdGGu3TP38G2Y2BfU22bYd2uKXNyzBuwk+LWs8+WmUYR0IiFda0Yn/
         oiCplp9BY1+3QRpZkYsNeVK22CsrrYMHmNWystCsvuYSZuubvwiV+B6VE5RuwcSbpLF+
         L7Pg==
X-Forwarded-Encrypted: i=1; AL+hErHf1K1OXBL6wn89RUnesS5fz3ufPSqP2/vkKnCowaha4DAuDidDXPQUuGOlzfjHbcevW9ipVw==@lists.infradead.org
X-Gm-Message-State: APuU4Z8Nm21hxYB/nUwmJAfHGQADEQiIMiXbaJ15j1zyV26G4uKdNhlu
	TGLFNCe9Qea2JI1XyfIWM97IjL3pIQKYxq53+Uxcfntn1pnu0dKNhilu4+tyS/NkO3J6PMMK/C9
	pjvu/pBixCSnnZ+HDTV110Xe1m6LFKPrnyeuhRM1jSvEoAN6ujRUPtm9gYd7Cmg==
X-Gm-Gg: AYBFou1/kXAhLXarvl5AqdeCGqeCDudeT/KMnP7vwWeq/+PP8cT+FnzJJVlNYpMJV4C
	GbdSRipwlae+LFCyx+FTe3LkNJGizinLuDJhgu4OBa5hKyAtz1RXJIzuFHnEzMlWy7Uau6ksMVJ
	CvPBhrL5knJxorMRoP4RYFuTZLnfDqU2GfRU2Z+GYyGxHj7BiiD94NkREZH25exUOLGKAkcU9mz
	q+WSjNsKnHtCQVY5j+wwDwOlsBhLvrWR8QzJM/mb/+35YEouidafOBl1byTZ63HYw9yYOTv2vO0
	0cD48hPp4EbqqIcsCuT7MDY1cLMMiPk7wd4d1W00em5XDQ0VAGc2Cmj3xJro4GfzPMdrTR0UrNv
	EQ4TxWnZQechFBTMTJPhBmyx7bM4zZm/vyUudEGponYEkhPboakQarhqSCuLch0i80/C77HRiHg
	X2lJlhY/VfKaJURANdtOOSsaXoeTyaop70ejyi+v5G1pcJzg==
X-Received: by 2002:a17:90b:37c3:b0:3ab:413:49bc with SMTP id 98e67ed59e1d1-3b182ee2462mr4497393a91.37.1794465132351;
        Wed, 11 Nov 2026 22:32:12 -0800 (PST)
X-Received: by 2002:a17:90b:37c3:b0:3ab:413:49bc with SMTP id 98e67ed59e1d1-3b182ee2462mr4497373a91.37.1794465131889;
        Wed, 11 Nov 2026 22:32:11 -0800 (PST)
Received: from ?IPV6:2001:4490:489d:4213:2481:b5a5:59e1:8f87? ([2001:4490:489d:4213:2481:b5a5:59e1:8f87])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197ce49d6sm3019469a91.4.2026.11.11.22.32.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2026 22:32:11 -0800 (PST)
Message-ID: <990cc079-70ab-4fcf-9974-679aaf07849e@redhat.com>
Date: Thu, 12 Nov 2026 12:02:05 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] kho: walk bootmem areas in address order
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>
Cc: Alexander Graf <graf@amazon.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Chen Pei <cp0613@linux.alibaba.com>, George Guo <guodongtai@kylinos.cn>,
 Kexin Liu <liukexin@kylinos.cn>, Sourabh Jain <sourabhjain@linux.ibm.com>,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20261104-kho-bootmem-sizing-v2-0-b0d1a834780f@kernel.org>
 <20261104-kho-bootmem-sizing-v2-1-b0d1a834780f@kernel.org>
From: Mukesh Pilaniya <mpilaniy@redhat.com>
In-Reply-To: <20261104-kho-bootmem-sizing-v2-1-b0d1a834780f@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Tw_ZmBDvOZRReC7NH5ggnWeYLh2CuReTY1ypZkoOlu8_1794465132
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261111_223223_024838_94D5009A 
X-CRM114-Status: GOOD (  34.53  )
X-Spam-Score: -2.8 (--)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Mike,

On 04/11/26 10:20 pm, Mike Rapoport (Microsoft) wrote:
> kexec_add_buffer() users may depend on the order in which memory holes are
> searched. For instance, arm64 places the kernel bottom-up and then
> requires the DTB to be above the kernel.
> 
> kho_walk_bootmem() walks the bootmem areas in the order they were
> reserved, so if the kernel lands in a small area at the top of the memory
> there is no room left for the DTB and kexec fails. For example, on an
> arm64 VM with 2G of RAM and kho_bootmem=8M,64M,64M, the lowmem area is
> reserved first at the top of the memory, the kernel image takes most of
> it and kexec fails with
> 
>   kexec_file(Image): Could not find any suitable kernel location!
> 
> Sort the bootmem areas by address and walk them in ascending order, or in
> descending order for top-down searches, like kexec_walk_resources() does.
> 
> Fixes: 3bdecc3c93f9 ("kexec: add KHO support to kexec file loads")
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  kernel/liveupdate/kexec_handover.c | 57 ++++++++++++++++++++++++++++++--------
>  1 file changed, 46 insertions(+), 11 deletions(-)
> 
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index 6f1f55fe31819..2ac5d94f33fd4 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -26,6 +26,7 @@
>  #include <linux/list.h>
>  #include <linux/memblock.h>
>  #include <linux/page-isolation.h>
> +#include <linux/sort.h>
>  #include <linux/unaligned.h>
>  #include <linux/vmalloc.h>
>  
> @@ -820,6 +821,14 @@ bool kho_bootmem_overlap(phys_addr_t phys, size_t size)
>  	return false;
>  }
>  
> +static int __init kho_bootmem_cmp(const void *_a, const void *_b)
> +{
> +	const struct kho_bootmem *a = _a;
> +	const struct kho_bootmem *b = _b;
> +
> +	return cmp_int(a->addr, b->addr);
> +}
> +
>  /**
>   * kho_reserve_bootmem - Reserve a contiguous chunk of memory for kexec
>   *
> @@ -904,6 +913,9 @@ static void __init kho_reserve_bootmem(void)
>  	 */
>  	kho_bootmem_cnt = i;
>  
> +	sort(kho_bootmem, kho_bootmem_cnt, sizeof(*kho_bootmem),
> +	     kho_bootmem_cmp, NULL);
This only covers the case where this kernel allocated the areas itself.
On a KHO boot the array comes from the previous kernel. A kernel with
this series that is handed over from one without it therefore keeps
walking the areas in reservation order for every following
kexec_file_load, and the arm64 failure you describe comes back until the
next cold boot and vise versa because the ABI string is still
"kho-v4".

So, sorting once in kho_memory_init_early after kho_bootmem is
mapped would make the invariant independent of the producer.  When the
previous kernel does have the sort this is a no-op, but the consumer
cannot tell which kernel recorded the array, because the ABI string is
the same.

> +
>  	return;
>  
>  err_free_bootmem_areas:
> @@ -2081,20 +2093,40 @@ int kho_fill_kimage(struct kimage *image)
>  	return 0;
>  }
>  
> -static int kho_walk_bootmem(struct kexec_buf *kbuf,
> -			    int (*func)(struct resource *, void *))
> +static int kho_bootmem_walk_one(struct kexec_buf *kbuf,
> +				const struct kho_bootmem *area,
> +				int (*func)(struct resource *, void *))
> +{
> +	struct resource res = {
> +		.start = area->addr,
> +		.end = area->addr + area->size - 1,
> +	};
> +
> +	/* Try to fit the kbuf into our KHO bootmem region */
> +	return func(&res, kbuf);
> +}
> +
> +static int kho_bootmem_walk_top_down(struct kexec_buf *kbuf,
> +				     int (*func)(struct resource *, void *))
>  {
>  	int ret = 0;
> -	int i;
>  
> -	for (i = 0; i < kho_bootmem_cnt; i++) {
> -		struct resource res = {
> -			.start = kho_bootmem[i].addr,
> -			.end = kho_bootmem[i].addr + kho_bootmem[i].size - 1,
> -		};
> +	for (int i = kho_bootmem_cnt - 1; i >= 0; i--) {
kho_bootmem_cnt is unsigned, but the reverse loops in
kho_reserve_bootmem() and kho_bootmem_walk_top_down() start an int
counter at kho_bootmem_cnt - 1, which for a zero count is UINT_MAX
converted to int.  That conversion is implementation-defined; with the
current compilers it yields -1 and the loop body is skipped.

How about using this one.
	for (unsigned int i = kho_bootmem_cnt; i-- > 0;)

Reviewed-by: Mukesh Pilaniya <mpilaniy@redhat.com>

> +		ret = kho_bootmem_walk_one(kbuf, &kho_bootmem[i], func);
> +		if (ret)
> +			break;
> +	}
> +
> +	return ret;
> +}
>  
> -		/* Try to fit the kimage into our KHO bootmem region */
> -		ret = func(&res, kbuf);
> +static int kho_bootmem_walk_bottom_up(struct kexec_buf *kbuf,
> +				      int (*func)(struct resource *, void *))
> +{
> +	int ret = 0;
> +
> +	for (int i = 0; i < kho_bootmem_cnt; i++) {
> +		ret = kho_bootmem_walk_one(kbuf, &kho_bootmem[i], func);
>  		if (ret)
>  			break;
>  	}
> @@ -2110,7 +2142,10 @@ int kho_locate_mem_hole(struct kexec_buf *kbuf,
>  	if (!kho_enable || kbuf->image->type == KEXEC_TYPE_CRASH)
>  		return 1;
>  
> -	ret = kho_walk_bootmem(kbuf, func);
> +	if (kbuf->top_down)
> +		ret = kho_bootmem_walk_top_down(kbuf, func);
> +	else
> +		ret = kho_bootmem_walk_bottom_up(kbuf, func);
>  
>  	return ret == 1 ? 0 : -EADDRNOTAVAIL;
>  }
> 

-- 
Regards,
Mukesh Pilaniya


