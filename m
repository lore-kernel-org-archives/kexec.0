Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEFF5C4167B
	for <kexec@archiver.kernel.org>; Fri,  1 Dec 2023 19:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pTGY7UkQk6LDc4jR5yGkP1eVd3vmN4ykKm7i9/d4cSo=; b=DB0plH+3l0drDk
	pFia1HWX5RlmxqaUNwQHqI7FJuSY6LLGCIKuxmZxRTEl1zhfKurIYvFrHwmx6bL7gjhCJRH65Laf7
	fymIgcs5PBONvDeu0cOtr9+jnNJtkxHaa/J0CbhhZQVDSGC1+y43as5SQliWsvVcZRPGpYyOqanfY
	5sVM03pk9M0KSr9WzDh6J29hnSNcqPygymOkUKciiCQIcn3UWeBq4gCX4x2qtQENFIGqIG66wrxYg
	9hTnFeun3UazuzHkbXbEcCgJ66NVcSjBjGP32f3s8xWbJohg/8o2KLz/AUMGUaGRD6Rd8xK3GLpRR
	kbyeHlXo3mMwP8ukEZtQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r99a3-00EXpe-2P;
	Fri, 01 Dec 2023 19:53:43 +0000
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1r99a0-00EXox-2x;
	Fri, 01 Dec 2023 19:53:40 +0000
Message-ID: <bbd1bbfb-c482-433d-bce9-2b591b8e855e@infradead.org>
Date: Fri, 1 Dec 2023 11:53:37 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: Tree for Dec 1 (riscv, crash_core)
Content-Language: en-US
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-riscv <linux-riscv@lists.infradead.org>,
 kexec <kexec@lists.infradead.org>, Baoquan He <bhe@redhat.com>
References: <20231201133726.4a4413dd@canb.auug.org.au>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231201133726.4a4413dd@canb.auug.org.au>
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



On 11/30/23 18:37, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20231130:
> 

on riscv 32-bit or 64-bit, with
# CONFIG_MMU is not set

In file included from ../arch/riscv/kernel/crash_core.c:3:
../arch/riscv/kernel/crash_core.c: In function 'arch_crash_save_vmcoreinfo':
../arch/riscv/kernel/crash_core.c:8:27: error: 'VA_BITS' undeclared (first use in this function)
    8 |         VMCOREINFO_NUMBER(VA_BITS);
      |                           ^~~~~~~
../include/linux/crash_core.h:78:64: note: in definition of macro 'VMCOREINFO_NUMBER'
   78 |         vmcoreinfo_append_str("NUMBER(%s)=%ld\n", #name, (long)name)
      |                                                                ^~~~
../arch/riscv/kernel/crash_core.c:8:27: note: each undeclared identifier is reported only once for each function it appears in
    8 |         VMCOREINFO_NUMBER(VA_BITS);
      |                           ^~~~~~~
../include/linux/crash_core.h:78:64: note: in definition of macro 'VMCOREINFO_NUMBER'
   78 |         vmcoreinfo_append_str("NUMBER(%s)=%ld\n", #name, (long)name)
      |                                                                ^~~~
../arch/riscv/kernel/crash_core.c:12:58: warning: format '%lx' expects argument of type 'long unsigned int', but argument 2 has type 'int' [-Wformat=]
   12 |         vmcoreinfo_append_str("NUMBER(VMALLOC_START)=0x%lx\n", VMALLOC_START);
      |                                                        ~~^
      |                                                          |
      |                                                          long unsigned int
      |                                                        %x
../arch/riscv/kernel/crash_core.c:14:64: error: 'VMEMMAP_START' undeclared (first use in this function)
   14 |         vmcoreinfo_append_str("NUMBER(VMEMMAP_START)=0x%lx\n", VMEMMAP_START);
      |                                                                ^~~~~~~~~~~~~
../arch/riscv/kernel/crash_core.c:15:62: error: 'VMEMMAP_END' undeclared (first use in this function); did you mean 'MEMREMAP_ENC'?
   15 |         vmcoreinfo_append_str("NUMBER(VMEMMAP_END)=0x%lx\n", VMEMMAP_END);
      |                                                              ^~~~~~~~~~~
      |                                                              MEMREMAP_ENC

64-bit only: 

../arch/riscv/kernel/crash_core.c:17:64: error: 'MODULES_VADDR' undeclared (first use in this function)
   17 |         vmcoreinfo_append_str("NUMBER(MODULES_VADDR)=0x%lx\n", MODULES_VADDR);
      |                                                                ^~~~~~~~~~~~~
../arch/riscv/kernel/crash_core.c:18:62: error: 'MODULES_END' undeclared (first use in this function)
   18 |         vmcoreinfo_append_str("NUMBER(MODULES_END)=0x%lx\n", MODULES_END);
      |                                                              ^~~~~~~~~~~



-- 
~Randy

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
