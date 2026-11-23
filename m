Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1A0606A32C
	for <kexec@archiver.kernel.org>; Mon, 23 Nov 2026 23:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=X8kAIFDv;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=ttks1Iqy;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=p1Kg7ySl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=oKSzBSU95DdRnrRamRQphUTqqkxr3KYrkXppzoiSkmM=; b=X8kAIFDvPrdRlfv7KHB/HPqVDS
	VP4YxrRiWY99RE/2JVGO750f1MNJhbdNNnWHODF0UwRboC61/RpWLDu6lXstTq+LCwtccQFgYoEFQ
	1ZM3m4B/436X2bodKFLN+KlUEZLyFf8OQYi5S9TIBcDXl8nzjozqU2Yr8WUFxbrr5KHiYrBtpTGk6
	Ksx0GvjCHLDiSprF3TIxnqMqSgrRFvKFs3MUuz04U1P6TO58fpbR7Yhy2KUEl6kLLlH6rTqG/NOJk
	dyAGX8R3cEHr5B8TRaHOGHVSmPhIXyPb20EgOvh1FoaZa4O3E+EIXIwIKvgXNyBzTJE+26z09aKD4
	DZNUY9Bg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVddm-00000005Bx6-3Dx7;
	Mon, 23 Nov 2026 23:40:06 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVddi-00000005Bqc-3K7o
	for kexec@bombadil.infradead.org;
	Mon, 23 Nov 2026 23:40:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:Cc:To:From:Subject:
	Message-ID:References:Mime-Version:In-Reply-To:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oKSzBSU95DdRnrRamRQphUTqqkxr3KYrkXppzoiSkmM=; b=ttks1IqyFz0PBk9xe/UAunDKZk
	XPNwfgt73e16f3NvHJb/CMvHbdcBIvKxKxnEFRGFRzkmHLSkabo3bhEvd6zl+X6e6y6bgh0ESPqp5
	Z//+v7vL1bVCS+B2v59nGoyiF9HC2rGbJgw5jWLDhNebhyNufot0P5get88lt2na2u917sIrwo8RV
	5RwqBq26d1JLfZSRpEiksFf8WCPLSxXiQEqTP5+IGc4u60zxHo4n8n5V0SkUKke3Tod55FvXYU4xz
	yTvfNSL55NV1WgAA5O1QM0fTpdCu7dOjvSJn0lfpI72kGU4ly3JbvcaaayOEB8xTTHJsOHqg/gybw
	aNMQZaSQ==;
Received: from mail-oi1-f200.google.com ([209.85.167.200])
	by casper.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVddZ-0000000AWLt-29tU
	for kexec@lists.infradead.org;
	Mon, 23 Nov 2026 23:39:56 +0000
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4a41f46d629so5746622b6e.3
        for <kexec@lists.infradead.org>; Mon, 23 Nov 2026 15:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795477190; x=1796081990; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oKSzBSU95DdRnrRamRQphUTqqkxr3KYrkXppzoiSkmM=;
        b=p1Kg7ySl+uK5yI5sO6giYGux0wNNB1Fm8BPKor7aJ06znTzhVJGgT/2IxHNeVurRE0
         5jTIs4w3tDNbJ2ZUVeSHidWAsa9MptOnW+w2QhX36G8KG1roSvy5Zup0BUSwNXorpM+h
         6Wb76S+VKa683bKt4m35eCbjT8M3F8KFagBYx+koVclxsF/4S2vdNGBhUfyChNNDst+i
         6GF1HMpi2GKQzAxtkPPBwdNGfhn5xAQeL63TGXGKkORAn8E/MJ/Xg/2+RaULzeAbtPpU
         EhRaskazcaLvjpZMYPS7W9y8309++7LDelfu0kw6fRUYdaWWCf3qgdSdcVEH0SksERjd
         qbeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795477190; x=1796081990;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oKSzBSU95DdRnrRamRQphUTqqkxr3KYrkXppzoiSkmM=;
        b=CwClugtMpUvLhoLvE9zD/CDF9H4Qi8fdGdWmDQEJvs/UGiHJDr7sF/Cfd+zzxOMwY9
         Q4MzkAZIwyeoMTD8Jr8dRFkqBv99CQ3mRWNg+GxvEnMXxS20aM7whTOyPSzYiHalZGov
         IgZtaQN05Du+zx/C72A7AgLt2+sHmE4yhd0aHtjjA6WrpAUaHon1m/FJYGveEyqe/ebh
         QK2RG0dwg4N5Zy+lbgqW/XzHv/DqhYUPF6gGbJOYvQkwBEgIrUstPQ8AwUNba6TU9w3r
         qKgcKHktIJkutcJmXrIfpVs6ZBaCTtlGugHuj1n/P2JyyxtTU6WyUrPKPnFAbrPB13a8
         TgQg==
X-Gm-Message-State: APuU4Z/f7jXu0fgMSBmlJAJdWVnSgKwjLjOiBSfwv4W7vQzgjRFHQdGK
	8tlV47ohxnCnUF57fYOjQjjweEhAzYtfobhwfUaqNMD/ctQx8lubF8CMApue9MZUp+ARYEa4jXH
	yVTF1c01HfX78YxuPoDy2UezAK4vAHZvml8wYIhxK+YUDRhmFG+9zKerSAFT5+mJHYuj8TuZWTA
	mdAzvTYSCz430zipoZgA9vk7YmKM/fzMUTyitmZ7Mb5xVS1W7AUzQ=
X-Received: from ioxg21.prod.google.com ([2002:a05:6602:735:b0:9c7:7f8f:934f])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:6415:b0:4d6:92d4:c806 with SMTP id 5614622812f47-57a0ab2fe9cmr13357792b6e.62.1795477189692;
 Mon, 23 Nov 2026 15:39:49 -0800 (PST)
Date: Mon, 23 Nov 2026 23:39:20 +0000
In-Reply-To: <20261123233924.3970932-1-dmatlack@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261123233924.3970932-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261123233924.3970932-16-dmatlack@google.com>
Subject: [PATCH v5 15/18] selftests/liveupdate: Test memfds and LUO
 interactions in luo_tmpfs
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
X-CRM114-CacheID: sfid-20261123_233953_716129_113E571E 
X-CRM114-Status: GOOD (  24.15  )
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

Add test cases to luo_tmpfs that check that memfds are retrieved as
memfds, with their seals and file position, and only without a retrieve
argument, while tmpfs files can only be retrieved with one.

Also check that invalid retrieve arguments fail and can be retried after
fixing them. Retrieving a token again fails with -EBUSY with an
argument, and returns the same open file without one. Files can't be
retrieved from outgoing sessions. A file that LUO already manages can't
be the target, whether it is preserved in an outgoing session or was
already retrieved.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 .../testing/selftests/liveupdate/luo_tmpfs.c  | 312 ++++++++++++++++++
 1 file changed, 312 insertions(+)

diff --git a/tools/testing/selftests/liveupdate/luo_tmpfs.c b/tools/testing/selftests/liveupdate/luo_tmpfs.c
index 4a50b26d509e..47d4fd27d105 100644
--- a/tools/testing/selftests/liveupdate/luo_tmpfs.c
+++ b/tools/testing/selftests/liveupdate/luo_tmpfs.c
@@ -96,6 +96,19 @@
 	}								\
 } while (0)
 
+/* Check that a system call fails with @err. */
+#define CHECK_ERRNO(expr, err) do {					\
+	long __ret = (expr);						\
+	int __err = errno, __exp = (err);				\
+									\
+	if (__ret != -1 || __err != __exp) {				\
+		ksft_print_msg("%s:%d: %s: %ld, errno %d, expected %d\n", \
+			       __func__, __LINE__, #expr,		\
+			       __ret, __err, __exp);			\
+		return KSFT_FAIL;					\
+	}								\
+} while (0)
+
 /* Call a function that returns a KSFT_* code, and return if it fails. */
 #define TRY(expr) do {							\
 	int __ret = (expr);						\
@@ -121,6 +134,7 @@ struct test_case {
 };
 
 static unsigned long page_size;
+static int dev_fd;
 static int session_fd;
 
 /* nolibc doesn't have these, so use syscall() where needed. */
@@ -282,6 +296,15 @@ static int link_fd(int fd, const char *path)
 		       AT_SYMLINK_FOLLOW);
 }
 
+/* Open the file @fd again with @flags. */
+static int reopen_fd(int fd, int flags)
+{
+	char fd_path[64];
+
+	snprintf(fd_path, sizeof(fd_path), "/proc/self/fd/%d", fd);
+	return open(fd_path, flags);
+}
+
 /* The contents of the files depend on their token. */
 static unsigned char pattern(__u64 token, size_t offset)
 {
@@ -408,6 +431,23 @@ static int preserve_file(struct test_case *tc)
 	return preserve_source(path, tc->size, tc->pos, tc->token);
 }
 
+/* Preserve a memfd with the contents of the source of @tc. */
+static int preserve_memfd(struct test_case *tc, unsigned int flags,
+			  unsigned int seals)
+{
+	int fd, ret;
+
+	fd = memfd_create(tc->name, flags);
+	CHECK(fd >= 0);
+	CHECK_EQ(write_pattern(fd, 0, tc->size, tc->token), 0);
+	if (seals)
+		CHECK_EQ(do_fcntl(fd, F_ADD_SEALS, seals), 0);
+	ret = preserve_fd(fd, tc->pos, tc->token);
+	close(fd);
+
+	return ret;
+}
+
 /* Retrieve the file of @tc into a new file on a new mount at dst. */
 static int restore_verify(struct test_case *tc)
 {
@@ -584,6 +624,236 @@ static int linked_target_verify(struct test_case *tc)
 	return KSFT_PASS;
 }
 
+static int memfd_preserve(struct test_case *tc)
+{
+	return preserve_memfd(tc, 0, 0);
+}
+
+static int memfd_verify(struct test_case *tc)
+{
+	struct stat st;
+	int fd;
+
+	/* memfds are only retrieved as memfds. */
+	CHECK_EQ(mount_tmpfs("dst", 16, NULL), 0);
+	CHECK_EQ(retrieve_new(tc->token, "dst"), -EINVAL);
+	CHECK_EQ(mnt_used("dst"), 0);
+
+	fd = luo_session_retrieve_fd(session_fd, tc->token);
+	CHECK(fd >= 0);
+	TRY(check_restored(tc, fd));
+	CHECK(!fstat(fd, &st));
+	CHECK_EQ(st.st_nlink, 0);
+	CHECK_EQ(do_fcntl(fd, F_GETFL, 0) & O_ACCMODE, O_RDWR);
+
+	/* Unlike for tmpfs files, the file position is restored. */
+	CHECK_EQ(lseek(fd, 0, SEEK_CUR), tc->pos);
+
+	close(fd);
+	return KSFT_PASS;
+}
+
+#define MEMFD_SEALS		(F_SEAL_SHRINK | F_SEAL_GROW | F_SEAL_WRITE)
+
+static int sealed_memfd_preserve(struct test_case *tc)
+{
+	return preserve_memfd(tc, MFD_ALLOW_SEALING, MEMFD_SEALS);
+}
+
+static int sealed_memfd_verify(struct test_case *tc)
+{
+	void *p;
+	int fd;
+
+	fd = luo_session_retrieve_fd(session_fd, tc->token);
+	CHECK(fd >= 0);
+	TRY(check_restored(tc, fd));
+	CHECK_EQ(do_fcntl(fd, F_GET_SEALS, 0), MEMFD_SEALS);
+	CHECK_ERRNO(write(fd, "x", 1), EPERM);
+	CHECK_ERRNO(ftruncate(fd, 0), EPERM);
+	p = mmap(NULL, page_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
+	CHECK(p == MAP_FAILED && errno == EPERM);
+
+	close(fd);
+	return KSFT_PASS;
+}
+
+static int bad_args_verify(struct test_case *tc)
+{
+	struct {
+		struct liveupdate_shmem_retrieve_arg arg;
+		__u64 extra;
+	} big = {};
+	struct liveupdate_shmem_retrieve_arg arg;
+	int target, path_fd, fd;
+
+	CHECK_EQ(mount_tmpfs("dst", 16, NULL), 0);
+	target = new_target("dst");
+	CHECK(target >= 0);
+
+	/* Files from tmpfs mounts are only retrieved into files on tmpfs. */
+	CHECK_EQ(luo_session_retrieve_fd(session_fd, tc->token), -EINVAL);
+
+	memset(&arg, 0, sizeof(arg));
+	arg.size = sizeof(arg);
+	arg.fd = target;
+
+	/* Problems with the argument itself. */
+	arg.size = offsetof(struct liveupdate_shmem_retrieve_arg, fd);
+	CHECK(retrieve_arg(tc->token, &arg) < 0);
+	arg.size = 2 * page_size;
+	CHECK(retrieve_arg(tc->token, &arg) < 0);
+	arg.size = sizeof(arg);
+
+	big.arg = arg;
+	big.arg.size = sizeof(big);
+	big.extra = 1;
+	CHECK_EQ(retrieve_arg(tc->token, &big.arg), -E2BIG);
+
+	/* Problems with the file descriptor. */
+	arg.fd = -1;
+	CHECK_EQ(retrieve_arg(tc->token, &arg), -EBADF);
+	path_fd = reopen_fd(target, O_PATH);
+	CHECK(path_fd >= 0);
+	arg.fd = path_fd;
+	CHECK_EQ(retrieve_arg(tc->token, &arg), -EBADF);
+	close(path_fd);
+	arg.fd = target;
+
+	CHECK_EQ(retrieve_arg(tc->token + 1, &arg), -ENOENT);
+	CHECK_EQ(file_size(target), 0);
+	CHECK_EQ(mnt_used("dst"), 0);
+
+	/* The failures didn't consume the preserved file. */
+	fd = retrieve_arg(tc->token, &arg);
+	CHECK(fd >= 0);
+	TRY(check_restored(tc, fd));
+
+	close(fd);
+	close(target);
+	return KSFT_PASS;
+}
+
+static int retrieve_twice_verify(struct test_case *tc)
+{
+	struct stat st, new_st;
+	int target, fd, new_fd;
+
+	CHECK_EQ(mount_tmpfs("dst", 16, NULL), 0);
+	fd = retrieve_new(tc->token, "dst");
+	CHECK(fd >= 0);
+	TRY(check_restored(tc, fd));
+
+	/* The argument only applies to the retrieve that restores the file. */
+	target = new_target("dst");
+	CHECK(target >= 0);
+	CHECK_EQ(retrieve_into(tc->token, target), -EBUSY);
+	CHECK_EQ(file_size(target), 0);
+	close(target);
+
+	/* A plain retrieve returns the same open file. */
+	new_fd = luo_session_retrieve_fd(session_fd, tc->token);
+	CHECK(new_fd >= 0);
+	CHECK(!fstat(fd, &st));
+	CHECK(!fstat(new_fd, &new_st));
+	CHECK_EQ(new_st.st_dev, st.st_dev);
+	CHECK_EQ(new_st.st_ino, st.st_ino);
+	CHECK_EQ(lseek(new_fd, 77, SEEK_SET), 77);
+	CHECK_EQ(lseek(fd, 0, SEEK_CUR), 77);
+	CHECK_EQ(mnt_used("dst"), nr_pages(tc->size));
+
+	close(new_fd);
+	close(fd);
+	return KSFT_PASS;
+}
+
+static int preserve_nothing(struct test_case *tc)
+{
+	return KSFT_PASS;
+}
+
+static int outgoing_session_verify(struct test_case *tc)
+{
+	struct liveupdate_shmem_retrieve_arg arg = {
+		.size = sizeof(arg),
+	};
+	int out_fd, source_fd;
+
+	out_fd = luo_create_session(dev_fd, SESSION_NAME "_outgoing_session");
+	CHECK(out_fd >= 0);
+	CHECK_EQ(mount_tmpfs("src", 16, NULL), 0);
+	source_fd = new_target("src");
+	CHECK(source_fd >= 0);
+	CHECK_EQ(luo_session_preserve_fd(out_fd, source_fd, tc->token), 0);
+
+	/* Files can only be retrieved from incoming sessions. */
+	arg.fd = new_target("src");
+	CHECK(arg.fd >= 0);
+	CHECK(luo_session_retrieve_fd_arg(out_fd, tc->token,
+					  (__u64)(uintptr_t)&arg) < 0);
+
+	close(arg.fd);
+	close(source_fd);
+	close(out_fd);
+	return KSFT_PASS;
+}
+
+static int target_preserved_verify(struct test_case *tc)
+{
+	int out_fd, target;
+
+	/* A file preserved in an outgoing session can't be the target. */
+	out_fd = luo_create_session(dev_fd, SESSION_NAME "_target_preserved");
+	CHECK(out_fd >= 0);
+	CHECK_EQ(mount_tmpfs("dst", 16, NULL), 0);
+	target = new_target("dst");
+	CHECK(target >= 0);
+	CHECK_EQ(luo_session_preserve_fd(out_fd, target, tc->token), 0);
+	CHECK_EQ(retrieve_into(tc->token, target), -EBUSY);
+	CHECK_EQ(file_size(target), 0);
+
+	/* Once the session is closed, the file is no longer preserved. */
+	close(out_fd);
+	CHECK_EQ(retrieve_into(tc->token, target), target);
+	TRY(check_restored(tc, target));
+
+	close(target);
+	return KSFT_PASS;
+}
+
+static int target_retrieved_preserve(struct test_case *tc)
+{
+	TRY(preserve_source("src/target_retrieved_empty", 0, 0, tc->token));
+	return preserve_source("src/target_retrieved", tc->size, 0,
+			       tc->token + 1);
+}
+
+static int target_retrieved_verify(struct test_case *tc)
+{
+	int target, other_fd;
+
+	/* Retrieving an empty file leaves the target empty... */
+	CHECK_EQ(mount_tmpfs("dst", 16, NULL), 0);
+	target = new_target("dst");
+	CHECK(target >= 0);
+	CHECK_EQ(retrieve_into(tc->token, target), target);
+	CHECK_EQ(file_size(target), 0);
+
+	/* ... but LUO manages the file now, so it can't be a target again. */
+	CHECK_EQ(retrieve_into(tc->token + 1, target), -EBUSY);
+	CHECK_EQ(file_size(target), 0);
+
+	/* The failure didn't consume the preserved file. */
+	other_fd = retrieve_new(tc->token + 1, "dst");
+	CHECK(other_fd >= 0);
+	CHECK_EQ(file_size(other_fd), tc->size);
+	TRY(check_contents(other_fd, tc->size, tc->token + 1));
+
+	close(other_fd);
+	close(target);
+	return KSFT_PASS;
+}
+
 static struct test_case test_cases[] = {
 	/* The restored file. */
 	{
@@ -612,6 +882,47 @@ static struct test_case test_cases[] = {
 		.size = SMALL_SIZE,
 		.verify = linked_target_verify,
 	},
+	/* memfds. */
+	{
+		.name = "memfd",
+		.size = SMALL_SIZE,
+		.pos = 700,
+		.preserve = memfd_preserve,
+		.verify = memfd_verify,
+	},
+	{
+		.name = "sealed_memfd",
+		.size = SMALL_SIZE,
+		.preserve = sealed_memfd_preserve,
+		.verify = sealed_memfd_verify,
+	},
+	/* Interactions with LUO. */
+	{
+		.name = "bad_args",
+		.size = SMALL_SIZE,
+		.verify = bad_args_verify,
+	},
+	{
+		.name = "retrieve_twice",
+		.size = SMALL_SIZE,
+		.verify = retrieve_twice_verify,
+	},
+	{
+		.name = "outgoing_session",
+		.preserve = preserve_nothing,
+		.verify = outgoing_session_verify,
+	},
+	{
+		.name = "target_preserved",
+		.size = SMALL_SIZE,
+		.verify = target_preserved_verify,
+	},
+	{
+		.name = "target_retrieved",
+		.size = SMALL_SIZE,
+		.preserve = target_retrieved_preserve,
+		.verify = target_retrieved_verify,
+	},
 };
 
 static long read_taint(void)
@@ -641,6 +952,7 @@ static void setup(int luo_fd)
 {
 	unsigned int i;
 
+	dev_fd = luo_fd;
 	page_size = getpagesize();
 	umask(TEST_UMASK);
 
-- 
2.56.1.809.ga0b61035b5-goog


