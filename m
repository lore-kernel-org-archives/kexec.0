Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7FD606A32D
	for <kexec@archiver.kernel.org>; Wed, 11 Nov 2026 07:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=BnQBlUAa;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=CIob77H5
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=oahx99XEloIqEujazr6llRd2iV3ppRMwlmYjmySRohQ=; b=BnQBlUAaLynQeYTbQu88INKx9L
	6wzuj+Doxc+hUH4kSKtdY7HHG1Aj5gGoZRTzHIcdW68M5UEmG4PQNgdB8cQ/TanGuYeervQr67LpD
	4f9hYUhALA9UPMxVdDCYIyjegE+aVUnOOmRFaACI3vXqNEuxYv2kruH97Qqv1XsPlHZzZIRrsFCCb
	I+Dm5/fWIPJFwVi9tLm7NV3jttjx4sg8UmtRYKKwaxZVLpyhEy/0K4Rb7BUpcVsD+dtEcAXg0b8MP
	cm6yRz8bp1pp4q20Dv5PPrDyge3SvnPfJOBURyFAu7Y+2gtZYcxhNqBGqls7lhj247Ia7yakP3NSc
	LuY0adoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR398-00000005xwB-2pDJ;
	Wed, 11 Nov 2026 07:53:30 +0000
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR393-00000005xtb-1cwe
	for kexec@lists.infradead.org;
	Wed, 11 Nov 2026 07:53:30 +0000
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-3acb11973c3so2355821a91.3
        for <kexec@lists.infradead.org>; Tue, 10 Nov 2026 23:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794383604; x=1794988404; darn=lists.infradead.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=oahx99XEloIqEujazr6llRd2iV3ppRMwlmYjmySRohQ=;
        b=CIob77H5OyxsLbYfVJIxCg/1hLjLPMW2nXTP5/84aLrM8AYK2vcWnM+NpGiHKrOgyl
         kNAkPzTH1g8soaH97Hr9zOu7dGXksCvSlABGJb1jsQTaHh96doREr9c9KkO1VJ7N3Z+J
         ZofjmQRlTQ8qN7pcHurbhZdtzec4gKgZDQnA8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794383604; x=1794988404;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oahx99XEloIqEujazr6llRd2iV3ppRMwlmYjmySRohQ=;
        b=U0Hcmhy4UIDHS4wrKiYemdtRSljTMqbyOgBehnKSF3rw3mg34jiPEyIwbZ6L3N1tqy
         0Y4FTcqNBeK2GWmLwHuPptP/ksQxHpjMSaMJZPeP7R4heJQyEuelcpSrfQ6L+qIUVH6p
         qye697U/fJsJS+J+ZmjF5bDvPH1WGn/U1I5fwP9cpe7jzEmyCMFawp6z4eMncDvtmmlU
         +7x5l4Vp5EggTlS3351ISC/wOI4ps7c5PsOwb98Prqq/US9gxY8YgVyii4+uB/yifcyn
         6cgyv/NTJNTXickF3PbHAUal9WjEw37OvCARAofVT/hntLUEfPawWkDI+VpEjOz0RxDK
         7MRA==
X-Forwarded-Encrypted: i=1; AL+hErGjq24fbPGqFIRvoKY8RAjchbhTtb3U2X3gLEZ7zrFcJC1BrVdoqYsUi4+L7jCnCs1Wh/D8sw==@lists.infradead.org
X-Gm-Message-State: APuU4Z9woGGXH1QjgDuq9uTKnsLbnVDnhWUosA8RKSx+wseNEfl0ZLUD
	mA7JtpWS7H0VkaQDQV/jKKIu08nc0pUrL7TiGvsaSnCFwCq3PrzWcwZc6eRtSecQ96M=
X-Gm-Gg: AYBFou2op4P/gCJrEil9H/A8mFWhD0S5uVpQa1McdgxhEMI2abS6Or36UAV/3cKK7Uc
	M1Lr6NDMUfDpjI8iTNnohN73J/xMxRLuIIZmguvxbBYO4HAIvRcubEt4S+c0q32RF32A0jinJk4
	y8V4v3M2Z5w6/bKB208snXyHhilkTgrnI06CZDZ4dArAfzw0A8k1t09rh7FecIzbb+juTPxbsQc
	va6CcQMkCQBC1Gyjzi8twnJxkM8SHBDEkhzOoAqK8V19N0Cbm3sqaJs72mIXOZHBMcKAvHBQ6d5
	pmxoqvMPmdJD1fKSCnO7mRY/xywE8vhQ3EuvnrQl/WYWMP+E8BR7YQwiHWjbrSHaXCWCuqU0ZzK
	2H1i9vMRIksAumywzKQml08oNQ8LUeJslyfpR3rG4vWexgcFstfjLZhVj7USI2puaatHuL0kRba
	pwHUXcq9zbF/OamkW2HWn8EPkWWZ6nrE5wfLpcsm1PgECd21cRyDJW+wsQV2iq80Rw8Bv0F4Fbh
	L6JJe514yVnAGGGxrclw2HkxR+/MYwz26x95Fr4LGL8HQgvirU6OEouCGph9U5rGZ8aHxvCzMNp
	8pW+lkmW/49pyCquZpOOP7i/pOoV3tFp33//FsC7aQmFbpBKlIO0HvX82wyPWPsJxZBnmNmTrzK
	EYMmD3kCuM0nVW29gjMfgBc/140P0liGhalaDPbOoZ2kav8hsPRPj8pswXOmXebswxWvHFByWFt
	4+V9ZMOswVWbP39KRriR79ZlLKNLr68Ng1kfdhjxQbDN7P8kLy9DVr76y8F3RS/FPnGo1DdpCxT
	w==
X-Received: by 2002:a17:90b:3ecd:b0:3b0:ae41:2706 with SMTP id 98e67ed59e1d1-3b182defae2mr1841105a91.4.1794383604238;
        Tue, 10 Nov 2026 23:53:24 -0800 (PST)
Received: from localhost ([199.201.64.8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b17dba5ed0sm3393597a91.17.2026.11.10.23.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 23:53:23 -0800 (PST)
Date: Tue, 10 Nov 2026 23:53:20 -0800
From: Chris Down <chris@chrisdown.name>
To: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>
Cc: Alexander Graf <graf@amazon.com>, Baoquan He <baoquan.he@linux.dev>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH 4/9] selftests/liveupdate: Catch incorrect file accounting
 across kexec
Message-ID: <d339c0af9c4ee54a5ee8052d5fe59c81302d82a7.1794383544.git.chris@chrisdown.name>
References: <cover.1794383544.git.chris@chrisdown.name>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1794383544.git.chris@chrisdown.name>
User-Agent: Mutt/2.3.3 (9073d26d) (2026-06-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261110_235325_462279_A9D151B0 
X-CRM114-Status: GOOD (  23.52  )
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
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Check that each retrieve is counted while the session is still open.
Finishing the session should count its unretrieved file as dropped,
while a file in an unclaimed session should still be held.

Signed-off-by: Chris Down <chris@chrisdown.name>
---
 tools/testing/selftests/liveupdate/Makefile   |   1 +
 tools/testing/selftests/liveupdate/init.c     |   5 +
 .../selftests/liveupdate/luo_handover_stats.c | 198 ++++++++++++++++++
 .../selftests/liveupdate/run-vmtests.sh       |   1 +
 tools/testing/selftests/liveupdate/vmtest.sh  |   2 +
 5 files changed, 207 insertions(+)
 create mode 100644 tools/testing/selftests/liveupdate/luo_handover_stats.c

diff --git a/tools/testing/selftests/liveupdate/Makefile b/tools/testing/selftests/liveupdate/Makefile
index 634211c66652..78a4419ff610 100644
--- a/tools/testing/selftests/liveupdate/Makefile
+++ b/tools/testing/selftests/liveupdate/Makefile
@@ -2,6 +2,7 @@
 
 TEST_GEN_PROGS += liveupdate
 
+TEST_GEN_PROGS_EXTENDED += luo_handover_stats
 TEST_GEN_PROGS_EXTENDED += luo_kexec_simple
 TEST_GEN_PROGS_EXTENDED += luo_multi_session
 TEST_GEN_PROGS_EXTENDED += luo_stress_sessions
diff --git a/tools/testing/selftests/liveupdate/init.c b/tools/testing/selftests/liveupdate/init.c
index fb08bd58b9b9..31bd8f0ec3a9 100644
--- a/tools/testing/selftests/liveupdate/init.c
+++ b/tools/testing/selftests/liveupdate/init.c
@@ -37,6 +37,11 @@ static int mount_filesystems(void)
 		return -1;
 	}
 
+	if (mount("sysfs", "/sys", "sysfs", 0, NULL) < 0) {
+		fprintf(stderr, "INIT: Failed to mount sysfs\n");
+		return -1;
+	}
+
 	return 0;
 }
 
diff --git a/tools/testing/selftests/liveupdate/luo_handover_stats.c b/tools/testing/selftests/liveupdate/luo_handover_stats.c
new file mode 100644
index 000000000000..f18df79dda55
--- /dev/null
+++ b/tools/testing/selftests/liveupdate/luo_handover_stats.c
@@ -0,0 +1,198 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include <fcntl.h>
+#include <limits.h>
+#include <stdio.h>
+#include <string.h>
+#include <unistd.h>
+#include <libliveupdate.h>
+
+#define INCOMING_DIR "/sys/class/misc/liveupdate/incoming/"
+
+#define SESSION_CLAIMED "stats-claimed"
+#define SESSION_UNCLAIMED "stats-unclaimed"
+
+#define MFD_RETRIEVED_TOKEN 0x51
+#define MFD_DROPPED_TOKEN 0x52
+#define MFD_UNCLAIMED_TOKEN 0x53
+
+#define MFD_RETRIEVED_DATA "retrieved before finish"
+#define MFD_DROPPED_DATA "never retrieved"
+#define MFD_UNCLAIMED_DATA "session never retrieved"
+
+#define STATE_SESSION_NAME "handover_stats_state"
+#define STATE_MEMFD_TOKEN 997
+
+/* The first open starts deserialization. */
+static char state_before_open[16];
+
+static void read_incoming(const char *name, char *buf, size_t len)
+{
+	char path[128];
+	ssize_t n;
+	int fd;
+
+	snprintf(path, sizeof(path), INCOMING_DIR "%s", name);
+	fd = open(path, O_RDONLY);
+	if (fd < 0)
+		fail_exit("open %s", path);
+
+	n = read(fd, buf, len - 1);
+	if (n < 0)
+		fail_exit("read %s", path);
+	close(fd);
+
+	/* A full buffer could hide the rest of a malformed value */
+	if ((size_t)n == len - 1)
+		ksft_exit_fail_msg("%s is longer than %zu bytes\n", path,
+				   len - 2);
+
+	buf[n] = '\0';
+	if (n > 0 && buf[n - 1] == '\n')
+		buf[n - 1] = '\0';
+}
+
+static void expect_state(const char *state, const char *expected)
+{
+	if (strcmp(state, expected))
+		ksft_exit_fail_msg("state is '%s', expected '%s'\n", state,
+				   expected);
+}
+
+static unsigned long long read_number(const char *name)
+{
+	unsigned long long val = 0;
+	char buf[32];
+	char *p;
+
+	read_incoming(name, buf, sizeof(buf));
+	for (p = buf; *p >= '0' && *p <= '9'; p++) {
+		if (val > (ULLONG_MAX - (*p - '0')) / 10)
+			break;
+		val = val * 10 + (*p - '0');
+	}
+	if (p == buf || *p)
+		ksft_exit_fail_msg("%s%s reads '%s', not a 64-bit unsigned number\n",
+				   INCOMING_DIR, name, buf);
+	return val;
+}
+
+static void expect_count(const char *name, unsigned long long expected)
+{
+	unsigned long long val = read_number(name);
+
+	if (val != expected)
+		ksft_exit_fail_msg("%s is %llu, expected %llu\n", name, val,
+				   expected);
+}
+
+static void expect_counts(long retrieved, long dropped)
+{
+	char state[16];
+
+	read_incoming("state", state, sizeof(state));
+	expect_state(state, "deserialized");
+
+	/* Three sessions, including the one carrying the test stage. */
+	expect_count("sessions", 3);
+	expect_count("files", 4);
+	expect_count("files_retrieved", retrieved);
+	expect_count("files_failed", 0);
+	expect_count("files_dropped", dropped);
+}
+
+static void run_stage_1(int luo_fd)
+{
+	int claimed_fd, unclaimed_fd;
+
+	ksft_print_msg("[STAGE 1] Checking state on a cold boot...\n");
+	expect_state(state_before_open, "none");
+	expect_count("sessions", 0);
+	expect_count("files", 0);
+
+	create_state_file(luo_fd, STATE_SESSION_NAME, STATE_MEMFD_TOKEN, 2);
+
+	ksft_print_msg("[STAGE 1] Preserving two memfds in '%s'...\n",
+		       SESSION_CLAIMED);
+	claimed_fd = luo_create_session(luo_fd, SESSION_CLAIMED);
+	if (claimed_fd < 0)
+		fail_exit("luo_create_session for '%s'", SESSION_CLAIMED);
+	if (create_and_preserve_memfd(claimed_fd, MFD_RETRIEVED_TOKEN,
+				      MFD_RETRIEVED_DATA) < 0)
+		fail_exit("create_and_preserve_memfd for token %#x",
+			  MFD_RETRIEVED_TOKEN);
+	if (create_and_preserve_memfd(claimed_fd, MFD_DROPPED_TOKEN,
+				      MFD_DROPPED_DATA) < 0)
+		fail_exit("create_and_preserve_memfd for token %#x",
+			  MFD_DROPPED_TOKEN);
+
+	ksft_print_msg("[STAGE 1] Preserving one memfd in '%s'...\n",
+		       SESSION_UNCLAIMED);
+	unclaimed_fd = luo_create_session(luo_fd, SESSION_UNCLAIMED);
+	if (unclaimed_fd < 0)
+		fail_exit("luo_create_session for '%s'", SESSION_UNCLAIMED);
+	if (create_and_preserve_memfd(unclaimed_fd, MFD_UNCLAIMED_TOKEN,
+				      MFD_UNCLAIMED_DATA) < 0)
+		fail_exit("create_and_preserve_memfd for token %#x",
+			  MFD_UNCLAIMED_TOKEN);
+
+	close(luo_fd);
+	daemonize_and_wait();
+}
+
+static void run_stage_2(int luo_fd, int state_session_fd)
+{
+	int claimed_fd, mfd, stage;
+
+	ksft_print_msg("[STAGE 2] Checking state before and after the first open...\n");
+	expect_state(state_before_open, "pending");
+	expect_counts(0, 0);
+
+	restore_and_read_stage(state_session_fd, STATE_MEMFD_TOKEN, &stage);
+	if (stage != 2)
+		fail_exit("Expected stage 2, but state file contains %d", stage);
+
+	/* The retrieve must count before the session finishes. */
+	expect_counts(1, 0);
+
+	ksft_print_msg("[STAGE 2] Retrieving one of the two memfds in '%s'...\n",
+		       SESSION_CLAIMED);
+	claimed_fd = luo_retrieve_session(luo_fd, SESSION_CLAIMED);
+	if (claimed_fd < 0)
+		fail_exit("luo_retrieve_session for '%s'", SESSION_CLAIMED);
+
+	mfd = restore_and_verify_memfd(claimed_fd, MFD_RETRIEVED_TOKEN,
+				       MFD_RETRIEVED_DATA);
+	if (mfd < 0)
+		fail_exit("restore_and_verify_memfd for token %#x",
+			  MFD_RETRIEVED_TOKEN);
+	close(mfd);
+	expect_counts(2, 0);
+
+	ksft_print_msg("[STAGE 2] Finishing '%s'...\n", SESSION_CLAIMED);
+	if (luo_session_finish(claimed_fd) < 0)
+		fail_exit("luo_session_finish for '%s'", SESSION_CLAIMED);
+	close(claimed_fd);
+
+	expect_counts(2, 1);
+
+	ksft_print_msg("[STAGE 2] Finishing the state session...\n");
+	if (luo_session_finish(state_session_fd) < 0)
+		fail_exit("luo_session_finish for state session");
+	close(state_session_fd);
+
+	/* Finishing the state session must not drop anything. */
+	expect_counts(2, 1);
+
+	ksft_print_msg("\n--- HANDOVER STATS TEST PASSED ---\n");
+}
+
+int main(int argc, char *argv[])
+{
+	read_incoming("state", state_before_open, sizeof(state_before_open));
+
+	return luo_test(argc, argv, STATE_SESSION_NAME,
+			run_stage_1, run_stage_2);
+}
diff --git a/tools/testing/selftests/liveupdate/run-vmtests.sh b/tools/testing/selftests/liveupdate/run-vmtests.sh
index 6f592aec0f85..bce7679279d4 100755
--- a/tools/testing/selftests/liveupdate/run-vmtests.sh
+++ b/tools/testing/selftests/liveupdate/run-vmtests.sh
@@ -16,6 +16,7 @@ failed=0
 skipped=0
 
 TEST_NAMES=(
+	"luo_handover_stats"
 	"luo_kexec_simple"
 	"luo_multi_session"
 	"luo_stress_files"
diff --git a/tools/testing/selftests/liveupdate/vmtest.sh b/tools/testing/selftests/liveupdate/vmtest.sh
index dea5a6fb2abc..76ffea7d4eb8 100755
--- a/tools/testing/selftests/liveupdate/vmtest.sh
+++ b/tools/testing/selftests/liveupdate/vmtest.sh
@@ -145,6 +145,7 @@ function mkinitrd() {
 	cat > "$workspace_dir/cpio_list_inner" <<EOF
 dir /dev 0755 0 0
 dir /proc 0755 0 0
+dir /sys 0755 0 0
 dir /debugfs 0755 0 0
 nod /dev/console 0600 0 0 c 5 1
 file /init $workspace_dir/init 0755 0 0
@@ -157,6 +158,7 @@ EOF
 	cat > "$workspace_dir/cpio_list" <<EOF
 dir /dev 0755 0 0
 dir /proc 0755 0 0
+dir /sys 0755 0 0
 dir /debugfs 0755 0 0
 nod /dev/console 0600 0 0 c 5 1
 file /init $workspace_dir/init 0755 0 0
-- 
2.54.0


