Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24BBFC624D0
	for <kexec@archiver.kernel.org>; Tue,  1 Sep 2026 18:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EEIZgCOB2hl947kqAMQSV91Zoox41yoYUfb/qDb9/EY=; b=NOBHItfCbFLlBO57/203rSPuzS
	65qWZRWKlesHSzQphF9Dc9zWQW9PS1aUkt6GjQrd90lo/4iFzIgrO+X/5jUKhcItqFdyb8BAJmzoI
	IXopsZnjF9oYmx8LJACgjvCvrM/lG9u7GvkAtmgmcjCReV3KJPj06VNLlJ7A0knFqhkV5r0Do3GFh
	GY6y0mBFdfKhyXeL0kDovuOQtZFs6qB7Xp/nji5dMti8vD3SJ8iJbnjpxgQHjhN3ZvFW3IZb73AJH
	7xH+hYs4mhpq9LgQ9mgrfavZMe+nTbbSoDERXGBRhbvDHwib8J8VbQvw7KOnuphKUuv6+fjL/pNfN
	W3fhsXDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1StU-0000000Cuyp-3Qjg;
	Tue, 01 Sep 2026 18:07:36 +0000
Received: from mail-pj1-x1045.google.com ([2607:f8b0:4864:20::1045])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1StP-0000000Cuto-0ddY
	for kexec@lists.infradead.org;
	Tue, 01 Sep 2026 18:07:35 +0000
Received: by mail-pj1-x1045.google.com with SMTP id 98e67ed59e1d1-398dcfabbf8so284944a91.0
        for <kexec@lists.infradead.org>; Tue, 01 Sep 2026 11:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788286049; x=1788890849; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EEIZgCOB2hl947kqAMQSV91Zoox41yoYUfb/qDb9/EY=;
        b=OCBuvXbYodub4m1LH/9MugdgqWC2oYb/hgQMuANEEGT1cTmqkWCyqJtzRc7UVcYqSZ
         8VgLdzxVeO7EsTbEIpQULvS3rzc+nWIbWxghE4q2ovhmRteuJYUK14YstQeHUjoOxKxi
         f8PTPgVNNIbeqiB7R+B4L/QfloIas7n/0kQ4XuYDGVkmOA+1GaH1f1sV7+EnCX63opPe
         Yt0bNxSHyQmhuLh7mjjp6ZgJVz2lBoaVyh4mAeFxThvhUbZZxwCPg7iyEhoofnFXDzsM
         ZBNDoMLcbHjzbpxk2ty6LTZI8g6vOCHqlNFUe2Jd0R5Udpu783tXSeSipBg3J04/LQow
         61Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788286049; x=1788890849;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EEIZgCOB2hl947kqAMQSV91Zoox41yoYUfb/qDb9/EY=;
        b=bfvjF4W1Lq/7SITA1tHJWOfWVWEz+LhNx5m7csWJL+BGfUZXkHIeeuyi6HtzaVQi5m
         GYVvR4eOk0bXMbam4iQhngrhU2YIHwnFWzDk6CGA3YGdU5vzI5XkaeFpCiFaU1D5F7yy
         5NdULIZ8m/0yyU8g88RuiTTlqf+NqRcPDi34pVkYAt89ubyo071KtXzTD+aK1OhZGqS9
         y/ust7eQKcv9IuG4RXlXTV2G7PkWGVSE5lTbiGLPto6aJMZR5As4PXSec1XxiCi9LeNc
         m0taM5z/Ba9z0MrOlY2VbQ40mMbHjCAHSZjVh3ePLA6mivEqWyjQE29/TEyL3cHIu4ul
         YVZQ==
X-Gm-Message-State: AFuF++mdD1QG+KydSp+acicg1qwBHyMJy4GSczvVlfBPGa5BbKh3V5GG
	PD7GvmX/yi0eEDNqniIHe8rkYfjNC0FgN4BPE5XNEqTN07zxuLhjTYIW2O4uu9oJh/yUdoPues6
	HS3HvB0spgPkISNLi4isYY/2VruVJjqMjHSDx/ya3jUR6HgIwwSQ6AjL/NKA85Pw+WsECAo22Wo
	QZkcgqlH1pIbKNXSeECpGKSKkVQMdiqwsRdnFF7gaECISI8hUiZNA=
X-Received: from pjbiy13.prod.google.com ([2002:a17:90b:16cd:b0:38e:b470:e6db])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3fcf:b0:398:9be5:b419 with SMTP id 98e67ed59e1d1-3989be5b4camr43204014a91.20.1788286048322;
 Tue, 01 Sep 2026 11:07:28 -0700 (PDT)
Date: Tue,  1 Sep 2026 18:07:13 +0000
In-Reply-To: <20260901180713.4185641-1-dmatlack@google.com>
Mime-Version: 1.0
References: <20260901180713.4185641-1-dmatlack@google.com>
X-Mailer: git-send-email 2.55.0.966.g6673acef38-goog
Message-ID: <20260901180713.4185641-6-dmatlack@google.com>
Subject: [RFC PATCH 5/5] selftests: liveupdate: Add multi-session test
 coverage for session_retrieve_into
From: David Matlack <dmatlack@google.com>
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <shuah@kernel.org>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260901_110731_195595_2986C49D 
X-CRM114-Status: GOOD (  17.17  )
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

Extend the multi-session Live Update test to specifically verify the new
LIVEUPDATE_SESSION_RETRIEVE_INTO_FD ioctl path. In Stage 2 of the kexec
workflow, the test explicitly delegates topology by allocating a clean
tmpfs target and driving the folios into it through the new API,
verifying that the data preserves identically to the native KHO mapping.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 .../liveupdate/lib/include/libliveupdate.h    |  1 +
 .../selftests/liveupdate/lib/lu_utils.c       | 33 +++++++++++
 .../selftests/liveupdate/luo_multi_session.c  | 56 ++++++++++++++++---
 3 files changed, 83 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/liveupdate/lib/include/libliveupdate.h b/tools/testing/selftests/liveupdate/lib/include/libliveupdate.h
index fa07fed08364..8ab1e662eeaa 100644
--- a/tools/testing/selftests/liveupdate/lib/include/libliveupdate.h
+++ b/tools/testing/selftests/liveupdate/lib/include/libliveupdate.h
@@ -33,6 +33,7 @@ int luo_session_retrieve_fd(int session_fd, __u64 token);
 
 int create_and_preserve_memfd(int session_fd, int token, const char *data);
 int restore_and_verify_memfd(int session_fd, int token, const char *expected_data);
+int luo_verify_retrieve_into_memfd(int session_fd, int token, int mfd, const char *expected_data);
 
 void create_state_file(int luo_fd, const char *session_name, int token,
 		       int next_stage);
diff --git a/tools/testing/selftests/liveupdate/lib/lu_utils.c b/tools/testing/selftests/liveupdate/lib/lu_utils.c
index 74d41115c281..8ed9c367f92e 100644
--- a/tools/testing/selftests/liveupdate/lib/lu_utils.c
+++ b/tools/testing/selftests/liveupdate/lib/lu_utils.c
@@ -324,3 +324,36 @@ int luo_test(int argc, char *argv[],
 
 	return 0;
 }
+
+int luo_verify_retrieve_into_memfd(int session_fd, int token, int mfd,
+				   const char *expected_data)
+{
+	struct liveupdate_session_retrieve_into_fd retrieve_args = {
+		.size = sizeof(retrieve_args),
+		.token = token,
+		.fd = mfd,
+	};
+	long page_size = getpagesize();
+	void *map = MAP_FAILED;
+	int ret = -1;
+
+	ret = ioctl(session_fd, LIVEUPDATE_SESSION_RETRIEVE_INTO_FD, &retrieve_args);
+	if (ret < 0) {
+		ksft_print_msg("ioctl LIVEUPDATE_SESSION_RETRIEVE_INTO_FD failed\n");
+		return -errno;
+	}
+
+	map = mmap(NULL, page_size, PROT_READ, MAP_SHARED, mfd, 0);
+	if (map == MAP_FAILED)
+		return -errno;
+
+	if (expected_data && strcmp(expected_data, map) != 0) {
+		ksft_print_msg("Data mismatch! Expected '%s', Got '%s'\n",
+			       expected_data, (char *)map);
+		munmap(map, page_size);
+		return -EINVAL;
+	}
+
+	munmap(map, page_size);
+	return 0;
+}
diff --git a/tools/testing/selftests/liveupdate/luo_multi_session.c b/tools/testing/selftests/liveupdate/luo_multi_session.c
index aac24a5f5ce3..7882f49aadaf 100644
--- a/tools/testing/selftests/liveupdate/luo_multi_session.c
+++ b/tools/testing/selftests/liveupdate/luo_multi_session.c
@@ -1,4 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0-only
+#include <sys/mman.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <sys/mount.h>
+#include <sys/stat.h>
 
 /*
  * Copyright (c) 2025, Google LLC.
@@ -31,6 +36,8 @@
 static void run_stage_1(int luo_fd)
 {
 	int s_empty1_fd, s_empty2_fd, s_files1_fd, s_files2_fd;
+	int tmpfs_fd;
+	void *map;
 
 	ksft_print_msg("[STAGE 1] Starting pre-kexec setup for multi-session test...\n");
 
@@ -53,25 +60,50 @@ static void run_stage_1(int luo_fd)
 	s_files1_fd = luo_create_session(luo_fd, SESSION_FILES_1);
 	if (s_files1_fd < 0)
 		fail_exit("luo_create_session for '%s'", SESSION_FILES_1);
+	ksft_print_msg("  -> Preserving memfd (token %#x, content: \"%s\")\n",
+		       MFD1_TOKEN, MFD1_DATA);
 	if (create_and_preserve_memfd(s_files1_fd, MFD1_TOKEN, MFD1_DATA) < 0) {
 		fail_exit("create_and_preserve_memfd for token %#x",
 			  MFD1_TOKEN);
 	}
 
-	ksft_print_msg("[STAGE 1] Creating session '%s' with two memfds...\n",
+	ksft_print_msg("[STAGE 1] Creating session '%s' with memfd and tmpfs file...\n",
 		       SESSION_FILES_2);
 
 	s_files2_fd = luo_create_session(luo_fd, SESSION_FILES_2);
 	if (s_files2_fd < 0)
 		fail_exit("luo_create_session for '%s'", SESSION_FILES_2);
+	ksft_print_msg("  -> Preserving memfd (token %#x, content: \"%s\")\n",
+		       MFD2_TOKEN, MFD2_DATA);
 	if (create_and_preserve_memfd(s_files2_fd, MFD2_TOKEN, MFD2_DATA) < 0) {
 		fail_exit("create_and_preserve_memfd for token %#x",
 			  MFD2_TOKEN);
 	}
-	if (create_and_preserve_memfd(s_files2_fd, MFD3_TOKEN, MFD3_DATA) < 0) {
-		fail_exit("create_and_preserve_memfd for token %#x",
-			  MFD3_TOKEN);
-	}
+	ksft_print_msg("  -> Populating custom tmpfs file at /mnt/mfd3_source...\n");
+	mkdir("/mnt", 0777);
+	mount("tmpfs", "/mnt", "tmpfs", 0, NULL);
+	tmpfs_fd = open("/mnt/mfd3_source", O_CREAT | O_RDWR, 0666);
+	if (tmpfs_fd < 0)
+		fail_exit("failed to open tmpfs_fd");
+	ksft_print_msg("  -> Preserving generic tmpfs file (token %#x, content: \"%s\")\n",
+		       MFD3_TOKEN, MFD3_DATA);
+	if (ftruncate(tmpfs_fd, getpagesize()) < 0)
+		fail_exit("ftruncate tmpfs_fd");
+	map = mmap(NULL, getpagesize(), PROT_WRITE, MAP_SHARED, tmpfs_fd, 0);
+	if (map == MAP_FAILED)
+		fail_exit("mmap tmpfs_fd");
+	strcpy(map, MFD3_DATA);
+	munmap(map, getpagesize());
+
+	struct liveupdate_session_preserve_fd preserve_args = {
+		.size = sizeof(preserve_args),
+		.token = MFD3_TOKEN,
+		.fd = tmpfs_fd,
+	};
+	if (ioctl(s_files2_fd, LIVEUPDATE_SESSION_PRESERVE_FD, &preserve_args) < 0)
+		fail_exit("preserve tmpfs fd");
+
+	close(tmpfs_fd);
 
 	close(luo_fd);
 	daemonize_and_wait();
@@ -110,6 +142,7 @@ static void run_stage_2(int luo_fd, int state_session_fd)
 
 	ksft_print_msg("[STAGE 2] Verifying contents of session '%s'...\n",
 		       SESSION_FILES_1);
+	ksft_print_msg("  -> Retrieving memfd (token %#x) from session...\n", MFD1_TOKEN);
 	mfd1 = restore_and_verify_memfd(s_files1_fd, MFD1_TOKEN, MFD1_DATA);
 	if (mfd1 < 0)
 		fail_exit("restore_and_verify_memfd for token %#x", MFD1_TOKEN);
@@ -118,14 +151,23 @@ static void run_stage_2(int luo_fd, int state_session_fd)
 	ksft_print_msg("[STAGE 2] Verifying contents of session '%s'...\n",
 		       SESSION_FILES_2);
 
+	ksft_print_msg("  -> Retrieving memfd (token %#x) from session...\n", MFD2_TOKEN);
 	mfd2 = restore_and_verify_memfd(s_files2_fd, MFD2_TOKEN, MFD2_DATA);
 	if (mfd2 < 0)
 		fail_exit("restore_and_verify_memfd for token %#x", MFD2_TOKEN);
 	close(mfd2);
 
-	mfd3 = restore_and_verify_memfd(s_files2_fd, MFD3_TOKEN, MFD3_DATA);
+	ksft_print_msg("  -> Creating empty tmpfs file at /mnt/mfd3_target...\n");
+	mkdir("/mnt", 0777);
+	mount("tmpfs", "/mnt", "tmpfs", 0, NULL);
+	mfd3 = open("/mnt/mfd3_target", O_CREAT | O_RDWR, 0666);
 	if (mfd3 < 0)
-		fail_exit("restore_and_verify_memfd for token %#x", MFD3_TOKEN);
+		fail_exit("open tmpfs target for retrieve_into");
+
+	ksft_print_msg("  -> Validating LIVEUPDATE_SESSION_RETRIEVE_INTO_FD (token %#x)...\n",
+		       MFD3_TOKEN);
+	if (luo_verify_retrieve_into_memfd(s_files2_fd, MFD3_TOKEN, mfd3, MFD3_DATA) < 0)
+		fail_exit("luo_verify_retrieve_into_memfd for token %#x", MFD3_TOKEN);
 	close(mfd3);
 
 	ksft_print_msg("[STAGE 2] Test data verified successfully.\n");
-- 
2.55.0.966.g6673acef38-goog


