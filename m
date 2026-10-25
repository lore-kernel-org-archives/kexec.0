Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C94606A324
	for <kexec@archiver.kernel.org>; Sun, 25 Oct 2026 17:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=xVIrWiqz;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=Rja6gNvE
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=bAlNiVr8BQR0wHHuK51By00coxfZadVdizds6cbggxE=; b=xVIrWiqzeTWgj5
	9hw4cx6BauCo1xrncY3FJpvrPc43eMJ+7JG2hr3epg/W+ubfk+Wsa6XpdQNTpcmYkIDmwaFiPbkij
	Uu9j22PNnVdgy5cZeyyDcZo+t6zG3ItrbDdalaIYiMtop8IE3mnNcp8O3pjgMgdE/lKIewhQvKVjE
	CPtvmcgKeYnyFeV2z7lRaljMNFGX3uXE7ESCprNgNjLGV971BX7TZ0njnlAshx+FTPGBGHYOKyWvA
	XVNxfaIl/OhDS+H3EhOFYlPzvjepI9Ari4Jzjxsp/ItpwBtRRluPmAKDp8Z/0iPrRTPFQ6DFAq2EN
	ezGNRqnrvpQorPg2Y1Dw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xL2Cz-00000001F9k-0qPV;
	Sun, 25 Oct 2026 17:40:37 +0000
Received: from mail-vk1-xa32.google.com ([2607:f8b0:4864:20::a32])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xL2Cv-00000001F2Q-1RGp
	for kexec@lists.infradead.org;
	Sun, 25 Oct 2026 17:40:35 +0000
Received: by mail-vk1-xa32.google.com with SMTP id 71dfb90a1353d-5eabf243d05so931433e0c.2
        for <kexec@lists.infradead.org>; Sun, 25 Oct 2026 10:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792950032; x=1793554832; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=bAlNiVr8BQR0wHHuK51By00coxfZadVdizds6cbggxE=;
        b=Rja6gNvEOuPoHuh92NxlIjPuk2nuocGLYj6t3VkPuzwO1hF3aiIbZDuWLJibImEhSv
         HEscmKE6iseeZe9KGcNjHwRp8agfn4yGAg6OHSVOYGg25w8qxqU/zhBMvOLrdGPYl5FO
         z7luENyeqWe5XwLRgjXbPFkTw9UClqSQUPzCWk0N3ckHrD8DX7/2XxAfud9MrvEEY90f
         cHeqpaxvNDGYirs57FF5mxRQQoM+UmqEBVPMD+uXLFYIbp1Dq8TNFJIVcqmankXzf/Vb
         YNISHK8/SxXn7wMTHI8w1oZSFPIQw37ushVDWxuF8Oky5nfBBLQtqzbkQvuqjNOU305C
         Px8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792950032; x=1793554832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=bAlNiVr8BQR0wHHuK51By00coxfZadVdizds6cbggxE=;
        b=DXzJhoDysGlwFrG1tcakq0G4Ouu2j5tMWwRBwkLHtjsY2Uita+sYH8qiuqt5InaWmI
         WHEHxaD0kmsJhfN7zjL+OBUzFoblrhBqRZ2TUGSAdbHtR0ByzH8EvlkSH9MDFaLEnXYt
         HchlDBLX81PCcLQgXkFdl4AL1sp9lhS1/WASjIWBTH8AhBiOzpb9ekRrQqscsfA5O/pj
         6oNN5fIdpJZ2XuiSmwhHdJbfQDnAwACcj/l9SixATAc+kqM4Nbi6tumKLvMhquppcZ41
         2y2/4yYPxTcWipTpohB68L1mPo4v9BxF37uUYia+VV8oe879dme9U3hETKK1DoFCktoE
         FlTg==
X-Forwarded-Encrypted: i=1; AKwUvBzvaoUEjUp+KSq3l4lCsJxDixo3H99wWhsmfgM9Az2cSFlWcOoW16ohbVj80oUgUftKdypsyA==@lists.infradead.org
X-Gm-Message-State: AFq9FYKlkol/rIpXcxaelZv4eLPinF0WKVkgs/2F7eA1VR1ptEOEATSr
	/2OzXj7fQNXpogfo/CoHjOlmGhRxwiJXTJdprF6jcZmuB9EFNTusqDYBlUyrzYoVzPs=
X-Gm-Gg: AYBFou1UhS/KL4GDQYUuoLDQjmtohbViK3wp4FSbgR95JtEcHc2g294RX6/0XXz79hv
	cYmB+anh72yYkkLbnWBjyQfj3ZMTbkGSdkn/z2g99YHQrpgriLV4hJIW6ihELSFaYPqV6euCS1w
	0nKpBqt1SL9PU4CD4MMbOciVCB3KuzJ5FeRHrBHBIrf1IBGdZIKwLRd+7AmwerCW2RKif8uMUXw
	hSnhe/PbfrdfCH45tUKQmpSG9lsUd1T4xIziPLBya2DQwZovmCqWoWhMd9GF9O+kgoB/SZwvHnK
	oYJLRQiIA/KTapZO8TxC5lswohyxuaQuPiuerulnnp8eiyEEHokyOEIpc0sYf7UNuHDufEJO0xd
	AryPW0xxeP1comXaKqkNtPibkF6cUkiJfge8WP13Ot9gziXScV8Aj5Qz+hEgHz9wks6d4XBpKvI
	V6mcR7HEs8l/DmD+nYD6HzAs6qIT6QhAaq0X/zeMnIs99JhcVkPGV3pWPemEMmSEOklcb83rF1z
	9CRJdZiK7RnOtYQqWAnXaqK+fmobwweyxLlBZA2A6EeKlNB4V+dsce+1coWoLxka0ky+vp9UJj4
	7TH1r8VmztoC+GPgRjeQlZHErN22lgVSv1bS13W94sybBBbOpwYtCPufEgAfcVPQ8mdQ1Y0JshD
	T
X-Received: by 2002:a05:6122:3117:b0:5ea:e196:272b with SMTP id 71dfb90a1353d-5ec23326b7amr1522204e0c.19.1792950031820;
        Sun, 25 Oct 2026 10:40:31 -0700 (PDT)
Received: from soleen.c.googlers.com.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec234673ebsm5783333e0c.13.2026.10.25.10.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 10:40:31 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: linux-kselftest@vger.kernel.org,
	rppt@kernel.org,
	kuba@kernel.org,
	enelsonmoore@gmail.com,
	bp@alien8.de,
	shuah@kernel.org,
	david@kernel.org,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	ljs@kernel.org,
	mhocko@suse.com,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	vbabka@kernel.org,
	dapeng1.mi@linux.intel.com,
	linux-kernel@vger.kernel.org,
	corbet@lwn.net,
	surenb@google.com,
	pasha.tatashin@soleen.com,
	kexec@lists.infradead.org,
	pratyush@kernel.org,
	rdunlap@infradead.org,
	elver@google.com,
	graf@amazon.com,
	lirongqing@baidu.com,
	liam@infradead.org,
	jlayton@kernel.org
Subject: [PATCH v2 9/9] selftests: kho: add read-only KHO test to vmtest.sh
Date: Sun, 25 Oct 2026 13:40:16 -0400
Message-ID: <20261025174017.3870481-10-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
In-Reply-To: <20261025174017.3870481-1-pasha.tatashin@soleen.com>
References: <20261025174017.3870481-1-pasha.tatashin@soleen.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261025_104033_423498_B72575F4 
X-CRM114-Status: GOOD (  19.03  )
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,LOTS_OF_MONEY,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

vmtest.sh currently only tests standard KHO restoration and does not
exercise read-only KHO mode ('kho_ro=<fdt_phys>') in QEMU.

Extend tools/testing/selftests/kho/vmtest.sh and init.c to enable both
CONFIG_KEXEC_HANDOVER=y and CONFIG_KEXEC_HANDOVER_READONLY=y in the
kernel configuration and run a second QEMU test verifying read-only KHO
after the standard KHO test on both x86_64 and aarch64:

- Enable CONFIG_KEXEC_HANDOVER_READONLY=y alongside
  CONFIG_KEXEC_HANDOVER=y in build_kernel().
- Pass KHO_RO_CMDLINE ('nokaslr kho_bootmem=64M,64M,64M' on x86_64) to
  the first kernel in the read-only test run and configure 4G of RAM on
  aarch64 so GFP_KERNEL KHO allocations are placed in ZONE_NORMAL above
  4G, outside the read-only kernel's System RAM.
- When booted with 'kho_ro_test', read /debugfs/kho/out/fdt_phys in
  init.c and kexec into the target kernel with 'kho_ro=<fdt_phys>' and
  architecture-specific memory parameters
  ('memmap=792M$16M memmap=24M$1000M' on x86_64, 'mem=128M' on aarch64)
  so the preserved pages are excluded from the boot memory map and
  mapped via kho_ro_map_folio().
- Verify 'KHO restore succeeded' from test_kho in read-only mode.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 tools/testing/selftests/kho/arm64.conf |  1 +
 tools/testing/selftests/kho/init.c     | 38 ++++++++++++++-
 tools/testing/selftests/kho/vmtest.sh  | 65 ++++++++++++++++----------
 tools/testing/selftests/kho/x86.conf   |  1 +
 4 files changed, 79 insertions(+), 26 deletions(-)

diff --git a/tools/testing/selftests/kho/arm64.conf b/tools/testing/selftests/kho/arm64.conf
index ee696807cd35..202f92121695 100644
--- a/tools/testing/selftests/kho/arm64.conf
+++ b/tools/testing/selftests/kho/arm64.conf
@@ -1,4 +1,5 @@
 QEMU_CMD="qemu-system-aarch64 -M virt -cpu max"
+QEMU_MEM="4G"
 QEMU_KCONFIG="
 CONFIG_SERIAL_AMBA_PL010=y
 CONFIG_SERIAL_AMBA_PL010_CONSOLE=y
diff --git a/tools/testing/selftests/kho/init.c b/tools/testing/selftests/kho/init.c
index 88a41b6eba95..e2ebcf7ab307 100644
--- a/tools/testing/selftests/kho/init.c
+++ b/tools/testing/selftests/kho/init.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <stdio.h>
+#include <string.h>
 #include <unistd.h>
 #include <fcntl.h>
 #include <sys/syscall.h>
@@ -12,6 +13,15 @@
 #define COMMAND_LINE_SIZE	2048
 
 #define KERNEL_IMAGE "/kernel"
+#define FDT_PHYS_PATH "/debugfs/kho/out/fdt_phys"
+
+#if defined(__x86_64__)
+#define KHO_RO_MEM_PARAM "memmap=792M$16M memmap=24M$1000M"
+#elif defined(__aarch64__)
+#define KHO_RO_MEM_PARAM "mem=128M"
+#else
+#define KHO_RO_MEM_PARAM ""
+#endif
 
 static int mount_filesystems(void)
 {
@@ -32,7 +42,8 @@ static long kexec_file_load(int kernel_fd, int initrd_fd,
 static int kexec_load(void)
 {
 	char cmdline[COMMAND_LINE_SIZE];
-	ssize_t len;
+	ssize_t len, fdt_len;
+	char fdt_phys[64];
 	int fd, err;
 
 	fd = open("/proc/cmdline", O_RDONLY);
@@ -41,11 +52,34 @@ static int kexec_load(void)
 
 	len = read(fd, cmdline, sizeof(cmdline));
 	close(fd);
-	if (len < 0)
+	if (len <= 0)
 		return -1;
 
 	/* replace \n with \0 */
 	cmdline[len - 1] = 0;
+
+	if (strstr(cmdline, "kho_ro_test")) {
+		fd = open(FDT_PHYS_PATH, O_RDONLY);
+		if (fd < 0)
+			return -1;
+
+		fdt_len = read(fd, fdt_phys, sizeof(fdt_phys) - 1);
+		close(fd);
+		if (fdt_len <= 0)
+			return -1;
+
+		if (fdt_phys[fdt_len - 1] == '\n')
+			fdt_len--;
+		fdt_phys[fdt_len] = 0;
+
+		len = (len - 1) + snprintf(cmdline + len - 1,
+					   sizeof(cmdline) - (len - 1),
+					   " kho_ro=%s " KHO_RO_MEM_PARAM,
+					   fdt_phys) + 1;
+		if (len <= 0 || (size_t)len > sizeof(cmdline))
+			return -1;
+	}
+
 	fd = open(KERNEL_IMAGE, O_RDONLY);
 	if (fd < 0)
 		return -1;
diff --git a/tools/testing/selftests/kho/vmtest.sh b/tools/testing/selftests/kho/vmtest.sh
index 0014bd76e88d..ca59a58ae2fb 100755
--- a/tools/testing/selftests/kho/vmtest.sh
+++ b/tools/testing/selftests/kho/vmtest.sh
@@ -35,17 +35,12 @@ trap cleanup EXIT
 function skip() {
 	local msg=${1:-""}
 
-	ktap_test_skip "$msg"
+	while [[ "$KTAP_TESTNO" -le "$KSFT_NUM_TESTS" ]]; do
+		ktap_test_skip "$msg"
+	done
 	exit "$KSFT_SKIP"
 }
 
-function fail() {
-	local msg=${1:-""}
-
-	ktap_test_fail "$msg"
-	exit "$KSFT_FAIL"
-}
-
 function build_kernel() {
 	local build_dir=$1
 	local make_cmd=$2
@@ -55,10 +50,11 @@ function build_kernel() {
 	local kho_config="$tmp_dir/kho.config"
 	local kconfig="$build_dir/.config"
 
-	# enable initrd, KHO and KHO test in kernel configuration
-	tee "$kconfig" > "$kho_config" <<EOF
+	# enable initrd, KHO, read-only KHO, and KHO test in kernel configuration
+	cat > "$kho_config" <<EOF
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_KEXEC_HANDOVER=y
+CONFIG_KEXEC_HANDOVER_READONLY=y
 CONFIG_KEXEC_HANDOVER_DEBUG=y
 CONFIG_KEXEC_HANDOVER_DEBUGFS=y
 CONFIG_TEST_KEXEC_HANDOVER=y
@@ -71,11 +67,25 @@ $arch_kconfig
 EOF
 
 	make_cmd="$make_cmd -C $kernel_dir O=$build_dir"
-	$make_cmd olddefconfig
+	local need_config=0
+	if [[ ! -f "$kconfig" ]]; then
+		need_config=1
+	else
+		while read -r opt ; do
+			[[ -z "$opt" ]] && continue
+			grep -q "^$opt$" "$kconfig" || need_config=1
+		done < "$kho_config"
+	fi
+
+	if [[ "$need_config" -eq 1 ]]; then
+		cp "$kho_config" "$kconfig"
+		$make_cmd olddefconfig
+	fi
 
-	# verify that kernel confiration has all necessary options
+	# verify that kernel configuration has all necessary options
 	while read -r opt ; do
-		grep "$opt" "$kconfig" &>/dev/null || skip "$opt is missing"
+		[[ -z "$opt" ]] && continue
+		grep -q "^$opt$" "$kconfig" || skip "$opt is missing"
 	done < "$kho_config"
 
 	$make_cmd "$kimage"
@@ -107,18 +117,23 @@ function run_qemu() {
 	local qemu_cmd=$1
 	local cmdline=$2
 	local kernel=$3
+	local test_name=$4
 	local serial="$tmp_dir/qemu.serial"
 
 	cmdline="$cmdline kho=on panic=-1"
 
-	$qemu_cmd -m 1G -smp 2 -no-reboot -nographic -nodefaults \
-		  -accel kvm -accel hvf -accel tcg  \
-		  -serial file:"$serial" \
-		  -append "$cmdline" \
-		  -kernel "$kernel" \
-		  -initrd "$initrd"
-
-	grep "KHO restore succeeded" "$serial" &> /dev/null || fail "KHO failed"
+	rm -f "$serial"
+	if $qemu_cmd -m "${QEMU_MEM:-1G}" -smp 2 -no-reboot -nographic -nodefaults \
+		     -accel kvm -accel hvf -accel tcg  \
+		     -serial file:"$serial" \
+		     -append "$cmdline" \
+		     -kernel "$kernel" \
+		     -initrd "$initrd" && \
+	   grep "KHO restore succeeded" "$serial" &> /dev/null; then
+		ktap_test_pass "$test_name succeeded"
+	else
+		ktap_test_fail "$test_name failed"
+	fi
 }
 
 function target_to_arch() {
@@ -164,7 +179,7 @@ function main() {
 	done
 
 	ktap_print_header
-	ktap_set_plan 1
+	ktap_set_plan 2
 
 	if [[ "$target" != "$(uname -m)" ]] && [[ -z "$CROSS_COMPILE" ]]; then
 		skip "Cross-platform testing needs to specify CROSS_COMPILE"
@@ -182,9 +197,11 @@ function main() {
 	local kernel="$build_dir/arch/$arch/boot/$KERNEL_IMAGE"
 	mkinitrd "$kernel"
 
-	run_qemu "$QEMU_CMD" "$KERNEL_CMDLINE" "$kernel"
+	trap - ERR
 
-	ktap_test_pass "KHO succeeded"
+	run_qemu "$QEMU_CMD" "$KERNEL_CMDLINE" "$kernel" "KHO"
+	run_qemu "$QEMU_CMD" "$KERNEL_CMDLINE ${KHO_RO_CMDLINE:-} kho_ro_test" \
+		 "$kernel" "KHO read-only"
 }
 
 main "$@"
diff --git a/tools/testing/selftests/kho/x86.conf b/tools/testing/selftests/kho/x86.conf
index b419e610ca22..2c097c5bd6c6 100644
--- a/tools/testing/selftests/kho/x86.conf
+++ b/tools/testing/selftests/kho/x86.conf
@@ -5,3 +5,4 @@ CONFIG_SERIAL_8250_CONSOLE=y
 "
 KERNEL_IMAGE="bzImage"
 KERNEL_CMDLINE="console=ttyS0"
+KHO_RO_CMDLINE="nokaslr kho_bootmem=64M,64M,64M"
-- 
2.56.0.307.g5fe7bd680c-goog


