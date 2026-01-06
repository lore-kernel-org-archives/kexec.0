Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74C6CC47BC5
	for <kexec@archiver.kernel.org>; Tue,  6 Jan 2026 08:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V867c7UphVGnIeOy7W0Ae1g0VsKH1KFb8UYnFs0q7vQ=; b=4Kzzn+FvkD02Jo9gxu3ZCfbSTO
	XB50jUup9OsVWjYRW+l/z8E/09+DJZxOfiNjsz99+gDkO8lYA83We+TY12zLjWRTgnVx6NrAyh1TI
	c/5R1GKI4f2exXtqCI5gtzDlqWwYGd1VvqQDdrtGQwrMYXfL8YOh8CH4Q5e8xdEl/F6ib3qJCQLzT
	sexpnAITue/PG5tfbN88pakTSeHxCCB49VJhfSL17S8TG0Qfm/3t8xRYpKo7aFv0uWyQ5WE7+B1Uy
	3FnqrEuDpba9IT21wMwinPOMmzTtIR2zQmsVPG+ct5XVI9IIZseRoZPrURqJVriqlVKyFYZhhGW9p
	pEmrrLQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vd2h1-0000000CdOa-07KS;
	Tue, 06 Jan 2026 08:45:31 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vd2gy-0000000CdNN-1mfu
	for kexec@lists.infradead.org;
	Tue, 06 Jan 2026 08:45:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767689127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V867c7UphVGnIeOy7W0Ae1g0VsKH1KFb8UYnFs0q7vQ=;
	b=DnrVrbKYIhHQaXAiR4bCpMJCMS9rBtyNe/R5RkCCb4bUkWGFE5qIIVQ47U9Lihdc1t67Qk
	eN6rXSPzFu47S6P8A+ig5lg26ig98XDt3o76z1aDV6GEF5NjX5K/MV9Ps8iWKG+Tg23j4o
	LDIVr1v5mNhS7kG/5XPve8qfQKeozO8=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-Z8B_t0-oMB227JFE8x3aeg-1; Tue, 06 Jan 2026 03:45:24 -0500
X-MC-Unique: Z8B_t0-oMB227JFE8x3aeg-1
X-Mimecast-MFC-AGG-ID: Z8B_t0-oMB227JFE8x3aeg_1767689123
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-29f1450189eso8553935ad.1
        for <kexec@lists.infradead.org>; Tue, 06 Jan 2026 00:45:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767689123; x=1768293923;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V867c7UphVGnIeOy7W0Ae1g0VsKH1KFb8UYnFs0q7vQ=;
        b=Bne7hL10rXwj37N7VyKEpoTPCen50w1l2CNhbyAuuCfWFDEyHzjo6Hs62P9xNZiWpy
         4h1ZgnfzLutBY6nrIg85eM5Y4v6b4D4a4S+wSKLz9OqShSkV/FN7Lcy8Cgfpyawe+687
         KbqhYXduskYEb53sR7LjpCMHoNAbsLSZ6u9ZRhqYA5uSpCD/2sOrG3vY++2TUl89dTZ5
         6AI/JPjA6WXeHKNCkK3+YTDnWbEt+5fC6Z6LXdJBhinVD6mkKp0rJUnaK0N2IBM5t+lk
         Lau8ABVXfOZXhZHfpQR5aRa5VXeCgHaU9a9/xuMc+qGHQB0rUGtjubsayCTsYoPYvHp8
         TlAg==
X-Gm-Message-State: AOJu0Yw0xf9EoHkcVmcLStkc4g3A7eGTKIw7DtrZwyEClYFK3zFD7231
	kVLSnSXmoouzR7hJsTIUmpYmwQGjbryTo4fAquZXq7bP771aQogVinZP7DmDP0ONOrcpG3S16OD
	KlDFFgHo6d4ZlRUdcP4o+V4a78sfNiUhgopxZU/oZl5y1qkhldEeB8pzDR+06/g==
X-Gm-Gg: AY/fxX5kOW3suet5CoXKP2ljO7qgc6zGnuIfRcsZS8yNF2XivW0bE9qhdjaltmNN3P2
	5inS815JFFHkqkT3NmUtfV/DKoEwH+ebtkc15tS0/DhtTTFZCNWkHXQQR5IgeiTBoHLuEUJkkvx
	osnpFR39r0JsKVaj+lbj5OCielz9VUc/gbC9RoMLIOYLWlKWpUVvwkst86PP44bqdxcNdowhsPI
	Yv+57Nycjfv6L/xuHcYiyiR130k+AHvwS3EVwN1RfrseaKXeZwAos6Zc+mq4DyW5W/LPuMG1vPA
	XAbkmFZvNAAvrRaFz/O+5P/By7dIykFMyw/kj3u9D3NO0/wbFRRH8WXdtEMTt+mjMl8FqhLYxZ3
	1
X-Received: by 2002:a17:902:e542:b0:2a0:acb8:9e80 with SMTP id d9443c01a7336-2a3e39fe508mr21174975ad.29.1767689122762;
        Tue, 06 Jan 2026 00:45:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHj87y/LvUuXsPTTHYyxl210tNMFszmP1mS+zOvYjb5dokYHtO6c1eZkb9GIqFdBLOfAwoSIw==
X-Received: by 2002:a17:902:e542:b0:2a0:acb8:9e80 with SMTP id d9443c01a7336-2a3e39fe508mr21174665ad.29.1767689122205;
        Tue, 06 Jan 2026 00:45:22 -0800 (PST)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cb2c0fsm15249925ad.66.2026.01.06.00.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 00:45:21 -0800 (PST)
Date: Tue, 6 Jan 2026 16:41:14 +0800
From: Coiby Xu <coxu@redhat.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	Arnaud Lefebvre <arnaud.lefebvre@clever-cloud.com>, Baoquan he <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, 
	Kairui Song <ryncsn@gmail.com>, Pingfan Liu <kernelfans@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2] arm64/kdump: pass dm-crypt keys to kdump kernel
Message-ID: <aVzFW1_32EwyE2kj@Rk>
References: <20251226141116.1379601-1-coxu@redhat.com>
 <20260106062231.448170-1-coxu@redhat.com>
 <20260106-mammoth-of-wondrous-blizzard-e30d62@quoll>
MIME-Version: 1.0
In-Reply-To: <20260106-mammoth-of-wondrous-blizzard-e30d62@quoll>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MslAL2_TuMlM-K_Wp8yMFwRIm5RvZqRminF1zjWTaFQ_1767689123
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260106_004528_528353_882F0FAF 
X-CRM114-Status: GOOD (  21.58  )
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

On Tue, Jan 06, 2026 at 09:05:49AM +0100, Krzysztof Kozlowski wrote:
>On Tue, Jan 06, 2026 at 02:22:30PM +0800, Coiby Xu wrote:
>> CONFIG_CRASH_DM_CRYPT has been introduced to support LUKS-encrypted
>> device dump target by addressing two challenges [1],
>>  - Kdump kernel may not be able to decrypt the LUKS partition. For some
>>    machines, a system administrator may not have a chance to enter the
>>    password to decrypt the device in kdump initramfs after the 1st kernel
>>    crashes
>>
>>  - LUKS2 by default use the memory-hard Argon2 key derivation function
>>    which is quite memory-consuming compared to the limited memory reserved
>>    for kdump.
>>
>> To also enable this feature for ARM64, we only need to add device tree
>> property dmcryptkeys [2] as similar to elfcorehdr to pass the memory
>> address of the stored info of dm-crypt keys to the kdump kernel.
>>
>> [1] https://lore.kernel.org/all/20250502011246.99238-1-coxu@redhat.com/
>> [2] https://github.com/devicetree-org/dt-schema/pull/181
>>
>> Cc: Arnaud Lefebvre <arnaud.lefebvre@clever-cloud.com>
>> Cc: Baoquan he <bhe@redhat.com>
>> Cc: Dave Young <dyoung@redhat.com>
>> Cc: Kairui Song <ryncsn@gmail.com>
>> Cc: Pingfan Liu <kernelfans@gmail.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Krzysztof Kozlowski <krzk@kernel.org>
>> Signed-off-by: Coiby Xu <coxu@redhat.com>
>> ---
>> v2
>> - Krzysztof
>>   - Use imperative mood for commit message
>>   - Add dt-schema ABI Documentation
>> - Don't print dm-crypt keys address via pr_debug
>
>Your changelog should explicitly document that this has external
>dependency on dtschema pull request, so that maintainers know that.

Thanks for the lightning-fast reply!

And thanks for the reminder! I didn't know the dtschema pull request is
regarded as a dependency. Currently, I only add the dtschema pull
request URL to the commit message. I'll also include it in the
changelog.

>
>Also, in the future:
>Do not attach (thread) your patchsets to some other threads (unrelated
>or older versions). This buries them deep in the mailbox and might
>interfere with applying entire sets. See also:
>https://elixir.bootlin.com/linux/v6.16-rc2/source/Documentation/process/submitting-patches.rst#L830

Thanks for pointing me to the above documentation! I thought adding
In-Reply-To to the V1 patch can provide better context since it's a
single patch. It seems this is not true for Devicetree. Is it because of
the documentation change thus we should treat it more like a multi-patch
series?

>
>Best regards,
>Krzysztof
>

-- 
Best regards,
Coiby


