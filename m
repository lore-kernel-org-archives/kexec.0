Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC953C3600B
	for <kexec@archiver.kernel.org>; Wed, 26 Mar 2025 14:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jMnqwnKFeunkNFt2xA902escEge7LjBq+yD8v//V6S4=; b=tw0NWbYVRgNcSHhS0JUsP8I3/H
	gOV9ktRwSqCFLPMpuXbLiJ3zgLN40x54xbcv9e9sQu713kSYoGbtJwFHDuuSCo6ccSrqeSDxdksSI
	Z6uvPbWqNG4SbozkLvygvSwyTC4WtTM+wAIjd51lLaRWBCIWeS+iLoS1u/3/DwZNSpDYfZjHsPekN
	HobN3LthuzPulqiDd63isT7ZLvy7j6P2+KFSZDPo5tbuQDZ2EKG5qQ/5OWtRfr3VZPRB/URdA9pdo
	rbBgirWqEsiLMa2B5KotKKR4oxkkNHLIDLzYwomKb9b/PaVMhwEs2aorvOPoUEM+66//feAeAfMB5
	vMTJ9uBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txRhJ-00000008gNf-265p;
	Wed, 26 Mar 2025 14:25:37 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txRfu-00000008gAr-35jm
	for kexec@bombadil.infradead.org;
	Wed, 26 Mar 2025 14:24:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=jMnqwnKFeunkNFt2xA902escEge7LjBq+yD8v//V6S4=; b=QK3NxM+L8hY5loEuRFMnINQ7nQ
	pSdpzFlRSRA1/KhyK290WhDGv4aJnouPOFloJrej2srPkW7zXnET1KWmYLbUF3602qS5E17+VmF+B
	3rxUugDIBIsAKzwPOgeKUyrM5jggzWIL7nHolh4+7MS+HQ824L7UavTw1QbF56NxOa5Eq7LNmQre8
	GlDsRRFLSJcg8/3eoaJ8Ion7H15fGhSVG9y+39OQ0SlcfBF0miY/jVIuCL4yhhEy6b/NPq+mqpies
	W4JUMBPHLBDu9MKFFzbTCwnvg0IXiDChIdpv4ScsexT07PEYhcLZXs8ocjmaXar1e3/vjgnFsvga2
	FaFwGtog==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txRfq-000000005rh-3ZZ7;
	Wed, 26 Mar 2025 14:24:07 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1txRfq-00000001A9U-2chY;
	Wed, 26 Mar 2025 14:24:06 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: kexec@lists.infradead.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Dave Young <dyoung@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	jpoimboe@kernel.org,
	bsz@amazon.de
Subject: [PATCH v9 4/4] selftests/kexec: Add x86_64 selftest for kexec-jump and exception handling
Date: Wed, 26 Mar 2025 14:16:04 +0000
Message-ID: <20250326142404.256980-5-dwmw2@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250326142404.256980-1-dwmw2@infradead.org>
References: <20250326142404.256980-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
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

From: David Woodhouse <dwmw@amazon.co.uk>

Add a self test which exercises both the kexec-jump facility, and the
kexec exception handling.

Invoke a trivial payload which just does an int3 and returns,
flip-flopping its entry point for the next invocation between two
implementations of the same thing.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 tools/testing/selftests/kexec/Makefile        |  7 ++
 .../testing/selftests/kexec/test_kexec_jump.c | 72 +++++++++++++++++++
 .../selftests/kexec/test_kexec_jump.sh        | 42 +++++++++++
 3 files changed, 121 insertions(+)
 create mode 100644 tools/testing/selftests/kexec/test_kexec_jump.c
 create mode 100755 tools/testing/selftests/kexec/test_kexec_jump.sh

diff --git a/tools/testing/selftests/kexec/Makefile b/tools/testing/selftests/kexec/Makefile
index 67fe7a46cb62..e3000ccb9a5d 100644
--- a/tools/testing/selftests/kexec/Makefile
+++ b/tools/testing/selftests/kexec/Makefile
@@ -8,6 +8,13 @@ ifeq ($(ARCH_PROCESSED),$(filter $(ARCH_PROCESSED),x86 ppc64le))
 TEST_PROGS := test_kexec_load.sh test_kexec_file_load.sh
 TEST_FILES := kexec_common_lib.sh
 
+include ../../../scripts/Makefile.arch
+
+ifeq ($(IS_64_BIT)$(ARCH_PROCESSED),1x86)
+TEST_PROGS += test_kexec_jump.sh
+test_kexec_jump.sh: $(OUTPUT)/test_kexec_jump
+endif
+
 include ../lib.mk
 
 endif
diff --git a/tools/testing/selftests/kexec/test_kexec_jump.c b/tools/testing/selftests/kexec/test_kexec_jump.c
new file mode 100644
index 000000000000..fbce287866f5
--- /dev/null
+++ b/tools/testing/selftests/kexec/test_kexec_jump.c
@@ -0,0 +1,72 @@
+#include <unistd.h>
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <linux/kexec.h>
+#include <linux/reboot.h>
+#include <sys/reboot.h>
+#include <sys/syscall.h>
+
+asm(
+    "  .code64\n"
+    "  .data\n"
+    "purgatory_start:\n"
+
+    // Trigger kexec debug exception handling
+    "  int3\n"
+
+    // Set load address for next time
+    "  leaq purgatory_start_b(%rip), %r11\n"
+    "  movq %r11, 8(%rsp)\n"
+
+    // Back to Linux
+    "  ret\n"
+
+    // Same again
+    "purgatory_start_b:\n"
+
+    // Trigger kexec debug exception handling
+    "  int3\n"
+
+    // Set load address for next time
+    "  leaq purgatory_start(%rip), %r11\n"
+    "  movq %r11, 8(%rsp)\n"
+
+    // Back to Linux
+    "  ret\n"
+
+    "purgatory_end:\n"
+    ".previous"
+);
+extern char purgatory_start[], purgatory_end[];
+
+int main (void)
+{
+        struct kexec_segment segment = {};
+	int ret;
+
+	segment.buf = purgatory_start;
+	segment.bufsz = purgatory_end - purgatory_start;
+	segment.mem = (void *)0x400000;
+	segment.memsz = 0x1000;
+	ret = syscall(__NR_kexec_load, 0x400000, 1, &segment, KEXEC_PRESERVE_CONTEXT);
+	if (ret) {
+		perror("kexec_load");
+		exit(1);
+	}
+
+	ret = syscall(__NR_reboot, LINUX_REBOOT_MAGIC1, LINUX_REBOOT_MAGIC2, LINUX_REBOOT_CMD_KEXEC);
+	if (ret) {
+		perror("kexec reboot");
+		exit(1);
+	}
+
+	ret = syscall(__NR_reboot, LINUX_REBOOT_MAGIC1, LINUX_REBOOT_MAGIC2, LINUX_REBOOT_CMD_KEXEC);
+	if (ret) {
+		perror("kexec reboot");
+		exit(1);
+	}
+	printf("Success\n");
+	return 0;
+}
+
diff --git a/tools/testing/selftests/kexec/test_kexec_jump.sh b/tools/testing/selftests/kexec/test_kexec_jump.sh
new file mode 100755
index 000000000000..6ae977054ba2
--- /dev/null
+++ b/tools/testing/selftests/kexec/test_kexec_jump.sh
@@ -0,0 +1,42 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+#
+# Prevent loading a kernel image via the kexec_load syscall when
+# signatures are required.  (Dependent on CONFIG_IMA_ARCH_POLICY.)
+
+TEST="$0"
+. ./kexec_common_lib.sh
+
+# kexec requires root privileges
+require_root_privileges
+
+# get the kernel config
+get_kconfig
+
+kconfig_enabled "CONFIG_KEXEC_JUMP=y" "kexec_jump is enabled"
+if [ $? -eq 0 ]; then
+	log_skip "kexec_jump is not enabled"
+fi
+
+kconfig_enabled "CONFIG_IMA_APPRAISE=y" "IMA enabled"
+ima_appraise=$?
+
+kconfig_enabled "CONFIG_IMA_ARCH_POLICY=y" \
+	"IMA architecture specific policy enabled"
+arch_policy=$?
+
+get_secureboot_mode
+secureboot=$?
+
+if [ $secureboot -eq 1 ] && [ $arch_policy -eq 1 ]; then
+    log_skip "Secure boot and CONFIG_IMA_ARCH_POLICY are enabled"
+fi
+
+./test_kexec_jump
+if [ $? -eq 0 ]; then
+    log_pass "kexec_jump succeeded"
+else
+    # The more likely failure mode if anything went wrong is that the
+    # kernel just crashes. But if we get back here, sure, whine anyway.
+    log_fail "kexec_jump failed"
+fi
-- 
2.48.1


