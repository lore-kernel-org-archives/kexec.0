Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94FA6CD6E55
	for <kexec@archiver.kernel.org>; Sat, 30 May 2026 22:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LZ44uuKaEudMkx03Nujcoh6Uuv+6Qpcd4aVYSw8wkq4=; b=YwQGfOPxReDHyVkpdwqPpHg9EW
	F8Dl1QpfnCYj0F92fpVBIrMYjIqxoa0f1wGM7w+7DHb8XIO7EOtjmNxW9u2Ns9FWWIEWp/kK5Barh
	0Ucc+UiiRtkif9tsVIF7nCgpNwUrLbPNbE08R0FKEzlXl/pRMISKT3EJ5pe86jw2hs39KbTMLWcqw
	0Mzg3/rtmnCjYYtgFHko23g4Z29W6jCGIlzYzLuNeAeNayqpFsXVh0hCUQ0EHWknLknXZNrQm9RkC
	iLZd1SqEp+UerikQ/cUFCzu0eSHSMyhkd5kJhHmJUz1AMhD9/U6CoaoUhQJxYF94xs6yKzDZfw8Wo
	SA1xwMnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTS2L-0000000965N-2mGI;
	Sat, 30 May 2026 22:20:09 +0000
Received: from mail-qk1-x736.google.com ([2607:f8b0:4864:20::736])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTS2I-0000000960R-3UjV
	for kexec@lists.infradead.org;
	Sat, 30 May 2026 22:20:08 +0000
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-914bfa75911so948821185a.1
        for <kexec@lists.infradead.org>; Sat, 30 May 2026 15:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1780179605; x=1780784405; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LZ44uuKaEudMkx03Nujcoh6Uuv+6Qpcd4aVYSw8wkq4=;
        b=HTkpdLdE9x9KZ0Mmz5fwGBM2Bsxz420kJeg4HJzSwTxyDlAp9VcMiTtXheh/NtSZRz
         4IweLDalSSZ8BrRuOxLjiyG6jT8qHVMHrS7mBwD5px2YR/LETm2AkODglJUvX36bbQvA
         f1G5UsqxYOQ0qf+XA3Wyp/QtylQq2SmsyhNSsyodDGtK+yDTN/MsWjCFWwcCpxQdfJt3
         Q+dmF7NXJyYiLWEQi/+aAUUIktD9dq3Hv/WinFcwGn8dYDIrmfjUEHp88w6A80MtTLHS
         XPimjy1z6XMuX8HntyAjpXglqCdAzP42YZNp+5DjaxK3zl4vKjyfTFB1bxlC7hAfSJhu
         ytbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780179605; x=1780784405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LZ44uuKaEudMkx03Nujcoh6Uuv+6Qpcd4aVYSw8wkq4=;
        b=SW9FBw8BYmuyWSk0I9CWEiAudpCVvQG370GJnWZpEVzfY/L5Av0dF1XLXwhFur6W7L
         d5SsRxsbatpfBb8UEgt9MclnMgbnyxc1q9G1BGgrag4LXbZGr7u2D9+7NK4/CghtuV46
         HZy09/9zwJYfzFfVrx2Un1mA+SJipXJOdccLUP3aVLyt+7xpj04b4ZTtrymAwY90F1d9
         GnkQuFVnBXZs3qe+cEXEnSICg+ngJvlVjfjjqAISJH5wnjv1DG8vFk747k1TlXecau/X
         EOo2wlOg6JavVBw/CMn+U4snZyhMmvcZSe4dHrM2zdAehO14ST4h1NXvHpERIKgCo3l/
         UlUw==
X-Forwarded-Encrypted: i=1; AFNElJ9M08aCf77TDvkO9z6bRUgkbcfIimdbAZap/4DACSTX4kdTmFI6jZ4s3B0PiouDyafXUib1sQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YxIk5nlX/ZUe3V/yiunXOj46rtOtjTFsOLzcOussHXXwzZNrSvY
	YGK17YKew8lNpc77Sn494IvS59CHYKOibcdJ8E141yv91rU3AgbI9uhfxY7nXJerm8k=
X-Gm-Gg: Acq92OG6UCbeuOhouJxpmz4d/IyPCcVxjG7PuYDHuYeuHUM9XAIgFAI2iF2aYQhJpUZ
	k3dpw793Q1YXfV4RBEjuI4WAjmVlGuTHvs51QRTXlOaBc/h+qRVji3QSjcsWnHF/VTtEbZue4VC
	no+JOWLdDtaJVc/X598DLNpdON0E0DLdrQO2FGeVEKMRWcYjpqALJeU2XgHurd7vs1KQ0Dozegu
	C5+dznwcFfMBALStitw179qVfK3yvqLSa8dSPKV5Drccmh2sVXy5bxyHtaSD8s8t8HC8rkKXfPA
	QUDr4m74Pjlx6tOASXSUo+mwcsZIzkufDO4WHft0+oL+sSX5hLTK7cXIvgufgAZXeuMRV192OZB
	DADSvEjuVe5/LrWUAbrH7zyXslqtpTWDfD6ZycyLd+v9k+Q0fegMlRiNejU4l2v2t1kwmaJSxlI
	FuGX18zafY4ersYfwfS3J0Yk4o+dXHoPHoFc/X5dRgt/NUSmHO6I10BDIbvSe0hw==
X-Received: by 2002:a05:620a:29d5:b0:90f:786c:4a82 with SMTP id af79cd13be357-9152fa29820mr1006065185a.39.1780179605586;
        Sat, 30 May 2026 15:20:05 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-915324868a0sm651790085a.18.2026.05.30.15.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 15:20:04 -0700 (PDT)
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
Subject: [PATCH v4 13/13] selftests/liveupdate: Add stress-files kexec test
Date: Sat, 30 May 2026 22:19:38 +0000
Message-ID: <20260530221938.115978-14-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530221938.115978-1-pasha.tatashin@soleen.com>
References: <20260530221938.115978-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260530_152006_900921_43CFA81D 
X-CRM114-Status: GOOD (  14.99  )
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


