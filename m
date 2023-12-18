Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B362C46CA2
	for <kexec@archiver.kernel.org>; Mon, 18 Dec 2023 23:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:CC:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=icHCKAG7TB7Y/5xZLI40gBH/EQC9lVqVKR6xVvNZ3lI=; b=2ZFsUhL0jQJbkb
	JxxPpmyQl9tOgzBdNY4Shy5FoFvJlaOGyhhjfu7N2uQG+O3QO544vtiQ3ts3uq8nZlfiTXn7fXfOz
	TYqg4KvI6bS6N8RCtuN7gkj06mf3t+4anuPG2LB7R4XCnIiKGAtRqMkPBNj94KGG2bZZajbfuLhSO
	6orraBHMeNnFZGe+4ybxxIccdXfCsvLpzJ8T6epkJqKkFe4raD1+7iRiUZ6zDLkOo3r5dnZnh6FH1
	ogl5t1AKrQMny1NyAPwRqOqOffK58sLWtOTmqupDWHaLz6NvGgC3OIQ7ovVVxPhqN+J9UljnmSVBc
	9RepmTaF2uQ3vWxwXBoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFMc5-00CHZS-0g;
	Mon, 18 Dec 2023 23:01:29 +0000
Received: from smtp-fw-80008.amazon.com ([99.78.197.219])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFMc2-00CHYd-2Q;
	Mon, 18 Dec 2023 23:01:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702940486; x=1734476486;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BKnuJnSOr7AXqCS4JEaUZGmhItcYW0ApYK2shnoxWNA=;
  b=j36hye9lK0Y7um62Z5ZYwdyN/Tul5vjMHnSTuGXv4P+Ntdtzcl+Z/XFX
   6qqQa5kpyR5mW3g2D7VDzVtpXqN2f/Qeh3OqUqZ52jakHV3ojLit8g2Ms
   gQiDX77TjfJUvMRTnLKe4na8RUZ03Ts5LfNqQl/cWyS95k5Rj69koXg+X
   8=;
X-IronPort-AV: E=Sophos;i="6.04,286,1695686400"; 
   d="scan'208";a="52164912"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-153b24bc.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 23:01:18 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan3.iad.amazon.com [10.32.235.38])
	by email-inbound-relay-iad-1d-m6i4x-153b24bc.us-east-1.amazon.com (Postfix) with ESMTPS id D02B4C605B;
	Mon, 18 Dec 2023 23:01:10 +0000 (UTC)
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:5473]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.33.64:2525] with esmtp (Farcaster)
 id 5f7bb7c5-6180-43fc-ad28-77aacdf6c520; Mon, 18 Dec 2023 23:01:10 +0000 (UTC)
X-Farcaster-Flow-ID: 5f7bb7c5-6180-43fc-ad28-77aacdf6c520
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 18 Dec 2023 23:01:10 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 18 Dec
 2023 23:01:04 +0000
Message-ID: <d843596e-0def-439b-966a-a0f10a1b7f6d@amazon.com>
Date: Tue, 19 Dec 2023 00:01:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/15] arm64: Add KHO support
To: Rob Herring <robh@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <kexec@lists.infradead.org>,
	<linux-doc@vger.kernel.org>, <x86@kernel.org>, Eric Biederman
	<ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski
	<luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Steven Rostedt
	<rostedt@goodmis.org>, Andrew Morton <akpm@linux-foundation.org>, "Mark
 Rutland" <mark.rutland@arm.com>, Tom Lendacky <thomas.lendacky@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>, James Gowans <jgowans@amazon.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>, <arnd@arndb.de>,
	<pbonzini@redhat.com>, <madvenka@linux.microsoft.com>, Anthony Yznaga
	<anthony.yznaga@oracle.com>, Usama Arif <usama.arif@bytedance.com>, "David
 Woodhouse" <dwmw@amazon.co.uk>, Benjamin Herrenschmidt
	<benh@kernel.crashing.org>
References: <20231213000452.88295-1-graf@amazon.com>
 <20231213000452.88295-7-graf@amazon.com>
 <20231214223604.GA1045434-robh@kernel.org>
Content-Language: en-US
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <20231214223604.GA1045434-robh@kernel.org>
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D042UWA003.ant.amazon.com (10.13.139.44) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231218_150126_906641_AB1AF4E3 
X-CRM114-Status: GOOD (  28.45  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hey Rob!

On 14.12.23 23:36, Rob Herring wrote:
> On Wed, Dec 13, 2023 at 12:04:43AM +0000, Alexander Graf wrote:
>> We now have all bits in place to support KHO kexecs. This patch adds
>> awareness of KHO in the kexec file as well as boot path for arm64 and
>> adds the respective kconfig option to the architecture so that it can
>> use KHO successfully.
>>
>> Signed-off-by: Alexander Graf <graf@amazon.com>
>> ---
>>   arch/arm64/Kconfig        | 12 ++++++++++++
>>   arch/arm64/kernel/setup.c |  2 ++
>>   arch/arm64/mm/init.c      |  8 ++++++++
>>   drivers/of/fdt.c          | 41 +++++++++++++++++++++++++++++++++++++++
>>   drivers/of/kexec.c        | 36 ++++++++++++++++++++++++++++++++++
>>   5 files changed, 99 insertions(+)
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 7b071a00425d..1ba338ce7598 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -1501,6 +1501,18 @@ config ARCH_SUPPORTS_CRASH_DUMP
>>   config ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
>>        def_bool CRASH_CORE
>>
>> +config KEXEC_KHO
>> +     bool "kexec handover"
>> +     depends on KEXEC
>> +     select MEMBLOCK_SCRATCH
>> +     select LIBFDT
>> +     select CMA
>> +     help
>> +       Allow kexec to hand over state across kernels by generating and
>> +       passing additional metadata to the target kernel. This is useful
>> +       to keep data or state alive across the kexec. For this to work,
>> +       both source and target kernels need to have this option enabled.
> Why do we have the same kconfig entry twice? Here and x86.


This was how the kexec config options were done when I wrote the patches 
originally. Since then, looks like Eric DeVolder has cleaned up things 
quite nicely. I'll adapt the new way.


>
>> +
>>   config TRANS_TABLE
>>        def_bool y
>>        depends on HIBERNATION || KEXEC_CORE
>> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
>> index 417a8a86b2db..8035b673d96d 100644
>> --- a/arch/arm64/kernel/setup.c
>> +++ b/arch/arm64/kernel/setup.c
>> @@ -346,6 +346,8 @@ void __init __no_sanitize_address setup_arch(char **cmdline_p)
>>
>>        paging_init();
>>
>> +     kho_reserve_mem();
>> +
>>        acpi_table_upgrade();
>>
>>        /* Parse the ACPI tables for possible boot-time configuration */
>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>> index 74c1db8ce271..254d82f3383a 100644
>> --- a/arch/arm64/mm/init.c
>> +++ b/arch/arm64/mm/init.c
>> @@ -358,6 +358,8 @@ void __init bootmem_init(void)
>>         */
>>        arch_reserve_crashkernel();
>>
>> +     kho_reserve();
>> +
> reserve what? It is not obvious what the difference between
> kho_reserve_mem() and kho_reserve() are.


Yeah, I agree. I was struggling to find good names for them. What they 
do is:

kho_reserve() - Reserve CMA memory for later kexec. We use this memory 
region as scratch memory later.
kho_reserve_mem() - Post-KHO. Creates memory reservations inside 
memblocks for pre-KHO handed over memory.

For v2, I'll change them to kho_reserve_scratch() and 
kho_reserve_previous_mem() unless you have better ideas :)


>
>>        memblock_dump_all();
>>   }
>>
>> @@ -386,6 +388,12 @@ void __init mem_init(void)
>>        /* this will put all unused low memory onto the freelists */
>>        memblock_free_all();
>>
>> +     /*
>> +      * Now that all KHO pages are marked as reserved, let's flip them back
>> +      * to normal pages with accurate refcount.
>> +      */
>> +     kho_populate_refcount();
>> +
>>        /*
>>         * Check boundaries twice: Some fundamental inconsistencies can be
>>         * detected at build time already.
>> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
>> index bf502ba8da95..af95139351ed 100644
>> --- a/drivers/of/fdt.c
>> +++ b/drivers/of/fdt.c
>> @@ -1006,6 +1006,44 @@ void __init early_init_dt_check_for_usable_mem_range(void)
>>                memblock_add(rgn[i].base, rgn[i].size);
>>   }
>>
>> +/**
>> + * early_init_dt_check_kho - Decode info required for kexec handover from DT
>> + */
>> +void __init early_init_dt_check_kho(void)
>> +{
>> +#ifdef CONFIG_KEXEC_KHO
> if (!IS_ENABLED(CONFIG_KEXEC_KHO))
>    return;
>
> You'll need a kho_populate() stub.


Always happy to remove #ifdefs :)


>
>> +     unsigned long node = chosen_node_offset;
>> +     u64 kho_start, scratch_start, scratch_size, mem_start, mem_size;
>> +     const __be32 *p;
>> +     int l;
>> +
>> +     if ((long)node < 0)
>> +             return;
>> +
>> +     p = of_get_flat_dt_prop(node, "linux,kho-dt", &l);
>> +     if (l != (dt_root_addr_cells + dt_root_size_cells) * sizeof(__be32))
>> +             return;
>> +
>> +     kho_start = dt_mem_next_cell(dt_root_addr_cells, &p);
>> +
>> +     p = of_get_flat_dt_prop(node, "linux,kho-scratch", &l);
>> +     if (l != (dt_root_addr_cells + dt_root_size_cells) * sizeof(__be32))
>> +             return;
>> +
>> +     scratch_start = dt_mem_next_cell(dt_root_addr_cells, &p);
>> +     scratch_size = dt_mem_next_cell(dt_root_addr_cells, &p);
>> +
>> +     p = of_get_flat_dt_prop(node, "linux,kho-mem", &l);
>> +     if (l != (dt_root_addr_cells + dt_root_size_cells) * sizeof(__be32))
>> +             return;
>> +
>> +     mem_start = dt_mem_next_cell(dt_root_addr_cells, &p);
>> +     mem_size = dt_mem_next_cell(dt_root_addr_cells, &p);
>> +
>> +     kho_populate(kho_start, scratch_start, scratch_size, mem_start, mem_size);
>> +#endif
>> +}
>> +
>>   #ifdef CONFIG_SERIAL_EARLYCON
>>
>>   int __init early_init_dt_scan_chosen_stdout(void)
>> @@ -1304,6 +1342,9 @@ void __init early_init_dt_scan_nodes(void)
>>
>>        /* Handle linux,usable-memory-range property */
>>        early_init_dt_check_for_usable_mem_range();
>> +
>> +     /* Handle kexec handover */
>> +     early_init_dt_check_kho();
>>   }
>>
>>   bool __init early_init_dt_scan(void *params)
>> diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
>> index 68278340cecf..a612e6bb8c75 100644
>> --- a/drivers/of/kexec.c
>> +++ b/drivers/of/kexec.c
>> @@ -264,6 +264,37 @@ static inline int setup_ima_buffer(const struct kimage *image, void *fdt,
>>   }
>>   #endif /* CONFIG_IMA_KEXEC */
>>
>> +static int kho_add_chosen(const struct kimage *image, void *fdt, int chosen_node)
>> +{
>> +     int ret = 0;
>> +
>> +#ifdef CONFIG_KEXEC_KHO
> ditto
>
> Though perhaps image->kho is not defined?


Correct, it is not. But I'm happy to have a few local variables that I 
stash the image->kho contents inside an ifdef into so we can at least 
compile check all libfdt invocations.


Alex




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
