Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6433560A260E
	for <kexec@archiver.kernel.org>; Wed, 18 Nov 2026 21:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ZNISvWHw;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=YWTuZn5B
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=s4n5oLhMYFN0GZT8T1PCl7tWuEXQGuvdSxMt72RME2E=; b=ZNISvWHwY3aHTk
	NQCMyhbJFczVYukhSr9zcIdE8bs6Uv0rie9Ctwcsli6KDgZMSxRzWcJpjFbWvPujYl9Aoys55dyGX
	si8GRCGzu4CS2T9T1G1mcVax2S59wNBzOkiKenXEaw3zFBBSdC2oqdjYwCgPtwKGKbxP8+xeOwcjq
	YVDkca4pafZlWfrMSZYrKvCmAnY9CftGrxhj/SFN1thSVTY45OpjnNw5rD/0zJSufYEjyAKYH8WXl
	jILVuWbShdl/bklQ0c/5ZVhMKi1i06LnEaScdq0G8/PYEhPXOGQRHhySTmO2SpNVUz2xlusQxp0ie
	puzeJN5ZRrlA23l5CKNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTnDB-0000000AJgt-0F6m;
	Wed, 18 Nov 2026 21:29:01 +0000
Received: from mail-ua1-x933.google.com ([2607:f8b0:4864:20::933])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTnD5-0000000AJcC-26Pj
	for kexec@lists.infradead.org;
	Wed, 18 Nov 2026 21:28:59 +0000
Received: by mail-ua1-x933.google.com with SMTP id a1e0cc1a2514c-99c042cee7dso703519241.1
        for <kexec@lists.infradead.org>; Wed, 18 Nov 2026 13:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1795037334; x=1795642134; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=s4n5oLhMYFN0GZT8T1PCl7tWuEXQGuvdSxMt72RME2E=;
        b=YWTuZn5BY+Bwz2WaCPBjtogB987Z4X21KT5kFZThl201HWXMrbtyZE621EQDU+1/oz
         0qSv10dutCKmcw9hWtk7Y3KUy3JyOFrFl/4ixWxAQnQs1leWKBHjWgHGYxNDxsAvu1TV
         Po7UyiNxddMUvsMYUji9Q5/zYVPj9aRxYGynB8Ds3vUqPPr7eeZ9Yx26RJrK+m3mqAxH
         zZW6QK4dmeE7sJhTcGgoTvbC+fyk7Nl3xeTvftUGLS3igYjdyC630uR+xBjEzceoXTrX
         IdE/3gCC2YreTI2qwhvkyhDubCh5JW3w0d8NfSPEt+5zPVRyEs1GzBzDN7cbX/llC53r
         sHcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795037334; x=1795642134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=s4n5oLhMYFN0GZT8T1PCl7tWuEXQGuvdSxMt72RME2E=;
        b=n3htJ5XoDeq9dF7yudg63JsVQ0184UQMdcY29Wyx4Sa+TMhJiPk5jhglAbeVfV+5/O
         ztj/UsY3dLgNAIaCF73PNL66eY46nl4TTmMqyLtUS1dzNe8UXxtTPr0VQrvNqNrqJxNO
         98lc9tUYEeo78+IU0VcXkIint2OuVWX51ypwwfuTHQQz/CRR8Yp2lcgc4CCHGxnRG4MK
         Y/ddzVjn8DPCmKXE6nSygNN6qZzuiY5+LYHAIU2wuFDmUznF9NAnXHV37QRKJ+M1rWVH
         RnjzVPNSDl8WD7Wet2vI6X7NFH0zXpc5KgBipZQvPH/1rNkyFH+Bx7uddcYTN3FT9Tef
         Jbbw==
X-Forwarded-Encrypted: i=1; AL+hErG7BHzIR3FrRU3wPG9dgAFWi0NeUVHFJ6Pd2xDy5acaToC2sNQqpyvLB3MSIFj/It+aQwJIDw==@lists.infradead.org
X-Gm-Message-State: APuU4Z+q8SuvXGo4ENw1odTOyo8674DhC3vmDeTyxdmbgVhgv7ndFE/y
	I+XvyBgnLtj/wl89lC0VAeLNRlDdxLwoSiQ4tzCAu63v1FSXpnkInlo5Vjht46j1xpY=
X-Gm-Gg: AYBFou3GVly+od0sJpdlF+6U/fnnBzuV2EVaaC1pNGYTc2oXcsIYQzgHbnl9YIQXn0C
	9nzgcLRWz7bUEHOJJbKsrND/mBBxbK7MgFzDoG8iK1t7UEBbqQWnf45/lQ1Z+hXi8zmOGZlBuWy
	n3fms8229fvMhJnrO5piufD4kl0ymE18jY0Wn0DK2cSno/6BkaMnw34B8X/uzDBLNh3HtAAlcFA
	fabf9mc7Go1/RcL+AGJr7ss1s2/SzvTr9NPy7AcdZmeRzflApjq1iWGDNdbSmFORAgAArXs7le+
	9kfzxN4t+YGb+SVpkosrcMOxtvMIYHRnFBHfqm7X24TNZLfFfvinNquAeJ5KpzuRXq/gxJjj5PL
	i5x1ElIz9K+JFL4e01dbSQITui8wXwfKcQbBTBl19WQJSiVw5aJ6+8gOERLJz+DVpLHuSymUb6H
	/aiYgm5CQeJZnFhLPdePYPGHPZusY+31NffZHuGz0eT5KrLTlrxD1XBYJgPxPfKCX+9sWuXaHdF
	tUEag9z/XssLWyWM3smEag0cR197udAARb7N/lYywZWnmJNqTFBZfgfAkvCFs5xAAMqdnN6whRd
	1f+WI/E4x7963aHtHQ86i8EdAWxco7tT0q1dipPtk5ygadvh9yop4Gi9ZK0VVm/JUqSAFxmC+iY
	YW4T6OmB09mC5/9Q6X+2xi88xbqmfIX5nCeIoPaV6uQuJpsw79FNnjMoLlVc53elmrYfH8KCEPQ
	==
X-Received: by 2002:a05:6102:4412:b0:7d2:8529:6892 with SMTP id ada2fe7eead31-7d6ba3e7857mr1999245137.11.1795037334470;
        Wed, 18 Nov 2026 13:28:54 -0800 (PST)
Received: from soleen.c.googlers.com.com (57.233.150.34.bc.googleusercontent.com. [34.150.233.57])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6b9185bc3sm2724635137.5.2026.11.18.13.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 13:28:54 -0800 (PST)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: linux-kselftest@vger.kernel.org,
	rppt@kernel.org,
	shuah@kernel.org,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	vipinsh@google.com,
	linux-kernel@vger.kernel.org,
	corbet@lwn.net,
	linux-api@vger.kernel.org,
	pasha.tatashin@soleen.com,
	dmatlack@google.com,
	kexec@lists.infradead.org,
	pratyush@kernel.org,
	rdunlap@infradead.org,
	graf@amazon.com
Subject: [PATCH v6 6/7] selftests: liveupdate: Add unit tests for LIVEUPDATE_SESSION_FREEZE
Date: Wed, 18 Nov 2026 16:28:41 -0500
Message-ID: <20261118212845.2855249-7-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
In-Reply-To: <20261118212845.2855249-1-pasha.tatashin@soleen.com>
References: <20261118212845.2855249-1-pasha.tatashin@soleen.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261118_132857_981529_62860F26 
X-CRM114-Status: GOOD (  10.91  )
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

Add a luo_session_freeze() helper and unit tests in liveupdate.c for
LIVEUPDATE_SESSION_FREEZE. Verify negative cases (unsupported flags,
double freeze, and preserving files after freeze), that closing a
frozen uncommitted session unfreezes and returns resources, and that
closing a committed session retains LUO ownership of the session and
its preserved files.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 .../liveupdate/lib/include/libliveupdate.h    |   1 +
 .../selftests/liveupdate/lib/lu_utils.c       |  13 +++
 .../testing/selftests/liveupdate/liveupdate.c | 107 ++++++++++++++++++
 3 files changed, 121 insertions(+)

diff --git a/tools/testing/selftests/liveupdate/lib/include/libliveupdate.h b/tools/testing/selftests/liveupdate/lib/include/libliveupdate.h
index fa07fed08364..34657d6eb67b 100644
--- a/tools/testing/selftests/liveupdate/lib/include/libliveupdate.h
+++ b/tools/testing/selftests/liveupdate/lib/include/libliveupdate.h
@@ -26,6 +26,7 @@ int luo_create_session(int luo_fd, const char *name);
 int luo_retrieve_session(int luo_fd, const char *name);
 int luo_session_finish(int session_fd);
 int luo_get_session_name(int session_fd, char *name, size_t name_len);
+int luo_session_freeze(int session_fd, __u32 flags);
 
 int luo_ensure_nofile_limit(long min_limit);
 int luo_session_preserve_fd(int session_fd, int fd, __u64 token);
diff --git a/tools/testing/selftests/liveupdate/lib/lu_utils.c b/tools/testing/selftests/liveupdate/lib/lu_utils.c
index 74d41115c281..51384374305d 100644
--- a/tools/testing/selftests/liveupdate/lib/lu_utils.c
+++ b/tools/testing/selftests/liveupdate/lib/lu_utils.c
@@ -198,6 +198,19 @@ int luo_session_finish(int session_fd)
 	return 0;
 }
 
+int luo_session_freeze(int session_fd, __u32 flags)
+{
+	struct liveupdate_session_freeze arg = {
+		.size = sizeof(arg),
+		.flags = flags,
+	};
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
index 2dedd5fc2534..4b0c0fb1be87 100644
--- a/tools/testing/selftests/liveupdate/liveupdate.c
+++ b/tools/testing/selftests/liveupdate/liveupdate.c
@@ -530,4 +530,111 @@ TEST_F(liveupdate_device, preserve_many_files)
 	ASSERT_EQ(close(session_fd), 0);
 }
 
+/*
+ * Test Case: Session Freeze
+ *
+ * Verifies LIVEUPDATE_SESSION_FREEZE with flags == 0: unsupported flags return
+ * -EOPNOTSUPP, repeated freeze and post-freeze preserve return -EBUSY, and
+ * closing the session FD unfreezes the session and returns all resources.
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
+	session_fd = luo_create_session(self->fd1, "session-freeze");
+	ASSERT_GE(session_fd, 0);
+
+	mem_fd1 = memfd_create("freeze-memfd-1", 0);
+	ASSERT_GE(mem_fd1, 0);
+	ASSERT_EQ(luo_session_preserve_fd(session_fd, mem_fd1, 0x1111), 0);
+
+	/* Unsupported flag bits must fail with -EOPNOTSUPP */
+	EXPECT_EQ(luo_session_freeze(session_fd, 1U << 1), -EOPNOTSUPP);
+
+	/* Freeze the session */
+	ASSERT_EQ(luo_session_freeze(session_fd, 0), 0);
+
+	/* Subsequent freeze attempts must fail with -EBUSY */
+	EXPECT_EQ(luo_session_freeze(session_fd, 0), -EBUSY);
+	EXPECT_EQ(luo_session_freeze(session_fd,
+				     LIVEUPDATE_SESSION_FREEZE_COMMIT),
+		  -EBUSY);
+
+	/* Preserving a file after freeze must fail with -EBUSY */
+	mem_fd2 = memfd_create("freeze-memfd-2", 0);
+	ASSERT_GE(mem_fd2, 0);
+	EXPECT_EQ(luo_session_preserve_fd(session_fd, mem_fd2, 0x2222), -EBUSY);
+
+	/* Closing the session FD must unfreeze and unpreserve resources */
+	ASSERT_EQ(close(session_fd), 0);
+
+	session_fd = luo_create_session(self->fd1, "session-freeze");
+	ASSERT_GE(session_fd, 0);
+	ASSERT_EQ(luo_session_preserve_fd(session_fd, mem_fd1, 0x1111), 0);
+
+	ASSERT_EQ(close(session_fd), 0);
+	ASSERT_EQ(close(mem_fd1), 0);
+	ASSERT_EQ(close(mem_fd2), 0);
+}
+
+/*
+ * Test Case: Session Freeze and Commit
+ *
+ * Verifies LIVEUPDATE_SESSION_FREEZE with LIVEUPDATE_SESSION_FREEZE_COMMIT:
+ * once committed, the frozen session is serialized into KHO and survives
+ * closing the session FD with ownership retained by LUO until reboot.
+ */
+TEST_F(liveupdate_device, session_freeze_commit)
+{
+	char name[LIVEUPDATE_SESSION_NAME_LENGTH];
+	int session_fd, session_fd2, mem_fd1, mem_fd2;
+
+	self->fd1 = open(LIVEUPDATE_DEV, O_RDWR);
+	if (self->fd1 < 0 && errno == ENOENT)
+		SKIP(return, "%s does not exist", LIVEUPDATE_DEV);
+	ASSERT_GE(self->fd1, 0);
+
+	snprintf(name, sizeof(name), "freeze-commit-%d", getpid());
+	session_fd = luo_create_session(self->fd1, name);
+	ASSERT_GE(session_fd, 0);
+
+	mem_fd1 = memfd_create("freeze-commit-memfd-1", 0);
+	ASSERT_GE(mem_fd1, 0);
+	ASSERT_EQ(luo_session_preserve_fd(session_fd, mem_fd1, 0x1111), 0);
+
+	/* Freeze and commit the session */
+	ASSERT_EQ(luo_session_freeze(session_fd,
+				     LIVEUPDATE_SESSION_FREEZE_COMMIT), 0);
+
+	/* Subsequent freeze attempts must fail with -EBUSY */
+	EXPECT_EQ(luo_session_freeze(session_fd, 0), -EBUSY);
+	EXPECT_EQ(luo_session_freeze(session_fd,
+				     LIVEUPDATE_SESSION_FREEZE_COMMIT),
+		  -EBUSY);
+
+	/* Preserving a file after freeze must fail with -EBUSY */
+	mem_fd2 = memfd_create("freeze-commit-memfd-2", 0);
+	ASSERT_GE(mem_fd2, 0);
+	EXPECT_EQ(luo_session_preserve_fd(session_fd, mem_fd2, 0x2222), -EBUSY);
+
+	/* Closing the session FD must retain LUO ownership of session & files */
+	ASSERT_EQ(close(session_fd), 0);
+
+	EXPECT_EQ(luo_create_session(self->fd1, name), -EEXIST);
+
+	session_fd2 = luo_create_session(self->fd1, "freeze-commit-check");
+	ASSERT_GE(session_fd2, 0);
+	EXPECT_EQ(luo_session_preserve_fd(session_fd2, mem_fd1, 0x3333),
+		  -EBUSY);
+
+	ASSERT_EQ(close(session_fd2), 0);
+	ASSERT_EQ(close(mem_fd1), 0);
+	ASSERT_EQ(close(mem_fd2), 0);
+}
+
 TEST_HARNESS_MAIN
-- 
2.56.1.708.g77570a6a1d-goog


