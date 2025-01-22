Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CE0FC02181
	for <kexec@archiver.kernel.org>; Wed, 22 Jan 2025 11:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oh23WD6b9+c/DI2oI9FQ/B0EymzRbxc0VAjw7ASF7LU=; b=dQrSRLJDUZ3pIUXo4rnfzoTp+S
	iryER/DEfInh7OgN8HAI0Ve5EHv2tPfZXYifLwr4S02eVAyrf5NJ1BMtAtCz/328Cs39/FtLJp1yS
	y2c8r1ACxMiD0yue12tjWIReSXRjlr/vtaojrSgj75GmE6/51CFo+XF4AMYLc7lg4Puqst8EbP6iZ
	ufxWDkqFh0YKnkXtydKU0Ty4PC/uLnrmEXp+SrYIc4Q27EcvTWTwXhfNdF+QOKqCLh6bhux2VD015
	9lcOTHtQQ4ZSReSAoFSY9VJ6HdDytHRwW4PNtCeek7RVkzs9NorpD9LGN2ojASdrjMe0F2AOxXfF5
	4TOQ13rQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1taZFe-0000000A5m1-2jKl;
	Wed, 22 Jan 2025 11:50:30 +0000
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1taZFc-0000000A5ld-0t9A
	for kexec@lists.infradead.org;
	Wed, 22 Jan 2025 11:50:29 +0000
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-aaeef97ff02so1113477266b.1
        for <kexec@lists.infradead.org>; Wed, 22 Jan 2025 03:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737546626; x=1738151426; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oh23WD6b9+c/DI2oI9FQ/B0EymzRbxc0VAjw7ASF7LU=;
        b=DBatpwHM2G/7mQPsDZm7Z2r6e1eUrIsPbYmfG4LoMpwsMvYRB43py5fHwpALoxPXJp
         EFLAERmhgcY84CVO8QFAzq6JNNYOJRHqj6ar/vz/HUpA0rJfbc+4uG3hag/0p9DUQ0o7
         cg/rDR4t8gaVxBERQwihVB2lYSAfQqBrk2uroFa+QcGlM1PSZiimT1a+SEiSg3OSxBxY
         xr4s/wcodIBOQC4DjprHVvhzIbL9JQqRjo09T44W5WhnN3FlhI068emVy6SgQdBV1Eny
         V2Pc8+I8pxNlyu+qRoEKjsyZgJ0u5kmnsXF1e3Ih3lM35iIEBJSuBKcZLm4pdFYJk2CY
         Qh2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737546626; x=1738151426;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oh23WD6b9+c/DI2oI9FQ/B0EymzRbxc0VAjw7ASF7LU=;
        b=Mi6C/BR2wGPXUWQ17un/qE/mtBMSDJQp7vH/rb6qaffxK/kyxIxnBRpawukEpMP6aU
         F33pFwg6k12TzQONskidJq6fM7WtG3hf0/cUhqZbx8Xvi+wD137+x1voCcDD7Vac3xsL
         XElBDngfqzf+BWec9EBrKUCc5oYx/6HD262luRJot/LcGYRuJAp1gXQrX9AqA6itj2Nz
         zjN4SS0mx8eF7vZ3AOwKw4AQrLDId7+KGDFlSa3vNYxNe5WQhhR4K9aUiyV8fpvdE/76
         FY6T9va78Llu0TjgSTCJdWZpYTtq9FPajsCbSrXjtVr1zu08CmMI2fzfSAlYxdbfX4NG
         F7bQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJ/+qNr7/qBI+3YqMw6LhSde0Tt1MILhzXwbkaMx/FjQSWAx7A+QCnVNR92p7h3KU3OmyO0Q==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz5FqkSQkhaVP23kPLY/u+EulNFhfW1+JfONjoGCW2jlhI3HHGw
	j6U6imWyLqf6xo8H7QZwPJ/JL//3oCW1HSNgNyhm+Uif4k6lTlG6
X-Gm-Gg: ASbGnctJawnzHf+vvNZRRlVlzISnfgKgf7zLeXo8EK3XZW9r2FCGBxZtOhYuwbPtLXS
	zNOZs4DdcPsMtx9AqcReDLRVWMvjC27Iz1fH2k5l1vef6UqDfEY2J54GCRBDwKPZyqAhM6hAvjy
	owCvoTfTsEb9vV81i6nJJxfonIXAasqD76RsHmJlvC1gfWA14F9brNsQDcaH0crP98JvRUOdIZW
	LpXSQwP/nawan2LjgL+YsQA1u1ALtkOnJ5s/jd2OCNkxaEqwB4X4TU7cFhbWukVep5JqSF/tqof
	8rXJtpmvNOphqoujrfP4KK22oumDCFPALv4wwXOLwQ==
X-Google-Smtp-Source: AGHT+IF+incGb/IZc3tkpwYf1H3kUvKL8NDvsH89F25knBJMw3Vy2+yLj3qjgDdMHXGS49J7p9SFOw==
X-Received: by 2002:a17:907:7f89:b0:aa6:29dc:11b with SMTP id a640c23a62f3a-ab38b1ff059mr1576763966b.16.1737546625488;
        Wed, 22 Jan 2025 03:50:25 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1126:4:829:739b:3caa:6500? ([2620:10d:c092:500::4:1c5b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384d2cfc2sm887377566b.82.2025.01.22.03.50.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2025 03:50:25 -0800 (PST)
Message-ID: <1a4223a2-77ae-4f15-a40b-dc33de9e6c2d@gmail.com>
Date: Wed, 22 Jan 2025 11:50:24 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/2] efi/memattr: Use desc_size instead of total size to
 check for corruption
To: Dave Young <dyoung@redhat.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
 devel@edk2.groups.io, kexec@lists.infradead.org, hannes@cmpxchg.org,
 x86@kernel.org, linux-kernel@vger.kernel.org, leitao@debian.org,
 gourry@gourry.net, kernel-team@meta.com
References: <20250108215957.3437660-1-usamaarif642@gmail.com>
 <20250108215957.3437660-2-usamaarif642@gmail.com>
 <CAMj1kXH54Y0ae1OGwBe7-UiRBq9cFkDHbjxos_rEZPtan7NNzQ@mail.gmail.com>
 <d9c84079-6593-43f4-9483-648b665f03db@gmail.com>
 <CAMj1kXGYsJrqDzy_+g_wSAAEuQ_OnxvyJ8ZE+4gbr6KOY7iuow@mail.gmail.com>
 <8613563a-ee7c-4271-b1f0-4d1ac365ad3a@gmail.com>
 <CALu+AoS8tb=HgaybDw5OG4A1QbOXHvuidpu0ynmz-nE1nBqzTA@mail.gmail.com>
 <db7edff7-8a87-41db-9e40-202a498c5e29@gmail.com>
 <138f28ec-341e-4c48-a14b-4371a8198de8@gmail.com>
 <ed7ad48f-2270-4966-bdba-ccd4592a0fd4@gmail.com>
 <CAMj1kXFMxfOswAdBEVsCoVO90y_m1TUigWRG-3FJTsv4xOGTpw@mail.gmail.com>
 <029cff22-f2e0-4796-9c27-1df056e08f8f@gmail.com>
 <CAMj1kXEhKbuqVz9paggxQQz1Wyk_UNRvWZ46X7YKx9b-xMfWyQ@mail.gmail.com>
 <c5f68f9f-1494-426b-a5b2-bf6c1483c02f@gmail.com>
 <CALu+AoS5_w2CV5w+b1WrFRFH7nfwmkLZUh=AXn=D=7rAhDNVAQ@mail.gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CALu+AoS5_w2CV5w+b1WrFRFH7nfwmkLZUh=AXn=D=7rAhDNVAQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250122_035028_270761_9E408620 
X-CRM114-Status: GOOD (  18.18  )
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



On 22/01/2025 05:36, Dave Young wrote:
> Hi,
> On Mon, 20 Jan 2025 at 19:48, Usama Arif <usamaarif642@gmail.com> wrote:
>>
>>
>>
>> On 20/01/2025 11:29, Ard Biesheuvel wrote:
>>> On Mon, 20 Jan 2025 at 11:50, Usama Arif <usamaarif642@gmail.com> wrote:
>>>>
>>>>
>>>>
>>>> On 20/01/2025 10:32, Ard Biesheuvel wrote:
>>>>> On Mon, 20 Jan 2025 at 11:27, Usama Arif <usamaarif642@gmail.com> wrote:
>>>>>>
>>>>>>
>>>>> ...
>>>>>> Hi Ard,
>>>>>>
>>>>>> Just wanted to check how should we proceed forward? Should we try and fix the warning
>>>>>> and corruption during kexec as done in this series or not initialize memory attributes
>>>>>> table at all in kexec boot? I would prefer fixing the issues as in this series.
>>>>>>
>>>>>
>>>>> I would prefer kexec boot on x86 to disregard the memory attributes
>>>>> table entirely.
>>>>
>>>> Would you like Dave to send something like
>>>> https://lore.kernel.org/all/CALu+AoS8tb=HgaybDw5OG4A1QbOXHvuidpu0ynmz-nE1nBqzTA@mail.gmail.com/
>>>> on the mailing list (wrapped in ifdef CONFIG_X86_64)
>>>>
>>>
>>> I prefer this approach. and no need for the ifdef, this is x86
>>> specific code, and the memory attributes table is already ignored
>>> entirely on 32-bit x86 iirc
>>
>> ah yes, I ignored the file name when reviewing it and just focused on the function :)
>>
>> Will wait for Dave to send it.
> 
> Ok,  I will add reported-by from you and suggested-by from Ard.  But I
> can not test the efi mem attr, I'd prefer to have your test results
> first.  Could you confirm that?
> 

Please also add Reported-by: Breno Leitao <leitao@debian.org>
who originally discovered and reported the issue.

I have tested it and it works, efi_memattr_init will just return 0 as
efi_mem_attr_table = EFI_INVALID_TABLE_ADDR, so it won't be
initialized. Feel free to add Tested-by tag from me.

Thanks,
Usama

