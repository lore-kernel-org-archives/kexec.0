Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08C08E7544E
	for <kexec@archiver.kernel.org>; Wed, 24 Dec 2025 12:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kFaMyaLN7ofb8ca0IqdWrpz34r7dd+k0wM2WCDT3KaE=; b=NBfGFZ85JfpvCSDyoaLUlAqYIG
	ZWgxaX5V0YL9+7037sYkUCsX5tnUY6krst6/9XHXALsvVrsQu+nx/6sXTrNg1HxPK5LX0kXV9gjx4
	6XecScX7f7qHCe81DtAXBNP5c2OTE7CcbxlJRQgEBtlcW745Fp2sZwYsCMomDbwbXlcpHkh0ayk3/
	MEDxkDC9aaUkfJk4QNGqgY3aGx5Z0fMAjE/TsCKZ/RAUGwtpT42V1G/TGgFLfzLozgNozoa5EToGH
	4rKvgJcf9vcIWnD+ijyQLF+Miqb0cICkqNluMUli17kQgJOKzcnpDa793G0HP9NpqrBEbPu/hdtA3
	aLMzJBvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vYNwa-0000000Gn4H-3WMX;
	Wed, 24 Dec 2025 12:26:20 +0000
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vYNwX-0000000Gn3s-3o6Q
	for kexec@lists.infradead.org;
	Wed, 24 Dec 2025 12:26:19 +0000
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-4779b49d724so6762365e9.0
        for <kexec@lists.infradead.org>; Wed, 24 Dec 2025 04:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766579175; x=1767183975; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kFaMyaLN7ofb8ca0IqdWrpz34r7dd+k0wM2WCDT3KaE=;
        b=gYRTmty856xjwHKXcLlIqkw3uHeVxlLYvc2M3FflrC5vEyz8kLeLWm1DpD8fzAM9qP
         bgf9ucLLvgNiiKaZPsGykGN7KBCsdLBnq9+169J9WxlDWINeFkRJB/OxvYjvnFl52cDp
         Bd3EGwMaEQ/jb5Yk5oLtnDWX8eE45Xb7jRMOdCFpGzOaMo+5hMUEj+tNbroVgBYNAapp
         rorgkWTlh9XkwGRx2GSeXI0ingZSRbs/rZrW9SAgcFUBqv5GjHEeIhIKCBfEJAa5OZ8L
         c4K23XwZf6Y5uKvEl7ohohPFuKZ263RTMQP+5SJYvJROAf8Sey6mQwHHZZRhDv5ru8oe
         iKdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766579175; x=1767183975;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kFaMyaLN7ofb8ca0IqdWrpz34r7dd+k0wM2WCDT3KaE=;
        b=HIu+lg+skpeZoMKZ/tAtPYVfBZuwSTXQaz2SuhjTU8yUxuhosW0NyfV3Pu/rmr2wBd
         AhPcbWFFCTe7sIo32Qfc3banvuphJ/gxHjrLmi4AMv5LlDTgeXJ9cbbrPd0JBpRbrGrd
         IpUXvqA5PFCG7C1ZEwQml0HEOtIjjmVhvFT2vQVOHV4+bbomBJu8zw6UPb0nZF0o99I+
         F/h9HTgnG3RGVcS8smTYFCRwaVSt7swAIL1oO+27l/9pF0u8C1LH9n0gWimsFNXyhxrl
         7ky5HKSGFojTfF7kYxhWpjG5Xjk+aBIoGatbCVi8pes5BkoHV0MQhiL0voocuCCs2lY5
         sIzA==
X-Forwarded-Encrypted: i=1; AJvYcCXXkoTIhNmnR7h3VHga+t+BuEoweuIjWWBc1m7mR8DdZqxRwb3vRUHhAst7RUjLnanB2/9rFA==@lists.infradead.org
X-Gm-Message-State: AOJu0YwkLHLPLPWZMafHsw5izy3KnJ3UHvIqlTSuuRZLfn+E9SbWEfNM
	DIbL/X7W9zeNclYqA1bYy8yfdAMZDXls/b8NUa1gTMpy14/p/o7rmt28
X-Gm-Gg: AY/fxX5x4MfB7YpLvwl6AJl+V7vWsMLduQPRf8Z0Cqi53InNZMZKxfIxle06Ot1nkhb
	vEk3jznGDYVQr1EmcjLGtIlkEnh/KghFLMVgnIqWzmtzI3QOXZGdXLWTcGVZu8bRjGWOoQPQewr
	KiZhO5Z54HRjDLq1uByNLuUZJ0krNEt3+BkV5Mwq4eflugtNX4sAU6cOoMt58tZ7hi/AjYzaUtj
	FdhWNI6Q3PX1gE1Rgpulapbw2sPXaiGr2XZX2Y0k8lD8YGi/LrGteCgAQDkZduaOH2QN2fRyk5Q
	aszgAcq78oWKw3qCNPVaEh+dBWFqoUANwxXdZ8IBBH4jyFyX406/jCtRTBtC36dbJ+rs5jdgQCO
	jaQC27scNQL7+3hl6VQHe1BIJFNdT4GPZDptaD020CPRg/I8AOqEsttD/6askpz0n8jEmWbjKnF
	30a7WEdsABmmLK7DNNrQ==
X-Google-Smtp-Source: AGHT+IHCVi5vf+JW7cs0UQI/61lI+ftkhC5OET7bLF5lpXMP/9qG0WkJH6kguXir7jmsMYCcLoJ1nw==
X-Received: by 2002:a05:600c:348e:b0:477:5b01:7d42 with SMTP id 5b1f17b1804b1-47d19599f8cmr103586685e9.5.1766579175264;
        Wed, 24 Dec 2025 04:26:15 -0800 (PST)
Received: from [172.22.153.25] ([80.93.240.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be3a204e9sm132695265e9.2.2025.12.24.04.26.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Dec 2025 04:26:14 -0800 (PST)
Message-ID: <edd6e350-5482-4551-aa94-e1ab8d2f9774@gmail.com>
Date: Wed, 24 Dec 2025 13:25:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/12] mm/kasan: make kasan=on|off work for all three
 modes
To: Baoquan He <bhe@redhat.com>, Andrey Konovalov <andreyknvl@gmail.com>
Cc: linux-mm@kvack.org, glider@google.com, dvyukov@google.com,
 vincenzo.frascino@arm.com, akpm@linux-foundation.org,
 kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
 kexec@lists.infradead.org, elver@google.com, sj@kernel.org,
 lorenzo.stoakes@oracle.com, snovitoll@gmail.com, christophe.leroy@csgroup.eu
References: <20251128033320.1349620-1-bhe@redhat.com>
 <CA+fCnZcVV5=AJUNfy6G2T-UZCbAL=7NivmWkBr6LMSnzzTZ8Kg@mail.gmail.com>
 <aUtd6es8UC0lNf/9@MiWiFi-R3L-srv>
Content-Language: en-US
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <aUtd6es8UC0lNf/9@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251224_042617_961591_4FD5B06E 
X-CRM114-Status: GOOD (  18.35  )
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



On 12/24/25 4:28 AM, Baoquan He wrote:
> Hi Andrey,
> 
> On 12/04/25 at 05:38pm, Andrey Konovalov wrote:
>> On Fri, Nov 28, 2025 at 4:33 AM Baoquan He <bhe@redhat.com> wrote:
>>>
> ...snip...
>>> Testing:
>>> ========
>>> - Testing on x86_64 and arm64 for generic mode passed when kasan=on or
>>>   kasan=off.
>>>
>>> - Testing on arm64 with sw_tags mode passed when kasan=off is set. But
>>>   when I tried to test sw_tags on arm64, the system bootup failed. It's
>>>   not introduced by my patchset, the original code has the bug. I have
>>>   reported it to upstream.
>>>   - System is broken in KASAN sw_tags mode during bootup
>>>     - https://lore.kernel.org/all/aSXKqJTkZPNskFop@MiWiFi-R3L-srv/T/#u
>>
>> This will hopefully be fixed soon, so you'll be able to test.
> 
> Do you have the patch link of the fix on sw_tags breakage?

I think this one  should fix it - https://lkml.kernel.org/r/cover.1765978969.git.m.wieczorretman@pm.me

> 
> I am organizing patches and testing them for reposting, but still see
> the sw_tags breakage during boot on arm64 system. If you have the
> pointer about the fix, I can grab the possible unmature code change to
> make sw_tags mode work to finish my testing.
> 
> Thanks
> Baoquan
> 


