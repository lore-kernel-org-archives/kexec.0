Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AF1606D828
	for <kexec@archiver.kernel.org>; Tue,  3 Nov 2026 08:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=XOQN7DGQ;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=tF+CtXHV
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=c+UFJzAgy7f7fNDFNYwbu485X1uKYlUTNzJPVdBiORs=; b=XOQN7DGQ4F+rpM
	b4ZtFo20ZAhd4ZUrPlNW9sItUPDMoq5XnAgEq050BMIaHMvJM2m+oCWaNRTEiC4eKyg6fRHXvpQn+
	TSImYThdvLJk6sjhslrJy5dnKCkhcRL5HuqR6EfxeqUjMBqALsBKZ3atbDq8i5EvjJHZnjJV3QN+K
	+9nt05NDu9cg4pEN7ZAoI9T6JcYKyKSV1mkab+/nmUKJ24F9OeE5xCzO5uk2M+J2HNO5mgNw5CJkD
	AI7PnYp+UN/cN9ZwlRsvwH3ge6N0q5JJ3JOYJ3RKnY6orTlaJY3wLABzK2ubyLa/Zjkd3bTOGQQy2
	w57QjjNnm6ez7MsmzLjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO9ac-00000001ULC-2qmb;
	Tue, 03 Nov 2026 08:09:54 +0000
Received: from out30-124.freemail.mail.aliyun.com ([115.124.30.124])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO9aV-00000001UFh-2nQK;
	Tue, 03 Nov 2026 08:09:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793693385; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=c+UFJzAgy7f7fNDFNYwbu485X1uKYlUTNzJPVdBiORs=;
	b=tF+CtXHVwlX7o2mCzET7qWHgp2K6Oq1+vzQnNoueIzsAiwRYHbuCmXz/PPVThm+vvMCnkcBg1u5Jg0ukZ2gbOPcxCDrQ5Zgr702V1+5Jd9Wu67yku2SsBdLQjHTDA+ly1yQaeW4JxD1GvcyooO9SEwctrNwEPhkJcVqOtH3tJ2M=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0XE27L1F_1793693382;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0XE27L1F_1793693382 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 03 Nov 2026 16:09:43 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: pjw@kernel.org,
	palmer@dabbelt.com,
	alex@ghiti.fr,
	rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	graf@amazon.com,
	shuah@kernel.org
Cc: guoren@kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	kexec@lists.infradead.org
Subject: [PATCH v2 4/5] selftests: kho: Add riscv support
Date: Tue,  3 Nov 2026 16:09:25 +0800
Message-ID: <20261103080926.2079-5-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261103080926.2079-1-cp0613@linux.alibaba.com>
References: <20261103080926.2079-1-cp0613@linux.alibaba.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261103_000948_470676_2AF2B037 
X-CRM114-Status: GOOD (  11.67  )
X-Spam-Score: -17.6 (-----------------)
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
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Teach the KHO vmtest runner about riscv64: map the target to ARCH
riscv and describe the QEMU virt machine, the kernel image and its
console -- a 16550A port probed from the device tree on virt, hence
the SERIAL_8250{,_CONSOLE} and SERIAL_OF_PLATFORM symbols.  Also
select CONFIG_SPARSEMEM_MANUAL: the runner requires
CONFIG_DEFERRED_STRUCT_PAGE_INIT, which depends on SPARSEMEM, while
riscv falls back to FLATMEM (no ARCH_SPARSEMEM_DEFAULT), so without
it the test would just be skipped.

Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
---

Test: qemu-system-riscv64 (virt, -cpu max, TCG), in-tree runner
"tools/testing/selftests/kho/vmtest.sh -t riscv64" (boots the Image
and kexec'es into the same Image).

  KHO: found kexec handover data.
  KHO: exec from: 7.4.0-rc1-next-20261102-00005-gfca49e548231 (count 1)
  test_kho: KHO restore succeeded
  ok 1 KHO succeeded
  # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0

 tools/testing/selftests/kho/riscv.conf | 9 +++++++++
 tools/testing/selftests/kho/vmtest.sh  | 3 ++-
 2 files changed, 11 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/kho/riscv.conf

diff --git a/tools/testing/selftests/kho/riscv.conf b/tools/testing/selftests/kho/riscv.conf
new file mode 100644
index 000000000000..ec2a46cd45d5
--- /dev/null
+++ b/tools/testing/selftests/kho/riscv.conf
@@ -0,0 +1,9 @@
+QEMU_CMD="qemu-system-riscv64 -M virt -cpu max"
+QEMU_KCONFIG="
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_OF_PLATFORM=y
+CONFIG_SPARSEMEM_MANUAL=y
+"
+KERNEL_IMAGE="Image"
+KERNEL_CMDLINE="console=ttyS0"
diff --git a/tools/testing/selftests/kho/vmtest.sh b/tools/testing/selftests/kho/vmtest.sh
index 1e86ffcc3a79..56cac6ae3cf9 100755
--- a/tools/testing/selftests/kho/vmtest.sh
+++ b/tools/testing/selftests/kho/vmtest.sh
@@ -21,7 +21,7 @@ Options:
 	-d)	path to the kernel build directory
 	-j)	number of jobs for compilation, similar to -j in make
 	-t)	run test for target_arch, requires CROSS_COMPILE set
-		supported targets: aarch64, x86_64
+		supported targets: aarch64, x86_64, riscv64
 	-h)	display this help
 EOF
 }
@@ -127,6 +127,7 @@ function target_to_arch() {
 	case $target in
 	     aarch64) echo "arm64" ;;
 	     x86_64) echo "x86" ;;
+	     riscv64) echo "riscv" ;;
 	     *) skip "architecture $target is not supported"
 	esac
 }
-- 
2.50.1


