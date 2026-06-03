Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AA18CD6E6D
	for <kexec@archiver.kernel.org>; Wed,  3 Jun 2026 03:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LZ44uuKaEudMkx03Nujcoh6Uuv+6Qpcd4aVYSw8wkq4=; b=u7W6hulSsWLhceffmcThHa7Udm
	gM5n0SYsQYsVTHqR6HVDYs20D+gQa8L7LyQ6RgX1hTwdXpX82fbex0SAky1WuQ00VTUmtATY0qgBd
	0ML+9tpcAhNDWdbOpNHO0harJOPrm2LJy0NTMzNsq6JiUML4FGaQ1lRguTdUjLgITOc5tMK7PRWkQ
	BgJGkQcOijaxXuWH9KVNpAdjrHK3qDRb+P7gstPWmr3ysMJg2qajh1mgvFzOBqwll3fXo0VcoDkh+
	gHGMa4oUH78dXfJgyTmTOI1BvD29jZOzQkHyXkBfxCp4MSemkHtz6RIHUtxFlBFk6QjUmD7bOxyGy
	dSCXi9SQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUcIL-0000000EBCU-1rIr;
	Wed, 03 Jun 2026 03:29:29 +0000
Received: from mail-qv1-xf2a.google.com ([2607:f8b0:4864:20::f2a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUcIJ-0000000EB80-0Qi1
	for kexec@lists.infradead.org;
	Wed, 03 Jun 2026 03:29:28 +0000
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-8ccef25789fso31533436d6.3
        for <kexec@lists.infradead.org>; Tue, 02 Jun 2026 20:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1780457366; x=1781062166; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LZ44uuKaEudMkx03Nujcoh6Uuv+6Qpcd4aVYSw8wkq4=;
        b=aBCPjdCl3TfTwSHxdX9bR5gdhVmEHJsjT7qOhUngDTd87zY3feWsZWEaRurRw5ETRa
         xigEU92AaOQb/Ssp9jiPQ9CgnESw1kVPojQUfvMx+RDWq0u1nwvHQ+iB7zfsh3OOPJEd
         L6SH2aIAZ9qH5vsvMJRO6Ae60sUplWkVXTaHXJXP3RTpoCQVUZwthsaUJQ2J9pgU0AqD
         HhUniArDzay/XUXtczGg0rKjcvLmS+A5h+ABbMyFWvD6ySI1kjxRZU++nAFliRSaytn7
         Dt650pehebkyT0CwZOiI0JNK0Q+WThlsZc53mXWCLC8fv7L3s/GdrGhe3APksn81N1z3
         8lXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780457366; x=1781062166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LZ44uuKaEudMkx03Nujcoh6Uuv+6Qpcd4aVYSw8wkq4=;
        b=IQHA2EfoyS9w4AuZ8Uah4cFDQL+8I5mALw/41pwoFnD19Or+AxalWQ8wbczvI72NEi
         2pSmfxRPd0qINg3cMPvkscEkJyRl7NHbWYeCJsxAE7PPnabLcVC7H7UItOvpkeLAMF/L
         HSxq4GJqM5nhoKvySjO5dDEFB1rNRTern2uN7mso/abL0v5YBM6zzzD9eQDbc46GnQmC
         3jExlh6lbz30G/eop1QWghfbIiSuvhc1oI8TF4wY9QWYwveCN/A7raUH+Q7GXcqwnBHT
         sj2lNGHhbbvbXsI6emzqrZa+Ay691pP0M2v490V5rEOIjlm7AoCKd3JnC9BsDbcrCpvG
         Utrg==
X-Forwarded-Encrypted: i=1; AFNElJ/hxCncujqKhhbbjwQhll7zKBcGtvHi6GIaHV1KlcEIWk692eVyMJEyxYDs8nkld2zBnTqMlw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yzds0sYqCAoY5VzAL9tg4bFxxlfpt2ZjhSJZYFPbLfuAoMnXba7
	UP4QnV3nD/K5YyOpUoTZsLWL+eT3MKzNXjfP5ns7Z9SDskwWWVJHzwqPE7nRdYl9UKo=
X-Gm-Gg: Acq92OFD8RIM9TFlqFNNaL6ifN8bfvmhy9KNjTEecFcQA932eIlfuQlTEHBxwTwmOLD
	4UYmkRJnyiIUIo8Sji8jAq/wZv24o25g2CF4lObIuVA7V7aAoMMGn/zCa5RLe4JmA1Ve1TRlEBF
	nW6VoShvXt9a6PjqQa04W64CuqDsLdRj7zCnT3WbNLclaeLeWoFS1hNxUTk6R185xRwn465ZE8/
	pM2v7rMRMZEtUJ3VGz6tf0RmNFZCzGgM8/37iviDAWmAOGQamKus4rseG8KVijZPrzrqVyDoS/k
	gpYV8cjitC2h9CfH7fZBkvRylvcIwhqqtWFyIX6GjWfFO48BQgjRZB9CfH/URuMyLRq8J1Xqix3
	SoNTmnKieDkIsM/PXkQnbrtzxzOyYz4jCyIuzhsU8PHvkABhD/gcmMSMLL+Hh6cgsovrJx3g+aU
	RJf3O8vSONuwSEdA4gO01274ySMN+DHdSWauhyV9/8Upg4OkK1hht2NJ/mgj93fw==
X-Received: by 2002:a05:6214:500e:b0:8a0:4e92:c45f with SMTP id 6a1803df08f44-8cecdc18097mr21849986d6.11.1780457365747;
        Tue, 02 Jun 2026 20:29:25 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd26b3b9sm9244566d6.45.2026.06.02.20.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 20:29:25 -0700 (PDT)
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
Subject: [PATCH v6 13/13] selftests/liveupdate: Add stress-files kexec test
Date: Wed,  3 Jun 2026 03:29:04 +0000
Message-ID: <20260603032905.344462-14-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260603032905.344462-1-pasha.tatashin@soleen.com>
References: <20260603032905.344462-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260602_202927_206971_F64AC937 
X-CRM114-Status: GOOD (  15.18  )
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


