Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17F74C4167B
	for <kexec@archiver.kernel.org>; Mon,  4 Dec 2023 02:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=F4Djx45D1VK2d+7R5y8lSKTkN9iC8J9WDqRhX/JfW8E=; b=LUD4Oh1bF3xZa2
	+s+HsOmf915se+FaHqpNm9hy9ltikk1CRhVAMS5UIcKpjshYnb1GEwI9WAEHW8H0i3HQ10nM1ZOxW
	lm8/yqcFYeEd6TVYwl3uAhoOUrMo7CJIKHBRmEqEbFCYKL51RKN3F3Qfvj5yNziCoOktsx7KoT3yH
	1SpYXdWIGXbAsjnxVNUlNVYKtbD1l0OCZVBPJW250EEM1dI37n2uR4j4hxcKYCbCJR1iTi2ruKp4r
	2mIglZpjTDv98I8rqWyWirYimmFMNoO4L0caGAkTxy0KONiS9cis6Hl8n8BWG79D1/aCCqZGB6KKv
	7sO2bC5A4TnGP9oNZkRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r9yPf-002ovB-33;
	Mon, 04 Dec 2023 02:10:23 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r9yPY-002otn-26
	for kexec@lists.infradead.org;
	Mon, 04 Dec 2023 02:10:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701655814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=7DpzMW9l8USWbr/TXZ2mqrkhEXzMDf/T6QpMPtMWGcY=;
	b=Vn67vVh5w2GF+vZxq+FysbZrhpkVyF6tv3J4veCe9hS0ofoFEWXxAnSVuR/xe8rkR3kGhU
	k4erXSnaWnWx9wOGuZgLhcPN8tp029/13k4epUIKFCCsK75gFrKxgxhDtC99gsWqrmohbH
	DXm9xVfnIBOIQ0rXxWFIat9MtHrsjdo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-Xng4ZFAwNOuBMcJ3cikbmA-1; Sun, 03 Dec 2023 21:10:09 -0500
X-MC-Unique: Xng4ZFAwNOuBMcJ3cikbmA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 801BF811E86;
	Mon,  4 Dec 2023 02:10:08 +0000 (UTC)
Received: from localhost (unknown [10.72.113.121])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C25C5C1596F;
	Mon,  4 Dec 2023 02:10:07 +0000 (UTC)
Date: Mon, 4 Dec 2023 10:10:04 +0800
From: Baoquan He <bhe@redhat.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, akpm@linux-foundation.org,
	ignat@cloudflare.com, linux-next@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	kexec@lists.infradead.org, eric_devolder@yahoo.com
Subject: Re: Re: linux-next: Tree for Dec 1 (riscv, crash_core)
Message-ID: <ZW00/Cfk47Cc3kGo@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-Bad-Reply: 'Re:' in Subject but no References or In-Reply-To headers
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231203_181016_895689_F635CC34 
X-CRM114-Status: GOOD (  22.43  )
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

eric_devolder@yahoo.com, ignat@cloudflare.com,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-riscv <linux-riscv@lists.infradead.org>,
	kexec <kexec@lists.infradead.org>
Bcc: bhe@redhat.com
Subject: Re: linux-next: Tree for Dec 1 (riscv, crash_core)
Reply-To: 
In-Reply-To: <bbd1bbfb-c482-433d-bce9-2b591b8e855e@infradead.org>

On 12/01/23 at 11:53am, Randy Dunlap wrote:
> 
> 
> On 11/30/23 18:37, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Changes since 20231130:
> > 
> 
> on riscv 32-bit or 64-bit, with
> # CONFIG_MMU is not set

Thanks for providing the kernel config to ease reproduction. In the config,
there are:

CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_CRASH_DUMP=y
......
# CONFIG_MMU is not set

After investigation, I found this happened after Ignat's patch:
commit 1c7a3fa49ef7 ("kexec: drop dependency on ARCH_SUPPORTS_KEXEC from CRASH_DUMP")

Copy above commit change here for reference, and also risc-v's
ARCH_SUPPORTS_KEXEC depends on MMU:
--------------------------------------------------------
diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
index fc38f1ae3a30..946dffa048b7 100644
--- a/kernel/Kconfig.kexec
+++ b/kernel/Kconfig.kexec
@@ -96,7 +96,6 @@ config KEXEC_JUMP
 config CRASH_DUMP
        bool "kernel crash dumps"
        depends on ARCH_SUPPORTS_CRASH_DUMP
-       depends on ARCH_SUPPORTS_KEXEC
        select CRASH_CORE
        select KEXEC_CORE
        help

arch/riscv/Kconfig
---------------------
config ARCH_SUPPORTS_KEXEC
        def_bool MMU

Before Ignat's patch, once CONFIG_MMU is unset, CONFIG_CRASH_DUMP,
CONFIG_KEXEC_CORE, CONFIG_CRASH_CORE are all unset automatically. The
crash_core codes are not compiled. That's why no compiling error is
seen.

After Ignat's patch applied, we can enable CONFIG_CRASH_DUMP,
CONFIG_KEXEC_CORE, CONFIG_CRASH_CORE independently. However, there are
several macro definitions, such as VA_BITS, VMEMMAP_START, VMEMMAP_END,
MODULES_VADDR, MODULES_END are only available when CONFIG_MMU=y.

I made two patches to decouple the kexec/crash code with CONFIG_MMU. Not
sure if risc-v wants that.

Or we can simply add dependency on MMU for ARCH_SUPPORTS_CRASH_DUMP.
Then when CONFIG_MMU=n, CONFIG_CRASH_DUMP, CONFIG_KEXEC_CORE,
CONFIG_CRASH_CORE will be unset too. Please help check which one need be
taken.


diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 24c1799e2ec4..03d290da7262 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -708,6 +708,7 @@ config ARCH_SUPPORTS_KEXEC_PURGATORY
 
 config ARCH_SUPPORTS_CRASH_DUMP
 	def_bool y
+	depends on MMU=y
 
 config ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
 	def_bool CRASH_CORE

> 
> In file included from ../arch/riscv/kernel/crash_core.c:3:
> ../arch/riscv/kernel/crash_core.c: In function 'arch_crash_save_vmcoreinfo':
> ../arch/riscv/kernel/crash_core.c:8:27: error: 'VA_BITS' undeclared (first use in this function)
>     8 |         VMCOREINFO_NUMBER(VA_BITS);
>       |                           ^~~~~~~
> ../include/linux/crash_core.h:78:64: note: in definition of macro 'VMCOREINFO_NUMBER'
>    78 |         vmcoreinfo_append_str("NUMBER(%s)=%ld\n", #name, (long)name)
>       |                                                                ^~~~
> ../arch/riscv/kernel/crash_core.c:8:27: note: each undeclared identifier is reported only once for each function it appears in
>     8 |         VMCOREINFO_NUMBER(VA_BITS);
>       |                           ^~~~~~~
> ../include/linux/crash_core.h:78:64: note: in definition of macro 'VMCOREINFO_NUMBER'
>    78 |         vmcoreinfo_append_str("NUMBER(%s)=%ld\n", #name, (long)name)
>       |                                                                ^~~~
> ../arch/riscv/kernel/crash_core.c:12:58: warning: format '%lx' expects argument of type 'long unsigned int', but argument 2 has type 'int' [-Wformat=]
>    12 |         vmcoreinfo_append_str("NUMBER(VMALLOC_START)=0x%lx\n", VMALLOC_START);
>       |                                                        ~~^
>       |                                                          |
>       |                                                          long unsigned int
>       |                                                        %x
> ../arch/riscv/kernel/crash_core.c:14:64: error: 'VMEMMAP_START' undeclared (first use in this function)
>    14 |         vmcoreinfo_append_str("NUMBER(VMEMMAP_START)=0x%lx\n", VMEMMAP_START);
>       |                                                                ^~~~~~~~~~~~~
> ../arch/riscv/kernel/crash_core.c:15:62: error: 'VMEMMAP_END' undeclared (first use in this function); did you mean 'MEMREMAP_ENC'?
>    15 |         vmcoreinfo_append_str("NUMBER(VMEMMAP_END)=0x%lx\n", VMEMMAP_END);
>       |                                                              ^~~~~~~~~~~
>       |                                                              MEMREMAP_ENC
> 
> 64-bit only: 
> 
> ../arch/riscv/kernel/crash_core.c:17:64: error: 'MODULES_VADDR' undeclared (first use in this function)
>    17 |         vmcoreinfo_append_str("NUMBER(MODULES_VADDR)=0x%lx\n", MODULES_VADDR);
>       |                                                                ^~~~~~~~~~~~~
> ../arch/riscv/kernel/crash_core.c:18:62: error: 'MODULES_END' undeclared (first use in this function)
>    18 |         vmcoreinfo_append_str("NUMBER(MODULES_END)=0x%lx\n", MODULES_END);
>       |                                                              ^~~~~~~~~~~
> 
> 
> 
> -- 
> ~Randy
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
