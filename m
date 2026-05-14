Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87E70CD4F3D
	for <kexec@archiver.kernel.org>; Thu, 14 May 2026 22:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z+TDIuCJZXpxQehieZyZSUnjXJ4NsIJyCoOgTpI/vhI=; b=P4nw/BdM5J7IR0FlZMR8tvDUM+
	sw0yRxFF1+mnqNB7hQzCzbJxfR0cqMEp0b/SveMIg0sW3DKF5gscO64iDSwWUbKOSWr9vsuQ05c7a
	24FE2QO2jII8b9spQGJkqeC9kseAmJPjnRzd3ZzOzG7vfIQGReQWNB0NrbCeR7HOrwTZdx8ww4FEf
	aMUjPnp+gp1yW28B0ggqN7GxjQ2mprEMyOrDvnryAFSo7R0snOc9aS3pLWEMJ/oEJ5OuZIqHnCFJ3
	pugR+lF4ynfbqKzsINGj44frHFvuTGpK60CQMJdpuHQzCt0ZBOJc5kh07eAMQiAeOkNSlG4IHaFeY
	mMH6Ty/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNeW3-00000006iSb-39Xe;
	Thu, 14 May 2026 22:26:51 +0000
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNeW1-00000006iOn-0NJA
	for kexec@lists.infradead.org;
	Thu, 14 May 2026 22:26:50 +0000
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-514ae601df2so27945771cf.0
        for <kexec@lists.infradead.org>; Thu, 14 May 2026 15:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1778797608; x=1779402408; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z+TDIuCJZXpxQehieZyZSUnjXJ4NsIJyCoOgTpI/vhI=;
        b=HL1Wja9B42OEPtHrWVlFfQCXqXaXDyprwf9s21z1/7Mk70gcouWseSit9v6p2PLH7k
         y5bpcaVM9FfnZFu6KKn6yzTC4azlPI7NVyXUb85i9ISjP5OawMRpJ3LWh+X8I+QWFCbY
         QKXOyvm7eMGDvEFWipLMhPsr/GXDh0mGjHf+Wsr6xdtHNkN2wWYUNlJlA4ZOZ1AtRA99
         zQREW+VBfAWX6lqKMMl9jonvG2GaIOSTJfLUaHZgZO058zIO+Lf6TsYQNUAbTFeWPed7
         n1RVvMB3a2boQEFX98cYfnRST1Z8iMpHxUHp989fUofBj1+GKKBZhA3OzOLB6dtcQkv8
         iYYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778797608; x=1779402408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z+TDIuCJZXpxQehieZyZSUnjXJ4NsIJyCoOgTpI/vhI=;
        b=pc4k8PQ1lkRfnNoUlueLLoZMQvEbzuNNGO0u+qV+edB4c8x9rofpea0SKbvdpVj7OV
         Y1MmFkDuFJbEsc50CD+/FFc1d7vPLeMBxaKAMH7S7a3Wv4Lr2BGbj6XnjTFQXwUwGzPu
         /RI3vnJ/NCY/++kmTt0l/QjuIEkixq5zuyynJ5y+Dk3uPnLEzxhaDnRJo1O6vmNXYL/b
         ecpgq7pGmjjXCIsBFQmQofIDCL9SOx0zYMGdHcXobUnChweQVS6HDBKRtQlmKOedQToX
         kkrz5YBtoDWhnxCHfMG57m9fnQHaNNXtLikSOJaAUsBfVfu3GkY9sqEGxRe/IaQww++N
         s1Pg==
X-Forwarded-Encrypted: i=1; AFNElJ9f/kw4xkm5CnkWikxXLDh1XTJ5dM/H1sPuw534ga3tww9m07I1ghGjkrDMjNfbCr9qT0fKKQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yzf8tXNrJv8ABbmkcgX1bMkW9N8Ml+NRiRw9+b30d/OkYMNdkgf
	etoaw2glLji9c0megowI9Gy7qFzTRFBfdnKYhFm1bMAORttDIuGC/1APh86XrQ0M7z8=
X-Gm-Gg: Acq92OHavrgsIuSlbj/0XKug/arsrX18e9n7vkMHJZ37urVPu2zuzY5yu9WYYzST4qL
	ek6qXAWD9ybawpx7YLm3WHmhu61FWFtfpeWvI7RGNBw4nlIHwSTgfDOOFHJoYJQygeZYWg4nVVb
	AzgAWeqzKshdx2rV/pDc1Om8aGkx0uhImpN92N/rCUDlk+aV3TReOo5L6PtwypWsf1rgpmMji8B
	PxdZHK/v5zZnBQarAvgZZLIjBkhlXSpo4yv2SHw1Zn4fxeKoMpYtp30pDKqfgNtRBIYFNjL/uBt
	Sju2f02wWYOjK4br+YX2zl5h1lKB+7/HXA++6TNLbkOK6hDu19ezdxdpZJlHo5OXUZoXHhGInkS
	2XCxTCyPZkoKtwtCeYoBUj/7K2RyOA3i1nTBHlxmK4kd3OEmOSz8aV+9Et1b1hn62dQdYp1PaEm
	AcDW7pnZK7QgaJnUe73cJn8WO+bKplMe5I0sQC9Hu2lkiUOJTdYuI=
X-Received: by 2002:a05:622a:15c5:b0:50d:a8f5:1c02 with SMTP id d75a77b69052e-5165a219a43mr19531391cf.41.1778797607915;
        Thu, 14 May 2026 15:26:47 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516456ba92fsm28671901cf.9.2026.05.14.15.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 15:26:46 -0700 (PDT)
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
Subject: [PATCH v2 09/10] selftests/liveupdate: Add stress-sessions kexec test
Date: Thu, 14 May 2026 22:26:27 +0000
Message-ID: <20260514222628.931312-10-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260514222628.931312-1-pasha.tatashin@soleen.com>
References: <20260514222628.931312-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260514_152649_142502_DC41ABF3 
X-CRM114-Status: GOOD (  16.40  )
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


