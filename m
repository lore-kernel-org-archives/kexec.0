Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F43606A326
	for <kexec@archiver.kernel.org>; Thu, 29 Oct 2026 17:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=tpnEF6k0;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=LMMfsIV7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=62v7psIL8EAQ47S6rRTJha+UTtgm3E7BPb1/D07Yo+E=; b=tpnEF6k0aboN+e
	Kj4bDlJLwR0tGPNBie1u9vKk/dWfsxyfNU/kRPK8sNrfFrf2b58fcoXiRaotpM4+0Q9OJV1LZ4P2R
	xckBzjIqJIJCK7G8dGm9KSxLdf3prYLYYUZxQQBz/8XSPgd+t0zIGuFehat+iT4uaR6MEfSshkmmd
	BxmlFZQHTd6FLM1vLCJQKoas6OzXUAR81py4xcIvBD+mo1dp4xy3+cqDKVaqZ1X224PHLi1HYLJvA
	2IBCXj7U1NUYB3fIYvt0VkTM/Foo8ailUgf4k77394LZqXkK94AqS4QWvoF9l150dTP0MzUv/H9uO
	ng7Xt3GFpj1xF1oUSzug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMTxu-00000009ygv-1pmc;
	Thu, 29 Oct 2026 17:31:02 +0000
Received: from out-249.mta1.migadu.com ([95.215.58.249] helo=mta1.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMTxq-00000009ydY-2Y9a
	for kexec@lists.infradead.org;
	Thu, 29 Oct 2026 17:31:01 +0000
X-Envelope-To: kexec@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=PxCNVTb6jX0UZU4kP0/sdxuyaH5XxnIihD4Mw61jNnk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793295056; v=1; x=1793899856;
 b=LMMfsIV7/WEuySCEeQ2ahXjZrszY+S3tecdRjOn+1M62yCAFfHGHSIAKS1DEwfQK1o7OKVxb
 bz2XZ5ru3RXLaPasMWrVcUPjFWcjPvXGUeJ9AOs+lztf4LL72U/mAHJpNKfXXPY1B30JgfpTTSS
 7QgfD0efB+yaycgxYhXyGieE=
X-Envelope-To: kexec@lists.infradead.org
Received: by smtp.migadu.com with ESMTPS id cdb39e29496ef9b2;
	Thu, 29 Oct 2026 17:30:56 +0000
X-Mizu-Trace-ID: cdb39e29496ef9b2
X-Migadu-Flow: FLOW_OUT
From: George Guo <dongtai.guo@linux.dev>
To: rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	chenhuacai@kernel.org,
	ardb@kernel.org,
	shuah@kernel.org
Cc: ilias.apalodimas@linaro.org,
	akpm@linux-foundation.org,
	baoquan.he@linux.dev,
	ruirui.yang@linux.dev,
	guodongtai@kylinos.cn,
	kernel@xen0n.name,
	graf@amazon.com,
	liukexin@kylinos.cn,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-efi@vger.kernel.org
Subject: [PATCH v6 6/8] LoongArch: Enable kexec handover (KHO)
Date: Fri, 30 Oct 2026 02:29:53 +0900
Message-ID: <20261029172956.20791-7-dongtai.guo@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261029172956.20791-1-dongtai.guo@linux.dev>
References: <20261029172956.20791-1-dongtai.guo@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261029_103058_797622_8DC14915 
X-CRM114-Status: GOOD (  13.44  )
X-Spam-Score: -2.8 (--)
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: George Guo <guodongtai@kylinos.cn>

Enable ARCH_SUPPORTS_KEXEC_HANDOVER on 64-bit LoongArch with EFI_STUB.
KHO state is passed through an EFI configuration table installed by
the stub.

Disable KHO at boot if the table is missing, since the kernel cannot
pass KHO state to the next kernel without it.

Co-developed-by: Kexin Liu <liukexin@kylinos.cn>
Signed-off-by: Kexin Liu <liukexin@kylinos.cn>
Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 arch/loongarch/Kconfig        |  3 +++
 arch/loongarch/kernel/setup.c | 16 ++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index a21f51e5815e..d35ddd6ec540 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -685,6 +685,9 @@ config ARCH_SUPPORTS_KEXEC
 config ARCH_SUPPORTS_KEXEC_FILE
 	def_bool 64BIT
 
+config ARCH_SUPPORTS_KEXEC_HANDOVER
+	def_bool 64BIT && EFI_STUB
+
 config ARCH_SELECTS_KEXEC_FILE
 	def_bool 64BIT
 	depends on KEXEC_FILE
diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
index dff2e0c67ea0..e1023f93460c 100644
--- a/arch/loongarch/kernel/setup.c
+++ b/arch/loongarch/kernel/setup.c
@@ -20,6 +20,7 @@
 #include <linux/initrd.h>
 #include <linux/ioport.h>
 #include <linux/kexec.h>
+#include <linux/kexec_handover.h>
 #include <linux/crash_dump.h>
 #include <linux/root_dev.h>
 #include <linux/console.h>
@@ -594,6 +595,20 @@ static void __init prefill_possible_map(void)
 }
 #endif
 
+/*
+ * Only the EFI stub installs the KHO table, on a cold boot. A kernel
+ * started by kexec from a kernel that did not install it has no table,
+ * and the next kernel would not find what this kernel preserves, so
+ * turn KHO off.
+ */
+static void __init kho_check_efi_table(void)
+{
+	if (kho_is_enabled() && !efi_kho_table_found()) {
+		pr_warn("No EFI KHO table, disabling kexec handover\n");
+		kho_disable();
+	}
+}
+
 void __init setup_arch(char **cmdline_p)
 {
 	cpu_probe();
@@ -608,6 +623,7 @@ void __init setup_arch(char **cmdline_p)
 	bootcmdline_init(cmdline_p);
 	jump_label_init(); /* Initialise the static keys for early params */
 	parse_early_param();
+	kho_check_efi_table();
 	reserve_initrd_mem();
 
 	platform_init();
-- 
2.53.0


