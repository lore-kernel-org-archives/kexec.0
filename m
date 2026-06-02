Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCA57CD6E66
	for <kexec@archiver.kernel.org>; Tue,  2 Jun 2026 03:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LZ44uuKaEudMkx03Nujcoh6Uuv+6Qpcd4aVYSw8wkq4=; b=40NyscE9KL7Z0750TIINIGdEEP
	3puglhQF+Z7uAIQUaSZedOHxvQ7YuyDIwDP2fZWObXM4AmW41VoEBeyFQ553KW+XzJc1VFQjxdcBl
	yPAhGpw9uBn9X04vhHkSD59D1sfj/4FPTncCFQ3+MhLNVThwBoZ8ioVeGAtS8VnW1GcdRfk362SqG
	3gh4mmQO3zxP6Stali9JE+nMmhS/ehC54pOs/yUDX7BBzrn6abZZ4YZuVkh10x+wfVdEeqI9mnHeK
	7QiasRwxMbbELUsFd96Q41+xvEoDk57m5wrslbLRZZjSegbOpghuxSe+2E+uup+X0xKXYWW41AlQD
	la5T35WA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUFdS-0000000CDUs-25z1;
	Tue, 02 Jun 2026 03:17:46 +0000
Received: from mail-qt1-x829.google.com ([2607:f8b0:4864:20::829])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUFdK-0000000CDMg-3O8Y
	for kexec@lists.infradead.org;
	Tue, 02 Jun 2026 03:17:40 +0000
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-5174a133bc3so23485221cf.1
        for <kexec@lists.infradead.org>; Mon, 01 Jun 2026 20:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1780370258; x=1780975058; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LZ44uuKaEudMkx03Nujcoh6Uuv+6Qpcd4aVYSw8wkq4=;
        b=kwtYpzVxE0AiX4xrBNLd+pvWX4mZ3ghlYrKvVgxC9nUAXvoyym5yU40MFzWApQVyPA
         zdseN4kiKKZWE3DVLgQs8yakdzQYxV78Y/W2z1PJpZ6x6UL0Z7NggCcLH5PY3xsTtnGb
         8t2o/bR06Jc7pDXCvpdvlWCNqyUMEsqo2hLtq8d+I4hCn6SvNNE6C4oToX5O/5w/BZOo
         j4CL2Tej6j2iuL0NTnwdNf4O2LIQDQGVDC8ZvJqxqyE2zyVXI93bTpOaVMshduWTbi3W
         lcF4G+1lfInDGsbYeA9+RYXjvf7svf4t6KM5BwmpehWkpz0KfCS9rt0aZZMhT/mKIEmV
         uhYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780370258; x=1780975058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LZ44uuKaEudMkx03Nujcoh6Uuv+6Qpcd4aVYSw8wkq4=;
        b=jKVc9vtoZKc46OSYNJafBDxpRqRI7AKGb8jzZeM+TMrDQiKBB6n5I3Yj2kTI57Llcq
         udGEnqj+UNMsNhS1vTmA4qhylmNLiJUIFxO0Tfn6IVFJZj/buek6y1Cfv+iNxHDAd2bK
         wfGdLxd3v5N70ffFSFzYEXFT/Mr5T2hZij3CFbyRBUm5/FG7+kEV3n8PvEHePAMwAn9H
         YSx5z70iX1Ny0F9jhz73WB6BdSXuY6aobNV46VXu5iKYUkiYDUmNHvJvgntpGstxc9VO
         XRTwCg4BFErlpdkLzL4XemY5tbGLogIkQEvJko5pjkPgGWbT7vgTSfPrm5GGK6yjvpiR
         s6HQ==
X-Forwarded-Encrypted: i=1; AFNElJ9cZzL6U+M1swVHSEWE3RxMy6n2NO/qv8SMQkIxREEH6PwnydrcJtmPTn64FaVLeoSVruqwMQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx7CrG6+mVnKfbLUFLVPvCstgNTMCRflFZVV4o5zYwxSvJhj0VB
	/yV1kdfPowWomwSG5L5rU2/oJI/kwY28qEapTxvyv9cqR3V/oZCFM9g5PAu6AdEiQJg=
X-Gm-Gg: Acq92OHlxHPKoXigEPuiHkaUGO9knLK0R/iuUhxHDGQAUaVhHrqhgpwHikYubZ7yuw4
	YPf1lRb+8KzransJ1VHNuHV8FHSK7CsQQCR79+dcXa1JDkFz0zuf9lBgO7JiYcbhPXaFYykdQ+8
	y83W4QFLzifIKxvILOOmr5d77r5mUUCEeuM09I8s0a2wcRRBvgy/2Sm7e+nT4KfufJzfWCq4ZeU
	I44kWgc/Hkv8WDSLlmKaQxVWT3iEYIv8ECPb3CyGYdKa9Rki/wX1ipgjVtq6U3ngX+9zM87pkBM
	Zo4VUtg/ypSlPgwp1CPN17s0KxjlkftHWChmgHgjdyZ56/ZTKtSSktCX1LkqMV34dGDhGVLv/Zy
	Rexclr84r1Z4IRiftWW3wANuAktd6WRN9Fow3+D4hhxIUgRPv1BlU+pC8Whp9RPuhNNeXWpkJes
	oUcN4+MuoCMBEpoRlsEgGSZIKQQZULIl8fbXLSmPFO8QW6AhGw30WZ2fzXsVEkgVfAbzdL4R+9
X-Received: by 2002:a05:622a:1f9a:b0:516:d781:589a with SMTP id d75a77b69052e-5173a73b0aemr208229881cf.22.1780370257673;
        Mon, 01 Jun 2026 20:17:37 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51741b29745sm71219081cf.8.2026.06.01.20.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 20:17:37 -0700 (PDT)
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
Subject: [PATCH v5 13/13] selftests/liveupdate: Add stress-files kexec test
Date: Tue,  2 Jun 2026 03:17:17 +0000
Message-ID: <20260602031717.197696-14-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260602031717.197696-1-pasha.tatashin@soleen.com>
References: <20260602031717.197696-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260601_201738_854940_263C3751 
X-CRM114-Status: GOOD (  14.73  )
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


