Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94741C433FE
	for <kexec@archiver.kernel.org>; Thu, 20 Oct 2022 02:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ddzzy/Q+HB+cGfYKo/UQaR3oBMQYh/IHKqQUhzG5hLo=; b=kmXcAXsMgZaN2r
	uf8qQsg5ZyXMETX04mf3Y6Yo5rV7i8QkFsyl6DICjCgi/hGk1HRSUS4bmksxxwe4keF+F026EqCvv
	pN6a6EAunD2gQgaAKE/T18Hn7LuLv5NqyxE/4OeoIqbSi4AF861I+IA1soh14JP/h/Yduvm8SoZUE
	XxhwVfld4Eku+EZGtwD84DHa1PIuQk0u6NbRYVykE32vNHLjxcN9U+EeRO3DxQNPxXhDy7fW3KZpf
	rxNyPPvPbjEEntyPRSHIxp5PRF4rB6jZAAtcHbwiXzZa5ZdPY5wfRhe6wWiGIxjrUU3Jrr318+z4w
	rToQdeUKXVUlEpWYo/gw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olKzX-009PKb-Me; Thu, 20 Oct 2022 02:09:03 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olKzU-009PJ6-5P
	for kexec@lists.infradead.org; Thu, 20 Oct 2022 02:09:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1666231738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ba5NE9Dt+mVGgzTdquEVzfX/7nF3Hbru1aJHQKnQt9M=;
	b=VBS2ZEEUwYJmZ4F5skzJTW3/HVClVUwZsLvTeElp1rto2BQ7zVsIquxi2Nx98og5p0nhG+
	BL1SaHL/OgMkLkZaGmnCD+Uc7uyPUToRZ1i24CqAdhA/AH51zqJOclk3JWdtIw9EOZutEL
	gKKHAyphNV8aBV7JUEg/OIE+NVixN4c=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-220-kT1rBtH6NWe_Eb20E9SHwA-1; Wed, 19 Oct 2022 22:08:51 -0400
X-MC-Unique: kT1rBtH6NWe_Eb20E9SHwA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1BA121C068C2;
	Thu, 20 Oct 2022 02:08:51 +0000 (UTC)
Received: from localhost (ovpn-12-35.pek2.redhat.com [10.72.12.35])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id F0D58140EBF3;
	Thu, 20 Oct 2022 02:08:48 +0000 (UTC)
Date: Thu, 20 Oct 2022 10:08:45 +0800
From: Baoquan He <bhe@redhat.com>
To: Xianting Tian <xianting.tian@linux.alibaba.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	anup@brainfault.org, heiko@sntech.de, guoren@kernel.org,
	mick@ics.forth.gr, alexandre.ghiti@canonical.com, vgoyal@redhat.com,
	dyoung@redhat.com, corbet@lwn.net, Conor.Dooley@microchip.com,
	bagasdotme@gmail.com, k-hagio-ab@nec.com, lijiang@redhat.com,
	kexec@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	crash-utility@redhat.com, heinrich.schuchardt@canonical.com,
	hschauhan@nulltrace.org, yixun.lan@gmail.com
Subject: Re: [PATCH V4 1/2] RISC-V: Add arch_crash_save_vmcoreinfo support
Message-ID: <Y1CtreAKT/SEh4vN@MiWiFi-R3L-srv>
References: <20221019103623.7008-1-xianting.tian@linux.alibaba.com>
 <20221019103623.7008-2-xianting.tian@linux.alibaba.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221019103623.7008-2-xianting.tian@linux.alibaba.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221019_190900_322447_B0E76F10 
X-CRM114-Status: GOOD (  22.03  )
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

On 10/19/22 at 06:36pm, Xianting Tian wrote:
> Add arch_crash_save_vmcoreinfo(), which exports VM layout(MODULES, VMALLOC,
> VMEMMAP ranges and KERNEL_LINK_ADDR), va bits and ram base for vmcore.
> 
> Default pagetable levels and PAGE_OFFSET aren't same for different kernel
> version as below. For pagetable levels, it sets sv57 by default and falls
> back to setting sv48 at boot time if sv57 is not supported by the hardware.
> 
> For ram base, the default value is 0x80200000 for qemu riscv64 env and,
> for example, is 0x200000 on the XuanTie 910 CPU.
> 
>  * Linux Kernel 5.18 ~
>  *      PGTABLE_LEVELS = 5
>  *      PAGE_OFFSET = 0xff60000000000000
>  * Linux Kernel 5.17 ~
>  *      PGTABLE_LEVELS = 4
>  *      PAGE_OFFSET = 0xffffaf8000000000
>  * Linux Kernel 4.19 ~
>  *      PGTABLE_LEVELS = 3
>  *      PAGE_OFFSET = 0xffffffe000000000
> 
> Since these configurations change from time to time and version to version,
> it is preferable to export them via vmcoreinfo than to change the crash's
> code frequently, it can simplify the development of crash tool.
> 
> Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
> ---
>  arch/riscv/kernel/Makefile     |  1 +
>  arch/riscv/kernel/crash_core.c | 23 +++++++++++++++++++++++
>  2 files changed, 24 insertions(+)
>  create mode 100644 arch/riscv/kernel/crash_core.c
> 
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index db6e4b1294ba..4cf303a779ab 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -81,6 +81,7 @@ obj-$(CONFIG_KGDB)		+= kgdb.o
>  obj-$(CONFIG_KEXEC_CORE)	+= kexec_relocate.o crash_save_regs.o machine_kexec.o
>  obj-$(CONFIG_KEXEC_FILE)	+= elf_kexec.o machine_kexec_file.o
>  obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
> +obj-$(CONFIG_CRASH_CORE)	+= crash_core.o
>  
>  obj-$(CONFIG_JUMP_LABEL)	+= jump_label.o
>  
> diff --git a/arch/riscv/kernel/crash_core.c b/arch/riscv/kernel/crash_core.c
> new file mode 100644
> index 000000000000..3e889d0ed7bd
> --- /dev/null
> +++ b/arch/riscv/kernel/crash_core.c
> @@ -0,0 +1,23 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <linux/crash_core.h>
> +#include <linux/pagemap.h>
> +
> +void arch_crash_save_vmcoreinfo(void)
> +{
> +	VMCOREINFO_NUMBER(VA_BITS);
> +	VMCOREINFO_NUMBER(phys_ram_base);
> +
> +	vmcoreinfo_append_str("NUMBER(PAGE_OFFSET)=0x%lx\n", PAGE_OFFSET);
> +	vmcoreinfo_append_str("NUMBER(VMALLOC_START)=0x%lx\n", VMALLOC_START);
> +	vmcoreinfo_append_str("NUMBER(VMALLOC_END)=0x%lx\n", VMALLOC_END);
> +	vmcoreinfo_append_str("NUMBER(VMEMMAP_START)=0x%lx\n", VMEMMAP_START);
> +	vmcoreinfo_append_str("NUMBER(VMEMMAP_END)=0x%lx\n", VMEMMAP_END);
> +#ifdef CONFIG_64BIT
> +	vmcoreinfo_append_str("NUMBER(MODULES_VADDR)=0x%lx\n", MODULES_VADDR);
> +	vmcoreinfo_append_str("NUMBER(MODULES_END)=0x%lx\n", MODULES_END);
> +#endif
> +
> +	if (IS_ENABLED(CONFIG_64BIT))
> +		vmcoreinfo_append_str("NUMBER(KERNEL_LINK_ADDR)=0x%lx\n", KERNEL_LINK_ADDR);

Wondering why you don't put KERNEL_LINK_ADDR exporting into the above
ifdeffery scope, with that you can save one line of "IS_ENABLED(CONFIG_64BIT)".


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
