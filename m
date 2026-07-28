Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFB5CC53219
	for <kexec@archiver.kernel.org>; Tue, 28 Jul 2026 06:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G9PHCPemx3I5IiaOZkfCpXgJjCP/3isLoWalQDvmgro=; b=d1jwEsnCTGxEkHeGDXyqiXhKm0
	2MxkYBs26ZNFBpQL1FGz8Il6LUSPGhzOI25Tckx9JFooOIxQbUYXh1kvKm8Rlkh61GN9JqIWpUIl2
	l6U3BV5p34oy5DiEUQshbuKB2XDt4lEq3/0B6k2vzRvGb3NexwvlY0npQ/dcN8yDwFZprzAeBxmYt
	1QiZwhbyA8aC5X6a3nQzCJRayIjliYHSAJDLWtJP5uNV97QcPFNfn6/rXWjki3fsUhAuORcge5uKp
	0oz4JXyM72hmQbnJ2a3CldQ+VbnlpNEkIOllFQaZxPlVwZxgazgusL2pb6/lVaCupgZMImUK4jEgO
	gSL6O2mw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wobZU-00000004YwX-0vmn;
	Tue, 28 Jul 2026 06:45:48 +0000
Received: from mail-pj2-x01.google.com ([2607:f8b0:4864:39::1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wobZS-00000004Yv6-0Tsk
	for kexec@lists.infradead.org;
	Tue, 28 Jul 2026 06:45:47 +0000
Received: by mail-pj2-x01.google.com with SMTP id d9443c01a7336-2ce7ac92dfcso31822465ad.1
        for <kexec@lists.infradead.org>; Mon, 27 Jul 2026 23:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785221145; x=1785825945; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G9PHCPemx3I5IiaOZkfCpXgJjCP/3isLoWalQDvmgro=;
        b=am+nuyhWGZQGDZUpub8mb0r92Upz2N0J7ZuxaYTm+jIIYULepZ49dzcDaa42V2KzOS
         76LP7TK5Nk4zuoScKMyxrO2mtH1w/a00vJZT53rh6xGk/HDUvuISqGcRHs0CtJaTSgac
         oNfMbPpJftzSGaZES45iYAX3QAcO3A5R2oHAiPQlAOqvdOUjfUnb0uAAbmg9AdVr7Zqi
         9l6z8gK8QXNBUx56U4v73Ban/tlB6udxHhyP6/NwSMJREDuq4nJQIu6fPBWh8Fvnzxu3
         Q3CZxuEN/dxegi05TFhoMkb139W2lBinS4GfztOsgjLrb4WCGoDe8Am7xXBOtQZEZ+3b
         ifYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785221145; x=1785825945;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G9PHCPemx3I5IiaOZkfCpXgJjCP/3isLoWalQDvmgro=;
        b=HlgXz9InMD2QZPsvUuPGDp8MpdHwTBZ4ANNzUCJVHCC+se/hJFqf5LO3GehkzERSKD
         jPfUhz1BidkBKg+GQV9W7b5WdxkRmNbUBc3SLUCDgxySbasx34w/SagUFLHUox67TMKC
         +PNSbcHteUNjIcuBv+6r1asbQvpp9BF8CIdVfuClKxbH67HxEGFfT34/EpzNvE41LiGi
         kpZNvchvesNtadvRrIDRUevmAVHj4H7mfblFqjAiX0kRr6hgJHBbs68FLaDMC+wOBKwz
         +SEnfqpO2RS8AWUchFei7eXHfrsQmweMurXQpgLFjCrMkr12xV+sxuguFfE7m0rek6ay
         WdFg==
X-Forwarded-Encrypted: i=1; AHgh+Rq1xUqckVPFL5C/xad6iJs1ux+PGRe0gMPHiOePy6u6jn6eQUeN2GiB6sFO7P/o2ZTZVR3tLA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yzih4T5xLWKo6abPskLWixhokCYOGEs32v1oGki9l338C9cuVn+
	aEnjpiUPBVOxWnhR4gC0FLxXUnO6X73uKv+rYmMuup5eBB6KjlMJmy/s
X-Gm-Gg: AR+sD10Ckbo88OyoZyUvIqYX+NQWVs/8acqZ/8AtJ+ARVin4yR4jfQk699nd9NP2V3F
	b3qgnQwy+jrsay6e8T7tN5AyJz8hS2juco9S+UYv20xIiYhOn+6CA9D8y20psndsDli5WWWnDPl
	OBk0K5n0cc9d3MxvJ5e/PTKrIW9NmMofb2DBUOU8L1XmsY6fEyHPJIie4EsuRB0omTe1lQrLSe7
	6V/FcnQLU2FzB8PHFFqcMWi6QZVk1H6Jdda28D6MieTSS0rAlSGvq8xBIM1G5lGcZSd4jvXe3wI
	BT9cRDUwbmuWRRlfvq+uv3u+vYf+O0axxdlF1ANs2CJRnnRw9k5T+qqNeHywcWdCbATiWcwswQH
	rogMMgy5VoaxxZ0Je/T66hpe2FsQOzrkjOdiZxiFVokj0kcKeLkuhr1cPoafxwjuzAdqUWYVtXM
	UIiaRHny9qDw==
X-Received: by 2002:a17:903:b90:b0:2ca:d9b3:715e with SMTP id d9443c01a7336-2d015c9b773mr13766995ad.9.1785221144689;
        Mon, 27 Jul 2026 23:45:44 -0700 (PDT)
Received: from [10.125.112.20] ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde5e1e26sm46147345ad.22.2026.07.27.23.45.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2026 23:45:43 -0700 (PDT)
Message-ID: <14ae96c1-707c-4999-bc9d-65ec74fbeff2@gmail.com>
Date: Tue, 28 Jul 2026 14:45:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/10] kdump: reduce vmcore size and capture time
To: Rob Herring <robh@kernel.org>, m.szyprowski@samsung.com
Cc: chenhuacai@kernel.org, kernel@xen0n.name, pjw@kernel.org,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, saravanak@kernel.org,
 bhe@redhat.com, rppt@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
 kexec@lists.infradead.org, iommu@lists.linux.dev, zhaomeijing@lixiang.com,
 catalin.marinas@arm.com, will@kernel.org, alex@ghiti.fr,
 akpm@linux-foundation.org, pasha.tatashin@soleen.com, pratyush@kernel.org,
 ruirui.yang@linux.dev, robin.murphy@arm.com
References: <20260630074715.4126796-1-chenwandun1@gmail.com>
 <20260723234126.GA3253409-robh@kernel.org>
Content-Language: en-US
From: Wandun <chenwandun1@gmail.com>
In-Reply-To: <20260723234126.GA3253409-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260727_234546_163816_8E088B7A 
X-CRM114-Status: GOOD (  21.88  )
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



On 7/24/26 07:41, Rob Herring wrote:
> On Tue, Jun 30, 2026 at 03:47:04PM +0800, Wandun Chen wrote:
>> From: Wandun Chen <chenwandun@lixiang.com>
>>
>> On SoCs that carve out large firmware-owned reserved memory (GPU
>> firmware, DSP, modem, camera ISP, NPU, ...), kdump currently dumps
>> those carveouts as part of system RAM even though their contents are
>> firmware state that is not useful for kernel crash analysis.
> 
> What about reserved regions on ACPI based systems?

ACPI based systems already filter out these reserved regions from vmcore.
In the EFI memory map, firmware carveouts are reported with the type
EFI_RESERVED_TYPE. This type of memory gets the nomap flag set in
memblock.memory (is_usable_memory() returns false in reserve_regions()
and mark these regions with nomap flag), during prepare_elf_headers(),
for_each_mem_range() filters out these nomap regions. Therefore, the
memory reserved on ACPI based systems will not be dumped into the vmcore.
> 
>> This series introduces an opt-in 'dumpable' flag [1] on struct
>> reserved_mem and uses it to filter the elfcorehdr PT_LOAD ranges on
>> DT-based architectures (arm64, riscv, loongarch). By default reserved
>> regions are treated as non-dumpable; CMA regions are explicitly opted
>> in because their pages are returned to the buddy allocator and may
>> carry key crash-analysis data.
> 
> I never like seeing the same change being made to each architecture. 
> That's generally a sign of restructuring needed. loongarch and arm64 
> prepare_elf_headers() look about the same. riscv version uses 
> walk_system_ram_res() for some reason. 
> 
> Perhaps the dumpable flag belongs in memblock instead? Then at least we 
> wouldn't need more DT APIs exposed to the arch code, and the code stays 
> independent of the firmware API.

Agreed on both points. Adding the flag to memblock can indeed eliminate
the duplicated code in prepare_elf_headers, and avoid expose APIs to the
arch code.

I will add a dumpability marker to memblock for future extensibility
and to avoid duplicating the same code across different architectures.

I'm inclined to add a nodump flag, similar to nomap, by default all memory
is dumpable, and only the small fraction of memory that carries this flag
would be excluded from the vmcore, What do you think about this approach?

walk_system_ram_res() in riscv could be reworked into the same form as in
the arm64/loongarch architectures, will do in next version.

> 
> I'd really like Marek's review on the reserved memory code changes.

Marek, could you take a look when you have a chance about the reserved
memory code changes, I'm happy to respin and address any feedback.

> 
> Rob

Best regards,
Wandun


