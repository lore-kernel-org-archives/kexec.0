Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A10FC43458
	for <kexec@archiver.kernel.org>; Tue, 30 Jun 2026 11:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kFi2ufhS9A7S0N/yneP1QPCfIlIbo7VUsBbxmuAgBec=; b=WCrRYEFVB9hX+isiDRsj42Aa3R
	AlrODzn2EvfEhHn1YyIufCUZCBvF0eNsFvhtB+qNAhysO4CvU+orTn4QTtYFZ/voFVim5Fsm/J7hz
	9v8sZwXPj3BM0h2JGeHdFTvQF+jZqNmaSkXLvtBvIkCz+118FXi1Z9f7T5fJ9NuBWUTbOhPiDzlHI
	bHQdPRmu1/sTGuU4sMWRfwic6+hSfYLZ9GqCv+oxKH6fe1SYxoWTbgi7U1t8psv+e/gb8mfHMH5UB
	zjtkK1rYGw427TwOd9Trp8iQlzLETs5Yc6cTVDKX7Bs66JHDaE8CdIiN4brxRMcYTSOJReWWUIb/7
	u5tpsivw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weWON-0000000Go4s-1zc5;
	Tue, 30 Jun 2026 11:12:39 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weWOL-0000000Go4W-3Fkz;
	Tue, 30 Jun 2026 11:12:37 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 3DE48409ED;
	Tue, 30 Jun 2026 11:12:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D92961F000E9;
	Tue, 30 Jun 2026 11:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782817957;
	bh=kFi2ufhS9A7S0N/yneP1QPCfIlIbo7VUsBbxmuAgBec=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=MGNhr8eNkW7digT0TFYt+epnd3BW/+YsO4q/eYHOhHz7227q1kCPu/CVHfYs/I4LI
	 iImDvzD+CnJnH7CqEqW/XrPImbYT9ptiNpLpvLD4AdrvLUw3YiFDRAyK6eJiIaRT/L
	 JhxLyvriaMRcYrkq0K/XDMQj9vGMNUQBiU+R8rNahF5oRZ1jxtDuY/aGxoQXEvrG5Q
	 9hyHAz62Sxg/kpxyVDYrXXapZ8OBaDtqmEJB9A61lTHrO7FNkmY4uFhkJQZyvzel2l
	 1MbHnImoQCt9VhcZlwlBYGj9EGHAnQ8aEgLQj6yfL92rZX/hhcgHNPJy1GrybDCrkG
	 fk/CJPKbEXU5Q==
From: Pratyush Yadav <pratyush@kernel.org>
To: Wandun Chen <chenwandun1@gmail.com>
Cc: chenhuacai@kernel.org,  kernel@xen0n.name,  pjw@kernel.org,
  palmer@dabbelt.com,  aou@eecs.berkeley.edu,  robh@kernel.org,
  saravanak@kernel.org,  bhe@redhat.com,  rppt@kernel.org,
  linux-arm-kernel@lists.infradead.org,  linux-kernel@vger.kernel.org,
  loongarch@lists.linux.dev,  linux-riscv@lists.infradead.org,
  devicetree@vger.kernel.org,  kexec@lists.infradead.org,
  iommu@lists.linux.dev,  zhaomeijing@lixiang.com,
  catalin.marinas@arm.com,  will@kernel.org,  alex@ghiti.fr,
  akpm@linux-foundation.org,  pasha.tatashin@soleen.com,
  pratyush@kernel.org,  ruirui.yang@linux.dev,  m.szyprowski@samsung.com,
  robin.murphy@arm.com
Subject: Re: [PATCH v4 09/10] riscv: kdump: exclude non-dumpable reserved
 memory regions from vmcore
In-Reply-To: <20260630074715.4126796-10-chenwandun1@gmail.com> (Wandun Chen's
	message of "Tue, 30 Jun 2026 15:47:13 +0800")
References: <20260630074715.4126796-1-chenwandun1@gmail.com>
	<20260630074715.4126796-10-chenwandun1@gmail.com>
Date: Tue, 30 Jun 2026 13:12:31 +0200
Message-ID: <2vxzechoi8o0.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

On Tue, Jun 30 2026, Wandun Chen wrote:

> From: Wandun Chen <chenwandun@lixiang.com>
>
> Apply the same non-dumpable reserved memory filtering to RISC-V kdump
> as was done for arm64. Use of_reserved_mem_kdump_exclude() to drop
> flagged regions from the elfcorehdr PT_LOAD segments, and
> of_reserved_mem_kdump_nr_ranges() to pre-size the crash_mem array.
>
> Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
> ---
>  arch/riscv/kernel/machine_kexec_file.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/riscv/kernel/machine_kexec_file.c b/arch/riscv/kernel/machine_kexec_file.c
> index 59d4bbc848a8..25359d583bc3 100644
> --- a/arch/riscv/kernel/machine_kexec_file.c
> +++ b/arch/riscv/kernel/machine_kexec_file.c
> @@ -10,6 +10,7 @@
>  #include <linux/elf.h>
>  #include <linux/slab.h>
>  #include <linux/of.h>
> +#include <linux/of_reserved_mem.h>
>  #include <linux/libfdt.h>
>  #include <linux/types.h>
>  #include <linux/memblock.h>
> @@ -64,6 +65,7 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
>  
>  	nr_ranges = 1; /* For exclusion of crashkernel region */
>  	walk_system_ram_res(0, -1, &nr_ranges, get_nr_ram_ranges_callback);
> +	nr_ranges += of_reserved_mem_kdump_nr_ranges();
>  
>  	cmem = kmalloc_flex(*cmem, ranges, nr_ranges);
>  	if (!cmem)
> @@ -77,6 +79,8 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
>  
>  	/* Exclude crashkernel region */
>  	ret = crash_exclude_mem_range(cmem, crashk_res.start, crashk_res.end);
> +	if (!ret)
> +		ret = of_reserved_mem_kdump_exclude(cmem);
>  	if (!ret)
>  		ret = crash_prepare_elf64_headers(cmem, true, addr, sz);

Nit: can you do the usual pattern of if (err) goto err; instead?

So this would look like:

	/* Exclude crashkernel region */
	ret = crash_exclude_mem_range(cmem, crashk_res.start, crashk_res.end);
	if (ret)
		goto out;

	ret = of_reserved_mem_kdump_exclude(cmem);
	if (ret)
		goto out;
        
	ret = crash_prepare_elf64_headers(cmem, true, addr, sz);
out:
	...

With this,

Acked-by: Pratyush Yadav <pratyush@kernel.org>

-- 
Regards,
Pratyush Yadav

