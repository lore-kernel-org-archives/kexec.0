Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3B0606A31E
	for <kexec@archiver.kernel.org>; Thu, 29 Oct 2026 17:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=hzm7KVoL;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=xPnFkVGP
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=/+hjM5CsEedso/LlGxQH+kdJiIeJBeEghJpwPsmuqXM=; b=hzm7KVoL01ljph
	cU7opjv5W0tSPYWDbKam79o1r+baigBg1wcqozOVZ6n+UAeYKShIj6VlHv6dK+H7NETyIKMfECpcv
	TW9eA5EryKHejcwHSureRyEv5ue8MaSfyxZ4BVqIg6uksu0skLyQIr0I1KWuRbQEcyI11n2fgsJ7C
	JVrQHFmJBF+NNGaPfEYD1MMyxjAint4M3IIXAElteVAIvjknS1/tLAuDTBi/mrePzAf7FV/X9qXze
	+u7VbLr6dSRZ2drC3hQOyNdmeJxmxByOyRy/pqVkpzl8RMC963B8ge2EdguRXFtAJ5RJzk9WLqfzr
	4VnVd9ijI2s8cZ2nsE3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMTxw-00000009yih-3VAF;
	Thu, 29 Oct 2026 17:31:04 +0000
Received: from out-5.mta1.migadu.com ([95.215.58.5] helo=mta1.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMTxs-00000009yej-3oLS
	for kexec@lists.infradead.org;
	Thu, 29 Oct 2026 17:31:03 +0000
X-Envelope-To: kexec@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=XjaLIKpPNBz8YS+fveYxov34nv5lXYqg9aUyoW4HF6I=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793295058; v=1; x=1793899858;
 b=xPnFkVGPL1QlatO8UExQBh7I/oQ7dCIPtcm0w9D9uT/f3tQiHIeMhfaVOfxkUr317Yy8D3qq
 Z9q+BkBVSYSu8XAvbF7V302QzSYfro1VtTONorAqqtsMb84XMbG+lFZgfoRYpIiT7eF/FRER19m
 tadG1qwTfbcTGi96CL0Qf208=
X-Envelope-To: kexec@lists.infradead.org
Received: by smtp.migadu.com with ESMTPS id 072f51d6be77a39d;
	Thu, 29 Oct 2026 17:30:58 +0000
X-Mizu-Trace-ID: 072f51d6be77a39d
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
Subject: [PATCH v6 7/8] selftests/kho: Add LoongArch vmtest support
Date: Fri, 30 Oct 2026 02:29:54 +0900
Message-ID: <20261029172956.20791-8-dongtai.guo@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261029172956.20791-1-dongtai.guo@linux.dev>
References: <20261029172956.20791-1-dongtai.guo@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261029_103101_110484_C8387810 
X-CRM114-Status: GOOD (  15.33  )
X-Spam-Score: -2.8 (--)
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

Add loongarch.conf to run the test on QEMU's LoongArch virtual machine
with a la464 CPU and an 8250 serial console, and let vmtest.sh accept
the loongarch64 target.

Boot vmlinux.efi through EFI firmware. The EFI stub installs the KHO EFI
table, and QEMU's direct kernel boot would skip the stub. QEMU_EFI
defaults to /usr/share/edk2/loongarch64/QEMU_EFI.fd and can be set for
distributions that install the firmware elsewhere, such as Debian's
qemu-efi-loongarch64 package.

QEMU's LoongArch virtual machine has no i8042 controller. Enable the
generic PCI host so its I/O space is mapped before the i8042 fallback
probe touches the legacy ports. This keeps i8042 enabled, so the same
kernel configuration still works on real hardware.

Enable ACPI_SPCR_TABLE so the bare earlycon parameter gets the UART from
the SPCR table installed by EDK2. Unlike x86, LoongArch does not enable
it by default, and without it there is no early console and vmtest sees
no early boot output.

The KHO vmtest needs CONFIG_DEFERRED_STRUCT_PAGE_INIT=y, which depends
on SPARSEMEM, so select CONFIG_SPARSEMEM_MANUAL=y.

Co-developed-by: Kexin Liu <liukexin@kylinos.cn>
Signed-off-by: Kexin Liu <liukexin@kylinos.cn>
Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 tools/testing/selftests/kho/loongarch.conf | 11 +++++++++++
 tools/testing/selftests/kho/vmtest.sh      |  3 ++-
 2 files changed, 13 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/kho/loongarch.conf

diff --git a/tools/testing/selftests/kho/loongarch.conf b/tools/testing/selftests/kho/loongarch.conf
new file mode 100644
index 000000000000..36153b03c4ef
--- /dev/null
+++ b/tools/testing/selftests/kho/loongarch.conf
@@ -0,0 +1,11 @@
+QEMU_EFI="${QEMU_EFI:-/usr/share/edk2/loongarch64/QEMU_EFI.fd}"
+QEMU_CMD="qemu-system-loongarch64 -M virt -cpu la464 -bios $QEMU_EFI"
+QEMU_KCONFIG="
+CONFIG_ACPI_SPCR_TABLE=y
+CONFIG_PCI_HOST_GENERIC=y
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SPARSEMEM_MANUAL=y
+"
+KERNEL_IMAGE="vmlinux.efi"
+KERNEL_CMDLINE="console=ttyS0 earlycon"
diff --git a/tools/testing/selftests/kho/vmtest.sh b/tools/testing/selftests/kho/vmtest.sh
index 0014bd76e88d..d05ba0734b25 100755
--- a/tools/testing/selftests/kho/vmtest.sh
+++ b/tools/testing/selftests/kho/vmtest.sh
@@ -21,7 +21,7 @@ Options:
 	-d)	path to the kernel build directory
 	-j)	number of jobs for compilation, similar to -j in make
 	-t)	run test for target_arch, requires CROSS_COMPILE set
-		supported targets: aarch64, x86_64
+		supported targets: aarch64, loongarch64, x86_64
 	-h)	display this help
 EOF
 }
@@ -126,6 +126,7 @@ function target_to_arch() {
 
 	case $target in
 	     aarch64) echo "arm64" ;;
+	     loongarch64) echo "loongarch" ;;
 	     x86_64) echo "x86" ;;
 	     *) skip "architecture $target is not supported"
 	esac
-- 
2.53.0


