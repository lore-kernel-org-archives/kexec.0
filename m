Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C993CD6E52
	for <kexec@archiver.kernel.org>; Sat, 30 May 2026 22:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l/PRPWvWF9f7qW0XjjBpwGc/NadY8LWCtXHDn2RYoSI=; b=Vjezwu1EJE1ASxjw4jvUNPIODu
	8iPb3CHc3m5uzGNvoFt/OGQBGBERO/+HztTeyhKoQNlxedKWx3ThzC9rpa+ywEU8Jx0QOutL9d59l
	heI/xOedKsLhaACCNSMRzBlCHnGtD8UaX+lqxIDh1C60LK0HVIOdW0G67ZG31sm94qG3Lx7ijRa1c
	MjkxRkwTPcnqE5OvK4yZEOntof0Q9aSIFAzyuKixHoPiqLzQBSicewsShWGsXuzOucsiV2z7PhiaX
	ZkU5eaLcOgnwfOKpO8RW68CksjeP5QUwH7c3+6FhdEZ9dRfJfKaUPCoIR89wijvraqCdSQLboFnIB
	Dkv23gvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTS2J-0000000962A-1Gzb;
	Sat, 30 May 2026 22:20:07 +0000
Received: from mail-qk1-x735.google.com ([2607:f8b0:4864:20::735])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTS2F-000000095v9-0Xzy
	for kexec@lists.infradead.org;
	Sat, 30 May 2026 22:20:04 +0000
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-914ad42e617so1038404585a.2
        for <kexec@lists.infradead.org>; Sat, 30 May 2026 15:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1780179602; x=1780784402; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l/PRPWvWF9f7qW0XjjBpwGc/NadY8LWCtXHDn2RYoSI=;
        b=k5sXGrD6Q6e6l47Fa1C41W2ANpoXkn/snZL9QybCKhgqmuVNA6ocE6zC5Ere3c99Ah
         PWTo629ip+EYDMIUOzA6PVhZuUs7bt17SvX3T/SsV7MUYRAJ8xSzOpDNr3rDNvZkZdPS
         y1DTdfHcVcQBq+oGlyg2+W5P6pncaS0GKCPjhSWUn0BjC416eMJMgj6BHDVL/iOxejai
         ogVmFlqLSHeDWw+2+3VqMmVar9TZJp4BkdA3ZNeNg1meFUVkvIpMMX+cPcllQC8vVY2S
         0UeVA2bMjF2qByYUz3FSRMCWYMlQjVofIVZINlG8Ns0yum62KKDxhLt4xAphgmtPD1/O
         8Lhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780179602; x=1780784402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=l/PRPWvWF9f7qW0XjjBpwGc/NadY8LWCtXHDn2RYoSI=;
        b=K0PcECVw4u2ZnbI+77WUSDiLiSROkJ8V9k3yogYL6+IcEIw0zkts429kc9XyFH+F8P
         lU4YICHK7FQez2F+10TVlxHkiKWWCDsCz/LB5yQwCoMN1FisQA5TKgkMI0mWqDBkXkXF
         quAzx61L5aH9HIgTxCmkX/6DtGcvx0Sm/lRxXTVpDpS5Dd5Xan/nlBVBsJUC+xo/P2QN
         po7KyHk138wvhM25mU+nwDl6gxVv9mfJsxM9x1nMrIdxbRLgLZ9daBqDaBnSq+CGVROR
         a+YUCTKrVSLQs8CKz4SsnvnfZaHA/qrfDHWEgYm1jfWXw35NY4Hc4YjESUGRxeNQ9D3m
         wRog==
X-Forwarded-Encrypted: i=1; AFNElJ8+Zw8qtzN/iTjB/joYkKakzPO+SBWPSR7VpyOX0c4SQiCoZg8dZxTLDDvXpnKyNS2SLOqERw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw+Sx9ZVR8pIgUyixOL3I2YaXpz2RR7WxzwS1UcnWm3qVv7zeBq
	74DHCwyJx5VFvl15YeAojgzzasKUvmbMcTpp1Vl5WSTxjILLLnHKIp9zNN9fQjElNrs=
X-Gm-Gg: Acq92OFUy3REEx8vuSXGpaTzgiGId4x+2k2rbL4bIP9CV+84Bfh2xn3eXxLoCrs/Hnn
	K7Mu7gVJ4xXjDGYfxQtGEJk1qTy08IhbtszqVyHB/Cn9o2tZQ8SBP4eOgzzC3NVpDB6Wl5t+I8Z
	hv5l1Z9Tms3ISW9ALaKISjqint74O2EQRktD+ffmdDpms2iIxyYUcgyVmKWfNHoWNRSsGDLglGi
	Ol82FJnLVrQXJnsYBmYqKyZtHEyAUnqPHKTDYtiovnVDqI0XjhC7ceHpRZ79lEyy5Iq7RIgvKyV
	pnvj6PXwJ6vqTIMQJyDZQWF+uaV7UEhZg198YL2V3PWkDo6jhRGKJ0805DPyVBORCcYSOmXrB/H
	50J5+qtd/fslSUFvzn5BdOWf4S6loUq5fig1Xsvk8MKoEz3AdVDw/IElXhTASIUdpcYz/vygZXL
	tDqNFbtvWOq3Slb6sScV0MR6QrqEzRL8eamvV8RMujwP1pX9t3ez+fzF/FYDGhmCA6Q7iyAK77
X-Received: by 2002:a05:620a:648d:b0:914:db82:f791 with SMTP id af79cd13be357-9153dc29a52mr727746685a.49.1780179601868;
        Sat, 30 May 2026 15:20:01 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-915324868a0sm651790085a.18.2026.05.30.15.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 15:20:01 -0700 (PDT)
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
Subject: [PATCH v4 11/13] selftests/liveupdate: Test session and file limit removal
Date: Sat, 30 May 2026 22:19:36 +0000
Message-ID: <20260530221938.115978-12-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530221938.115978-1-pasha.tatashin@soleen.com>
References: <20260530221938.115978-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260530_152003_653827_9B5EA02E 
X-CRM114-Status: GOOD (  17.50  )
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


