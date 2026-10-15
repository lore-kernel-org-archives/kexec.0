Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A55E1CC6B3A
	for <kexec@archiver.kernel.org>; Thu, 15 Oct 2026 09:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IPTzG9yeWgp2JFe+s9iO1cWtEwA5iuP2nn+kITzaTP4=; b=EpEDnnNHIlclfyDttfWOlz2UKi
	byOToFIOXRgJfT5ZX41eVYYsIlCOvRvutwQHUISBOCRhAE7ms40ffe/0T6K9nQ5xPhP8dZktNmzPM
	HzZVuhIHAMdB0xMyulxgHDSQ7hykVUjfNm+fGPlljfHRednTlst5qzEHk9svPKMCAL3eOMPOB3UIM
	DvT3ENAlm2ET8tvlzeMz4ewn4+QruLHV8DeezDvajABFbjfZcyCS5tB6Pt7DUJ42NA+wE+4jwt8QY
	EfjX8nYG+bR2omJ2P2kvtLLy6Dn9XqJPAtbB50qPGjqJfik+fYtKBNTh8WM1wz6x6Fbi8Sa9ZWPHg
	9+l8fIIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHHvF-0000000HI8w-2zCf;
	Thu, 15 Oct 2026 09:38:49 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHHvE-0000000HI8W-2jvd
	for kexec@bombadil.infradead.org;
	Thu, 15 Oct 2026 09:38:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
	Content-Type:Content-ID:Content-Description;
	bh=IPTzG9yeWgp2JFe+s9iO1cWtEwA5iuP2nn+kITzaTP4=; b=NC2qlgyiwwPYduHaj6AXKcM6Ag
	rmsABVFV+U8FjcDx2DQKrrCFOph8RRRFzgcOwDDFku8bCIpK6C4XoBtHjzOiKy909COskMQaMlERg
	al0ibmuvIr+MuPBat+kaNDH8Fh+/K2cr66LyJxH9IYTmpKr9+HJmqAyfpLI2DpjzQoH6Ryqjf5Gjz
	GWtpu1YeZMXO3xBKPl2fEd32VYnrCVg4nbqSrfkaLfwKSRc/4GcFl73mb1xZlIrMbfhyzkAqdR0gR
	gMH74clR2ULXzDgbNb+wDiaOkFUkWSE+dxEremdsUmyA9av72LfAPwsQLzWWaEMUXyENR2yfPjjuP
	+4fueOmw==;
Received: from mail-vk1-xa30.google.com ([2607:f8b0:4864:20::a30])
	by casper.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHHvB-0000000CWiJ-2tUd
	for kexec@lists.infradead.org;
	Thu, 15 Oct 2026 09:38:47 +0000
Received: by mail-vk1-xa30.google.com with SMTP id 71dfb90a1353d-5d8e5624261so458797e0c.0
        for <kexec@lists.infradead.org>; Thu, 15 Oct 2026 02:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792057122; x=1792661922; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IPTzG9yeWgp2JFe+s9iO1cWtEwA5iuP2nn+kITzaTP4=;
        b=XcfskNzuP465z+yvBOfpkbXKuU5oPN4tBsFD/J8ZmAPYyjmuokIYq5hcKIYVqpCBbY
         k/6JWdRMaN4ff/ApfHErghlnBiEIXvmCRQs76YZlh2SKKt3ufBeVscXMm29d/os6k8kf
         6arkTD3TIzA/71Js3EBkH4k5SGQyjm4nDy6oH3eLqGX9PJ6rtTttw/H1m9bXrMI6BZ+A
         cq8YlAqdrt3EM/rU37VyLDQaOzTimA6Y9qIgJ0/1uX40IzDl1fJkTmfbhTi1n4ta3PSU
         1u3qeBqRGeLWiQBtqk1Fpap49+QC4kYxDWY2/OC/NlxfOr2b6tMxcNXj3cBSThdQIoEi
         akXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792057122; x=1792661922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=IPTzG9yeWgp2JFe+s9iO1cWtEwA5iuP2nn+kITzaTP4=;
        b=Z5543eNityDy4UPEu91UhAI70pSp1C5W/Xc9fA/TvJDbuIUwYuV28kA3qzIpqSW+na
         2xc8ywQ1STX/WlVqIhU8D9+4XqmcHs+V6KlWwjH234KalTk2dRrODOfx0K9+kfe8Atwy
         CMSgbDFA7Jh/TsriB1MBrA2Ypo+T3pA0AQHm31in6W0IiDEDdHWVL11M3+t6d42obOuf
         o1kbWULRznoLiX7omC/BRd0MAiHMiIcFeILAliPSqnxG7cZvM2khV9rtrRJIysBiw1KN
         Aj15BZXYAWxMWTCaVq+s3NX/0vZAMtaCi9LZiFCl2bKU4UYBaZ6FwwhDyMTD+DviyUYl
         ik4w==
X-Forwarded-Encrypted: i=1; AKwUvByFP+vSlrH6ILDn9wgZ5hAU027uLKqpdCwWgyUej+UsbmHqLLTc3lR3pVKd8JOFBAFbeBRxWQ==@lists.infradead.org
X-Gm-Message-State: AFq9FYKYVH/AIaMDnwFyNDHlsfTjF2DeXHm2jEFxvnbg4yBvOoLS2Kyf
	4RII8FV9fZqCJmaTr3qSD9K+42aSPKjVdI3YcYcYYifj4hpuUT8UYjZmYklMK2jj9q0=
X-Gm-Gg: AYBFou1NGJILetsmih9ABw3nQfXvLa2eLmGS7i64r0AexJLUjDiU27SQPM7JM6G0JEl
	g4XwD0fRHQ+FRb/h8vmrbZFNTTaRZmIKfLesKYGSK7GhaPys2A2WHppD7AeL82yjl5rbxDHOG8T
	fMNXSv8Emz5YKd7acoZIBytHg2vu8iDN/FjKGKlZLjFItyAdn9mKP/V7bUp2ydUs0QG0GESVc0i
	CMG7tKMub/OXwubI6SISky83NBfVLturrcH5O1tCbNXKnlKCEMiFQ6AgMtVhi+c1u9Bc1SY0tKc
	CzdnjX2I5dMaWw1WunRoWw5jqdqX6rXH20TEAJBMTYGpBXvfNcLPKGK2Fbkwq9KqCq3QKk2y+Yy
	/nd5iQQ8hsjz0f2E9h1tORBoHxnG0fHphoHkZLh6aW7UwcZVzT699UIWjKMJvkrTs5/iX9mDPFo
	NMaywMHAnYYwDx7EyWFrLS2xgwC6RF4dRqNvdDBrb9mADQBPXyE92i4fx3N9ia0sY19CoaRgWOw
	7LCam+5vRdMde+VgOMbCjQ9o+3Td2qEcW7Y44K3mYseEQXAqIUaWqcQwT+pT9Tgn8LT/D0kivlU
	rnm2DSycAP6g/vL8sQE=
X-Received: by 2002:a05:6122:4b8c:b0:5cf:1e68:6015 with SMTP id 71dfb90a1353d-5e91f4cc080mr5669513e0c.15.1792057122304;
        Thu, 15 Oct 2026 02:38:42 -0700 (PDT)
Received: from soleen.c.googlers.com.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99003d37009sm12275672241.2.2026.10.15.02.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 02:38:36 -0700 (PDT)
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
Subject: [PATCH v1 7/7] selftests: liveupdate: Add test coverage for tmpfs preservation and retrieval
Date: Thu, 15 Oct 2026 05:38:16 -0400
Message-ID: <20261015093816.2438942-8-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
In-Reply-To: <20261015093816.2438942-1-pasha.tatashin@soleen.com>
References: <20261015093816.2438942-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261015_103845_775598_A9CB82AB 
X-CRM114-Status: GOOD (  14.12  )
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

From: David Matlack <dmatlack@google.com>

Extend the multi-session LUO test to verify preserving a path-backed
tmpfs file and retrieving its contents to a newly created empty tmpfs
file post-kexec using struct liveupdate_memfd_retrieve_arg with
LIVEUPDATE_SESSION_RETRIEVE_FD. Also verify that retrieve argument
validation errors (passing an argument when retrieving a memfd, omitting
the argument when retrieving a tmpfs file, or passing a read-only target
tmpfs FD) are retryable and allow a subsequent valid retrieve call to
succeed.

Signed-off-by: David Matlack <dmatlack@google.com>
Co-developed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 .../liveupdate/lib/include/libliveupdate.h    |   2 +
 .../selftests/liveupdate/lib/lu_utils.c       |  44 +++++++
 .../selftests/liveupdate/luo_multi_session.c  | 110 ++++++++++++++++--
 3 files changed, 147 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/liveupdate/lib/include/libliveupdate.h b/tools/testing/selftests/liveupdate/lib/include/libliveupdate.h
index 8a38268e89dee..dc5c01408462d 100644
--- a/tools/testing/selftests/liveupdate/lib/include/libliveupdate.h
+++ b/tools/testing/selftests/liveupdate/lib/include/libliveupdate.h
@@ -37,6 +37,8 @@ int luo_session_retrieve_fd_arg(int session_fd, __u64 token, __u64 user_arg);
 
 int create_and_preserve_memfd(int session_fd, int token, const char *data);
 int restore_and_verify_memfd(int session_fd, int token, const char *expected_data);
+int restore_and_verify_tmpfs(int session_fd, int token, int fd,
+			     const char *expected_data);
 
 void create_state_file(int luo_fd, const char *session_name, int token,
 		       int next_stage);
diff --git a/tools/testing/selftests/liveupdate/lib/lu_utils.c b/tools/testing/selftests/liveupdate/lib/lu_utils.c
index 5c6f8bf80b297..1b1a556287d3a 100644
--- a/tools/testing/selftests/liveupdate/lib/lu_utils.c
+++ b/tools/testing/selftests/liveupdate/lib/lu_utils.c
@@ -347,3 +347,47 @@ int luo_test(int argc, char *argv[],
 
 	return 0;
 }
+
+int restore_and_verify_tmpfs(int session_fd, int token, int fd,
+			     const char *expected_data)
+{
+	struct liveupdate_memfd_retrieve_arg rarg = {
+		.size = sizeof(rarg),
+		.fd = fd,
+	};
+	long page_size = getpagesize();
+	void *map = MAP_FAILED;
+	struct stat st;
+	int ret_fd;
+
+	ret_fd = luo_session_retrieve_fd_arg(session_fd, token,
+					     (unsigned long)&rarg);
+	if (ret_fd < 0) {
+		ksft_print_msg("luo_session_retrieve_fd_arg failed: %d\n",
+			       ret_fd);
+		return ret_fd;
+	}
+	close(ret_fd);
+
+	if (fstat(fd, &st) < 0)
+		return -errno;
+	if (st.st_size != page_size) {
+		ksft_print_msg("Size mismatch! Expected %ld, Got %lld\n",
+			       page_size, (long long)st.st_size);
+		return -EINVAL;
+	}
+
+	map = mmap(NULL, page_size, PROT_READ, MAP_SHARED, fd, 0);
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
index aac24a5f5ce3c..46889676d9f52 100644
--- a/tools/testing/selftests/liveupdate/luo_multi_session.c
+++ b/tools/testing/selftests/liveupdate/luo_multi_session.c
@@ -9,7 +9,15 @@
  * files.
  */
 
+#include <errno.h>
+#include <fcntl.h>
+#include <sys/mman.h>
+#include <sys/mount.h>
+#include <sys/stat.h>
+#include <unistd.h>
+
 #include <libliveupdate.h>
+#include <linux/liveupdate.h>
 
 #define SESSION_EMPTY_1 "multi-test-empty-1"
 #define SESSION_EMPTY_2 "multi-test-empty-2"
@@ -23,6 +31,7 @@
 #define MFD1_DATA "Data for session files 1"
 #define MFD2_DATA "First file for session files 2"
 #define MFD3_DATA "Second file for session files 2"
+#define MFD3_POS 42
 
 #define STATE_SESSION_NAME "kexec_multi_state"
 #define STATE_MEMFD_TOKEN 998
@@ -31,6 +40,8 @@
 static void run_stage_1(int luo_fd)
 {
 	int s_empty1_fd, s_empty2_fd, s_files1_fd, s_files2_fd;
+	int tmpfs_fd;
+	void *map;
 
 	ksft_print_msg("[STAGE 1] Starting pre-kexec setup for multi-session test...\n");
 
@@ -53,25 +64,50 @@ static void run_stage_1(int luo_fd)
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
+
+	ksft_print_msg("  -> Populating tmpfs file at /mnt/mfd3...\n");
+	if (mkdir("/mnt", 0777) < 0 && errno != EEXIST)
+		fail_exit("mkdir /mnt");
+	if (mount("tmpfs", "/mnt", "tmpfs", 0, NULL) < 0)
+		fail_exit("mount tmpfs");
+	tmpfs_fd = open("/mnt/mfd3", O_CREAT | O_RDWR, 0666);
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
+	if (lseek(tmpfs_fd, MFD3_POS, SEEK_SET) != MFD3_POS)
+		fail_exit("lseek tmpfs_fd");
+
+	if (luo_session_preserve_fd(s_files2_fd, tmpfs_fd, MFD3_TOKEN) < 0)
+		fail_exit("preserve tmpfs fd");
+
+	close(tmpfs_fd);
 
 	close(luo_fd);
 	daemonize_and_wait();
@@ -81,7 +117,10 @@ static void run_stage_1(int luo_fd)
 static void run_stage_2(int luo_fd, int state_session_fd)
 {
 	int s_empty1_fd, s_empty2_fd, s_files1_fd, s_files2_fd;
-	int mfd1, mfd2, mfd3, stage;
+	struct liveupdate_memfd_retrieve_arg rarg = {
+		.size = sizeof(rarg),
+	};
+	int mfd1, mfd2, mfd3, ro_fd, ret, stage;
 
 	ksft_print_msg("[STAGE 2] Starting post-kexec verification...\n");
 
@@ -110,6 +149,8 @@ static void run_stage_2(int luo_fd, int state_session_fd)
 
 	ksft_print_msg("[STAGE 2] Verifying contents of session '%s'...\n",
 		       SESSION_FILES_1);
+	ksft_print_msg("  -> Retrieving memfd (token %#x) from session...\n",
+		       MFD1_TOKEN);
 	mfd1 = restore_and_verify_memfd(s_files1_fd, MFD1_TOKEN, MFD1_DATA);
 	if (mfd1 < 0)
 		fail_exit("restore_and_verify_memfd for token %#x", MFD1_TOKEN);
@@ -118,14 +159,65 @@ static void run_stage_2(int luo_fd, int state_session_fd)
 	ksft_print_msg("[STAGE 2] Verifying contents of session '%s'...\n",
 		       SESSION_FILES_2);
 
+	ksft_print_msg("  -> Creating empty tmpfs file at /mnt/mfd3...\n");
+	if (mkdir("/mnt", 0777) < 0 && errno != EEXIST)
+		fail_exit("mkdir /mnt");
+	if (mount("tmpfs", "/mnt", "tmpfs", 0, NULL) < 0)
+		fail_exit("mount tmpfs");
+	mfd3 = open("/mnt/mfd3", O_CREAT | O_RDWR, 0666);
+	if (mfd3 < 0)
+		fail_exit("open tmpfs file");
+	ro_fd = open("/mnt/mfd3", O_RDONLY);
+	if (ro_fd < 0)
+		fail_exit("open read-only tmpfs file");
+
+	ksft_print_msg("  -> Verifying retryable retrieve errors for memfd and tmpfs...\n");
+	rarg.fd = mfd3;
+	ret = luo_session_retrieve_fd_arg(s_files2_fd, MFD2_TOKEN,
+					  (uintptr_t)&rarg);
+	if (ret != -EINVAL)
+		fail_exit("expected -EINVAL when passing arg to memfd retrieve, got %d",
+			  ret);
+
+	ksft_print_msg("  -> Retrieving memfd (token %#x) from session...\n",
+		       MFD2_TOKEN);
 	mfd2 = restore_and_verify_memfd(s_files2_fd, MFD2_TOKEN, MFD2_DATA);
 	if (mfd2 < 0)
 		fail_exit("restore_and_verify_memfd for token %#x", MFD2_TOKEN);
 	close(mfd2);
 
-	mfd3 = restore_and_verify_memfd(s_files2_fd, MFD3_TOKEN, MFD3_DATA);
-	if (mfd3 < 0)
-		fail_exit("restore_and_verify_memfd for token %#x", MFD3_TOKEN);
+	ret = luo_session_retrieve_fd(s_files2_fd, MFD3_TOKEN);
+	if (ret != -EINVAL)
+		fail_exit("expected -EINVAL when retrieving tmpfs without arg, got %d",
+			  ret);
+
+	rarg.fd = ro_fd;
+	ret = luo_session_retrieve_fd_arg(s_files2_fd, MFD3_TOKEN,
+					  (uintptr_t)&rarg);
+	if (ret != -EACCES)
+		fail_exit("expected -EACCES when retrieving tmpfs into read-only fd, got %d",
+			  ret);
+	close(ro_fd);
+
+	if (ftruncate(mfd3, 1) < 0)
+		fail_exit("ftruncate non-empty tmpfs file");
+	rarg.fd = mfd3;
+	ret = luo_session_retrieve_fd_arg(s_files2_fd, MFD3_TOKEN,
+					  (uintptr_t)&rarg);
+	if (ret != -EBUSY)
+		fail_exit("expected -EBUSY when retrieving tmpfs into non-empty fd, got %d",
+			  ret);
+	if (ftruncate(mfd3, 0) < 0)
+		fail_exit("ftruncate empty tmpfs file");
+
+	ksft_print_msg("  -> Retrieving tmpfs file (token %#x) from session...\n",
+		       MFD3_TOKEN);
+	if (restore_and_verify_tmpfs(s_files2_fd, MFD3_TOKEN, mfd3,
+				     MFD3_DATA) < 0)
+		fail_exit("restore_and_verify_tmpfs for token %#x",
+			  MFD3_TOKEN);
+	if (lseek(mfd3, 0, SEEK_CUR) != MFD3_POS)
+		fail_exit("expected f_pos %d on restored tmpfs file", MFD3_POS);
 	close(mfd3);
 
 	ksft_print_msg("[STAGE 2] Test data verified successfully.\n");
-- 
2.56.0.385.gd3acb90ef8-goog


