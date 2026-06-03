Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53948CD6E57
	for <kexec@archiver.kernel.org>; Wed,  3 Jun 2026 15:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SdAegEf5u3em8MUzB4xyEunyt/xoJrJRQD9FIOINoRs=; b=KGZ0LAZdQJUxk/rjRXNme8VS5b
	VSLEItBZmLnoU7+Dj4bHkly5STmMq7i4Nj4tJaWW4mnPrOuMP9ok8MiBhrb/F2tjnHxroG4d0Qx00
	JKfxt/axZYK7S2D5exTo+PoD5QaPGzG/6Tb3iAM1iJlUrAv6sAWk7ZtIDbFQX0wGYPCP2tgALFQpE
	r0svDYxmiwl2jZ3NkZtdN5Lk5G7O6B7ZGZAP/TJpf2aEynSakMk6gCuI1xELcZcJ21QN61wLNfV8T
	5HhV22fM8SrI0zC1MItj9yt85sblncRSPMxwfOOkWpCTlRn968W3e23hjqMHvqHHW0r2JFkENoAE8
	gn/DQJvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUnnP-0000000FSGy-22JX;
	Wed, 03 Jun 2026 15:46:19 +0000
Received: from mail-qk1-x72b.google.com ([2607:f8b0:4864:20::72b])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUnnL-0000000FSFR-38bJ
	for kexec@lists.infradead.org;
	Wed, 03 Jun 2026 15:46:17 +0000
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-9157d3f2098so246493785a.3
        for <kexec@lists.infradead.org>; Wed, 03 Jun 2026 08:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1780501574; x=1781106374; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SdAegEf5u3em8MUzB4xyEunyt/xoJrJRQD9FIOINoRs=;
        b=HPmPegiBsLUaa0tOtHyMDbwJUyS6tsh1VQKgL4NxMDAICT/UHCXFdrRJ2BM6sG+O6z
         HvYzuHkKQBYGepWxL/etusH0TLfcywp7fbKRNLCNqx64WOkYklECAls2xM+1bUFmO+S9
         3lHZU99eQXmej82pa9mKKzGFU0nSnCz8UGWSSIPviFJ984KNth+0X8ZrML7EyWn/QEPH
         Wzm890nHulvLApHGL9hTbjnmi3pXoWwTtsDp5Vwe+31M7H5n4nFhM0C93hOIMKoKx7rB
         EDaJUzE3uDd/ypbZyA3NfwLrRSoY8aQK9xqzLOgo2eqXGWmwNEOEjapSz61ay205IrAs
         mn4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780501574; x=1781106374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SdAegEf5u3em8MUzB4xyEunyt/xoJrJRQD9FIOINoRs=;
        b=GK10Cw3BHwNNzaixbGB63WRl4OicDMk7AtJIsJzgo7mXeji3oSxZxlcVCZ8jr6GIHl
         /Nwn7Wt+StAPQYZJEr+Xqb5sDchWTnhl2bfEnNCTlRlmc8wnFo3jRzxwDquBnZyJeSeQ
         is8ufdMGiwgyGNDgrVpmcRiLFmxUuWhzkz+YEFqKs8YyBA39HqExEXVTmCr7dlqDtiMY
         rfdKCLeJek1ZhYiYezR+1aryKQuaHAr2tXCvoOvIwcRUJv7JuDRkM33Qsym9STpY4PZH
         3HhGzoh0+13KfAlRI23jsIvOsrMsPYyJk4/IIBuFH3kg3c+YcwX5DGrqcT9bzZIUk8RW
         0xyg==
X-Forwarded-Encrypted: i=1; AFNElJ92t7r1oDWpswjri5mpfpphqTgED2LwYPBBWWRcp8AzkeaLDT0WVTkgM7LDPxVvkq9h3/fufw==@lists.infradead.org
X-Gm-Message-State: AOJu0YzknbHMokciVfzkbZxgE1ux1OhK3JoDIU0S0I3G0x1btuH6MdCl
	LW+pafTGo/X8hrUV27IFxneb4hdqi0X1O5VdrTE8nS5UzKFqraVAZ1u2IOGfrozS+QE=
X-Gm-Gg: Acq92OFWs5zy15WF/w+HZkukgoIJI7f+sy5DrvuN+IK9VpzSeRaZTB9mH3QBeH1NwVo
	d25Arthzqy2SQcU93nADO+YQqpN4utX62gryGQehd4JnnGvXOkOOCLde/HrCHxAgxovKbvoWRhq
	hZtG43uw4WXfyN48ZGKB5v3qJ3AOW/KHo8trbTMhpBUy5mwVlcuw+Xzc2TC6Ab5QJLIl72uNzUx
	yTwCUsl4ScqrZD9XKKQ837Dk6HyH3Zx+wWEGxfTj4JRrnUjIVBPkzhqdGRbKeqq/JbnhJ7trMr8
	13gwPBQA8gYB10QRUszzXiI6WkWvxXybpWeaoGJQt3eDJTYZ+St5qmh3XwNzuKcoxUHi3joZfp/
	NHbFPJOs2qeVHU93atfeaLINEorYVDRydLTa96LMTPrVufD3VY9xERFsh95syDLVr4tLed9z9I/
	LkKyLktdH/RHy340/GRiCeAB38LIjOxw25DEE3+7kX1ZwxytN9xRRr2zd7z72goQ==
X-Received: by 2002:a05:620a:4708:b0:915:3be9:1160 with SMTP id af79cd13be357-9158a6bb43fmr659953785a.21.1780501574350;
        Wed, 03 Jun 2026 08:46:14 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a3bf5f9sm274596385a.35.2026.06.03.08.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 08:46:13 -0700 (PDT)
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
Subject: [PATCH v7 11/13] selftests/liveupdate: Test session and file limit removal
Date: Wed,  3 Jun 2026 15:44:00 +0000
Message-ID: <20260603154402.468928-12-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260603154402.468928-1-pasha.tatashin@soleen.com>
References: <20260603154402.468928-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260603_084615_858563_8F386BFC 
X-CRM114-Status: GOOD (  17.40  )
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

With the removal of static limits on the number of sessions and files per
session, the orchestrator now uses dynamic allocation.

Add new test cases to verify that the system can handle a large number of
sessions and files. These tests ensure that the dynamic block allocation
and reuse logic for session metadata and outgoing files work correctly
beyond the previous static limits.

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 .../testing/selftests/liveupdate/liveupdate.c | 75 +++++++++++++++++++
 .../selftests/liveupdate/luo_test_utils.c     | 24 ++++++
 .../selftests/liveupdate/luo_test_utils.h     |  2 +
 3 files changed, 101 insertions(+)

diff --git a/tools/testing/selftests/liveupdate/liveupdate.c b/tools/testing/selftests/liveupdate/liveupdate.c
index c7d94b9181e1..502fb3567e38 100644
--- a/tools/testing/selftests/liveupdate/liveupdate.c
+++ b/tools/testing/selftests/liveupdate/liveupdate.c
@@ -26,6 +26,7 @@
 
 #include <linux/liveupdate.h>
 
+#include "luo_test_utils.h"
 #include "../kselftest.h"
 #include "../kselftest_harness.h"
 
@@ -499,4 +500,78 @@ TEST_F(liveupdate_device, get_session_name_max_length)
 	ASSERT_EQ(close(session_fd), 0);
 }
 
+/*
+ * Test Case: Manage Many Sessions
+ *
+ * Verifies that a large number of sessions can be created and then
+ * destroyed during normal system operation. This specifically tests the
+ * dynamic block allocation and reuse logic for session metadata management
+ * without preserving any files.
+ */
+TEST_F(liveupdate_device, preserve_many_sessions)
+{
+#define MANY_SESSIONS 2000
+	int session_fds[MANY_SESSIONS];
+	int ret, i;
+
+	self->fd1 = open(LIVEUPDATE_DEV, O_RDWR);
+	if (self->fd1 < 0 && errno == ENOENT)
+		SKIP(return, "%s does not exist", LIVEUPDATE_DEV);
+	ASSERT_GE(self->fd1, 0);
+
+	ret = luo_ensure_nofile_limit(MANY_SESSIONS);
+	if (ret == -EPERM)
+		SKIP(return, "Insufficient privileges to set RLIMIT_NOFILE");
+	ASSERT_EQ(ret, 0);
+
+	for (i = 0; i < MANY_SESSIONS; i++) {
+		char name[64];
+
+		snprintf(name, sizeof(name), "many-session-%d", i);
+		session_fds[i] = create_session(self->fd1, name);
+		ASSERT_GE(session_fds[i], 0);
+	}
+
+	for (i = 0; i < MANY_SESSIONS; i++)
+		ASSERT_EQ(close(session_fds[i]), 0);
+}
+
+/*
+ * Test Case: Preserve Many Files
+ *
+ * Verifies that a large number of files can be preserved in a single session
+ * and then destroyed during normal system operation. This tests the dynamic
+ * block allocation and management for outgoing files.
+ */
+TEST_F(liveupdate_device, preserve_many_files)
+{
+#define MANY_FILES 500
+	int mem_fds[MANY_FILES];
+	int session_fd, ret, i;
+
+	self->fd1 = open(LIVEUPDATE_DEV, O_RDWR);
+	if (self->fd1 < 0 && errno == ENOENT)
+		SKIP(return, "%s does not exist", LIVEUPDATE_DEV);
+	ASSERT_GE(self->fd1, 0);
+
+	session_fd = create_session(self->fd1, "many-files-test");
+	ASSERT_GE(session_fd, 0);
+
+	ret = luo_ensure_nofile_limit(MANY_FILES + 10);
+	if (ret == -EPERM)
+		SKIP(return, "Insufficient privileges to set RLIMIT_NOFILE");
+	ASSERT_EQ(ret, 0);
+
+	for (i = 0; i < MANY_FILES; i++) {
+		mem_fds[i] = memfd_create("test-memfd", 0);
+		ASSERT_GE(mem_fds[i], 0);
+		ASSERT_EQ(preserve_fd(session_fd, mem_fds[i], i), 0);
+	}
+
+	for (i = 0; i < MANY_FILES; i++)
+		ASSERT_EQ(close(mem_fds[i]), 0);
+
+	ASSERT_EQ(close(session_fd), 0);
+}
+
 TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/liveupdate/luo_test_utils.c b/tools/testing/selftests/liveupdate/luo_test_utils.c
index 3c8721c505df..333a3530051b 100644
--- a/tools/testing/selftests/liveupdate/luo_test_utils.c
+++ b/tools/testing/selftests/liveupdate/luo_test_utils.c
@@ -17,6 +17,7 @@
 #include <sys/syscall.h>
 #include <sys/mman.h>
 #include <sys/types.h>
+#include <sys/resource.h>
 #include <sys/stat.h>
 #include <errno.h>
 #include <stdarg.h>
@@ -28,6 +29,29 @@ int luo_open_device(void)
 	return open(LUO_DEVICE, O_RDWR);
 }
 
+int luo_ensure_nofile_limit(long min_limit)
+{
+	struct rlimit hl;
+
+	/* Allow to extra files to be used by test itself */
+	min_limit += 32;
+
+	if (getrlimit(RLIMIT_NOFILE, &hl) < 0)
+		return -errno;
+
+	if (hl.rlim_cur >= min_limit)
+		return 0;
+
+	hl.rlim_cur = min_limit;
+	if (hl.rlim_cur > hl.rlim_max)
+		hl.rlim_max = hl.rlim_cur;
+
+	if (setrlimit(RLIMIT_NOFILE, &hl) < 0)
+		return -errno;
+
+	return 0;
+}
+
 int luo_create_session(int luo_fd, const char *name)
 {
 	struct liveupdate_ioctl_create_session arg = { .size = sizeof(arg) };
diff --git a/tools/testing/selftests/liveupdate/luo_test_utils.h b/tools/testing/selftests/liveupdate/luo_test_utils.h
index 90099bf49577..6a0d85386613 100644
--- a/tools/testing/selftests/liveupdate/luo_test_utils.h
+++ b/tools/testing/selftests/liveupdate/luo_test_utils.h
@@ -26,6 +26,8 @@ int luo_create_session(int luo_fd, const char *name);
 int luo_retrieve_session(int luo_fd, const char *name);
 int luo_session_finish(int session_fd);
 
+int luo_ensure_nofile_limit(long min_limit);
+
 int create_and_preserve_memfd(int session_fd, int token, const char *data);
 int restore_and_verify_memfd(int session_fd, int token, const char *expected_data);
 
-- 
2.53.0


