Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12F3ACFC264
	for <kexec@archiver.kernel.org>; Tue, 15 Oct 2024 03:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=D93A4z3a8aVfoJPt2kAcC/NDmSvJkn0GmMsCjSDmWtg=; b=lLfF2XEmqoFlSR
	NzoLUjE7JRgRKIebtDIXw9k2OjRAWIKyqQZvz7nVcUPVnaSW8t65RgDN34gMOip8SwCFNOYdRwUFU
	S8kva5NOqtL0i1LReG66WcRiLXioCDLXg6n/vGXVuc8NOXaZz3fGt1O3faX3jUbH4UW2Z70PQDe6B
	1CafIScUo7TlZxwpl2MB8tiF5lY9mV/ZFPRauKJRfoGz+vJYaYFlS26w36JdT8QYoPvYRKE7VJQg5
	ZCXCTvXQ5GLS5UTY29PZ59wtXQeHP13mNvHlM7ijKiO/acQSfLN3XaOuj7swYuO9p1CZfudJJQMAx
	Na7SfWCWfa96gUSzjT7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t0YYE-000000070dn-2qcq;
	Tue, 15 Oct 2024 03:48:50 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0YWn-000000070T8-1CuP
	for kexec@lists.infradead.org;
	Tue, 15 Oct 2024 03:47:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728964039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8dfHwMGJbsawxs7janPhhHUV4M9LSvsDgTpkLW3bePY=;
	b=YDHsw/afCGcmz6dWioG3gh2275SV0jhzpqF2GvzFQETawUogJK3bu8IfYXuCvUpV7yOUXn
	SyFL3mBCROEIw9K1chhUgXV5JyTWH1NLQ7p+kYYqvQBEqJgjDpACaHJ39cJsXtA9VB9+hk
	k0buLSLY4C/n7w0U6raXD35d0PABebc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-544-P6e0lCY_PJuFC2ui5jvLjg-1; Mon,
 14 Oct 2024 23:47:15 -0400
X-MC-Unique: P6e0lCY_PJuFC2ui5jvLjg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CC24A1956083;
	Tue, 15 Oct 2024 03:47:11 +0000 (UTC)
Received: from localhost (unknown [10.72.112.16])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5FA781956089;
	Tue, 15 Oct 2024 03:47:08 +0000 (UTC)
Date: Tue, 15 Oct 2024 11:47:04 +0800
From: Baoquan He <bhe@redhat.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	David Hildenbrand <david@redhat.com>,
	Greg Marsden <greg.marsden@oracle.com>,
	Ivan Ivanov <ivan.ivanov@suse.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Miroslav Benes <mbenes@suse.cz>, Will Deacon <will@kernel.org>,
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v1 19/57] crash: Remove PAGE_SIZE compile-time
 constant assumption
Message-ID: <Zw3luHGG3LqHge2m@MiWiFi-R3L-srv>
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241014105912.3207374-1-ryan.roberts@arm.com>
 <20241014105912.3207374-19-ryan.roberts@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241014105912.3207374-19-ryan.roberts@arm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241014_204721_402880_83A9052F 
X-CRM114-Status: GOOD (  20.62  )
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

On 10/14/24 at 11:58am, Ryan Roberts wrote:
> To prepare for supporting boot-time page size selection, refactor code
> to remove assumptions about PAGE_SIZE being compile-time constant. Code
> intended to be equivalent when compile-time page size is active.
> 
> Updated BUILD_BUG_ON() to test against limit.
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
> 
> ***NOTE***
> Any confused maintainers may want to read the cover note here for context:
> https://lore.kernel.org/all/20241014105514.3206191-1-ryan.roberts@arm.com/
> 
>  kernel/crash_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 63cf89393c6eb..978c600a47ac8 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -465,7 +465,7 @@ static int __init crash_notes_memory_init(void)
>  	 * Break compile if size is bigger than PAGE_SIZE since crash_notes
>  	 * definitely will be in 2 pages with that.
>  	 */
> -	BUILD_BUG_ON(size > PAGE_SIZE);
> +	BUILD_BUG_ON(size > PAGE_SIZE_MIN);

This should be OK. While one thing which could happen is if selected size
is 64K, PAGE_SIZE_MIN is 4K, it will issue a false-positive warning when
compiling while actual it's not a problem during running. Not sure if
that could happen on arm64. Anyway, we can check the crash_notes to get
why it's so big when it really happens. So,

Acked-by: Baoquan He <bhe@redhat.com>

>  
>  	crash_notes = __alloc_percpu(size, align);
>  	if (!crash_notes) {
> -- 
> 2.43.0
> 
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
