Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30B60CD5BC0
	for <kexec@archiver.kernel.org>; Mon, 25 May 2026 06:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mcgnzkCekxGDxlLfZgjscpscBgEbQ0p2mN6z74HWjig=; b=lwg9RLPAajp89+LrTkoVfFig+O
	ZOguKwHnKwWS24klsS87sy0YazXcHGaZRVZl5DztBbrwFJxz2gzTccfO9cFGiyKurq9c4VepO82QW
	rlPKh0aIRGzyL2TfcL1Mp+MmWSvLj8ZmYkjyRG9Y+zAYbZN+3rk1Xt/bG5pYjxlpWu6kByaXy/Xui
	GWQ95LJCXJyZP2eZ0BvNfvJV3kFhEUk83P0MnZZhqbRgZ+cvCCYYwj5PHZdKm1ilwSiDBuL1t6VoV
	Ay5pzUrix1NG+mVOnJKYuC4H+MsD0Q/YUnFCbm5JfJ6flf8mzZRE8/NaF7Th4K7PPZxc8/MsMapzL
	+OFiY3+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wROno-0000000GQ8Q-1Gf3;
	Mon, 25 May 2026 06:28:40 +0000
Received: from out-172.mta1.migadu.com ([95.215.58.172])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wROnk-0000000GQ4W-3TTL
	for kexec@lists.infradead.org;
	Mon, 25 May 2026 06:28:38 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779690514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mcgnzkCekxGDxlLfZgjscpscBgEbQ0p2mN6z74HWjig=;
	b=wF4CAHMKnaTjqP7CgZmhq1gjjZcsaQDDnRTJ7BOOXGt2R4+eBKLdLu6nFi1Etz86WDKBUm
	9eIv/D+TXkOgB43kU/9ITlfPggrXIbYYowsynT59if8vuDhnasmeCa25X6FhnqXoDxoTVg
	kRRqpHBBSpRR8UA7tn4RIUkQmoAWafA=
From: George Guo <dongtai.guo@linux.dev>
To: chenhuacai@kernel.org,
	rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org
Cc: kernel@xen0n.name,
	graf@amazon.com,
	shuah@kernel.org,
	loongarch@lists.linux.dev,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	George Guo <guodongtai@kylinos.cn>,
	Kexin Liu <liukexin@kylinos.cn>
Subject: [PATCH 5/7] selftests/kho: add LoongArch vmtest support
Date: Mon, 25 May 2026 14:28:08 +0800
Message-Id: <20260525062810.103367-6-dongtai.guo@linux.dev>
In-Reply-To: <20260525062810.103367-1-dongtai.guo@linux.dev>
References: <20260525062810.103367-1-dongtai.guo@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260524_232837_026100_31B3A069 
X-CRM114-Status: GOOD (  12.63  )
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

From: George Guo <guodongtai@kylinos.cn>

Add loongarch.conf to configure QEMU's LoongArch virt machine with a
la464 CPU, enable the 8250 serial console, and set the kernel image
to vmlinux.efi. Extend vmtest.sh to recognize loongarch64 as a
supported target and map it to the 'loongarch' kernel arch name.

QEMU's LoongArch virt machine provides no ACPI tables and relies on
FDT to describe hardware. Without 'earlycon' on the kernel command
line, the FDT is not scanned for a console UART, no output reaches
the console, and vmtest.sh's console log stays empty causing the test
to always fail. Add 'earlycon' to KERNEL_CMDLINE in loongarch.conf
to fix this.

Co-developed-by: Kexin Liu <liukexin@kylinos.cn>
Signed-off-by: Kexin Liu <liukexin@kylinos.cn>
Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 tools/testing/selftests/kho/loongarch.conf | 7 +++++++
 tools/testing/selftests/kho/vmtest.sh      | 3 ++-
 2 files changed, 9 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/kho/loongarch.conf

diff --git a/tools/testing/selftests/kho/loongarch.conf b/tools/testing/selftests/kho/loongarch.conf
new file mode 100644
index 000000000000..b0551e0c2d77
--- /dev/null
+++ b/tools/testing/selftests/kho/loongarch.conf
@@ -0,0 +1,7 @@
+QEMU_CMD="qemu-system-loongarch64 -M virt -cpu la464"
+QEMU_KCONFIG="
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+"
+KERNEL_IMAGE="vmlinux.efi"
+KERNEL_CMDLINE="console=ttyS0 earlycon"
diff --git a/tools/testing/selftests/kho/vmtest.sh b/tools/testing/selftests/kho/vmtest.sh
index 49fdac8e8b15..a6ae9ac09595 100755
--- a/tools/testing/selftests/kho/vmtest.sh
+++ b/tools/testing/selftests/kho/vmtest.sh
@@ -21,7 +21,7 @@ Options:
 	-d)	path to the kernel build directory
 	-j)	number of jobs for compilation, similar to -j in make
 	-t)	run test for target_arch, requires CROSS_COMPILE set
-		supported targets: aarch64, x86_64
+		supported targets: aarch64, x86_64, loongarch64
 	-h)	display this help
 EOF
 }
@@ -123,6 +123,7 @@ function target_to_arch() {
 	case $target in
 	     aarch64) echo "arm64" ;;
 	     x86_64) echo "x86" ;;
+	     loongarch64) echo "loongarch" ;;
 	     *) skip "architecture $target is not supported"
 	esac
 }
-- 
2.25.1


