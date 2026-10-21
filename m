Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B52606A31A
	for <kexec@archiver.kernel.org>; Wed, 21 Oct 2026 08:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=PYhgV9lx;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=UGdVZQGF
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=72fCXYnwXZJQ3k3U2Ed815XR/8CaxvvHXwHA6M9NPgM=; b=PYhgV9lxKhdt/8zTPsP8M2clvS
	DzjqNOflHelHnlSLWqtlumf/RpKyR6C23o4fpxBEyoq/yG29HnjH38LolYVJusi8bY28hVyiWHzHO
	fMyyBC/mqO2wIzotYO69gS8jPnoIlAkiBqWLucrTZqMjB32rZ5feyVdMEaZey86j2nzUQgN1h8hrD
	4xOCTwshSPi0b0PWEawmtVh5OK4mxAv6GJikzyVts/5gwn/HtBaZXcw7Q37Xdhfxk9XmNQ0irR2wG
	2ln7zm+h5zcQlz1/v095pPJxGgAJnbAZ2zAHFYC2dESEsTHKrn3V/qDqLDW5FoQwVNqph8H4wD77i
	YOaEbsoA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJRgs-0000000BLnS-2vqH;
	Wed, 21 Oct 2026 08:28:54 +0000
Received: from canpmsgout06.his.huawei.com ([113.46.200.221])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJRgo-0000000BLmJ-43a6;
	Wed, 21 Oct 2026 08:28:53 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=72fCXYnwXZJQ3k3U2Ed815XR/8CaxvvHXwHA6M9NPgM=;
	b=UGdVZQGF4bCI41N7zSwSS2YVkuJadnmqUUi6Jdq3mJ42sRZVsU1/2gUNwT6rK3ZXM+JpSIzPK
	MUvNAK1AvPtX7Bd3DM7r49nubQkWJ5kUsbXxURyNHwjLgEAa8k8VKn+B4fWaTxUHBbQFiM/QgOq
	IpV4Gv4HXs64YouQo7jyjaI=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4j8j9B0QvSzRhTC;
	Wed, 21 Oct 2026 16:28:30 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 56B1440561;
	Wed, 21 Oct 2026 16:28:34 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemk200008.china.huawei.com
 (7.202.194.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 21 Oct
 2026 16:28:32 +0800
Message-ID: <b729d819-39c9-42a1-8f9c-49019091b81f@huawei.com>
Date: Wed, 21 Oct 2026 16:28:31 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/14] x86/crash: Fix massive out-of-bounds write on
 32-bit Highmem
To: Mike Rapoport <rppt@kernel.org>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <mark.rutland@arm.com>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <maddy@linux.ibm.com>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <chleroy@kernel.org>,
	<ritesh.list@gmail.com>, <sshegde@linux.ibm.com>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
	<dakr@kernel.org>, <akpm@linux-foundation.org>, <baoquan.he@linux.dev>,
	<pasha.tatashin@soleen.com>, <pratyush@kernel.org>, <ruirui.yang@linux.dev>,
	<leitao@debian.org>, <yeoreum.yun@arm.com>, <sourabhjain@linux.ibm.com>,
	<robh@kernel.org>, <coxu@redhat.com>, <kees@kernel.org>,
	<tangyouling@kylinos.cn>, <liukexin@kylinos.cn>, <zhangtianyang@loongson.cn>,
	<guodongtai@kylinos.cn>, <maqianga@uniontech.com>, <chao.gao@intel.com>,
	<kai.huang@intel.com>, <vishal.l.verma@intel.com>, <seanjc@google.com>,
	<piliu@redhat.com>, <thuth@redhat.com>, <jbouron@amazon.com>,
	<me@linux.beauty>, <mclapinski@google.com>, <graf@amazon.com>,
	<bgwin@google.com>, <hbathini@linux.ibm.com>, <eric.devolder@oracle.com>,
	<takahiro.akashi@linaro.org>, <james.morse@arm.com>, <palmer@rivosinc.com>,
	<x86@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <loongarch@lists.linux.dev>,
	<linuxppc-dev@lists.ozlabs.org>, <driver-core@lists.linux.dev>,
	<kexec@lists.infradead.org>
References: <20260921090450.807575-1-ruanjinjie@huawei.com>
 <20260921090450.807575-10-ruanjinjie@huawei.com>
 <179248377976.302547.17579416672238014424.b4-review@b4>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <179248377976.302547.17579416672238014424.b4-review@b4>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemk200008.china.huawei.com (7.202.194.74)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261021_012851_346282_3183E4A3 
X-CRM114-Status: GOOD (  26.89  )
X-Spam-Score: -2.1 (--)
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
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



在 2026/10/20 16:09, Mike Rapoport 写道:
> Hi Jinjie,
> 
>> On 32-bit x86 systems with HIGHMEM, kmap_local_page() only maps a single
>> 4KB page. However, the elfcorehdr segment can span several pages (up to
>> hundreds of kilobytes).
>>
>> The original code blindly copies 'elfsz' bytes at once via
>> memcpy_flushcache(), overwriting adjacent fixmap entries or critical
>> virtual addresses.
>>
>> Fix this by copying the new elfcorehdr page by page.
> 
> This is independed of other fixes and can be sent as a separate x86b fix.

Yes

> 
>> Cc: Thomas Gleixner <tglx@kernel.org>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Borislav Petkov <bp@alien8.de>
>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>> Cc: "H. Peter Anvin" <hpa@zytor.com>
>> Cc: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>> Cc: Vishal Verma <vishal.l.verma@intel.com>
>> Cc: Baoquan He <baoquan.he@linux.dev>
>> Cc: Chao Gao <chao.gao@intel.com>
>> Cc: Sean Christopherson <seanjc@google.com>
>> Cc: Eric DeVolder <eric.devolder@oracle.com>
>> Cc: Hari Bathini <hbathini@linux.ibm.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
>> Cc: stable@vger.kernel.org
>> Fixes: ea53ad9cf73b ("x86/crash: add x86 crash hotplug support")
>> Link: https://sashiko.dev/#/patchset/20260907125404.922123-1-ruanjinjie%40huawei.com
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
>>  arch/x86/kernel/crash.c | 26 +++++++++++++-------------
>>  1 file changed, 13 insertions(+), 13 deletions(-)
>>
>> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
>> index e681ec9cf1dc8..3c9f4fbbe7ff0 100644
>> --- a/arch/x86/kernel/crash.c
>> +++ b/arch/x86/kernel/crash.c
>> @@ -447,9 +447,10 @@ unsigned int arch_crash_get_elfcorehdr_size(void)
>>   */
>>  void arch_crash_handle_hotplug_event(struct kimage *image, void *arg)
>>  {
>> -	void *elfbuf = NULL, *old_elfcorehdr;
>>  	unsigned long mem, memsz;
>>  	unsigned long elfsz = 0;
>> +	void *elfbuf = NULL;
>> +	unsigned long done;
>>  
>>  	/*
>>  	 * As crash_prepare_elf64_headers() has already described all
>> @@ -484,21 +485,20 @@ void arch_crash_handle_hotplug_event(struct kimage *image, void *arg)
>>  
>>  	/*
>>  	 * Copy new elfcorehdr over the old elfcorehdr at destination.
>> -	 */
>> -	old_elfcorehdr = kmap_local_page(pfn_to_page(mem >> PAGE_SHIFT));
>> -	if (!old_elfcorehdr) {
>> -		pr_err("mapping elfcorehdr segment failed\n");
>> -		goto out;
>> -	}
>> -
>> -	/*
>> -	 * Temporarily invalidate the crash image while the
>> -	 * elfcorehdr is updated.
>> +	 * The segment is physically contiguous but can span several pages.
>> +	 * On 32-bit Highmem architectures, kmap_local_page() maps only a
>> +	 * single page at a time, so copy page by page.
>>  	 */
>>  	xchg(&kexec_crash_image, NULL);
>> -	memcpy_flushcache(old_elfcorehdr, elfbuf, elfsz);
>> +	for (done = 0; done < elfsz; ) {
>> +		size_t chunk = min_t(size_t, PAGE_SIZE, elfsz - done);
>> +		void *dst = kmap_local_page(pfn_to_page((mem + done) >> PAGE_SHIFT));
>> +
>> +		memcpy_flushcache(dst, elfbuf + done, chunk);
>> +		kunmap_local(dst);
>> +		done += chunk;
>> +	}
> 
> HIGMEM is only enabled on 32-bit and there elfsz cannot be "massive"
> because it is the size of the headers just built for the CPUs and RAM
> ranges actually present, not the large memsz reserved for hotplug.
> On x86_32 (NR_CPUS <= 64) that is a few KiB at most.
> 
> Also, crashkernel is capped at CRASH_ADDR_HIGH_MAX = SZ_512M on X86_32,
> which is below the default lowmem limit. For lowmem pages,
> kmap_local_page() returns the contiguous direct-map address, so the old

Hi Mike,

x86 32-bit doesn't support memory hotplug, and NR_CPUS is capped at 8.

config NR_CPUS_RANGE_END
    int
    depends on X86_32
    default    8 if  SMP
    default    1 if !SMP

According to the elf header size calculation in
crash_prepare_elf64_headers():

- nr_phdr = num_possible_cpus() + nr_mem_ranges + 2
- sizeof(Elf64_Ehdr) = 64
- sizeof(Elf64_Phdr) = 56

so:
    elf_sz = 64 + (num_possible_cpus() + nr_mem_ranges + 2) * 56

To exceed 4K:

    64 + (num_possible_cpus() + nr_ranges + 2) * 56 > 4096


So we'd need at least 60+ RAM ranges, which seems unlikely on real
hardware without memory hotplug. I think this problem can't actually be
triggered in practice, so we can safely drop this patch.

> code was already fine.
> 
> So the overflow needs the crash region to be in highmem, either through
> crashkernel=size@offset above lowmem or through a large vmalloc=
> setting, and an elfcorehdr larger than one page.
> 
> It is still worth fixing, but please drop "massive" from the subject.
> 
> The changelog should also mention the conditions when this could happen.
> 

-- 
Best regards,
Jinjie


