Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3048FC982EE
	for <kexec@archiver.kernel.org>; Sun, 20 Sep 2026 20:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pYr/9NMKeUZAYHni34Sv6tdHvQS74uTyy8Pha66A4FI=; b=ZMPMMp+KR2HEApOWr9GBKjG077
	2VnvmSTkDxS6FxNs7ktSzWs0rrGukkbWR8jjT0bzCN3QgGWKxkKDkNx7IXr47QAIMJxRHAvSwl/FG
	fmxsuGiWmHb+gYgdvM8fWXu9uFLlbxYsoxzFgZQKEfxiMo87/Mbj5621oaT1L2nG+NSQP/JjmNzmA
	YxJTeX3VDqKm4UVrYZRRFpNCVbGBGPgHjM7WeL+GFxaIKYrqYnBhSR0Rgy3B1XfyFdPZ7O/HoSJd4
	yKM0MJBB3RX61Gbcyou4E+koAg+egf7r5Kt3Nr5T+lFsQi2yBZ2oQemw+1Nq1nbfIIFHuJ3Fxn3/C
	TC6XiM9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8O4u-00000000Ng9-3PfD;
	Sun, 20 Sep 2026 20:24:00 +0000
Received: from mail-yx2-x0e.google.com ([2607:f8b0:4864:41::e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8NNL-00000000Iyh-34Q4
	for kexec@lists.infradead.org;
	Sun, 20 Sep 2026 19:39:00 +0000
Received: by mail-yx2-x0e.google.com with SMTP id 00721157ae682-89666ee9b3bso13451507b3.0
        for <kexec@lists.infradead.org>; Sun, 20 Sep 2026 12:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1789933138; x=1790537938; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pYr/9NMKeUZAYHni34Sv6tdHvQS74uTyy8Pha66A4FI=;
        b=PDvuNaMfad+flNIex+qG46MXjxZRI0SkP9ixJPVq2hjAp7LufYKgdnJTfd7oPK7JWu
         bYUQW0UQQaO8iKovbD24US/nmmoFEy/B3T2WrOTPuQ04uC2In52iWxZLESbFIB8dEx/v
         89skUQO9/PrL+YK6GERuQ6wQocE/WbVhJcwo/pz3sNm6yx4DOa75GKdKnguod0cOldjg
         v7oRCcf5g9WKmVdILHacLyW17trLvOq47j7onk+MiqjBnZ8moAKETH8N79MGgumXMWd8
         PAYSTzkFYiYF5rOpPUbgf1QyWXxdJqotQz/TZObi+fRoK9EVIyKiJwIqtC1bs7XqtU3v
         FwPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789933138; x=1790537938;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=pYr/9NMKeUZAYHni34Sv6tdHvQS74uTyy8Pha66A4FI=;
        b=fVzkToCbQeM+6Jb4hBDV5KZa6E/5GUnqx9X+rsufWTLonNn0iidMHIV6gjajp34FqQ
         mo0VGEc6D0f3pLIAMW8T7dX6P5rTtuzTdwM8VGT8GdFMYcnuFiP88fGmwORyaLH56HNF
         sCtCkZ6wHsEdr1rUk4bPUDpLKYl23z8G4mmzc/dul4wlCk5R+obIHT1eTDs1OfnS2gYX
         U7IbHlEUrpHPmlDqhI16zE7InZdEk6YFkct0baPXwBi5N8IE0+aD2FVKZYmPQ7UkzAnL
         s91WSaqwP1o8TMZpteR+0KSp2R1uxxIpwMd92CBqbWbp97Lpw/BuOF2O30KuVE87Jiwr
         H+pw==
X-Forwarded-Encrypted: i=1; AKwUvBwDQjYSKhgWA0f+MdFSJeFvOkzMAuUEATxxeWPIcdiJ7S9G1n0AEVgMvEO/i074MCRT9eTFdA==@lists.infradead.org
X-Gm-Message-State: AFuF++lIRHhQeusXvVxWXmKNzBMQ2ujr97GZfL34b5KIwdjrr2foQI1Y
	QEt7Ez/7RBY8necAD03r6y284r+5UGnALtckZWpoJ0+ZDcGymzBcv5doiexEvqiUFBU=
X-Gm-Gg: AYBFou2lzof5HalifVzgCL7toEUPngmK7y61kR9LTsIJG422l1gcYIkl36TwD6/P16x
	44SQDGCEDR9BA5daXARlKfls7NIhwNIG2hydAPiTn1fEvpuQM1r6C4fuPNDQ1vdB21Qx6ecxZQW
	0tLs1J1wcQB3is088peHKt1VtzrzwuZVmUqjbcKj9fc8XXx9ULFqMFpSqVUhdQZp4qNgfjWlQWA
	4IwqO9vcIpufjOOI9tNHnlK3e3VJzEBZZl4Y6RUWivLpHa7GmHhnedA1UyHhKfItcbuAj/GIRoE
	XFGJmN0meWntiBOa/6WX2EWDBFUDPTyAH1tAxqCWWKFHLknI+cIHc1M+5jLLmmEcofTskJZASZL
	2zK5Hz5YZY1+7StmqON8iFfT15awZGgy7bY3u1+pQvrGeZlnKnVvOdPWYwrKr1cbW0k3WJjWUnw
	hbDGLF/44EL607zWbrP+78yLyoRHvogos9f6MZiIKzNsqNOJo4u9B82NCWBy/3lDqqEXeiQ6cgf
	N9PdlhpoJLWQai9KtpYHt2EDmmweqCTWVmBN733BkXf1Iz3k9B3i6z9yeX/Lo8zaVJ8Caka3/bV
	saACZ6fGVYfpihEbuPg=
X-Received: by 2002:a05:690c:e196:20b0:89a:63da:cbe9 with SMTP id 00721157ae682-89a63daccb1mr15163787b3.47.1789933138554;
        Sun, 20 Sep 2026 12:38:58 -0700 (PDT)
Received: from soleen.c.googlers.com.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-89a482d3648sm18568067b3.39.2026.09.20.12.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 12:38:58 -0700 (PDT)
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
Subject: [RFC PATCH 21/46] selftests: liveupdate: Add physical CPU preservation unit tests
Date: Sun, 20 Sep 2026 15:36:25 -0400
Message-ID: <20260920193650.3373435-22-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <20260920193650.3373435-1-pasha.tatashin@soleen.com>
References: <20260920193650.3373435-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260920_123859_791854_D210519B 
X-CRM114-Status: GOOD (  16.69  )
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

Add unit tests exercising CPU preservation sysfs interface:
- Verify /sys/devices/system/cpu/cpu<N>/preserve operations.
- Test CPU offline and preserve sequencing.
- Verify status reporting and error handling.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 tools/testing/selftests/liveupdate/config     |   6 +
 .../testing/selftests/liveupdate/liveupdate.c | 251 ++++++++++++++++++
 2 files changed, 257 insertions(+)

diff --git a/tools/testing/selftests/liveupdate/config b/tools/testing/selftests/liveupdate/config
index 016d009dba13..9458b9c70eeb 100644
--- a/tools/testing/selftests/liveupdate/config
+++ b/tools/testing/selftests/liveupdate/config
@@ -5,8 +5,14 @@ CONFIG_KEXEC_HANDOVER=y
 CONFIG_KEXEC_HANDOVER_ENABLE_DEFAULT=y
 CONFIG_KEXEC_HANDOVER_DEBUGFS=y
 CONFIG_KEXEC_HANDOVER_DEBUG=y
+CONFIG_SMP=y
+CONFIG_HOTPLUG_CPU=y
 CONFIG_LIVEUPDATE=y
 CONFIG_LIVEUPDATE_TEST=y
+CONFIG_LIVEUPDATE_CPU=y
+CONFIG_ACPI=y
+CONFIG_ACPI_PROCESSOR=y
+CONFIG_ACPI_HOTPLUG_CPU=y
 CONFIG_MEMFD_CREATE=y
 CONFIG_TMPFS=y
 CONFIG_SHMEM=y
diff --git a/tools/testing/selftests/liveupdate/liveupdate.c b/tools/testing/selftests/liveupdate/liveupdate.c
index 2dedd5fc2534..b3c9cd7ea653 100644
--- a/tools/testing/selftests/liveupdate/liveupdate.c
+++ b/tools/testing/selftests/liveupdate/liveupdate.c
@@ -530,4 +530,255 @@ TEST_F(liveupdate_device, preserve_many_files)
 	ASSERT_EQ(close(session_fd), 0);
 }
 
+static int find_hotplug_cpu(void)
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
+	int fd, val;
+
+	snprintf(path, sizeof(path), "/sys/devices/system/cpu/cpu%d/online", cpu);
+	fd = open(path, O_RDONLY);
+	if (fd < 0)
+		return -1;
+	memset(buf, 0, sizeof(buf));
+	if (read(fd, buf, sizeof(buf) - 1) <= 0) {
+		close(fd);
+		return -1;
+	}
+	close(fd);
+	val = atoi(buf);
+	return val;
+}
+
+static int write_cpu_online(int cpu, int val)
+{
+	char path[128], buf[16];
+	int fd, ret;
+
+	snprintf(path, sizeof(path), "/sys/devices/system/cpu/cpu%d/online", cpu);
+	fd = open(path, O_WRONLY);
+	if (fd < 0)
+		return -errno;
+	snprintf(buf, sizeof(buf), "%d\n", val);
+	ret = write(fd, buf, strlen(buf));
+	if (ret < 0) {
+		ret = -errno;
+		close(fd);
+		return ret;
+	}
+	close(fd);
+	return 0;
+}
+
+/*
+ * Test Case: CPU Preservation Basic
+ *
+ * Verifies that a CPU preserve sysfs file descriptor can be preserved in a
+ * LUO session, offlining the CPU from scheduler and returning it online upon
+ * session teardown.
+ */
+TEST_F(liveupdate_device, cpu_preserve_basic)
+{
+	char path[128];
+	int target_cpu;
+	int session_fd, cpu_fd;
+
+	self->fd1 = open(LIVEUPDATE_DEV, O_RDWR);
+	if (self->fd1 < 0 && errno == ENOENT)
+		SKIP(return, "%s does not exist", LIVEUPDATE_DEV);
+	ASSERT_GE(self->fd1, 0);
+
+	target_cpu = find_hotplug_cpu();
+	if (target_cpu < 0)
+		SKIP(return, "No hotpluggable CPU with preserve attribute found");
+
+	snprintf(path, sizeof(path), "/sys/devices/system/cpu/cpu%d/preserve", target_cpu);
+	cpu_fd = open(path, O_RDONLY);
+	ASSERT_GE(cpu_fd, 0);
+
+	session_fd = luo_create_session(self->fd1, "cpu-preserve-test");
+	ASSERT_GE(session_fd, 0);
+
+	ASSERT_EQ(luo_session_preserve_fd(session_fd, cpu_fd, 0x42), 0);
+	close(cpu_fd);
+
+	/* Verify target CPU is now offline */
+	ASSERT_EQ(read_cpu_online(target_cpu), 0);
+
+	/* Closing session unpreserves and brings CPU back online */
+	ASSERT_EQ(close(session_fd), 0);
+	ASSERT_EQ(read_cpu_online(target_cpu), 1);
+}
+
+/*
+ * Test Case: CPU Preservation Sysfs Online/Offline Rejection
+ *
+ * Verifies that while a CPU is preserved, attempting to bring it online
+ * via sysfs fails with -EBUSY. After session closure, normal online/offline
+ * hotplug operations succeed.
+ */
+TEST_F(liveupdate_device, cpu_preserve_sysfs_online_offline)
+{
+	char path[128];
+	int target_cpu;
+	int session_fd, cpu_fd;
+
+	self->fd1 = open(LIVEUPDATE_DEV, O_RDWR);
+	if (self->fd1 < 0 && errno == ENOENT)
+		SKIP(return, "%s does not exist", LIVEUPDATE_DEV);
+	ASSERT_GE(self->fd1, 0);
+
+	target_cpu = find_hotplug_cpu();
+	if (target_cpu < 0)
+		SKIP(return, "No hotpluggable CPU with preserve attribute found");
+
+	snprintf(path, sizeof(path), "/sys/devices/system/cpu/cpu%d/preserve", target_cpu);
+	cpu_fd = open(path, O_RDONLY);
+	ASSERT_GE(cpu_fd, 0);
+
+	session_fd = luo_create_session(self->fd1, "cpu-preserve-sysfs");
+	ASSERT_GE(session_fd, 0);
+
+	ASSERT_EQ(luo_session_preserve_fd(session_fd, cpu_fd, 0x100), 0);
+	close(cpu_fd);
+
+	/* Target CPU is offline while preserved */
+	ASSERT_EQ(read_cpu_online(target_cpu), 0);
+
+	/* Attempting to bring the preserved CPU online via sysfs must fail with EBUSY */
+	EXPECT_EQ(write_cpu_online(target_cpu, 1), -EBUSY);
+	ASSERT_EQ(read_cpu_online(target_cpu), 0);
+
+	/* Writing 0 to online (offline) should succeed since it is already offline */
+	EXPECT_EQ(write_cpu_online(target_cpu, 0), 0);
+
+	/* Close session -> unpreserve and restore online */
+	ASSERT_EQ(close(session_fd), 0);
+	ASSERT_EQ(read_cpu_online(target_cpu), 1);
+
+	/* Verify normal offline and online now succeed */
+	ASSERT_EQ(write_cpu_online(target_cpu, 0), 0);
+	ASSERT_EQ(read_cpu_online(target_cpu), 0);
+	ASSERT_EQ(write_cpu_online(target_cpu, 1), 0);
+	ASSERT_EQ(read_cpu_online(target_cpu), 1);
+}
+
+/*
+ * Test Case: Prevent Double CPU Preservation
+ *
+ * Verifies that a CPU cannot be preserved twice across the same or different
+ * sessions simultaneously.
+ */
+TEST_F(liveupdate_device, cpu_preserve_prevent_double)
+{
+	char path[128];
+	int target_cpu;
+	int session_fd1, session_fd2, cpu_fd1, cpu_fd2;
+
+	self->fd1 = open(LIVEUPDATE_DEV, O_RDWR);
+	if (self->fd1 < 0 && errno == ENOENT)
+		SKIP(return, "%s does not exist", LIVEUPDATE_DEV);
+	ASSERT_GE(self->fd1, 0);
+
+	target_cpu = find_hotplug_cpu();
+	if (target_cpu < 0)
+		SKIP(return, "No hotpluggable CPU with preserve attribute found");
+
+	session_fd1 = luo_create_session(self->fd1, "cpu-double-1");
+	ASSERT_GE(session_fd1, 0);
+	session_fd2 = luo_create_session(self->fd1, "cpu-double-2");
+	ASSERT_GE(session_fd2, 0);
+
+	snprintf(path, sizeof(path), "/sys/devices/system/cpu/cpu%d/preserve", target_cpu);
+	cpu_fd1 = open(path, O_RDONLY);
+	ASSERT_GE(cpu_fd1, 0);
+
+	ASSERT_EQ(luo_session_preserve_fd(session_fd1, cpu_fd1, 0x10), 0);
+	close(cpu_fd1);
+
+	/* Attempting to preserve the same CPU in session2 must fail with -EBUSY */
+	cpu_fd2 = open(path, O_RDONLY);
+	ASSERT_GE(cpu_fd2, 0);
+	EXPECT_EQ(luo_session_preserve_fd(session_fd2, cpu_fd2, 0x20), -EBUSY);
+	close(cpu_fd2);
+
+	/* Attempting to preserve again in session1 must also fail with -EBUSY */
+	cpu_fd2 = open(path, O_RDONLY);
+	ASSERT_GE(cpu_fd2, 0);
+	EXPECT_EQ(luo_session_preserve_fd(session_fd1, cpu_fd2, 0x30), -EBUSY);
+	close(cpu_fd2);
+
+	ASSERT_EQ(close(session_fd1), 0);
+	ASSERT_EQ(close(session_fd2), 0);
+	ASSERT_EQ(read_cpu_online(target_cpu), 1);
+}
+
+/*
+ * Test Case: Multiple Preserved CPUs
+ *
+ * Verifies preserving multiple distinct CPUs simultaneously in the same session.
+ */
+TEST_F(liveupdate_device, cpu_preserve_multiple_cpus)
+{
+	char path[128];
+	int target_cpus[8];
+	int num_targets = 0;
+	int session_fd, cpu_fd, cpu, i;
+
+	self->fd1 = open(LIVEUPDATE_DEV, O_RDWR);
+	if (self->fd1 < 0 && errno == ENOENT)
+		SKIP(return, "%s does not exist", LIVEUPDATE_DEV);
+	ASSERT_GE(self->fd1, 0);
+
+	for (cpu = 1; cpu < 256 && num_targets < 8; cpu++) {
+		snprintf(path, sizeof(path), "/sys/devices/system/cpu/cpu%d/preserve", cpu);
+		if (access(path, R_OK) == 0) {
+			snprintf(path, sizeof(path), "/sys/devices/system/cpu/cpu%d/online", cpu);
+			if (access(path, R_OK) == 0)
+				target_cpus[num_targets++] = cpu;
+		}
+	}
+
+	if (num_targets < 2)
+		SKIP(return, "Need at least 2 hotpluggable CPUs for multiple CPU preserve test");
+
+	session_fd = luo_create_session(self->fd1, "multi-cpu-preserve");
+	ASSERT_GE(session_fd, 0);
+
+	for (i = 0; i < num_targets; i++) {
+		snprintf(path, sizeof(path),
+			 "/sys/devices/system/cpu/cpu%d/preserve", target_cpus[i]);
+		cpu_fd = open(path, O_RDONLY);
+		ASSERT_GE(cpu_fd, 0);
+		ASSERT_EQ(luo_session_preserve_fd(session_fd, cpu_fd, 0x1000 + i), 0);
+		close(cpu_fd);
+	}
+
+	/* Verify all targets are offline and reject sysfs online */
+	for (i = 0; i < num_targets; i++) {
+		ASSERT_EQ(read_cpu_online(target_cpus[i]), 0);
+		EXPECT_EQ(write_cpu_online(target_cpus[i], 1), -EBUSY);
+	}
+
+	/* Close session and verify all targets return online */
+	ASSERT_EQ(close(session_fd), 0);
+	for (i = 0; i < num_targets; i++)
+		ASSERT_EQ(read_cpu_online(target_cpus[i]), 1);
+}
+
 TEST_HARNESS_MAIN
-- 
2.55.0.1082.g2b9226bbc0-goog


