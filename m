Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B0C0CD6E55
	for <kexec@archiver.kernel.org>; Wed,  3 Jun 2026 15:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=psMAwGaqe9xuyJY3Mn283ARVP/GQQXmgr+1HpWpGRKs=; b=VIhmK+3AVBH3Xu/S1xidrbRD/y
	csNPIN7fE5V82TWWNRkYmImyBRC6mV9Q31Z7XhljQaJM/3mOGITFs/UF2mdckXzqDoaxnK+miphNG
	PEwX6rmUWyBR5CXU4P0jLh1XTnh8NDKxwsLc/ahKNKcunvQ5Z02Nc2bPz3e/Tl9F5NgsFZlc5GzB4
	taTALq/tB4cKK6pMVB0E/D2SuCXg87vld7LrV7+OEmL0ge2Ze4/PkT6CComJMap76v7uZjdgNyQbs
	//w9KkMS8qXvr41/C3w7alBW5K6NNmu0me1wWLO3LM+coSddoipaJHjJaPlmaMlMxQ7jcOoh+FgHc
	UZwWdHXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUnna-0000000FSK2-2gia;
	Wed, 03 Jun 2026 15:46:30 +0000
Received: from mail-vs1-xe29.google.com ([2607:f8b0:4864:20::e29])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUnnX-0000000FSJ4-3G2l
	for kexec@lists.infradead.org;
	Wed, 03 Jun 2026 15:46:28 +0000
Received: by mail-vs1-xe29.google.com with SMTP id ada2fe7eead31-6cfdcc79789so1634398137.3
        for <kexec@lists.infradead.org>; Wed, 03 Jun 2026 08:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1780501586; x=1781106386; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=psMAwGaqe9xuyJY3Mn283ARVP/GQQXmgr+1HpWpGRKs=;
        b=MZqmEW5ytdbcQazx9ahSfpNj2TRF8GwAoWK0TQGHEch5BRGyhZXtZx8Xu0TvSLGzrZ
         je11UREeTlPQjXl3Xy4iswt0yh7aiMBYWCZBGUPEA0UuxdiOeBwTZwFI1xPPkn+oQIoW
         h+wKNc+Sqp2o2VlcFgumhnmG/vsezZbd+Q9vx8NLK0b9e+aM/JZ+YMQnfu16dVx2ft7j
         dk5HS89uJXha9g8865m/wBORCUpEAYNK9k8DV+ug9f6aDu6auR8ZcXhy5xnuW3aShbIg
         zYkZGLO/sLWrqN4XdplRur0v+f7NikXvw/hLugu63mLKiuX4QYqAJJb8TnJr0T/fwMA1
         h6zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780501586; x=1781106386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=psMAwGaqe9xuyJY3Mn283ARVP/GQQXmgr+1HpWpGRKs=;
        b=Dh1kkYvFuaG6kiwc6yqHV7GWfO9EeeKcFoXpNUii0J6bqZSCY3lZJPvI+ceUSpioo1
         PkFhXCraWr26TBhAdRWrhXrwTMmIM46sOGURCEiLj7Em1lfwSO8Y0Lh3QGESP3hDROTM
         +fX0yoILe9gw5gUf8+vInsOjb9x7hz9cLfbM2TxUL7xbKwF16z9JJgGGphMialJoPGpz
         onYubvHwjVw24Sq/l4oPcBOxuVwyt2RHIPEYRa4RpbaPyJCDJbNWEOqRDL0GFrlCfvbm
         ujdnFSwnA8CXiWwFHElY4vIl+mBfli4ellYloJm93bePLl3vTiwckC4VurEDdh/nFLcX
         TVOQ==
X-Forwarded-Encrypted: i=1; AFNElJ8L8Tzqz4B6OuAYh/Dd6JwAJaAo5sytJp/n4eK8KyV/ZuKDcjw9InhHDo1aN/DOPTX4zQciDA==@lists.infradead.org
X-Gm-Message-State: AOJu0YxIiyzi52qyvi4yNs/UsP6ZKrfLA+VayU+EJD7Bg/OwdLSptXAj
	77NvyFWCGn/eGym0+6Woa/1/xLkr7AB4zq/w8cDYVRCnbmUSZ7C+/K6IsdiIub6mlFQ=
X-Gm-Gg: Acq92OHhovxxJHA4qr6Wn/DP1yGtUr6kblrm4JqB6atWGvZn71HhSiWqBXkkbI+pCPL
	tanPeV/ePPTb4LUmM5ElRXyV2Sg5nyJtCdYcm54EWiKtxPhJjlZllpSqxSp9lCCtDfhVLOyPr7D
	U7hgfMgkBw4tXREglyz1wDajOW9YTmCggaSF89O/lghSDlMecRGLkOSrQ+rIELJ9aQLXWxPaKJD
	XubLkXPewrd86PDKOeYEgFifE01S/Crwaq1Q5BPOmojVDU6t6WLK4gtR+PDEn5GJf73IXV7gRGi
	Z6zWJDJEfOfd7t0XISkXKZF4qZxHqwQm0WJCcCAWTOFJzJT0QVG4XoPncwYC7KztaPmXQ5k0Dit
	trgoJvG4Hmrqvdw/4szHEAGYRju/q/Dhqvo0N69IQ49WrnnryiBbDxf40QE7GD+itZkuAYXV4Hd
	4KIBTeAgBjA18ocaZp8chF+ffFjPeh7/4peXML5fdSWZNivBmv+LC9PFDGV7vryg==
X-Received: by 2002:a05:6102:e0a:b0:631:2a80:e492 with SMTP id ada2fe7eead31-6ec4ce590b0mr2408029137.30.1780501586216;
        Wed, 03 Jun 2026 08:46:26 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd053032sm23998326d6.24.2026.06.03.08.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 08:46:25 -0700 (PDT)
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
Subject: [PATCH v7 12/13] selftests/liveupdate: Add stress-sessions kexec test
Date: Wed,  3 Jun 2026 15:44:01 +0000
Message-ID: <20260603154402.468928-13-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260603154402.468928-1-pasha.tatashin@soleen.com>
References: <20260603154402.468928-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260603_084627_820991_73DA0944 
X-CRM114-Status: GOOD (  16.44  )
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


