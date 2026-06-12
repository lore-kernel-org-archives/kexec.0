Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8942BCD4F2C
	for <kexec@archiver.kernel.org>; Fri, 12 Jun 2026 07:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=66pdCW0yOW5Nk6MUhQzAUTYI58FQ4Ifcfuf+SyuK5QE=; b=Vnq8JJAPqlWKagIOlEDxdQ84aj
	HdnIkF+sylIsfHE1S/0doa7SrYQ6s4+4UdzOlASfqwoBEUupSVR++ZHnfKnQQZ7Fn38GSi52Nj64X
	GwQrCK5Bo1+gQtMOnvpSCb8gs+jHwhF/LM7bVJq6MXtAvA54ZcIN8ke4z1E1P2mNcaUlQxHo2cYko
	A/IhymUR+Dznb71ht3mpQL71kxMVtEb8tfrDewcQUVhIJy1BRQZsDBCzogTexp6xEA0GU3kPH2zdy
	T/xu5hb4esncOdEGN6Dv/JWx0fsNknTzu4kBv25P9CLLMpqzBD1hzcr9NKr/c50J9jrBsbpfQZ389
	gbajvQ5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXwJl-0000000ATNU-2WLY;
	Fri, 12 Jun 2026 07:28:41 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXwJi-0000000ATMC-01FV
	for kexec@lists.infradead.org;
	Fri, 12 Jun 2026 07:28:40 +0000
Received: by mail-pf1-x441.google.com with SMTP id d2e1a72fcca58-8423f869421so579097b3a.3
        for <kexec@lists.infradead.org>; Fri, 12 Jun 2026 00:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781249317; x=1781854117; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=66pdCW0yOW5Nk6MUhQzAUTYI58FQ4Ifcfuf+SyuK5QE=;
        b=knH7F9p6e24S5Bxa6iqKH/CvgHklIVx6BRnNu73Kz3Q3OxpIGc6AQ1O7g78dWAbHuy
         oQNYIYZTpY6SAQfOG/R5Ci44WGh1V8Il2NpZW+Zn0bcoWNyyXWIHEutibyl0AIf4VPVw
         P5w4yf3HHTBHE79HmubGI0yy053QDJJxm8ThjzBLitBVOj1S/r9zjdL9SMmhWLTPRVhs
         wn1F41jcrviR15ZJCke8aD7YE2K5yoe8jNyUvBDYYvZ7xli71R1sXGF2qBxgkBC3q/bM
         CuyuSM6FKy9KLab7S7KM0fLsrT6utCqGYANTc3OAm6oF5fmuwEp9cetNRqb+V1AtzIjC
         i7LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781249317; x=1781854117;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=66pdCW0yOW5Nk6MUhQzAUTYI58FQ4Ifcfuf+SyuK5QE=;
        b=IwzjSTUw9i1l+ZKTC9kxsmSQhaFdPnzp9SC8Cm5Lpiz2IsUJvBAAWq0YoBXM8/2QtS
         LB8Jxbz0bZseCzbcOVTcJLk3trHcHXyxwtm96TmJlsRBcKDib85m+tFNw0Vf98bFUzRC
         qpC0ymHRdUDGT1HtVXuIoCHvzAdEfoIXteGsdUUPgW81mNh7Dn8aQWKD4REr0GUfzJTJ
         WO5yJDCFceONy017/pE8h8AEsZnRtSI8VjZsFqDY4UpXt7DC+Gmjz2i4qD5OqKV98dtM
         AuVFkTGuAlU8gBZfrZvTYUL4dF7TSBgQfav6pwVtTptSPA9g11GPTZ2cjn1Ix/70EQQl
         e3XA==
X-Forwarded-Encrypted: i=1; AFNElJ+wO2rsLLHlEdM3WWGHWyPVLT6fsVxpf5qBxqf3RTAiOus/QbiSYjqVVve5ROec6PFl8UWmHw==@lists.infradead.org
X-Gm-Message-State: AOJu0YwTce1omNA8EGA905j9okboAvl2KEYQlcCbjTIMS4QtvCi6jlXd
	JtbzMw338txyYE79ANe0f6tY2nSKyx8GfLcBC9uEh68S9gF4bBlFzKE2
X-Gm-Gg: Acq92OFh4THFMw0A1hrdYGi9fuCszL+N5KOIA4bPYwUMuWp8KqT7cOnes2RXweL8gXn
	q9WieY1+Wex6CMcmig9Af726uCx8VKYbE1Ln1bb7Velp5l8ptK0IVupXayES2Hia2kp8agvbE7s
	S68FV7Clc9e5wpKezu4uRrP+B3fUW+CyGy+Eq6isd5YUiSKDFSwDezQplGQAr9EpdvOKETEssk3
	o0ejYFucPQ/5sJAi/bWQsqLSAvWPyVwucLw+OFSudJqSKRvr+pQzJqDMcRoLRNVHUzo23HuqaQI
	ILQsusDROQUw3+5XYrDZcPemCOWco5VSKf0Fn9408N1qFGwJWCgv/WiogNvT1h6ZGj/0KeU106q
	/t4EWCvbq1K40EORtx393e5jxXCD1O1Ur++kLaFWUvJDZQnCJ3hR+ufXfwbrEhkUxQo4Am4wc3h
	FPrWFdmOEGzwhhsu+qtclV7JaYxxDcNelQAyjutzpreQ==
X-Received: by 2002:a05:6a00:218c:b0:842:708f:39a6 with SMTP id d2e1a72fcca58-8434cc08379mr1646577b3a.10.1781249316540;
        Fri, 12 Jun 2026 00:28:36 -0700 (PDT)
Received: from [10.125.112.20] ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434afc8a9bsm1278464b3a.31.2026.06.12.00.28.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2026 00:28:35 -0700 (PDT)
Message-ID: <27a06e00-ac47-4e5f-8033-4e89f15d0411@gmail.com>
Date: Fri, 12 Jun 2026 15:28:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/11] kdump: reduce vmcore size and capture time
To: Baoquan He <baoquan.he@linux.dev>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
 devicetree@vger.kernel.org, kexec@lists.infradead.org,
 iommu@lists.linux.dev, zhaomeijing@lixiang.com, Rob Herring
 <robh@kernel.org>, saravanak@kernel.org, bhe@redhat.com, rppt@kernel.org,
 pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 chenhuacai@kernel.org, kernel@xen0n.name, catalin.marinas@arm.com,
 will@kernel.org, alex@ghiti.fr, akpm@linux-foundation.org,
 pasha.tatashin@soleen.com, pratyush@kernel.org, ruirui.yang@linux.dev,
 m.szyprowski@samsung.com, robin.murphy@arm.com
References: <20260527032917.3385849-1-chenwandun1@gmail.com>
 <7ed207fa-4c86-426a-8570-495902ce04c3@gmail.com>
 <a3993db0-6975-455d-9674-4fd7cfcf80fc@gmail.com>
 <aiqkKe1gXPZ5LZ7t@MiWiFi-R3L-srv>
Content-Language: en-US
From: Wandun <chenwandun1@gmail.com>
In-Reply-To: <aiqkKe1gXPZ5LZ7t@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260612_002838_056133_7DC10ADC 
X-CRM114-Status: GOOD (  21.74  )
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



On 6/11/26 20:03, Baoquan He wrote:
> On 06/11/26 at 11:09am, Wandun wrote:
>>
>>
>> On 6/11/26 10:09, Wandun wrote:
>>>
>>>
>>> On 5/27/26 11:29, Wandun Chen wrote:
>>>> From: Wandun Chen <chenwandun@lixiang.com>
>>>>
>>>> On SoCs that carve out large firmware-owned reserved memory (GPU
>>>> firmware, DSP, modem, camera ISP, NPU, ...), kdump currently dumps
>>>> those carveouts as part of system RAM even though their contents are
>>>> firmware state that is not useful for kernel crash analysis.
>>>>
>>>> This series introduces an opt-in 'dumpable' flag [1] on struct
>>>> reserved_mem and uses it to filter the elfcorehdr PT_LOAD ranges on
>>>> DT-based architectures (arm64, riscv, loongarch). By default reserved
>>>> regions are treated as non-dumpable; CMA regions are explicitly opted
>>>> in because their pages are returned to the buddy allocator and may
>>>> carry key crash-analysis data.
>>>>
>>>> The series is organized as follows:
>>>> Patches 1-3: Pre-existing fixes and a small prep change.
>>>> Patches 4-5: Restructure to allow appending /memreserve/ entries.
>>>> Patches 6-7: Add a dumpable flag and append /memreserve/ entries.
>>>> Patch 8: Add generic kdump helpers.
>>>> Patches 9-11: Wire the helpers into arm64, riscv and loongarch kdump
>>>>                elfcorehdr preparation.
>>> Hi,
>>>
>>> Gentle ping on this series.
>>>
>>> Status summary:
>>> -patch 03: respun separately per Rob's suggestion, picked up for 7.2
>>> -patch 06: Acked-by: Marek Szyprowski -patch 09: Acked-by: Will Deacon
>>> The remaining patches (01, 02, 04, 05, 07, 08, 10, 11) are still
>>> awaiting review. your feedback would be greately appreciated. I know we
>>> are at the end of 7.1 -rc cycle, I don't want to rush this series, just
>>> collecting more feedback, and will send next version based on 7.2-rc1.
>>> If spliting the series into smaller logical group would make review
>>> easier, please let me know. Best regards, Wandun
>>
>> Apologies for the formatting issue in my previous email.
>> Here is the properly formatted version.
>>
>> Gentle ping on this series.
> 
> Thanks for the effort, the overral looks good to me at 1st glance. I will
> check if there's concern on generic part. And meanwhile, I am wondering
> if there's any chance x86 or other ARCH-es w/o OF/FDT can also choose to
> not dump some areas, e.g GPU stolen memory. Surely, that's another story.

Thanks for the review, Baoquan.

IIUC, reserved memory is already excluded from vmcore on x86.

Reserved memory is typed as E820_TYPE_RESERVED in the e820 table, and
insert into iomem resource tree with IORESOURCE_MEM flag. The x86 kdump
patch uses walk_system_ram_res() which scan iomem resource tree, and
only collects ranges with IORESOURCE_SYSTEM_RAM flag, so reserved
regions are excluded.


Best regards,
Wandun
> 
>>
>> Status summary:
>> - patch 03: respun separately per Rob's suggestion, picked up for 7.2
>> - patch 06: Acked-by: Marek Szyprowski
>> - patch 09: Acked-by: Will Deacon
>>
>> The remaining patches (01, 02, 04, 05, 07, 08, 10, 11) are still
>> awaiting review. Your feedback would be greatly appreciated.
>>
>> I know we are at the end of 7.1-rc cycle, I don't want to rush this
>> series, just collecting more feedback, and will send next version based
>> on 7.2-rc1.
>>
>> If splitting the series into smaller logical groups would make review
>> easier, please let me know.
>>
>> Best regards,
>> Wandun
>>
>>
>>>>
>>>> v2 --> v3:
>>>> 1. Fix out-of-bounds issue if device tree lacks /reserved-memory node.[2]
>>>> 2. Fix UAF issue when alloc_reserved_mem_array() fails.
>>>> 3. Add some prepare patches.
>>>>
>>>> v1 --> v2:
>>>> 1. v1 added an opt-out DT property ('linux,no-dump'). Per Rob's
>>>>     feedback [1], v2 drop that property and exclude reserve memory
>>>>     by default.
>>>> 2. Split some prepared patches from the original patches.
>>>> 3. Address coding-style comments on patch 5 from Rob.
>>>>
>>>> [1] https://lore.kernel.org/lkml/20260506144542.GA2072596-
>>>> robh@kernel.org/
>>>> [2] https://sashiko.dev/#/patchset/20260520091844.592753-1-
>>>> chenwandun%40lixiang.com?part=4
>>>>
>>>> Wandun Chen (11):
>>>>    of: reserved_mem: handle NULL name in of_reserved_mem_lookup()
>>>>    kexec/crash: provide crash_exclude_mem_range() stub when
>>>>      CONFIG_CRASH_DUMP=n
>>>>    of: reserved_mem: avoid post-init UAF when alloc_reserved_mem_array()
>>>>      fails
>>>>    of: reserved_mem: zero total_reserved_mem_cnt if no valid
>>>>      /reserved-memory entry
>>>>    of: reserved_mem: split alloc_reserved_mem_array() from
>>>>      fdt_scan_reserved_mem_late()
>>>>    of: reserved_mem: add dumpable flag to opt-in vmcore
>>>>    of: reserved_mem: save /memreserve/ entries into the reserved_mem
>>>>      array
>>>>    of: reserved_mem: add kdump helpers to exclude non-dumpable regions
>>>>    arm64: kdump: exclude non-dumpable reserved memory regions from vmcore
>>>>    riscv: kdump: exclude non-dumpable reserved memory regions from vmcore
>>>>    loongarch: kdump: exclude non-dumpable reserved memory regions from
>>>>      vmcore
>>>>
>>>>   arch/arm64/kernel/machine_kexec_file.c     |   6 ++
>>>>   arch/loongarch/kernel/machine_kexec_file.c |   6 ++
>>>>   arch/riscv/kernel/machine_kexec_file.c     |   4 +
>>>>   drivers/of/fdt.c                           |  11 +-
>>>>   drivers/of/of_private.h                    |   3 +
>>>>   drivers/of/of_reserved_mem.c               | 117 +++++++++++++++++++--
>>>>   include/linux/crash_core.h                 |   6 ++
>>>>   include/linux/of_reserved_mem.h            |  15 +++
>>>>   kernel/dma/contiguous.c                    |   1 +
>>>>   9 files changed, 157 insertions(+), 12 deletions(-)
>>>>
>>>
>>


