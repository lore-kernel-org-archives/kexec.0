Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20283C87FCF
	for <kexec@archiver.kernel.org>; Thu,  7 Aug 2025 16:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HtJ7SukZttuLpvU2sM4wbLSaHHmB2xRR25bbI/ADQkc=; b=KEubRlhuApXQ69QbHWQn1yQpzI
	qu/TWK0aAJV21sE9eQUgkFc9oPZeJY9mHpcjySlb5yfzwVUbs1PR9iwt8EFe5aW7afzSx/QsHDRbz
	d+rGey29gYYg/HY0675iyZ0CvguytnQESnkQ+/xYgCBC6O+KwdvdjhMNb2mZeDpGXGiGCcclNIrxf
	C0uBnUFsI5w+2nmpX5YLqNfCANdgbERC9+58V0A9876ojN4aKvkG7sq9iXGINwUQSe4RiGKvXnbyk
	HUhW8RfMTlacW7PzfjU7s6T0HOfe7FyePF1cgp2I7qNKXgqsPSeUYDgfiFsPOKjdFSz/eBFVEtbTV
	ArcgWLpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uk3af-00000001AOi-0Yly;
	Thu, 07 Aug 2025 16:35:41 +0000
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uk3ad-00000001ANQ-0kHy
	for kexec@lists.infradead.org;
	Thu, 07 Aug 2025 16:35:40 +0000
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-55b9f78b48fso225047e87.1
        for <kexec@lists.infradead.org>; Thu, 07 Aug 2025 09:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754584537; x=1755189337; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HtJ7SukZttuLpvU2sM4wbLSaHHmB2xRR25bbI/ADQkc=;
        b=Hum9GpJ838Kco1hWshshcaLqYhLLNO8u4S1BkAwwlFB2y1C+ezHWnkUgRtsDOT/OIn
         YL6L1ppV3/mYwwkNR0ZLf+XRkTskc0/xlYqpu75/IO+/jRSNYjSKUWtUayjLq2mr/ZUH
         Y4L12fjIiHdrns7DyYeT6wCpPgUFxk1ss9IyqCoceuPwSskdK6vCW1MXUMp1o1POhvpx
         p+kwRKWCahO0xac676U1/j6DFAV1x/Jj6pW7AIGQWCegchYTaJggMsQVzDy7eLh72Wsy
         KPXoYETqJip5YcMIfYFsYWMQOAWjgKsfUZFjtKhPZMrKS1QC0WHNq+6NuDmbgfcCrN+r
         bXHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754584537; x=1755189337;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HtJ7SukZttuLpvU2sM4wbLSaHHmB2xRR25bbI/ADQkc=;
        b=AlxHxwcnRezO9jkGlPwZ/3TXrSbKL2eb5xuVw8a3lE03MtiJcMKp95q/90mLcAA7ms
         i46F6/mSBaKipmr2XAeJ3cWqVyU4RiyjmFyp5iGpZxn0CDoUPTVenSYYPO+PpzFF7+k5
         q3/dZGaBgbJr6P72P3O9yLCn+5OUJfDQdrgUrE9CUwTBL1Skl+44LlFZ0fpWSNp7Im6m
         jw3PC2+rAGw8dX7XX6tCW8Lg9q71Y2amLF/u4AwujMas63GFpcSzdHzWBd6mXY4OX97m
         rIU+4lF9eS+E6xul0JVu9iJGu7S9LGq3seHW+AhoIKXsxFOuhUZ4IFxw3ceDOe8G4uEy
         vjcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWpCwuw/ilfR8ly6ZSzNs19mbSV0BEm1lNsUKwhNAZtYG3y53Q/qi1gi2IR/xUo21jSho6tA==@lists.infradead.org
X-Gm-Message-State: AOJu0YziZdKIhYnDWHhjHqmh9dnWb6DLQPWx3vsi4OA10avmuUc1CvOs
	+t+P8oAICrHNyYeM/BalvnRWZPlQpeLUfmLH3rQUcvc2QsJQrgfD8Mzq
X-Gm-Gg: ASbGncvGTtJqrOQ7F271ZpWt3iVU7+i+dJ7kMWEUbIoUKHhMEZyEawJ2Ej9gogrcP9E
	sy9QHBYtSh3xMjNUJzHW1/5kal1KSP1YO+2lu76Zn2B7ZlM5fuROjL+9627DDFSgt1TcT4XL8HW
	H6U0wRMjt48noyMAXN3I2k6qdMngTmOmUwczHABUoZkH3YJAASASza0pp2wx+75uEAGkRDhCb+F
	0rE8IKal9Z+fESyXCEfYgzz/BkjvNzr9IdOysFO3Ql5FPlWK6bWlYpmU1knTb80Rw9HA0iKqwGU
	g9oTms82EXGByE8tF8dPvXy8wAQc0n/S/4enH/+tcI50geWaZFXhUAPm0eL2O6/WmdVfJ0BfZse
	ZWDbO2WRSZyrZQ9xeI4hoXuWl5JKOm3LQJniZtKU=
X-Google-Smtp-Source: AGHT+IHkT64c9OHy2Nzz9XBeldTkqmQHkNU7gSOvuItx5Jn+CKscilRIlUOnQhfn0UMy94ic/YnGvQ==
X-Received: by 2002:a05:6512:3b28:b0:55b:8e2e:8ce4 with SMTP id 2adb3069b0e04-55caf317e7bmr927137e87.5.1754584537230;
        Thu, 07 Aug 2025 09:35:37 -0700 (PDT)
Received: from [10.214.35.248] ([80.93.240.68])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b8898bd4asm2706906e87.11.2025.08.07.09.35.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Aug 2025 09:35:36 -0700 (PDT)
Message-ID: <69b4f07d-b83d-4ead-b3f1-1e42b2dca9c2@gmail.com>
Date: Thu, 7 Aug 2025 18:34:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] mm/kasan: make kasan=on|off work for all three modes
To: Baoquan He <bhe@redhat.com>, linux-mm@kvack.org
Cc: glider@google.com, andreyknvl@gmail.com, dvyukov@google.com,
 vincenzo.frascino@arm.com, akpm@linux-foundation.org,
 kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
 kexec@lists.infradead.org
References: <20250805062333.121553-1-bhe@redhat.com>
Content-Language: en-US
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <20250805062333.121553-1-bhe@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250807_093539_218509_546F06AE 
X-CRM114-Status: GOOD (  18.88  )
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



On 8/5/25 8:23 AM, Baoquan He wrote:
> Currently only hw_tags mode of kasan can be enabled or disabled with
> kernel parameter kasan=on|off for built kernel. For kasan generic and
> sw_tags mode, there's no way to disable them once kernel is built. 
> This is not convenient sometime, e.g in system kdump is configured.
> When the 1st kernel has KASAN enabled and crash triggered to switch to
> kdump kernel, the generic or sw_tags mode will cost much extra memory
> for kasan shadow while in fact it's meaningless to have kasan in kdump
> kernel.
> 

Ideally this problem should be solved by having kdump kernel with different
config. Because if we want only reliably collect crash dumps, than we probably
don't want other debug features, e.g. like VM_BUG_ON() crashing our kdump kernel.



> So this patchset moves the kasan=on|off out of hw_tags scope and into
> common code to make it visible in generic and sw_tags mode too. Then we
> can add kasan=off in kdump kernel to reduce the unneeded meomry cost for
> kasan.
> 
> Test:
> =====
> I only took test on x86_64 for generic mode, and on arm64 for
> generic, sw_tags and hw_tags mode. All of them works well.
> 
> However when I tested sw_tags on a HPE apollo arm64 machine, it always
> breaks kernel with a KASAN bug. Even w/o this patchset applied, the bug 
> can always be seen too.
> 
> "BUG: KASAN: invalid-access in pcpu_alloc_noprof+0x42c/0x9a8"
> 
> I haven't got root cause of the bug, will report the bug later in
> another thread.
> ====
> 
> Baoquan He (4):
>   mm/kasan: add conditional checks in functions to return directly if
>     kasan is disabled
>   mm/kasan: move kasan= code to common place
>   mm/kasan: don't initialize kasan if it's disabled
>   mm/kasan: make kasan=on|off take effect for all three modes
> 
>  arch/arm/mm/kasan_init.c               |  6 +++++
>  arch/arm64/mm/kasan_init.c             |  7 ++++++
>  arch/loongarch/mm/kasan_init.c         |  5 ++++
>  arch/powerpc/mm/kasan/init_32.c        |  8 +++++-
>  arch/powerpc/mm/kasan/init_book3e_64.c |  6 +++++
>  arch/powerpc/mm/kasan/init_book3s_64.c |  6 +++++
>  arch/riscv/mm/kasan_init.c             |  6 +++++
>  arch/um/kernel/mem.c                   |  6 +++++
>  arch/x86/mm/kasan_init_64.c            |  6 +++++
>  arch/xtensa/mm/kasan_init.c            |  6 +++++
>  include/linux/kasan-enabled.h          | 11 ++------
>  mm/kasan/common.c                      | 27 ++++++++++++++++++++
>  mm/kasan/generic.c                     | 20 +++++++++++++--
>  mm/kasan/hw_tags.c                     | 35 ++------------------------
>  mm/kasan/init.c                        |  6 +++++
>  mm/kasan/quarantine.c                  |  3 +++
>  mm/kasan/shadow.c                      | 23 ++++++++++++++++-
>  mm/kasan/sw_tags.c                     |  9 +++++++
>  18 files changed, 150 insertions(+), 46 deletions(-)
> 


