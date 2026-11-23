Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52233606A68D
	for <kexec@archiver.kernel.org>; Mon, 23 Nov 2026 23:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=NM5/IwLQ;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=E72qA2B+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=TfpmwInLEGo5frDChwR3ktzWoQYmqPnvABEvfJfxR3I=; b=NM5/IwLQ9DCFVP7FD6gdidLWPA
	AtzSlhmwWEpV7v9RQDJ74puJkHzg2Vs2bdPIum0WKWUIQi8nQd0no7fFm+gmcC8sMzhsTpH9IwEzs
	Ouynfp/PseQNjy9GDxliuf6//Eq5slUpniEQqQTXeeuicg530izPLzupNOQ4EL21wEqJCNPuu7neM
	2lGXtORpYFg5o8pxP3eZyGxbG93O0rOBYUKbMFrnfIs4y10EqYBgFJ8CIt3MEMSpjCblTI3OpE/Nu
	UWxlsPewxNBpM7/O0vGgXxTq+Zy/IT/bHTAhP9q0jXskmCAp8jow2nTVX4hgCQPrsVunwfP+OZO6G
	4w/gsZqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVddg-00000005BrO-3jk5;
	Mon, 23 Nov 2026 23:40:00 +0000
Received: from mail-oi1-x247.google.com ([2607:f8b0:4864:20::247])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVddb-00000005Bjm-2Hf8
	for kexec@lists.infradead.org;
	Mon, 23 Nov 2026 23:39:57 +0000
Received: by mail-oi1-x247.google.com with SMTP id 5614622812f47-4e937c5bd4fso3393377b6e.2
        for <kexec@lists.infradead.org>; Mon, 23 Nov 2026 15:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795477194; x=1796081994; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TfpmwInLEGo5frDChwR3ktzWoQYmqPnvABEvfJfxR3I=;
        b=E72qA2B+JDQbtEBqvbGhivJuuGghDevVizwpkDxqidzgA03wRzVPGiHqXXFnN2DR4N
         P3MtfownicivCH/FRnlS05LwiaCDQaiKS2h4zkotnH++wRjuUrRrVuYZ4rgy79M+h7MS
         3ZXPNhhOrQaf9cpEacpf+1kAgJWGvTSgzdM0qSLWC8yJssMPDK3Guwkv0jA+iQqjkzM/
         9Y67Ww4TTYqC13zMnGZgoXBBmWeLsDemy9ixn2k9Xp8kOwookat7T9y9R7eT2hUzPQGD
         bk6r910k2VEHVM7UP2+sIeakdxu2ozGLIothjJyJ9WHed/TotIgR+qm3ChCVnUS0hlaa
         M5Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795477194; x=1796081994;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TfpmwInLEGo5frDChwR3ktzWoQYmqPnvABEvfJfxR3I=;
        b=X2ePSWY8NaCoOLr+B5xXjgQbC/ZxqjXzKvZUhYqpYgKHRNMFNxyOgUQw3aUfYKp1ZU
         lLGL3ni3smOgjKXkiq3WGQBoUb0eMKrRWJAa8Irs7zXgEKtD/JUUAIGwOHviEjBIypaN
         UEDD04HXIIwTn5BccydHDQ/9AfVJTQqCr1rQtpLvbZvl6ZtkIIzo8zztSp2rSmg+XJYn
         zELZzwgjOjnLXYk/oxj6kzFxN44u9MBGPMBtIe1SOQTlNzSyrVbEeONr/CNKQ+3ysO4E
         /aOVQikPMavzGV7MVmC0GBAtjuRs6zmfzMZJBbynPC2ADCOouy6H6yuPViKM0+L6kw99
         B7Xg==
X-Gm-Message-State: APuU4Z92w/mowN+cJsquw56kGrGv9KVEbbKwasQ7tmraIzDNYYUc0Q4H
	nO6SjfjLgJp9a0Q050WYSDiaJ3vlwD/aoDF+KCZxluipM5ha7epga2Ht28v8lZk36gGQt+v37EI
	Map7IO1zpfZ4pwfmIcZ9prBOmMmN9RRAc6KwpINeuuMNMdSRxvVHQKGhl9RGm5oLpWOPsskvo21
	3YyDm8yO6mRBDLI9BFWC8EsqP/CZBzr36XoqLXxoqqwKqTdlhpICs=
X-Received: from jats20.prod.google.com ([2002:a05:6638:2594:b0:61c:f132:938b])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:c3d2:b0:579:293a:52ac with SMTP id 5614622812f47-57a06a0f737mr14141383b6e.9.1795477193657;
 Mon, 23 Nov 2026 15:39:53 -0800 (PST)
Date: Mon, 23 Nov 2026 23:39:23 +0000
In-Reply-To: <20261123233924.3970932-1-dmatlack@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261123233924.3970932-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261123233924.3970932-19-dmatlack@google.com>
Subject: [PATCH v5 18/18] selftests/liveupdate: Test block accounting of
 retrieved tmpfs files
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
X-CRM114-CacheID: sfid-20261123_153955_633180_D1B171B1 
X-CRM114-Status: GOOD (  31.73  )
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

Add test cases to luo_tmpfs for how the blocks of a retrieved file are
charged: The file fits a mount of exactly its size, and a large folio
that extends past the end of the file is charged in full. Running out of
space on the mount, or hitting the memcg limit, fails permanently,
leaves the target empty and nothing charged to the mount or the memcg,
and the session can still be finished.

Enable CONFIG_TRANSPARENT_HUGEPAGE for the large folio test cases, and
CONFIG_CGROUPS and CONFIG_MEMCG for the memcg test case. They are
skipped without them.

tmpfs quotas are not tested.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/testing/selftests/liveupdate/config     |   3 +
 .../testing/selftests/liveupdate/luo_tmpfs.c  | 283 +++++++++++++++++-
 2 files changed, 284 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/liveupdate/config b/tools/testing/selftests/liveupdate/config
index 37230f4c488f..7f38291c979d 100644
--- a/tools/testing/selftests/liveupdate/config
+++ b/tools/testing/selftests/liveupdate/config
@@ -1,4 +1,5 @@
 CONFIG_BLK_DEV_INITRD=y
+CONFIG_CGROUPS=y
 CONFIG_DEVTMPFS=y
 CONFIG_KEXEC_FILE=y
 CONFIG_KEXEC_HANDOVER=y
@@ -7,7 +8,9 @@ CONFIG_KEXEC_HANDOVER_DEBUGFS=y
 CONFIG_KEXEC_HANDOVER_DEBUG=y
 CONFIG_LIVEUPDATE=y
 CONFIG_LIVEUPDATE_TEST=y
+CONFIG_MEMCG=y
 CONFIG_MEMFD_CREATE=y
 CONFIG_TMPFS=y
 CONFIG_TMPFS_XATTR=y
 CONFIG_SHMEM=y
+CONFIG_TRANSPARENT_HUGEPAGE=y
diff --git a/tools/testing/selftests/liveupdate/luo_tmpfs.c b/tools/testing/selftests/liveupdate/luo_tmpfs.c
index 7911ac28188f..df2bc1488c01 100644
--- a/tools/testing/selftests/liveupdate/luo_tmpfs.c
+++ b/tools/testing/selftests/liveupdate/luo_tmpfs.c
@@ -62,8 +62,9 @@
 
 /*
  * Everything happens on a tmpfs mounted at TEST_DIR. In stage 1, the source
- * files are created on the tmpfs mounted at TEST_DIR/src. In stage 2, each
- * case runs in the directory TEST_DIR/<name of the case>.
+ * files are created on the tmpfs mounted at TEST_DIR/src, or at
+ * TEST_DIR/src_huge for files that need large folios. In stage 2, each case
+ * runs in the directory TEST_DIR/<name of the case>.
  */
 #define TEST_DIR		"/luo_tmpfs"
 
@@ -145,6 +146,7 @@ struct test_case {
 static unsigned long page_size;
 static int dev_fd;
 static int session_fd;
+static bool have_huge_src;
 
 /* nolibc doesn't have these, so use syscall() where needed. */
 static int do_fcntl(int fd, int cmd, long arg)
@@ -213,6 +215,16 @@ static long mnt_used(const char *path)
 	return buf.f_blocks - buf.f_bfree;
 }
 
+static long mnt_free(const char *path)
+{
+	struct statfs buf;
+
+	if (do_statfs(path, &buf))
+		return -1;
+
+	return buf.f_bfree;
+}
+
 /* Mount a tmpfs with room for @pages pages at @dir. */
 static int mount_tmpfs(const char *dir, unsigned long pages, const char *opts)
 {
@@ -248,6 +260,26 @@ static long read_long(const char *path)
 	return strtol(buf, NULL, 10);
 }
 
+/* Write @str to the file at @path. Return 0 or -errno. */
+static int write_file(const char *path, const char *str)
+{
+	ssize_t len = strlen(str), ret;
+	int fd;
+
+	fd = open(path, O_WRONLY);
+	if (fd < 0)
+		return -errno;
+
+	ret = write(fd, str, len);
+	if (ret != len)
+		ret = ret < 0 ? -errno : -EIO;
+	else
+		ret = 0;
+
+	close(fd);
+	return ret;
+}
+
 /* Retrieve with the argument @arg. Return the new fd or -errno. */
 static int retrieve_arg(__u64 token, struct liveupdate_shmem_retrieve_arg *arg)
 {
@@ -462,6 +494,33 @@ static int preserve_memfd(struct test_case *tc, unsigned int flags,
 	return ret;
 }
 
+/* Preserve a file from the tmpfs mounted with huge=always. */
+static int preserve_huge_file(struct test_case *tc)
+{
+	char path[128];
+	int fd, ret;
+
+	if (!have_huge_src)
+		return KSFT_SKIP;
+
+	snprintf(path, sizeof(path), "src_huge/%s", tc->name);
+	fd = create_source(path, tc->size, tc->token);
+	CHECK(fd >= 0);
+
+	/* The test needs the last, partial page to be in a large folio. */
+	if (tc->size % page_size && file_pages(fd) <= nr_pages(tc->size)) {
+		ksft_print_msg("%s: No large folio for the source file\n",
+			       tc->name);
+		close(fd);
+		return KSFT_SKIP;
+	}
+
+	ret = preserve_fd(fd, tc->pos, tc->token);
+	close(fd);
+
+	return ret;
+}
+
 /* Skip a case whose source file couldn't be preserved in stage 1. */
 static int skip_not_preserved(struct test_case *tc)
 {
@@ -1335,6 +1394,186 @@ static int exec_after_finish(struct test_case *tc)
 	return KSFT_PASS;
 }
 
+static int mount_fits_verify(struct test_case *tc)
+{
+	unsigned long pages = nr_pages(tc->size);
+	int fd;
+
+	/* The file can be retrieved into a mount it fits exactly. */
+	CHECK_EQ(mount_tmpfs("fit", pages, NULL), 0);
+	fd = retrieve_new(tc->token, "fit");
+	CHECK(fd >= 0);
+	TRY(check_restored(tc, fd));
+	CHECK_EQ(mnt_used("fit"), pages);
+	CHECK_EQ(mnt_free("fit"), 0);
+
+	CHECK_EQ(ftruncate(fd, 0), 0);
+	CHECK_EQ(mnt_used("fit"), 0);
+
+	close(fd);
+	return KSFT_PASS;
+}
+
+static int mount_too_small_verify(struct test_case *tc)
+{
+	unsigned long pages = nr_pages(tc->size);
+	int target;
+
+	/* The failure leaves the target empty, and the mount untouched... */
+	CHECK_EQ(mount_tmpfs("small", pages - 1, NULL), 0);
+	target = new_target("small");
+	CHECK(target >= 0);
+	CHECK_EQ(retrieve_into(tc->token, target), -ENOSPC);
+	CHECK_EQ(file_size(target), 0);
+	CHECK_EQ(file_pages(target), 0);
+	CHECK_EQ(mnt_used("small"), 0);
+	close(target);
+
+	/*
+	 * ... but the preserved contents were restored before it was detected,
+	 * so the failure is permanent. Finishing the session frees them.
+	 */
+	CHECK_EQ(mount_tmpfs("big", pages, NULL), 0);
+	CHECK_EQ(retrieve_new(tc->token, "big"), -ENOSPC);
+	CHECK_EQ(luo_session_retrieve_fd(session_fd, tc->token), -ENOSPC);
+	CHECK_EQ(mnt_used("big"), 0);
+
+	return KSFT_PASS;
+}
+
+static int huge_folios_verify(struct test_case *tc)
+{
+	unsigned long pages = nr_pages(tc->size);
+	int fd;
+
+	CHECK_EQ(mount_tmpfs("dst", pages, "huge=never"), 0);
+	fd = retrieve_new(tc->token, "dst");
+	if (fd == -ENOENT)
+		return skip_not_preserved(tc);
+	CHECK(fd >= 0);
+	TRY(check_restored(tc, fd));
+	CHECK_EQ(mnt_used("dst"), pages);
+
+	/* LUO keeps a reference to the file until the session is finished. */
+	close(fd);
+	CHECK_EQ(mnt_used("dst"), pages);
+
+	return KSFT_PASS;
+}
+
+static int huge_folios_after_finish(struct test_case *tc)
+{
+	CHECK_EQ(mnt_used("dst"), 0);
+	return KSFT_PASS;
+}
+
+static int huge_folio_tail_verify(struct test_case *tc)
+{
+	long pages;
+	int fd;
+
+	CHECK_EQ(mount_tmpfs("dst", 4096, "huge=never"), 0);
+	fd = retrieve_new(tc->token, "dst");
+	if (fd == -ENOENT)
+		return skip_not_preserved(tc);
+	CHECK(fd >= 0);
+	CHECK_EQ(file_size(fd), tc->size);
+	TRY(check_contents(fd, tc->size, tc->token));
+
+	/* The whole folio is charged, including the part past EOF. */
+	pages = file_pages(fd);
+	CHECK(pages > 1);
+	CHECK_EQ(mnt_used("dst"), pages);
+
+	CHECK_EQ(ftruncate(fd, 0), 0);
+	CHECK_EQ(mnt_used("dst"), 0);
+
+	close(fd);
+	return KSFT_PASS;
+}
+
+static int huge_folio_tail_enospc_verify(struct test_case *tc)
+{
+	int ret;
+
+	/* There is room for the file, but not for its last folio. */
+	CHECK_EQ(mount_tmpfs("small", 1, "huge=never"), 0);
+	ret = retrieve_new(tc->token, "small");
+	if (ret == -ENOENT)
+		return skip_not_preserved(tc);
+	CHECK_EQ(ret, -ENOSPC);
+	CHECK_EQ(mnt_used("small"), 0);
+
+	return KSFT_PASS;
+}
+
+static int memcg_limit_child(struct test_case *tc)
+{
+	long limit = tc->size / 2, usage;
+	int ret;
+
+	/*
+	 * Charging a large folio doesn't invoke the memcg OOM killer, but the
+	 * source may have gotten small folios. Protect the child, so that the
+	 * retrieve fails with -ENOMEM instead.
+	 */
+	CHECK_EQ(write_file("/proc/self/oom_score_adj", "-1000"), 0);
+	CHECK_EQ(write_file("memcg/small/cgroup.procs", "0"), 0);
+
+	/* The folios are charged to the memcg of the caller, which is full. */
+	ret = retrieve_new(tc->token, "dst");
+	if (ret == -ENOENT)
+		return skip_not_preserved(tc);
+	CHECK_EQ(ret, -ENOMEM);
+
+	/* The failure leaves the mount and the memcg untouched. */
+	CHECK_EQ(mnt_used("dst"), 0);
+	usage = read_long("memcg/small/memory.current");
+	CHECK(usage >= 0 && usage < limit);
+
+	return KSFT_PASS;
+}
+
+static int memcg_limit_verify(struct test_case *tc)
+{
+	unsigned long pages = nr_pages(tc->size);
+	char limit[32];
+	int ret;
+
+	CHECK_EQ(mkdir("memcg", 0755), 0);
+	if (do_mount("cgroup2", "memcg", "cgroup2", 0, NULL)) {
+		ksft_print_msg("%s: cgroup2 is not available\n", tc->name);
+		return KSFT_SKIP;
+	}
+	if (write_file("memcg/cgroup.subtree_control", "+memory")) {
+		ksft_print_msg("%s: The memory controller is not available\n",
+			       tc->name);
+		return KSFT_SKIP;
+	}
+
+	CHECK_EQ(mount_tmpfs("dst", pages, "huge=never"), 0);
+
+	/* A memcg without room for the file. */
+	CHECK_EQ(mkdir("memcg/small", 0755), 0);
+	snprintf(limit, sizeof(limit), "%zu", tc->size * 3 / 4);
+	ret = write_file("memcg/small/memory.max", limit);
+	if (ret) {
+		ksft_print_msg("%s: Can't set memory.max: %d\n", tc->name, ret);
+		ret = KSFT_FAIL;
+	} else {
+		ret = run_child(memcg_limit_child, tc);
+	}
+	rmdir("memcg/small");
+	if (ret != KSFT_PASS)
+		return ret;
+
+	/* The preserved contents were restored, so the failure is permanent. */
+	CHECK_EQ(retrieve_new(tc->token, "dst"), -ENOMEM);
+	CHECK_EQ(mnt_used("dst"), 0);
+
+	return KSFT_PASS;
+}
+
 static int memfd_preserve(struct test_case *tc)
 {
 	return preserve_memfd(tc, 0, 0);
@@ -1661,6 +1900,42 @@ static struct test_case test_cases[] = {
 		.verify = exec_verify,
 		.after_finish = exec_after_finish,
 	},
+	/* Block accounting. */
+	{
+		.name = "mount_fits",
+		.size = 2 << 20,
+		.verify = mount_fits_verify,
+	},
+	{
+		.name = "mount_too_small",
+		.size = 2 << 20,
+		.verify = mount_too_small_verify,
+	},
+	{
+		.name = "huge_folios",
+		.size = 4 << 20,
+		.preserve = preserve_huge_file,
+		.verify = huge_folios_verify,
+		.after_finish = huge_folios_after_finish,
+	},
+	{
+		.name = "huge_folio_tail",
+		.size = 100,
+		.preserve = preserve_huge_file,
+		.verify = huge_folio_tail_verify,
+	},
+	{
+		.name = "huge_folio_tail_enospc",
+		.size = 100,
+		.preserve = preserve_huge_file,
+		.verify = huge_folio_tail_enospc_verify,
+	},
+	{
+		.name = "memcg_limit",
+		.size = 4 << 20,
+		.preserve = preserve_huge_file,
+		.verify = memcg_limit_verify,
+	},
 	/* memfds. */
 	{
 		.name = "memfd",
@@ -1765,6 +2040,10 @@ static void run_stage_1(int luo_fd)
 	if (chdir(TEST_DIR) || mount_tmpfs("src", 4096, "huge=never"))
 		fail_exit("Failed to mount the source tmpfs");
 
+	have_huge_src = !mount_tmpfs("src_huge", 4096, "huge=always");
+	if (!have_huge_src)
+		ksft_print_msg("[STAGE 1] huge=always is not supported\n");
+
 	session_fd = luo_create_session(luo_fd, SESSION_NAME);
 	if (session_fd < 0)
 		fail_exit("luo_create_session for '%s'", SESSION_NAME);
-- 
2.56.1.809.ga0b61035b5-goog


