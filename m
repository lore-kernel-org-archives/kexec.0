Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8265606A31B
	for <kexec@archiver.kernel.org>; Wed, 21 Oct 2026 09:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=pJuHFjiv;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=buTtj0MY;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Xsaf5ppa
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qb8CCyZKDo3DU8wu9akhVT7quX2USeXAOK8NbuiE3KM=; b=pJuHFjiv1ZytgpHHYEHm/32xAX
	1jxsKjQw53ekGG9Un6rHE7yrvhBYq0sCFjK9hty0j3Z8zE7ApFeh+GoNPk2TJjcGk1gwc3u2086TN
	kRKAg2KkqfVjF+l5MU67F4wIE+791Xwqw4X4MviVM9fcj8KOaGfiRTFejw+Zb7IOLdZ8Ll8BSJMo5
	QphvcmoYI6HPvKs9fPQW61Myx3xa0HhZRpOrEGOOovMXVHRo5lHs46YClOV2K2O1E2f0iLTQ3HZvC
	YMJnqOT02G4LMXgKLgVrs3s78BTIWhRmgLNHmKdiWVzniUoyzxVffjcRH4McxJxCrfASNkVyVJGwd
	BQBCpjVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJSwV-0000000BX0s-093f;
	Wed, 21 Oct 2026 09:49:07 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJSwU-0000000BX03-0Jai
	for kexec@bombadil.infradead.org;
	Wed, 21 Oct 2026 09:49:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=qb8CCyZKDo3DU8wu9akhVT7quX2USeXAOK8NbuiE3KM=; b=buTtj0MYuUiIJXLQ/gWc7R4snP
	xVcKVnUFUxe88R+h6nH125LSrjBRF2tinwTqBd+TTiIYmHCiu6n9Dp0giuQ+giLg2IBOJdtz4/NFS
	3nSaGUOCN81xX8wqqyVivLhHBibesahG+XOcHGtS7v+aavKnMxZFPcLbYwpSibCHF7mPyPfHlnIlY
	/oVAdH9xjYqF/ZEfgfW2I+Pszy39CPgV8N/Gy6qFmf6RpnTl6YmgQQOHTX0qN/heXeA6vdoGppgJa
	UUd7pvHiPxtU/6gEdP90YCxhcPU2H2eBoaKvQTqtIZgAlusD3jHCKLqPHJTumcA5OfXad7V3S13A6
	jY9nnKLw==;
Received: from mail-pj2-x07.google.com ([2607:f8b0:4864:39::7])
	by desiato.infradead.org with esmtps (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xJSwN-00000005fdo-2NFx
	for kexec@lists.infradead.org;
	Wed, 21 Oct 2026 09:49:02 +0000
Received: by mail-pj2-x07.google.com with SMTP id d9443c01a7336-2e934c6c20aso2703245ad.0
        for <kexec@lists.infradead.org>; Wed, 21 Oct 2026 02:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792576137; x=1793180937; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qb8CCyZKDo3DU8wu9akhVT7quX2USeXAOK8NbuiE3KM=;
        b=Xsaf5ppa7LFsOQGPq9QOpzqt4Dv5wzKyElTo0JQOr9eW5kRpufU51Nkuij5kywZ8if
         /KGBrodSSyXakbFdVBVmfdeAF72RheyupBKq2XbkOip5LbBXl3uFwI/1v+1C2LbwzpSi
         wdlsD9IbeKTZztMkd8/BnRqCo8/DJPz13u3BnxHE4Nc85HkdtHe1vo+7AQMTFc90Ex++
         DQpdyEUPLEUrqYthVJPBfvAwhXbuN8gflSW+7DVh9xZBjDYq+Al4o4NMCpJWyZ0sKeNd
         2boDP5cKPh5UaHAAu4EeJ7YOe72PoZMY32qyEny6MGSzZ8lpL90frgsZA2cJBogjSgMY
         p6lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792576137; x=1793180937;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qb8CCyZKDo3DU8wu9akhVT7quX2USeXAOK8NbuiE3KM=;
        b=0aMh4zMmulR2BpiEzCghDjV3WnLl5dJhJGa7/QO5W3YzHFz6/beAqrG7znoRtxvCpo
         FBtJIXfMYTTumSDN6/2/myrJ7UC/efMJbrJH6+QOJto8qjVxWwGUdZ/jm/N5zApEJtw7
         IqgG8TLjOlbR8RDqMGMS0kUSTi4rUIRS5HIWEqKm57l5KVzJsqBitk84pmdDwz/lryRF
         18iJ/wFb7TNEPT08Hk6oiCAqpN3y+OvfnQtG2aXWda7/1Pgc6FDZWppK0AZM9dW/UwXP
         9xRnLBuMbdOy6Tp9gaG2Mh9TetIAnJ8WOeaFrScPKod0tydK92EraBqazlwuKw4du8eQ
         hERw==
X-Forwarded-Encrypted: i=1; AKwUvBwwOrnsMLZ704EljOIlvN3Vqi1t7AH9pl01TWj7hiIdABGAxCeGi+Z8hf99iXXHJg4x15sOcg==@lists.infradead.org
X-Gm-Message-State: AFq9FYJVGbi81bt//Dc43Kl5xSjNS2DxXKvXhs58gOw+aHBWuU2UrrH4
	nsa5BArNmk6tcgVa5iPktq7lAPxf9EFJjtyrY8Gn+LeKEY11dx1UOo+i
X-Gm-Gg: AYBFou3srR0bWrzZwWkplEgZNSyKqJE7ND11SZWkYEpj45+B9cgMjkVJluhMaMbEPMD
	dTIubAYRCwJ9PFvNhx/K83E+phEQcblOj8fFQmNvuEQtU28YW4hRs3zpQ7T/NjRxASI2UF0HQ+C
	Qgi0L1+IfkqtL2yGzwgECYcbKtHuquwsRyYQQoVFanhoza4Px+fV1CiHFF4TbMZ7oP2x5ZPGbBJ
	9LAtNiTGn9+H/FlkQGsWKH9+anKXCjgeNAlib/cyQz3m7w62c7cmA+97J1VAxO6eU5lFCA7ZVUI
	wkvThSnx0B8k3SVc+QTWsep0B9iLIpj+Zl1p5gX9NIYmN2HlW9FNWzDySX6LDeuhuf4/4sGLhV9
	WwrR4CiRDgkc8lsh/yj1YXE4uf3+CbYKGSPzVg+uRBx5gfjAlsrpn7+JKJXeQxTcfW4sAfagE/N
	Sy58YxKKUPMVeFUtrad9e3iwDNdx4okBlPmSBRqIcAuXPcyj2Vd/9cefOscB30Mn5YS/hFp9WbU
	HDKEAEEmfIrOwefdk1Qdoek8Nzpm/N2d9wug1k6ECTW4xOSjKhJmlSnbTzBtJg=
X-Received: by 2002:a17:902:f60e:b0:2ea:192a:13b8 with SMTP id d9443c01a7336-2ea43a13e4fmr10496695ad.20.1792576137131;
        Wed, 21 Oct 2026 02:48:57 -0700 (PDT)
Received: from [10.125.112.22] ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea3b486970sm8858055ad.62.2026.10.21.02.48.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 02:48:56 -0700 (PDT)
Message-ID: <a1665f9e-3116-47bc-974e-98dce408fa37@gmail.com>
Date: Wed, 21 Oct 2026 17:48:37 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 3/8] crash_core: serialize crash header preparation
 against hotplug
To: Jinjie Ruan <ruanjinjie@huawei.com>, robh@kernel.org,
 baoquan.he@linux.dev, rppt@kernel.org, m.szyprowski@samsung.com
Cc: catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
 chenhuacai@kernel.org, kernel@xen0n.name, pjw@kernel.org,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, tglx@kernel.org,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
 hpa@zytor.com, saravanak@kernel.org, akpm@linux-foundation.org,
 pasha.tatashin@soleen.com, pratyush@kernel.org, ruirui.yang@linux.dev,
 robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
 kexec@lists.infradead.org, linux-mm@kvack.org, iommu@lists.linux.dev
References: <20261021083011.2170525-1-chenwandun1@gmail.com>
 <20261021083011.2170525-4-chenwandun1@gmail.com>
 <12e4e687-1ff0-41b2-bdf8-7f48b29e1f2f@huawei.com>
Content-Language: en-US
From: Wandun <chenwandun1@gmail.com>
In-Reply-To: <12e4e687-1ff0-41b2-bdf8-7f48b29e1f2f@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261021_104859_979302_565992BC 
X-CRM114-Status: GOOD (  22.19  )
X-Spam-Score: 0.1 (/)
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



On 10/21/26 17:13, Jinjie Ruan wrote:
> 
> 
> 在 2026/10/21 16:30, Wandun Chen 写道:
>> From: Wandun Chen <chenwandun@lixiang.com>
>>
>> crash_prepare_headers() counts memory ranges before populating the
>> allocated crash_mem array. The weak implementation used by ARM64,
>> RISC-V and LoongArch walks memblock.memory, while x86 performs the same
>> two-pass operation over system RAM resources. Concurrent memory hotplug
>> can change range source between the two walks and make the populate
>> pass overflow cmem->ranges.
>>
>> Take device_hotplug_lock when preparing crash headers during
>> kexec_file_load(). The x86/riscv memory hotplug path already takes
>> device_hotplug_lock, so call __crash_prepare_headers() directly
>> to avoid recursive locking.
>>
>> Sashiko reported this issue in [1].
>>
>> Fixes: 3751e728cef2 ("arm64: kexec_file: add crash dump support")
>> Fixes: 1bcca8620a91 ("LoongArch: Add crash dump support for kexec_file")
>> Fixes: 8acea455fafa ("RISC-V: Support for kexec_file on panic")
>> Fixes: dd5f726076cc ("kexec: support for kexec on panic using new system call")
>> Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
>> Link: https://sashiko.dev/#/message/20260806101002.1F84E1F000E9@smtp.kernel.org [1]
>> Acked-by: Baoquan He <baoquan.he@linux.dev>
>> ---
>>  arch/riscv/kernel/crash.c  |  2 +-
>>  arch/x86/kernel/crash.c    |  2 +-
>>  include/linux/crash_core.h |  2 ++
>>  kernel/crash_core.c        | 17 +++++++++++++++--
>>  4 files changed, 19 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/riscv/kernel/crash.c b/arch/riscv/kernel/crash.c
>> index fe5a4b306aae..ac8df2edf2a7 100644
>> --- a/arch/riscv/kernel/crash.c
>> +++ b/arch/riscv/kernel/crash.c
>> @@ -70,7 +70,7 @@ void arch_crash_handle_hotplug_event(struct kimage *image, void *arg)
>>  	 * Create the new elfcorehdr reflecting the changes to CPU and/or
>>  	 * memory resources.
>>  	 */
>> -	if (crash_prepare_headers(true, &elfbuf, &elfsz, NULL)) {
>> +	if (__crash_prepare_headers(true, &elfbuf, &elfsz, NULL)) {
>>  		pr_err("unable to create new elfcorehdr");
>>  		goto out;
>>  	}
>> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
>> index e6f23933a6df..bef008a0cb22 100644
>> --- a/arch/x86/kernel/crash.c
>> +++ b/arch/x86/kernel/crash.c
>> @@ -465,7 +465,7 @@ void arch_crash_handle_hotplug_event(struct kimage *image, void *arg)
>>  	 * Create the new elfcorehdr reflecting the changes to CPU and/or
>>  	 * memory resources.
>>  	 */
>> -	if (crash_prepare_headers(IS_ENABLED(CONFIG_X86_64), &elfbuf, &elfsz, NULL)) {
>> +	if (__crash_prepare_headers(IS_ENABLED(CONFIG_X86_64), &elfbuf, &elfsz, NULL)) {
>>  		pr_err("unable to create new elfcorehdr");
>>  		goto out;
>>  	}
>> diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
>> index bc087124cd78..28e7a81cf263 100644
>> --- a/include/linux/crash_core.h
>> +++ b/include/linux/crash_core.h
>> @@ -61,6 +61,8 @@ extern int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_ma
>>  				       void **addr, unsigned long *sz);
>>  extern int crash_prepare_headers(int need_kernel_map, void **addr,
>>  				 unsigned long *sz, unsigned long *nr_mem_ranges);
>> +int __crash_prepare_headers(int need_kernel_map, void **addr, unsigned long *sz,
>> +			    unsigned long *nr_mem_ranges);
>>  extern int crash_exclude_core_ranges(struct crash_mem **cmem);
>>  
>>  struct kimage;
>> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
>> index faa0f22dbb41..8a861a946e26 100644
>> --- a/kernel/crash_core.c
>> +++ b/kernel/crash_core.c
>> @@ -16,6 +16,7 @@
>>  #include <linux/mm.h>
>>  #include <linux/cpuhotplug.h>
>>  #include <linux/memblock.h>
>> +#include <linux/device.h>
>>  #include <linux/kmemleak.h>
>>  #include <linux/crash_core.h>
>>  #include <linux/reboot.h>
>> @@ -344,8 +345,8 @@ int crash_exclude_core_ranges(struct crash_mem **cmem)
>>  	return 0;
>>  }
>>  
>> -int crash_prepare_headers(int need_kernel_map, void **addr, unsigned long *sz,
>> -			  unsigned long *nr_mem_ranges)
>> +int __crash_prepare_headers(int need_kernel_map, void **addr, unsigned long *sz,
>> +			    unsigned long *nr_mem_ranges)
>>  {
>>  	unsigned int max_nr_ranges;
>>  	struct crash_mem *cmem;
>> @@ -382,6 +383,18 @@ int crash_prepare_headers(int need_kernel_map, void **addr, unsigned long *sz,
>>  	return ret;
>>  }
>>  
>> +int crash_prepare_headers(int need_kernel_map, void **addr, unsigned long *sz,
>> +			  unsigned long *nr_mem_ranges)
>> +{
>> +	int ret;
>> +
>> +	lock_device_hotplug();
>> +	ret = __crash_prepare_headers(need_kernel_map, addr, sz, nr_mem_ranges);
>> +	unlock_device_hotplug();
> 
> I think this patch conflicts with my changes and would also conflict
> with the implementation of arm64 crash hotplug.
> 
> https://lore.kernel.org/all/20260921090450.807575-15-ruanjinjie@huawei.com/
> 
Have these patches already been merged? My current work is based on the latest
linux-next. If they have already been merged into the maintainer's branch,
please let me know, I will update my tree and rebase/re-adapt my changes accordingly.


Also, regarding the changes in kernel/crash_core.c: it looks like we modified
the same spot, the change is not wrong, is that right?

> arm64 crash hotplug:
> https://lore.kernel.org/all/20260918100442.3841135-18-ruanjinjie@huawei.com/

In addition, if arm64 gains crash hotplug support, the code there would indeed
need to be modified (to avoid a deadlock). As of now, arm64 crash hotplug
support has not been merged yet either, has it? I just want to make sure I
haven't missed anything.

> 
>> +
>> +	return ret;
>> +}
>> +
>>  /**
>>   * crash_exclude_mem_range - exclude a mem range for existing ranges
>>   * @mem: mem->range contains an array of ranges sorted in ascending order
> 


