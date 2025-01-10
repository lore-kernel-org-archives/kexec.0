Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DA1FE77188
	for <kexec@archiver.kernel.org>; Fri, 10 Jan 2025 11:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hRwtHfP1JQU5+YPorhBGMH6eYlGfleBI3Cl5YY7QQEI=; b=hwJC8X8YxvLj25vwdu9ZrBibEO
	RJm7ALXPUWzpHy/UpAXJ4WdZwqvwpWJ4u864Wxpo7qayNP+qaB3W7R9tX9/SP+cbmK0xXGyvpLAJn
	p5ZAoH1bLQWw5uhGyucAwD/wBMYRuM1M5zTqDReF7RTbeHvivfSYTVC8730LyFfOzyW9YXoiu2IOK
	iael7FdVzivbuNnHRY3yb1ctWDfB9Ty9cS1hmblWOXNky+DOCbjpkavi6yevBbcaNLXL9KvIKLBHZ
	qcYhb6tHmEmbK+F3qiq/0YmbzgGvZqRpFI/rlPQ6zdVtc1yzsY/tWemjXzI2JKCuQGP1qN3JMnQJ+
	6g4+Imrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tWCwY-0000000F4Q2-361W;
	Fri, 10 Jan 2025 11:12:46 +0000
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tWCwW-0000000F4O5-1Bfc
	for kexec@lists.infradead.org;
	Fri, 10 Jan 2025 11:12:45 +0000
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-aa684b6d9c7so350187066b.2
        for <kexec@lists.infradead.org>; Fri, 10 Jan 2025 03:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736507562; x=1737112362; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hRwtHfP1JQU5+YPorhBGMH6eYlGfleBI3Cl5YY7QQEI=;
        b=LT4OfAjfQrzEyRPa1h4tnxBfUxkPqKAEpS6YbiU32pUpFFkwtamcRBfTWWnOmK2B8H
         jS0anu3YvPKeCe6v1GBWkzSrY3kIlfguNcBwjG2tpVUVWTRq67ti9OcwD7BI3lkyDUZy
         IF8pLQWURxr60SRQ2Sd/D5e4mJI2Qg4zl79y3QgF8LwxJ4E4EccJFFwnG63Ls9OtLEo6
         YBBgT3acxLbtNfVZTGC1l9pfjScWx9XlhOsPdC0M6FzSl/UihHFbh2uo0/rscTegha2Q
         Rw3slNwqxjBFL52pYzWhGeVnz/I+2Fur4HBj0xUb9qSQaGRV+nvdoM9gbQQUb2wLBDlZ
         AmQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736507562; x=1737112362;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hRwtHfP1JQU5+YPorhBGMH6eYlGfleBI3Cl5YY7QQEI=;
        b=hoWtkZXdSSUhG9WIalSRjFz79c+/ZZwK27ApVtjA8fBW7yCP9aNTzGiWxd4PtyrzF/
         kowbhwmw3fJVaOoK7cj/7CGmC+oI+qC7/a6MkOdq72jrWMvXFz01WKYbyZ8Xl/2RNDLc
         Ry0sQFQhSo86hQYT3mcLORjgSA0si7NN9CCVZUQpzZo05WYPh2P6XFZWOUpNgUvcGyRk
         OsFLjHYpiWn61Ds9KBaHupKqji/ENLD2jeB+WLIu2AwBRCunZzVUpTt4qUCbw4nLlcgw
         IyrpVBMa5GGZj3mfxyZRUkxqsWfUyoPnL9c2YQcAAP5rtSdfz3DNch3aXz3LnJCJCmcN
         doFA==
X-Forwarded-Encrypted: i=1; AJvYcCXgSPiNiWsr84CiPwRTocrGdNjcTkcj9RxhQ9mai9kqahvzdL1Ugz2LgXV8s210NChU9S8JEQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YyNkv9kAn24DMTSzcnajJlYn5p5lt3MbEMNB0FE/0EMogJvv9Au
	o87pLDbmuhgDwUq3NHkLy+/zNCq+bt4DYhEa9E5fyReIYySnDKXT
X-Gm-Gg: ASbGncvWMbBHWjQ0Yf+W026q96dOaVEJtKJ1f0F51UmuEnL+gpqASu+Ijp6D6n31Emc
	KBFJ5PvpDHl0O1TaV7mNPexst4iR7espOQqgxjGi/C2+gqhr+fFRVmLwDzR0qB/EMcPeJQQ1wu6
	kvptdrBC9/lYWw4P8KeCHDD5XmmTVQgYstyPe5q1fOkzM5c3/gZj10Hfoxw/kQVfz8rjYlqbXrV
	8UOYsLPLVpR2v0oo1jXUXMx4LrVhT2G1FznJkDLszdwMLOIrxE8nIjE0nEIYnfLoUYmN7h/9n/s
	UMXfaYHHGR3b4w90o6ga9UL767pX
X-Google-Smtp-Source: AGHT+IEr3DYjbmxJfOi4g+OJHmU/3Mg1uURC8lJFwHS/uzBUjhDVzsWaDhSM2tE7YGlD4il6vC880g==
X-Received: by 2002:a17:906:dc8d:b0:aaf:4008:5e2c with SMTP id a640c23a62f3a-ab2ab66fea4mr827120266b.2.1736507562473;
        Fri, 10 Jan 2025 03:12:42 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1126:4:829:739b:3caa:6500? ([2620:10d:c092:500::5:e213])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c905f0b3sm157026166b.21.2025.01.10.03.12.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2025 03:12:42 -0800 (PST)
Message-ID: <4ed67e5b-c2ea-4dc3-b4c5-f8f112b0cd40@gmail.com>
Date: Fri, 10 Jan 2025 11:12:41 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 2/2] efi/memattr: add efi_mem_attr_table as a reserved
 region in 820_table_firmware
To: Dave Young <dyoung@redhat.com>
Cc: linux-efi@vger.kernel.org, devel@edk2.groups.io,
 kexec@lists.infradead.org, ardb@kernel.org, hannes@cmpxchg.org,
 x86@kernel.org, linux-kernel@vger.kernel.org, leitao@debian.org,
 gourry@gourry.net, kernel-team@meta.com
References: <20250108215957.3437660-1-usamaarif642@gmail.com>
 <20250108215957.3437660-3-usamaarif642@gmail.com>
 <CALu+AoTgjdq+kUbv-5CGQr=UTLd2+zDLbHt=kXaoMYYptBYnAA@mail.gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CALu+AoTgjdq+kUbv-5CGQr=UTLd2+zDLbHt=kXaoMYYptBYnAA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250110_031244_337321_A54A5767 
X-CRM114-Status: GOOD (  12.01  )
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



On 10/01/2025 02:50, Dave Young wrote:
> Hi Usama,
> 
> On Thu, 9 Jan 2025 at 06:00, Usama Arif <usamaarif642@gmail.com> wrote:
>>
>> When this area is not reserved, it comes up as usable in
>> /sys/firmware/memmap. This means that kexec, which uses that memmap
>> to find usable memory regions, can select the region where
>> efi_mem_attr_table is and overwrite it and relocate_kernel.
> 
> Is the attr table BOOT SERVICE DATA?  If so, does efi_mem_reserve()
> work for you?
> Just refer to esrt.c.
> 

Hi Dave,

Its a bit difficult to reproduce the problem and therefore test the fix, but
we are seeing it a lot in production. Ard proposed the same thing in 
https://lore.kernel.org/all/6b4780a5-ada0-405e-9f0a-4d2186177f29@gmail.com/
but as I mentioned there, I dont think that efi_mem_reserve would help,
as efi_mem_reserve changes e820_table, while kexec looks at
/sys/firmware/memmap which uses e820_table_firmware.

Thanks,
Usama

> Thanks
> Dave
> 


