Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07365F9D0F6
	for <kexec@archiver.kernel.org>; Tue, 14 Apr 2026 20:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yCXGOxyW+pw6N8ft4rnwW7MuGB9g0PHpMRF3XlVYG+8=; b=DuhJR80cEfNf7MzXGuUU1LStz/
	e1cJ5XbV7dWffOmWsK/LGwHEpOnXBgUDss+666n5ImL+61t7Lp0VnCyQ6EUy3RQkoz3RMBkbQEkSt
	Ss/lNYsuFsZVuvwkGJavavpm2EBIlVHwd3uTkhufqsCC6LwrIvItdtAZsJAzLGesIvIaRarlBiyin
	HpjKqvdC2ZweJhZc/qgwGaMtlXfwdefVhxTjBXbtbMCECL8uCVFu42pl6zJwSe+yZ6smf3FOu5oHv
	3QsowZywiaMqvhyn2plR479SbnpzqRNvvOM3CDZHBjrd5Kw0a3vrHY65abT6D/oUhO2faPeEyzHql
	YTaQ7Uug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCjyC-00000000B4i-1p6t;
	Tue, 14 Apr 2026 20:02:48 +0000
Received: from mail-qv1-xf34.google.com ([2607:f8b0:4864:20::f34])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCjy9-00000000B2M-1hbj
	for kexec@lists.infradead.org;
	Tue, 14 Apr 2026 20:02:46 +0000
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-8acb550db18so22200916d6.3
        for <kexec@lists.infradead.org>; Tue, 14 Apr 2026 13:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1776196964; x=1776801764; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yCXGOxyW+pw6N8ft4rnwW7MuGB9g0PHpMRF3XlVYG+8=;
        b=MrrZinr0E3AYhx5tEGbUZvX5paqSVAChlPyzxeMPn+k8cGnpmhjKUHTMgNj5IlB3Yt
         bADN8iRKGi1grFFDjVyPhcDoA8j5AgB9ifRG8NpHSwcqqrublRmtcHVA9lRIuijxhpBQ
         xddJ8oKddUI+XIMPDMz7zQYxjzjnGqewnrOknEdDQhAvUok1E59+hOpWhm3QDcBFDScM
         xqwhETqdfH0DeWHWLeLy+tbDQ1xTgW+Tye1AqaoUzNLphV8GItyUmY+QotOPYPQRWvex
         Z1wnUzIG/5qIB/yrZHLwbEixs2gvl+2pdG39PFnak0wiZCHyS6tPNLVdtWGqwDJeuWv8
         mikA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776196964; x=1776801764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yCXGOxyW+pw6N8ft4rnwW7MuGB9g0PHpMRF3XlVYG+8=;
        b=i7Evf5hWxai+VS4Cwhi0pkKNQuY7v7g6q/33Se/WJRvEYmpAdxkWOBskbVHiTsvccf
         DO06Ocfc7wq1qIIoEoEPYt6vVxYp1UF30oTVgnGDfjTqVtMng6+VQBa4ZMOGkeXkuXa9
         t93QKKD8qYKrIYSTogLQ/JMfcjSWP9qNRMkWyBomPGlQefB7dsF4PJgfoEicwO6v8KPZ
         7dhSv5L1FTGKI3RlWUziGhe+LtbdPESH7O16xEnYG7Db1sHayTg425mi79YqBCt1SD7l
         GLS5qiEXwVZjvgMRKCbr9G6SEvWYHOTkQkxHml5i2VXxa8057yJ69EqwkEjAv8/tTb3L
         izVA==
X-Forwarded-Encrypted: i=1; AFNElJ9tw3zuI6z0D99vnLYhovwQ1iIMRJGR7nr1zPsKMlL4Nbii63fO/7ob8Vt17TRwfyVHZrVkwg==@lists.infradead.org
X-Gm-Message-State: AOJu0YybqE9Q9Za/PlaY1ZJUhgtBiqKp0miiRVQabarceTJlpxzTlkmW
	muCqxP2ERLxhl68aZdlKBuQX30RMTnBOLKfmYYAfgDYAsKspNjD1OxzHZsZGgEwTcBU=
X-Gm-Gg: AeBDietH5J9u7HEyJ8A2WzSnggOCobX4ZtwM2CjRpHbEdXGmkFXW34E44/djPJ6abW9
	KEmnvgl0Ie6Tm74WlGl1VoJdJu594xakM9MGz11HKPfR0pZlztGbRMLDSUEUaoTPX9aAJftCkiw
	rrdHcrDaImd9RFop1ypDDE/PZCIo8hMDxU7lArn4tNB4MAy3KIjLf2ixzV0zRCELntXtVeQexcQ
	+aCdAQH/ydeN/HYqOOxUAX7rzV68f7J7ffJnKTJIraI+FyKnU5mA4Ia9JNm0V1E7kTrS+99CdBz
	Nju456RZzFbOSV/zEbnp9l7BoNS5mwRhxiu4Py2deNrGapqcUWx0tXoLMyfg4fx217A0hLbGvpD
	Ip+aiC0Hr68Kp90Y8dnxG785lFYmaIm36NYdQyRNg1ujULnsUeQV3HsX9ReXM0XCJwUy32oUFIJ
	7CKGGS8YJSZ7smg/HCYczV7Ju1TdNfYcq7ES8GPfpyxJt7CXxbzBzo92y++/HW44kynw==
X-Received: by 2002:a05:6214:f24:b0:89c:4cb3:4ea1 with SMTP id 6a1803df08f44-8ac861ef1bdmr302331696d6.20.1776196964120;
        Tue, 14 Apr 2026 13:02:44 -0700 (PDT)
Received: from plex.localdomain ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ac84a180a2sm132213656d6.15.2026.04.14.13.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 13:02:43 -0700 (PDT)
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
Subject: [PATCH 3/5] selftests/liveupdate: Test session and file limit removal
Date: Tue, 14 Apr 2026 20:02:35 +0000
Message-ID: <20260414200237.444170-4-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260414200237.444170-1-pasha.tatashin@soleen.com>
References: <20260414200237.444170-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260414_130245_515171_513F3874 
X-CRM114-Status: GOOD (  15.51  )
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

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 .../testing/selftests/liveupdate/liveupdate.c | 99 +++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/tools/testing/selftests/liveupdate/liveupdate.c b/tools/testing/selftests/liveupdate/liveupdate.c
index 37c808fbe1e9..0eaf97b19267 100644
--- a/tools/testing/selftests/liveupdate/liveupdate.c
+++ b/tools/testing/selftests/liveupdate/liveupdate.c
@@ -22,6 +22,7 @@
 #include <fcntl.h>
 #include <string.h>
 #include <sys/ioctl.h>
+#include <sys/resource.h>
 #include <unistd.h>
 
 #include <linux/liveupdate.h>
@@ -386,4 +387,102 @@ TEST_F(liveupdate_device, prevent_double_preservation)
 	ASSERT_EQ(close(session_fd2), 0);
 }
 
+static void ensure_nofile_limit(struct __test_metadata *_metadata,
+				long min_limit)
+{
+	struct rlimit hl;
+
+	if (getrlimit(RLIMIT_NOFILE, &hl) < 0)
+		ksft_exit_fail_msg("getrlimit failed: %s\n", strerror(errno));
+
+	if (hl.rlim_cur >= min_limit)
+		return;
+
+	hl.rlim_cur = min_limit;
+	if (hl.rlim_cur > hl.rlim_max)
+		hl.rlim_max = hl.rlim_cur;
+
+	if (setrlimit(RLIMIT_NOFILE, &hl) < 0) {
+		if (errno == EPERM) {
+			SKIP(return, "Insufficient privileges to set RLIMIT_NOFILE to %ld",
+			     hl.rlim_cur);
+		}
+		ksft_exit_fail_msg("setrlimit to %ld failed: %s\n",
+				   hl.rlim_cur, strerror(errno));
+	}
+}
+
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
+	int i;
+
+	self->fd1 = open(LIVEUPDATE_DEV, O_RDWR);
+	if (self->fd1 < 0 && errno == ENOENT)
+		SKIP(return, "%s does not exist", LIVEUPDATE_DEV);
+	ASSERT_GE(self->fd1, 0);
+
+	ensure_nofile_limit(_metadata, MANY_SESSIONS + 10);
+	if (_metadata->exit_code == KSFT_SKIP)
+		return;
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
+	int session_fd;
+	int i;
+
+	self->fd1 = open(LIVEUPDATE_DEV, O_RDWR);
+	if (self->fd1 < 0 && errno == ENOENT)
+		SKIP(return, "%s does not exist", LIVEUPDATE_DEV);
+	ASSERT_GE(self->fd1, 0);
+
+	session_fd = create_session(self->fd1, "many-files-test");
+	ASSERT_GE(session_fd, 0);
+
+	ensure_nofile_limit(_metadata, MANY_FILES + 10);
+	if (_metadata->exit_code == KSFT_SKIP)
+		return;
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
-- 
2.43.0


