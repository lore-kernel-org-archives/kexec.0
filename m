Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65685CD5BD0
	for <kexec@archiver.kernel.org>; Sat, 30 May 2026 22:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zMNVhv3SnOTuZ3xqpMfMs2g7riJHPagItEAHtnUEWTI=; b=eGWvFXMAKkScFgir2vwCEevlvV
	NFNoWIJWfXRrk+EV/4rcr0gHKqR3Ae28kjsbGVUtJUW/UsKGAzzJnwrERkE2NfN2YYdrbj16q+Dhd
	fFBY7keK0EHhptvp0KfOW3T+Ai/hgQX9vTIi8Eg8xeTyudAd9D6QX22d8ucc+GFRYQC2jYdil9oqm
	ExwD8f1BGi0v4V1aSr/J5X782KD627Fkl7XzoiQQ3Eb/iMuZJ3Z4gwmrOG/wrb6KALBFAdPOUbJq1
	IJOv31lLu+r7gOlY7HT6FpGVpjns/kitoMKFv3imZJ3vdo1hKGQ1EufrHelQLdC4o616LVvc3U08N
	8/8TvJTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTS2J-0000000962M-27gZ;
	Sat, 30 May 2026 22:20:07 +0000
Received: from mail-qk1-x734.google.com ([2607:f8b0:4864:20::734])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTS2H-000000095xn-069u
	for kexec@lists.infradead.org;
	Sat, 30 May 2026 22:20:06 +0000
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-914bf8abeaeso706116185a.0
        for <kexec@lists.infradead.org>; Sat, 30 May 2026 15:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1780179604; x=1780784404; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zMNVhv3SnOTuZ3xqpMfMs2g7riJHPagItEAHtnUEWTI=;
        b=i9bOjbujeNOHpttv1HvHHDvU8kSMt/4N8FpB48z8V7PtdwzbYOQZ75KLU+UCXx8Dc0
         hvTjwFw9rQlzcOf/3R2yuGxdmRtnLbxK2+MJ30A9JRUjZv2zO2h+V32UyXGCzEfjWihF
         v9sANuTqE1iL6990NK7b2kuWfvoXxwK7Ux+FGsSpjf9OiMA2UB7uI26Wbii1fK2GEY0S
         x6o/YhhQPiGPnXi1jHo9gRglNaQsrwmNyXc2tb1xtS2GNBQb4FLMJsS1ADW//i1zt1d6
         qbFRuy6PDO1MBj/A/xPDjNNTY8BfnS6NTSOLmulVp990nxJ4+WfuEZQSjQTZ6+jmuGyb
         YOWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780179604; x=1780784404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zMNVhv3SnOTuZ3xqpMfMs2g7riJHPagItEAHtnUEWTI=;
        b=m1ejVgWA6vvZBtPEl9+AL5d/5eq37tRp4p408eCEfMObGptdYKu1sKbhvVLAMZ34dL
         QcGninfJ9/d/j+fe0yEVUslBgD/LoVSYo7ABksC1XiJTwtjLDwM4rSwsTAD80nkFROVm
         YMRXZ8sMIylU8g0oMh/fBR2xWwPYoAO4+2rH67F/9AWraz2XNXYn2vZZvPiBrkUrjm3L
         kh3x7y1igPmCcmn1eA3T6CgpilPdXsz+vd17PdU4P6MQEaAgkcow4IMyG1II7yrUJOSL
         0y0UsUbM6yzaW+4jWJmgbVGmZkkysHZ3Nk0xRlMYBH7DlMVwblFIobJmqvVVgvm5VnRD
         +v8Q==
X-Forwarded-Encrypted: i=1; AFNElJ+UfaYM+sDsrAFwSGbfSErPi01JNnv20vzpSyzO7l59glcYe4VSEzmX84tDo9/8vrpcs1s4QQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YzlEwwPErjpzQ1s50IAYioOv6ZUbakN/sG7tjps2ZH3TbhGVNYh
	bCFKXT9PZ0Az35FYy03dfl9spOCQLkKW/eUeQ4xcCgszpOMUuXrzLczm8slyGra32kk=
X-Gm-Gg: Acq92OFiEtA3QDSbyCi6wNPBDHiMDDaLsvM5lbMSCj+cerDBjMajAYCTAD2zkZPGIsv
	ETVZEJ6HetcO7mgWjTrfZXObnZNGrFHcQXicFqHMg/A38rB18LkmOlMsaoVFVP3V0pxvcsfwbHo
	WMA+7srjCe6uR8sDP9z/Vc6k3GNMjwpFMTUzWcbLI33/Q+8qmFaxtlIyAn7fM1BQv19r/M3BigV
	+TktnpURiihKkfTP3tYmI4US+ulXiw6NE+gAIhvL/8cSPJQAtsKpfgszV7VdLSJK/ZWsDMy2nf9
	C+zk/L8iYv7IOpqhXFoNwuVFfRzw+G8UUdQIAlZi+mUbtOZbgwsvwKhHXQKpXOCs/TjZCd0BxLj
	cHbBY4Dp5iFzzr+k0MC2vqg/Dzq1Qxj5zCci9okHJX9jJlia5zH0wvPjc57GfpPr6gRvyTIg2T6
	ZeyZEuUsRHRTgUJV5tlDqk01LScaqaP23IVeMb9/I4+nPNgeQM8LewvQ9hvHkUsA==
X-Received: by 2002:a05:620a:178e:b0:912:67ca:bac6 with SMTP id af79cd13be357-9153d98adc6mr770549985a.26.1780179603772;
        Sat, 30 May 2026 15:20:03 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-915324868a0sm651790085a.18.2026.05.30.15.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 15:20:03 -0700 (PDT)
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
Subject: [PATCH v4 12/13] selftests/liveupdate: Add stress-sessions kexec test
Date: Sat, 30 May 2026 22:19:37 +0000
Message-ID: <20260530221938.115978-13-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530221938.115978-1-pasha.tatashin@soleen.com>
References: <20260530221938.115978-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260530_152005_097078_BEE9669F 
X-CRM114-Status: GOOD (  16.67  )
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


