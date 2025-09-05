Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CF4FCAC588
	for <kexec@archiver.kernel.org>; Sat,  6 Sep 2025 00:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YRexvvNjPPJfK1uT0OSGvRNA7ydx0We94Cj4HRzyUo8=; b=EXce+6AuR8Zl70GRbh2NFUeyAH
	c30BZXy6uhB70XcGNXkTP8pnBxBuqM1SKtU8dCw349BNdLqr22sr+xVME9gN0z0SDVL+x1hddBcOW
	0jsZ5OAwcn1DRNLB57/AQu83uwXLhWVxaKEzeIR9aHIZMsQ8OKw1ZTcA9TogtWkAMgKpXEvqSxsmT
	fcrokWZ8IYHVg/n4VnHRHtg8v77qs7BQ2Nx6YpOeE4YIZkWiPvyy8P4mjDyhV8hXlXlU3pwIO3AfR
	zI4FUNx9h2uePvr5bkLWqP8N3eLK4AQSfdVQNS/+IOswoXkxfYgqfV4XvEDOzfsEF2bUbfgjnJGs3
	gtJ5Z7dQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uugVY-00000005RRJ-1b0n;
	Sat, 06 Sep 2025 00:10:20 +0000
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuZzB-00000003Nz3-0aK0
	for kexec@lists.infradead.org;
	Fri, 05 Sep 2025 17:12:30 +0000
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3d9e0a6aa4aso288463f8f.0
        for <kexec@lists.infradead.org>; Fri, 05 Sep 2025 10:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757092347; x=1757697147; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YRexvvNjPPJfK1uT0OSGvRNA7ydx0We94Cj4HRzyUo8=;
        b=BU4CGciFm+CXIfLSPp4ywsWTA37Qi7rw7SehV+k+H9GwB3Wvv36lXX5V0+BkheuyGr
         nv7anu09WI1gQ5xBmREHzkUj/+pFtgf+PQ99La8l6I4kwlm0KL3Z2KiICuu98Dscu85Q
         RiqwnN+OrAfcJdwLU6gHp33PFe24WQTlYS7CRoYBM+bW/BXAjE1EEYgNf/cS2dyLha3v
         Iwvd/QzZJ/QnZuwqv/fn686bOZ491xRI3RbJwu3OduUgC6QxTIXupv85n3BGntxxyhJk
         pRfEeNRh+Hkt0ztDWSFc70+tU2bQoYkuOmnCoM4mwlnBjLpYrjHoc8Xf9CZjSqQbUMU6
         /6rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757092347; x=1757697147;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YRexvvNjPPJfK1uT0OSGvRNA7ydx0We94Cj4HRzyUo8=;
        b=J4ibI+xmcI11RDpcrcIxKKzZlXqB0tugGfRng/44hnGlUuKRUSoU0yqg3pXzuqR10k
         mC+0VBxSo1+M+4G6xabFSqT+0hvUC58hwm92Zc2DaJ15/kuOluycLg7SSRrEaheHQP17
         HqmFyjFqNhhUP3UMjDLm/961+pfTHEK/+zN7PuaB7mw4uzQPO5M+f/aIOU2yKLw8FVRD
         3oTThNpQBU+KRnGgdk6s4O8vTPDYhnqGEJMqhemKsRkgMNejnOCDmbYt074Zdl8RaYeT
         b+CCxovcuI40EQTscYLzQySozDANXP9X+OCBXiBZGFBmFYGwZD0m5xWybmItycRpCvd0
         FpqA==
X-Forwarded-Encrypted: i=1; AJvYcCU8Qeo3eKulUIyKX7X32hAbM24fKw4nuauA6m/uaIM2tgDciEhT5HKwv1QqSsDkZwCNY+6gRw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yxycr8Tcseqs6n12A8mZy5L3y7EYIqOwwOPrmbnp1+KluZuj9UJ
	/5Oun4v5aqQLkXlbwKvPGhGA8B2f8JdGGsKlV8G8fMmrV9BsiakSs2bL
X-Gm-Gg: ASbGncuC5J9/gfnsH569jJk6y7Tumwur+VF/TB9Fp2tZwj3GNO8rdol6bglfhV9xfUL
	I7g2XkNOdFpeCMyjnuKfs+aK39nirQ9uKO8pVx/P2FUEbirgaNyOuoWhZtij9dzfHMxugeZZswW
	htYBwQ4ri9T3Wf5zG5OMGPluw/LEKJrc+dK2EebID8Yqs1PVt6g7ntUXgmMeuD9JWFHwstnIG7Z
	ZSQLQNquAFQtlOcgfjSI4BHpgK3ZkCwSAJx8XOExOcw+/uXcaO6t/wfZCavJSXgM9TwoRGKN3rh
	RMR5RqokyxagSkJpqD0ZJeYFQiDVUyp6VQlTW/a31dpNM5d19vI/ZKymSnkf43TFBucoVLJcfiT
	1PmC0q6P0FZoWyu8WuYw27CQ5i14VM7XOZ7qdDwnQyIb5oCt+8eCCIWOuR3SvyO2vT9YdaB8gUk
	ia62K/Gu3H84c6RcA=
X-Google-Smtp-Source: AGHT+IGlC1bZMx0rOOObifxr+isGVzwQ1CKTbVGeV1N0+/Jd+6iR4EncAxNpQwTB91Ey6108bNX3uA==
X-Received: by 2002:a05:600c:8b10:b0:45d:d0a9:18b3 with SMTP id 5b1f17b1804b1-45dd0a91aecmr33464465e9.4.1757092346974;
        Fri, 05 Sep 2025 10:12:26 -0700 (PDT)
Received: from [10.213.233.28] (109-92-217-44.dynamic.isp.telekom.rs. [109.92.217.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e8ab14esm369577925e9.21.2025.09.05.10.12.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 10:12:26 -0700 (PDT)
Message-ID: <75a2eb31-3636-44d4-b2c9-3a24646499a4@gmail.com>
Date: Fri, 5 Sep 2025 19:12:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/12] mm/kasan: make kasan=on|off work for all three
 modes
To: Andrey Konovalov <andreyknvl@gmail.com>, Baoquan He <bhe@redhat.com>,
 snovitoll@gmail.com
Cc: glider@google.com, dvyukov@google.com, elver@google.com,
 linux-mm@kvack.org, vincenzo.frascino@arm.com, akpm@linux-foundation.org,
 kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
 kexec@lists.infradead.org, sj@kernel.org, lorenzo.stoakes@oracle.com,
 christophe.leroy@csgroup.eu
References: <20250820053459.164825-1-bhe@redhat.com>
 <CA+fCnZdfv+D7sfRtWgbbFAmWExggzC2by8sDaK7hXfTS7viY8w@mail.gmail.com>
 <aLlJtTeNMdtZAA9B@MiWiFi-R3L-srv>
 <CA+fCnZf2fGTQ6PpoKxDqkOtwcdwyPYx2cFwQw+3xAjOVxjoh6w@mail.gmail.com>
Content-Language: en-US
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <CA+fCnZf2fGTQ6PpoKxDqkOtwcdwyPYx2cFwQw+3xAjOVxjoh6w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250905_101229_210518_6278B690 
X-CRM114-Status: GOOD (  23.97  )
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

On 9/4/25 4:58 PM, Andrey Konovalov wrote:
> On Thu, Sep 4, 2025 at 10:11 AM Baoquan He <bhe@redhat.com> wrote:
>>
>>> If so, would it help if we make the kasan.vmalloc command-line
>>> parameter work with the non-HW_TAGS modes (and make it do the same
>>> thing as disabling CONFIG_KASAN_VMALLOC)?
>>>
>>> What I don't like about introducing kasan=off for non-HW_TAGS modes is
>>> that this parameter does not actually disable KASAN. It just
>>> suppresses KASAN code for mapping proper shadow memory. But the
>>> compiler-added instrumentation is still executing (and I suspect this
>>> might break the inline instrumentation mode).
>>
>> I may not follow your saying it doesn't disable KASAN. In this patchset,
>> not only do I disable the code for mapping shadow memory, but also I
>> skip any KASAN checking. Please see change of check_region_inline() in
>> mm/kasan/generic.c and kasan_check_range() in mm/kasan/sw_tags.c. It
>> will skip any KASAN checking when accessing memory.
>>
>> Yeah, the compiler added instrumentation will be called, but the if
>> (!kasan_enabled()) checking will decide if going further into KASAN code
>> or just return directly.
> 
> This all is true for the outline instrumentation mode.
> 
> However, with the inline instrumentation, check_region_inline() is not
> called (in many cases, at least) and instead the compiler embeds the
> instructions to calculate the shadow memory address and check its
> value directly (this is why we have CONFIG_KASAN_SHADOW_OFFSET, whose
> value has to be known at compile time).
> 
>> I tried inline mode on x86_64 and arm64, it
>> works well when one reviewer said inline mode could cost much more
>> memory, I don't see any breakage w or w/o kasan=off when this patchset
>> applied..
> 
> This is interesting. I guess what happens is that we still have the
> early shadow memory mapped so the shadow memory accesses inserted by
> the inline instrumentation do not crash.
> 
> But have you tried running kasan=off + CONFIG_KASAN_STACK=y +
> CONFIG_VMAP_STACK=y (+ CONFIG_KASAN_VMALLOC=y)? I would expect this
> should causes crashes, as the early shadow is mapped as read-only and
> the inline stack instrumentation will try writing into it (or do the
> writes into the early shadow somehow get ignored?..).
> 

It's not read-only, otherwise we would crash very early before full shadow
setup and won't be able to boot at all. So writes still happen, and shadow
checked, but reports are disabled.

So the patchset should work, but it's a little bit odd feature. With kasan=off we still
pay x2-x3 performance penalty of compiler instrumentation and get nothing in return.
So the usecase for this is if you don't want to compile and manage additional kernel binary
(with CONFIG_KASAN=n) and don't care about performance at all.

