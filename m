Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 240D2C02181
	for <kexec@archiver.kernel.org>; Mon, 20 Jan 2025 11:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=slhGj4lfgwuXBxH87F1uWakd45t5DstPDaiKXvqzZ+U=; b=xeMUBQ38Zqqop1jEgHTOY9DJ1N
	TiwoKHMcTuU3j508aFUWCkq3vIkcA5jJZ0T+GYsKB4tBOuDazsEdnM49sQ6QVB60aIiAIlw5AFxVf
	xIg64Ba3t8aBNNaKt9BKmZyINgndrvbxwvLXblb1fefEScDdhWohmLWLA6xErzmrY+Vd5vULVYP3x
	FatMH8JO+mUr5In1XvdFPfGGJxyLrMPqQsYpsOVptVDfq59Tw9DzGiK6Emj336qpwC6Un5gcL+jWS
	25TxiuJMZ9dPlxW3MDBN5UX4OiUWrA7bVLbEpbic59TveWFSxc7drjQ8OrAYLAp+2CyORjpqVdAae
	+V5QALsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tZqGu-00000005TL7-14b7;
	Mon, 20 Jan 2025 11:48:48 +0000
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tZqGr-00000005TKh-0Q5M
	for kexec@lists.infradead.org;
	Mon, 20 Jan 2025 11:48:46 +0000
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-aab925654d9so776897366b.2
        for <kexec@lists.infradead.org>; Mon, 20 Jan 2025 03:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737373723; x=1737978523; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=slhGj4lfgwuXBxH87F1uWakd45t5DstPDaiKXvqzZ+U=;
        b=IWtlKkgPwYb9AaX70AZ4vL/bI0HWe3u2Ni9gKOt/ObvJhmeFNtiYpnf7XnGcRIzXCA
         dMjWSwHMtrvbBpAR/b5m+VRxiksiG3ynPeHa+U3NzgU/+cK+Xy3jxNDwUJcfpgunoNKX
         7pYg7T6f4Vk9i6ztGGsyBPuQxditpRDWm/J4CeNYccrffsdMJ2EQoa8qfb4T0uwkQxKQ
         l/z4Zi+voqEOaHC/jqefh5gui/SmrNZ9AHGDc1ZvqrD9oJs5CS9CIlQu77AdUK53yzot
         SJUI+yParL02j08b4WzKwSciOMi1kbBtentetAlXwlaGrlsGS6RZNRBRocoeAHr+7xH3
         d9Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737373723; x=1737978523;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=slhGj4lfgwuXBxH87F1uWakd45t5DstPDaiKXvqzZ+U=;
        b=GmUtpxRsuIuWGGUDKb21tFBB1WQ8SlZxAeZ4n0tbmmr7KP07K/dVZv7uh/fov99JX/
         4wD1Yi8XKLdRNLAGNHjyFHF+hfKnRo4t8+tQQYLiHUUVs0MMse/+TnIcsgKLVhvrcMwB
         caQc1Fs3ON8g2UM+DsLorcZRNXw2tzQswuyeW9/kruzbwDw7ehxF4Qtq6ilhcY1jd0z1
         FgpcDmzBG+e7SefVm1xXpj5SDcLr9PmTIIfYBb+SVo44lHHrp0Id38Gt86K1y+tyIT1f
         unFuvCN59UPeQk0OxZIe0W9536ogdHyxYIdUhaRoTHv6StpqNH/8/OGvaEpVaocJ2f8h
         pwyg==
X-Forwarded-Encrypted: i=1; AJvYcCVANRIOZnujaqGJ3KMErDtRWDYiZStZ5DjpY1nympfEMG1+Mo9nfOosmmb4QTYVIasS6zmL5w==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw6ihasnJtV6qEwMBXXm2RnAkAMuvsVVoP9C5PhgnEDqEmaTEb5
	LmQ5QhTTqb0Gnrlpg5WKMX8y8wgu1goNaIHX5ONhD/6V1sy+7t6B
X-Gm-Gg: ASbGncuZ1XU9+r8LWXCapFaUHyEq0i7cCEc+pwOJutsieDOQemux5eTymatwaiAP/YY
	9PrAta3vra/E8T47+psklfCjhfZFzTSGx8bfXrAOTCjWhcmGJ3+rnxZRgyvWIFNddcp/yACgdpZ
	E0Jl62e5Ilk4RwDS461f3J8prML81cGOE1W3hqjabT/0FYs32Q1DmEz5h8/rHLJFnr3BLiA1WMR
	yqu7fGXe8xR05vENYGSO1kXhSmnQ+MEkvUSFS0nM6vHrt2ADdaNWmq/DD1WyhQqk2yZQYpfUBJy
	8oQOJ6R2ASPZ6eyqZ2lgTW3VReQelV8jTSg9O162Bw==
X-Google-Smtp-Source: AGHT+IFYFn/WFKp/ftN1HulWjfWaLQ02JfyVI2i0N4djdi9JbtdvvOdvnirZWnQ0LpueoRV/zRiVxQ==
X-Received: by 2002:a17:907:1c85:b0:aa6:81dc:6638 with SMTP id a640c23a62f3a-ab38b26f4cemr1152029566b.16.1737373723314;
        Mon, 20 Jan 2025 03:48:43 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1126:4:829:739b:3caa:6500? ([2620:10d:c092:500::4:4372])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384f290fasm614214466b.103.2025.01.20.03.48.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jan 2025 03:48:42 -0800 (PST)
Message-ID: <c5f68f9f-1494-426b-a5b2-bf6c1483c02f@gmail.com>
Date: Mon, 20 Jan 2025 11:48:42 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/2] efi/memattr: Use desc_size instead of total size to
 check for corruption
To: Ard Biesheuvel <ardb@kernel.org>, Dave Young <dyoung@redhat.com>
Cc: linux-efi@vger.kernel.org, devel@edk2.groups.io,
 kexec@lists.infradead.org, hannes@cmpxchg.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, leitao@debian.org, gourry@gourry.net,
 kernel-team@meta.com
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
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CAMj1kXEhKbuqVz9paggxQQz1Wyk_UNRvWZ46X7YKx9b-xMfWyQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250120_034845_145017_E6FA980A 
X-CRM114-Status: GOOD (  14.35  )
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



On 20/01/2025 11:29, Ard Biesheuvel wrote:
> On Mon, 20 Jan 2025 at 11:50, Usama Arif <usamaarif642@gmail.com> wrote:
>>
>>
>>
>> On 20/01/2025 10:32, Ard Biesheuvel wrote:
>>> On Mon, 20 Jan 2025 at 11:27, Usama Arif <usamaarif642@gmail.com> wrote:
>>>>
>>>>
>>> ...
>>>> Hi Ard,
>>>>
>>>> Just wanted to check how should we proceed forward? Should we try and fix the warning
>>>> and corruption during kexec as done in this series or not initialize memory attributes
>>>> table at all in kexec boot? I would prefer fixing the issues as in this series.
>>>>
>>>
>>> I would prefer kexec boot on x86 to disregard the memory attributes
>>> table entirely.
>>
>> Would you like Dave to send something like
>> https://lore.kernel.org/all/CALu+AoS8tb=HgaybDw5OG4A1QbOXHvuidpu0ynmz-nE1nBqzTA@mail.gmail.com/
>> on the mailing list (wrapped in ifdef CONFIG_X86_64)
>>
> 
> I prefer this approach. and no need for the ifdef, this is x86
> specific code, and the memory attributes table is already ignored
> entirely on 32-bit x86 iirc

ah yes, I ignored the file name when reviewing it and just focused on the function :)

Will wait for Dave to send it.

Thanks,
Usama

