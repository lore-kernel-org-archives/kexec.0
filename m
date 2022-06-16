Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96530C43334
	for <kexec@archiver.kernel.org>; Thu, 16 Jun 2022 02:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1Aer1gVD8Udn38FvNCKj6nqcwF7Ongm1PEEa+R/dLGE=; b=zwdZ3NNi/62liy
	TvMNwVhsRIv8ym3y1CyZGUeFiheZeaZFq6egYTuDcUNiisGJECTuIwoicvzEYZFIa8maasiIc86gP
	ytyiDjJewslsUfQK8vmZuAJ8Hc3OFDk37NGUZ5Ph1M8YNZxGS/mRG028+Z/ZXiQ1/ODdLLXFrhEgg
	0ulU2zicHx/mA8m7aT70ISQO8V1xpz7cBTu/KYoSbdMHnXTTKU+kIm+HRoETswF4QdbZ5QXzniqbc
	BSm73yYahfczfg993jSSQEXDZs8wc/Ck6p/QpVmHsYKLeBEJ2jl8V9M8rKCCwXPFBYwi43Jp9eEO1
	Yln/c3xB7j09+qsd/0TA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1erl-00HZE0-9A; Thu, 16 Jun 2022 02:04:13 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1erf-00HZ9r-Se
	for kexec@lists.infradead.org; Thu, 16 Jun 2022 02:04:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1655345045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+6r1G8PKJO7+Y7DI4HGnIM2AF5wLt599saHsPkMasHA=;
	b=Lp/MyymFGRMEFST7wk9R3p6c2ysUCVTx0NSNEU6CvzJ/SDEDDKOZ5xTGMvA/jvLIZDHl9f
	KPIPe4GTywhi2pqZhgyB0OlPdNirm1cO8lI+6pae2vwa4okdi+Gu/GEepDi6AMnmx3F6pc
	BKWFezqJY/IzJVGM0kmIZNVZGRAHTE0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-423-vekuOx0TNhespHrQtMhD6g-1; Wed, 15 Jun 2022 22:04:02 -0400
X-MC-Unique: vekuOx0TNhespHrQtMhD6g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AB4973801149;
	Thu, 16 Jun 2022 02:04:01 +0000 (UTC)
Received: from localhost (ovpn-12-237.pek2.redhat.com [10.72.12.237])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 18CFE2166B26;
	Thu, 16 Jun 2022 02:03:57 +0000 (UTC)
Date: Thu, 16 Jun 2022 10:03:53 +0800
From: Baoquan He <bhe@redhat.com>
To: Li Chen <me@linux.beauty>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>,
	Eric Biederman <ebiederm@xmission.com>,
	kexec <kexec@lists.infradead.org>
Subject: Re: [PATCH] kexec: replace crash_mem_range with range
Message-ID: <YqqPiU+tkCh+vXC/@MiWiFi-R3L-srv>
References: <18165bf7271.d72aa7571639569.7041635736718062250@linux.beauty>
MIME-Version: 1.0
In-Reply-To: <18165bf7271.d72aa7571639569.7041635736718062250@linux.beauty>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=bhe@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220615_190408_097745_4DFF79AE 
X-CRM114-Status: GOOD (  24.64  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
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
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 06/14/22 at 10:04pm, Li Chen wrote:
> From: Li Chen <lchen@ambarella.com>
> 
> We already have struct range, so just use it.

Looks good, have you tested it?

> 
> Signed-off-by: Li Chen <lchen@ambarella.com>
> ---
>  arch/powerpc/kexec/file_load_64.c | 2 +-
>  arch/powerpc/kexec/ranges.c       | 8 ++++----
>  include/linux/kexec.h             | 7 ++-----
>  kernel/kexec_file.c               | 2 +-
>  4 files changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
> index b4981b651d9a..583b7fc478f2 100644
> --- a/arch/powerpc/kexec/file_load_64.c
> +++ b/arch/powerpc/kexec/file_load_64.c
> @@ -34,7 +34,7 @@ struct umem_info {
>  
>  	/* usable memory ranges to look up */
>  	unsigned int nr_ranges;
> -	const struct crash_mem_range *ranges;
> +	const struct range *ranges;
>  };
>  
>  const struct kexec_file_ops * const kexec_file_loaders[] = {
> diff --git a/arch/powerpc/kexec/ranges.c b/arch/powerpc/kexec/ranges.c
> index 563e9989a5bf..5fc53a5fcfdf 100644
> --- a/arch/powerpc/kexec/ranges.c
> +++ b/arch/powerpc/kexec/ranges.c
> @@ -33,7 +33,7 @@
>  static inline unsigned int get_max_nr_ranges(size_t size)
>  {
>  	return ((size - sizeof(struct crash_mem)) /
> -		sizeof(struct crash_mem_range));
> +		sizeof(struct range));
>  }
>  
>  /**
> @@ -51,7 +51,7 @@ static inline size_t get_mem_rngs_size(struct crash_mem *mem_rngs)
>  		return 0;
>  
>  	size = (sizeof(struct crash_mem) +
> -		(mem_rngs->max_nr_ranges * sizeof(struct crash_mem_range)));
> +		(mem_rngs->max_nr_ranges * sizeof(struct range)));
>  
>  	/*
>  	 * Memory is allocated in size multiple of MEM_RANGE_CHUNK_SZ.
> @@ -98,7 +98,7 @@ static int __add_mem_range(struct crash_mem **mem_ranges, u64 base, u64 size)
>   */
>  static void __merge_memory_ranges(struct crash_mem *mem_rngs)
>  {
> -	struct crash_mem_range *ranges;
> +	struct range *ranges;
>  	int i, idx;
>  
>  	if (!mem_rngs)
> @@ -123,7 +123,7 @@ static void __merge_memory_ranges(struct crash_mem *mem_rngs)
>  /* cmp_func_t callback to sort ranges with sort() */
>  static int rngcmp(const void *_x, const void *_y)
>  {
> -	const struct crash_mem_range *x = _x, *y = _y;
> +	const struct range *x = _x, *y = _y;
>  
>  	if (x->start > y->start)
>  		return 1;
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index 58d1b58a971e..d7ab4ad4c619 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -17,6 +17,7 @@
>  
>  #include <linux/crash_core.h>
>  #include <asm/io.h>
> +#include <linux/range.h>
>  
>  #include <uapi/linux/kexec.h>
>  
> @@ -214,14 +215,10 @@ int kexec_locate_mem_hole(struct kexec_buf *kbuf);
>  /* Alignment required for elf header segment */
>  #define ELF_CORE_HEADER_ALIGN   4096
>  
> -struct crash_mem_range {
> -	u64 start, end;
> -};
> -
>  struct crash_mem {
>  	unsigned int max_nr_ranges;
>  	unsigned int nr_ranges;
> -	struct crash_mem_range ranges[];
> +	struct range ranges[];
>  };
>  
>  extern int crash_exclude_mem_range(struct crash_mem *mem,
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 8347fc158d2b..f2758af86b93 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -1183,7 +1183,7 @@ int crash_exclude_mem_range(struct crash_mem *mem,
>  {
>  	int i, j;
>  	unsigned long long start, end, p_start, p_end;
> -	struct crash_mem_range temp_range = {0, 0};
> +	struct range temp_range = {0, 0};
>  
>  	for (i = 0; i < mem->nr_ranges; i++) {
>  		start = mem->ranges[i].start;
> -- 
> 2.36.1
> 
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
