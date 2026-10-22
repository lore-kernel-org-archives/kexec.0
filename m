Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890EF606A31B
	for <kexec@archiver.kernel.org>; Thu, 22 Oct 2026 07:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=uurimsmR;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sjUxHJpS
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HDXHwat4zLpbZennBEg7uZauJYVMECCPqpPno/TLnRE=; b=uurimsmRkHzL6Q0TcD3VQ6uolk
	EmhGCw60OivaPyNzNx8TUAV7qIJRbT/UFp+kCRNLt+6hY42VZWCVL1fVyq0aU0YUsIKf3yWi2rZvm
	KITC0OQNH6Im7x649xcCh2BTIms6PokKpXRWXUgZBH/c5C6rwsOQmeWzilXqxCsqWm0FA74mWsbYR
	6UBgUIqHGk3ab576HLUG6IaLpxHDDimaVIy0oJscHmnBru05G7ti0UnlxHQ08mJtxsYjtdapbMcPS
	ep8V3gcHTN/fRdbHwKtR5I8xJchbP+YkilpAIDnzSJPOFGd6e7oEum6Cjip3C1O5Gvwp6jqgRXlFP
	pv4xP6Yw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJnU9-0000000Dace-0uKe;
	Thu, 22 Oct 2026 07:45:13 +0000
Received: from mail-pj2-x0a.google.com ([2607:f8b0:4864:39::a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJnU4-0000000Daaz-46Lc
	for kexec@lists.infradead.org;
	Thu, 22 Oct 2026 07:45:10 +0000
Received: by mail-pj2-x0a.google.com with SMTP id 98e67ed59e1d1-3ac144119e4so751852a91.0
        for <kexec@lists.infradead.org>; Thu, 22 Oct 2026 00:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792655108; x=1793259908; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HDXHwat4zLpbZennBEg7uZauJYVMECCPqpPno/TLnRE=;
        b=sjUxHJpSA3mI6smHrfY24HuKW/hjm060HnpLLz0J6BF63PvljYtEt3DaB0SmTvuiG7
         idG6V2Hd5irMkkDIF0mfNdP/lg+JEcgLOpLp4fe9PfgNxdjuyyAigSEuy6D9aGBjMs8l
         ii6ALoPqGuzkrNtzgxPmk8ega01C1f92HWf1hz1XuFhwUuUa4CZDBqgfA9aNgY7gUqSX
         5feSC2knT6vhwm/hSIIat7B/4bRT9wNmuqsIfp9CzCVzw/NhrffA+Jhj7Hrv+6RoXZFT
         YuxYsXLWXXoFRKBkw/AyhR1FlnaKWqwmZw2OaBFUXPP4qAhzYG+4TskwKSQvQUlA/5tc
         Ak1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792655108; x=1793259908;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HDXHwat4zLpbZennBEg7uZauJYVMECCPqpPno/TLnRE=;
        b=BU8enwejZM7PzV5bZ1KLa9nhrgIE8o28Rb7RTJNXldy2mps+KEV/6vObbnuCiDXhWe
         zzSLOu8Zrl+6PTRpzA9CqMP3w4zoZQ9dFfa7+FRjGKMz15cQ1gibEJJY0n2TdSZBe/0Y
         BUlIW3nCNqzGE5OSLnpleBdonqZyFONzEYqhbjzzO4dzo9VS4iBYctesShWkrVVOYgqE
         9ljFvhdLwPxqDcm0JnMKj394WsMdIkaZs5MEvexzaftb29Tb8xF2qszJHNc1dQz3JPXz
         IZgWqtDLrBFZc4/WhI4GFdL1I8kJOO5lorSE5HjFWnbHxJOFc3GvyzCHFJQblrJ+hS5u
         x/Kw==
X-Forwarded-Encrypted: i=1; AKwUvByi1S9uBOpROhzMIqn5LiIO3R0VSOarlyH/+oxT2FkCHJsluUA35/H5Kf3ZU3ENm/WiUBIKDw==@lists.infradead.org
X-Gm-Message-State: AFq9FYJMIliAgAD8fs5qcueD0zCc7w2a1HnAmhkJj6I3zHQJPh5Yklt6
	k4KLquMfLjFyvAJZzeNq0jaeu23sgQX8uT/VxU/GFvpt4dzcfFo06McKjIC8ueLycCw81g==
X-Gm-Gg: AYBFou0DRgk7l6vGD3UMDny7QSqVUrJ37PGBanjAD7Uw+6r9baOJcPmC+M9QvoQVsY6
	QnL6Z6TSBLDRy7yJkowqtL+3kBqEhL9yPg6OwXHYrIing1BRStm32y26esff62v7qCXy/M8K58G
	XbPWvI41XOKkQX6DmLYwGX2Vr5uj6+3zgz3kymgwDj65CiE8o12SctQa7dkCSiR0ytXtrVzfnOb
	mm+OKc0reSb0av5P4hL6mGZIRBW2kacIMMtDnUpiNb2y6EwI9XVyael5Am97dSBo2zNtqCe+Nqj
	Xr7NStK+OxtW0jQoOInNvg3NgFAEesRLVs0qk/jolH7OGP2BC4LTYV4SzT4qt8Vy+2oNq2Sh09h
	okNFysvs4slNyJEffCl0yoMUg+96HevMe9nUS5BJ1BkclsCpzN0d+s/Sd41ALb1DR0noHj8ujrS
	bJ2Er0i5Zw3909B0g4yZGh/Dq9iMiJikZJWcX8B3NWV0ZtMuKv35/i/HS9NljZV658zJQo6T09F
	eUE/cduXMCrVuTyeIzxjbOIFv1ia/h6H4ZuXGXjBHw7urc+XTEqgP35nTdadgk=
X-Received: by 2002:a17:90b:5870:b0:3ab:5758:3766 with SMTP id 98e67ed59e1d1-3ad8707700dmr3724932a91.51.1792655107849;
        Thu, 22 Oct 2026 00:45:07 -0700 (PDT)
Received: from [10.125.112.22] ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ada49366fdsm2945920a91.14.2026.10.22.00.44.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2026 00:45:06 -0700 (PDT)
Message-ID: <098ff899-81b9-4ccc-a143-1e324446258f@gmail.com>
Date: Thu, 22 Oct 2026 15:44:48 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 3/8] crash_core: serialize crash header preparation
 against hotplug
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
 chenhuacai@kernel.org, kernel@xen0n.name, pjw@kernel.org,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, tglx@kernel.org,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
 hpa@zytor.com, saravanak@kernel.org, akpm@linux-foundation.org,
 pasha.tatashin@soleen.com, pratyush@kernel.org, ruirui.yang@linux.dev,
 robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
 kexec@lists.infradead.org, linux-mm@kvack.org, iommu@lists.linux.dev,
 robh@kernel.org, baoquan.he@linux.dev, rppt@kernel.org,
 m.szyprowski@samsung.com
References: <20261021083011.2170525-1-chenwandun1@gmail.com>
 <20261021083011.2170525-4-chenwandun1@gmail.com>
 <12e4e687-1ff0-41b2-bdf8-7f48b29e1f2f@huawei.com>
 <a1665f9e-3116-47bc-974e-98dce408fa37@gmail.com>
 <31d63208-3ef2-420f-a0c2-d9d6d49c5e21@huawei.com>
Content-Language: en-US
From: Wandun <chenwandun1@gmail.com>
In-Reply-To: <31d63208-3ef2-420f-a0c2-d9d6d49c5e21@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261022_004509_055188_C08AEFC0 
X-CRM114-Status: GOOD (  25.05  )
X-Spam-Score: -1.8 (-)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/22/26 10:00, Jinjie Ruan wrote:
> 
> 
> 在 2026/10/21 17:48, Wandun 写道:
>>
>>
>> On 10/21/26 17:13, Jinjie Ruan wrote:
>>>
>>>
>>> 在 2026/10/21 16:30, Wandun Chen 写道:
>>>> From: Wandun Chen <chenwandun@lixiang.com>
>>>>
>>>> crash_prepare_headers() counts memory ranges before populating the
>>>> allocated crash_mem array. The weak implementation used by ARM64,
>>>> RISC-V and LoongArch walks memblock.memory, while x86 performs the same
>>>> two-pass operation over system RAM resources. Concurrent memory hotplug
>>>> can change range source between the two walks and make the populate
>>>> pass overflow cmem->ranges.
>>>>
>>>> Take device_hotplug_lock when preparing crash headers during
>>>> kexec_file_load(). The x86/riscv memory hotplug path already takes
>>>> device_hotplug_lock, so call __crash_prepare_headers() directly
>>>> to avoid recursive locking.
>>>>
>>>> Sashiko reported this issue in [1].
>>>>
>>>> Fixes: 3751e728cef2 ("arm64: kexec_file: add crash dump support")
>>>> Fixes: 1bcca8620a91 ("LoongArch: Add crash dump support for kexec_file")
>>>> Fixes: 8acea455fafa ("RISC-V: Support for kexec_file on panic")
>>>> Fixes: dd5f726076cc ("kexec: support for kexec on panic using new system call")
>>>> Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
>>>> Link: https://sashiko.dev/#/message/20260806101002.1F84E1F000E9@smtp.kernel.org [1]
>>>> Acked-by: Baoquan He <baoquan.he@linux.dev>
>>>> ---
>>>>  arch/riscv/kernel/crash.c  |  2 +-
>>>>  arch/x86/kernel/crash.c    |  2 +-
>>>>  include/linux/crash_core.h |  2 ++
>>>>  kernel/crash_core.c        | 17 +++++++++++++++--
>>>>  4 files changed, 19 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/arch/riscv/kernel/crash.c b/arch/riscv/kernel/crash.c
>>>> index fe5a4b306aae..ac8df2edf2a7 100644
>>>> --- a/arch/riscv/kernel/crash.c
>>>> +++ b/arch/riscv/kernel/crash.c
>>>> @@ -70,7 +70,7 @@ void arch_crash_handle_hotplug_event(struct kimage *image, void *arg)
>>>>  	 * Create the new elfcorehdr reflecting the changes to CPU and/or
>>>>  	 * memory resources.
>>>>  	 */
>>>> -	if (crash_prepare_headers(true, &elfbuf, &elfsz, NULL)) {
>>>> +	if (__crash_prepare_headers(true, &elfbuf, &elfsz, NULL)) {
>>>>  		pr_err("unable to create new elfcorehdr");
>>>>  		goto out;
>>>>  	}
>>>> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
>>>> index e6f23933a6df..bef008a0cb22 100644
>>>> --- a/arch/x86/kernel/crash.c
>>>> +++ b/arch/x86/kernel/crash.c
>>>> @@ -465,7 +465,7 @@ void arch_crash_handle_hotplug_event(struct kimage *image, void *arg)
>>>>  	 * Create the new elfcorehdr reflecting the changes to CPU and/or
>>>>  	 * memory resources.
>>>>  	 */
>>>> -	if (crash_prepare_headers(IS_ENABLED(CONFIG_X86_64), &elfbuf, &elfsz, NULL)) {
>>>> +	if (__crash_prepare_headers(IS_ENABLED(CONFIG_X86_64), &elfbuf, &elfsz, NULL)) {
>>>>  		pr_err("unable to create new elfcorehdr");
>>>>  		goto out;
>>>>  	}
>>>> diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
>>>> index bc087124cd78..28e7a81cf263 100644
>>>> --- a/include/linux/crash_core.h
>>>> +++ b/include/linux/crash_core.h
>>>> @@ -61,6 +61,8 @@ extern int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_ma
>>>>  				       void **addr, unsigned long *sz);
>>>>  extern int crash_prepare_headers(int need_kernel_map, void **addr,
>>>>  				 unsigned long *sz, unsigned long *nr_mem_ranges);
>>>> +int __crash_prepare_headers(int need_kernel_map, void **addr, unsigned long *sz,
>>>> +			    unsigned long *nr_mem_ranges);
>>>>  extern int crash_exclude_core_ranges(struct crash_mem **cmem);
>>>>  
>>>>  struct kimage;
>>>> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
>>>> index faa0f22dbb41..8a861a946e26 100644
>>>> --- a/kernel/crash_core.c
>>>> +++ b/kernel/crash_core.c
>>>> @@ -16,6 +16,7 @@
>>>>  #include <linux/mm.h>
>>>>  #include <linux/cpuhotplug.h>
>>>>  #include <linux/memblock.h>
>>>> +#include <linux/device.h>
>>>>  #include <linux/kmemleak.h>
>>>>  #include <linux/crash_core.h>
>>>>  #include <linux/reboot.h>
>>>> @@ -344,8 +345,8 @@ int crash_exclude_core_ranges(struct crash_mem **cmem)
>>>>  	return 0;
>>>>  }
>>>>  
>>>> -int crash_prepare_headers(int need_kernel_map, void **addr, unsigned long *sz,
>>>> -			  unsigned long *nr_mem_ranges)
>>>> +int __crash_prepare_headers(int need_kernel_map, void **addr, unsigned long *sz,
>>>> +			    unsigned long *nr_mem_ranges)
>>>>  {
>>>>  	unsigned int max_nr_ranges;
>>>>  	struct crash_mem *cmem;
>>>> @@ -382,6 +383,18 @@ int crash_prepare_headers(int need_kernel_map, void **addr, unsigned long *sz,
>>>>  	return ret;
>>>>  }
>>>>  
>>>> +int crash_prepare_headers(int need_kernel_map, void **addr, unsigned long *sz,
>>>> +			  unsigned long *nr_mem_ranges)
>>>> +{
>>>> +	int ret;
>>>> +
>>>> +	lock_device_hotplug();
>>>> +	ret = __crash_prepare_headers(need_kernel_map, addr, sz, nr_mem_ranges);
>>>> +	unlock_device_hotplug();
>>>
>>> I think this patch conflicts with my changes and would also conflict
>>> with the implementation of arm64 crash hotplug.
>>>
>>> https://lore.kernel.org/all/20260921090450.807575-15-ruanjinjie@huawei.com/
>>>
>> Have these patches already been merged? My current work is based on the latest
>> linux-next. If they have already been merged into the maintainer's branch,
>> please let me know, I will update my tree and rebase/re-adapt my changes accordingly.
>>
>>
>> Also, regarding the changes in kernel/crash_core.c: it looks like we modified
>> the same spot, the change is not wrong, is that right?
> 
> Hi Wandun,
> 
> However, I think someone should have informed me in advance; otherwise,
> doing duplicate fix work is pointless.
> 
> I see that part of your patch series modifies code I previously changed,
> but I was not CC'd.

Hi Jinjie,

Sorry for not CC'ing you. I keep the per-patch Cc lists short because
large recipient sets have caused my sends to be cut off midway before,
(I'm still trying to track down exactly where the problem is) you should
have been on the list that's my miss. You'll be on the Cc of every future
version.
> 
>>
>>> arm64 crash hotplug:
>>> https://lore.kernel.org/all/20260918100442.3841135-18-ruanjinjie@huawei.com/
>>
>> In addition, if arm64 gains crash hotplug support, the code there would indeed
>> need to be modified (to avoid a deadlock). As of now, arm64 crash hotplug
>> support has not been merged yet either, has it? I just want to make sure I
>> haven't missed anything.
> 
> Yes, you are right. If your patch series will be merged soon, I will
> develop based on it.

Also thanks for your reminder, otherwise I might later overlook the case
where arm64 has already gained crash hotplug support, and introduce bugs
as a result.


Best regards,
Wandun>
>>
>>>
>>>> +
>>>> +	return ret;
>>>> +}
>>>> +
>>>>  /**
>>>>   * crash_exclude_mem_range - exclude a mem range for existing ranges
>>>>   * @mem: mem->range contains an array of ranges sorted in ascending order
>>>
>>
> 


