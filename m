Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDC6BCD6E4C
	for <kexec@archiver.kernel.org>; Fri, 29 May 2026 03:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DD7mpkHwGkKw+XnhrMPNwFwDdntpab6EeONlinrdH5M=; b=DLfD8OubTIKyzIWrzW8WZyZrm/
	yQy+vKDE1OR1I4aZSoYGky4q1kG81c97gAU8ZPMyxqcBsKiz7uoYbjrrnJuX21KvpvBL4jqVzIhDn
	Po46AnKCzPBtozV0NFqJHJZmJ6Q1eWhs0A2V57d/o/mKCXi6XRr40WEp6Av8QpLUdhgq9gz4eyyN1
	jFPduf+02JC+0b2uJP5vm6LrNWhDSEP/RBkbu4DddpFM5BHlRpKlNM2hKpZ9TEZlVUpYZAUK4Vrq7
	dIECRXpBOgZsnVtVUUnX7P4UvpEiRgw8CxZFBWjU9JboCDbC+8h4SZuiuf3h9EWfPbQbUyEJ8U2o2
	wdTO388Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSnmr-00000006geM-1mLU;
	Fri, 29 May 2026 03:21:29 +0000
Received: from mail-qk1-x72b.google.com ([2607:f8b0:4864:20::72b])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSnmn-00000006ga3-0ZFb
	for kexec@lists.infradead.org;
	Fri, 29 May 2026 03:21:28 +0000
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-914ae4101b4so957973285a.2
        for <kexec@lists.infradead.org>; Thu, 28 May 2026 20:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1780024884; x=1780629684; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DD7mpkHwGkKw+XnhrMPNwFwDdntpab6EeONlinrdH5M=;
        b=glymwe+Y/O051jWEGsSPza6jcqvoddBIyeLyX1V5Uh+fCx+kxm9g9ImdQPa1rRgdoV
         tjpALLy9pqBWD14nTVll3qgj/AlpieKrgPBrTYCHy2CWWQyD3LjicLXyvRxgHNxGOZMQ
         WeQv5nBdtUOe5/3dEUj2FyNbODpQ6bT93yKk1TW4rJx6t5gtUg0CzXpEqRegQhJgU0Wn
         7HlrPkqtHPtdaSk4rP6HWcGX2/Tva6yGrwaABkVyqyCuQeZVWyaFGMB3XqrJkFRvsvVd
         E98zykKfKIMf2C/8Wo4drQfZPxWtrnFr8B1AVP/oDZQzUVg0vL9k9N7XmfrTs3Z2H7cZ
         RdgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780024884; x=1780629684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DD7mpkHwGkKw+XnhrMPNwFwDdntpab6EeONlinrdH5M=;
        b=q97woRk1Sl1JN+z7+4yqC5IadMxYlCDp9RlTGs2338yAUW7Z7kBUIkR8p6B9owBfbZ
         5Pbj5iv7TFKKwodoZ3BdAw4ECUZF+kKQ+c2H7Pkvf9rcKTNWszP8ch37wbpSiTgbSS7C
         gVGCjUVvbPAwhvRjaPIpRRC7QPQ+AB+7AGkCbw6vw/KXUSejokhf0nVWnZrqCeMcdjiz
         NhC+IP7kCzUOtigBdx2a3Q6ys4/UjSOEB7sU6SzxuXC2rVwPe5IMrhiVYd/nJGPcrrfP
         3GOG6Hh0o47Ss9w1B8a064dG0VDDPKipjh5w3GFr7dbmX1zdZtpqVFT//zrwWcs/Iyo+
         sodQ==
X-Forwarded-Encrypted: i=1; AFNElJ9AEAIAXvN/MaOIDokwiEz/5Dx5blSJmDTjiXCNeGFxGxD2cP6z/Oo9/UiKyfH5cmz+yLKLfw==@lists.infradead.org
X-Gm-Message-State: AOJu0YyMvgO+OXeeHW9Zdg1aocixqRvhYz+lU7Cg1tPEXBgptYQzu6Uz
	L9t8p3wXcAaEqk5/cADuBaofTvTqZUnv9Bz70l42uoeFPIAgpgmKYWk1L7mQH4ciwis=
X-Gm-Gg: Acq92OEyC0+L1iUHndZXH8Km8+iqap4nOriJ63G+kEheh4HeqT35biHgtcGZI1/wVgp
	UAsP/KdBteUIUUN9uXNXQjL+qvNZf4BLDNi4SeZgVq2Y8Yi9Maj/GkoGclFfEU3+35XLKjXPKN/
	BJNd4qYEzNFxxZf/gDUdzLDsc9948W3yrozR6aa4EXWAMlACTmfqoi9MnFNb3JanKU8zdvT2ZwX
	/9kLevsW6pIviefenIa2GXP1h9Z5rokURE90PyUQycDKaSpjmekVIwvfV5HP+QLpy/9Li39HmES
	pLzanxdM5FhOOnZi30YYO1vnet9ICYTZ5cbT0Xr+KTw14BGG8amorrz6rXEL2r1UW3nPfG0a8Ex
	cIiQXAtia5MbGwu2Vd0k9X+5XLEXRXdqvvsz4CnI4eItwn2HRuDj6mwYvkvtkV7Ay5ds/lnIc5H
	yd7zBA3/YVBP4XjlTDJSO+fHwjFewdBHtqli9sZY+mAr/rpp2u15h+Qieug1h+nQ==
X-Received: by 2002:a05:620a:4709:b0:914:bb8e:915b with SMTP id af79cd13be357-9152fd2fc49mr147943985a.21.1780024883867;
        Thu, 28 May 2026 20:21:23 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ccea26d286sm1179476d6.48.2026.05.28.20.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 20:21:22 -0700 (PDT)
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
Subject: [PATCH v3 11/11] selftests/liveupdate: Add stress-files kexec test
Date: Fri, 29 May 2026 03:21:06 +0000
Message-ID: <20260529032106.1505796-12-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529032106.1505796-1-pasha.tatashin@soleen.com>
References: <20260529032106.1505796-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260528_202125_185135_35C13D8B 
X-CRM114-Status: GOOD (  15.36  )
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
 tools/testing/selftests/liveupdate/Makefile   |   1 +
 .../selftests/liveupdate/luo_stress_files.c   | 101 ++++++++++++++++++
 2 files changed, 102 insertions(+)
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
index 000000000000..b6a0c3899890
--- /dev/null
+++ b/tools/testing/selftests/liveupdate/luo_stress_files.c
@@ -0,0 +1,101 @@
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
+	int session_fd, ret, i;
+
+	ksft_print_msg("[STAGE 1] Increasing ulimit for open files...\n");
+	ret = luo_ensure_nofile_limit(NUM_FILES);
+	if (ret == -EPERM)
+		ksft_exit_skip("Insufficient privileges to set RLIMIT_NOFILE\n");
+	if (ret < 0)
+		ksft_exit_fail_msg("luo_ensure_nofile_limit failed: %s\n", strerror(-ret));
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
2.53.0


