Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5CA7C433EF
	for <kexec@archiver.kernel.org>; Thu, 16 Jun 2022 01:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y4+KTjuDnXlzb4oddrWJpybBAXGcm9mB25G/KiXZi/4=; b=hmk5HOf7IRdHG+p/9jVyEv/7nD
	iRZckIShWZtKtPeKg/bG3FavwZs/LLxuxI2fjcrgf6UjGgr1hbt9kymL56YMK1XZn/RSIfTIy/HP7
	CZOeJY7RSGAShJzyLbFCHXvzarc4yPutOkZ7IZuIvaN3Ao7Y39QRSQPZJg4vCGYKX4A3lHHYYoZ/o
	NCTq5ZHmcYWqldO/1Hb/j3D8KYHRzHUT/VnebDIYBP4FKdPUYXUZ0KH049/N3pPixvRWB7Rxrh9B2
	StjYdpZICkMsiM8dSImXvUX4TjNOBpJcioFkiQs0TAzVxIq2v4VH3yWSG8hpwpGsLNhLmNSax1ouA
	Y2ndljAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1eeb-00HRp4-Q8; Thu, 16 Jun 2022 01:50:37 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1eeJ-00HRh8-Mm
	for kexec@lists.infradead.org; Thu, 16 Jun 2022 01:50:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1655344218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mfnj3kbt/mcFDC8cZyL7mlTMEbSGwlIrcY0mmV2SXko=;
	b=KYlM+mZEb0CuzIF1s6N6ZJ4SpeJBjb7iwjGbkDs7Cf1MM0oG0g8j9lTsf+klLDxOHfbXze
	frvzMTI2Kqj05i9kHMAs+6KbtJVQ6erqXkP6S0pyR1pzTmZCFTFr3DEqcq/sW1NNyScNHa
	EhTcmXxqaHDpcTIa0PSyLa7y4qUvXKA=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-339-tAi4_T39NeK6KEZPxLHBNw-1; Wed, 15 Jun 2022 21:50:15 -0400
X-MC-Unique: tAi4_T39NeK6KEZPxLHBNw-1
Received: by mail-pg1-f198.google.com with SMTP id h190-20020a636cc7000000b003fd5d5452cfso7336721pgc.8
        for <kexec@lists.infradead.org>; Wed, 15 Jun 2022 18:50:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Mfnj3kbt/mcFDC8cZyL7mlTMEbSGwlIrcY0mmV2SXko=;
        b=yqZfjuTJDP5yohRXxNlva6nXmRYqkQzYGmTtoHttQ/00U4d3hQ7f7smJtZcpfWNGfR
         57DDO29iMSOJYSkfDI/6dGNg2hmCQ7MwiVZfAaTAwujzQW413+/abZRceRE3My+SrDSB
         p98nfANT6QqT0wes6/Ab/5hGFzhHVRxjwucPwQwBZ0YdkrALTrKmgjp0wHT++VNoKSVQ
         awRTJOckSe2dnr1uUuuZ13vAQtiYbyzNtq9ltFUO+T5iECYljXJJZhMBKGsc4TUGQ+cd
         Lqx8uCsDXH2QShEYEcAl4hEDwsuoN/my6R4kOUUqXEhaXMVGZww5FbS/eCchZiAJO370
         Pj4w==
X-Gm-Message-State: AJIora979zaN4xL+a3c17JWQ1BT05IqnSiEmj780RE6VlmRAWv6EXzxV
	c3nWBs2AVvkx5UmDwu5ygbklEgHP9a2wiXhOYYPgA2VXwE1A1O4MXKve43K2pdQZD1DS8jSmnd3
	SRRTNolxUf4tAIBjQC4Pi
X-Received: by 2002:a63:1e1d:0:b0:401:a251:767e with SMTP id e29-20020a631e1d000000b00401a251767emr2357348pge.26.1655344214529;
        Wed, 15 Jun 2022 18:50:14 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sEarbrrVxjiXB2Z4yglIOjHVgXmEDqqN6H9xo+0t/vhcHtsIxwYcmDDYcM0diomczP0LPViQ==
X-Received: by 2002:a63:1e1d:0:b0:401:a251:767e with SMTP id e29-20020a631e1d000000b00401a251767emr2357317pge.26.1655344214223;
        Wed, 15 Jun 2022 18:50:14 -0700 (PDT)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id k16-20020a17090aaa1000b001e3351cb7fbsm2464671pjq.28.2022.06.15.18.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 18:50:13 -0700 (PDT)
Date: Thu, 16 Jun 2022 09:46:50 +0800
From: Coiby Xu <coxu@redhat.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Baoquan He <bhe@redhat.com>,
	Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>,
	Heiko Carstens <hca@linux.ibm.com>, akpm@linux-foundation.org,
	kexec@lists.infradead.org, keyrings@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Dave Young <dyoung@redhat.com>, Will Deacon <will@kernel.org>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Chun-Yi Lee <jlee@suse.com>, stable@vger.kernel.org,
	Philipp Rudo <prudo@linux.ibm.com>,
	linux-security-module@vger.kernel.org,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	"open list:S390" <linux-s390@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	linux-integrity <linux-integrity@vger.kernel.org>,
	Jarkko Sakkinen <jarkko@kernel.org>
Subject: Re: [PATCH v8 4/4] kexec, KEYS, s390: Make use of built-in and
 secondary keyring for signature verification
Message-ID: <20220616014650.wd6saed72breqeyb@Rk>
References: <20220512070123.29486-1-coxu@redhat.com>
 <20220512070123.29486-5-coxu@redhat.com>
 <YoTYm6Fo1vBUuJGu@osiris>
 <20220519003902.GE156677@MiWiFi-R3L-srv>
 <c47299b899da4ad4b6d3ad637022ad82c8ed6ed2.camel@linux.ibm.com>
 <YoZSl84aJYTscgfO@MiWiFi-R3L-srv>
 <20220519171134.GN163591@kunlun.suse.cz>
MIME-Version: 1.0
In-Reply-To: <20220519171134.GN163591@kunlun.suse.cz>
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=coxu@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220615_185020_769434_3469083E 
X-CRM114-Status: GOOD (  18.55  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hi Mimi,

>> >
>> > This patch set could probably go through KEYS/KEYRINGS_INTEGRITY, but
>> > it's kind of late to be asking.  Has it been in linux-next?  Should I
>> > assume this patch set has been fully tested or can we get some "tags"?
>>
[...]
>>
>> IIRC, Coiby has tested it on x86_64/arm64, not sure if he took test on
>> s390. No, this hasn't been in linux-next.

For arm64, recently I did a new round of test and the patches works as
expected,
   1. Build 5.19.0-rc2
   2. generate keys and add them to .secondary_trusted_keys, MOK, UEFI
      db; 
   3. sign different kernel images with different keys including keys
      from .builtin_trusted_key, .secondary_trusted_keys keyring, UEFI db
      key and MOK key 
   4. Without lockdown, all kernel images can be kexec'ed; with lockdown
      enabled, only the kernel image signed by the key from
      .builtin_trusted_key can be kexec'ed

Then I build a new kernel with the patches applied and confirm all
kernel images can be kexec'ed.

>
>I used the s390 code on powerpc and there it did not work because the
>built-in key was needed to verify the kernel.
>
>I did not really run this on s390, only ported the fix I needed on
>powerpc back to s390.

For 390, I commented out the code that skips signature verification
when secure boot is not enabled since I couldn't find a machine that
supports secure boot and confirm before applying the patch, kernel
images signed by keys from .builtin_trusted_key, .secondary_trusted_keys
couldn't be kexec'ed when lockdown is enabled; after applying the
patch, those kernel images could be kexec'ed. 

>
>Thanks
>
>Michal
>

-- 
Best regards,
Coiby


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
