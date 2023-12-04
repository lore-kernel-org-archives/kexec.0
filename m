Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D767AC4167B
	for <kexec@archiver.kernel.org>; Mon,  4 Dec 2023 02:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/ZTmSFs5hS0pZdJf/Lm5g38Reg+R+pj626FqybBMDn8=; b=SEph38bYK8ifQB
	pr84e6+5vzjS8PLNs+m9GFjbNag93kjE9ufWexBg7CohgmIeZcDcTfkQtOfLe3bzMwU5pfKFrQdZi
	3lyinE5/HRFgAL/RSkpC7q2Fk4fYxMq0N/RQHzppf+L/i74o9X9PP7NvD0dgBESfZeNzJH4NyiJG4
	MvQX+uFsSyN0eCRDmN6/yQBglZcnzBrHGyxqMGNmt2JICu6Tt9mGpe5NmwVE7Y/dbcmKTQIOG9Pso
	TgKEFSnO3DA7ag5mErTgDH5fOmhyse8aAys49ldafx5TRyTE1s02vpmHsI1qIiRzZoddEwCoGGofc
	85VF+kPIuN4ROrvL59Ug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r9yYp-002pM0-2G;
	Mon, 04 Dec 2023 02:19:52 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r9yYk-002pKk-2E
	for kexec@lists.infradead.org;
	Mon, 04 Dec 2023 02:19:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701656385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kEYLn+UWJXzVvOdXDQoSl0HV2uxdkFhIxrNZEqvidvw=;
	b=bKNUhvejjTi2F8VnkWBXjstDBUm2CpscUvlVDOA0FR92ky5L7GoqD4orXNYYzk6bsUztI8
	nah17naJUl2fz0BuBrIgVcTGiHjZvX59LQV8Dmn0yQYMuGfTx/lbwKvEnNJNuuHU2o+c77
	wWTq/wCCr15DcqQ6gfM2XMfqgsl/Y3s=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-527-IJdQXgyNMci1xrid06S4Qw-1; Sun,
 03 Dec 2023 21:19:41 -0500
X-MC-Unique: IJdQXgyNMci1xrid06S4Qw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F151E1C041BF;
	Mon,  4 Dec 2023 02:19:40 +0000 (UTC)
Received: from localhost (unknown [10.72.113.121])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4F2A9492BFC;
	Mon,  4 Dec 2023 02:19:39 +0000 (UTC)
Date: Mon, 4 Dec 2023 10:19:36 +0800
From: Baoquan He <bhe@redhat.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, akpm@linux-foundation.org,
	ignat@cloudflare.com, linux-next@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	kexec@lists.infradead.org, eric_devolder@yahoo.com
Subject: [PATCH 1/2] riscv, crash: don't export some symbols when CONFIG_MMU=n
Message-ID: <ZW03ODUKGGhP1ZGU@MiWiFi-R3L-srv>
References: <ZW00/Cfk47Cc3kGo@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZW00/Cfk47Cc3kGo@MiWiFi-R3L-srv>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231203_181946_873775_776B10A6 
X-CRM114-Status: GOOD (  12.97  )
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

When dropping select of KEXEC and dependency on ARCH_SUPPORTS_KEXEC
from CRASH_DUMP, compiling error is reported when below config items are
set:
-----------------------
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_CRASH_DUMP=y
......
-----------------------

-------------------------------------------------------------------------------------------------
arch/riscv/kernel/crash_core.c:8:27: error: 'VA_BITS' undeclared (first use in this function)
 8 |         VMCOREINFO_NUMBER(VA_BITS);
   |                           ^~~~~~~
include/linux/crash_core.h:78:64: note: in definition of macro 'VMCOREINFO_NUMBER'
78 |         vmcoreinfo_append_str("NUMBER(%s)=%ld\n", #name, (long)name)
   |                                                                ^~~~

arch/riscv/kernel/crash_core.c:14:64: error: 'VMEMMAP_START' undeclared (first use in this function)
14 |         vmcoreinfo_append_str("NUMBER(VMEMMAP_START)=0x%lx\n", VMEMMAP_START);
   |                                                                ^~~~~~~~~~~~~
arch/riscv/kernel/crash_core.c:15:62: error: 'VMEMMAP_END' undeclared (first use in this function); did you mean 'MEMREMAP_ENC'?
15 |         vmcoreinfo_append_str("NUMBER(VMEMMAP_END)=0x%lx\n", VMEMMAP_END);
   |                                                              ^~~~~~~~~~~
   |                                                              MEMREMAP_ENC
arch/riscv/kernel/crash_core.c:17:64: error: 'MODULES_VADDR' undeclared (first use in this function)
17 |         vmcoreinfo_append_str("NUMBER(MODULES_VADDR)=0x%lx\n", MODULES_VADDR);
   |                                                                ^~~~~~~~~~~~~
arch/riscv/kernel/crash_core.c:18:62: error: 'MODULES_END' undeclared (first use in this function)
18 |         vmcoreinfo_append_str("NUMBER(MODULES_END)=0x%lx\n", MODULES_END);
-------------------------------------------------------------------------------------------------

Currently, riscv's ARCH_SUPPORTS_KEXEC has dependency on MMU. Before
dropping ARCH_SUPPORTS_KEXEC, disabling CONFIG_MMU will unset
CONFIG_CRASH_DUMP, CONFIG_KEXEC_CORE, CONFIG_CRASH_CORE. Hence
crash_core related codes won't be compiled.

---------------------
arch/riscv/Kconfig:
config ARCH_SUPPORTS_KEXEC
        def_bool MMU
---------------------

After dropping ARCH_SUPPORTS_KEXEC, CONFIG_CRASH_DUMP, CONFIG_KEXEC_CORE,
CONFIG_CRASH_CORE can be set independently of CONFIG_MMU. However, there
are several macro definitions, such as VA_BITS, VMEMMAP_START, VMEMMAP_END,
MODULES_VADDR, MODULES_END are only available when CONFIG_MMU=y. Then
compiling errors are triggered.

Here, add CONFIG_MMU ifdeffery in arch_crash_save_vmcoreinfo() to export
those symbols when CONFIG_MMU is enabled.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/riscv/kernel/crash_core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/crash_core.c b/arch/riscv/kernel/crash_core.c
index 55f1d7856b54..8706736fd4e2 100644
--- a/arch/riscv/kernel/crash_core.c
+++ b/arch/riscv/kernel/crash_core.c
@@ -5,17 +5,19 @@
 
 void arch_crash_save_vmcoreinfo(void)
 {
-	VMCOREINFO_NUMBER(VA_BITS);
 	VMCOREINFO_NUMBER(phys_ram_base);
 
 	vmcoreinfo_append_str("NUMBER(PAGE_OFFSET)=0x%lx\n", PAGE_OFFSET);
 	vmcoreinfo_append_str("NUMBER(VMALLOC_START)=0x%lx\n", VMALLOC_START);
 	vmcoreinfo_append_str("NUMBER(VMALLOC_END)=0x%lx\n", VMALLOC_END);
+#ifdef CONFIG_MMU
+	VMCOREINFO_NUMBER(VA_BITS);
 	vmcoreinfo_append_str("NUMBER(VMEMMAP_START)=0x%lx\n", VMEMMAP_START);
 	vmcoreinfo_append_str("NUMBER(VMEMMAP_END)=0x%lx\n", VMEMMAP_END);
 #ifdef CONFIG_64BIT
 	vmcoreinfo_append_str("NUMBER(MODULES_VADDR)=0x%lx\n", MODULES_VADDR);
 	vmcoreinfo_append_str("NUMBER(MODULES_END)=0x%lx\n", MODULES_END);
+#endif
 #endif
 	vmcoreinfo_append_str("NUMBER(KERNEL_LINK_ADDR)=0x%lx\n", KERNEL_LINK_ADDR);
 	vmcoreinfo_append_str("NUMBER(va_kernel_pa_offset)=0x%lx\n",
-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
