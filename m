Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A333606A31F
	for <kexec@archiver.kernel.org>; Tue, 20 Oct 2026 14:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=zWlPOz8p;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=SPf3aWmd
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8BnGO4/42KiDK1q900mgIYvccBVIMN3QrNthvM/m5KA=; b=zWlPOz8pv4ynV0kMLPrjCiBpem
	vwzQv1YOmFfK2Q7NhcNHKFOGOB/V58TuPU4XB/edzAi083a/cAB7gAUZALE1dYuWu8y6P3PMVAfwp
	3zzzrMIjc6salFmTnfcVlrotvpYEFTbx6fgH3Ov9Fy+0CIDM6rhStFTgk+mFLb2/tcMM3W2I+E/Pb
	XH5C1tN2DsIR5nliIS5LsInFc5m22v9+4kJootLvASdhejJbUpGOoD0pYU9HcgAsLyFnqSZpjCSXL
	nA91vCVQe+5K7li2VZ/9k7T74vm8+3bYpXjywtNjem7u/GPh++B1z7LVxIOXZ57Jp6IYLhysF/RRt
	f1yMgRug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJB7k-00000009zCo-0iWF;
	Tue, 20 Oct 2026 14:47:32 +0000
Received: from mail-vs1-xe36.google.com ([2607:f8b0:4864:20::e36])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJB7h-00000009zAu-03L1
	for kexec@lists.infradead.org;
	Tue, 20 Oct 2026 14:47:30 +0000
Received: by mail-vs1-xe36.google.com with SMTP id ada2fe7eead31-7907f01e487so721404137.2
        for <kexec@lists.infradead.org>; Tue, 20 Oct 2026 07:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792507648; x=1793112448; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8BnGO4/42KiDK1q900mgIYvccBVIMN3QrNthvM/m5KA=;
        b=SPf3aWmdeEU2kF8OFKD1Nqix5ydR1eybk85Y4LBz60a4VMIgfntJU2r5VaqJaRnrF7
         TwtmGint5kCFr9Y+H1fxzFLOj7OuYHOn2nUyZlSjadMurW+t+HhQV2n1lDQqlDwLcZMS
         bxfx3MNUGe7CYSFlb5u6ofViyCSPHC67zfoIy6M9/Qew/zWDHGw359itfux3wiuFwku3
         XJd71ZJo1u682fxlwUJsa+3lYP9oampGqlxY/krjfVP1sOo+Oz12f4eK5HORRL8nRHtf
         R2K4O1Z7BzgFIpsXuBTdGnbWnzv8xkXaipffLvRmYxEJQu5sSDe90X8CbODd6s9O6BMD
         BcnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792507648; x=1793112448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=8BnGO4/42KiDK1q900mgIYvccBVIMN3QrNthvM/m5KA=;
        b=XZvKKo7SBO7vtbfaqT/lFpiIpFXzg2+kbolz2kuyVnHKJZhyWNeFeqLK8v6CADAdli
         UoSxb/P0Gje+0FDPgy1NUZjvwyCOrZDSaIODegDc+4BY/yPhJer/WY41pGDPPZ+B2VLh
         gkeI/Napz3HPehlxmEpB0BYDKcIHmk0ib9+yOR8bvGMQNXYKNucKUNu6BBA+9XLU2t6r
         wzsXggZRCb6hAKdvcYlVMWA7udOTDmSzF2zgUuiZuATrGlAZGpUyQBfPCrJTYBJulwsm
         1REgV0/MgRSTWhhC+mht9jA6zAEiRrHiU9LDsPJALfxsmhRkM3i70CFYs6sIUFyMv+1M
         Qb9Q==
X-Forwarded-Encrypted: i=1; AKwUvBwwmDxgcKiTJqfOeYPrAwtgILMac8U26viTdStMc5Y6ST1zaMTzcHBOin78B5T8crHJXuCKqg==@lists.infradead.org
X-Gm-Message-State: AFq9FYJv+Iz90Ds/YP1C99lFneystWTsO7sY5gW7UmN470nrjoWDsaKc
	pod6hQn33c7civOfgWb6PmgkWTibjKLj/hGUGWel1aQoVPEBmUgO08PJJMVYgrDmGtk=
X-Gm-Gg: AYBFou08PyBU27UUEveKP6P8O+t5nXHplY65IxtN9FiWtff4wYwR2RWASmOmX1JWvgZ
	1Ag5G64gd//umlKC2HKP9T3UraVNS2lM0tz6ud2B6YpHUIFZG8UnWEoFqueXJs9ecM94OCnWQu4
	7KL+cdn3Ch25J8GN45YL0z2yDUhrtGKPeNa+QJvfqbavRM0I80/LZnqu/66OC9EMxQjWk2PYGo+
	n6rHF1NabuSXtQ0W82JkuT55AyzNZuJ1gZEZDjRApTccki2VhdsAagG3f+IGDz4qbGy95o6Cz0E
	k6HRmDXHGBr+vg6NP5yaZnNhMj0577Z/SMCrfmZl23tvockkyGOolzv+D885ftQ7UjpJW9mw2jH
	GdAkTnw5UK8MOTzMi16ND3yUnwPud/J/tO+CUqWl1hm5+EUJUZMjtXxjYeeaAg76oOW2TQv0YtP
	O0rI2fQkUtn1JVJUSQJJSYgOW5rNHq8TjB9wuGsqA38dOZbvIlPpSQSSNUt6DZP21KgoMKVJkaO
	EqaFmk32wiyJgzNDdeko2eTDy75J5jDHsZ6IcGftPnPkeXcGb5GRc7KfkELZ+gE3VKxwgBkzfH+
	7b+/Zte2N8/v9UeqxeQ=
X-Received: by 2002:a05:6102:4487:b0:7cc:1045:610 with SMTP id ada2fe7eead31-7cc36ab3f59mr2581207137.27.1792507647537;
        Tue, 20 Oct 2026 07:47:27 -0700 (PDT)
Received: from soleen.c.googlers.com.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ea9b536ccdsm12920421e0c.13.2026.10.20.07.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 07:47:26 -0700 (PDT)
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
Subject: [PATCH v2 2/2] selftests: liveupdate: Add tests for LIVEUPDATE_SESSION_FREEZE
Date: Tue, 20 Oct 2026 10:47:04 -0400
Message-ID: <20261020144710.4154339-3-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
In-Reply-To: <20261020144710.4154339-1-pasha.tatashin@soleen.com>
References: <20261020144710.4154339-1-pasha.tatashin@soleen.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261020_074729_330534_E2899C88 
X-CRM114-Status: GOOD (  15.33  )
X-Spam-Score: -2.1 (--)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Provide luo_session_freeze() in the liveupdate test library and add unit
tests in liveupdate.c covering the LIVEUPDATE_SESSION_FREEZE ioctl. The
tests verify that non-zero reserved bits are rejected with -EINVAL, an
outgoing session with preserved files can be frozen early, freezing an
already frozen session returns -EBUSY, and attempting to preserve an
additional file descriptor into a frozen session fails with -EBUSY.

Also freeze the test session early in luo_kexec_simple.c to exercise
LIVEUPDATE_SESSION_FREEZE across a kexec reboot, and verify that
attempting to freeze a retrieved incoming session returns -EINVAL.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 .../liveupdate/lib/include/libliveupdate.h    |  1 +
 .../selftests/liveupdate/lib/lu_utils.c       | 10 ++++
 .../testing/selftests/liveupdate/liveupdate.c | 49 +++++++++++++++++++
 .../selftests/liveupdate/luo_kexec_simple.c   |  8 +++
 4 files changed, 68 insertions(+)

diff --git a/tools/testing/selftests/liveupdate/lib/include/libliveupdate.h b/tools/testing/selftests/liveupdate/lib/include/libliveupdate.h
index fa07fed08364..15a7db3a6b3e 100644
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
index 74d41115c281..6315746ff08f 100644
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
index 2dedd5fc2534..74004e4276f5 100644
--- a/tools/testing/selftests/liveupdate/liveupdate.c
+++ b/tools/testing/selftests/liveupdate/liveupdate.c
@@ -530,4 +530,53 @@ TEST_F(liveupdate_device, preserve_many_files)
 	ASSERT_EQ(close(session_fd), 0);
 }
 
+/*
+ * Test Case: Session Freeze
+ *
+ * Verifies that an outgoing session can be frozen early via
+ * LIVEUPDATE_SESSION_FREEZE, rejects non-zero reserved bits with -EINVAL,
+ * that subsequent freeze attempts return -EBUSY, and that attempting to
+ * preserve an additional file descriptor into a frozen session fails with
+ * -EBUSY.
+ */
+TEST_F(liveupdate_device, session_freeze)
+{
+	struct liveupdate_session_freeze bad_arg = {
+		.size = sizeof(bad_arg),
+		.reserved = 1,
+	};
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
+	/* Non-zero reserved field must fail with -EINVAL */
+	EXPECT_EQ(ioctl(session_fd, LIVEUPDATE_SESSION_FREEZE, &bad_arg), -1);
+	EXPECT_EQ(errno, EINVAL);
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
index 786ac93b9ae3..9bc8dab2e074 100644
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
@@ -60,6 +65,9 @@ static void run_stage_2(int luo_fd, int state_session_fd)
 	if (session_fd < 0)
 		fail_exit("luo_retrieve_session for '%s'", TEST_SESSION_NAME);
 
+	if (luo_session_freeze(session_fd) != -EINVAL)
+		fail_exit("luo_session_freeze on incoming session did not return -EINVAL");
+
 	ksft_print_msg("[STAGE 2] Restoring and verifying memfd (token %#x)...\n",
 		       TEST_MEMFD_TOKEN);
 	mfd = restore_and_verify_memfd(session_fd, TEST_MEMFD_TOKEN,
-- 
2.56.0.212.g129ede20d9-goog


