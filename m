Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E766EC021A0
	for <kexec@archiver.kernel.org>; Tue, 11 Feb 2025 07:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:
	Date:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w5toRi1o9VCJfRHONe3YCmWk3W7ZGM55kfa06L/QV90=; b=QrQBr7A0ZFPl+uqND8oKtRZtpC
	nVnA2YUZtZq2hBeoEwa7LJGsVF4BN+J9sWPXM62F5BcsQI6ZUXFsnu25CQQGudQtUS7L1GW+XywmW
	hw0iq+Nuest++cYl2EBrU0uw7rGxqSD0zGMzlMlfW+/NO8LxCTydNFsrThMBlfq4ze+JriweRFJIt
	QbU/fUpOG/UAjE1IDG2YdNEZi0TBymIKKkPn2AgmGwahOy+rKwkWF2eyHnSwf/zHHciAEFQIhY4gT
	Gi/5yfkqA4D8v86SvZtVYCdo5TrRTSr1xDBO0/OqkOY83b0NbLkdW6mSomwzg3NpPNyoITIF4FVyp
	yTp+i6Bg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1thkZr-00000002ocY-2yZC;
	Tue, 11 Feb 2025 07:21:03 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1thkZp-00000002obC-2heq
	for kexec@lists.infradead.org;
	Tue, 11 Feb 2025 07:21:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739258459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w5toRi1o9VCJfRHONe3YCmWk3W7ZGM55kfa06L/QV90=;
	b=JISsjsKAi2r91p/zKjT875eN8VWY2AehIZzGq5zhemyTMv3rY+iPcYPwyA2EGuwdOK0xna
	MYXcRaqm8Fo2YrFHSLBSe5mL6DOJ2lxGqa+Jvp6RBQsoivb4JTmuyvCzDiave1a/HeyEoC
	kRiOHjUZCT6QdACjVy8CoTZ5ibU72S8=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-1Qm_ZDzDM-24u-75eTKo-w-1; Tue, 11 Feb 2025 02:20:57 -0500
X-MC-Unique: 1Qm_ZDzDM-24u-75eTKo-w-1
X-Mimecast-MFC-AGG-ID: 1Qm_ZDzDM-24u-75eTKo-w
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2fa562cc226so5116151a91.0
        for <kexec@lists.infradead.org>; Mon, 10 Feb 2025 23:20:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739258455; x=1739863255;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w5toRi1o9VCJfRHONe3YCmWk3W7ZGM55kfa06L/QV90=;
        b=e7ZIQS7UMEYCgwXy1RslSzXAKEjwKkoARQVj/8egeD2KCidkUgSm9U++DQyhMJSEco
         AckhHYie4Ctq2bChFIjMKHsmMFCbuywu39QdXjypn+tVU+XcTuFBPUsD1w2H64oC32oH
         rxz4ARaZ8yJjgIVzJV/XJarvGeBeF49+2wU5H5Bt8xc+JT4Y0hK3WQKh5cYdus4L5kHy
         iivbbMxh8TzJxpEOtYrzzWjShL6y8mZh3SRDB/mMra6jGkcXwRvCx7u9vIY2unFjUcnR
         DgurKRRTnfkyLMxEslLvS3dRSeB692XQxJgZnwVUrLySgD1zQ6uqflnpW4BQVme/Hp1/
         mMUw==
X-Gm-Message-State: AOJu0YyYHioExUdjFafz0DxX9DtzEDaqa+Xhkw2xUtd+xkEyZfsrdn2Q
	unAivo0PO3WE1QskiVtpI+AnOahnlSb9evyeXij6HMqnsxG3WXUe7T1oYWI7b3FJiBU+un6UdMy
	NHX74gYwv5BMYiZ22Mh9PWhD3z1ttc07aVfUhUhpUPnXJ1CT3IYcgNVY0Ksb2opg67HH1xbpHR8
	6NK5veDks71scjsa2THXWAHnME1MQja4rZja7vGUqgxA==
X-Gm-Gg: ASbGncutvKtqtxvf3eK6Lifk5b6HCC/UDC/nopdenKZRC9KX5xrxO8jDZxuEVkAVXsp
	iYb4G4y9R3aKlmmg1ZmDCl5Oi08p8WOGNoMrwqDKBRZu0uHV3ts2CEt6/V+1B+8wT9fcGRDxzZd
	jD3vmRX1veATs3STxlX0lhmXoUfv4lNDPDr/ykT1c99bcUSAsBB+DJx5tsdlFdqvKzW8bkF9e8R
	c7HW7tWLhjetXEA2VxnxgcTw5yUIcqZNi1dVVSuvWGAFyqEOtSmvlfC7QXWAO43WGUTG3c0
X-Received: by 2002:a05:6a00:7491:b0:730:75b1:7218 with SMTP id d2e1a72fcca58-73075b17593mr12799594b3a.16.1739258455475;
        Mon, 10 Feb 2025 23:20:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH6Fwz2x0GELQ8GGw0fhSFbS0p91upZHh16RbU7/zTKw4F9UcJN7QM5FcqsYQYL0ELzwjW2dg==
X-Received: by 2002:a05:6a00:7491:b0:730:75b1:7218 with SMTP id d2e1a72fcca58-73075b17593mr12799570b3a.16.1739258454910;
        Mon, 10 Feb 2025 23:20:54 -0800 (PST)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7308a05f754sm3610073b3a.153.2025.02.10.23.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 23:20:54 -0800 (PST)
Date: Tue, 11 Feb 2025 15:18:09 +0800
From: Coiby Xu <coxu@redhat.com>
To: kexec@lists.infradead.org, Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Subject: Re: [PATCH] makedumpfile: fix gcc-15 compiling error: too many
 arguments to function eppic_init
Message-ID: <zumzzlgu4t235ms6lvwckc24oseb5tg7hx275l74llq2lhkdiz@d3l5cis6f53n>
References: <20250123094710.212511-1-coxu@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20250123094710.212511-1-coxu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kpgdP4Sq7JQ1yPWCwYzIr74R3wZhOr1_fNWqfs0tfhc_1739258456
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250210_232101_748752_530B872A 
X-CRM114-Status: GOOD (  14.95  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hi Kazuhito,

In case you miss this patch because I forgot to prefix the email subject
with "makedumpfile".

On Thu, Jan 23, 2025 at 05:47:10PM +0800, Coiby Xu wrote:
>Resolves: https://bugzilla.redhat.com/show_bug.cgi?id=2340813
>
>When building makekdumpfile against gcc-15, the following error is
                ^^^^^^^^^^^^^
                makedumpfile
Oh, there is a typo. Please help me fix it if you are going to merge the
patch. Thanks!

>shown,
>
>    erase_info.c: In function ‘process_eppic_file’:
>    erase_info.c:2226:13: error: too many arguments to function ‘eppic_init’; expected 0, have 1
>     2226 |         if (eppic_init(&eppic_cb)) {
>          |             ^~~~~~~~~~ ~~~~~~~~~
>    make: *** [Makefile:109: erase_info.o] Error 1
>
>Signed-off-by: Coiby Xu <coxu@redhat.com>
>---
> erase_info.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/erase_info.c b/erase_info.c
>index cbe1681..af6bfae 100644
>--- a/erase_info.c
>+++ b/erase_info.c
>@@ -2192,7 +2192,7 @@ process_eppic_file(char *name_config)
> {
> 	void *handle;
> 	void (*eppic_load)(char *), (*eppic_unload)(char *);
>-	int (*eppic_init)();
>+	int (*eppic_init)(struct call_back *);
>
> 	/*
> 	 * Dynamically load the eppic_makedumpfile.so library.
>-- 
>2.48.1
>

-- 
Best regards,
Coiby


