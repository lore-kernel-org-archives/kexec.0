Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 569FAF9D0F2
	for <kexec@archiver.kernel.org>; Tue, 14 Apr 2026 20:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ydncbOJwc9Epn5rxEKLGgwSNmxXWJlxhMwGYD93RLPE=; b=WdUfcmjPMM7I1+5Tue4npoBIED
	1hBvECW6bc62IK/QnKPzYSDh/vgdz4PdE4Zx6+F6mUuK4eVHZIDjElIWuUcof8WDyx3B7lqMKkGfp
	B8WD44auj0/ClyoKDJm+0cGhwJzXcFwCqPv+b0TsS6NXkGeE14VY5BFZWl2M2UgdIUI8XwY6tLqvS
	j0Wes4VtneJ/hXVxGJyeOZ+8N8bUzSKpwVxVKTlrB1xSkPsBPwJ7QhruZv0mRQzRRpHHOVuqiyyS6
	AcH4V1VelShVHWy8RFHgudopcuFD7leB9hYsllkK2946QNXuFjK10EP6ELYkRGvxLWiDMhYe/crE1
	WRwYG+nQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCjyC-00000000B5h-3vNE;
	Tue, 14 Apr 2026 20:02:48 +0000
Received: from mail-qv1-xf31.google.com ([2607:f8b0:4864:20::f31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCjyA-00000000B39-2mVX
	for kexec@lists.infradead.org;
	Tue, 14 Apr 2026 20:02:47 +0000
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-8aca4e14411so34789166d6.3
        for <kexec@lists.infradead.org>; Tue, 14 Apr 2026 13:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1776196965; x=1776801765; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ydncbOJwc9Epn5rxEKLGgwSNmxXWJlxhMwGYD93RLPE=;
        b=heDM60vH5w6LaVw6Nm3dMkJlVr0WeKoheIdV8VdoUC1pcmzKa5vJxCrPH0SlLROiuq
         /NzDvQB3eFOJ3jeiT5jDWsFqJNd3tpLMU5Uh+gqIwx5JmHcurvNDx9/+qwlhhtfvuSzu
         zr3bq64oEqjxYBJWakGm4qMQB9Xv6U3xQfmC524zu/slp2cyUsv+ivnEuH2R0048CYYf
         rNF+0qiS6I/ClsPprhrxmG+atCZ3kJXWcA+selk4Pr47uTGGxhgbEchVu7+C1k+xFifd
         OHATSf88qNW7kp1ZWIjrQ9MM5qnHhQ5UfbPnQrnEs6ngwtTg4JNWZ67tH/B6aC4aG7vt
         ZoHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776196965; x=1776801765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ydncbOJwc9Epn5rxEKLGgwSNmxXWJlxhMwGYD93RLPE=;
        b=iqbmv43APrnaVIcBETyqX5ofL5LrjTLbhDOMDnFSlqGQrroH84GDvJG8Ej2Hut0nlk
         8FyvzBNyjQdlI5l1yd70JMaZi6BoRaP3HyM+Pl0WxyM5A7LbmLLeopb3Nt5s6EE6IgLm
         i9/6YONjKgXwevRwz/RvOvt68PQx5iOFup8gfPumIhyRIC+t2gRMoiwjHbmKdQM7WBZE
         QXSMrDyyxRSIN5+TkmNxCYNBrJIwSUKBoSg2OlZFGaWkTXOt8JM8l9cB9xP5yQHnt85O
         GTqhWyN08IqkYZ1duyfM9pumo0+QVlK5B5vHt0slVJ3WljzAkuv00JGQv9mhIF3TfaH8
         fO6w==
X-Forwarded-Encrypted: i=1; AFNElJ8YXGFkLpLpV9UyHFwcu2hpmU/KRtC6Iw6RMsmL1s+cdJzzFTb8ZfGDcnavyb5+hL2ASzRx+A==@lists.infradead.org
X-Gm-Message-State: AOJu0YyJC4dThVnMvKhcxKocILvIxG6exYYTdtQsK83qGRndZuV8kBHX
	v/a4H92zedYrrqYYkE2rP60/lrE1j7fmLCgfjU7INoI3Lm6yFmwmhlW0sVnEuDCreRE=
X-Gm-Gg: AeBDies4dygR3zWgJXxUFsFjxaG+3F5JHQ7qDjR1nAKSR0VOS6cvvOWqqV0+ol3eIJM
	0iAOPvjCKetbKcDN/osWa8NmduPRyFikwqIM6HHh/UyIcF+gz8UfAQEngPdh2+0TkR6GwPXUUxv
	vGYvTQssp/vCQ7//GeBYRTewE81sL6AGOHXKMTEX7xdAFGIdNcw9wzi272nIjJ+U1L3OWTcLzdk
	Uel9JLeP6/+Ulcs29MGRKtXMWQ2RCZAxLAkOcPz+YJdcGIDRmfj1nYqSct7Njx6GOGtCu9cmg2U
	pDd18Gg7V1JilHYj9Xd5RM3XJymdmqyDNn/crQJrV5IDBpdcwPfllVdd5yNBtZC9af6axh6sBDF
	Po+gTMJjO6TEvhyo9Istk6yo6XnLHAJPrP/UkO3ZUofgnxH9gNiHtSo3Hn3vZBTpa/9QJH2YzZw
	ArnZnKFzQDqUp7rKe3qVWQHbyM1kqkv9wPh1X3j3ZKrfzV9fH0gb9InFjBDiDWh+3gnQ==
X-Received: by 2002:a05:6214:4a8a:b0:8ac:ba63:a1af with SMTP id 6a1803df08f44-8acba63a68dmr104715286d6.53.1776196965499;
        Tue, 14 Apr 2026 13:02:45 -0700 (PDT)
Received: from plex.localdomain ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ac84a180a2sm132213656d6.15.2026.04.14.13.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 13:02:45 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: linux-kselftest@vger.kernel.org,
	rppt@kernel.org,
	shuah@kernel.org,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	pasha.tatashin@soleen.com,
	dmatlack@google.com,
	kexec@lists.infradead.org,
	pratyush@kernel.org,
	skhawaja@google.com,
	graf@amazon.com
Subject: [PATCH 4/5] selftests/liveupdate: Add stress-sessions kexec test
Date: Tue, 14 Apr 2026 20:02:36 +0000
Message-ID: <20260414200237.444170-5-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260414200237.444170-1-pasha.tatashin@soleen.com>
References: <20260414200237.444170-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260414_130246_726109_A29D761D 
X-CRM114-Status: GOOD (  20.08  )
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

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 tools/testing/selftests/liveupdate/Makefile   |  1 +
 .../liveupdate/luo_stress_sessions.c          | 98 +++++++++++++++++++
 .../selftests/liveupdate/luo_test_utils.c     | 25 +++++
 .../selftests/liveupdate/luo_test_utils.h     |  2 +
 4 files changed, 126 insertions(+)
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
index 000000000000..cd6e9bb0db3c
--- /dev/null
+++ b/tools/testing/selftests/liveupdate/luo_stress_sessions.c
@@ -0,0 +1,98 @@
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
+	int i;
+
+	ksft_print_msg("[STAGE 1] Increasing ulimit for open files...\n");
+	luo_ensure_nofile_limit(NUM_SESSIONS + 10);
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
diff --git a/tools/testing/selftests/liveupdate/luo_test_utils.c b/tools/testing/selftests/liveupdate/luo_test_utils.c
index 3c8721c505df..37c330b9bb36 100644
--- a/tools/testing/selftests/liveupdate/luo_test_utils.c
+++ b/tools/testing/selftests/liveupdate/luo_test_utils.c
@@ -20,6 +20,7 @@
 #include <sys/stat.h>
 #include <errno.h>
 #include <stdarg.h>
+#include <sys/resource.h>
 
 #include "luo_test_utils.h"
 
@@ -28,6 +29,30 @@ int luo_open_device(void)
 	return open(LUO_DEVICE, O_RDWR);
 }
 
+void luo_ensure_nofile_limit(long min_limit)
+{
+	struct rlimit hl;
+
+	if (getrlimit(RLIMIT_NOFILE, &hl) < 0)
+		ksft_exit_fail_msg("getrlimit failed: %s\n", strerror(errno));
+
+	if (hl.rlim_cur >= min_limit)
+		return;
+
+	hl.rlim_cur = min_limit;
+	if (hl.rlim_cur > hl.rlim_max)
+		hl.rlim_max = hl.rlim_cur;
+
+	if (setrlimit(RLIMIT_NOFILE, &hl) < 0) {
+		if (errno == EPERM) {
+			ksft_exit_skip("Insufficient privileges to set RLIMIT_NOFILE to %ld\n",
+				       hl.rlim_cur);
+		}
+		ksft_exit_fail_msg("setrlimit to %ld failed: %s\n",
+				   hl.rlim_cur, strerror(errno));
+	}
+}
+
 int luo_create_session(int luo_fd, const char *name)
 {
 	struct liveupdate_ioctl_create_session arg = { .size = sizeof(arg) };
diff --git a/tools/testing/selftests/liveupdate/luo_test_utils.h b/tools/testing/selftests/liveupdate/luo_test_utils.h
index 90099bf49577..9174d6757a7f 100644
--- a/tools/testing/selftests/liveupdate/luo_test_utils.h
+++ b/tools/testing/selftests/liveupdate/luo_test_utils.h
@@ -26,6 +26,8 @@ int luo_create_session(int luo_fd, const char *name);
 int luo_retrieve_session(int luo_fd, const char *name);
 int luo_session_finish(int session_fd);
 
+void luo_ensure_nofile_limit(long min_limit);
+
 int create_and_preserve_memfd(int session_fd, int token, const char *data);
 int restore_and_verify_memfd(int session_fd, int token, const char *expected_data);
 
-- 
2.43.0


