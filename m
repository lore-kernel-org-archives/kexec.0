Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28408606A321
	for <kexec@archiver.kernel.org>; Tue, 10 Nov 2026 10:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=y6y/3uSR;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QT0hLtk9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=eY1DjQBxx9pGJujq6jDGfkVxNU4BxXGTTLJbRN2wf4U=; b=y6y/3uSRS1Oid+
	Dh53EQLxUOJovaAoywNtQAqEyA/Q5A9z2U1Um3uhIHEbrG9GmCeaZ/vipbR0LATiwR7MXIYsEqiH2
	3R2uILcQKxJHZ0dXPJCx6n4ic9wlpVkan/lJjHa9bvGihU+cf4EeVd7ToBdXlI4dFa41a1wwAxbFw
	YHMPmW3hX9ZFkoMQMaRp2m4PnqxKgok3jjYR9nOy683gxiS+je3TG7I5D+fMgtkjr65fHEFYWbaRb
	S47cEeGkYa5Ojq2gyHbKc3NzEoG+ICGPwsoaClAAmuwYxlAHogpUvcyiAC7/Vg8u+UTkKsFIZqefK
	K0L8iNleNChqIyQsqmLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQiiJ-00000003Nwb-2u4P;
	Tue, 10 Nov 2026 10:04:27 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQiiG-00000003Nvx-03f3;
	Tue, 10 Nov 2026 10:04:24 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 68EBE42EB0;
	Tue, 10 Nov 2026 10:04:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A80651F0089F;
	Tue, 10 Nov 2026 10:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794305063;
	bh=eY1DjQBxx9pGJujq6jDGfkVxNU4BxXGTTLJbRN2wf4U=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=QT0hLtk9QO9NQkSAMafK//Ctz1CLu6QbM11Rc9ypRgZvHyr5B908aYtoNJaavFGGr
	 0fInfPXPrGa6TWHGLogzkkxJ+Xx00GGNu+4+rA8qxV1XsW1X1hTqN6DD16TSa3JAKp
	 zFkHqXG9t7lCkgbbuWrsooy4xekpacKz3RZeGeb/jw/+M3qMTK0+w0JDpZwYMFWKGh
	 gQ6rTH8699FKSbnCwHqDJJrCqVSQyUMdoE56xaNNnc1h9qrqjX4Oq+tJRybK9TVJke
	 XsntNYFGeRI83Yhcix3xoAuRHe6qn+3qze9Zkb5x2CzaRLiQXjUBcD/HiBTyyy2Dku
	 wT9SVixRtBFow==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v7 12/15] kexec: Add kexec_load_other_segments() helper
From: Mike Rapoport <rppt@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, 
 chenhuacai@kernel.org, kernel@xen0n.name, maddy@linux.ibm.com, 
 mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, 
 ritesh.list@gmail.com, sshegde@linux.ibm.com, pjw@kernel.org, 
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, tglx@kernel.org, 
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
 akpm@linux-foundation.org, baoquan.he@linux.dev, rppt@kernel.org, 
 pasha.tatashin@soleen.com, pratyush@kernel.org, thuth@redhat.com, 
 leitao@debian.org, yeoreum.yun@arm.com, robh@kernel.org, 
 sourabhjain@linux.ibm.com, kees@kernel.org, coiby.xu@gmail.com, 
 Yeking@Red54.com, tangyouling@kylinos.cn, maqianga@uniontech.com, 
 zhangtianyang@loongson.cn, guodongtai@kylinos.cn, blum@kernel.org, 
 adityag@linux.ibm.com, hui.wang@canonical.com, sohammetha01@gmail.com, 
 guoren@kernel.org, gaohan@iscas.ac.cn, kai.huang@intel.com, kas@kernel.org, 
 vishal.l.verma@intel.com, piliu@redhat.com, jbouron@amazon.com, 
 mclapinski@google.com, me@linux.beauty, graf@amazon.com, bgwin@google.com, 
 x86@kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
 kexec@lists.infradead.org
In-Reply-To: <20261026075201.699550-13-ruanjinjie@huawei.com>
References: <20261026075201.699550-1-ruanjinjie@huawei.com>
 <20261026075201.699550-13-ruanjinjie@huawei.com>
Date: Tue, 10 Nov 2026 12:04:05 +0200
Message-Id: <179430504583.425130.15302016434972990362.b4-review@b4>
X-Mailer: b4 0.16.1-dev
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Jinjie,

> arm64, LoongArch and RISC-V duplicate the elf core header and initrd
> loading.  Move it into a common helper with one arch hook for the boot
> parameters; a failure releases everything added for the attempt.

I like the idea of pulling out the common code, but I'm not convinced
that the split you suggest is right.

> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Baoquan He <baoquan.he@linux.dev>
> Cc: Mike Rapoport <rppt@kernel.org>
> Suggested-by: Mike Rapoport <rppt@kernel.org>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  include/linux/kexec.h | 15 ++++++++
>  kernel/kexec_file.c   | 90 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 105 insertions(+)
>
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index faba26f871a4a..de1d83ddc38bd 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -259,6 +259,21 @@ int kexec_kernel_verify_pe_sig(const char *kernel, unsigned long kernel_len);
>  extern int kexec_add_buffer(struct kexec_buf *kbuf);
>  int kexec_locate_mem_hole(struct kexec_buf *kbuf);
>  
> +struct kexec_load_params {
> +	unsigned long kernel_load_addr;
> +	unsigned long kernel_size;
> +	char *initrd;
> +	unsigned long initrd_len;
> +	char *cmdline;
> +	unsigned long cmdline_len;
> +};

initrd and cmdline are already in image->initrd_buf, initrd_buf_len,
cmdline_buf and cmdline_buf_len, that's where fops->load() gets them from.

And the outputs are scattered: elf_load_addr goes to the image, the initrd
address is passed as a separate argument to the hook, and LoongArch infers
"there is an initrd" from initrd_load_addr != 0.



> +
> +int arch_kexec_setup_other_segments(struct kimage *image,
> +				    struct kexec_load_params *params,
> +				    unsigned long initrd_load_addr);
> +int kexec_load_other_segments(struct kimage *image,
> +			      struct kexec_load_params *params, bool top_down);
> +

The call chain is now fops->load() in arch -> kexec_load_other_segments()
in core -> arch_kexec_setup_other_segments() back in arch. That's a
midlayer: the core helper owns the sequence and the arch fills a hole in
the middle of it.

The weak default is never used, all three users override it, and x86,
powerpc and s390 build a helper and a hook that nothing calls.

>  #ifndef arch_kexec_locate_mem_hole
>  /**
>   * arch_kexec_locate_mem_hole - Find free memory to place the segments.
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 62d4cba278a57..8b80f1186875b 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -1295,3 +1295,93 @@ int kexec_purgatory_get_set_symbol(struct kimage *image, const char *name,
>  	return 0;
>  }
>  #endif /* CONFIG_ARCH_SUPPORTS_KEXEC_PURGATORY */
> +
> +int __weak arch_kexec_setup_other_segments(struct kimage *image,
> +					   struct kexec_load_params *params,
> +					   unsigned long initrd_load_addr)
> +{
> +	return 0;
> +}
> +
> +int kexec_load_other_segments(struct kimage *image,
> +			      struct kexec_load_params *params, bool top_down)
> +{
> +	struct kexec_buf kbuf = {
> +		.image = image,
> +		/* Do not allocate anything below the kernel */
> +		.buf_min = params->kernel_load_addr + params->kernel_size,
> +		.buf_max = top_down ? PFN_PHYS(max_low_pfn) : ULONG_MAX,
> +	};

top_down does not describe a direction, it selects "RISC-V policy" vs
"arm64 policy": the upper limit for all buffers, the initrd direction and
the 32G initrd window.

These are boot protocol constraints and they belong to the architecture.
The 32G window comes from arm64 booting.rst and the SZ_64K alignment below
is "largest supported page size" on arm64 and LoongArch. With this patch
they become generic and RISC-V silently switches from
ELF_CORE_HEADER_ALIGN to 64K in 15/15.


> +
> +	unsigned long orig_segments = image->nr_segments;
> +	unsigned long initrd_load_addr = 0;
> +	int ret = 0;
> +
> +#ifdef CONFIG_CRASH_DUMP
> +	if (image->type == KEXEC_TYPE_CRASH) {
> +		ret = crash_prepare_headers(true, &kbuf.buffer, &kbuf.bufsz, NULL);
> +		if (ret) {
> +			pr_err("Preparing elf core header failed\n");
> +			goto out_err;
> +		}
> +
> +		if (unlikely(image->elf_headers))
> +			vfree(image->elf_headers);

The headers don't depend on where the kernel is placed, yet they are
rebuilt on every iteration of the arm64 and LoongArch retry loops. That's
why the vfree() above is needed, and with the out_err path freeing them
it's now dead code.

Building the headers once and only placing them in the loop removes the
leak instead of fixing it.


> +
> +		image->elf_headers = kbuf.buffer;
> +		image->elf_headers_sz = kbuf.bufsz;
> +
> +		kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
> +		kbuf.memsz = kbuf.bufsz;
> +		kbuf.buf_align = SZ_64K; /* largest supported page size */
> +		kbuf.top_down = true;
> +
> +		ret = kexec_add_buffer(&kbuf);
> +		if (ret)
> +			goto out_err;
> +
> +		image->elf_load_addr = kbuf.mem;
> +
> +		kexec_dprintk("Loaded elf core header at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
> +			      image->elf_load_addr, kbuf.bufsz, kbuf.memsz);
> +	}
> +#endif
> +
> +	if (params->initrd) {
> +		kbuf.buffer = params->initrd;
> +		kbuf.bufsz = params->initrd_len;
> +		kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
> +		kbuf.memsz = params->initrd_len;
> +		kbuf.buf_align = 0;
> +		/* within 1GB-aligned window of up to 32GB in size */
> +		if (!top_down)
> +			kbuf.buf_max = round_down(params->kernel_load_addr, SZ_1G) +
> +					(unsigned long)SZ_1G * 32;
> +		kbuf.top_down = top_down;
> +
> +		ret = kexec_add_buffer(&kbuf);
> +		if (ret)
> +			goto out_err;
> +		initrd_load_addr = kbuf.mem;
> +
> +		kexec_dprintk("Loaded initrd at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
> +			      initrd_load_addr, kbuf.bufsz, kbuf.memsz);
> +	}
> +
> +	ret = arch_kexec_setup_other_segments(image, params,
> +					      initrd_load_addr);
> +	if (ret)
> +		goto out_err;
> +
> +	return 0;
> +
> +out_err:
> +	while (image->nr_segments > orig_segments) {
> +		kexec_free_segment_cma(image, image->nr_segments - 1);
> +		image->nr_segments--;
> +	}
> +
> +	kexec_free_elf_headers(image);

This drops segments added by the arch hook (DTB, RISC-V purgatory, arm64
dm-crypt keys) without knowing anything about the state attached to them,
like image->dm_crypt_keys_addr or the purgatory info. The hook, in turn,
frees its buffers but not its segments.

Nobody owns the unwind, so "a failure releases everything added for the
attempt" is not quite what happens.

The conversions also bury ordering changes in "simplify" patches: on arm64
dm-crypt keys move after the initrd, and on RISC-V the initrd moves before
the purgatory. And dm-crypt keys loading is not an arm64 boot parameter,
x86 and powerpc use it as well.

> +
> +	return ret;
> +}


What I had in mind was to make the core provide building blocks and let
the architectures compose them, e.g. a common rollback function that
frees CMAs and drops segments above nr. The retry loops in arm64 and
LoongArch image loaders can use it instead of open coding
kexec_free_segment_cma() and nr_segments--. There also could be a helper
for adding FDT for example and maybe some other common parts, like, say,
efl headers.

Arch's load_other_segments() could use these helpers and still define
their own policy for segment placement.

-- 
Sincerely yours,
Mike.


