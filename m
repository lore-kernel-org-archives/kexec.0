Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62947606A32D
	for <kexec@archiver.kernel.org>; Thu, 22 Oct 2026 01:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=v0Qb8g+f;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=N0yfZzVQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J0kSQmA6WteBQ8jad2iaYF5h9jM/IeqgPz50Jq+mBV0=; b=v0Qb8g+fedC8CwrK7gWQN9n6c/
	AbkU8oyR9r0uBXIwmp2q7uZT+7R2b3UCvdRp7fm4sboSU46uQJGkBpkdIkb5Q3/0eFGj2VXo7l9WP
	y3uLxRBh/kV3G9dEuR/cD238bqzNpCDtqqcO988qFujAJPyVrHZE6BAdTXs7/su+Y+MZTemYTCRwd
	kTiVYnVXSTWNXp0z8hJCpyaW8Wy04VdTePT0DH4PiXwnLi+LYGT9W9TDAaZRuAe9Z67rCq3XUIqwC
	Jj4xQEpD+I2ifERaQPLHB8a5z2O0/kO3ipTvBgZmwtt0g0jI4C0/5XkpkHC5OGPymFbBrCwqIckHs
	/ijH6ekw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJi54-0000000DAOG-2Br1;
	Thu, 22 Oct 2026 01:58:58 +0000
Received: from mail-qk1-x733.google.com ([2607:f8b0:4864:20::733])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJi4w-0000000DAMO-2qcS
	for kexec@lists.infradead.org;
	Thu, 22 Oct 2026 01:58:54 +0000
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-93cc1ab5f6cso143329385a.0
        for <kexec@lists.infradead.org>; Wed, 21 Oct 2026 18:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792634329; x=1793239129; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=J0kSQmA6WteBQ8jad2iaYF5h9jM/IeqgPz50Jq+mBV0=;
        b=N0yfZzVQPv/MMjalr+zNPhuFu72UGvn2QKSFNxxLmzFbgnNJA2PPz2DuN6N6pxazjs
         KHhYUhVr31P9WmZ4XL2voo38jDa5j+4uj4hsM0Jh9LVN5J4TYxkrOcADOO7wYXff0RqA
         8Q4YtDTshMN0E/cm2qLrFT5BuuR5tEmemi2YjUDH0bFZ+2SjsRlTXoVWsDf8k7acR3e2
         O8qc0XzL8zjemIpu/aMOd8+zI6cN8ZtuHHLrgP0YvKO+4cjkR079kfjLiQJ5kpSHQpsD
         p+K1dN/2DZZtoMS1kNiuotrSv9mG+FkNFBOl3moxsnhntOUwbjpD18SJE+ZFtg5DOuzp
         zelw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792634329; x=1793239129;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=J0kSQmA6WteBQ8jad2iaYF5h9jM/IeqgPz50Jq+mBV0=;
        b=18mek90auFtdCB/kgKhUc+FeQKgnIRn+8jagXcDCfPNzHhF9pWSf3bFEzVV1nGE1yr
         OOXYgqbIRvroxY0meIY8tS5fBAJuWqV4P8tUBidYk11OQKmFowikjLlZ+IIbE8M3ZJsZ
         bNlJswOM4iIwJ161WobifefZss+KMJHvdV0FQpmo60JCkOERpzZPgEBo0p7sE3/hSG0k
         U1ZofZi8WHz9k2IImDem+mS6/jKUc6RgpTm3AwW2DiO8bIqBjI/D/N31Jw+RDYSG4QC8
         wTibTlENpdQt5ybcrSx3wcmj/ELx7GBanbN5dj5L+FPMwvsyCAe6WvUu75dZth1wJeLD
         ZT2A==
X-Forwarded-Encrypted: i=1; AKwUvBzeFqR2FElij1eKK70iNYBLs7LI9P8xSFHqAVzOO+pSp2hv1rZ/ZMAV0II/Zi1qQ4io8LCjew==@lists.infradead.org
X-Gm-Message-State: AFq9FYKUkKT5NZrCJKAvGty6lOBepuKSRQHUOK563LPgqN9HH7fHINCY
	wgxa6Ds06gQB+UwUEs7g5zczakjcbMD/B7HBpezLibfI1T+h7diUB/xI6QZjpMTvKyU=
X-Gm-Gg: AYBFou00gOQ/6b8co/DrGFntrgWlgqaswHnTmjchhGLVDZJAcQFm72WWGRhfCsuGAIX
	DQZfVUFyobZpbnb0CoTBSxz6HC7VQLUM0NL5ylvXJuvvn6JubxQOnaMDQLSY9R1IQu1vmkwm8sP
	XR/4OT/ERySTpWqOVKVC/O6+d5T3umWezlCS4BVNzc9E+k1amldQHj69VUvS5S4qROTalkgCqIp
	K9RPZPDoQWOtPBJ8YFMAIXEnq7RNJNEndLnBPWQyXVcWr/Q7POYhqrGsbTcM7WJ9KYl1ydLpGDZ
	PpOPl8ZH6GU2J+SiGAbO75LfbyIFXATPekVzhl7SfitSPEz4avdxfn11AW/P8zvdknw5bDSiYcg
	cQgY4z15UzycNQz2XnI65LtzSua288fmnPSrgscuLAr/KAihZYWZBOwN5KaFUt4Ggs6nzTD+/h3
	NVPugelFglfCpV8fGaOC4Pua16CnaToMJHV43bV7z0TNPqp9u3bXTimw2bd8MIPeWHVOf+oln/y
	M19RLQIkD2+TSs71wgeN7owwNNLwOmsEZZos+eR8bonyE0Xb1HtPd5f5OB3jgyJPoN7kFwqYLXG
	NyjBk4kA9qt4LE0CfcjuKhJKOfMI5KI5O8qZyf90jCJ4c7T/S6LbnHROAM1UjFdhbvZNkn/t4Sh
	ZLVkQbv9SpkV5i1ZDQbE6Ow==
X-Received: by 2002:a05:620a:2851:b0:93e:4d60:d389 with SMTP id af79cd13be357-93f57f1ecf1mr807656985a.25.1792634329416;
        Wed, 21 Oct 2026 18:58:49 -0700 (PDT)
Received: from soleen.c.googlers.com.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f56e247ffsm397383285a.39.2026.10.21.18.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 18:58:48 -0700 (PDT)
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
Subject: [PATCH v3 2/2] selftests: liveupdate: Add tests for LIVEUPDATE_SESSION_FREEZE
Date: Wed, 21 Oct 2026 21:58:40 -0400
Message-ID: <20261022015844.2795816-3-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
In-Reply-To: <20261022015844.2795816-1-pasha.tatashin@soleen.com>
References: <20261022015844.2795816-1-pasha.tatashin@soleen.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261021_185850_730470_CA00D141 
X-CRM114-Status: GOOD (  15.21  )
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
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
2.56.0.218.g1ec904b173-goog


