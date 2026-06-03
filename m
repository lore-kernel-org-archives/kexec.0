Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66EC7CD6E6C
	for <kexec@archiver.kernel.org>; Wed,  3 Jun 2026 03:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=psMAwGaqe9xuyJY3Mn283ARVP/GQQXmgr+1HpWpGRKs=; b=vWwso37wYPv01Yo1muINxU+OJB
	4Nv7RBsFJ4cWhxc2clZwQRCS91sgTkaNRSJwcPAZyU4xamisW1PpEvw0x5YMmOfTMVYoq62c0yHG+
	Qxe6MzMdejh5uaT3mu4ElKzjM8p++HLUzbbtB7Q2s21q1xFZmfAFdMsYN1Qb+dHef1lbytxQuej9M
	xFSl5XgMj4a8kjhRlVqcdHdBrn88P5Cu59/401pgyUht5obvMoICybj5FNmyCYN/SaJxcYUoeSuD6
	MXGFMm9kIhuz2XezfzzTts6elxDSp8UVJjD2JzZa+/+NQwWsvXN39zSaZV21gWdbluwGecgmPKMJx
	6E+r1O9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUcIK-0000000EBAx-1PyP;
	Wed, 03 Jun 2026 03:29:28 +0000
Received: from mail-qv1-xf36.google.com ([2607:f8b0:4864:20::f36])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUcIH-0000000EB61-2DQ0
	for kexec@lists.infradead.org;
	Wed, 03 Jun 2026 03:29:26 +0000
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-8cebfb15413so16139326d6.0
        for <kexec@lists.infradead.org>; Tue, 02 Jun 2026 20:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1780457364; x=1781062164; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=psMAwGaqe9xuyJY3Mn283ARVP/GQQXmgr+1HpWpGRKs=;
        b=OR7C24HvOWdYf1OpuYE0I7KF0ojww7je6WlqczjbNTIGdSFEdq2TXKkxe/UV+duZOc
         hSuiYTTN6ICsYLxFcwVDEabJ2yIjKdjwbx+rggdz+1d4quNC+/CDsPW3dZ/JN8hgEdT1
         KdeuvrlnWE4HZIjd35SCVkbSxMCeCxUcei3wVQrFDN8R7kK1ut4/C02iPIAm1pjRQRLo
         3xFau0Ivuusmy4+8JYNihP+oxgwyRBJNrlF8yQ8fbfNezj3pV98JXamcLdYFSx9K1QBB
         mvX+pGIZUk29tcVdnnM7fujJ9TLItRk+KTK0vI8QkmWqVICCtRgXW3wYDLSDONO4J9lQ
         8o5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780457364; x=1781062164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=psMAwGaqe9xuyJY3Mn283ARVP/GQQXmgr+1HpWpGRKs=;
        b=VePK/fs6/IDLUPf3qFNu2blSoDiT161ZTi0E5UX4hD0rFAxpIZ3iYgSzTzjRaWzhkM
         gHIkAhxZ7hJnM53ERkF8hf6infgegxgt2U0ajejzVaS/Mj8r3zXw4PjulSZ7iZ8hf8ln
         pdFAyizRykMeW19blJbmMgJeXXKqkC1Opp29gxrDuTDoGXWY9hhJsB2fpfhezjI+MhWe
         o6d86jFMNnzAurH1rvok6kFuwytSqOjwf6/a0kTT2vZ0b+mqk5vkNFEM0vIgoqNQ2B5o
         LVJLfN1Y7AlzBcQ7z6ANWo2VKBc59zPUa+slxMv1sjvolq8+F6uFILL1nfk+mHBbslAa
         YBBQ==
X-Forwarded-Encrypted: i=1; AFNElJ8nalPLd9OhHw/IDvdPZwpbFdnzymRaiTDMgRoWsVoFnuqTHQ/erAKHwQ/QN8/T2W5GwfOqmg==@lists.infradead.org
X-Gm-Message-State: AOJu0YxMhgOllw5YaEHeJ9zXf7V16VJDt9Lfwl2utj3ilfyC9ve3c/PB
	y0gm+bjHO6H3gI3j6dS5fLE9/0WU9v+1AqeYrj1JN4xpJmox3YTzaQevVxHSE1nneC8=
X-Gm-Gg: Acq92OFWeEtx2kOUW2c9JuXs0yZrQ3BWP77aSD7FU6aUgm2w28t2vjq4+QjQ7Mytz+L
	dH0xgBhY415icY2ki1JfvPJFnnf1OSzO2dQdjWQTsMTvJIhoqZTpVBtbKyjxBnFM51xZ/gkB1qV
	YVYmhdmex3vmWiSK5WBPquh/nlPr0Vpwc3BxZ0bXg0Xh4qgvfva0Neo6x+33CkP9lVOcQNOZZm4
	7cgDrDqvopK5IRFpFWrIh9XoZySyRBBqBV/p3RJe60ssmcEAplEHf/EfSmVbr53cIpGDcM3Ycgf
	CTT5M7c9CjZvjQztI+vLqXV2tuW0fAVIJGhC45kBxrJ+BPgAVEvuu+qjcEwFj0Uz0uAF9EGunB8
	ed8+t5YUCqzGbQJZ7PZspEa824yhtyaOg+N8oTomTzLJ4AM0YLH8uruFCgNFnzt21z9T9puy2C+
	VZvuFqa9aG08yBSf9I43BnrNQQNQJKVOkvRBmtkmia07zs4CyHvCW2ov8KC7IO8QDv2LrKQqkw
X-Received: by 2002:ad4:5044:0:b0:8bd:59a6:4165 with SMTP id 6a1803df08f44-8cecdc04bc1mr16915496d6.4.1780457364532;
        Tue, 02 Jun 2026 20:29:24 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd26b3b9sm9244566d6.45.2026.06.02.20.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 20:29:23 -0700 (PDT)
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
Subject: [PATCH v6 12/13] selftests/liveupdate: Add stress-sessions kexec test
Date: Wed,  3 Jun 2026 03:29:03 +0000
Message-ID: <20260603032905.344462-13-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260603032905.344462-1-pasha.tatashin@soleen.com>
References: <20260603032905.344462-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260602_202925_669413_55447B04 
X-CRM114-Status: GOOD (  16.65  )
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


