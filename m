Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A38B606A32E
	for <kexec@archiver.kernel.org>; Wed, 11 Nov 2026 12:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=B/Tz3TlY;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=A/8QfyjR
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=hLlB9PIDPa4FwR0ytVgqyr+GYjQb+wnK9lGZmR7GcW4=; b=B/Tz3TlYzX9ypk
	LbMoCAMM3wHA5zrbmhxps+rPE5yWFDTKW4RnB/dUeqyxNuWyzSnbLuSH1easnu4zWrT2/0PqJzMat
	KIEE0/kTTVW7zuFC603w8ERAGMTfXwB3ciEk751lLWJBFasHMLivSvwsg8s0GZgorVmRnNCN/FlfU
	ynhGTwyUQiNURmCzULFcvG3lE7XBKzifvFAqxTXW29AKMI5trBSG8V04ecco21WJflvT0x/m5/h1P
	eUzFmHcSW+wJEGqKddXB+ETNL3od0CcT2hct6LB/nW28eE4a8uKNNq+fC9tdI85G45exweYNvZH2j
	/SQl0jn9SNWa7vI9aoYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR71p-00000006b9T-3MXi;
	Wed, 11 Nov 2026 12:02:13 +0000
Received: from canpmsgout06.his.huawei.com ([113.46.200.221])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR71k-00000006b4b-3IES;
	Wed, 11 Nov 2026 12:02:13 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=hLlB9PIDPa4FwR0ytVgqyr+GYjQb+wnK9lGZmR7GcW4=;
	b=A/8QfyjRiaBChHXgN5XNj/qC6s6VEqJwOoJCEIPPsSdA1xn/u9+4I2BNIdvO6VwakQ1MwuTCd
	pj5GIPYBFjb6edzmQpShYUk32wfSlLjBaFgXCSpJhe/z8AYNpDzsASB94Ju4K3qlDzqztwlntQB
	KB4pcepY8BB3ooGO1+Evs6g=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4jPhvg5fcvzRhT3;
	Wed, 11 Nov 2026 20:01:51 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 3A53140538;
	Wed, 11 Nov 2026 20:02:02 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemk200008.china.huawei.com
 (7.202.194.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 11 Nov
 2026 20:02:00 +0800
Message-ID: <d6047caf-4838-4007-8483-8739dd2a429a@huawei.com>
Date: Wed, 11 Nov 2026 20:01:59 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 12/15] kexec: Add kexec_load_other_segments() helper
To: Mike Rapoport <rppt@kernel.org>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <mark.rutland@arm.com>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <maddy@linux.ibm.com>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <chleroy@kernel.org>,
	<ritesh.list@gmail.com>, <sshegde@linux.ibm.com>, <pjw@kernel.org>,
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>,
	<tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <akpm@linux-foundation.org>,
	<baoquan.he@linux.dev>, <pasha.tatashin@soleen.com>, <pratyush@kernel.org>,
	<thuth@redhat.com>, <leitao@debian.org>, <yeoreum.yun@arm.com>,
	<robh@kernel.org>, <sourabhjain@linux.ibm.com>, <kees@kernel.org>,
	<coiby.xu@gmail.com>, <Yeking@Red54.com>, <tangyouling@kylinos.cn>,
	<maqianga@uniontech.com>, <zhangtianyang@loongson.cn>,
	<guodongtai@kylinos.cn>, <blum@kernel.org>, <adityag@linux.ibm.com>,
	<hui.wang@canonical.com>, <sohammetha01@gmail.com>, <guoren@kernel.org>,
	<gaohan@iscas.ac.cn>, <kai.huang@intel.com>, <kas@kernel.org>,
	<vishal.l.verma@intel.com>, <piliu@redhat.com>, <jbouron@amazon.com>,
	<mclapinski@google.com>, <me@linux.beauty>, <graf@amazon.com>,
	<bgwin@google.com>, <x86@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <loongarch@lists.linux.dev>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-riscv@lists.infradead.org>,
	<kexec@lists.infradead.org>
References: <20261026075201.699550-1-ruanjinjie@huawei.com>
 <20261026075201.699550-13-ruanjinjie@huawei.com>
 <179430504583.425130.15302016434972990362.b4-review@b4>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <179430504583.425130.15302016434972990362.b4-review@b4>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemk200008.china.huawei.com (7.202.194.74)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261111_040209_460416_09611533 
X-CRM114-Status: GOOD (  40.45  )
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
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



在 2026/11/10 18:04, Mike Rapoport 写道:
> Hi Jinjie,

Hi Mike,

> 
>> arm64, LoongArch and RISC-V duplicate the elf core header and initrd
>> loading.  Move it into a common helper with one arch hook for the boot
>> parameters; a failure releases everything added for the attempt.
> 
> I like the idea of pulling out the common code, but I'm not convinced

Thank you for the review.

> that the split you suggest is right.

Yes, the current solution is straightforward.

> 
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Baoquan He <baoquan.he@linux.dev>
>> Cc: Mike Rapoport <rppt@kernel.org>
>> Suggested-by: Mike Rapoport <rppt@kernel.org>
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
>>  include/linux/kexec.h | 15 ++++++++
>>  kernel/kexec_file.c   | 90 +++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 105 insertions(+)
>>
>> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
>> index faba26f871a4a..de1d83ddc38bd 100644
>> --- a/include/linux/kexec.h
>> +++ b/include/linux/kexec.h
>> @@ -259,6 +259,21 @@ int kexec_kernel_verify_pe_sig(const char *kernel, unsigned long kernel_len);
>>  extern int kexec_add_buffer(struct kexec_buf *kbuf);
>>  int kexec_locate_mem_hole(struct kexec_buf *kbuf);
>>  
>> +struct kexec_load_params {
>> +	unsigned long kernel_load_addr;
>> +	unsigned long kernel_size;
>> +	char *initrd;
>> +	unsigned long initrd_len;
>> +	char *cmdline;
>> +	unsigned long cmdline_len;
>> +};
> 
> initrd and cmdline are already in image->initrd_buf, initrd_buf_len,
> cmdline_buf and cmdline_buf_len, that's where fops->load() gets them from.

OK, will delete them.

> 
> And the outputs are scattered: elf_load_addr goes to the image, the initrd
> address is passed as a separate argument to the hook, and LoongArch infers
> "there is an initrd" from initrd_load_addr != 0.

These are currently just being shoehorned in.

> 
> 
> 
>> +
>> +int arch_kexec_setup_other_segments(struct kimage *image,
>> +				    struct kexec_load_params *params,
>> +				    unsigned long initrd_load_addr);
>> +int kexec_load_other_segments(struct kimage *image,
>> +			      struct kexec_load_params *params, bool top_down);
>> +
> 
> The call chain is now fops->load() in arch -> kexec_load_other_segments()
> in core -> arch_kexec_setup_other_segments() back in arch. That's a
> midlayer: the core helper owns the sequence and the arch fills a hole in
> the middle of it.

The new refactoring will follow this principle to ensure that the
framework code is in control of the order.

> 
> The weak default is never used, all three users override it, and x86,
> powerpc and s390 build a helper and a hook that nothing calls.

Yes, x86 and powerpc has not used it, Some adjustments need for the rework.

> 
>>  #ifndef arch_kexec_locate_mem_hole
>>  /**
>>   * arch_kexec_locate_mem_hole - Find free memory to place the segments.
>> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
>> index 62d4cba278a57..8b80f1186875b 100644
>> --- a/kernel/kexec_file.c
>> +++ b/kernel/kexec_file.c
>> @@ -1295,3 +1295,93 @@ int kexec_purgatory_get_set_symbol(struct kimage *image, const char *name,
>>  	return 0;
>>  }
>>  #endif /* CONFIG_ARCH_SUPPORTS_KEXEC_PURGATORY */
>> +
>> +int __weak arch_kexec_setup_other_segments(struct kimage *image,
>> +					   struct kexec_load_params *params,
>> +					   unsigned long initrd_load_addr)
>> +{
>> +	return 0;
>> +}
>> +
>> +int kexec_load_other_segments(struct kimage *image,
>> +			      struct kexec_load_params *params, bool top_down)
>> +{
>> +	struct kexec_buf kbuf = {
>> +		.image = image,
>> +		/* Do not allocate anything below the kernel */
>> +		.buf_min = params->kernel_load_addr + params->kernel_size,
>> +		.buf_max = top_down ? PFN_PHYS(max_low_pfn) : ULONG_MAX,
>> +	};
> 
> top_down does not describe a direction, it selects "RISC-V policy" vs
> "arm64 policy": the upper limit for all buffers, the initrd direction and
> the 32G initrd window.

Yes its the topdown of initrd and distinguish between different
architectures is a bit of a stretch here.

Right! arm64 has its unique boot protocol restrictions. Here, RISC-V has
a bug fix that requires specifying a memory top limit.

> 
> These are boot protocol constraints and they belong to the architecture.

Agree

> The 32G window comes from arm64 booting.rst and the SZ_64K alignment below
> is "largest supported page size" on arm64 and LoongArch. With this patch

Yes.

> they become generic and RISC-V silently switches from
> ELF_CORE_HEADER_ALIGN to 64K in 15/15.

There are indeed some function changes, which are also mentioned
in the commit message.

> 
> 
>> +
>> +	unsigned long orig_segments = image->nr_segments;
>> +	unsigned long initrd_load_addr = 0;
>> +	int ret = 0;
>> +
>> +#ifdef CONFIG_CRASH_DUMP
>> +	if (image->type == KEXEC_TYPE_CRASH) {
>> +		ret = crash_prepare_headers(true, &kbuf.buffer, &kbuf.bufsz, NULL);
>> +		if (ret) {
>> +			pr_err("Preparing elf core header failed\n");
>> +			goto out_err;
>> +		}
>> +
>> +		if (unlikely(image->elf_headers))
>> +			vfree(image->elf_headers);
> 
> The headers don't depend on where the kernel is placed, yet they are
> rebuilt on every iteration of the arm64 and LoongArch retry loops. That's
> why the vfree() above is needed, and with the out_err path freeing them
> it's now dead code.

Yes, it need deleted now.

> 
> Building the headers once and only placing them in the loop removes the
> leak instead of fixing it.

I agree, I had a similar fix attempt before, where I only allocated once
to avoid placing it in a loop.

> 
> 
>> +
>> +		image->elf_headers = kbuf.buffer;
>> +		image->elf_headers_sz = kbuf.bufsz;
>> +
>> +		kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
>> +		kbuf.memsz = kbuf.bufsz;
>> +		kbuf.buf_align = SZ_64K; /* largest supported page size */
>> +		kbuf.top_down = true;
>> +
>> +		ret = kexec_add_buffer(&kbuf);
>> +		if (ret)
>> +			goto out_err;
>> +
>> +		image->elf_load_addr = kbuf.mem;
>> +
>> +		kexec_dprintk("Loaded elf core header at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
>> +			      image->elf_load_addr, kbuf.bufsz, kbuf.memsz);
>> +	}
>> +#endif
>> +
>> +	if (params->initrd) {
>> +		kbuf.buffer = params->initrd;
>> +		kbuf.bufsz = params->initrd_len;
>> +		kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
>> +		kbuf.memsz = params->initrd_len;
>> +		kbuf.buf_align = 0;
>> +		/* within 1GB-aligned window of up to 32GB in size */
>> +		if (!top_down)
>> +			kbuf.buf_max = round_down(params->kernel_load_addr, SZ_1G) +
>> +					(unsigned long)SZ_1G * 32;
>> +		kbuf.top_down = top_down;
>> +
>> +		ret = kexec_add_buffer(&kbuf);
>> +		if (ret)
>> +			goto out_err;
>> +		initrd_load_addr = kbuf.mem;
>> +
>> +		kexec_dprintk("Loaded initrd at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
>> +			      initrd_load_addr, kbuf.bufsz, kbuf.memsz);
>> +	}
>> +
>> +	ret = arch_kexec_setup_other_segments(image, params,
>> +					      initrd_load_addr);
>> +	if (ret)
>> +		goto out_err;
>> +
>> +	return 0;
>> +
>> +out_err:
>> +	while (image->nr_segments > orig_segments) {
>> +		kexec_free_segment_cma(image, image->nr_segments - 1);
>> +		image->nr_segments--;
>> +	}
>> +
>> +	kexec_free_elf_headers(image);
> 
> This drops segments added by the arch hook (DTB, RISC-V purgatory, arm64
> dm-crypt keys) without knowing anything about the state attached to them,
> like image->dm_crypt_keys_addr or the purgatory info. The hook, in turn,
> frees its buffers but not its segments.

Yes

> 
> Nobody owns the unwind, so "a failure releases everything added for the
> attempt" is not quite what happens.
> 
> The conversions also bury ordering changes in "simplify" patches: on arm64
> dm-crypt keys move after the initrd, and on RISC-V the initrd moves before
> the purgatory. And dm-crypt keys loading is not an arm64 boot parameter,
> x86 and powerpc use it as well.
>

Yes, the segment allocation order is indeed changed.


>> +
>> +	return ret;
>> +}
> 
> 
> What I had in mind was to make the core provide building blocks and let
> the architectures compose them, e.g. a common rollback function that
> frees CMAs and drops segments above nr. The retry loops in arm64 and
> LoongArch image loaders can use it instead of open coding
> kexec_free_segment_cma() and nr_segments--. There also could be a helper

I agree.

> for adding FDT for example and maybe some other common parts, like, say,
> efl headers.


I am trying out your refactoring ideas so that x86 and PowerPC can also
use these newly added small hook functions.

> 
> Arch's load_other_segments() could use these helpers and still define
> their own policy for segment placement.

This will eliminate the issue of changes in the above sequence or the
problem of the startup protocol being modified.

Thank you again for your review and suggestions for refactoring. I will
thoroughly consider the issues you raised, revise the code, and conduct
more testing.

> 

-- 
Best regards,
Jinjie


