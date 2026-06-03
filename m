Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67C70CD6E57
	for <kexec@archiver.kernel.org>; Wed,  3 Jun 2026 15:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LZ44uuKaEudMkx03Nujcoh6Uuv+6Qpcd4aVYSw8wkq4=; b=vL6u4uoSK6Xd401RLNrGd/piFZ
	kExc8kqYh4bMK9ptzGckkWrf7G9qg4YyVGffsY7MXpo5LvnQCjuE2Us71eCkAud/5KYt1Jc/g1Q9M
	JdmheVOHAgbUpzUTNmPBnl2mlaX8PHpqQKATwfq1B/u513FTnGlg4mBNZD8LMTrnzkIJxSXK/m1Ji
	f1y+jRmLTMXv7z0fo0ZTYb0538fCBod1wstGz3n9fPGZP5CRMrfjJtVKcWmn/IHE5HUIrXa9vCAo/
	xsZNfjgkLd+dLCzhVKgy+jL8akPRWOXEnCNFYQoSwpzy/F0NbsDEb50bErZIh5oGr6a0Eosg+ynBS
	DXToWjJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUnnl-0000000FSN7-34lU;
	Wed, 03 Jun 2026 15:46:41 +0000
Received: from mail-qv1-xf29.google.com ([2607:f8b0:4864:20::f29])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUnnj-0000000FSMY-1p2G
	for kexec@lists.infradead.org;
	Wed, 03 Jun 2026 15:46:40 +0000
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-8ccf887de87so51737656d6.0
        for <kexec@lists.infradead.org>; Wed, 03 Jun 2026 08:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1780501598; x=1781106398; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LZ44uuKaEudMkx03Nujcoh6Uuv+6Qpcd4aVYSw8wkq4=;
        b=SYnctjGgrnb6aIE+7T52BTKRxiqXhE+bT2pPfDYvokjDmV1u4vIWQDceocwCN2WasM
         cUN7pxcUSTJ+X5PCBPuiIY7Y3GOrUSv9OSVSj41q64p79cV4nug7qkSJ33Y378MXNz6K
         aLVcnQtyDL+F5BpmKrVh6R8VnCrPctOj3RyOigGvhcUltWmSyYNK+adZYFzEsx17RPi+
         EIp8IufFKnsXuq0HcM9lSoPgZuL3XzkEBpW901sea3cHcOkC0i2iBwh856Cac5HFglxm
         dh9vlX0ZBtLcFOCzYB9FjV1W+nS09h0W6cubi5OLm0QS42jwusqMuGPJ/pWNGXi8gduP
         CROw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780501598; x=1781106398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LZ44uuKaEudMkx03Nujcoh6Uuv+6Qpcd4aVYSw8wkq4=;
        b=ibXfkhQmBfuVqViAkUItWDFG/ko6DLc2CSe5XITlvTPEA8VuABpD4ltAdI7uf/TgSO
         WPAyQEQW9iE6cLzzouChO6L7tLMZz+ON4PF/Svhl+mZBLehFe089CeI00q5iP/2kNEJr
         eCkahKpkXnEnqmQ+mXXq81xruF/zBzjZZPIkSJXLGq1RvPEtvM6Fab06J8ExkHy2R3+x
         +1P1K7KhRz20Fhspwze+Bv9KnVLMBJ8959u5VGp2uiRfNUWdkl4on+ACle6ivvam2xjA
         diSCpDhEnlSC8RzEnp2++ZGQ4Cu89ZjWuB6RbWC4ISEUtZWL3KGYW9pA7EyqxaAO0f6K
         yocA==
X-Forwarded-Encrypted: i=1; AFNElJ/jx7GujLpnb31pvOZdg5qtIfNRI9GRtr/Y9VHO2VUyLIq1xDYXZB97wfywuL8trpOXXPfgzA==@lists.infradead.org
X-Gm-Message-State: AOJu0YzkIAQul3yo2mcXCrBumoroKX4yrQkDwD+6oEX2wMJ+e74f6GhU
	KuEksq51RT9LVw6B/dFDPNSl276DpKG9nKNnQB3ePyv6xR6rxq79NPtsy2hXEMQLtMQ=
X-Gm-Gg: Acq92OHCx65GyyPO8ZAcPfhIWIw98UdR1B7arfjOlawNzC1wzLTsh+lRHZBmCFbUo43
	GW4YGM9ttuvciyoJ+QaADIxN0yUt2yiWOqkqqb3LzpOQxUgZ5erA0dMqvmk8S6Gt92CeBxQNV23
	yOUNdtu56cb5S9szakwQxibfUFOOUiCiKJ9BsVKcCqL5fJ6bR1OjyMX/EX5Lx/pSx/swlt3HIZ1
	2ApVM9OPSQmOvx/kcKWfWJRhvlfC0gJVOp8a4QHg5ysqdBdE5o7XFnAd7gRZvuAf3B8r+U6AOyg
	d3DHRcDJ/J105kpG6BAE7pF0virvUT5CeTHzCawwxyLpWx78MoYJgBSsLT4i+8ODtrmpxDEcNJM
	EZQbpErh/Og/hg/X5Ip4RKI69fzIvzR6i3CoIn+Qp0zBYL+GgtKi3TsjJ52Y4XnCh69dfjDpKzD
	PX2Vm10jDnoQPVGRd2IesQ20Jgi+/ml3wkdhjoisDbMZfcenuN4yk8UVm5jlg6k8JVSHJBkBeO
X-Received: by 2002:a05:6214:dce:b0:8ac:a6bd:503b with SMTP id 6a1803df08f44-8cecde9c8admr53195506d6.15.1780501598131;
        Wed, 03 Jun 2026 08:46:38 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd277070sm22665326d6.48.2026.06.03.08.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 08:46:37 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: linux-kselftest@vger.kernel.org,
	rppt@kernel.org,
	shuah@kernel.org,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	corbet@lwn.net,
	pasha.tatashin@soleen.com,
	dmatlack@google.com,
	kexec@lists.infradead.org,
	pratyush@kernel.org,
	skhawaja@google.com,
	graf@amazon.com
Subject: [PATCH v7 13/13] selftests/liveupdate: Add stress-files kexec test
Date: Wed,  3 Jun 2026 15:44:02 +0000
Message-ID: <20260603154402.468928-14-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260603154402.468928-1-pasha.tatashin@soleen.com>
References: <20260603154402.468928-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260603_084639_480178_4F2BD006 
X-CRM114-Status: GOOD (  14.87  )
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

Add a new luo_stress_files kexec test that verifies preserving and
retrieving 500 files across a kexec reboot.

Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 tools/testing/selftests/liveupdate/Makefile   |  1 +
 .../selftests/liveupdate/luo_stress_files.c   | 97 +++++++++++++++++++
 2 files changed, 98 insertions(+)
 create mode 100644 tools/testing/selftests/liveupdate/luo_stress_files.c

diff --git a/tools/testing/selftests/liveupdate/Makefile b/tools/testing/selftests/liveupdate/Makefile
index ed7534468386..30689d22cb02 100644
--- a/tools/testing/selftests/liveupdate/Makefile
+++ b/tools/testing/selftests/liveupdate/Makefile
@@ -7,6 +7,7 @@ TEST_GEN_PROGS += liveupdate
 TEST_GEN_PROGS_EXTENDED += luo_kexec_simple
 TEST_GEN_PROGS_EXTENDED += luo_multi_session
 TEST_GEN_PROGS_EXTENDED += luo_stress_sessions
+TEST_GEN_PROGS_EXTENDED += luo_stress_files
 
 TEST_FILES += do_kexec.sh
 
diff --git a/tools/testing/selftests/liveupdate/luo_stress_files.c b/tools/testing/selftests/liveupdate/luo_stress_files.c
new file mode 100644
index 000000000000..0cdf9cd4bac7
--- /dev/null
+++ b/tools/testing/selftests/liveupdate/luo_stress_files.c
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * Copyright (c) 2026, Google LLC.
+ * Pasha Tatashin <pasha.tatashin@soleen.com>
+ *
+ * Validate that LUO can handle a large number of files per session across
+ * a kexec reboot.
+ */
+
+#include <stdio.h>
+#include <unistd.h>
+#include "luo_test_utils.h"
+
+#define NUM_FILES 500
+#define STATE_SESSION_NAME "kexec_many_files_state"
+#define STATE_MEMFD_TOKEN 9999
+#define TEST_SESSION_NAME "many_files_session"
+
+/* Stage 1: Executed before the kexec reboot. */
+static void run_stage_1(int luo_fd)
+{
+	int session_fd, i;
+
+	ksft_print_msg("[STAGE 1] Creating state file for next stage (2)...\n");
+	create_state_file(luo_fd, STATE_SESSION_NAME, STATE_MEMFD_TOKEN, 2);
+
+	ksft_print_msg("[STAGE 1] Creating test session '%s'...\n", TEST_SESSION_NAME);
+	session_fd = luo_create_session(luo_fd, TEST_SESSION_NAME);
+	if (session_fd < 0)
+		fail_exit("luo_create_session");
+
+	ksft_print_msg("[STAGE 1] Preserving %d files...\n", NUM_FILES);
+	for (i = 0; i < NUM_FILES; i++) {
+		char data[64];
+
+		snprintf(data, sizeof(data), "file-data-%d", i);
+		if (create_and_preserve_memfd(session_fd, i, data) < 0)
+			fail_exit("create_and_preserve_memfd for index %d", i);
+	}
+
+	ksft_print_msg("[STAGE 1] Successfully preserved %d files.\n", NUM_FILES);
+
+	close(luo_fd);
+	daemonize_and_wait();
+}
+
+/* Stage 2: Executed after the kexec reboot. */
+static void run_stage_2(int luo_fd, int state_session_fd)
+{
+	int session_fd;
+	int i, stage;
+
+	ksft_print_msg("[STAGE 2] Starting post-kexec verification...\n");
+
+	restore_and_read_stage(state_session_fd, STATE_MEMFD_TOKEN, &stage);
+	if (stage != 2) {
+		fail_exit("Expected stage 2, but state file contains %d",
+			  stage);
+	}
+
+	ksft_print_msg("[STAGE 2] Retrieving test session '%s'...\n", TEST_SESSION_NAME);
+	session_fd = luo_retrieve_session(luo_fd, TEST_SESSION_NAME);
+	if (session_fd < 0)
+		fail_exit("luo_retrieve_session");
+
+	ksft_print_msg("[STAGE 2] Verifying %d files...\n", NUM_FILES);
+	for (i = 0; i < NUM_FILES; i++) {
+		char data[64];
+		int fd;
+
+		snprintf(data, sizeof(data), "file-data-%d", i);
+		fd = restore_and_verify_memfd(session_fd, i, data);
+		if (fd < 0)
+			fail_exit("restore_and_verify_memfd for index %d", i);
+		close(fd);
+	}
+
+	ksft_print_msg("[STAGE 2] Finishing test session...\n");
+	if (luo_session_finish(session_fd) < 0)
+		fail_exit("luo_session_finish for test session");
+	close(session_fd);
+
+	ksft_print_msg("[STAGE 2] Finalizing state session...\n");
+	if (luo_session_finish(state_session_fd) < 0)
+		fail_exit("luo_session_finish for state session");
+	close(state_session_fd);
+
+	ksft_print_msg("\n--- MANY-FILES KEXEC TEST PASSED (%d files) ---\n",
+		       NUM_FILES);
+}
+
+int main(int argc, char *argv[])
+{
+	return luo_test(argc, argv, STATE_SESSION_NAME,
+			run_stage_1, run_stage_2);
+}
-- 
2.53.0


