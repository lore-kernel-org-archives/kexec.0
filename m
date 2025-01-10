Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 064CCE77188
	for <kexec@archiver.kernel.org>; Fri, 10 Jan 2025 11:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rmbj6+bdcAEA/h03npvSWI55L56TERING6IBOmfVGT8=; b=z6XddXYC+NuFoRj6ZHJKfEScCH
	dSDxsFEHLEzill6rLeXfgGvLS6D1Pl8eqJUjd9iegqkRnfV2UsnysX2Ss/5jREY0rSktTBTchgKDP
	yxHCMSmEiiYDJ6DmucKee7Gz/rMhczXQBaDD5SI5K9nOHNt7/gZphzwoxIvxWKPP5fir8exD+54Dk
	3qgtO3vtn9urCkJHDQHdJG4HAZkqRABatwurKxOAZUjpv+gAsdqzSjVZrkN8cJ1/Hc6q43Pc3rAm2
	+KTiIo25XmG5gx4/0hClO/8udcxALsi7kKo4ueMopyOQ5Jr2W5262w571GZl/WYfLireqmXEzDWvS
	R88XJhQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tWDP4-0000000F9SR-19wv;
	Fri, 10 Jan 2025 11:42:14 +0000
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tWDP1-0000000F9S0-1mEL
	for kexec@lists.infradead.org;
	Fri, 10 Jan 2025 11:42:12 +0000
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-aab6fa3e20eso348875166b.2
        for <kexec@lists.infradead.org>; Fri, 10 Jan 2025 03:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736509329; x=1737114129; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rmbj6+bdcAEA/h03npvSWI55L56TERING6IBOmfVGT8=;
        b=TvlMJg48EIhIhsmYPvI7xkALYoLaQGTZO8U7KWZjGbCrj+zC7kTZN4KZfvp/O4OIZ1
         cN2Jrg94FmoB71eBKeMNAYPFgOJoGP1dXMTn8h43HdjC7tKEAthOFzvSfGBalWo3sWWN
         Emqk7A3Lz5R5eFwY81JPjyeDOVfF+fHA4PbW6ychtcT/5Z2zDRDeCMVRo/0L4p3cA+G8
         R40URLMY0kou5Rga/x3Nu32gJ0WuO3PK+BjXNQREIvQrnIHDzX7B+jIlWz9iEdQSvQK5
         TznTtX6l4fSkcgLunGx7zJ9JfrvW496/IVsRQK9XvfaLx/rxtHz/nihTvODbvMqSISlU
         qz3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736509329; x=1737114129;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rmbj6+bdcAEA/h03npvSWI55L56TERING6IBOmfVGT8=;
        b=m+fMhV287FqOrYP4nsCyQD3PwKIq0aHLeK4BoW2S2AsOhKl6g4HtnZgrHYQTMaTQTx
         QTIuABXfkkvHMZUWylNId+w3f99W8nuLDhMl0PA+cflduFT3Xb/tOmjf2pgCxLxytuwP
         CPaSF8jk8aRuewis8es/qZtwtvTOS63FAW0lxnaFDG0YwC3fqwO7+xZb4ZxwLW8udWKm
         DEJijmofYfo01BddQuxMvhO4cP1bNmzZFOPLKnzqfTt3QoPXKsyAzp3yPrh4SSs0LxWb
         A83YX7/GlVmW9RGKiqbqHUU97oHaMgLEJ3/uYRWBf0az98/qxXNvmAuIsym2vQ0RUMB8
         P6ig==
X-Forwarded-Encrypted: i=1; AJvYcCVHFFN0TJmmkXKzpNB0Y2WlhbKca3iUUwVGJqgjUW2hrW774uOMdTBcYqL64/CzarP4teIydQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz60Q3HQoKWk7tTcWF0D94U4gmVosv0okEFdbGyTV4ZKhizNU/2
	Kuen1BVrEZmI3zNLsQpdELDJST016Q9PQ1UuVFW4YGYRNjcTYyNe
X-Gm-Gg: ASbGncuxCnwq1u9cXW1tKbk+ELC5QY70L1nQo5MO2uu7BCFRuUyiGNVSxXOKijSHPFe
	nQZ8P0jAGXFBqD/yZXAoW/UtBC4SPXPvXbJV8QgUpCe0/TCUGPqzZevrsnJISCFX0gipKspc4vk
	3FuhE1MgckRvb3/RIH4jOmX8S7DBJiezFAGIaabkwJkCuzSLM19+BJj+KqixvTC12SSdaSHt9up
	DQNrHNSODwrkpDhiciCM1XcXYe5e/JFhRo7Vn5Kqj9oMeboBp5k10RiXZpbfaedYf/LtN21YfUz
	zoNh4r7jyCLx3mQoFqJ8djA4DjLS
X-Google-Smtp-Source: AGHT+IFqYTiXpAtyFHsSTe2ln++HKgU0ODNtcI+FY2vTwxc+2zrHSgT1LKHx/WkhY/e2BplHhyn4nA==
X-Received: by 2002:a17:906:f582:b0:aa6:7165:5044 with SMTP id a640c23a62f3a-ab2abc789c7mr828412766b.44.1736509329336;
        Fri, 10 Jan 2025 03:42:09 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1126:4:829:739b:3caa:6500? ([2620:10d:c092:500::5:e213])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c964992esm156460966b.185.2025.01.10.03.42.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2025 03:42:09 -0800 (PST)
Message-ID: <31ea58e9-147e-4c6d-861e-97f0cc7792bb@gmail.com>
Date: Fri, 10 Jan 2025 11:42:08 +0000
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
 <4ed67e5b-c2ea-4dc3-b4c5-f8f112b0cd40@gmail.com>
 <CALu+AoSKrzcvP_wCRqPLO1+VBZzt-kuspiFf3dax8WDMDtCMgg@mail.gmail.com>
 <CALu+AoSg7=AJ5_x=ssznVCcssy+USHAGW_pHNpo7+_+KWRc+ag@mail.gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CALu+AoSg7=AJ5_x=ssznVCcssy+USHAGW_pHNpo7+_+KWRc+ag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250110_034211_466791_E2B489F6 
X-CRM114-Status: GOOD (  14.10  )
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



On 10/01/2025 11:20, Dave Young wrote:
> On Fri, 10 Jan 2025 at 19:18, Dave Young <dyoung@redhat.com> wrote:
>>
>> On Fri, 10 Jan 2025 at 19:12, Usama Arif <usamaarif642@gmail.com> wrote:
>>>
>>>
>>>
>>> On 10/01/2025 02:50, Dave Young wrote:
>>>> Hi Usama,
>>>>
>>>> On Thu, 9 Jan 2025 at 06:00, Usama Arif <usamaarif642@gmail.com> wrote:
>>>>>
>>>>> When this area is not reserved, it comes up as usable in
>>>>> /sys/firmware/memmap. This means that kexec, which uses that memmap
>>>>> to find usable memory regions, can select the region where
>>>>> efi_mem_attr_table is and overwrite it and relocate_kernel.
>>>>
>>>> Is the attr table BOOT SERVICE DATA?  If so, does efi_mem_reserve()
>>>> work for you?
>>>> Just refer to esrt.c.
>>>>
>>>
>>> Hi Dave,
>>>
>>> Its a bit difficult to reproduce the problem and therefore test the fix, but
>>> we are seeing it a lot in production. Ard proposed the same thing in
>>> https://lore.kernel.org/all/6b4780a5-ada0-405e-9f0a-4d2186177f29@gmail.com/
>>> but as I mentioned there, I dont think that efi_mem_reserve would help,
>>> as efi_mem_reserve changes e820_table, while kexec looks at
>>> /sys/firmware/memmap which uses e820_table_firmware.
>>
>> I sent a question to pm people, if the sysfs memmap comes from
>> e820_table then it will be fine. Let's see:
> s/e820_table/e820_table_kexec
> 

Do you mean change /sys/firmware/memmap to point to e820_table_kexec instead
of e820_table_firmware [1]? 
I thought of doing this when the first bug was encountered last year, but
didn't do it as I thought it would be frowned upon to change what sysfs file
exposes to userspace.

[1] https://elixir.bootlin.com/linux/v6.12.6/source/arch/x86/kernel/e820.c#L31


>> https://lore.kernel.org/all/CALu+AoS-nk4u=9UYP7BLS=diOxjJRf+vfv7KHXG=uXozoYazsw@mail.gmail.com/
>>
>>>
>>> Thanks,
>>> Usama
>>>
>>>> Thanks
>>>> Dave
>>>>
>>>
> 


