Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF4F7F9D0F8
	for <kexec@archiver.kernel.org>; Tue, 14 Apr 2026 20:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9TjUnXkwrio/0RMOWx8bIqnkUDx9TXK82cA2FHqDPhg=; b=jMknVVUrzKqNXMus25BKEGhqsj
	pi3HEIs2Ps4LMg1KzZo2ttTeLn9huRrPhW5LD3UEHPkV5CGiXyQ+H1rrSOvug8aCXaFZ9RPI2SAc4
	AcTiT/6kCGPPVyVa+qziLYzI9WO0WyQpkrqjdOGQdE3PfLdhjN1yudWBGyTh1uIO2ZWtMUJWuMGze
	eQF+TFqRDrhSOp4Xq670YNCRFek0+zhmxn/Y1NIqUQgZgEz18ZZfCtQ46TDZeS/D/xB4L9D0DHLsv
	YI5ijIXON8Voj3qzd+9MYMpc1b+Uh1VPv3ezE8qYNh7dENKkdrM8W4whofaFHm4Kho8ZYAdhwUt6Q
	SReTqm7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCjyF-00000000B7b-0rzA;
	Tue, 14 Apr 2026 20:02:51 +0000
Received: from mail-ua1-x92d.google.com ([2607:f8b0:4864:20::92d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCjyC-00000000B4J-1whD
	for kexec@lists.infradead.org;
	Tue, 14 Apr 2026 20:02:49 +0000
Received: by mail-ua1-x92d.google.com with SMTP id a1e0cc1a2514c-953c5738c03so3557749241.2
        for <kexec@lists.infradead.org>; Tue, 14 Apr 2026 13:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1776196967; x=1776801767; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9TjUnXkwrio/0RMOWx8bIqnkUDx9TXK82cA2FHqDPhg=;
        b=IT9021ean+NajSZjruVMdy4j0zsaU9+sOfa+2hLd2xcp+orG6sc127SUd76jiM0ume
         bZhxB71aXMtG9AhZbH8wI1d0a/b8ZMyn973pfMknv3sd9yVzdvswRkY1ALQb/nmT4ad4
         Q7saerDpNrqADML26vvRrfVxQKjOGcKb8O17Hgqjgd1IJNnMJLacrUoFDNHB6YE3N8xR
         Qi2e7yPMZWg1SckDFK7ntlIDuP2QiZdudRINJR0KkTg9dNu3Q7TYFUJYqHvJY2wbAWIL
         6cPTqG3fpK6NwP9iP31ckOyTK8Lz76G6Tgeb1lhhJ48R2+tqZCD5AgXBIrj5ZuBbsB8R
         kP8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776196967; x=1776801767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9TjUnXkwrio/0RMOWx8bIqnkUDx9TXK82cA2FHqDPhg=;
        b=VuxlWIVTtAAZJCoS33G1toqeeEua8EAzPc+EqR7IwaQT13S4I1D3Jxwm203z0BjLzs
         TcPp/xKN9/qwk0IKGefmBo6gcnJ4QAXWwNaJtku/x6V+MATQFri4Q+uw+N/wttxKjNCV
         DcMZxzsL47a0fYnK3XT89IwRA10PTcNjuvxHY30OngYoFx4dKpvmBXKRqwkMtFJb/Hky
         lr+IkJwBuPKSEjm4AGwFllT/HCgqe0AdgsXbAeblblKWeQ/LsYin4dMKKA9xKxWWPy7E
         6MKjUIELzab23BFlOCs+rY/XhRFZAmCynY1KwD2OLTIqetjNXqmmvHYwooif8j8kDx1F
         1vSQ==
X-Forwarded-Encrypted: i=1; AFNElJ+uhlcwyWBmT8G1/kBIwgdKdpq/0zGR6u+c1ZbK/8IsZUJLsZHZyA2A9prL6lq7p+ae44edtA==@lists.infradead.org
X-Gm-Message-State: AOJu0YxDkF0KU3eHGwhuMkd4zkHOJLXTNvDqbc5fUv5Ydk7CMgGHRxF2
	BMEJDg4UTAJRfH+Pbls2ENCG97fG2cH2Xr96uX6nHQ9KvHFsYHK5HuRE47ib3+CPa2Q=
X-Gm-Gg: AeBDietwvEdk1bJ0eU5obBX4Hv41rdI+XafH5M7dIcIRbq2Y2EkD799c/EH70nAlVSP
	AhfyB2hFYneIWWdck3zdodabca+Kwv5+dFsxoWlPpivZvIEypFFwLFO8/RbnmiSh0Rv6QfNs2/e
	CLu+VGNoaisqE5kssc6iM+suE627IO4UOBrpC+1pL8tKkl0zewu7HZDZVoa+yKavS4jqv3jXTW5
	frR2uTXJgm1baoEn8VAFpSfjA5WeA0c2UVREAk8OLfioF6jjZbEpx5aiy+753DPAP7w6pHOhM2W
	hYY1lHX2lmOak7Xqdny+t9jcUGSWIdlVYas8LYncabXhFFqSuaSrvEKjjsLgHXbka/hsYG1QUdq
	2309PRXsT/ldXzlEJzvL3/s/kAH1dFTpB3hBVnN4aoTi1fXGfeaxtG5UjrRqcNSpuC07U3N3KTN
	h/hfali/RjFf87Nln2NVfRTKQ1gOLg+0694/F1v4ehu/wUIaUZiwEFcg2wD6N7yx/88fEVbOfOF
	SAF
X-Received: by 2002:a05:6102:2c16:b0:607:95f4:53b5 with SMTP id ada2fe7eead31-609fecbd99dmr8981083137.4.1776196967110;
        Tue, 14 Apr 2026 13:02:47 -0700 (PDT)
Received: from plex.localdomain ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ac84a180a2sm132213656d6.15.2026.04.14.13.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 13:02:46 -0700 (PDT)
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
Subject: [PATCH 5/5] selftests/liveupdate: Add stress-files kexec test
Date: Tue, 14 Apr 2026 20:02:37 +0000
Message-ID: <20260414200237.444170-6-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260414200237.444170-1-pasha.tatashin@soleen.com>
References: <20260414200237.444170-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260414_130248_522841_31298A67 
X-CRM114-Status: GOOD (  14.55  )
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

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 tools/testing/selftests/liveupdate/Makefile   |  1 +
 .../selftests/liveupdate/luo_stress_files.c   | 98 +++++++++++++++++++
 2 files changed, 99 insertions(+)
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
index 000000000000..6217122b92f4
--- /dev/null
+++ b/tools/testing/selftests/liveupdate/luo_stress_files.c
@@ -0,0 +1,98 @@
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
+	int session_fd;
+	int i;
+
+	ksft_print_msg("[STAGE 1] Increasing ulimit for open files...\n");
+	luo_ensure_nofile_limit(NUM_FILES + 10);
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
+
+		snprintf(data, sizeof(data), "file-data-%d", i);
+		if (restore_and_verify_memfd(session_fd, i, data) < 0)
+			fail_exit("restore_and_verify_memfd for index %d", i);
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
2.43.0


