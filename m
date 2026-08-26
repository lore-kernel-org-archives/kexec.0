Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AA0DC61DC7
	for <kexec@archiver.kernel.org>; Wed, 26 Aug 2026 09:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3yLl9In8Wv4o0ZdsQbHCo1Df/gDSHHkfLMajcmTmIOU=; b=0Mfr8dyIB2sgomXObBA9xmmIDq
	1wK9Mw6gmTZOoFVIZaLQeLfOVYH03J+48L/rqTq3FDKFDzlXmr8V4DiVC5AwP6sxZih+PQ3EYmaFZ
	Q9rGZ5PU5WUz3k+9dZAaszULWTzLu9gztPFWBNfZ7BqQXd34W+hGOxmd9CPuhRUWhlUMwfONyZlEg
	tPKDnDSsqA4JZs28GPlE8e/Q14j4qfjh5R8L9+WJOjDFMVAMxmce5H00F+6Vv4EKcoOPwCHJS80yx
	JI1tuCWSqUcBTI+Uh7I/ndrg46Cd+DyWoH/iVL5+oQEAgwW0QQ5HlQrMAezDLAzrZ6LEOLQnWGTFa
	+a1zORmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wz9th-00000002BZ6-2n4g;
	Wed, 26 Aug 2026 09:26:17 +0000
Received: from canpmsgout07.his.huawei.com ([113.46.200.222])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wz9tC-00000002B8H-3VNn;
	Wed, 26 Aug 2026 09:25:52 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=3yLl9In8Wv4o0ZdsQbHCo1Df/gDSHHkfLMajcmTmIOU=;
	b=sd/H+UNCaNAatBnZBdwzX8iqrWgk9CvZKeHro8YXwCBizriBg8j/ic2nCnNuWmYjOd30NiN+s
	o0gHA+GVWfBZxWfQc5kddUQtVkrxsFSTSz7Qz2UeV8XoAt1UtBiJcSp4/Oy1mZg78qh4xUuqL3O
	bguC9nDFMKh9jB1NsetGV8w=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4hVJrf3mV2zLlXB;
	Wed, 26 Aug 2026 17:14:58 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 298AF4057C;
	Wed, 26 Aug 2026 17:25:44 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 26 Aug
 2026 17:25:41 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <mark.rutland@arm.com>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <maddy@linux.ibm.com>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <chleroy@kernel.org>,
	<tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <akpm@linux-foundation.org>,
	<baoquan.he@linux.dev>, <rppt@kernel.org>, <pasha.tatashin@soleen.com>,
	<pratyush@kernel.org>, <ruirui.yang@linux.dev>, <kees@kernel.org>,
	<thuth@redhat.com>, <gshan@redhat.com>, <jic23@kernel.org>,
	<james.morse@arm.com>, <ardb@kernel.org>, <leitao@debian.org>,
	<yeoreum.yun@arm.com>, <sourabhjain@linux.ibm.com>, <coxu@redhat.com>,
	<tangyouling@kylinos.cn>, <hbathini@linux.ibm.com>, <adityag@linux.ibm.com>,
	<ionut.nechita@windriver.com>, <liaoyuanhong@vivo.com>, <seanjc@google.com>,
	<fuqiang.wang@easystack.cn>, <makb@juniper.net>, <piliu@redhat.com>,
	<ebiggers@kernel.org>, <jbouron@amazon.com>, <mclapinski@google.com>,
	<me@linux.beauty>, <graf@amazon.com>, <bgwin@google.com>, <robh@kernel.org>,
	<takahiro.akashi@linaro.org>, <palmer@rivosinc.com>, <x86@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<loongarch@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
	<kexec@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-mm@kvack.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v3 15/17] crash: Simplify CRASH_MAX_MEMORY_RANGES handling
Date: Wed, 26 Aug 2026 17:25:39 +0800
Message-ID: <20260826092541.3905933-16-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260826092541.3905933-1-ruanjinjie@huawei.com>
References: <20260826092541.3905933-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf500011.china.huawei.com (7.185.36.131)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260826_022547_518026_291FCDE2 
X-CRM114-Status: UNSURE (   9.92  )
X-CRM114-Notice: Please train this message.
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

Set CRASH_MAX_MEMORY_RANGES to 0 when MEMORY_HOTPLUG is disabled, then
remove the now unnecessary IS_ENABLED(CONFIG_MEMORY_HOTPLUG) checks in
powerpc and x86 arch_crash_get_elfcorehdr_size().

No functional change intended.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/powerpc/kexec/crash.c | 4 +---
 arch/x86/kernel/crash.c    | 4 +---
 kernel/Kconfig.kexec       | 3 ++-
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kexec/crash.c b/arch/powerpc/kexec/crash.c
index fc0105c7af4c..c47e3f867ea1 100644
--- a/arch/powerpc/kexec/crash.c
+++ b/arch/powerpc/kexec/crash.c
@@ -474,9 +474,7 @@ unsigned int arch_crash_get_elfcorehdr_size(void)
 	unsigned long phdr_cnt;
 
 	/* A program header for possible CPUs + vmcoreinfo */
-	phdr_cnt = num_possible_cpus() + 1;
-	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
-		phdr_cnt += CONFIG_CRASH_MAX_MEMORY_RANGES;
+	phdr_cnt = num_possible_cpus() + 1 + CONFIG_CRASH_MAX_MEMORY_RANGES;
 
 	return elf64_phdr_size(phdr_cnt);
 }
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 99eb8583d932..116410ac90fb 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -407,9 +407,7 @@ unsigned int arch_crash_get_elfcorehdr_size(void)
 	unsigned int sz;
 
 	/* kernel_map, VMCOREINFO and maximum CPUs */
-	sz = 2 + num_possible_cpus();
-	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
-		sz += CONFIG_CRASH_MAX_MEMORY_RANGES;
+	sz = 2 + num_possible_cpus() + CONFIG_CRASH_MAX_MEMORY_RANGES;
 	sz *= sizeof(Elf64_Phdr);
 	return sz;
 }
diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
index a97ed9605602..e6251dfe451a 100644
--- a/kernel/Kconfig.kexec
+++ b/kernel/Kconfig.kexec
@@ -160,7 +160,8 @@ config CRASH_HOTPLUG
 
 config CRASH_MAX_MEMORY_RANGES
 	int "Specify the maximum number of memory regions for the elfcorehdr"
-	default 8192
+	default 8192 if MEMORY_HOTPLUG
+	default 0 if !MEMORY_HOTPLUG
 	depends on CRASH_HOTPLUG
 	help
 	  For the kexec_file_load() syscall path, specify the maximum number of
-- 
2.34.1


