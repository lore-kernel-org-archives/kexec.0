Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FDDFC982D8
	for <kexec@archiver.kernel.org>; Sun, 20 Sep 2026 20:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sEtY+1n4Sw7+L9nuvlWdwzAf6I2rCrn2rF9X6RG1+q8=; b=ZzMw+PGZVtyrsGMkhAjyXSCleA
	0h/v3MMGyq0Hx/uMChMvac9iT/GZSGshuQYNz6lRApTNTeqzr4UXGQawOR9hEJiAr+BPX5FnW1Uc6
	ttXyiizWCyqaXtAgMWzStLV7+89KnAQEVvBjCWxx8f1RF8MgIE2KdHcFG/urpayc74Qic9p1hnkBT
	GilhetYkV5Xz5m9JxQZmPvK6cAUCECBiIzxeFRRfHo7b0IvcJaF1FNeIjZhz73f68RVLUsmfd6dB6
	+POXcy7z4Et5yvK6oCY0iIinWcMg3CilWpogPlwnvBJR6DvFF2LOS2gVPKd06O6vZj6YZvoEunYED
	YRNftTqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8O4v-00000000NhG-10u2;
	Sun, 20 Sep 2026 20:24:01 +0000
Received: from mail-yx2-x0f.google.com ([2607:f8b0:4864:41::f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8NNR-00000000J0Z-2279
	for kexec@lists.infradead.org;
	Sun, 20 Sep 2026 19:39:06 +0000
Received: by mail-yx2-x0f.google.com with SMTP id 00721157ae682-895eaf30817so23275937b3.0
        for <kexec@lists.infradead.org>; Sun, 20 Sep 2026 12:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1789933144; x=1790537944; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=sEtY+1n4Sw7+L9nuvlWdwzAf6I2rCrn2rF9X6RG1+q8=;
        b=ONoUL48QHEWpeVi7U5YcYFOJFaQx2dztNy/O07bBiN5Gt4DAXVctvzfyxraM6KRolU
         HhueRkoq976koFFBsc5oANK2wNkNchrjVzbddXapg0nK3hE13HrVx159T77vvafwDwdY
         s5lktrV6bccM+Nykf6xcKumlFgkyyFzb4B1UIYEW8K0N9eGce2IWwKi5tTfPuj4SGZti
         of0AYIrvMaVfiuMOuJxxLh/tZKriYo+iSUt+RjM2BwRbdTZIn7on5OJbLYZOKq/RfeIw
         mCFhb/CJP/cG3eRmIjvxQm6WFOQV+QzAuShjN3qzKAOuEyunnCK6Bice0RUu51kTk12v
         mVpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789933144; x=1790537944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=sEtY+1n4Sw7+L9nuvlWdwzAf6I2rCrn2rF9X6RG1+q8=;
        b=eZtBpr4ZDRHsSnKrJaaK3VAbscQ4cRO4VB3rTRPtURh5dHsfEF/Onaxhhc1a1qtNav
         pjXZtGqT+catDhTpCkH4FO0ExCLidb3FuIX7cFzQSxIgKnbYpqdDcUPyZQb2UUY91TAC
         hiWDzRNOF2JMRduoQhmWNhTrwV5CWpluYTCtnpEnIFdY5hBq/YzGybZnXfYBVj16Mt86
         Vqb+IKcxcpYUNgLou3WkLyqL+Rl4xDeEEj9OBWOGVAcVpAn2IJly9vwFqMRPs1fssYeR
         5QDXuD9uyo1F/ZrVI09pD7BhIl6KQOqlwAaOCQFJ3r59TdeeK/EJddc6E1/b8NZ+uo17
         yueA==
X-Forwarded-Encrypted: i=1; AKwUvBxHhEPHwWPHBAfQ3/4le7dDRFQscFXad0Wcm9bJKzesTW9sUEVeufV24huuVI1Or2efc2a44A==@lists.infradead.org
X-Gm-Message-State: AFuF++kKT2e6SPBO58ki+FwqxJB3ME4XvMuRPr9qSMQT2LnPpde6Ucij
	m1x+Zps5Mv1IztGajOl9Jlb17dwTAXHx7rVqXTABJsYVroMRMLXkVBvC86LmYLEVXCY=
X-Gm-Gg: AYBFou2vcZSdCkHFYLpN2XqhO+ZJa0i5te8mBqh9RQBfP15fj3yMuTewUJeejEEGttV
	uhYWXWKg1/OPK8R2SQBB4050LuKM7tHrB6R/Z7EzTjARmTVrfIcXpZmGdBGjw9mINJ4UKjsrjvn
	rPzv2WaPMFP9lXRM+LtBu+ep/cE5pBHCJ6pzmKyCtrPwF9HhAy1xo7kYACBes9Gg6xeVm9V/7R1
	siGdf7fmdhHJ5SoGxOW/sEC5o5P5UmMTjYNwmTDnxAEz0rvSL/gOgS0V3YONiDtF4o0ED6Hhv8r
	jaALiAdVB6teoi+TckYy3yAFRX9RcKg+ViXor7mi0jiFVVNUBqNWZhBBax43gGOD9hUH2kT+C7q
	yc4HXy63vSYkYNBEUccs9SY1hu9WzKpJIl+sC2vV2qJsIzHcUuAA+bl+AhFmvLWyFylDyA0kan7
	4cb94l9it3YvwMomye7r4WnldI7RV0jng1lmzKJGWXimSSFS7qn92r+voEb0bYpEROJ+o/B7POL
	eL9hlbA45vMSa93iUgPtwQ9gAC5xapw4c2iL86jYnu9HkgFDnh/JYgbQc2uD0Z4f054lY/LSI21
	jGWy+znKl3slohVWQw8=
X-Received: by 2002:a05:690c:498f:b0:81e:6c2e:f0f5 with SMTP id 00721157ae682-89734ac7b85mr23278327b3.28.1789933144397;
        Sun, 20 Sep 2026 12:39:04 -0700 (PDT)
Received: from soleen.c.googlers.com.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-89a48d99122sm18304727b3.48.2026.09.20.12.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 12:39:03 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: linux-kselftest@vger.kernel.org,
	legion@kernel.org,
	kees@kernel.org,
	will@kernel.org,
	ruanjinjie@huawei.com,
	atomlin@atomlin.com,
	rppt@kernel.org,
	jani.nikula@intel.com,
	hamzamahfooz@linux.microsoft.com,
	joey.gouly@arm.com,
	tglx@kernel.org,
	nsc@kernel.org,
	alexandre.chartre@oracle.com,
	james.morse@arm.com,
	dianders@chromium.org,
	bp@alien8.de,
	jpoimboe@kernel.org,
	shuah@kernel.org,
	catalin.marinas@arm.com,
	linux-kbuild@vger.kernel.org,
	linux-arch@vger.kernel.org,
	kvmarm@lists.linux.dev,
	jaredwhite@microsoft.com,
	johan@kernel.org,
	pbonzini@redhat.com,
	mingo@redhat.com,
	linux-mm@kvack.org,
	seanjc@google.com,
	mark.rutland@arm.com,
	vdonnefort@google.com,
	tarunsahu@google.com,
	gshan@redhat.com,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	xur@google.com,
	djbw@kernel.org,
	oupton@kernel.org,
	nogikh@google.com,
	sumitg@nvidia.com,
	linux-kernel@vger.kernel.org,
	zengheng4@huawei.com,
	peterz@infradead.org,
	corbet@lwn.net,
	suzuki.poulose@arm.com,
	luto@kernel.org,
	hpa@zytor.com,
	zhangpengjie2@huawei.com,
	x86@kernel.org,
	yuzenghui@huawei.com,
	jic23@kernel.org,
	ardb@kernel.org,
	pasha.tatashin@soleen.com,
	petr.pavlu@suse.com,
	ryan.roberts@arm.com,
	kexec@lists.infradead.org,
	pratyush@kernel.org,
	dave.hansen@linux.intel.com,
	rdunlap@infradead.org,
	kvm@vger.kernel.org,
	fuad.tabba@linux.dev,
	maz@kernel.org,
	mbenes@suse.cz,
	jgross@suse.com,
	seiden@linux.ibm.com,
	pierre.gondois@arm.com,
	song@kernel.org,
	nathan@kernel.org,
	pmladek@suse.com,
	graf@amazon.com,
	chao.gao@intel.com,
	zhenglifeng1@huawei.com,
	arnd@arndb.de,
	sidnayyar@google.com,
	linux-arm-kernel@lists.infradead.org,
	vladimir.murzin@arm.com,
	kas@kernel.org
Subject: [RFC PATCH 22/46] selftests: liveupdate: Add physical CPU preservation live update tests
Date: Sun, 20 Sep 2026 15:36:26 -0400
Message-ID: <20260920193650.3373435-23-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <20260920193650.3373435-1-pasha.tatashin@soleen.com>
References: <20260920193650.3373435-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260920_123905_540419_F398A800 
X-CRM114-Status: GOOD (  20.19  )
X-Mailman-Approved-At: Sun, 20 Sep 2026 13:23:19 -0700
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

Add integration tests performing kexec live updates with preserved
CPUs:
- Preserve physical cores across kexec reboot.
- Verify cores remain preserved and isolated in incoming kernel.
- Verify unpreserve and online restoration.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 tools/testing/selftests/liveupdate/Makefile   |   1 +
 tools/testing/selftests/liveupdate/init.c     |  27 +++-
 .../selftests/liveupdate/luo_cpu_preserve.c   | 145 ++++++++++++++++++
 .../selftests/liveupdate/run-vmtests.sh       |   1 +
 tools/testing/selftests/liveupdate/vmtest.sh  |   4 +-
 5 files changed, 175 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/liveupdate/luo_cpu_preserve.c

diff --git a/tools/testing/selftests/liveupdate/Makefile b/tools/testing/selftests/liveupdate/Makefile
index 634211c66652..0fa80f26a191 100644
--- a/tools/testing/selftests/liveupdate/Makefile
+++ b/tools/testing/selftests/liveupdate/Makefile
@@ -3,6 +3,7 @@
 TEST_GEN_PROGS += liveupdate
 
 TEST_GEN_PROGS_EXTENDED += luo_kexec_simple
+TEST_GEN_PROGS_EXTENDED += luo_cpu_preserve
 TEST_GEN_PROGS_EXTENDED += luo_multi_session
 TEST_GEN_PROGS_EXTENDED += luo_stress_sessions
 TEST_GEN_PROGS_EXTENDED += luo_stress_files
diff --git a/tools/testing/selftests/liveupdate/init.c b/tools/testing/selftests/liveupdate/init.c
index fb08bd58b9b9..a3850ff95c00 100644
--- a/tools/testing/selftests/liveupdate/init.c
+++ b/tools/testing/selftests/liveupdate/init.c
@@ -11,6 +11,7 @@
 #include <string.h>
 #include <sys/mount.h>
 #include <sys/reboot.h>
+#include <sys/stat.h>
 #include <sys/syscall.h>
 #include <sys/wait.h>
 #include <unistd.h>
@@ -27,11 +28,15 @@ static int mount_filesystems(void)
 		return -1;
 	}
 
-	if (mount("debugfs", "/debugfs", "debugfs", 0, NULL) < 0) {
-		fprintf(stderr, "INIT: Failed to mount debugfs\n");
+	if (mount("sysfs", "/sys", "sysfs", 0, NULL) < 0) {
+		fprintf(stderr, "INIT: Failed to mount sysfs\n");
 		return -1;
 	}
 
+	mkdir("/sys/kernel/debug", 0755);
+	mount("debugfs", "/sys/kernel/debug", "debugfs", 0, NULL);
+	mount("debugfs", "/debugfs", "debugfs", 0, NULL);
+
 	if (mount("proc", "/proc", "proc", 0, NULL) < 0) {
 		fprintf(stderr, "INIT: Failed to mount proc\n");
 		return -1;
@@ -116,7 +121,23 @@ static int run_test(int stage)
 	}
 
 	waitpid(pid, &status, 0);
+	if (WIFEXITED(status) && WEXITSTATUS(status) == 0)
+		return 0;
+
+	/* If test binary does not accept -s (e.g. kselftest harness), run without -s */
+	pid = fork();
+	if (pid < 0)
+		return -1;
+
+	if (!pid) {
+		char *const argv[] = {TEST_BINARY, NULL};
 
+		execve(TEST_BINARY, argv, NULL);
+		fprintf(stderr, "INIT: execve failed\n");
+		_exit(1);
+	}
+
+	waitpid(pid, &status, 0);
 	return (WIFEXITED(status) && WEXITSTATUS(status) == 0) ? 0 : -1;
 }
 
@@ -168,6 +189,8 @@ int main(int argc, char *argv[])
 	}
 
 	printf("INIT: Stage %d completed successfully.\n", current_stage);
+	if (current_stage == 2)
+		printf("\n--- TEST PASSED ---\n");
 	reboot(current_stage == 1 ? RB_KEXEC : RB_AUTOBOOT);
 
 	return 0;
diff --git a/tools/testing/selftests/liveupdate/luo_cpu_preserve.c b/tools/testing/selftests/liveupdate/luo_cpu_preserve.c
new file mode 100644
index 000000000000..85d17ccf3d90
--- /dev/null
+++ b/tools/testing/selftests/liveupdate/luo_cpu_preserve.c
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * Copyright (c) 2026, Google LLC.
+ * Pasha Tatashin <pasha.tatashin@soleen.com>
+ *
+ * A selftest to validate the lifecycle of preserved CPUs across Live Update
+ * and within a local session.
+ */
+
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <unistd.h>
+
+#include <libliveupdate.h>
+
+#define TEST_SESSION_NAME "cpu-preserve-session"
+#define STATE_SESSION_NAME "cpu_preserve_state"
+#define STATE_MEMFD_TOKEN 999
+#define TEST_CPU_TOKEN 0x100
+
+static int find_target_cpu(void)
+{
+	char path[128];
+	int cpu;
+
+	for (cpu = 1; cpu < 256; cpu++) {
+		snprintf(path, sizeof(path), "/sys/devices/system/cpu/cpu%d/preserve", cpu);
+		if (access(path, R_OK) == 0) {
+			snprintf(path, sizeof(path), "/sys/devices/system/cpu/cpu%d/online", cpu);
+			if (access(path, R_OK) == 0)
+				return cpu;
+		}
+	}
+	return -1;
+}
+
+static int read_cpu_online(int cpu)
+{
+	char path[128], buf[16];
+	int fd, val = -1;
+
+	snprintf(path, sizeof(path), "/sys/devices/system/cpu/cpu%d/online", cpu);
+	fd = open(path, O_RDONLY);
+	if (fd < 0)
+		return -1;
+	if (read(fd, buf, sizeof(buf) - 1) > 0)
+		val = atoi(buf);
+	close(fd);
+	return val;
+}
+
+static int preserve_cpu_fd(int session_fd, int cpu, int token)
+{
+	struct liveupdate_session_preserve_fd pfd = {};
+	char path[128];
+	int cpu_fd, ret;
+
+	snprintf(path, sizeof(path), "/sys/devices/system/cpu/cpu%d/preserve", cpu);
+	cpu_fd = open(path, O_RDONLY);
+	if (cpu_fd < 0)
+		return -1;
+
+	pfd.size = sizeof(pfd);
+	pfd.fd = cpu_fd;
+	pfd.token = token;
+
+	ret = ioctl(session_fd, LIVEUPDATE_SESSION_PRESERVE_FD, &pfd);
+	close(cpu_fd);
+	return ret;
+}
+
+/* Stage 1: Executed before kexec */
+static void run_stage_1(int luo_fd)
+{
+	int target_cpu, session_fd;
+
+	target_cpu = find_target_cpu();
+	if (target_cpu < 0)
+		fail_exit("No hotpluggable CPU with preserve attribute found");
+
+	ksft_print_msg("[STAGE 1] Target CPU for preservation: %d\n", target_cpu);
+
+	create_state_file(luo_fd, STATE_SESSION_NAME, STATE_MEMFD_TOKEN, target_cpu);
+
+	session_fd = luo_create_session(luo_fd, TEST_SESSION_NAME);
+	if (session_fd < 0)
+		fail_exit("luo_create_session for '%s'", TEST_SESSION_NAME);
+
+	if (preserve_cpu_fd(session_fd, target_cpu, TEST_CPU_TOKEN) < 0)
+		fail_exit("preserve_cpu_fd for cpu %d", target_cpu);
+
+	if (read_cpu_online(target_cpu) != 0)
+		fail_exit("CPU %d was expected to be offline after preservation", target_cpu);
+
+	ksft_print_msg("[STAGE 1] CPU %d successfully preserved and offlined\n", target_cpu);
+
+	close(luo_fd);
+	daemonize_and_wait();
+}
+
+/* Stage 2: Executed after kexec */
+static void run_stage_2(int luo_fd, int state_session_fd)
+{
+	struct liveupdate_session_retrieve_fd rfd = {};
+	int target_cpu, session_fd;
+
+	restore_and_read_stage(state_session_fd, STATE_MEMFD_TOKEN, &target_cpu);
+	ksft_print_msg("[STAGE 2] Restored target CPU: %d\n", target_cpu);
+
+	session_fd = luo_retrieve_session(luo_fd, TEST_SESSION_NAME);
+	if (session_fd < 0)
+		fail_exit("luo_retrieve_session for '%s'", TEST_SESSION_NAME);
+
+	rfd.size = sizeof(rfd);
+	rfd.token = TEST_CPU_TOKEN;
+	if (ioctl(session_fd, LIVEUPDATE_SESSION_RETRIEVE_FD, &rfd) < 0)
+		fail_exit("LIVEUPDATE_SESSION_RETRIEVE_FD for cpu token %#x", TEST_CPU_TOKEN);
+
+	close(rfd.fd);
+
+	if (read_cpu_online(target_cpu) != 1)
+		fail_exit("CPU %d was expected to be online after retrieval", target_cpu);
+
+	ksft_print_msg("[STAGE 2] CPU %d successfully retrieved and online\n", target_cpu);
+
+	if (luo_session_finish(session_fd) < 0)
+		fail_exit("luo_session_finish for test session");
+	close(session_fd);
+
+	if (luo_session_finish(state_session_fd) < 0)
+		fail_exit("luo_session_finish for state session");
+	close(state_session_fd);
+
+	ksft_print_msg("\n--- CPU PRESERVATION KEXEC TEST PASSED ---\n");
+}
+
+int main(int argc, char *argv[])
+{
+	return luo_test(argc, argv, STATE_SESSION_NAME,
+			run_stage_1, run_stage_2);
+}
diff --git a/tools/testing/selftests/liveupdate/run-vmtests.sh b/tools/testing/selftests/liveupdate/run-vmtests.sh
index d656ce58c5a7..1b90d56ec4a2 100755
--- a/tools/testing/selftests/liveupdate/run-vmtests.sh
+++ b/tools/testing/selftests/liveupdate/run-vmtests.sh
@@ -20,6 +20,7 @@ TEST_NAMES=(
 	"luo_multi_session"
 	"luo_stress_files"
 	"luo_stress_sessions"
+	"luo_cpu_preserve"
 )
 
 function usage() {
diff --git a/tools/testing/selftests/liveupdate/vmtest.sh b/tools/testing/selftests/liveupdate/vmtest.sh
index 64fd2ab55b76..c934c76c00a0 100755
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
@@ -179,7 +181,7 @@ function run_qemu() {
 
 	echo "# Serial Log: $serial"
 	timeout 30s \
-	$qemu_cmd -m 1G -smp 2 -no-reboot -nographic -nodefaults \
+	$qemu_cmd -m 1G -smp 4 -no-reboot -nographic -nodefaults \
 		  -accel tcg -accel hvf -accel kvm \
 		  -serial file:"$serial" \
 		  -append "$cmdline" \
-- 
2.55.0.1082.g2b9226bbc0-goog


