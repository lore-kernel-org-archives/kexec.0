Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA586C982EF
	for <kexec@archiver.kernel.org>; Sun, 20 Sep 2026 20:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4CXJGmKHG01Cx5WADm45ZnwIf+yzPgsSp4LXsSCGK8w=; b=46gtoViu7kCmniTHfq1I5E8GK0
	CXu3HomdTGwqc2pGs8GnvTHK2t4KegA9adBDZaQ1h7vkyUwd4TpZq/TQsTqRjD4wwFU13DVNy+9G+
	g7U7l4JFOiLeYAxBD0NN2QAZ80WoGNsbn82PNZ1JPnnk/0bozpeYF67VYVXHkVettmDWZzAmRt2qT
	jwjYDrdpUz1I8rv70rLSnGC/bUilJNMaTndGJjnKPnWofAoOyDOO2Dw/EToL0g7ua0qpUhhKPI0sY
	1g4Xaeg4OObwHk+CmMI1j9Ks+xq0vu6HkUNlytKx9gnrijSZEJlS+0rc37416HlgbOxS2wqLE5EU6
	NuUP0Pfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8O4q-00000000NX8-3wz5;
	Sun, 20 Sep 2026 20:23:56 +0000
Received: from [113.46.200.227] (helo=canpmsgout12.his.huawei.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x88bU-0000000GqI9-15h0;
	Sun, 20 Sep 2026 03:52:38 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=4CXJGmKHG01Cx5WADm45ZnwIf+yzPgsSp4LXsSCGK8w=;
	b=1lkRrGqDddig7anIp5WuNHAm+CuT3FvIsggB6VBKbwEF2UUvgcG9HIXey+Zr7ZvRIoY0aGqG4
	b1NaWsV+IYNc9zNPu7OWgW8LLxF5UL3Hg51zBkUv0TQ316qIuIhBTx2h1CSpbZOxa4mSd/F9cTt
	FP44s2lWygtUjNf1ecHgMFI=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hnXG031FSznTZk;
	Sun, 20 Sep 2026 11:41:12 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 4E14F40572;
	Sun, 20 Sep 2026 11:52:15 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemk200008.china.huawei.com (7.202.194.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Sun, 20 Sep 2026 11:52:12 +0800
Message-ID: <7e624b9b-b759-44c6-b1b8-810c36a066c5@huawei.com>
Date: Sun, 20 Sep 2026 11:52:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/17] crash: Normalize the kexec_load elfcorehdr at
 load time
To: <sashiko-reviews@lists.linux.dev>, <baoquan.he@linux.dev>,
	<gregkh@linuxfoundation.org>, <ruirui.yang@linux.dev>, <npiggin@gmail.com>,
	<liukexin@kylinos.cn>, <dave.hansen@linux.intel.com>,
	<mclapinski@google.com>, <ritesh.list@gmail.com>,
	<takahiro.akashi@linaro.org>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>, <will@kernel.org>, <pratyush@kernel.org>,
	<coxu@redhat.com>, <mingo@redhat.com>, <zhangtianyang@loongson.cn>,
	<linux-fsdevel@vger.kernel.org>, <sourabhjain@linux.ibm.com>,
	<hpa@zytor.com>, <rafael@kernel.org>, <graf@amazon.com>,
	<jbouron@amazon.com>, <yeoreum.yun@arm.com>, <hbathini@linux.ibm.com>,
	<chenhuacai@kernel.org>, <akpm@linux-foundation.org>,
	<lizhengyu3@huawei.com>, <chleroy@kernel.org>, <adityag@linux.ibm.com>,
	<dakr@kernel.org>, <piliu@redhat.com>, <pasha.tatashin@soleen.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mm@kvack.org>,
	<ardb@kernel.org>, <leitao@debian.org>, <catalin.marinas@arm.com>,
	<kees@kernel.org>, <thuth@redhat.com>, <blum@kernel.org>, <kas@kernel.org>,
	<maddy@linux.ibm.com>, <james.morse@arm.com>, <tglx@kernel.org>,
	<bp@alien8.d>, <e@domain.invalid>, <mark.rutland@arm.com>,
	<driver-core@lists.linux.dev>, <kernel@xen0n.name>, <chao.gao@intel.com>,
	<eric.devolder@oracle.com>, <tangyouling@kylinos.cn>, <palmer@rivosinc.com>,
	<loongarch@lists.linux.dev>, <bgwin@google.com>, <guodongtai@kylinos.cn>,
	<rppt@kernel.org>, <linuxppc-dev@lists.ozlabs.org>, <maqianga@uniontech.com>,
	<seanjc@google.com>, <vishal.l.verma@intel.com>, <robh@kernel.org>,
	<gshan@redhat.com>, <me@linux.beauty>, <sshegde@linux.ibm.com>,
	<mpe@ellerman.id.au>
CC: <kexec@lists.infradead.org>
References: <20260918100442.3841135-1-ruanjinjie@huawei.com>
 <20260918100442.3841135-12-ruanjinjie@huawei.com>
 <20260918102742.414E21F000FF@smtp.kernel.org>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20260918102742.414E21F000FF@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemk200008.china.huawei.com (7.202.194.74)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260919_205236_604759_A901CDB0 
X-CRM114-Status: GOOD (  14.54  )
X-Mailman-Approved-At: Sun, 20 Sep 2026 13:23:20 -0700
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



在 2026/9/18 18:27, sashiko-bot@kernel.org 写道:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] kexec: elfcorehdr_updated in struct kimage is write-only and unused
> --
> 
> commit 463b7b7692d8e96dc1be8ffaed1b6d0c8d298c9f
> Author: Jinjie Ruan <ruanjinjie@huawei.com>
> 
> crash: Normalize the kexec_load elfcorehdr at load time
> 
> This commit changes kexec_load to normalize the elfcorehdr at load time
> instead of waiting for the first crash hotplug event. By doing this while
> the device_hotplug_lock can be safely taken, it allows hotplug paths to
> skip CPU events safely and avoid racing with memory hotplug.
> 
>> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
>> index 3c9f4fbbe7ff0..f34fa8dba0288 100644
>> --- a/arch/x86/kernel/crash.c
>> +++ b/arch/x86/kernel/crash.c
>> @@ -457,9 +457,8 @@ void arch_crash_handle_hotplug_event(struct kimage *image, void *arg)
>>  	 * possible CPUs, there is no need to update the elfcorehdr
>>  	 * for additional CPU changes.
>>  	 */
>> -	if ((image->file_mode || image->elfcorehdr_updated) &&
>> -		((image->hp_action == KEXEC_CRASH_HP_ADD_CPU) ||
>> -		(image->hp_action == KEXEC_CRASH_HP_REMOVE_CPU)))
>> +	if (image->hp_action == KEXEC_CRASH_HP_ADD_CPU ||
>> +	    image->hp_action == KEXEC_CRASH_HP_REMOVE_CPU)
>>  		return;
> 
> [Severity: Low]
> Does this leave elfcorehdr_updated as a write-only and unused field?
> 
> Since this patch removes the last reader of image->elfcorehdr_updated,
> the field is now only written to in crash_handle_hotplug_event() and
> initialized in kernel/kexec_core.c:

Will remove unused  elfcorehdr_updated in v6.

> 
> kernel/crash_core.c:crash_handle_hotplug_event() {
>     ...
>     image->hp_action = KEXEC_CRASH_HP_NONE;
>     image->elfcorehdr_updated = true;
>     ...
> }
> 
> Should the elfcorehdr_updated field be completely removed from struct kimage
> in include/linux/kexec.h along with its assignments to avoid dead code and
> structure overhead?
> 

-- 
Best regards,
Jinjie


