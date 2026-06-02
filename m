Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28529CD6E61
	for <kexec@archiver.kernel.org>; Tue,  2 Jun 2026 03:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=psMAwGaqe9xuyJY3Mn283ARVP/GQQXmgr+1HpWpGRKs=; b=UtlkFr7rYnPgZn2VJtadiWA2h9
	OhEeLhYNVrY7rpkhHmgKKMw/ya98fmL8t05uhjb8HvTybj2n4ohemgKT1c28d/GUsbitUuuDCW8nW
	fmwgzL7sa/qKc9KTXsYFcUMKa57bgs9i91ZE8tEleoW4VxF1sgC2KaPQypl5bqUB4CwuLNW48i7V0
	6EYvvob/l23eTtouVLNXt0kUE4jf+6nNvigTqecJahbEqOt8ac06P8P3PpygeUBHDgQD/j2AzdzIZ
	6qUl81X/ockgSrFu8h4fLZxJxH6YxWzx5p2dzhbO9pXA3vgUXJbJBY3VvacJ87hKRGC0u91WJkTnD
	zH+TZAOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUFdS-0000000CDUO-1VqQ;
	Tue, 02 Jun 2026 03:17:46 +0000
Received: from mail-qv1-xf2f.google.com ([2607:f8b0:4864:20::f2f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUFdJ-0000000CDJk-2Z7y
	for kexec@lists.infradead.org;
	Tue, 02 Jun 2026 03:17:39 +0000
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-8cceaa6f75bso59905706d6.0
        for <kexec@lists.infradead.org>; Mon, 01 Jun 2026 20:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1780370256; x=1780975056; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=psMAwGaqe9xuyJY3Mn283ARVP/GQQXmgr+1HpWpGRKs=;
        b=QEOeskTmOxYgpUu05FlU+vVlUi3ADRl0UEIUuee63jo9EC6/S5HoVugrA/0tLwYJSx
         T95mFHZW4X+SVYcw+LAmqIEMGKBTtVLn9s5cPg2vWcaGxf7FcIFWlPtjF82YijADKMac
         HyJ12B/IClctdLLXmWITPhPy1gfol1NzUGgkIqhTYUi81HNE282Pqdg3Uht5J/C9t4fr
         ZcZnoVgAyC1qKYWMcEL2d6QQN+hX2hwBTkx4U6biAN8e0WcITtC6kffutkJ8+YZj1pV3
         sMe+fFL/byUtOfm5wMD2WQj0TCXQfWOV6LlDYl3t6alxL0hsSroKGdwEllv2WK+1nUKK
         ZYHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780370256; x=1780975056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=psMAwGaqe9xuyJY3Mn283ARVP/GQQXmgr+1HpWpGRKs=;
        b=eAU8o/Y3PfE9qnzaeHktGQuQ1XnQya+fGgpj75WqhqGMueJ8hLPA0nCdgd4/j6SRES
         b4e8RE0djj2d2HbcaDfvJc4jiIQ3RGnVADVblVeYi/z9gNdWjpg/hyOW0KeXi+0w1RcP
         8qWLFVecJ/BFgOZOeuegzXdNSR6bLJLBHu6GOe7r02UgE/ZV2UR1q7TjeBsHP2LthOx2
         DAihMk/WieL+EZWagx9jdHUNlz1rIQ4ZYmOjod6jRpla/97dS2w/p1YSMnyDif+z7+FK
         xML3Ruw8kLi5F69Xl7F9hitxAEaGPCXcAM2HyOWaV0RWRQglOQUBO40Gvk+FNr7+ZVGV
         l2eQ==
X-Forwarded-Encrypted: i=1; AFNElJ8069Btqy3d/ru9EbD2K+vUieWPPeDumYTOlKyVaT4OT7o11pMFpyNzglICwz/rPP45PjezKA==@lists.infradead.org
X-Gm-Message-State: AOJu0YzVqhgmiDS1rq1EQ31geR0DzMcVe0LbQymFp2ZMh+z7Wu3eTLmr
	Jfc3KMoOawQX4SVxu+3Pw1jphrJrcKfi0Zg9t2MDquGjFDFz6UO6m9t4+4NweHnMdr8=
X-Gm-Gg: Acq92OG6/+rVUPrFT/kbu5MaIulgGfg6rG4D9u48LK3rsHXl4FfX2ItUC6J1sn0uAx0
	7noQ9k06VBLsZcnGemTnRbYaXIlx2LJFnjZ15z8xUaZFak6cQx3HGYTTk1GJxheOw4ygtgYpg5t
	Lt5Fj9vO0t9y0SPELVpNmN4A1gpuQwR3DUc3dC2R6z+ty7sYeeszYdchZNW34KfCAsvSDAGFkxt
	w4RKYrFef5rndghhMjvEpQVxidw9/INkypJlFTi4vqtWKxD8vCbDA0nr5YF10jFigtI8JADTOyB
	ZF0wcqEIRHP2VePANkeueRoxcy5h3RorReQUDuBRhjP/7+pt97jP/mcH803C8CR7AGzrjRO65Oj
	wUnT3LH1dUom8hFb08R7kF28D7stO08yqSnu+MAhJwqNybXE2xeNpAPB36i96r7JxERoOvAqNJD
	h0Jy5jeP3TIIeTyvyoA02FeljE+B/O5KZ380z04zYJVdkyaDpeuDZ0cg8OiszKgg==
X-Received: by 2002:a05:622a:9016:b0:50d:3e1e:7998 with SMTP id d75a77b69052e-5173a821f86mr167634871cf.37.1780370256215;
        Mon, 01 Jun 2026 20:17:36 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51741b29745sm71219081cf.8.2026.06.01.20.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 20:17:35 -0700 (PDT)
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
Subject: [PATCH v5 12/13] selftests/liveupdate: Add stress-sessions kexec test
Date: Tue,  2 Jun 2026 03:17:16 +0000
Message-ID: <20260602031717.197696-13-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260602031717.197696-1-pasha.tatashin@soleen.com>
References: <20260602031717.197696-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260601_201737_669821_7D76916D 
X-CRM114-Status: GOOD (  16.33  )
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
Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>
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


