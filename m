Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 417E3CC6B3B
	for <kexec@archiver.kernel.org>; Thu, 15 Oct 2026 09:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QvPtbhrFSm5FoNNWvwj4y3Q4nd03scqDRxnUx7itX/Q=; b=EXCa8DkBzhJ5ZXj7Rs+vGRzWBT
	Gg+kTwYc2FnApH7zH2A0fWo8NBv42dv3DIZS2yG1KbRzUlwqCg1YcilVzebDZE3MjONsXUUpximMC
	gY+PDI9l7z7vTYqo64DaHHbN1qDDLbQ7BVABrInYfmZwFprhp3Vt+0ydK0gVhx+8AWBBMeHazM15o
	5+5JA5gTmsOMXVuX8zUA8Z4iSq3+Nl6Ps0PeWXrebmXPTsS1UEazrhRprxMijWwunDS8vyO9cMj8v
	0u2SpauwfCeeMIXNVMg8++SjFhNUvkUl2JYoPzEY0yX1gIejQgsu/fzsmav6kCXiVLEmbQQPsh+9E
	pGTXJlyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHHuv-0000000HHyy-1ThX;
	Thu, 15 Oct 2026 09:38:29 +0000
Received: from mail-ua1-f49.google.com ([209.85.222.49])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHHut-0000000HHy1-0K0A
	for kexec@lists.infradead.org;
	Thu, 15 Oct 2026 09:38:28 +0000
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-9906034086cso539931241.1
        for <kexec@lists.infradead.org>; Thu, 15 Oct 2026 02:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792057105; x=1792661905; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=QvPtbhrFSm5FoNNWvwj4y3Q4nd03scqDRxnUx7itX/Q=;
        b=T6g3XSyutjyXKSUIf1sU3vXW4ac+zr3GOwhoiwNpXj0ETYNLskp+QztqgK3nf6J4d8
         djbSpOaazF/civha6gTSjXgtZn4iAZYGw6ld4RjZGCOFU4gNwXXNse2lgD8YQL5ffk56
         Gd35cVBDqQo7aWL66C9tGEwSGkdKM2vQpavnkVMGfok/lkStNBtNUL54nvNRdhuv9idg
         1gMXO6+C0e7mj6UH9vcS7QbElB3YTuWuueQlMSsAzGd5/29Olf+JPVdC7pZmshuAliMk
         JHc1/7aJmCUFJDruMT1Xesuz/fE65RxDC8cqxvT3DJIefUQkl2VbYxsFEoo2XrN//rz6
         fjKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792057105; x=1792661905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=QvPtbhrFSm5FoNNWvwj4y3Q4nd03scqDRxnUx7itX/Q=;
        b=SzEnCjMTw7tglYsp5qXMD3J1c4WzkEwSaFZedJVPe/FUMmdKWgmBPXsd4F08oG5d5b
         3bkpEl76LM1okE0wE9jrWoMuAOFKHn/f/bYuRbpgB3AvDbUkaMlbnsaFKrWnnprK8wUW
         GSXQKkM9nf8M4gw2nqGefjlq2E9CAdsgU9B2z1efU5Mgoo27bmWgM3u8rUw/SlzsI0l+
         n1mCCcQPL0P3eIDsLp7m2SMeu+b8NtmIJufDLz0KasqDGAo9aGzANJ72cYw6VeccTZgp
         ydwV8t2NTmi6oTnpCbjwo4h4nwJBiqfdhdtEzt7BUB1d0ZLSebtPWwGCQU0yF4I9dsCn
         97hg==
X-Forwarded-Encrypted: i=1; AKwUvBxn22wmLmUwmd+RUpi1pD52RRm2sFDQ14OR26/9YrSKSh1tMaiHx9xiI7+p4ayi36w014TjgA==@lists.infradead.org
X-Gm-Message-State: AFq9FYJTa8Br8BLucTDb7oKEeLFmV5sPEFvwJahD9s9j73Fe0W49026O
	0OVqM8VXIi0a4OCKPAHaoYswd58L1zR0UaGUQCR80HczDfqZsT66iw9kqdapZO1XDDw=
X-Gm-Gg: AYBFou1B3yPZd4r08pNAua46NTTKFRrHM6QsaZQgesXRdrUaRZhSw8ZXt8Hd9Cu5Ync
	/Kff0FWAePtz7sBRXNtsBpLWJefhmQZINCAnXURCd34IRlUHXr6B2fgA21Xss0MSmUFr3n2ZrIV
	tp9C2H41lpgH3SJekmZyV6HAMTlUrqL6M0VuT+tqN2Co9iZNkPyFlVmUuhZBOh3gbK0fRuqS1fU
	5rWQB4ymvpQm2s3olPIsTFvJvw/j9Bvr/Z/Q+xAj9qqNpRfmITz56PeW8Vj6AqMNCfzWITnBc01
	2nJ4HpD1d4j/e7yD2DKcjcDjyJ1215iE0Ontq/xYrxWcvceqHP8rZn7nwyuJThpQyRVLg2jAwwu
	2Hjb+qZL8fXW8xvU3yujxHeTxulLOcapK6Z8Z+sF1nzYGEgQ4bdmEPG29/qLQSXyR/aT3UNlmja
	oXgCtaHxcEu39je3BKcb/yX8tOzG/PeYCiHkJ1PvQpk5uAJjmS1aXStlrCjIJMXq8q7A8HlEdMy
	Wy+FEzCi0XpccLEiGuVAjNa6sKKHbWR/DmarMBEWUSZ2zT8Ibg9BrS6gQygaHb6ov79JwVBKZ5I
	pIgvkdmSqsPMmn4LrgyFioQpv/vW3GM=
X-Received: by 2002:a05:6102:c07:b0:7c3:873c:b3fa with SMTP id ada2fe7eead31-7cb36885ff2mr3914174137.4.1792057105254;
        Thu, 15 Oct 2026 02:38:25 -0700 (PDT)
Received: from soleen.c.googlers.com.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99003d37009sm12275672241.2.2026.10.15.02.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 02:38:24 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: linux-kselftest@vger.kernel.org,
	rppt@kernel.org,
	shuah@kernel.org,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	vipinsh@google.com,
	linux-kernel@vger.kernel.org,
	pasha.tatashin@soleen.com,
	dmatlack@google.com,
	kexec@lists.infradead.org,
	pratyush@kernel.org,
	graf@amazon.com
Subject: [PATCH v1 2/7] selftests: liveupdate: Add tests for LIVEUPDATE_SESSION_FREEZE
Date: Thu, 15 Oct 2026 05:38:11 -0400
Message-ID: <20261015093816.2438942-3-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
In-Reply-To: <20261015093816.2438942-1-pasha.tatashin@soleen.com>
References: <20261015093816.2438942-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261015_023827_130496_4A98C5B9 
X-CRM114-Status: GOOD (  14.26  )
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

Provide luo_session_freeze() in the liveupdate test library and add unit
tests in liveupdate.c covering the LIVEUPDATE_SESSION_FREEZE ioctl. The
tests verify that an outgoing session with preserved files can be frozen
early, that freezing an already frozen session returns -EBUSY, and that
attempting to preserve an additional file descriptor into a frozen session
fails with -EBUSY.

Also freeze the test session early in luo_kexec_simple.c to exercise
LIVEUPDATE_SESSION_FREEZE across a kexec reboot.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 .../liveupdate/lib/include/libliveupdate.h    |  1 +
 .../selftests/liveupdate/lib/lu_utils.c       | 10 +++++
 .../testing/selftests/liveupdate/liveupdate.c | 40 +++++++++++++++++++
 .../selftests/liveupdate/luo_kexec_simple.c   |  5 +++
 4 files changed, 56 insertions(+)

diff --git a/tools/testing/selftests/liveupdate/lib/include/libliveupdate.h b/tools/testing/selftests/liveupdate/lib/include/libliveupdate.h
index fa07fed083646..15a7db3a6b3e8 100644
--- a/tools/testing/selftests/liveupdate/lib/include/libliveupdate.h
+++ b/tools/testing/selftests/liveupdate/lib/include/libliveupdate.h
@@ -26,6 +26,7 @@ int luo_create_session(int luo_fd, const char *name);
 int luo_retrieve_session(int luo_fd, const char *name);
 int luo_session_finish(int session_fd);
 int luo_get_session_name(int session_fd, char *name, size_t name_len);
+int luo_session_freeze(int session_fd);
 
 int luo_ensure_nofile_limit(long min_limit);
 int luo_session_preserve_fd(int session_fd, int fd, __u64 token);
diff --git a/tools/testing/selftests/liveupdate/lib/lu_utils.c b/tools/testing/selftests/liveupdate/lib/lu_utils.c
index 74d41115c2815..6315746ff08f8 100644
--- a/tools/testing/selftests/liveupdate/lib/lu_utils.c
+++ b/tools/testing/selftests/liveupdate/lib/lu_utils.c
@@ -198,6 +198,16 @@ int luo_session_finish(int session_fd)
 	return 0;
 }
 
+int luo_session_freeze(int session_fd)
+{
+	struct liveupdate_session_freeze arg = { .size = sizeof(arg) };
+
+	if (ioctl(session_fd, LIVEUPDATE_SESSION_FREEZE, &arg) < 0)
+		return -errno;
+
+	return 0;
+}
+
 void create_state_file(int luo_fd, const char *session_name, int token,
 		       int next_stage)
 {
diff --git a/tools/testing/selftests/liveupdate/liveupdate.c b/tools/testing/selftests/liveupdate/liveupdate.c
index 2dedd5fc2534f..9de068f31c3ec 100644
--- a/tools/testing/selftests/liveupdate/liveupdate.c
+++ b/tools/testing/selftests/liveupdate/liveupdate.c
@@ -530,4 +530,44 @@ TEST_F(liveupdate_device, preserve_many_files)
 	ASSERT_EQ(close(session_fd), 0);
 }
 
+/*
+ * Test Case: Session Freeze
+ *
+ * Verifies that an outgoing session can be frozen early via
+ * LIVEUPDATE_SESSION_FREEZE, that subsequent freeze attempts return -EBUSY,
+ * and that attempting to preserve an additional file descriptor into a frozen
+ * session fails with -EBUSY.
+ */
+TEST_F(liveupdate_device, session_freeze)
+{
+	int session_fd, mem_fd1, mem_fd2;
+
+	self->fd1 = open(LIVEUPDATE_DEV, O_RDWR);
+	if (self->fd1 < 0 && errno == ENOENT)
+		SKIP(return, "%s does not exist", LIVEUPDATE_DEV);
+	ASSERT_GE(self->fd1, 0);
+
+	session_fd = luo_create_session(self->fd1, "session-freeze-test");
+	ASSERT_GE(session_fd, 0);
+
+	mem_fd1 = memfd_create("freeze-memfd-1", 0);
+	ASSERT_GE(mem_fd1, 0);
+	ASSERT_EQ(luo_session_preserve_fd(session_fd, mem_fd1, 0x1111), 0);
+
+	/* Freeze the session early */
+	ASSERT_EQ(luo_session_freeze(session_fd), 0);
+
+	/* Subsequent freeze attempt on an already frozen session must fail with -EBUSY */
+	EXPECT_EQ(luo_session_freeze(session_fd), -EBUSY);
+
+	/* Preserving a file after freeze must fail with -EBUSY */
+	mem_fd2 = memfd_create("freeze-memfd-2", 0);
+	ASSERT_GE(mem_fd2, 0);
+	EXPECT_EQ(luo_session_preserve_fd(session_fd, mem_fd2, 0x2222), -EBUSY);
+
+	ASSERT_EQ(close(session_fd), 0);
+	ASSERT_EQ(close(mem_fd1), 0);
+	ASSERT_EQ(close(mem_fd2), 0);
+}
+
 TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/liveupdate/luo_kexec_simple.c b/tools/testing/selftests/liveupdate/luo_kexec_simple.c
index 786ac93b9ae38..ab108c7f1d855 100644
--- a/tools/testing/selftests/liveupdate/luo_kexec_simple.c
+++ b/tools/testing/selftests/liveupdate/luo_kexec_simple.c
@@ -40,6 +40,11 @@ static void run_stage_1(int luo_fd)
 			  TEST_MEMFD_TOKEN);
 	}
 
+	ksft_print_msg("[STAGE 1] Freezing session '%s' early...\n",
+		       TEST_SESSION_NAME);
+	if (luo_session_freeze(session_fd) < 0)
+		fail_exit("luo_session_freeze for '%s'", TEST_SESSION_NAME);
+
 	close(luo_fd);
 	daemonize_and_wait();
 }
-- 
2.56.0.385.gd3acb90ef8-goog


