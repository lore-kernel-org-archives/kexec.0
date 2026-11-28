Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC475606A31C
	for <kexec@archiver.kernel.org>; Sat, 28 Nov 2026 07:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=zNpA/Mbb;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=ZT8lgopD
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=iKGjH6wS2a4sHmXZLlgO25XKxI/4g/tKHlpp0EC0Hlg=; b=zNpA/MbbxrQh2qaijf8JFieV1T
	WzjNkCAm5mlQGWM6S4riZfMw2PR6A3Jowe423CRLUjE5xmiQX0860im8KHR4J1NDqhIPwKeI4ip7E
	y1vHW9F1OP/Dw6ddZcM7QeicL2SwVvV4u2QMZJy1+mfaUxvcXVKmCLTH1Lwh5lzBz7aZo/ErtbLpD
	4avBqeoSfB8QvOiyEmaI8788cC1mo8GFMY308vDFg9C3KzMeYJw66HxZuWhSBJJ/tkY5StvHItYzd
	fmrz68ydoxGWCl/qE8w0Rxn690L4ReIBlanwx6FgFH4l9RZ/G85+WENeSyrBQ7m3x8QLL2Ko6wJ0A
	UQKsng+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xXCqR-00000000TAR-1PIp;
	Sat, 28 Nov 2026 07:27:39 +0000
Received: from canpmsgout01.his.huawei.com ([113.46.200.216])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xXCqK-00000000T7d-3ZE6
	for kexec@lists.infradead.org;
	Sat, 28 Nov 2026 07:27:37 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=iKGjH6wS2a4sHmXZLlgO25XKxI/4g/tKHlpp0EC0Hlg=;
	b=ZT8lgopD9VuauBsAONcI6THMkpuSRbLWx/lHGseaVInjt0vU+TYa9M67rPEzfr2AHVy02PU71
	WIqUznSiO4MdmCDXN87x/RXDnIML/yddpzAI65Y1u4k+J7xA62G699h8p4xSbTZ4XiW6VxHiZyE
	8+X57tS/edSZrkQV77DHGuI=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4jc2056Mdsz1T4Fx;
	Sat, 28 Nov 2026 15:26:29 +0800 (CST)
Received: from kwepemo200009.china.huawei.com (unknown [7.202.195.26])
	by mail.maildlp.com (Postfix) with ESMTPS id B6DC040561;
	Sat, 28 Nov 2026 15:27:23 +0800 (CST)
Received: from localhost.localdomain (10.50.159.234) by
 kwepemo200009.china.huawei.com (7.202.195.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Sat, 28 Nov 2026 15:27:22 +0800
From: Long Wei <longwei27@huawei.com>
To: <rppt@kernel.org>, <pasha.tatashin@soleen.com>, <pratyush@kernel.org>
CC: <shuah@kernel.org>, <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<kexec@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <hewenliang4@huawei.com>, Long Wei
	<longwei27@huawei.com>
Subject: [PATCH 2/2] selftests/liveupdate: add seal-after-preserve kexec test
Date: Sat, 28 Nov 2026 15:24:44 +0800
Message-ID: <20261128072444.1114964-3-longwei27@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261128072444.1114964-1-longwei27@huawei.com>
References: <20261128072444.1114964-1-longwei27@huawei.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemo200009.china.huawei.com (7.202.195.26)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261127_232734_572552_F99774BD 
X-CRM114-Status: GOOD (  18.03  )
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

Add luo_seal_after_preserve, a kexec test that preserves an unsealed
memfd, adds F_SEAL_GROW *after* the preserve (which used to be silently
lost across the handover), and verifies after the kexec reboot that
both the data and the seal survived.

The test creates its own memfd instead of using the
create_and_preserve_memfd() helper because the helper creates the memfd
without MFD_ALLOW_SEALING, which makes it unsealable forever.  It is
registered in TEST_GEN_PROGS_EXTENDED and TEST_NAMES so it runs in the
vmtest CI.

Signed-off-by: Long Wei <longwei27@huawei.com>
---
 tools/testing/selftests/liveupdate/Makefile   |   1 +
 .../liveupdate/luo_seal_after_preserve.c      | 170 ++++++++++++++++++
 .../selftests/liveupdate/run-vmtests.sh       |   1 +
 3 files changed, 172 insertions(+)
 create mode 100644 tools/testing/selftests/liveupdate/luo_seal_after_preserve.c

diff --git a/tools/testing/selftests/liveupdate/Makefile b/tools/testing/selftests/liveupdate/Makefile
index 634211c66652..03bb09bb9867 100644
--- a/tools/testing/selftests/liveupdate/Makefile
+++ b/tools/testing/selftests/liveupdate/Makefile
@@ -6,6 +6,7 @@ TEST_GEN_PROGS_EXTENDED += luo_kexec_simple
 TEST_GEN_PROGS_EXTENDED += luo_multi_session
 TEST_GEN_PROGS_EXTENDED += luo_stress_sessions
 TEST_GEN_PROGS_EXTENDED += luo_stress_files
+TEST_GEN_PROGS_EXTENDED += luo_seal_after_preserve
 
 TEST_FILES += do_kexec.sh
 
diff --git a/tools/testing/selftests/liveupdate/luo_seal_after_preserve.c b/tools/testing/selftests/liveupdate/luo_seal_after_preserve.c
new file mode 100644
index 000000000000..12e6731c9235
--- /dev/null
+++ b/tools/testing/selftests/liveupdate/luo_seal_after_preserve.c
@@ -0,0 +1,170 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * Copyright (c) 2026, Huawei.
+ * Long Wei <longwei27@huawei.com>
+ *
+ * A selftest to validate that a seal added to a memfd with F_ADD_SEALS
+ * after the memfd is preserved is transferred across a kexec reboot.
+ *
+ * Note: the create_and_preserve_memfd() helper cannot be used here because
+ * it creates the memfd without MFD_ALLOW_SEALING, which makes the memfd
+ * unsealable forever.
+ */
+
+#include <errno.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <string.h>
+#include <sys/mman.h>
+#include <sys/syscall.h>
+#include <unistd.h>
+
+#include <libliveupdate.h>
+
+#ifndef F_ADD_SEALS
+#define F_ADD_SEALS 1033
+#endif
+#ifndef F_GET_SEALS
+#define F_GET_SEALS 1034
+#endif
+#ifndef F_SEAL_GROW
+#define F_SEAL_GROW 0x0004
+#endif
+#ifndef MFD_ALLOW_SEALING
+#define MFD_ALLOW_SEALING 0x0002U
+#endif
+
+/*
+ * Prefer SYS_fcntl when the libc defines it (glibc, musl); fall back to
+ * __NR_fcntl which is the only name nolibc provides.
+ */
+#ifdef SYS_fcntl
+#define LUO_FCNTL_NR SYS_fcntl
+#else
+#define LUO_FCNTL_NR __NR_fcntl
+#endif
+
+#define STATE_SESSION_NAME "seal_after_preserve_state"
+#define STATE_MEMFD_TOKEN  0x1000
+
+#define TEST_SESSION_NAME  "seal_after_preserve_session"
+#define TEST_MEMFD_DATA    "seal-after-preserve"
+#define TEST_MEMFD_TOKEN   0x1001
+
+/* Unsealed, non-empty memfd open for sealing. */
+static int create_sealable_memfd(void)
+{
+	long page_size = getpagesize();
+	void *map = MAP_FAILED;
+	int mfd = -1, ret = -1;
+
+	mfd = memfd_create("seal_test", MFD_ALLOW_SEALING);
+	if (mfd < 0)
+		return -errno;
+
+	if (ftruncate(mfd, page_size)) {
+		ret = -errno;
+		close(mfd);
+		return ret;
+	}
+
+	map = mmap(NULL, page_size, PROT_WRITE, MAP_SHARED, mfd, 0);
+	if (map == MAP_FAILED) {
+		ret = -errno;
+		close(mfd);
+		return ret;
+	}
+	snprintf(map, page_size, "%s", TEST_MEMFD_DATA);
+	munmap(map, page_size);
+
+	return mfd;
+}
+
+/* Stage 1: Executed before the kexec reboot. */
+static void run_stage_1(int luo_fd)
+{
+	int session_fd, mfd, seals;
+
+	ksft_print_msg("[STAGE 1] Creating state file for next stage (2)...\n");
+	create_state_file(luo_fd, STATE_SESSION_NAME, STATE_MEMFD_TOKEN, 2);
+
+	ksft_print_msg("[STAGE 1] Creating test session '%s'...\n",
+		       TEST_SESSION_NAME);
+	session_fd = luo_create_session(luo_fd, TEST_SESSION_NAME);
+	if (session_fd < 0)
+		fail_exit("luo_create_session");
+
+	ksft_print_msg("[STAGE 1] Preserving unsealed test memfd...\n");
+	mfd = create_sealable_memfd();
+	if (mfd < 0)
+		fail_exit("create unsealed sealable memfd");
+
+	if (luo_session_preserve_fd(session_fd, mfd, TEST_MEMFD_TOKEN))
+		fail_exit("preserve unsealed memfd");
+
+	if (syscall(LUO_FCNTL_NR, mfd, F_ADD_SEALS, F_SEAL_GROW) < 0)
+		fail_exit("F_ADD_SEALS(F_SEAL_GROW) after preserve");
+
+	seals = syscall(LUO_FCNTL_NR, mfd, F_GET_SEALS, 0);
+	if (seals < 0)
+		fail_exit("F_GET_SEALS");
+	if (!(seals & F_SEAL_GROW))
+		fail_exit("F_SEAL_GROW missing (F_GET_SEALS=0x%x)", seals);
+
+	ksft_print_msg("[STAGE 1] F_SEAL_GROW added after preserve (seals=0x%x).\n", seals);
+
+	close(luo_fd);
+	daemonize_and_wait();
+}
+
+/* Stage 2: Executed after the kexec reboot. */
+static void run_stage_2(int luo_fd, int state_session_fd)
+{
+	int session_fd, mfd, seals, stage;
+
+	ksft_print_msg("[STAGE 2] Starting post-kexec verification...\n");
+
+	restore_and_read_stage(state_session_fd, STATE_MEMFD_TOKEN, &stage);
+	if (stage != 2)
+		fail_exit("Expected stage 2, but state file contains %d", stage);
+
+	session_fd = luo_retrieve_session(luo_fd, TEST_SESSION_NAME);
+	if (session_fd < 0)
+		fail_exit("luo_retrieve_session");
+
+	ksft_print_msg("[STAGE 2] Restoring and verifying test memfd (token=%d)...\n",
+		       TEST_MEMFD_TOKEN);
+	mfd = restore_and_verify_memfd(session_fd, TEST_MEMFD_TOKEN,
+				       TEST_MEMFD_DATA);
+	if (mfd < 0)
+		fail_exit("restore_and_verify_memfd for test memfd");
+
+	seals = syscall(LUO_FCNTL_NR, mfd, F_GET_SEALS, 0);
+	if (seals < 0)
+		fail_exit("F_GET_SEALS");
+	if (!(seals & F_SEAL_GROW))
+		fail_exit("F_SEAL_GROW silently lost across kexec (seals=0x%x, expected 0x%x)",
+			  seals, F_SEAL_GROW);
+
+	ksft_print_msg("[STAGE 2] F_SEAL_GROW survived the kexec (seals=0x%x).\n", seals);
+
+	close(mfd);
+
+	if (luo_session_finish(session_fd) < 0)
+		fail_exit("luo_session_finish for test session");
+	close(session_fd);
+
+	ksft_print_msg("[STAGE 2] Finalizing state session...\n");
+	if (luo_session_finish(state_session_fd) < 0)
+		fail_exit("luo_session_finish for state session");
+	close(state_session_fd);
+
+	ksft_print_msg("\n--- SEAL-AFTER-PRESERVE KEXEC TEST PASSED ---\n");
+}
+
+int main(int argc, char *argv[])
+{
+	return luo_test(argc, argv, STATE_SESSION_NAME,
+			run_stage_1, run_stage_2);
+}
diff --git a/tools/testing/selftests/liveupdate/run-vmtests.sh b/tools/testing/selftests/liveupdate/run-vmtests.sh
index c3d828cfd63b..fbc853d981db 100755
--- a/tools/testing/selftests/liveupdate/run-vmtests.sh
+++ b/tools/testing/selftests/liveupdate/run-vmtests.sh
@@ -20,6 +20,7 @@ TEST_NAMES=(
 	"luo_multi_session"
 	"luo_stress_files"
 	"luo_stress_sessions"
+	"luo_seal_after_preserve"
 )
 
 function usage() {
-- 
2.43.0


