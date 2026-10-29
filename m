Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D024606A31D
	for <kexec@archiver.kernel.org>; Thu, 29 Oct 2026 17:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=2Ao0oOFX;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=W9LFoFBs
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=hjl3YWLB9mIMK4NxN5xFoTsa4zvmwEeXlgSjnO0OUbA=; b=2Ao0oOFXLVY2Jp
	2OskrYXPCwAsy+SwBUPBRljPOCbHWd9i0oL5nvt/Y4IbEstyMmwOC1xejIgI+ogxJRIXWZJFQ7e0Q
	gnwXJI9opQbVJrdIuDw9/83xneNhsfxY/DAfAQYg0mdqdllglAM7Sm5T6iPzBGjvLLODmrjr9D9xc
	OOMHG41VF0A4/KBJtU0lGw1lgzgCSmyfZUkoMDOTmxZlBv718FJvTO2kXLeIgEr9XtX3eEBtwquh7
	L84JFN5Xq82st6kozgn1Ey3YGCGynRoYJ2v5I5n5NC+Bh/ETk/tIu+fJ5L6bqMvXYJ5mqSYCoGKqc
	PZhVBwOMq9lUGzGi6I0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMTy2-00000009ymI-003d;
	Thu, 29 Oct 2026 17:31:10 +0000
Received: from out-250.mta0.migadu.com ([2001:41d0:1004:224b::fa] helo=mta0.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMTxz-00000009yif-011s
	for kexec@lists.infradead.org;
	Thu, 29 Oct 2026 17:31:08 +0000
X-Envelope-To: kexec@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=GBih4azSAalhMpwQa4vAt/wr7df5ETSpm+lkTN2YYcw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793295064; v=1; x=1793899864;
 b=W9LFoFBszpWry1/NSZbVhjNsFbcVuSrt/CoO/JfaLe7WiVW7vFpNJY7uGjKf+aJPQSKJXkIV
 06V+5qqpODl9AsLap7BQ8oVrkrYL+GpTR9hNsSgs8TMSSct9wgIdgHD1c/40EKKFuVfRSevj1BA
 V7H11bHuwTRyacCfRGC8mjeE=
X-Envelope-To: kexec@lists.infradead.org
Received: by smtp.migadu.com with ESMTPS id d28391d344248cfb;
	Thu, 29 Oct 2026 17:31:04 +0000
X-Mizu-Trace-ID: d28391d344248cfb
X-Migadu-Flow: FLOW_OUT
From: George Guo <dongtai.guo@linux.dev>
To: rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	chenhuacai@kernel.org,
	ardb@kernel.org,
	shuah@kernel.org
Cc: ilias.apalodimas@linaro.org,
	akpm@linux-foundation.org,
	baoquan.he@linux.dev,
	ruirui.yang@linux.dev,
	guodongtai@kylinos.cn,
	kernel@xen0n.name,
	graf@amazon.com,
	liukexin@kylinos.cn,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-efi@vger.kernel.org
Subject: [PATCH v6 8/8] selftests/liveupdate: Add LoongArch vmtest support
Date: Fri, 30 Oct 2026 02:29:55 +0900
Message-ID: <20261029172956.20791-9-dongtai.guo@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261029172956.20791-1-dongtai.guo@linux.dev>
References: <20261029172956.20791-1-dongtai.guo@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261029_103107_249150_34FDEB80 
X-CRM114-Status: GOOD (  13.99  )
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

From: George Guo <guodongtai@kylinos.cn>

Add the LoongArch kernel configuration, target and cross-compiler
detection, and include loongarch64 in the VM test suite.

Boot vmlinux.efi through EFI firmware so the EFI stub installs the KHO
table. Allow the firmware path to be set with QEMU_EFI and skip the test
if it is unavailable.

Co-developed-by: Kexin Liu <liukexin@kylinos.cn>
Signed-off-by: Kexin Liu <liukexin@kylinos.cn>
Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 .../selftests/liveupdate/config.loongarch64        |  5 +++++
 tools/testing/selftests/liveupdate/run-vmtests.sh  |  4 ++--
 tools/testing/selftests/liveupdate/vmtest.sh       | 14 +++++++++++++-
 3 files changed, 20 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/liveupdate/config.loongarch64

diff --git a/tools/testing/selftests/liveupdate/config.loongarch64 b/tools/testing/selftests/liveupdate/config.loongarch64
new file mode 100644
index 000000000000..264067ef5ab1
--- /dev/null
+++ b/tools/testing/selftests/liveupdate/config.loongarch64
@@ -0,0 +1,5 @@
+CONFIG_ACPI_SPCR_TABLE=y
+CONFIG_PCI_HOST_GENERIC=y
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SMP=y
diff --git a/tools/testing/selftests/liveupdate/run-vmtests.sh b/tools/testing/selftests/liveupdate/run-vmtests.sh
index d656ce58c5a7..f6cfb76b1dac 100755
--- a/tools/testing/selftests/liveupdate/run-vmtests.sh
+++ b/tools/testing/selftests/liveupdate/run-vmtests.sh
@@ -4,7 +4,7 @@
 SCRIPT_DIR=$(dirname "$(realpath "$0")")
 TEST_RUNNER="$SCRIPT_DIR/vmtest.sh"
 
-TARGETS=("x86_64" "aarch64")
+TARGETS=("x86_64" "aarch64" "loongarch64")
 
 GREEN='\033[0;32m'
 RED='\033[0;31m'
@@ -72,7 +72,7 @@ function main() {
 		for test_name in "${TEST_NAMES[@]}"; do
 			log="$output_dir/${arch}_${test_name}.log"
 
-			printf "  -> %-8s %-24s ... " "$arch" "$test_name"
+			printf "  -> %-11s %-24s ... " "$arch" "$test_name"
 
 			"$TEST_RUNNER" -t "$arch" -T "$test_name" &> "$log"
 			exit_code=$?
diff --git a/tools/testing/selftests/liveupdate/vmtest.sh b/tools/testing/selftests/liveupdate/vmtest.sh
index 69beda6c961d..ffe82512f3e4 100755
--- a/tools/testing/selftests/liveupdate/vmtest.sh
+++ b/tools/testing/selftests/liveupdate/vmtest.sh
@@ -21,6 +21,12 @@ function get_arch_conf() {
 		QEMU_CMD="qemu-system-aarch64 -M virt -cpu max"
 		KERNEL_IMAGE="Image"
 		KERNEL_CMDLINE="console=ttyAMA0"
+	elif [[ "$arch" == "loongarch" ]]; then
+		local qemu_efi="${QEMU_EFI:-/usr/share/edk2/loongarch64/QEMU_EFI.fd}"
+		[ -r "$qemu_efi" ] || skip "EFI firmware '$qemu_efi' not found, set QEMU_EFI"
+		QEMU_CMD="qemu-system-loongarch64 -M virt -cpu la464 -bios $qemu_efi"
+		KERNEL_IMAGE="vmlinux.efi"
+		KERNEL_CMDLINE="console=ttyS0 earlycon"
 	elif [[ "$arch" == "x86" ]]; then
 		QEMU_CMD="qemu-system-x86_64"
 		KERNEL_IMAGE="bzImage"
@@ -37,11 +43,15 @@ $0 [-d build_dir] [-j jobs] [-t target_arch] [-T test_name] [-w workspace_dir] [
 Options:
 	-d)	path to the kernel build directory (default: .luo_test_build.<arch>)
 	-j)	number of jobs for compilation
-	-t)	run test for target_arch (aarch64, x86_64)
+	-t)	run test for target_arch (aarch64, loongarch64, x86_64)
 	-T)	test name to run (default: luo_kexec_simple)
 	-w)	custom workspace directory (default: creates temp dir)
 	-k)	keep workspace directory after successful test
 	-h)	display this help
+
+Environment:
+	QEMU_EFI	LoongArch EFI firmware path
+			(default: /usr/share/edk2/loongarch64/QEMU_EFI.fd)
 EOF
 }
 
@@ -86,6 +96,7 @@ function detect_cross_compile() {
 	local candidate=""
 	case "$target" in
 		aarch64) candidate="aarch64-linux-gnu-" ;;
+		loongarch64) candidate="loongarch64-linux-gnu-" ;;
 		x86_64)  candidate="x86_64-linux-gnu-" ;;
 		*)       skip "Auto-detection for target '$target' not supported. Please set CROSS_COMPILE manually." ;;
 	esac
@@ -193,6 +204,7 @@ function target_to_arch() {
 	local target=$1
 	case $target in
 	     aarch64) echo "arm64" ;;
+	     loongarch64) echo "loongarch" ;;
 	     x86_64) echo "x86" ;;
 	     *) skip "architecture $target is not supported"
 	esac
-- 
2.53.0


