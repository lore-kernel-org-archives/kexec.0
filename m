Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F10DCA5FE3
	for <kexec@archiver.kernel.org>; Sat,  3 Oct 2026 08:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fpZt2aZdBsNduHTlBv5vWWE9AejQLjcJ/O5lddAlZiU=; b=X0UaAIXduD8p4DKZOnNIM4zZLj
	u7I3cONIykaOMTxQCihXKU/SjSgskYuhmOwPP6pnYVTCGfvFZ2FBaG5B9dgMvZstJeRtqXG2EKANn
	l5aWlzioQn5B5bGlQWYUGBzXYrZvdsQS5s1L1kuMcQ41kH269yTU3PuW9Pp+m+pSTNPFBNGx0UMDh
	PWNklPph+dre0tXrxJ1UoxcBTk8qqsRVt3jI74bTHZDbNSYOZjV9Vneb094Q2Tz+C5pm1LnXTRygU
	I2Qao9AspaRZZ0dP6zCqbUrYnhxfgsnPaG3jIVUPxx7hB1XMjP5xAbSXWwBLlb2BilAw/VNgQiDiX
	hlEvZ1eA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCv3O-0000000DAq0-125j;
	Sat, 03 Oct 2026 08:25:10 +0000
Received: from mail-m49198.qiye.163.com ([45.254.49.198])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCv3L-0000000DAoB-1TkP
	for kexec@lists.infradead.org;
	Sat, 03 Oct 2026 08:25:09 +0000
Received: from [192.168.5.82] (unknown [125.82.165.238])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4fe102675;
	Sat, 3 Oct 2026 16:24:51 +0800 (GMT+08:00)
Message-ID: <1b9d2426-fe5c-4227-976d-65ceb812c93c@tsinghua.org.cn>
Date: Sat, 3 Oct 2026 16:23:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] LoongArch: kdump: add arch_crash_save_vmcoreinfo()
 support
To: Huacai Chen <chenhuacai@kernel.org>,
 Yangyang Lian <lianyangyang@kylinos.cn>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Baoquan He <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>, Dave Young <ruirui.yang@linux.dev>,
 WANG Xuerui <kernel@xen0n.name>, kexec@lists.infradead.org,
 loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
 Haoran Jiang <jianghaoran@kylinos.cn>, Tao Cui <cuitao@kylinos.cn>,
 George Guo <guodongtai@kylinos.cn>
References: <20260923060349.146780-1-lianyangyang@kylinos.cn>
 <20260924075655.375632-1-lianyangyang@kylinos.cn>
 <CAAhV-H6C=AyS=1AejxxaG-Zri=2=AfMtPzXFxEvzpFdD1_AaAw@mail.gmail.com>
Content-Language: en-US, en-GB
From: Dave Young <yangrr.2009@tsinghua.org.cn>
In-Reply-To: <CAAhV-H6C=AyS=1AejxxaG-Zri=2=AfMtPzXFxEvzpFdD1_AaAw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa100ddb36603a2kunm96589f122a1e56
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFKTEtLSjdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZQ0NLVk9CH0sYSB4YGRkfH1
	YeHw5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKSU5VQ0lVSk1OVUlIQ1lXWRYaDxIVHRRZQVlPS0hVSk
	tJT09PSFVKS0tVSkJLS1kG
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261003_012507_601730_A5C44F3B 
X-CRM114-Status: GOOD (  21.98  )
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



On 9/28/26 10:28 PM, Huacai Chen wrote:
> Hi, Yangyang,
> 
> On Thu, Sep 24, 2026 at 3:58 PM Yangyang Lian <lianyangyang@kylinos.cn> wrote:
>>
>> Since commit 23c85094fe18 ("proc/kcore: add vmcoreinfo note to
>> /proc/kcore") the kernel has exported the vmcoreinfo PT_NOTE on
>> /proc/kcore as wellas /proc/vmcore.
>>
>> LoongArch does not provide arch_crash_save_vmcoreinfo(), so the
>> arch-specific values are missing from the vmcoreinfo PT_NOTE. The
>> generic exporter in kernel/vmcore_info.c already provides
>> NUMBER(VMALLOC_START), but tools like crash cannot derive the module
>> and vmemmap ranges, VA_BITS, or the KASLR offset of a LoongArch dump.

current crash can get the kaslr offset from the _stext differ, so it just works, but maybe makedumpfile still need the vmcoreinfo export.

>>
>> Since commit 18210a104bb9 ("LoongArch: Expand module virtual address
>> space to 2GB") the vmalloc and module boundaries are no longer stable
>> across kernel versions either, so vmcoreinfo is the only reliable
>> source for them.
>>
>> Provide this function in a separate file that is built at the same time
>> as its caller in kernel/vmcore_info.c, and add a LOONGARCH64 section to
>> Documentation/admin-guide/kdump/vmcoreinfo.rst.
>>
>> Reported-by: Haoran Jiang <jianghaoran@kylinos.cn>
>> Suggested-by: Haoran Jiang <jianghaoran@kylinos.cn>
>> Tested-by: Tao Cui <cuitao@kylinos.cn>
>> Co-developed-by: George Guo <guodongtai@kylinos.cn>
>> Signed-off-by: George Guo <guodongtai@kylinos.cn>
>> Signed-off-by: Yangyang Lian <lianyangyang@kylinos.cn>
>> ---
>> V2 -> V1: Export VMEMMAP_END + 1 to make it an exclusive bound, matching
>>           what tools like makedumpfile expect.
>>           Add Tested-by tag from Tao Cui.
>>
>>  .../admin-guide/kdump/vmcoreinfo.rst          | 29 +++++++++++++++++++
>>  arch/loongarch/kernel/Makefile                |  1 +
>>  arch/loongarch/kernel/vmcore_info.c           | 21 ++++++++++++++
>>  3 files changed, 51 insertions(+)
>>  create mode 100644 arch/loongarch/kernel/vmcore_info.c
>>
>> diff --git a/Documentation/admin-guide/kdump/vmcoreinfo.rst b/Documentation/admin-guide/kdump/vmcoreinfo.rst
>> index 7663c610fe90..2ff921232616 100644
>> --- a/Documentation/admin-guide/kdump/vmcoreinfo.rst
>> +++ b/Documentation/admin-guide/kdump/vmcoreinfo.rst
>> @@ -594,3 +594,32 @@ va_kernel_pa_offset
>>
>>  Indicates the offset between the kernel virtual and physical mappings.
>>  Used to translate virtual to physical addresses.
>> +
>> +LOONGARCH64
>> +===========
>> +
>> +VA_BITS
>> +-------
>> +
>> +The maximum number of bits for virtual addresses. Used to compute the
>> +virtual memory ranges.
>> +
>> +PHYS_OFFSET
>> +-----------
>> +
>> +Indicates the physical address of the start of memory. Used to translate
>> +virtual to physical addresses.
>> +
>> +KERNELOFFSET
>> +------------
>> +
>> +The kernel randomization offset. Used to locate the kernel text in
>> +virtual memory. If KASLR is disabled, this value is zero.
>> +
>> +MODULES_VADDR|MODULES_END|VMALLOC_START|VMALLOC_END|VMEMMAP_START|VMEMMAP_END
>> +-----------------------------------------------------------------------------
>> +
>> +Used to get the correct ranges:
>> +       MODULES_VADDR ~ MODULES_END-1 : Kernel module space.
>> +       VMALLOC_START ~ VMALLOC_END-1 : vmalloc() / ioremap() space.
>> +       VMEMMAP_START ~ VMEMMAP_END-1 : vmemmap region, used for struct page array.
>> diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Makefile
>> index 001924877772..6260c15adaba 100644
>> --- a/arch/loongarch/kernel/Makefile
>> +++ b/arch/loongarch/kernel/Makefile
>> @@ -64,6 +64,7 @@ obj-$(CONFIG_RELOCATABLE)     += relocate.o
>>  obj-$(CONFIG_KEXEC_CORE)       += machine_kexec.o relocate_kernel.o
>>  obj-$(CONFIG_KEXEC_FILE)       += machine_kexec_file.o kexec_efi.o kexec_elf.o
>>  obj-$(CONFIG_CRASH_DUMP)       += crash_dump.o
>> +obj-$(CONFIG_VMCORE_INFO)      += vmcore_info.o
>>
>>  obj-$(CONFIG_UNWINDER_GUESS)   += unwind_guess.o
>>  obj-$(CONFIG_UNWINDER_PROLOGUE) += unwind_prologue.o
>> diff --git a/arch/loongarch/kernel/vmcore_info.c b/arch/loongarch/kernel/vmcore_info.c
>> new file mode 100644
>> index 000000000000..fb703b716253
>> --- /dev/null
>> +++ b/arch/loongarch/kernel/vmcore_info.c
>> @@ -0,0 +1,21 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +#include <linux/vmcore_info.h>
>> +#include <asm/addrspace.h>
>> +#include <asm/pgtable.h>
>> +#include <asm/setup.h>
>> +
>> +void arch_crash_save_vmcoreinfo(void)
>> +{
>> +       VMCOREINFO_NUMBER(VA_BITS);
>> +       /* NUMBER(VMALLOC_START) is exported by the generic code */
>> +       vmcoreinfo_append_str("NUMBER(VMALLOC_END)=0x%lx\n", VMALLOC_END);
>> +#ifdef CONFIG_64BIT
>> +       vmcoreinfo_append_str("NUMBER(MODULES_VADDR)=0x%lx\n", MODULES_VADDR);
>> +       vmcoreinfo_append_str("NUMBER(MODULES_END)=0x%lx\n", MODULES_END);
>> +       vmcoreinfo_append_str("NUMBER(VMEMMAP_START)=0x%lx\n", (unsigned long)vmemmap);
>> +       vmcoreinfo_append_str("NUMBER(VMEMMAP_END)=0x%lx\n", VMEMMAP_END + 1);
>> +#endif
>> +       vmcoreinfo_append_str("NUMBER(PHYS_OFFSET)=0x%lx\n", PHYS_OFFSET);
> I think it is also useful to export PAGE_OFFSET here.

Hi Huacai,  if it is a fixed value or it can be derived from other known values I'd suggest not to export.

> 
> Huacai
>> +       vmcoreinfo_append_str("KERNELOFFSET=%lx\n", kaslr_offset());
>> +}
>> --
>> 2.25.1
>>
>>
> 
> 
> 


