Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D96F606A69A
	for <kexec@archiver.kernel.org>; Mon, 23 Nov 2026 23:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=A4OdJLaa;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PwjBR1nR
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=EeRPz4sZOybVhfqP/WD/7fCihnY2rWbCdbzpXQtgwmc=; b=A4OdJLaaG4CzNLVUvn1UXtlqmh
	6mWV1yKN6yBFTT81QkCUchBhTtY34Q/J+rHtT67JTMmThDDe32E4Am+DJmn6T4kSvuEoNIK50l3p4
	5O3c+jePhgYFLzTib5GYpmBrLX+muT2c9u33TaLWQjXZ2jBOzN6m6p9mh5KiIt3sOIuYFJvFiM9dY
	pxkJDTkueGlaVO5VzL5Y9qjEZcoARB+7fD/E7CwgJMXU4JjubIUn1Cb+q3K0t3dlqY6ddJNsqimcB
	4QRqFaxw3sBTqsil2T5YH1u7BBoKlEl/QxI1T7i0NodhLaVsrqIoOxqkd8sQK0CU+NgvDNNQwqC7P
	yI+u7xsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVddK-00000005BPn-3HE6;
	Mon, 23 Nov 2026 23:39:38 +0000
Received: from mail-oi1-x246.google.com ([2607:f8b0:4864:20::246])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVddG-00000005BMT-3dR5
	for kexec@lists.infradead.org;
	Mon, 23 Nov 2026 23:39:36 +0000
Received: by mail-oi1-x246.google.com with SMTP id 5614622812f47-4ea2c058e67so4396906b6e.1
        for <kexec@lists.infradead.org>; Mon, 23 Nov 2026 15:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795477173; x=1796081973; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EeRPz4sZOybVhfqP/WD/7fCihnY2rWbCdbzpXQtgwmc=;
        b=PwjBR1nRiiBFtcMGqKcr/L3Z9Wx3UD0tSVa3orxQBXAHxXtHI20qza6HiNmA0UbPuT
         SccXWUQLwASGhAjRQNUBSJjsvTiBnJpctf9gRvVMHAElc8JpZNsCDu3P6GJWXEidzz1V
         JSc4NXO47WYRQmfn8ILb377Y+DZ1lSkjuLl5fYGtfs3QjWihnYqrBAzVUfPy3T1M8pa2
         GjpyjmglKGs6Zl1cm9+vvV2ADEATtTjIXer+7DEBqFuHsVd0Zg7Ts+VoBfdVlNXX0ng3
         HswErDWydL65tk435EGdSOaoNPQu1UIqlfNAKBjSWu4P+rOm9h+OJ0RL9eOR/AAwiSQs
         BoGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795477173; x=1796081973;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EeRPz4sZOybVhfqP/WD/7fCihnY2rWbCdbzpXQtgwmc=;
        b=vspynGTSnCj3qw1z0VuqvT1QT+9gbPAp19M78ecZHgpdz84/dyNXvwc2SuV/kRbwDq
         t0JnShMnKgMtpr/L7y/dLPGaeD3ITTe8jW0wR4kZXyreoBqO09zZ2cy7mYQYa1mdCwRF
         vB237KlK12UgNOlfHDQ9f88qpjsnWwzbemQmYM1UXrtLS4yXv+n5DrF317uscFB0hsfL
         boss80DRez0JM0KdvIn99Y+EIzGRGlTadX655yqAkjd6v8+e8uYyofn5KVwkpO026C78
         dmGvwhGHVltGj4mf01sLU1vCPW+pKeFBGbbVg/ohlFJVe8ZoA364gKQfipAepCtRXcxB
         1NFw==
X-Gm-Message-State: APuU4Z800+sU9tIq3LFc4iiBgozIAqZMIqcvwcH+koUC7jIapcIR8M4x
	OeU8WFzJiR2113LPfxItvUY/TSF7nFMFxjrBenTnJHv/e6JIVpMn+hHfL2Kn6jLunpoVXMFrlxS
	5nFaH3n++JJ5acey9r6TL8teSK3olIPIzw8QjaY7Gp9sh/KzWYbdFGBIwTYSGIthZbBJ4be+sQs
	ZdqCb3xhrIswJ4s7lvrZw1yKer5lN5f42y/aLSFBrQPwnE7DUZoTE=
X-Received: from oixz16-n2.prod.google.com ([2002:a05:6809:410:20b0:4f4:549a:d85d])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:4fe1:b0:575:39f9:df7c with SMTP id 5614622812f47-57a06504990mr14793633b6e.2.1795477172875;
 Mon, 23 Nov 2026 15:39:32 -0800 (PST)
Date: Mon, 23 Nov 2026 23:39:08 +0000
In-Reply-To: <20261123233924.3970932-1-dmatlack@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261123233924.3970932-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261123233924.3970932-4-dmatlack@google.com>
Subject: [PATCH v5 03/18] selftests/liveupdate: Add tests for preserve and
 retrieve user argument
From: David Matlack <dmatlack@google.com>
To: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org
Cc: Alexander Graf <graf@amazon.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Christian Brauner <brauner@kernel.org>, 
	David Hildenbrand <david@kernel.org>, Hugh Dickins <hughd@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	"Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Mike Rapoport <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@kernel.org>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261123_153934_978029_A27F9B57 
X-CRM114-Status: GOOD (  17.33  )
X-Spam-Score: -9.5 (---------)
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
X-Spam-Status: No, score=-26.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Pasha Tatashin <pasha.tatashin@soleen.com>

Verify the user argument support in LIVEUPDATE_SESSION_PRESERVE_FD and
LIVEUPDATE_SESSION_RETRIEVE_FD. Add luo_session_preserve_fd_arg() and
luo_session_retrieve_fd_arg() helpers to libliveupdate so tests can pass
a handler-specific argument.

Add a preserve_memfd_with_arg test case to verify that memfd
preservation rejects a non-zero argument with -EOPNOTSUPP, accepts an
explicit zero argument, and remains compatible with callers passing the
legacy struct size up to the token field.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Signed-off-by: David Matlack <dmatlack@google.com>
Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>
---
 .../liveupdate/lib/include/libliveupdate.h    |  3 ++
 .../selftests/liveupdate/lib/lu_utils.c       | 17 ++++++-
 .../testing/selftests/liveupdate/liveupdate.c | 48 +++++++++++++++++++
 3 files changed, 66 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/liveupdate/lib/include/libliveupdate.h b/tools/testing/selftests/liveupdate/lib/include/libliveupdate.h
index fa07fed08364..cd1d843a0d3d 100644
--- a/tools/testing/selftests/liveupdate/lib/include/libliveupdate.h
+++ b/tools/testing/selftests/liveupdate/lib/include/libliveupdate.h
@@ -29,7 +29,10 @@ int luo_get_session_name(int session_fd, char *name, size_t name_len);
 
 int luo_ensure_nofile_limit(long min_limit);
 int luo_session_preserve_fd(int session_fd, int fd, __u64 token);
+int luo_session_preserve_fd_arg(int session_fd, int fd, __u64 token,
+				__u64 user_arg);
 int luo_session_retrieve_fd(int session_fd, __u64 token);
+int luo_session_retrieve_fd_arg(int session_fd, __u64 token, __u64 user_arg);
 
 int create_and_preserve_memfd(int session_fd, int token, const char *data);
 int restore_and_verify_memfd(int session_fd, int token, const char *expected_data);
diff --git a/tools/testing/selftests/liveupdate/lib/lu_utils.c b/tools/testing/selftests/liveupdate/lib/lu_utils.c
index 74d41115c281..db7a90b002cb 100644
--- a/tools/testing/selftests/liveupdate/lib/lu_utils.c
+++ b/tools/testing/selftests/liveupdate/lib/lu_utils.c
@@ -79,12 +79,14 @@ int luo_retrieve_session(int luo_fd, const char *name)
 	return arg.fd;
 }
 
-int luo_session_preserve_fd(int session_fd, int fd, __u64 token)
+int luo_session_preserve_fd_arg(int session_fd, int fd, __u64 token,
+				__u64 user_arg)
 {
 	struct liveupdate_session_preserve_fd arg = {
 		.size = sizeof(arg),
 		.fd = fd,
 		.token = token,
+		.arg = user_arg,
 	};
 
 	if (ioctl(session_fd, LIVEUPDATE_SESSION_PRESERVE_FD, &arg))
@@ -93,11 +95,17 @@ int luo_session_preserve_fd(int session_fd, int fd, __u64 token)
 	return 0;
 }
 
-int luo_session_retrieve_fd(int session_fd, __u64 token)
+int luo_session_preserve_fd(int session_fd, int fd, __u64 token)
+{
+	return luo_session_preserve_fd_arg(session_fd, fd, token, 0);
+}
+
+int luo_session_retrieve_fd_arg(int session_fd, __u64 token, __u64 user_arg)
 {
 	struct liveupdate_session_retrieve_fd arg = {
 		.size = sizeof(arg),
 		.token = token,
+		.arg = user_arg,
 	};
 
 	if (ioctl(session_fd, LIVEUPDATE_SESSION_RETRIEVE_FD, &arg))
@@ -106,6 +114,11 @@ int luo_session_retrieve_fd(int session_fd, __u64 token)
 	return arg.fd;
 }
 
+int luo_session_retrieve_fd(int session_fd, __u64 token)
+{
+	return luo_session_retrieve_fd_arg(session_fd, token, 0);
+}
+
 /* Helper function to get a session name via ioctl. */
 int luo_get_session_name(int session_fd, char *name, size_t name_len)
 {
diff --git a/tools/testing/selftests/liveupdate/liveupdate.c b/tools/testing/selftests/liveupdate/liveupdate.c
index 2dedd5fc2534..8b6e61695a35 100644
--- a/tools/testing/selftests/liveupdate/liveupdate.c
+++ b/tools/testing/selftests/liveupdate/liveupdate.c
@@ -20,6 +20,7 @@
 
 #include <errno.h>
 #include <fcntl.h>
+#include <stddef.h>
 #include <string.h>
 #include <sys/ioctl.h>
 #include <unistd.h>
@@ -530,4 +531,51 @@ TEST_F(liveupdate_device, preserve_many_files)
 	ASSERT_EQ(close(session_fd), 0);
 }
 
+/*
+ * Test Case: Preserve MemFD with User Argument
+ *
+ * Verifies that passing a non-zero user argument to memfd preservation fails
+ * with -EOPNOTSUPP, while passing a zero argument or using the minimum struct
+ * size without the arg field succeeds.
+ */
+TEST_F(liveupdate_device, preserve_memfd_with_arg)
+{
+	struct liveupdate_session_preserve_fd min_arg = {};
+	int session_fd, mem_fd1, mem_fd2;
+
+	self->fd1 = open(LIVEUPDATE_DEV, O_RDWR);
+	if (self->fd1 < 0 && errno == ENOENT)
+		SKIP(return, "%s does not exist", LIVEUPDATE_DEV);
+	ASSERT_GE(self->fd1, 0);
+
+	session_fd = luo_create_session(self->fd1, "preserve-arg-test");
+	ASSERT_GE(session_fd, 0);
+
+	mem_fd1 = memfd_create("arg-memfd-1", 0);
+	ASSERT_GE(mem_fd1, 0);
+
+	/* Non-zero arg is not supported by memfd handler */
+	EXPECT_EQ(luo_session_preserve_fd_arg(session_fd, mem_fd1, 0x1111, 1),
+		  -EOPNOTSUPP);
+
+	/*
+	 * Legacy struct size (up to token) should succeed. The kernel must
+	 * ignore arg, so set it to a value the memfd handler would reject.
+	 */
+	min_arg.size = offsetof(struct liveupdate_session_preserve_fd, arg);
+	min_arg.fd = mem_fd1;
+	min_arg.token = 0x1111;
+	min_arg.arg = 1;
+	ASSERT_EQ(ioctl(session_fd, LIVEUPDATE_SESSION_PRESERVE_FD, &min_arg), 0);
+
+	/* Explicit zero arg with full struct size should also succeed */
+	mem_fd2 = memfd_create("arg-memfd-2", 0);
+	ASSERT_GE(mem_fd2, 0);
+	ASSERT_EQ(luo_session_preserve_fd_arg(session_fd, mem_fd2, 0x2222, 0), 0);
+
+	ASSERT_EQ(close(session_fd), 0);
+	ASSERT_EQ(close(mem_fd1), 0);
+	ASSERT_EQ(close(mem_fd2), 0);
+}
+
 TEST_HARNESS_MAIN
-- 
2.56.1.809.ga0b61035b5-goog


