Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BD51C5DF74
	for <kexec@archiver.kernel.org>; Mon, 17 Aug 2026 23:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:In-Reply-To:Subject:CC:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:References:List-Owner;
	bh=SZh2ivKKSQMz4Tw4pj6gSgvCgz+xLewwqu5aJ6u3/8U=; b=3mcSOgx8uoT2pTRjjPKb6p+Ddc
	4zTIAE/OSk8+aunszJnDsIjKuuVn21Kq3ZaD5Noczwt1vs4pxVUT6HaJvz2MSnDi21JyatLqOznfx
	F2uPNc4fkdWwihicWlAWyO0k0pWo80uLO+DTItOmfWFvcq6VsVo4Gx1CHFaePv5fRLFrb7HMgSgr7
	RjGH7KEF7ww5dl7jOBoqbPnkax9T+ua0qZiuzlZPntgJbmlPmQtIrAufJ9iXFP2mEX74XMZmbEL07
	iAva85vxSej3ZQ0In5eO6FuBHjF+sdgIjpa324dBVQwrZYcfBmL6HcEwWmqzrkJZRPcQX5BZ1DDUl
	I0kZohuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1ww6Z5-00000006y2I-2fb8;
	Mon, 17 Aug 2026 23:16:23 +0000
Received: from devianza.investici.org ([198.167.222.108])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1ww6Z2-00000006y1T-3UpZ
	for kexec@lists.infradead.org;
	Mon, 17 Aug 2026 23:16:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1787008576;
	bh=SZh2ivKKSQMz4Tw4pj6gSgvCgz+xLewwqu5aJ6u3/8U=;
	h=Date:From:To:CC:Subject:In-Reply-To:From;
	b=tLBa7SRkSl1VcfdFFnQeFD8Y7j6DI5NJ2v5swv1uI9QQ+BDpc1dMBwrvhJTd58HuX
	 /0FtPAsLhAcCsjGalJH+K/qiIbcbM2S06wXf1ZsJoqv1PkhiwPyxFkABDAUClwXFA2
	 R4BQgMKip+IVdMA+Y9xwhtk2zSFge8R3GQ8R5SKU=
Received: from mx2.investici.org (unknown [127.0.0.1])
	by devianza.investici.org (Postfix) with ESMTP id 4hP7xX4hpxz6vNG;
	Mon, 17 Aug 2026 23:16:16 +0000 (UTC)
Received: by mx2.investici.org (Postfix) id 4hP7xX1FHGz4y6W;
	Mon, 17 Aug 2026 23:16:16 +0000 (UTC)
Date: Tue, 18 Aug 2026 00:16:18 +0100
From: Bradley Morgan <include@grrlz.net>
To: ruanjinjie@huawei.com
CC: akpm@linux-foundation.org, bhe@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, eric.devolder@oracle.com,
 hbathini@linux.ibm.com, hpa@zytor.com, ionut.nechita@windriver.com,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com,
 tglx@linutronix.de, x86@kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_1/1=5D_x86/crash=3A_reserve_elfcorehdr_?=
 =?US-ASCII?Q?for_CONFIG=5FNR=5FCPUS=2C_not_CONFIG=5FNR=5FCPUS=5FDEFAULT?=
In-Reply-To: <e51a0df8-7519-480d-84a6-22cf96e6d06e@huawei.com>
Message-ID: <DBEE296F-28C0-40BF-B4D1-68D6E5831CFC@grrlz.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260817_161621_325308_B08740C4 
X-CRM114-Status: GOOD (  21.15  )
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

On 17 August 2026 02:18:59 BST, Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>
>
>在 2026/8/13 1:04, Ionut Nechita (Wind River) 写道:
>> From: Ionut Nechita <ionut.nechita@windriver.com>
>> 
>> kexec_file_load(2) fails with -EINVAL when loading a crash kernel on a
>> machine whose number of possible CPUs exceeds CONFIG_NR_CPUS_DEFAULT,
>> even though the classic kexec_load(2) path succeeds on the same machine.
>> 
>> With CONFIG_CRASH_HOTPLUG=y the elfcorehdr segment is over-allocated so
>> it can be updated in place on CPU/memory hotplug. crash_load_segments()
>> and arch_crash_get_elfcorehdr_size() compute that reservation from
>> CONFIG_NR_CPUS_DEFAULT:
>> 
>> 	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
>> 		pnum = 2 + CONFIG_NR_CPUS_DEFAULT + CONFIG_CRASH_MAX_MEMORY_RANGES;
>> 	else
>> 		pnum += 2 + CONFIG_NR_CPUS_DEFAULT;
>> 
>> However the actual header produced by crash_prepare_elf64_headers()
>> contains one PT_NOTE per *possible* CPU, i.e. num_possible_cpus(), which
>> is bounded by CONFIG_NR_CPUS, not by CONFIG_NR_CPUS_DEFAULT.  On configs
>> that raise CONFIG_NR_CPUS above the arch default while leaving
>> CONFIG_NR_CPUS_DEFAULT untouched (e.g. CONFIG_NR_CPUS=256,
>> CONFIG_NR_CPUS_DEFAULT=64 on x86_64 without MAXSMP), a system with more
>> than ~CONFIG_NR_CPUS_DEFAULT possible CPUs builds a header whose bufsz
>> exceeds the reserved, page-aligned memsz.  sanity_check_segment_list()
>> then rejects the image:
>> 
>> 	if (image->segment[i].bufsz > image->segment[i].memsz)
>> 		return -EINVAL;
>> 
>> kexec_load(2) is unaffected because user space builds the elfcorehdr
>> without the hotplug over-allocation.
>> 
>> Observed on a single-socket Xeon 6776P (144 possible CPUs) running a
>> PREEMPT_RT kernel with:
>> 
>> 	# CONFIG_MAXSMP is not set
>> 	CONFIG_NR_CPUS_RANGE_BEGIN=2
>> 	CONFIG_NR_CPUS_RANGE_END=512
>> 	CONFIG_NR_CPUS_DEFAULT=64
>> 	CONFIG_NR_CPUS=256
>> 
>> kexec -p -s fails with "kexec_file_load failed: Invalid argument".
>> Reducing the possible CPU count below the page-rounding threshold
>> (e.g. 72 via firmware) makes it succeed, confirming the reservation is
>> the limiting factor.
>> 
>> Reserve the elfcorehdr for CONFIG_NR_CPUS, the compile-time upper bound
>> of num_possible_cpus(), so the reservation always covers the header that
>> is actually generated.
>> 
>> Fixes: a72bbec70da2 ("crash: hotplug support for kexec_load()")
>> Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
>> ---
>>  arch/x86/kernel/crash.c | 6 +++---
>
>We should also update the comment in crash_handle_hotplug_event() to
>avoid misleading people.
>
>diff --git a/kernel/crash_core.c b/kernel/crash_core.c
>index 4f21fc3b108b..b046c1682aad 100644
>--- a/kernel/crash_core.c
>+++ b/kernel/crash_core.c
>@@ -565,7 +565,7 @@ int crash_check_hotplug_support(void)
>  * new list of CPUs and memory. To make changes to the elfcorehdr, it
>  * should be large enough to permit a growing number of CPU and Memory
>  * resources. One can estimate the elfcorehdr memory size based on
>- * NR_CPUS_DEFAULT and CRASH_MAX_MEMORY_RANGES. The elfcorehdr is
>+ * NR_CPUS and CRASH_MAX_MEMORY_RANGES. The elfcorehdr is

One more spot carries the same stale name though:

kernel/Kconfig.kexec: "This value is combined with NR_CPUS_DEFAULT
and multiplied by sizeof(Elf64_Phdr) to determine the final
elfcorehdr memory buffer/segment size."

The CRASH_MAX_MEMORY_RANGES help text needs the same
s/NR_CPUS_DEFAULT/NR_CPUS/, either here or in Ionut's v2.



Reviewed-by: Bradley Morgan <include@grrlz.net>


>  * excluded from SHA verification by default if the architecture
>  * supports crash hotplug.
>  */
>
>
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>> 
>> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
>> index e681ec9cf1dc8..e6f23933a6df2 100644
>> --- a/arch/x86/kernel/crash.c
>> +++ b/arch/x86/kernel/crash.c
>> @@ -369,9 +369,9 @@ int crash_load_segments(struct kimage *image)
>>  	 * maximum CPUs and maximum memory ranges.
>>  	 */
>>  	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
>> -		pnum = 2 + CONFIG_NR_CPUS_DEFAULT + CONFIG_CRASH_MAX_MEMORY_RANGES;
>> +		pnum = 2 + CONFIG_NR_CPUS + CONFIG_CRASH_MAX_MEMORY_RANGES;
>>  	else
>> -		pnum += 2 + CONFIG_NR_CPUS_DEFAULT;
>> +		pnum += 2 + CONFIG_NR_CPUS;
>>  
>>  	if (pnum < (unsigned long)PN_XNUM) {
>>  		kbuf.memsz = pnum * sizeof(Elf64_Phdr);
>> @@ -430,7 +430,7 @@ unsigned int arch_crash_get_elfcorehdr_size(void)
>>  	unsigned int sz;
>>  
>>  	/* kernel_map, VMCOREINFO and maximum CPUs */
>> -	sz = 2 + CONFIG_NR_CPUS_DEFAULT;
>> +	sz = 2 + CONFIG_NR_CPUS;
>>  	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
>>  		sz += CONFIG_CRASH_MAX_MEMORY_RANGES;
>>  	sz *= sizeof(Elf64_Phdr);
>
>
>

Thanks!

