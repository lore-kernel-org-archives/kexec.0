Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E0FBC47073
	for <kexec@archiver.kernel.org>; Thu,  4 Jan 2024 11:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dc7B6FQcVzt3G50rJ9FyZQE75Ku47V3RYlSPofhE9oU=; b=rM+xIwzrVkC0Mr
	BvIiTbh5P7m2R4zVmXOw3Hf37BKY/lq+Y+9Kd9dzsctuFHBNpaxDjRZM8ld/V266q21aVvn+gCucp
	0TMGrIUu+2cuMHwhftTle299+5IXekDwBSd3B45rs6ZnX/26yCC87MmB0LHcF5v51pQB7GCkJ7xiX
	upCW5N8TzGb/d3uNccPnCY+2kV2xWk1V2MuRYm1n8mp+InDxqHkZHFt+kLR4N6FqfQkN4vklGMRRz
	S6ynbeFtwLlN2HUA93znHJWVQdacQW4an31HwAdiUGC9LA12aN9bGi70QaVeKuX0scnzVS6Z+IhNK
	Ur/cF/pEaV1c9nvH3/UQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rLLiN-00Dff5-11;
	Thu, 04 Jan 2024 11:16:43 +0000
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rLLiH-00Dfdc-1p
	for kexec@lists.infradead.org;
	Thu, 04 Jan 2024 11:16:39 +0000
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-a279ce3aab9so46978266b.0
        for <kexec@lists.infradead.org>; Thu, 04 Jan 2024 03:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1704366993; x=1704971793; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6zqYkg8yk8zP0vzRSPS98tqeixvnsBHfftd361m6Is4=;
        b=HIsYsYNbNrDeuuEmVCCBuEuIMOzr2fyZr54qywV/6wasZctb6EHUJeg/ChW1x+mzl0
         EwM99QHmycWtdFjLOMEWkQl0FvFgjdov9TjWdlK//cqfUz/KfSp/HzB2L1tEvR0V0rQ1
         5CuVbxV2IeZBrIUljqvq7/VmBbD4HEevUXrc5kPuIw+WBsc76axCC2VU30AfLhtQh0Ax
         4Nwe1d5llC61KNR8P8XK3vPrOU8Mh6LdW1LDeN7oNOd5p1733g6DblYfUSO4lMbkKNE/
         bm3PbV9guBBdoxW1L7zYgBv0RB3DapZAQPikNG/8YpiRl7F3VK1mlxsz2jx27Rpou9Ib
         LShQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704366993; x=1704971793;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6zqYkg8yk8zP0vzRSPS98tqeixvnsBHfftd361m6Is4=;
        b=bDnYKzlNbgCNYBkuV1bxzEKpxtKmzfIQVwVw8PKf5YXKAZaC/27M6TZa049fKnAYK+
         z+FH+bUJ2EvKCKWHaG7xQ0Zr7P0scxQBcFb9eJb/lh+FyS2ixrHdTW2Y2lXqSX3CuxQq
         vmifyAQdQRtCxHC3ARl11iCHMEaNIYWr11iXzc2AD6lLZ+9pQyp1e3Elae/ujUmMkBzW
         zoGxWwQhyX5+OfQ5maNxHhgJhH+OOYfhBmGzoc/4TmdjULj0kmoudGPyGgEQ/RH2Qca1
         luHdtNgGZ3AZVu029Vn/DT5dOlSwBCQG249JBdzBQaD9Kn7Occ/JK55W7iaxWxLZslQf
         Ihnw==
X-Gm-Message-State: AOJu0YzcWxs0d/v/qVDkD17r7X3iBb+UMXqlX5XaVzEnSvrI/vgx8pjd
	hiGc41gGCnOoRR4ZYK98GSurxqRTPdHmyQ==
X-Google-Smtp-Source: AGHT+IFKS6wv9L1TAw0aXFiLo+P9K0iu/ZQVSiHhV0dPtI/Qr6VzH6xarKf1rn+q35Ljo49uFB2Fng==
X-Received: by 2002:a17:906:5792:b0:a23:748e:f3eb with SMTP id k18-20020a170906579200b00a23748ef3ebmr122546ejq.286.1704366993185;
        Thu, 04 Jan 2024 03:16:33 -0800 (PST)
Received: from alley ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id ef13-20020a17090697cd00b00a28d2e95152sm596149ejb.129.2024.01.04.03.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 03:16:32 -0800 (PST)
Date: Thu, 4 Jan 2024 12:16:30 +0100
From: Petr Mladek <pmladek@suse.com>
To: Ruipeng Qi <ruipengqi7@gmail.com>
Cc: catalin.marinas@arm.com, will@kernel.org, bhe@redhat.com,
	vgoyal@redhat.com, dyoung@redhat.com, rostedt@goodmis.org,
	john.ogness@linutronix.de, senozhatsky@chromium.org,
	akpm@linux-foundation.org, qiruipeng@lixiang.com, maz@kernel.org,
	lecopzer.chen@mediatek.com, ardb@kernel.org, mark.rutland@arm.com,
	yury.norov@gmail.com, arnd@arndb.de, mcgrof@kernel.org,
	brauner@kernel.org, dianders@chromium.org, maninder1.s@samsung.com,
	michael.christie@oracle.com, samitolvanen@google.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org
Subject: Re: [RFC PATCH 2/7] osdump: reuse some code from crash_core to get
 vmcoreinfo
Message-ID: <ZZaTjl4Ngp7haNZZ@alley>
References: <20231221132522.547-1-ruipengqi7@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231221132522.547-1-ruipengqi7@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240104_031637_606672_C35F37DF 
X-CRM114-Status: GOOD (  28.06  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hi Qi,

first, most people, including me, prefer to be in Cc for the entire patchset.
It helps to get the whole picture.

This mail is even worse because the other patches are not in the same
thread. As a result, I can't find the other patches even via lore,
see https://lore.kernel.org/all/20231221132522.547-1-ruipengqi7@gmail.com/


On Thu 2023-12-21 21:25:22, Ruipeng Qi wrote:
> From: qiruipeng <qiruipeng@lixiang.com>
> 
> Osdump is a new crash dumping solution like crash. It is interested in
> vmcoreinfo,too. Reuse some data and function from crash_core, but not full
> of them. So pick some code to get vmcoreinfo as needed.

> diff --git a/kernel/crash_core_mini.c b/kernel/crash_core_mini.c
> new file mode 100644
> index 000000000000..a0f8d0c79bba
> --- /dev/null
> +++ b/kernel/crash_core_mini.c
> @@ -0,0 +1,275 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * crash.c - kernel crash support code.
> + * Copyright (C) 2002-2004 Eric Biederman  <ebiederm@xmission.com>
> + */
> +
> +#include <linux/buildid.h>
> +#include <linux/init.h>
> +#include <linux/utsname.h>
> +#include <linux/vmalloc.h>
> +#include <linux/sizes.h>
> +#include <linux/kexec.h>
> +#include <linux/memory.h>
> +#include <linux/cpuhotplug.h>
> +#include <linux/memblock.h>
> +#include <linux/kexec.h>
> +#include <linux/kmemleak.h>
> +
> +#include <asm/page.h>
> +#include <asm/sections.h>
> +
> +#include <crypto/sha1.h>
> +
> +#include "kallsyms_internal.h"
> +#include "kexec_internal.h"
> +
> +/* Per cpu memory for storing cpu states in case of system crash. */
> +note_buf_t __percpu *crash_notes;
> +
> +/* vmcoreinfo stuff */
> +unsigned char *vmcoreinfo_data;
> +size_t vmcoreinfo_size;
> +u32 *vmcoreinfo_note;
> +
> +/* trusted vmcoreinfo, e.g. we can make a copy in the crash memory */
> +static unsigned char *vmcoreinfo_data_safecopy;
> +
> +
> +Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
> +			  void *data, size_t data_len)
> +{
> +	struct elf_note *note = (struct elf_note *)buf;
> +
> +	note->n_namesz = strlen(name) + 1;
> +	note->n_descsz = data_len;
> +	note->n_type   = type;
> +	buf += DIV_ROUND_UP(sizeof(*note), sizeof(Elf_Word));
> +	memcpy(buf, name, note->n_namesz);
> +	buf += DIV_ROUND_UP(note->n_namesz, sizeof(Elf_Word));
> +	memcpy(buf, data, data_len);
> +	buf += DIV_ROUND_UP(data_len, sizeof(Elf_Word));
> +
> +	return buf;
> +}
> +
> +void final_note(Elf_Word *buf)
> +{
> +	memset(buf, 0, sizeof(struct elf_note));
> +}
> +
> +static void update_vmcoreinfo_note(void)
> +{
> +	u32 *buf = vmcoreinfo_note;
> +
> +	if (!vmcoreinfo_size)
> +		return;
> +	buf = append_elf_note(buf, VMCOREINFO_NOTE_NAME, 0, vmcoreinfo_data,
> +			      vmcoreinfo_size);
> +	final_note(buf);
> +}
> +
> +void crash_update_vmcoreinfo_safecopy(void *ptr)
> +{
> +	if (ptr)
> +		memcpy(ptr, vmcoreinfo_data, vmcoreinfo_size);
> +
> +	vmcoreinfo_data_safecopy = ptr;
> +}
> +
> +void crash_save_vmcoreinfo(void)
> +{
> +	if (!vmcoreinfo_note)
> +		return;
> +
> +	/* Use the safe copy to generate vmcoreinfo note if have */
> +	if (vmcoreinfo_data_safecopy)
> +		vmcoreinfo_data = vmcoreinfo_data_safecopy;
> +
> +	vmcoreinfo_append_str("CRASHTIME=%lld\n", ktime_get_real_seconds());
> +	update_vmcoreinfo_note();
> +}
> +
> +void vmcoreinfo_append_str(const char *fmt, ...)
> +{
> +	va_list args;
> +	char buf[0x50];
> +	size_t r;
> +
> +	va_start(args, fmt);
> +	r = vscnprintf(buf, sizeof(buf), fmt, args);
> +	va_end(args);
> +
> +	r = min(r, (size_t)VMCOREINFO_BYTES - vmcoreinfo_size);
> +
> +	memcpy(&vmcoreinfo_data[vmcoreinfo_size], buf, r);
> +
> +	vmcoreinfo_size += r;
> +
> +	WARN_ONCE(vmcoreinfo_size == VMCOREINFO_BYTES,
> +		  "vmcoreinfo data exceeds allocated size, truncating");
> +}
> +
> +/*
> + * provide an empty default implementation here -- architecture
> + * code may override this
> + */
> +void __weak arch_crash_save_vmcoreinfo(void)
> +{}
> +
> +phys_addr_t __weak paddr_vmcoreinfo_note(void)
> +{
> +	return __pa(vmcoreinfo_note);
> +}
> +EXPORT_SYMBOL(paddr_vmcoreinfo_note);
> +
> +int get_note_size(void)
> +{
> +	return VMCOREINFO_NOTE_SIZE;
> +}
> +
> +static int __init crash_save_vmcoreinfo_init(void)
> +{
> +	vmcoreinfo_data = (unsigned char *)get_zeroed_page(GFP_KERNEL);
> +	if (!vmcoreinfo_data) {
> +		pr_warn("Memory allocation for vmcoreinfo_data failed\n");
> +		return -ENOMEM;
> +	}
> +
> +	vmcoreinfo_note = alloc_pages_exact(VMCOREINFO_NOTE_SIZE,
> +						GFP_KERNEL | __GFP_ZERO);
> +	if (!vmcoreinfo_note) {
> +		free_page((unsigned long)vmcoreinfo_data);
> +		vmcoreinfo_data = NULL;
> +		pr_warn("Memory allocation for vmcoreinfo_note failed\n");
> +		return -ENOMEM;
> +	}
> +
> +	VMCOREINFO_OSRELEASE(init_uts_ns.name.release);
> +	VMCOREINFO_BUILD_ID();
> +	VMCOREINFO_PAGESIZE(PAGE_SIZE);
> +
> +	VMCOREINFO_SYMBOL(init_uts_ns);
> +	VMCOREINFO_OFFSET(uts_namespace, name);
> +	VMCOREINFO_SYMBOL(node_online_map);
> +#ifdef CONFIG_MMU
> +	VMCOREINFO_SYMBOL_ARRAY(swapper_pg_dir);
> +#endif
> +	VMCOREINFO_SYMBOL(_stext);
> +	VMCOREINFO_SYMBOL(vmap_area_list);
> +
> +#ifndef CONFIG_NUMA
> +	VMCOREINFO_SYMBOL(mem_map);
> +	VMCOREINFO_SYMBOL(contig_page_data);
> +#endif
> +#ifdef CONFIG_SPARSEMEM
> +	VMCOREINFO_SYMBOL_ARRAY(mem_section);
> +	VMCOREINFO_LENGTH(mem_section, NR_SECTION_ROOTS);
> +	VMCOREINFO_STRUCT_SIZE(mem_section);
> +	VMCOREINFO_OFFSET(mem_section, section_mem_map);
> +	VMCOREINFO_NUMBER(SECTION_SIZE_BITS);
> +	VMCOREINFO_NUMBER(MAX_PHYSMEM_BITS);
> +#endif

[...]

It seems that this duplicates a lot of code from kernel/crash_core.c.
It is a bad idea and maintenance nightmare.

It is not acceptable from my POV. Please, split the shared code
into a separate source file.

BTW: Is it really a big deal to just share the entire vmcoreinfo?
     Osdump might just ignore entries which are not supported
     at the moment.

Best Regards,
Petr

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
