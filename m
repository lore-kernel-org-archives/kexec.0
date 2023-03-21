Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D54B2C74A5B
	for <kexec@archiver.kernel.org>; Tue, 21 Mar 2023 19:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LhpnpgWRb4P9ORLowuD3MDLK1ndl99kJM8S/cu1Tyws=; b=CqCBMkILnqd3WP
	p42qwS0GrFmiSGSR0ijfcdp6xQDktxgIDx6kV36E0uHjEXlgfoQsPriZ+mVDbrmVQqvsu76y3mrK1
	X1ozbAs0WxdcTU9S2UI9mBLKixTDejqOq0sJ2lN6hgRUUA53Kpa+XVUcuKq+tAsxkqpcmnEPniv2c
	slDXpo2nphgEdo08CcOZktpTtmVuyianrAEjTpBTW2ceReubxCsfHALNjb2bzVJoYq+bUv6wCiofI
	Dje8+f8WsoH/yH0Eup3NXQTSMfB+knnL5mYgMLlci59NvsDV1lgdEbTKO5Uq38OkUOfp9ITMkw6cv
	siBhBvEJRz8MFFCyDf2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pehiZ-00DUbo-0U;
	Tue, 21 Mar 2023 19:32:23 +0000
Received: from mail-io1-xd2b.google.com ([2607:f8b0:4864:20::d2b])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pehiV-00DUZv-2s
	for kexec@lists.infradead.org;
	Tue, 21 Mar 2023 19:32:21 +0000
Received: by mail-io1-xd2b.google.com with SMTP id f14so7452004iow.5
        for <kexec@lists.infradead.org>; Tue, 21 Mar 2023 12:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1679427138;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7CeJzgGGkpz4OJNP+n2r4VhZEuuVOgz0h28luVhwWvM=;
        b=onBLdjuFW4OF9Ht5Rs2OEMX4aFQHB3mb67rib8Ag91iE4T2V0mEOeVtnbO60FtKxJi
         L1ZVDAdXzIBGc8uzGY9zUbtJqMNQ/JEzGufLkjl4q2W4gCNgOaaDnO/8rDzVvhIyKBt8
         zfAWpBfk9kKdRInXFn5Ve4KJNMfcDDXrl+//pEDel/TULKnCiMCBbg4jQY6Sg4G9Z2JT
         ctXDOrQLsenp00LY2dxVE1Z7BeOlwMY7psuC5OpAf1FTAsRMlhzt3MGbKFWtgA/OolIb
         ajafD0Eh3TgzjUbHPvPmc2uSjgk8UiukZdu23QCWLJP9yhMVywGUtmMI/zSwHNtcm6zu
         gDMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679427138;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7CeJzgGGkpz4OJNP+n2r4VhZEuuVOgz0h28luVhwWvM=;
        b=PtJcDGLfaqY2CnCBXoqGHltlesFV2/BQU3TYoFdk9Wk2mvp93SlXRFGbzJKUPzsZgQ
         49kca+DDnL7H6YH6xZeHvpSmFbPf6nPPn6JZeWSrP9r50elekFIZkzw2etO3XgEqr6Qq
         aIJxiPYtp1h+nPm6E3hX8jcnQXP60ArsiAPFvfhqgaTwIOD6hxMKo8DEqZxw2N5pvdTS
         Qd3dIjW532UwrRqa4Ja0XIwR63ntaMzQNUZEq+HYCs3WQyuGF2HKtt9zBO9JH2R0Lae1
         hlvIUVyknTl76Np/5apD+CJSLZHJer5NDjN5cIZc69RqJ2R2d761M1wJcoBsiWNI9Gdi
         FZXg==
X-Gm-Message-State: AO0yUKWEkdKmM9kcmF5b1qdcCWeZ2TRLd2kPh66m4p3yEGGJGR/Yrzst
	pN2ePfYuEV4JZSV7UermURlh4A==
X-Google-Smtp-Source: AK7set+phMYJWl6sgVT+AVfG9ZZk7GsfTnjNYpV3+LVic3XR8FeoqngvOFzznh2XdWllptC2fYtjOQ==
X-Received: by 2002:a6b:5802:0:b0:758:5653:353a with SMTP id m2-20020a6b5802000000b007585653353amr1487525iob.0.1679427137979;
        Tue, 21 Mar 2023 12:32:17 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id j189-20020a0263c6000000b0039deb26853csm4495686jac.10.2023.03.21.12.32.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 12:32:17 -0700 (PDT)
Message-ID: <3fcad89a-77ad-3369-cd8c-88a223758173@kernel.dk>
Date: Tue, 21 Mar 2023 13:32:16 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [GIT PULL] keys: Miscellaneous fixes/changes
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>,
 Bharath SM <bharathsm@microsoft.com>, Shyam Prasad N
 <nspmangalore@gmail.com>, Steve French <smfrench@gmail.com>,
 Robbie Harwood <rharwood@redhat.com>, Eric Biederman
 <ebiederm@xmission.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 keyrings@vger.kernel.org, linux-cifs@vger.kernel.org,
 linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <2851036.1679417029@warthog.procyon.org.uk>
 <CAHk-=wh1b0r+5SnwWedx=J4aZhRif1HLN_moxEG9Jzy23S6QUA@mail.gmail.com>
 <8d532de2-bf3a-dee4-1cad-e11714e914d0@kernel.dk>
 <CAHk-=wi2yeuwCxvB18=AWG+YKnMgd28WGkHFMqTyMA=59cw3rg@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHk-=wi2yeuwCxvB18=AWG+YKnMgd28WGkHFMqTyMA=59cw3rg@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230321_123219_930466_7AF954CF 
X-CRM114-Status: GOOD (  14.52  )
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

On 3/21/23 1:21?PM, Linus Torvalds wrote:
> On Tue, Mar 21, 2023 at 12:16?PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> I haven't seen the patch yet as it hasn't been pushed,
> 
> Well, it went out a couple of minutes before your email, so it's out now.

Yep I see it now, looks as expected.

>> It may make sense to add some debug check for
>> PF_KTHREAD having TIF_NOTIFY_RESUME set, or task_work pending for that
>> matter, as that is generally not workable without doing something to
>> handle it explicitly.
> 
> Yeah, I guess we could have some generic check for that. I'm not sure
> where it would be. Scheduler?

Off the top of my head, two options, both in kernel/sched/core.c:

1) Add it to schedule_debug()

2) Add it to sched_submit_work(), adding PF_KTHREAD to the flags checked
   for PF_IO_WORKER | PF_WQ_WORKER to avoid adding any extra fast-path
   overhead.

Alternatively, I guess it could go in kthread_exit() as well. But for
workloads with a persistent kthread that doesn't really go away, that
won't catch it.

-- 
Jens Axboe


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
