Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 366C3C4332F
	for <kexec@archiver.kernel.org>; Mon, 21 Nov 2022 08:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YWAuF7aH/xKGJKEoGvkN7bRQfEpjdQxQsO44L6oZEcU=; b=FbTTJLCRwBjQb4
	s7zi6RamkPwjWP4lQNBDA0gdOFZbyvCxmLCQ4Xx5zsfZ9TJxPO4pSC2TjX7B1jihVYIBM+SMJmQK1
	XeTkmhm/mnDpeXitSD9kpxkNaWmka5LOzg8cFKtz1IeKjClARKPWJteOkRnyls1soQSBZjI1kQBOm
	CqP1x0L2G5+WPSdpI6/NzaDRlHrSSBAmQTs6Fh0SgDfIlsIyN2bCv0sxRsAlRxObudNJkAGoNScqK
	RJDuF2GHRXotHiwoLcl0FJNgC8rlGF3HcQps5fPM8Bqq8ILgkp/r7VWi1h5xCRme3HsZm55PWtVCT
	dNwH3z0ffrYcDFbaqS+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ox2DU-00BI29-AT; Mon, 21 Nov 2022 08:31:48 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ox2DQ-00BHze-N7
	for kexec@lists.infradead.org; Mon, 21 Nov 2022 08:31:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1669019502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lS+1v4t3MHKdnVMtm8dzAIaMzgKu70EAh1YPkpsaRUY=;
	b=XxQgJdoJ/j9i+ORlW4umhf4SnpO2RSSO/Eseb9ystQ/LDA/iP2/izaFr0HjBCxN1GwIGDS
	rEzHKks0Al4esUIcwtQfNyuqMMOTBQgy4CHOhoo0WlxSwh1P+ZPXDXK3F2l8UABEM6A0YQ
	D/C+NoCzVPP8u2UAgc1fuLaa7i46NWI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-616-5tZ5hloXMymn1Pe7RqWmjg-1; Mon, 21 Nov 2022 03:31:40 -0500
X-MC-Unique: 5tZ5hloXMymn1Pe7RqWmjg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5F6B887B2A0;
	Mon, 21 Nov 2022 08:31:39 +0000 (UTC)
Received: from localhost (ovpn-13-22.pek2.redhat.com [10.72.13.22])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id CF436492CA2;
	Mon, 21 Nov 2022 08:31:37 +0000 (UTC)
Date: Mon, 21 Nov 2022 16:31:32 +0800
From: Baoquan He <bhe@redhat.com>
To: Zhen Lei <thunder.leizhen@huawei.com>
Cc: Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Feng Zhou <zhoufeng.zf@bytedance.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Chen Zhou <dingguo.cz@antgroup.com>,
	John Donnelly <John.p.donnelly@oracle.com>,
	Dave Kleikamp <dave.kleikamp@oracle.com>
Subject: Re: [PATCH v4 2/2] arm64: kdump: Support crashkernel=X fall back to
 reserve region above DMA zones
Message-ID: <Y3s3ZCYj+ZbI3whB@MiWiFi-R3L-srv>
References: <20221116121044.1690-1-thunder.leizhen@huawei.com>
 <20221116121044.1690-3-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221116121044.1690-3-thunder.leizhen@huawei.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221121_003144_872512_677A8E0F 
X-CRM114-Status: GOOD (  28.70  )
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

On 11/16/22 at 08:10pm, Zhen Lei wrote:
> For crashkernel=X without '@offset', select a region within DMA zones
> first, and fall back to reserve region above DMA zones. This allows
> users to use the same configuration on multiple platforms.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> Acked-by: Baoquan He <bhe@redhat.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt |  2 +-
>  arch/arm64/mm/init.c                            | 17 ++++++++++++++++-
>  2 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index a7b7147447b8bf8..ef6d922ed26b9dc 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -842,7 +842,7 @@
>  			memory region [offset, offset + size] for that kernel
>  			image. If '@offset' is omitted, then a suitable offset
>  			is selected automatically.
> -			[KNL, X86-64] Select a region under 4G first, and
> +			[KNL, X86-64, ARM64] Select a region under 4G first, and
>  			fall back to reserve region above 4G when '@offset'
>  			hasn't been specified.
>  			See Documentation/admin-guide/kdump/kdump.rst for further details.
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index ba7227179822d10..58a0bb2c17f18cf 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -132,6 +132,7 @@ static void __init reserve_crashkernel(void)
>  	unsigned long long crash_max = CRASH_ADDR_LOW_MAX;
>  	char *cmdline = boot_command_line;
>  	int ret;
> +	bool fixed_base = false;
>  
>  	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
>  		return;
> @@ -163,12 +164,26 @@ static void __init reserve_crashkernel(void)
>  	crash_size = PAGE_ALIGN(crash_size);
>  
>  	/* User specifies base address explicitly. */
> -	if (crash_base)
> +	if (crash_base) {
> +		fixed_base = true;
>  		crash_max = crash_base + crash_size;
> +	}
>  
> +retry:
>  	crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
>  					       crash_base, crash_max);

This pachset looks good to me. While we observed a unexpected case,
where a reserved region cross the high and low meomry region. I noticed
Catalin has pointed that out. Even with the suggested code, we could
have the kernel parameters like: crashkernel=512M,high
crashkernel=128M,low, we finally have [4G-126M, 4G+386M], [1G, 1G+128M]
regions in running kernel. This looks strange.

I am wondering if we can specify explicit search_base in
memblock_phys_alloc_range() to avoid above case. Like this,
crashkernel,high region will only exist in high memory, crashkernel,low
region only exists in low memory region. I made a draft patch based on
this patchset to present what the code looks like.

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 58a0bb2c17f1..fd9d35e17a62 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -127,7 +127,7 @@ static int __init reserve_crashkernel_low(unsigned long long low_size)
  */
 static void __init reserve_crashkernel(void)
 {
-	unsigned long long crash_base, crash_size;
+	unsigned long long crash_base, crash_size, search_base;
 	unsigned long long crash_low_size = 0;
 	unsigned long long crash_max = CRASH_ADDR_LOW_MAX;
 	char *cmdline = boot_command_line;
@@ -155,6 +155,7 @@ static void __init reserve_crashkernel(void)
 		else if (ret)
 			return;
 
+		search_base = CRASH_ADDR_LOW_MAX;
 		crash_max = CRASH_ADDR_HIGH_MAX;
 	} else if (ret || !crash_size) {
 		/* The specified value is invalid */
@@ -166,12 +167,13 @@ static void __init reserve_crashkernel(void)
 	/* User specifies base address explicitly. */
 	if (crash_base) {
 		fixed_base = true;
+		search_base = crash_base;
 		crash_max = crash_base + crash_size;
 	}
 
 retry:
 	crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
-					       crash_base, crash_max);
+					       search_base, crash_max);
 	if (!crash_base) {
 		/*
 		 * If the first attempt was for low memory, fall back to
@@ -180,6 +182,7 @@ static void __init reserve_crashkernel(void)
 		 */
 		if (!fixed_base && (crash_max == CRASH_ADDR_LOW_MAX)) {
 			crash_max = CRASH_ADDR_HIGH_MAX;
+			search_base = CRASH_ADDR_LOW_MAX;
 			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
 			goto retry;
 		}
@@ -189,7 +192,7 @@ static void __init reserve_crashkernel(void)
 		return;
 	}
 
-	if ((crash_base > CRASH_ADDR_LOW_MAX - crash_low_size) &&
+	if ((crash_base > CRASH_ADDR_LOW_MAX) &&
 	     crash_low_size && reserve_crashkernel_low(crash_low_size)) {
 		memblock_phys_free(crash_base, crash_size);
 		return;


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
