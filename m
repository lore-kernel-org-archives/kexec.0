Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96A46CD4F25
	for <kexec@archiver.kernel.org>; Thu, 14 May 2026 22:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZIrwM3YYxVlDXZ9UztplnfGrca1M/xZmJnShxYpBntg=; b=dCtFCqpHVrh3awo/KSqO84LDo5
	BC6hwA6ZsEapOoUCVC9Zc/QkrEoIyHNcNlt51fKKINT6+lQxXhnqLEbDii2++MIPM5pT8GeZ9t39f
	TvzO5cb3yOS9ZTvDKhAQHxkDptnzh4oXzKN1+fGJq+FL66WdYRP+85u0k2ZVLIYMkW56G3dN2nWvj
	q+IrqHBLyTi6mvhJ+HqYkYV6K73Elu8rFEv9C3dQADOcQi/25KtO03Iq/Z/HQ2C48J7u9Blg/nD9K
	FWWlY4pSvruo6wZ2NWcaj7wcLeRmqim0SJpQC7k8C0GGK4hBEXw7AHzlrtlU3lBgzH2az6UowOS2B
	xQ2JD3Lg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNeW4-00000006iUP-3Xde;
	Thu, 14 May 2026 22:26:52 +0000
Received: from mail-qk1-x731.google.com ([2607:f8b0:4864:20::731])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNeW2-00000006iQG-2d0w
	for kexec@lists.infradead.org;
	Thu, 14 May 2026 22:26:51 +0000
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-90fbf21d9d3so350101085a.1
        for <kexec@lists.infradead.org>; Thu, 14 May 2026 15:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1778797609; x=1779402409; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZIrwM3YYxVlDXZ9UztplnfGrca1M/xZmJnShxYpBntg=;
        b=D32SqqgOJro3fj7RO4KS0Q2mkTpm+iIlSVlI9Ccz6WFq+mKVVa5A7yPSdnfVl/HBCx
         XaUEug+P+8BB8YzlAWoq2DgRmJxlNbp2eoS4enRD9BoyDjYA1Bpn2DEYH26Xuc7QdKfd
         tSS2kQjy9NSyPEQ6GRI33zJGDaRULB5SQP3bRFVAgTOKD+HKS6GL4mmS0+SFcTbVtDRw
         Uga+pLsJJlMZQOZTjE4vyC7STiJGXJLKfEFI9bYm7u9UP0pn/ZyNIvgbuUdPhWTSk7x6
         xnHLRvmbewNOJqbAb9dKpG/KzIXrD7RuxV+lCMCWphu2ocXbuYHof94dpLBFr2ZDzGdl
         BstQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778797609; x=1779402409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZIrwM3YYxVlDXZ9UztplnfGrca1M/xZmJnShxYpBntg=;
        b=iydOgrc2bpBc9zu9Hj/hGZ/0kGGakVc+xnREMwh8Yn+9/sE9Vh+F8OOmFS+darUohv
         m2VR7HztNosrTd0VM+WwZwonMn5y2FM+sO088huDe8p+6rWug3V3+mEil9vINruhXiLl
         TXXCgksbfueP08rycTHMR3woNmqFKrpWdUsqk1DKVNutN+8SkikxJF1NJrp9A8I9L8v5
         jgKtKusxl0tBr9huqBMmGKrGApuYTN1bT+HOKVKNvycATbWSVtpRCz5tzgolmTcgterE
         Z2ccY93RgkfRvitoJXooqpAeamDcF3ZgMz8JvHH7uIeCQVNxZILxayZd6lAXR3ij/HWW
         A37w==
X-Forwarded-Encrypted: i=1; AFNElJ/19VpxXBq/+pTEz7ek65XOi1M4HtLjK/uscaxNIBIc6N+0berHLS0Vr8Jp2y5KNGCuAUOhgA==@lists.infradead.org
X-Gm-Message-State: AOJu0YxKzLFFeDQz5lp79x1YLAq6q+pzg1ZtbLlVxJPs7YHMKSDNSStz
	RAaKm0iDL1Jx62jGajdM2PTcSMiygPzBdn2IETe3IkIQa3+zqdfo6cXJYHN/9H3akw0=
X-Gm-Gg: Acq92OF5HtUV3UBTILwKc0TzAwPwEosQMAZch36oBnUhTJuWb69RGNY5yMZBI6fCpm3
	1lDMTRiuZcw08btHFcg5muhmMfDMl3XBuWtG2yIfFThIcQfNzGAtu4ZFvqW5wo1pECT9kISn1zp
	JKEcXD65Y12cCD8f9g3TtwKs3lkAbgkQIVq8PoEDD/FCYk32xG6krwvt1vbJbsLGB9FWYHHddsW
	OTmYznuuPNF4KYOzWyhF8c8MfvknD7JcJyjzjc2jwv0gFJIpIVi9jMIH3q7r2rigCsUVtu0anyB
	BPoRk6MBsaik4yA3ir4Fh83Pmzfm/zAOrZj/QvaK1qNkVM1dZZclz384Hsj2Xdk1gIuSpqtN6E2
	oKE6BaEBdssv9tkZCg8sfxSwf9/YL32zNqZHcBNwBpoCQB2kEyfPm2M21BVsc43aSNMT/2PVYy7
	uxRvlh9ycIqDfFLGCWTtuvPjwYt5vUfNdA9x5JfdFmYUudiO4iDYw=
X-Received: by 2002:a05:622a:2445:b0:4f1:ab79:fb18 with SMTP id d75a77b69052e-5165a03e931mr18328421cf.25.1778797609141;
        Thu, 14 May 2026 15:26:49 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516456ba92fsm28671901cf.9.2026.05.14.15.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 15:26:48 -0700 (PDT)
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
Subject: [PATCH v2 10/10] selftests/liveupdate: Add stress-files kexec test
Date: Thu, 14 May 2026 22:26:28 +0000
Message-ID: <20260514222628.931312-11-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260514222628.931312-1-pasha.tatashin@soleen.com>
References: <20260514222628.931312-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260514_152650_678287_86F28EE6 
X-CRM114-Status: GOOD (  14.86  )
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
Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>
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


