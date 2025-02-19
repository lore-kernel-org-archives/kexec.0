Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD30CC021AA
	for <kexec@archiver.kernel.org>; Wed, 19 Feb 2025 01:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=X+5XWp0um59Fxl7TDZoaRkQkliV3bJTEB0j6ktnOISg=; b=gCkd1f4kF9alH490eTUl1GAoub
	ou3/9rXF0x3dSfZCiBkYNt7Y0cVU3o28Dv5iZz43kq8509rv4BkPAUlW+jSf7ueA9FZnH6AsNDIWJ
	NVoGJUePXWrSdH0IHpI5JztdwpnEH/oa6iw5JEMFfMUSkVk5T0SnXsJ+Qc2wu3m2L4s2hr3SFJoHe
	c/qHa0GkrWYdxtwwW3FBqGFvRvUqQq6Pq/UCy494iCcu1b+UjcFAtWf4XVfOK5XbsH/14dNVCahdo
	EfYKNYwEwfdEQU+6VwaR78NCE0vEn6H4VzOEGz9D5bVq2YHDf+zuUvAgr4cnUuEaPU6k+tDpNpFc4
	jCc6N8WQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tkYlB-0000000AW81-1m2a;
	Wed, 19 Feb 2025 01:20:21 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tkYl8-0000000AW7U-46Kj
	for kexec@lists.infradead.org;
	Wed, 19 Feb 2025 01:20:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739928016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X+5XWp0um59Fxl7TDZoaRkQkliV3bJTEB0j6ktnOISg=;
	b=cYtIIGH339tfJNMKuHoEmJhTW/WrONHPHh2I8VF+iO2n5g7f97+YJzE2IF5BUnkYDGU4Je
	J8l16RfAczVUFed67XYTzoBJCS7jKYokHS1Kbw8X4A2eSDaNg+B6twKPEeTkO+03WKdoJV
	62GCKsBUhuE5ZBCcZT65lZECIxe2iTM=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-HBDdMTbTPKeiJZzs-320ng-1; Tue, 18 Feb 2025 20:20:15 -0500
X-MC-Unique: HBDdMTbTPKeiJZzs-320ng-1
X-Mimecast-MFC-AGG-ID: HBDdMTbTPKeiJZzs-320ng_1739928013
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-220ff7d7b67so87196355ad.2
        for <kexec@lists.infradead.org>; Tue, 18 Feb 2025 17:20:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739928013; x=1740532813;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X+5XWp0um59Fxl7TDZoaRkQkliV3bJTEB0j6ktnOISg=;
        b=ubE/Sy9+DYkBJGB8E8sHXkEPsHFL/9CQf/vXvM+Br/BxAy/MfjW7161pF98suEpEmS
         u0ksJ6IqZMMB1wT/SXbGpWDovtgjy9sAOMCOtRk82o1ccZZqtVkI4CvX9VEA0zXdBrep
         hYorGsaadS3nLFJjzGu0HRkJfGguyOSdvfT1KaSGVKN+49OQjjmQJUc+4iGqtrtm4QtP
         /aR8BayfUaEPOFOR9pazUu0ApJa9Et4XA0NWufsnaTprZB87m+zd7LEFmGtEz++83+pR
         hxspLMBv2SAiXRHIf+tJwYUcAWXdLEM1CTJtf9OdeJ9EQ60RrdDEgyLWvCtitoVc2vGw
         /BFA==
X-Gm-Message-State: AOJu0Yx56RgMGC5Qvi8lVzCga4O3YW54Tx6oLDbrEC0RC81443loVtaA
	gWiKBBGR53fz5Cm014ep1Vbnv/WeUPpvmQxKYR9tEzaXya7G9C1RXvdKfiiVdYf60VwMjyJXnyB
	ZdA+sAzDu5piaaIObYFWwCueBLdT72golGcXflhf72lWYPTOaUXHTRBCx3g5zPstnatqPxOc=
X-Gm-Gg: ASbGncvnoZ3EgH1HkyvHI+Lrd1am6gUpsqggTu6Ye9F6NuEax3v0mkgEG3NYgg2D+uY
	ecdXC5xnlrA9GvfUaKmt8AEhW5XCREYVaFKH86llAx5LFzpT4ebNK9zVxOAz86iSTSGE3q149AP
	i+LstR8q1S9Ys8YfZJroC30U4zJ17feRgnTF1MwwMLPWxNCddfmc/H6kBAjdQW1PRtUvgBOHJ8l
	6LIrt9Mj7tTvrPgruR6J9tI+uCFQKO1Z3z8Hj7QLzQRIaXxq78kp4eZCq4Pj15OzF99wRrB
X-Received: by 2002:a17:903:2291:b0:220:c8e2:5e30 with SMTP id d9443c01a7336-2211c5547a9mr179131495ad.46.1739928012777;
        Tue, 18 Feb 2025 17:20:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGtDEFHY9600PL37s9hDBrLYYqF/uJzEM8f7seSCghJtJT5TZcBl20qejcggTjPjZ3iwoFVVA==
X-Received: by 2002:a17:903:2291:b0:220:c8e2:5e30 with SMTP id d9443c01a7336-2211c5547a9mr179131075ad.46.1739928012382;
        Tue, 18 Feb 2025 17:20:12 -0800 (PST)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220e21d2453sm88998515ad.184.2025.02.18.17.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 17:20:11 -0800 (PST)
Date: Wed, 19 Feb 2025 09:15:08 +0800
From: Coiby Xu <coxu@redhat.com>
To: YAMAZAKI =?utf-8?B?TUFTQU1JVFNVKOWxseW0juOAgOecn+WFiSk=?= <m-yamazaki2@nec.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, 
	Kazuhito Hagio <k-hagio-ab@nec.com>
Subject: Re: [PATCH] makedumpfile: fix gcc-15 compiling error: too many
 arguments to function eppic_init
Message-ID: <l2babcmcsngmcwcbzfpxdctju4otuqb7vwiqavwlnulrddfpnk@blw3pn52ukmf>
References: <20250123094710.212511-1-coxu@redhat.com>
 <zumzzlgu4t235ms6lvwckc24oseb5tg7hx275l74llq2lhkdiz@d3l5cis6f53n>
 <TYWPR01MB10711AE8C0037FB3FD7D74F6CA2FA2@TYWPR01MB10711.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <TYWPR01MB10711AE8C0037FB3FD7D74F6CA2FA2@TYWPR01MB10711.jpnprd01.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lT0nTFydlzwESSRhqlgWfkUDFHH21mvrvJsXytAb_08_1739928013
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250218_172019_092313_00570B70 
X-CRM114-Status: GOOD (  17.25  )
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

On Tue, Feb 18, 2025 at 12:32:42PM +0000, YAMAZAKI MASAMITSU(山崎 真光) wrote:
>Hi Coiby,

Hi Masa,


>Oops. I'm so sorry. I will correct any typos found next.

No problem. Maybe I can also resend one version with typos corrected
next time.

>
>But, Thanks for finding this building error and fixing.
>When building makekdumpfile against gcc-14, not problem.
>However, certainly could not build using gcc-15.　Thanks!

Thanks for reviewing and merging the patch!

>
>Best regards,
>Masa
>
>-----Original Message-----
>From: kexec <kexec-bounces@lists.infradead.org> On Behalf Of Coiby Xu
>Sent: Tuesday, February 11, 2025 4:18 PM
>To: kexec@lists.infradead.org; Kazuhito Hagio <k-hagio@ab.jp.nec.com>
>Subject: Re: [PATCH] makedumpfile: fix gcc-15 compiling error: too many arguments to function eppic_init
>
>Hi Kazuhito,
>
>In case you miss this patch because I forgot to prefix the email subject
>with "makedumpfile".
>
>On Thu, Jan 23, 2025 at 05:47:10PM +0800, Coiby Xu wrote:
>>Resolves: https://bugzilla.redhat.com/show_bug.cgi?id=2340813
>>
>>When building makekdumpfile against gcc-15, the following error is
>                ^^^^^^^^^^^^^
>                makedumpfile
>Oh, there is a typo. Please help me fix it if you are going to merge the
>patch. Thanks!
>
>>shown,
>>
>>    erase_info.c: In function ‘process_eppic_file’:
>>    erase_info.c:2226:13: error: too many arguments to function ‘eppic_init’; expected 0, have 1
>>     2226 |         if (eppic_init(&eppic_cb)) {
>>          |             ^~~~~~~~~~ ~~~~~~~~~
>>    make: *** [Makefile:109: erase_info.o] Error 1
>>
>>Signed-off-by: Coiby Xu <coxu@redhat.com>
>>---
>> erase_info.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>>diff --git a/erase_info.c b/erase_info.c
>>index cbe1681..af6bfae 100644
>>--- a/erase_info.c
>>+++ b/erase_info.c
>>@@ -2192,7 +2192,7 @@ process_eppic_file(char *name_config)
>> {
>> 	void *handle;
>> 	void (*eppic_load)(char *), (*eppic_unload)(char *);
>>-	int (*eppic_init)();
>>+	int (*eppic_init)(struct call_back *);
>>
>> 	/*
>> 	 * Dynamically load the eppic_makedumpfile.so library.
>>--
>>2.48.1
>>
>
>-- 
>Best regards,
>Coiby
>



-- 
Best regards,
Coiby


