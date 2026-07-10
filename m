Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28ED7C43458
	for <kexec@archiver.kernel.org>; Fri, 10 Jul 2026 07:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:Date:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3MvQlBKjkny8mMC2lU5kct7N4ZDfA+zPYCI7ZPzWCME=; b=k2khAGZYCzpRh8y+7401GuDBxH
	O3b9ODS3OKy/p5wC5IWlRLWcwM/lXwII0o6SHsUflfVTIxHKSXa1Jz+ctkE5zSQ+oPaWrlqmmPUxS
	ZsdF5/TS8/F/d1CM+/h/NBA7T5i+3A8ENfYU5fODl8vbavrcU3OftvrYlrqWsbHlTrRtrjqY8yW6J
	7zwOfSnlDq15wBUEllFDJ+iPrei9UEswlJnrmsReEx/qhcrP+/27k5SSPOr16JUR+Z7az3W+fypeO
	9Vk1bFIJ0PilxoTEQ+Xv6sMuYToVMygyuDz06fd7wjKFaHFCcNfAUxnvKTK56eY3ggjKsTwOdxVgo
	fD9qiDCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wi63W-00000004OHu-27K9;
	Fri, 10 Jul 2026 07:53:54 +0000
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wi63U-00000004OHR-05t2
	for kexec@lists.infradead.org;
	Fri, 10 Jul 2026 07:53:53 +0000
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-80cebd41372so8865117b3.3
        for <kexec@lists.infradead.org>; Fri, 10 Jul 2026 00:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783670031; x=1784274831; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3MvQlBKjkny8mMC2lU5kct7N4ZDfA+zPYCI7ZPzWCME=;
        b=p6ppKugvWLkmJV18YRvgNwWF1Ef54g8nRdXgd2w/+dcHplOXkYDwhiX1dqTqKHx37E
         URPy3DJIY0IqrOnO/H+XREO6sfgWDn55/JP0Yn7v/d8Lk/L6s5QXc7PuKWUkTCpnKunO
         oy4xEoLrjYovnQK0xQixoKAYRXlZc/mTqGy34qqyYGKOxGsze/V3izye+llxIvdvbtFw
         lqeMZKYvpvalAHO9nCezCGboWS4LTn5Hr6myclb+34nhg0qqqojVyOY/uN8elqtaP4em
         hzU+eCpSXegx1KT7TbdH19nz24zCdxqJHlGx9K9r6nMKUVVoz/kgmvWcEVimzOHGdvjK
         BOQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783670031; x=1784274831;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3MvQlBKjkny8mMC2lU5kct7N4ZDfA+zPYCI7ZPzWCME=;
        b=TFC34JPOP3KRaqY5x8Z4Y0k/j45Rivw4AIgu4089o+KHVSqTg4l90myFIEV8UjLNql
         e/3y9C8Uy0shXnDS+IVf3ykgpiieWnivzaimEvVushCEkbPuhg+Ls3TjKfEL3HSIUs1b
         gZuD2SGCxIc1AlKyzmxlKgOmk7N02gJzTd1mwm9dSN+U1YZdRiDp6yahWhuRLm5FBAO2
         l1pqhtQnOwlzb9BezdNWGeZAM0LSK1XgOE9jnHAkAheUec7H5dnyGR2RMUCcfLoeJfxC
         pVdFGraLNaSJj0DG1lKNjQW4ey/D83OOnTmu3B9nZHzMtf9eVgNWjeQAM/wdtATYxqKz
         26uQ==
X-Gm-Message-State: AOJu0YxUZnhVqIy0R2X0SpUyX3VDiUZ3ncQkhBky2jprtRCi8xPU4WGw
	TrmqqUHjDYJzDvXVXOKGNudU7YFtn0y1zBTQuqHlm2UANrCKJ+Ft42FU
X-Gm-Gg: AfdE7cmCGy/ZQ5qmvQGXjMm9fqFYWS+vWjPpK13gVZ/MGnT6hGxPiQ4m6obXYe5lm3B
	ERaLwrmFNm90u+2eolkTqcM2ZSYDsLm7TSRUo1Z2nteYKRxYQptCSMI9HR9NaM9/I6bEW/TE2F+
	xUTeAfXQxgBh6dh6/ZfDLfeGHK91Ii2qOlnv32mZSYa73bj9Xcgp93OHfgk928eBXgtbqw0fOBk
	s2krZQvtNDnHq0rT1glGG+kL6I4wsIJw4ACkwuXUEHvH/C/aZYj9HO/jgTw8K84eJXmG+MayKXv
	CYssG0TVFm7jP2PTx7aFGtkfGk2aC0uLpFK0U1ul3QA+fY8FnesSjhUijYFW14v5KMvwFUODk3+
	QQ1DMLOrxplmsv2Idd7hEociH9FrxjJieZexy1W5vUG03juybqh/5vl7vQaHVl/hUUHP01+4B9o
	khX4P32gl+0JnUaxiZsFN55hx8C7hXX6Iwc2zC6E6s/A==
X-Received: by 2002:a05:690c:13:b0:7dc:aa85:5c67 with SMTP id 00721157ae682-81dbbe375afmr77927097b3.11.1783670030838;
        Fri, 10 Jul 2026 00:53:50 -0700 (PDT)
Received: from localhost (tpcc3a204.netvigator.com. [219.76.18.204])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81e6c212f14sm39077757b3.42.2026.07.10.00.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 00:53:50 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
X-Google-Original-From: Coiby Xu <Coiby.Xu@gmail.com>
Date: Fri, 10 Jul 2026 15:53:34 +0800
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: kexec@lists.infradead.org, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <baoquan.he@linux.dev>, Dave Young <ruirui.yang@linux.dev>, 
	Mike Rapoport <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Coiby Xu <coxu@redhat.com>, 
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 7/9] crash_dump: Improve readability of
 config_keys_restore_store
Message-ID: <alBIbR657paotvMT@Rk>
References: <20260501234342.2518281-1-coiby.xu@gmail.com>
 <20260501234342.2518281-8-coiby.xu@gmail.com>
 <23784559-1e11-4e14-bf23-6ffebd7b2d30@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <23784559-1e11-4e14-bf23-6ffebd7b2d30@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260710_005352_062685_AA554821 
X-CRM114-Status: GOOD (  14.93  )
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

On Wed, May 06, 2026 at 08:03:44PM +0530, Sourabh Jain wrote:
>
>
>On 02/05/26 05:13, Coiby Xu wrote:
>>config_keys_restore_store currently doesn't validate the user input
>>before restoring dm-crypt keys. Although it's not necessary for the case
>>of vmcore dumping, it's better to do it for the sake of consistency and
>>code readability. Also check the return code of
>>restore_dm_crypt_keys_to_thread_keyring.
>>
>>Fixes: 62f17d9df692 ("crash_dump: retrieve dm crypt keys in kdump kernel")
>>Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
>>---
>>  kernel/crash_dump_dm_crypt.c | 10 +++++++---
>>  1 file changed, 7 insertions(+), 3 deletions(-)
>>
>>diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
>>index 545d712428d3..36e51807d94f 100644
>>--- a/kernel/crash_dump_dm_crypt.c
>>+++ b/kernel/crash_dump_dm_crypt.c
>>@@ -358,12 +358,16 @@ static ssize_t config_keys_restore_show(struct config_item *item, char *page)
>>  static ssize_t config_keys_restore_store(struct config_item *item,
>>  					  const char *page, size_t count)
>>  {
>>-	if (!restore)
>>-		restore_dm_crypt_keys_to_thread_keyring();
>>+	bool val;
>>-	if (kstrtobool(page, &restore))
>>+	if (kstrtobool(page, &val))
>>  		return -EINVAL;
>>+	if (val && !restore) {
>>+		if (!restore_dm_crypt_keys_to_thread_keyring())
>>+			restore = true;
>>+	}
>
>Nit:
>I think it would be good to warn the user if they try to
>restore it when it has already been restored.

Thanks for the suggestion! I'll apply it to v3.

>
>
>- Sourabh Jain
>>+
>>  	return count;
>>  }
>

-- 
Best regards,
Coiby

