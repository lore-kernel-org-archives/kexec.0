Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E53C4C43334
	for <kexec@archiver.kernel.org>; Mon, 11 Jul 2022 07:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1s+D5ax+Fpr8rehHuE5dRN7pBJp99V7z1JKEp13ab+g=; b=kw3JW/U+fNOqlL
	SivtXPSF+ptd8x1Ksk4sTlDbRorccMiTl+1FVRNPdft2jcZsv51cUGHxbnaOAzgPoUMMD9pBHNK83
	YKRenbFHRzN9dPcUtaz8qhSlfEGWdLSTmYnWIWQonHUkC8wMht3N0SAPVGhuZ3/PcHgKW/Mg/f2bu
	eqR/GII5w1TRIcFgJ8qmLFFnUtj3gLHbxHMA7Qr3xGlGLPvRP3y27FIRc4XGUYA99VWSwdtB0JD9S
	9mpFkLh49n+U9CgCwNx8HDDHWkKccykISSvfghTB+KE3baCWHVXPwCB+vWqr1J3gG6a5mlcr9hpHt
	h+blurVLXwsiDcJ9uP4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oAoBD-00GyKV-Sf; Mon, 11 Jul 2022 07:50:07 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oAoB8-00GyHR-3P
	for kexec@lists.infradead.org; Mon, 11 Jul 2022 07:50:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1657525797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=65+qN8d8sGZSpzbvLfg3emL2uyMu+GmRHRjSzDdv/js=;
	b=EYhd6Q6zBFIFTd4b7xVjXNS3/abSbOj8tRO+IikPqpCV2UKB+NpkIRidi7pjWqpbHurYB6
	AFvUER3AF4hFJQBUPzqrAG3IBWXEHz4gFBEzW3v9rgy8rAj7OaNi+8+p/QypOVLSDeI2pq
	cYqzYd/aVm9aW3u/q/hF534h3au3s/k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-630-PcKH02_GNmyyAY5EzywamA-1; Mon, 11 Jul 2022 03:49:55 -0400
X-MC-Unique: PcKH02_GNmyyAY5EzywamA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8D5D6804197;
	Mon, 11 Jul 2022 07:49:55 +0000 (UTC)
Received: from localhost (ovpn-12-204.pek2.redhat.com [10.72.12.204])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E0E9140CF8EA;
	Mon, 11 Jul 2022 07:49:54 +0000 (UTC)
Date: Mon, 11 Jul 2022 15:49:51 +0800
From: Baoquan He <bhe@redhat.com>
To: Jianglei Nie <niejianglei2021@163.com>
Cc: vgoyal@redhat.com, dyoung@redhat.com, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3] proc/vmcore: fix potential memory leak in
 vmcore_init()
Message-ID: <YsvWHwrltqqAb12h@MiWiFi-R3L-srv>
References: <20220711073449.2319585-1-niejianglei2021@163.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220711073449.2319585-1-niejianglei2021@163.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220711_005002_260564_AEC0D4D3 
X-CRM114-Status: GOOD (  19.59  )
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

On 07/11/22 at 03:34pm, Jianglei Nie wrote:
> elfcorehdr_alloc() allocates a memory chunk for elfcorehdr_addr with
> kzalloc(). If is_vmcore_usable() returns false, elfcorehdr_addr is a
> predefined value. If parse_crash_elf_headers() occurs some error and
> returns a negetive value, the elfcorehdr_addr should be released with
> elfcorehdr_free().
> 
> We can fix by calling elfcorehdr_free() when parse_crash_elf_headers()
> fails.
> 
> Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
> ---
>  fs/proc/vmcore.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
> index 4eaeb645e759..125efe63f281 100644
> --- a/fs/proc/vmcore.c
> +++ b/fs/proc/vmcore.c
> @@ -1569,7 +1569,7 @@ static int __init vmcore_init(void)
>  	rc = parse_crash_elf_headers();
>  	if (rc) {
>  		pr_warn("Kdump: vmcore not initialized\n");
> -		return rc;
> +		goto fail;

Sigh. Why don't you copy my suggested code directly?

>  	}
>  	elfcorehdr_free(elfcorehdr_addr);

Remove above line.

>  	elfcorehdr_addr = ELFCORE_ADDR_ERR;
> @@ -1578,6 +1578,9 @@ static int __init vmcore_init(void)
>  	if (proc_vmcore)
>  		proc_vmcore->size = vmcore_size;
>  	return 0;

Remove above line too.

> +fail:
> +	elfcorehdr_free(elfcorehdr_addr);
> +	return rc;
>  }
>  fs_initcall(vmcore_init);
>  
> -- 
> 2.25.1
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
