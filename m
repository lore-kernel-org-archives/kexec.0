Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87681CD6E51
	for <kexec@archiver.kernel.org>; Fri, 29 May 2026 14:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vyAIkWzZgGB6LrCF6zuZOLFTfkZ2Yg44+ju3GGAi4XQ=; b=FpRrzGC6+RpW3ny8NocPnZUz8K
	/Xr5/N+G4LTz83JKWxBTDpNFFLhHeP8C0qUvPmIhY7LrXWffDxgp9zbvXCvMTsmvD1eho98+hy+Bq
	h4onU03BdmCTKc8620Fnac0Qiz8111eYqIMdveZzjLa8q6qdOuYNW+1RIo8ZmFCC4HoSgHHjjl4N7
	8xq2N1GsykScnimCRb1W+kMhff6OGcbDMz33Na8MlKffvZRGGqOWQVVzYiYiQGU07QtUiYXDH1euP
	bMJLz9caGLU0gEVAanCpHNUt0eXR6D99omJBYfn1vmWJx0pGbzRh8pQN4PcHFxsr7IbXypOePMGRN
	H3cgjZsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSyHH-00000007Woq-38S2;
	Fri, 29 May 2026 14:33:35 +0000
Received: from out-183.mta0.migadu.com ([2001:41d0:1004:224b::b7])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSyHE-00000007Wl2-1t1E
	for kexec@lists.infradead.org;
	Fri, 29 May 2026 14:33:33 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780065209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vyAIkWzZgGB6LrCF6zuZOLFTfkZ2Yg44+ju3GGAi4XQ=;
	b=DafaDXjjSeXGtjcjH2mCT9Xli+n/rYnZ0YEXjHK9TESaf44ilrrY9qDK2pVPBNOUC6X2W8
	r5hjtFAUjrfNCw94N3YpQ0/74WSpfZLeHgojtLEPfX3phj3XxYiJg061ipNs57HTx5U1YJ
	+aJMEBCCPHZRhAQq1vkm8Fe0d7cADrw=
From: George Guo <dongtai.guo@linux.dev>
To: Huacai Chen <chenhuacai@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>,
	Alexander Graf <graf@amazon.com>,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	George Guo <guodongtai@kylinos.cn>
Subject: [PATCH v2 4/4] selftests/kho: handle QEMU not exiting after kexec on LoongArch
Date: Fri, 29 May 2026 22:32:38 +0800
Message-Id: <20260529143238.169169-5-dongtai.guo@linux.dev>
In-Reply-To: <20260529143238.169169-1-dongtai.guo@linux.dev>
References: <20260529143238.169169-1-dongtai.guo@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260529_073332_863361_34D0426F 
X-CRM114-Status: GOOD (  10.20  )
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

On LoongArch, QEMU provides only a minimal EFI stub with no runtime
services and no ACPI tables, so machine_restart() falls through to
its infinite idle loop and QEMU never exits after kexec.  The test
result is already printed to the serial console and vmtest.sh reports
success, but the user must press Ctrl+C to get the prompt back.

Add QEMU_NEEDS_KILL=1 to loongarch.conf so the test completes
unattended.

Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 tools/testing/selftests/kho/loongarch.conf |  3 ++
 tools/testing/selftests/kho/vmtest.sh      | 32 ++++++++++++++++++----
 2 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kho/loongarch.conf b/tools/testing/selftests/kho/loongarch.conf
index 0145cb49e5b2..02a6add633f1 100644
--- a/tools/testing/selftests/kho/loongarch.conf
+++ b/tools/testing/selftests/kho/loongarch.conf
@@ -8,3 +8,6 @@ CONFIG_SERIAL_8250_CONSOLE=y
 "
 KERNEL_IMAGE="vmlinux.efi"
 KERNEL_CMDLINE="console=ttyS0 earlycon"
+# QEMU never exits after kexec on LoongArch (no EFI runtime services),
+# so vmtest.sh must kill it once the test verdict appears.
+QEMU_NEEDS_KILL=1
diff --git a/tools/testing/selftests/kho/vmtest.sh b/tools/testing/selftests/kho/vmtest.sh
index a6ae9ac09595..821e13fa69a5 100755
--- a/tools/testing/selftests/kho/vmtest.sh
+++ b/tools/testing/selftests/kho/vmtest.sh
@@ -107,12 +107,32 @@ function run_qemu() {
 
 	cmdline="$cmdline kho=on panic=-1"
 
-	$qemu_cmd -m 1G -smp 2 -no-reboot -nographic -nodefaults \
-		  -accel kvm -accel hvf -accel tcg  \
-		  -serial file:"$serial" \
-		  -append "$cmdline" \
-		  -kernel "$kernel" \
-		  -initrd "$initrd"
+	local qemu_args=(
+		-m 1G -smp 2 -no-reboot -nographic -nodefaults
+		-accel kvm -accel hvf -accel tcg
+		-serial file:"$serial"
+		-append "$cmdline"
+		-kernel "$kernel"
+		-initrd "$initrd"
+	)
+
+	# If the target does not exit QEMU after kexec (e.g. no EFI runtime
+	# services), the conf file sets QEMU_NEEDS_KILL=1.  Run QEMU in the
+	# background, poll for the test verdict, then kill it.
+	if [[ "${QEMU_NEEDS_KILL:-0}" == "1" ]]; then
+		$qemu_cmd "${qemu_args[@]}" &
+		local qemu_pid=$!
+		local remaining=100
+		while ((remaining-- > 0)); do
+			grep -q "KHO restore succeeded\|KHO restore failed" \
+				"$serial" 2>/dev/null && break
+			sleep 1
+		done
+		kill "$qemu_pid" 2>/dev/null
+		wait "$qemu_pid" 2>/dev/null || true
+	else
+		$qemu_cmd "${qemu_args[@]}"
+	fi
 
 	grep "KHO restore succeeded" "$serial" &> /dev/null || fail "KHO failed"
 }
-- 
2.25.1


