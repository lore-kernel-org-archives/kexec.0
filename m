Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F055606A327
	for <kexec@archiver.kernel.org>; Mon, 26 Oct 2026 01:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=AVomG1ik;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=f2GiC9J2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=paepyu+lNzKcCGz2xys5Lce7GHF0FgZ1jCDDvPB5GKY=; b=AVomG1ikoMClHQ
	fN7BnR5JLvszrK0UmDnPz2Jg38lcXQ9mocycROTEAS19jtU2nMB43zMh91Hug9aZeKphyZQSKzPPE
	lqTyLOFUejdSGetSnGm9IQlXwC1mUWKYfxIqLhaf9jxkVRiEWngRLZZ87Unc/ZopZ5vNQ36Wl1Ako
	AIwgr1dBMEQQw0DIsmbNKwjWdam9/73eAp4bGDBSv4nyw3jYHMg/bz9g6//bOFYWrUC0Bhp6LrIda
	ZE7S4BlcLXanYUEG4/pAnOXXmRJgLYplZTBN1PusxSZG9lc5eyobXovtH59PcgjMAuYP8FOJ6KDgn
	KrONFUXvQhwJRgbrckDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xL9qX-00000001a7C-1SaU;
	Mon, 26 Oct 2026 01:49:57 +0000
Received: from mail-vs1-xe2a.google.com ([2607:f8b0:4864:20::e2a])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xL9qV-00000001a5p-2LQg
	for kexec@lists.infradead.org;
	Mon, 26 Oct 2026 01:49:56 +0000
Received: by mail-vs1-xe2a.google.com with SMTP id ada2fe7eead31-7c33cc572e6so2233464137.1
        for <kexec@lists.infradead.org>; Sun, 25 Oct 2026 18:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792979394; x=1793584194; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=paepyu+lNzKcCGz2xys5Lce7GHF0FgZ1jCDDvPB5GKY=;
        b=f2GiC9J2zAx6bJj/N5zUjmOkGMdskEMC6vO0dTHo6YBtZbATMh1Ve82Ziug33YwZEW
         Y+eWvWZuYlYn4T6XeXJfd+vrVW6SjRmlAhgTRzW5jQpJbmoBzZcHLXCWpwHQqulnoxDI
         Xn1RzsAnEDT06RG/799IPD0xDumiGkpbMABFZZiObGxtcjyyKmx4Xe+74/UiuH4IoD2F
         gF+RKdnc/+SziM60eEP424tvCINfO8HBERd84uDfJQ84T7v2uCjIjLgD2zVrvc/zIl47
         mKNkiJpw6t9eAY8rkf55+OPMe+i8UcZQoubREMIDv6tLlPdWopTqmbZK8Boc5hKGjN0U
         9sLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792979394; x=1793584194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=paepyu+lNzKcCGz2xys5Lce7GHF0FgZ1jCDDvPB5GKY=;
        b=L9yK2D48grhF5iiL+fwVAyiO/ZIayJllc8CbFJuNNg8SbDdYgxz1wcdocRhGrRHSmY
         bVq6nkS0N2L8cCGXKS6QKs7J4m7+r6zz3YBSH5fRSFVU6odz3+Rrp5t/XwLgg8/tI1+f
         J6+ABeK4p89s16Do+funbcfSqGMc/QA+yTQ9m6bmwl1ANIskSgCXZg+aN+6V72W9Bs/c
         0wdXshdWDjTjDsMM2Vb7NVuQvJhAh73IPNQq2L3wHVklhIyQ8yzkcB/o2sXaM4WGGIjQ
         xNVFDUn3zhxB8vzst7NnRUTRS4ln//EowiX+kKt8rRePBroFjLOq9/ht0uvZC70l22bn
         EJcQ==
X-Forwarded-Encrypted: i=1; AKwUvBxKqoMW+ZeKNiao0duHoXjIuxdabWZl4QXLMABt2o63kD7tiAkCvZO0oM5ev144rB2ryX5OmQ==@lists.infradead.org
X-Gm-Message-State: AFq9FYKxLVN0EhJd3UD9iOJBHVaJmuakcc6GjxX5XDsmN56xgqubyl9e
	unBbDiBwFMDFouun6kv348PZpEFiwwWdgrZBNXBaWXnkrq05s2/YA5w3ccal+nPADAU=
X-Gm-Gg: AYBFou0FgAGujwgTOn6Naw00r6lxH/HBbFd2i3lfuViRmY6rK4v/tgDgpvAvy+q2Kcf
	9Xm1LZBVme0q9lXsEjFtOTftfLB0SnqhpgQPizKGtIlPgmgukLq2iuNuKOD5zFmBXvEFL/OlY7Y
	q6KCyN+bgaqUuzgSlJe8lq06uAyw1pmhqAp0i5u8MJN//t0jfqxB8rtGJzfdCcK5NFw+yIWGzCQ
	0gOJ0V/h8x0Arh8beKILPIsD3j4BO+tC65AAeKfa3iXaPRo4e+oCl1PkYwnipcYJ+QDdaic99Gm
	IvO/jxzn/AzY8fvO9PJoxF1IgJdJGYVo9qi+qMLtnwZklQX+4N0cFoWpl6DKIzNDqIc+XMfWfYZ
	pJZXaFVwQMKplWSQwE7hc7iIzsEwaTKNnJ09ijDDhst6z4Gb+wrkrYhKe0vy07sGvCnes3VrjcS
	fe58+Uago5ZsMsZuDPHAOguI5lfVmhtsFkzaMLDmcScyKm3udlLZ1RhCB/JwlmkzTQm6wAWL/Ja
	eXWxgMAwm0YJ9TWD4fpZcMF/h3qX/VvIsLBAUV38fAp9WZC4A5hsplXxyCmlJod2qQApo8DgNSz
	hzqW1gWD4MKQFSRL+UgmAM/MaoiXjEWZNoz46jXfyK2FlSgb7SKkS1lWo2c1IXEPFZ6rGKrYqln
	+lQ==
X-Received: by 2002:a05:6102:290c:b0:7a5:673f:9a37 with SMTP id ada2fe7eead31-7ce5d3e4c67mr1068887137.15.1792979394230;
        Sun, 25 Oct 2026 18:49:54 -0700 (PDT)
Received: from soleen.c.googlers.com.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7ce5df73970sm6099917137.1.2026.10.25.18.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 18:49:53 -0700 (PDT)
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
Subject: [PATCH v4 3/3] selftests: liveupdate: Add tests for LIVEUPDATE_SESSION_FREEZE
Date: Sun, 25 Oct 2026 21:49:46 -0400
Message-ID: <20261026014948.162559-4-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
In-Reply-To: <20261026014948.162559-1-pasha.tatashin@soleen.com>
References: <20261026014948.162559-1-pasha.tatashin@soleen.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261025_184955_614146_81A2EBC1 
X-CRM114-Status: GOOD (  13.42  )
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

Add a luo_session_freeze() helper and selftests for the
LIVEUPDATE_SESSION_FREEZE ioctl, including freezing a session before a
kexec reboot in luo_kexec_simple.c.

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 .../liveupdate/lib/include/libliveupdate.h    |  1 +
 .../selftests/liveupdate/lib/lu_utils.c       | 10 +++++
 .../testing/selftests/liveupdate/liveupdate.c | 45 +++++++++++++++++++
 .../selftests/liveupdate/luo_kexec_simple.c   |  8 ++++
 4 files changed, 64 insertions(+)

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
index 2dedd5fc2534..c27f57eab870 100644
--- a/tools/testing/selftests/liveupdate/liveupdate.c
+++ b/tools/testing/selftests/liveupdate/liveupdate.c
@@ -530,4 +530,49 @@ TEST_F(liveupdate_device, preserve_many_files)
 	ASSERT_EQ(close(session_fd), 0);
 }
 
+/*
+ * Test Case: Session Freeze
+ *
+ * Verifies the LIVEUPDATE_SESSION_FREEZE ioctl on an outgoing session.
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
2.56.0.307.g5fe7bd680c-goog


