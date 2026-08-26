Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31B02C61DC7
	for <kexec@archiver.kernel.org>; Wed, 26 Aug 2026 09:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AjFAkRrhVUTBFTsQMyUNsvLp/GHcd37S7PEMXZOcAZ4=; b=uVhOgCrzBPoAxTxSNEqUtx/0fD
	vlxdrc73GG9+FnmybqT5tgQ7LAu0tSUM6Gitrqiyor0Lv2gN4OuSbX5yF3fPrggou1dGW1Sptrs4X
	uSYVMgIBpoV2O2OzN3ttWwn1WVeHNxEAmvxQ24bpJvem40HTcfU6jAzFh+tENG5RsAXJ2FRcyEjXY
	I1qf4CRHBZfWCHdA92/RFBvMLAqoSTqk0LCNDqoYJPTiF8rzNGq97M9Vnngb0HFXzgVEL248HJ9Jo
	TWBlX5y112jCN2oco/HDUP+1ZDDcFHxyBE6Ol3uIEiFfoEFDxr8oKHs96LKQyVaWVmhmQhl5TUyyF
	//zmqXNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wz9tb-00000002BRC-3Jfk;
	Wed, 26 Aug 2026 09:26:11 +0000
Received: from canpmsgout03.his.huawei.com ([113.46.200.218])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wz9t4-00000002B2w-3hMw;
	Wed, 26 Aug 2026 09:25:43 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=AjFAkRrhVUTBFTsQMyUNsvLp/GHcd37S7PEMXZOcAZ4=;
	b=GB6QEE65ILKvCbQpXecQEb/ua/x3iezR7nE2mn7WyYvYlY4SUXxQ83iR38qyJiKIbAgDODNlH
	MU8cWojiXPCrCQ5dhsBQrS1ENBNRxVIcl10fi/R92xWzffLm8zRiqYcpNm7ebeVpN3c6nk/FktV
	hqwqWG9q2cn4HV8W9tiTxUc=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4hVJr24p4czpTHV;
	Wed, 26 Aug 2026 17:14:26 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 0D1434056D;
	Wed, 26 Aug 2026 17:25:35 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 26 Aug
 2026 17:25:32 +0800
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
Subject: [PATCH v3 11/17] crash: Introduce crash_extra_elfcorehdr_size() helper
Date: Wed, 26 Aug 2026 17:25:35 +0800
Message-ID: <20260826092541.3905933-12-ruanjinjie@huawei.com>
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
X-CRM114-CacheID: sfid-20260826_022541_299417_93A1AF15 
X-CRM114-Status: GOOD (  14.06  )
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

Extract the elfcorehdr extra space calculation from powerpc into a
generic helper crash_extra_elfcorehdr_size() for use by other
architectures.

The helper includes compile-time and runtime checks, it also checks
whether the total number of program headers (including fixed headers for
kernel_map, VMCOREINFO, and CPU notes) exceeds PN_XNUM, and provides a
stub when crash/memory hotplug is disabled.

Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan He <baoquan.he@linux.dev>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>
Cc: Dave Young <ruirui.yang@linux.dev>
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/powerpc/kexec/file_load_64.c | 19 +------------------
 include/linux/crash_core.h        | 26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
index 6075b1c88511..2b0325e4a628 100644
--- a/arch/powerpc/kexec/file_load_64.c
+++ b/arch/powerpc/kexec/file_load_64.c
@@ -374,23 +374,6 @@ static int load_backup_segment(struct kimage *image, struct kexec_buf *kbuf)
 	return 0;
 }
 
-static unsigned int kdump_extra_elfcorehdr_size(struct crash_mem *cmem)
-{
-#if defined(CONFIG_CRASH_HOTPLUG) && defined(CONFIG_MEMORY_HOTPLUG)
-	unsigned int extra_sz = 0;
-
-	if (CONFIG_CRASH_MAX_MEMORY_RANGES > (unsigned int)PN_XNUM)
-		pr_warn("Number of Phdrs %u exceeds max\n", CONFIG_CRASH_MAX_MEMORY_RANGES);
-	else if (cmem->nr_ranges >= CONFIG_CRASH_MAX_MEMORY_RANGES)
-		pr_warn("Configured crash mem ranges may not be enough\n");
-	else
-		extra_sz = (CONFIG_CRASH_MAX_MEMORY_RANGES - cmem->nr_ranges) * sizeof(Elf64_Phdr);
-
-	return extra_sz;
-#endif
-	return 0;
-}
-
 /**
  * load_elfcorehdr_segment - Setup crash memory ranges and initialize elfcorehdr
  *                           segment needed to load kdump kernel.
@@ -428,7 +411,7 @@ static int load_elfcorehdr_segment(struct kimage *image, struct kexec_buf *kbuf)
 	 * Account for extra space required to accommodate additional memory
 	 * ranges in elfcorehdr due to memory hotplug events.
 	 */
-	kbuf->memsz = headers_sz + kdump_extra_elfcorehdr_size(cmem);
+	kbuf->memsz = headers_sz + crash_extra_elfcorehdr_size(cmem->nr_ranges);
 	kbuf->top_down = false;
 
 	ret = kexec_add_buffer(kbuf);
diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index 6789ff0af39e..d5981008a812 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -106,4 +106,30 @@ ssize_t dm_crypt_keys_read(char *buf, size_t count, u64 *ppos);
 static inline int crash_load_dm_crypt_keys(struct kimage *image) {return 0; }
 #endif
 
+#if defined(CONFIG_CRASH_HOTPLUG) && defined(CONFIG_MEMORY_HOTPLUG)
+static inline unsigned int crash_extra_elfcorehdr_size(unsigned int nr_mem_ranges)
+{
+	unsigned int total_phdrs = 2 + num_possible_cpus() + CONFIG_CRASH_MAX_MEMORY_RANGES;
+
+	BUILD_BUG_ON(CONFIG_CRASH_MAX_MEMORY_RANGES > (unsigned int)PN_XNUM);
+
+	if (nr_mem_ranges >= CONFIG_CRASH_MAX_MEMORY_RANGES) {
+		pr_warn_once("Configured crash mem ranges may not be enough\n");
+		return 0;
+	}
+
+	if (total_phdrs >= (unsigned int)PN_XNUM) {
+		pr_warn_once("number of Phdrs %u exceeds max\n", total_phdrs);
+		return 0;
+	}
+
+	return (CONFIG_CRASH_MAX_MEMORY_RANGES - nr_mem_ranges) * sizeof(Elf64_Phdr);
+}
+#else
+static inline unsigned int crash_extra_elfcorehdr_size(unsigned int nr_mem_ranges)
+{
+	return 0;
+}
+#endif
+
 #endif /* LINUX_CRASH_CORE_H */
-- 
2.34.1


