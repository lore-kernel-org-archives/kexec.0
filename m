Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42BCECD5BB6
	for <kexec@archiver.kernel.org>; Fri, 22 May 2026 07:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ha3U5FJeF61nR13fqhapGOPU2jfN530U4ccDWtKILT0=; b=RDYlW85hjGTfzUOrQGnxDJdoB0
	WhYSu23ZbQMLu2niT936sMIUPcKvlriQr6vCW1XheYzId1QLrbHU6b2DGiH1UgyZropy5dvZzYYXe
	EtD5+CjtwM7w9R3whGJTRZ2zeDmtsm8BHirw9ukn9GBuAljmgUSX6X3c5XVJXqWTOxutYnE7Si2eU
	dYd8xTcj9DHmSt79h3xMWEUz/ZN43WgJ2WLpGNLefPjJTgSzTPioyY/HZSTa0uSQJixvWwAQXhILk
	b7Wgb0MAp8GViakNSXhVjywf4zv2dxc2rzvaPbpAlY397GfSQrI7FUgmp1iSpxI9zikf4Ntkvo0Yq
	np7T/ZRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQKSK-0000000A6xp-0Kg8;
	Fri, 22 May 2026 07:38:04 +0000
Received: from canpmsgout05.his.huawei.com ([113.46.200.220])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPJmB-00000001VYp-1YkA;
	Tue, 19 May 2026 12:42:26 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Ha3U5FJeF61nR13fqhapGOPU2jfN530U4ccDWtKILT0=;
	b=Imw5scWNyENSClDDsm0aKoLrou92ErUJJIQORPJEcabYI3utCuQCW0cH+DSoBKS/L+LrRsUXe
	4/57egHk9L82uCmnWMcuwAKP6ON3NWimFljmUY71FbmH/qt6gcc0LgcZJmkJ1LP6GuoGabpLGiL
	lCnVxupN6NtwOTzTEcksGao=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4gKYzG6L5wz12LF7;
	Tue, 19 May 2026 20:35:06 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 899C44056A;
	Tue, 19 May 2026 20:42:08 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 19 May 2026 20:42:04 +0800
Message-ID: <3ca700ed-e081-4c62-8289-5bbd4248e630@huawei.com>
Date: Tue, 19 May 2026 20:42:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 04/15] arm64: kexec_file: Fix potential buffer
 overflow in prepare_elf_headers()
To: Breno Leitao <leitao@debian.org>
CC: <corbet@lwn.net>, <skhan@linuxfoundation.org>, <catalin.marinas@arm.com>,
	<will@kernel.org>, <chenhuacai@kernel.org>, <kernel@xen0n.name>,
	<maddy@linux.ibm.com>, <mpe@ellerman.id.au>, <npiggin@gmail.com>,
	<chleroy@kernel.org>, <pjw@kernel.org>, <palmer@dabbelt.com>,
	<aou@eecs.berkeley.edu>, <alex@ghiti.fr>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <robh@kernel.org>, <saravanak@kernel.org>,
	<akpm@linux-foundation.org>, <bhe@redhat.com>, <rppt@kernel.org>,
	<pasha.tatashin@soleen.com>, <pratyush@kernel.org>, <ruirui.yang@linux.dev>,
	<rdunlap@infradead.org>, <pmladek@suse.com>, <dapeng1.mi@linux.intel.com>,
	<kees@kernel.org>, <elver@google.com>, <kuba@kernel.org>,
	<ebiggers@kernel.org>, <lirongqing@baidu.com>, <paulmck@kernel.org>,
	<sourabhjain@linux.ibm.com>, <coxu@redhat.com>, <jbohac@suse.cz>,
	<ryan.roberts@arm.com>, <osandov@fb.com>, <cfsworks@gmail.com>,
	<tangyouling@kylinos.cn>, <ritesh.list@gmail.com>, <adityag@linux.ibm.com>,
	<guoren@kernel.org>, <songshuaishuai@tinylab.org>, <kevin.brodsky@arm.com>,
	<vishal.moola@gmail.com>, <junhui.liu@pigmoral.tech>,
	<wangruikang@iscas.ac.cn>, <namcao@linutronix.de>, <chao.gao@intel.com>,
	<seanjc@google.com>, <fuqiang.wang@easystack.cn>, <ardb@kernel.org>,
	<chenjiahao16@huawei.com>, <hbathini@linux.ibm.com>,
	<takahiro.akashi@linaro.org>, <james.morse@arm.com>, <lizhengyu3@huawei.com>,
	<x86@kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<loongarch@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<kexec@lists.infradead.org>
References: <20260511030454.1730881-1-ruanjinjie@huawei.com>
 <20260511030454.1730881-5-ruanjinjie@huawei.com> <agGkvrg06KNDNfDi@gmail.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <agGkvrg06KNDNfDi@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500011.china.huawei.com (7.185.36.131)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260519_054224_058688_2F7F6872 
X-CRM114-Status: GOOD (  22.98  )
X-Mailman-Approved-At: Fri, 22 May 2026 00:38:03 -0700
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



On 5/11/2026 5:46 PM, Breno Leitao wrote:
> On Mon, May 11, 2026 at 11:04:43AM +0800, Jinjie Ruan wrote:
>> There is a race condition between the kexec_load() system call
>> (crash kernel loading path) and memory hotplug operations that can
>> lead to buffer overflow and potential kernel crash.
>>
>> During prepare_elf_headers(), the following steps occur:
>> 1. The first for_each_mem_range() queries current System RAM memory ranges
>> 2. Allocates buffer based on queried count
>> 3. The 2st for_each_mem_range() populates ranges from memblock
>>
>> If memory hotplug occurs between step 1 and step 3, the number of ranges
>> can increase, causing out-of-bounds write when populating cmem->ranges[].
>>
>> This happens because kexec_load() uses kexec_trylock (atomic_t) while
>> memory hotplug uses device_hotplug_lock (mutex), so they don't serialize
>> with each other.
>>
>> Add the explicit bounds checking to prevent out-of-bounds access.
> 
> It seems you have a TOCTOU type of issue, and this seems to be shrinking
> the window, but not fully solving it?

I plan to fix this issue as follows, and would appreciate your feedback
on whether this is reasonable.

Sashiko AI code review pointed out there is a TOCTOU (Time-of-Check to
Time-of-Use) race condition in prepare_elf_headers() between the initial
pass that counts System RAM ranges and the second pass that populates them.
If a memory hotplug event occurs between these two steps, the number of
memory regions may increase, causing an out-of-bounds write to
the cmem->ranges[] array.

To resolve this and ensure data consistency, this patch:

1. Wraps the counting and population passes with get_online_mems() and
   crash_hotplug_lock(). This serializes the kexec_file_load() path
   with concurrent memory hotplug operations, ensuring the memory
   map remains consistent throughout the header preparation.

2. Adds an explicit boundary check in prepare_elf64_ram_headers_callback().
   If the number of ranges exceeds the allocated maximum, it now returns
   -EAGAIN, which indicates a transient race, signaling userspace
   kexec-tools to retry the syscall instead of leaving the system
without a loaded crash kernel.

index daf81a873bbd..546be6261177 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -15,6 +15,7 @@
 #include <linux/kexec.h>
 #include <linux/libfdt.h>
 #include <linux/memblock.h>
+#include <linux/memory_hotplug.h>
 #include <linux/of.h>
 #include <linux/of_fdt.h>
 #include <linux/slab.h>
@@ -40,7 +41,7 @@ int arch_kimage_file_post_load_cleanup(struct kimage
*image)
 }

 #ifdef CONFIG_CRASH_DUMP
-int prepare_elf_headers(void **addr, unsigned long *sz)
+static int __prepare_elf_headers(void **addr, unsigned long *sz)
 {
 	struct crash_mem *cmem;
 	unsigned int nr_ranges;
@@ -59,6 +60,11 @@ int prepare_elf_headers(void **addr, unsigned long *sz)
 	cmem->max_nr_ranges = nr_ranges;
 	cmem->nr_ranges = 0;
 	for_each_mem_range(i, &start, &end) {
+		if (cmem->nr_ranges >= cmem->max_nr_ranges) {
+			ret = -EAGAIN;
+			goto out;
+		}
+
 		cmem->ranges[cmem->nr_ranges].start = start;
 		cmem->ranges[cmem->nr_ranges].end = end - 1;
 		cmem->nr_ranges++;
@@ -81,6 +87,21 @@ int prepare_elf_headers(void **addr, unsigned long *sz)
 	kfree(cmem);
 	return ret;
 }
+
+int prepare_elf_headers(void **addr, unsigned long *sz)
+{
+	int ret;
+
+	crash_hotplug_lock();
+	get_online_mems();
+
+	ret = __prepare_elf_headers(addr, sz);
+
+	put_online_mems();
+	crash_hotplug_unlock();
+
+	return ret;
+}
 #endif

> 
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Baoquan He <bhe@redhat.com>
>> Cc: Breno Leitao <leitao@debian.org>
>> Cc: stable@vger.kernel.org
>> Fixes: 3751e728cef2 ("arm64: kexec_file: add crash dump support")
>> Closes: https://sashiko.dev/#/patchset/20260323072745.2481719-1-ruanjinjie%40huawei.com
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
>>  arch/arm64/kernel/machine_kexec_file.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
>> index e31fabed378a..a67e7b1abbab 100644
>> --- a/arch/arm64/kernel/machine_kexec_file.c
>> +++ b/arch/arm64/kernel/machine_kexec_file.c
>> @@ -59,6 +59,11 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
>>  	cmem->max_nr_ranges = nr_ranges;
>>  	cmem->nr_ranges = 0;
>>  	for_each_mem_range(i, &start, &end) {
>> +		if (cmem->nr_ranges >= cmem->max_nr_ranges) {
>> +			ret = -ENOMEM;
> 
> -ENOMEM seems to be the the wrong errno. This isn't an allocation
> failure; it's a transient race. -EBUSY or -EAGAIN would be more honest


