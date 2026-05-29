Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6371ACD6E50
	for <kexec@archiver.kernel.org>; Fri, 29 May 2026 03:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zMNVhv3SnOTuZ3xqpMfMs2g7riJHPagItEAHtnUEWTI=; b=jL1p9sdtpfNS/bihP9FfpDUQbp
	+7ZbAQuxz737JQZcQdjlXgGEzW9b/0f6e58xqunjXis/73JqGqcKWbem77DirX6qhq1DT+FxuPeLh
	g6cBvZGrxOCk2qhsmKd23oddPSN+B96ehmmsr+cTg8g4oZclWs5x++eJIfo7V08r8xEUCn9Q8pxyQ
	De+hUZZneXoxdD71ZCtUIXy/X0Vn6U8W2098pSobRPULUBNeM3vnerIx7/wR8mmmIRCGW8XwPIzBy
	n+6SKU2/Q2QnQN9mNcSeh5vH+kSP4HU9lpLaDWVs8a9pVUv2gm92Kc2lVPyyvS7wMeRpbH6l4CoLi
	WKCxTg2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSnmq-00000006gcg-1LiF;
	Fri, 29 May 2026 03:21:28 +0000
Received: from mail-qv1-xf2e.google.com ([2607:f8b0:4864:20::f2e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSnmk-00000006gXt-39NI
	for kexec@lists.infradead.org;
	Fri, 29 May 2026 03:21:23 +0000
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-8bb4e8a5240so168601306d6.1
        for <kexec@lists.infradead.org>; Thu, 28 May 2026 20:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1780024882; x=1780629682; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zMNVhv3SnOTuZ3xqpMfMs2g7riJHPagItEAHtnUEWTI=;
        b=jDScEK/fx2r3NQns1vfE7PqSTE+JswYAVUk+NvjGtx+n3/43RzSZEeATQo1mzPiv91
         TgywAlSYPEm+dAPKf1qDi7pu/FaBw7nsjpUZPtOdDJoAFtZXbY3/oHqM/kG7aAYplq/j
         yoekOKvMyB8DqOxQ3QE+3aCtJqwB8JRW8MdaWCfYsbZRONVgDatJLwR6dbaez0LPHTdw
         5j5iAnNKW+kc3JRGcBAhM1qog/S8Xy8tMBu0n0UNQe0NW1sQCxqrWCE4E/QfQY9hEvE0
         H+bRZcPv99I+Io/vteWjSELdIqYmAh0/K+XDf3BqNekoWapRBi3roT4KAn7Ry3jKVp3v
         FnTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780024882; x=1780629682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zMNVhv3SnOTuZ3xqpMfMs2g7riJHPagItEAHtnUEWTI=;
        b=hsw7mTM6HCQd/o307aaBrkuOCa/RXUIDa0RB6M+9h3bXkYh9dlFenBmYib8ZzOCyu+
         a1et4D9LyiOTryV3QZBc8UCssAIi2GOMHaZvi6bFYdARNGg3jIUVeZayPfMN2HnaFKSt
         KOMRQjikbLRKKXWib7r2F2j+/UylXMY2pKDcYXIAep/y2DIJVnFopZDGArkuhJeFxX5h
         YR0KfpeM/3k5QyhZ4NkmIjbRyMXTSxP3ZQsmtLpmwkAhpy5Dke5rLD8T3N8tDlynNxzK
         zwvLkH+wSCUrfd1qEfbpWLYEGLBSwXNekKOIQpEf33LAs9OMF+mgHDyT3OuHqjAgmYYs
         hU0w==
X-Forwarded-Encrypted: i=1; AFNElJ/V70JNw0tF3poErDaxA84x9PdGkF8id67JBvn8tV/neGaMH5POMT/mJo5eV6FBHWBuhqYFjA==@lists.infradead.org
X-Gm-Message-State: AOJu0YyG/kBhixyBaFHQfD+cq4jtOvCFZHpPa5qB1NDZHWmnfz43At0F
	B54DRfz0XLsB0Y+7ldvdMtx4TnRjwD24Inoa/4EwhRXRInqYFyCfa+EWuBEVZIjlS50=
X-Gm-Gg: Acq92OFJ7wkJbdmDpgL4MVXDJwEpAh6t24YaJNaTQSM45SZmqRk1RWbXHsPMmKsjrJ1
	BS5gpFtqzZk87Gwr9YMehW7mDamVsFQr6jK/Y6B/nPf2TXu63vTmJuT7weeAOCAyCPlpaSMLG3M
	AZ2z+2HXqGLMhc5C0qbYkteHS7A17IVEo6JsjVCfg16XVcAEBIB5S/d6CiBoI78lFll5sITBRRh
	z5mouMvn5upNsKvGslaT0R0lWG1edweDNYWt3qeVT7iCW5z0y+ogfsHE2xms3GhGcdoJC6W0DQA
	N29FadWVUFawQNMWJnYY2mWOyegGOKhHMuO/UQUvmqB5G9O9p0luRoPJNuynC82JCvuD7rN23fu
	d4MdP9S5xfv04y59qSvTwXbqP7bl9GqS/5LkJK4fxKsa6WIPyfSWwuyVrUalhJQndalMhnF9V39
	PT5uzI4x0rsy8s7VcXCMknOjx0G794nLvZiL7s+e8toxr3MqowSx7p2oe+R+cPnA==
X-Received: by 2002:a05:6214:518b:b0:8ca:deb:3f9f with SMTP id 6a1803df08f44-8cce82412d1mr11698806d6.34.1780024881756;
        Thu, 28 May 2026 20:21:21 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ccea26d286sm1179476d6.48.2026.05.28.20.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 20:21:21 -0700 (PDT)
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
Subject: [PATCH v3 10/11] selftests/liveupdate: Add stress-sessions kexec test
Date: Fri, 29 May 2026 03:21:05 +0000
Message-ID: <20260529032106.1505796-11-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529032106.1505796-1-pasha.tatashin@soleen.com>
References: <20260529032106.1505796-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260528_202122_801627_F9CB3BAD 
X-CRM114-Status: GOOD (  16.69  )
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

Add a new test that creates 2000 LUO sessions before a kexec
reboot and verifies their presence after the reboot. This ensures
that the linked-block serialization mechanism works correctly for
a large number of sessions.

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 tools/testing/selftests/liveupdate/Makefile   |   1 +
 .../liveupdate/luo_stress_sessions.c          | 102 ++++++++++++++++++
 2 files changed, 103 insertions(+)
 create mode 100644 tools/testing/selftests/liveupdate/luo_stress_sessions.c

diff --git a/tools/testing/selftests/liveupdate/Makefile b/tools/testing/selftests/liveupdate/Makefile
index 080754787ede..ed7534468386 100644
--- a/tools/testing/selftests/liveupdate/Makefile
+++ b/tools/testing/selftests/liveupdate/Makefile
@@ -6,6 +6,7 @@ TEST_GEN_PROGS += liveupdate
 
 TEST_GEN_PROGS_EXTENDED += luo_kexec_simple
 TEST_GEN_PROGS_EXTENDED += luo_multi_session
+TEST_GEN_PROGS_EXTENDED += luo_stress_sessions
 
 TEST_FILES += do_kexec.sh
 
diff --git a/tools/testing/selftests/liveupdate/luo_stress_sessions.c b/tools/testing/selftests/liveupdate/luo_stress_sessions.c
new file mode 100644
index 000000000000..f201b1839d1d
--- /dev/null
+++ b/tools/testing/selftests/liveupdate/luo_stress_sessions.c
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * Copyright (c) 2026, Google LLC.
+ * Pasha Tatashin <pasha.tatashin@soleen.com>
+ *
+ * Validate that LUO can handle a large number of sessions across a kexec
+ * reboot.
+ */
+
+#include <stdio.h>
+#include <unistd.h>
+#include "luo_test_utils.h"
+
+#define NUM_SESSIONS 2000
+#define STATE_SESSION_NAME "kexec_many_state"
+#define STATE_MEMFD_TOKEN 999
+
+/* Stage 1: Executed before the kexec reboot. */
+static void run_stage_1(int luo_fd)
+{
+	int ret, i;
+
+	ksft_print_msg("[STAGE 1] Increasing ulimit for open files...\n");
+	ret = luo_ensure_nofile_limit(NUM_SESSIONS);
+	if (ret == -EPERM)
+		ksft_exit_skip("Insufficient privileges to set RLIMIT_NOFILE\n");
+	if (ret < 0)
+		ksft_exit_fail_msg("luo_ensure_nofile_limit failed: %s\n", strerror(-ret));
+
+	ksft_print_msg("[STAGE 1] Creating state file for next stage (2)...\n");
+	create_state_file(luo_fd, STATE_SESSION_NAME, STATE_MEMFD_TOKEN, 2);
+
+	ksft_print_msg("[STAGE 1] Creating %d sessions...\n", NUM_SESSIONS);
+
+	for (i = 0; i < NUM_SESSIONS; i++) {
+		char name[LIVEUPDATE_SESSION_NAME_LENGTH];
+		int s_fd;
+
+		snprintf(name, sizeof(name), "many-test-%d", i);
+		s_fd = luo_create_session(luo_fd, name);
+		if (s_fd < 0) {
+			fail_exit("luo_create_session for '%s' at index %d",
+				  name, i);
+		}
+	}
+
+	ksft_print_msg("[STAGE 1] Successfully created %d sessions.\n",
+		       NUM_SESSIONS);
+
+	close(luo_fd);
+	daemonize_and_wait();
+}
+
+/* Stage 2: Executed after the kexec reboot. */
+static void run_stage_2(int luo_fd, int state_session_fd)
+{
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
+	ksft_print_msg("[STAGE 2] Retrieving and finishing %d sessions...\n",
+		       NUM_SESSIONS);
+
+	for (i = 0; i < NUM_SESSIONS; i++) {
+		char name[LIVEUPDATE_SESSION_NAME_LENGTH];
+		int s_fd;
+
+		snprintf(name, sizeof(name), "many-test-%d", i);
+		s_fd = luo_retrieve_session(luo_fd, name);
+		if (s_fd < 0) {
+			fail_exit("luo_retrieve_session for '%s' at index %d",
+				  name, i);
+		}
+
+		if (luo_session_finish(s_fd) < 0) {
+			fail_exit("luo_session_finish for '%s' at index %d",
+				  name, i);
+		}
+		close(s_fd);
+	}
+
+	ksft_print_msg("[STAGE 2] Finalizing state session...\n");
+	if (luo_session_finish(state_session_fd) < 0)
+		fail_exit("luo_session_finish for state session");
+	close(state_session_fd);
+
+	ksft_print_msg("\n--- MANY-SESSIONS KEXEC TEST PASSED (%d sessions) ---\n",
+		       NUM_SESSIONS);
+}
+
+int main(int argc, char *argv[])
+{
+	return luo_test(argc, argv, STATE_SESSION_NAME,
+			run_stage_1, run_stage_2);
+}
-- 
2.53.0


