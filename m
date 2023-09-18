Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D2CEC46CA1
	for <kexec@archiver.kernel.org>; Mon, 18 Sep 2023 12:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=QSkPHGJoneA0gLxAldE/J6bR4CRT/o96B9RXDadNyW4=; b=mj2Fcnjqm7/fOfmScaSed3EIKU
	9TlPG+a3KFs25PP8gX187JuV3WqJ9PbTS9GU1DQC6FkPnPQ2BnB9Ld0+wCaL7FQHmagrV3D3eciTg
	WXgcv35rhRhQedtnnGDTg0W+SgwnaJa1CtiYKR9ufWjbxYjOYRO/LMyegnhmLVSZQcpiieFRtMP89
	dS7ZYW3aXbhZVeM6oG3OpIaYJ5zJCe0BEt1hOb+nBoI4vd0VrkSyfjyg1w4MEyrBSZnMXV6SOWGQy
	lDu6PnLLAELqRR7NJZpW6xLma5URt3CykMDK9vWAlVbP1r6SWKsMAhmctfoVNKrcL2PMJSPsNIBCF
	w8hfOORw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qiDqH-00FU0Z-2o;
	Mon, 18 Sep 2023 12:59:09 +0000
Received: from [45.249.212.51] (helo=dggsgout11.his.huawei.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qiDqD-00FTxp-1J;
	Mon, 18 Sep 2023 12:59:08 +0000
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Rq4cL5Vhcz4f3kL1;
	Mon, 18 Sep 2023 20:58:58 +0800 (CST)
Received: from [10.174.178.55] (unknown [10.174.178.55])
	by APP4 (Coremail) with SMTP id gCh0CgD3gtKRSQhloRYiAw--.63961S3;
	Mon, 18 Sep 2023 20:58:59 +0800 (CST)
Subject: Re: [PATCH v3 5/9] crash_core: move crashk_*res definition into
 crash_core.c
To: Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org, thunder.leizhen@huawei.com,
 catalin.marinas@arm.com, chenjiahao16@huawei.com, kexec@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org,
 x86@kernel.org
References: <20230914033142.676708-1-bhe@redhat.com>
 <20230914033142.676708-6-bhe@redhat.com>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huaweicloud.com>
Message-ID: <69346bd7-1dc6-8202-f5d1-dbcf4ccac096@huaweicloud.com>
Date: Mon, 18 Sep 2023 20:58:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20230914033142.676708-6-bhe@redhat.com>
Content-Language: en-US
X-CM-TRANSID: gCh0CgD3gtKRSQhloRYiAw--.63961S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCryDAryxtr1xJryfuryfWFg_yoWrWFWUpF
	n3Ca1UCayUGF1DWrsxCr92yayFqw4FkFyI9rZrJr1rAa43tr1vgw4DWr12vF1qkFW5KFya
	qrWrur9Fk3yDXrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv
	67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
	uYvjxUOyCJDUUUU
X-CM-SenderInfo: hwkx0vthuozvpl2kv046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230918_055905_897972_7DE8451A 
X-CRM114-Status: GOOD (  19.16  )
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



On 2023/9/14 11:31, Baoquan He wrote:
> Both crashk_res and crashk_low_res are used to mark the reserved
> crashkernel regions in iomem_resource tree. And later the generic
> crashkernel resrvation will be added into crash_core.c. So move
> crashk_res and crashk_low_res definition into crash_core.c to avoid
> compiling error if CONFIG_CRASH_CORE=on while CONFIG_KEXEC_CORE is
> unset.
> 
> Meanwhile include <asm/crash_core.h> in <linux/crash_core.h> if generic
> reservation is needed. In that case, <asm/crash_core.h> need be added
> by ARCH. In asm/crash_core.h, ARCH can provide its own macro definitions
> to override macros in <linux/crash_core.h> if needed. Wrap the including
> into CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION ifdeffery scope to
> avoid compiling error in other ARCH-es which don't take the generic
> reservation way yet.

Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>

> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  include/linux/crash_core.h |  8 ++++++++
>  include/linux/kexec.h      |  4 ----
>  kernel/crash_core.c        | 16 ++++++++++++++++
>  kernel/kexec_core.c        | 17 -----------------
>  4 files changed, 24 insertions(+), 21 deletions(-)
> 
> diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
> index 4dbd6565e0ff..3c735a7e33fb 100644
> --- a/include/linux/crash_core.h
> +++ b/include/linux/crash_core.h
> @@ -5,6 +5,14 @@
>  #include <linux/linkage.h>
>  #include <linux/elfcore.h>
>  #include <linux/elf.h>
> +#ifdef CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
> +#include <asm/crash_core.h>
> +#endif
> +
> +/* Location of a reserved region to hold the crash kernel.
> + */
> +extern struct resource crashk_res;
> +extern struct resource crashk_low_res;
>  
>  #define CRASH_CORE_NOTE_NAME	   "CORE"
>  #define CRASH_CORE_NOTE_HEAD_BYTES ALIGN(sizeof(struct elf_note), 4)
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index 32c78078552c..8227455192b7 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -22,10 +22,6 @@
>  #include <uapi/linux/kexec.h>
>  #include <linux/verification.h>
>  
> -/* Location of a reserved region to hold the crash kernel.
> - */
> -extern struct resource crashk_res;
> -extern struct resource crashk_low_res;
>  extern note_buf_t __percpu *crash_notes;
>  
>  #ifdef CONFIG_KEXEC_CORE
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index ca66b5f41dc7..ad7dc03f3993 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -35,6 +35,22 @@ u32 *vmcoreinfo_note;
>  /* trusted vmcoreinfo, e.g. we can make a copy in the crash memory */
>  static unsigned char *vmcoreinfo_data_safecopy;
>  
> +/* Location of the reserved area for the crash kernel */
> +struct resource crashk_res = {
> +	.name  = "Crash kernel",
> +	.start = 0,
> +	.end   = 0,
> +	.flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM,
> +	.desc  = IORES_DESC_CRASH_KERNEL
> +};
> +struct resource crashk_low_res = {
> +	.name  = "Crash kernel",
> +	.start = 0,
> +	.end   = 0,
> +	.flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM,
> +	.desc  = IORES_DESC_CRASH_KERNEL
> +};
> +
>  /*
>   * parsing the "crashkernel" commandline
>   *
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index 9dc728982d79..be5642a4ec49 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -52,23 +52,6 @@ atomic_t __kexec_lock = ATOMIC_INIT(0);
>  /* Flag to indicate we are going to kexec a new kernel */
>  bool kexec_in_progress = false;
>  
> -
> -/* Location of the reserved area for the crash kernel */
> -struct resource crashk_res = {
> -	.name  = "Crash kernel",
> -	.start = 0,
> -	.end   = 0,
> -	.flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM,
> -	.desc  = IORES_DESC_CRASH_KERNEL
> -};
> -struct resource crashk_low_res = {
> -	.name  = "Crash kernel",
> -	.start = 0,
> -	.end   = 0,
> -	.flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM,
> -	.desc  = IORES_DESC_CRASH_KERNEL
> -};
> -
>  int kexec_should_crash(struct task_struct *p)
>  {
>  	/*
> 

-- 
Regards,
  Zhen Lei


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
