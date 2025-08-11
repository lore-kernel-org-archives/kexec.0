Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B07DCA0EC4
	for <kexec@archiver.kernel.org>; Mon, 11 Aug 2025 08:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tlbJB+L4R3O7acATDOIm1feJEqppF/sXRloShshIIoo=; b=p9bpZK96FDeitOLWBiltjavEhW
	2HYCJ7WC7Mz5CaweyiaoueNAaHn3uOB83FQtTeuucllJ28WWYf1cWb0tIXMhWmmETO2KcubuoERt0
	JKqDM7zJ87yGBs+l2nXfg+a4RbDrpU4GlX3OUMOhpGTzQDkX8uAxFKmBfZn3BERicZhwDsXHO1MSB
	i7c/VyuOtIpYYlaOpDPLt+LLncmgApfwiRLC/4DFEi3MnDBstDKxcaN817Wv0m/edRc8+k+gezJTu
	kEzSOCtMo7scB61pQEn/7hNlfzKDuHTC9gONKoQiL0tcQXSnUqE6UmG8mB4HHL/KGm83fuaGo/HWa
	ysOYJp2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulOHP-00000006utu-1Wo5;
	Mon, 11 Aug 2025 08:53:19 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulNqb-00000006qXD-3ujt
	for kexec@lists.infradead.org;
	Mon, 11 Aug 2025 08:25:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 75A0A5C5BF9;
	Mon, 11 Aug 2025 08:25:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0AADC4CEF8;
	Mon, 11 Aug 2025 08:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754900737;
	bh=x9yDF0ETg1DZV483jmCAS7zdZyJxfX8QtrhsIOYLE3w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J+xamGjRj0qBZ8f+MKHSAySNijepwnYwt5H+o27/gEbgnXE3KQltdcbB0iHOqwdja
	 e3uxwJ+w5yxH41yVobpeGbK+tifeiohOed1kRfcIgZnRmaI0/zJph8jQ5jZVoQmEeA
	 SF8HdzQuD9/keUQlz5XLJhcPyyioXMA19Oobp3ATZm0iBRUf4g+5zifCSJpt16V6ae
	 aZW1oBggKLDmPu7m2OsuFxhT2HtyISgt7vOI/0pde2gNl2gwyV7EtRwVfP6dGR1CnN
	 VBZIFHyuTocPG+JYnv9+2PApCwJFsdR/g/PfEDfrLK1MTZdRF9ha1opuD5ix9iZ9en
	 HgZmIqifpPCkg==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Graf <graf@amazon.com>,
	Baoquan He <bhe@redhat.com>,
	Changyuan Lyu <changyuanl@google.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	=?UTF-8?q?Thomas=20Wei=DFschuh?= <linux@weissschuh.net>,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 3/3] selftest/kho: update generation of initrd
Date: Mon, 11 Aug 2025 11:25:10 +0300
Message-ID: <20250811082510.4154080-4-rppt@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250811082510.4154080-1-rppt@kernel.org>
References: <20250811082510.4154080-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250811_012538_061016_B732FAC7 
X-CRM114-Status: GOOD (  11.54  )
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

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

Use nolibc include directory rather than include a cumulative nolibc.h
on the compiler command line and replace use of 'sudo cpio' with
usr/gen_init_cpio.

While on it fix spelling of KHO_FINALIZE

Suggested-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 tools/testing/selftests/kho/init.c    | 13 ++++---------
 tools/testing/selftests/kho/vmtest.sh | 28 ++++++++++++++-------------
 2 files changed, 19 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/kho/init.c b/tools/testing/selftests/kho/init.c
index 8034e24c6bf6..6d9e91d55d68 100644
--- a/tools/testing/selftests/kho/init.c
+++ b/tools/testing/selftests/kho/init.c
@@ -1,22 +1,17 @@
 // SPDX-License-Identifier: GPL-2.0
 
-#ifndef NOLIBC
-#include <errno.h>
 #include <stdio.h>
 #include <unistd.h>
 #include <fcntl.h>
-#include <syscall.h>
+#include <sys/syscall.h>
 #include <sys/mount.h>
 #include <sys/reboot.h>
-#endif
+#include <linux/kexec.h>
 
 /* from arch/x86/include/asm/setup.h */
 #define COMMAND_LINE_SIZE	2048
 
-/* from include/linux/kexex.h */
-#define KEXEC_FILE_NO_INITRAMFS	0x00000004
-
-#define KHO_FINILIZE "/debugfs/kho/out/finalize"
+#define KHO_FINALIZE "/debugfs/kho/out/finalize"
 #define KERNEL_IMAGE "/kernel"
 
 static int mount_filesystems(void)
@@ -32,7 +27,7 @@ static int kho_enable(void)
 	const char enable[] = "1";
 	int fd;
 
-	fd = open(KHO_FINILIZE, O_RDWR);
+	fd = open(KHO_FINALIZE, O_RDWR);
 	if (fd < 0)
 		return -1;
 
diff --git a/tools/testing/selftests/kho/vmtest.sh b/tools/testing/selftests/kho/vmtest.sh
index ec70a17bd476..3f6c17166846 100755
--- a/tools/testing/selftests/kho/vmtest.sh
+++ b/tools/testing/selftests/kho/vmtest.sh
@@ -10,7 +10,6 @@ kernel_dir=$(realpath "$test_dir/../../../..")
 
 tmp_dir=$(mktemp -d /tmp/kho-test.XXXXXXXX)
 headers_dir="$tmp_dir/usr"
-initrd_dir="$tmp_dir/initrd"
 initrd="$tmp_dir/initrd.cpio"
 
 source "$test_dir/../kselftest/ktap_helpers.sh"
@@ -81,19 +80,22 @@ EOF
 function mkinitrd() {
 	local kernel=$1
 
-	mkdir -p "$initrd_dir"/{dev,debugfs,proc}
-	sudo mknod "$initrd_dir/dev/console" c 5 1
-
-	"$CROSS_COMPILE"gcc -s -static -Os -nostdinc -I"$headers_dir/include" \
-			-fno-asynchronous-unwind-tables -fno-ident -nostdlib \
-			-include "$test_dir/../../../include/nolibc/nolibc.h" \
-			-o "$initrd_dir/init" "$test_dir/init.c" \
-
-	cp "$kernel" "$initrd_dir/kernel"
+	"$CROSS_COMPILE"gcc -s -static -Os -nostdinc -nostdlib \
+			-fno-asynchronous-unwind-tables -fno-ident \
+			-I "$headers_dir/include" \
+			-I "$kernel_dir/tools/include/nolibc" \
+			-o "$tmp_dir/init" "$test_dir/init.c"
+
+	cat > "$tmp_dir/cpio_list" <<EOF
+dir /dev 0755 0 0
+dir /proc 0755 0 0
+dir /debugfs 0755 0 0
+nod /dev/console 0600 0 0 c 5 1
+file /init $tmp_dir/init 0755 0 0
+file /kernel $kernel 0644 0 0
+EOF
 
-	pushd "$initrd_dir" &>/dev/null
-	find . | cpio -H newc --create > "$initrd" 2>/dev/null
-	popd &>/dev/null
+	"$build_dir/usr/gen_init_cpio" "$tmp_dir/cpio_list" > "$initrd"
 }
 
 function run_qemu() {
-- 
2.47.2


