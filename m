Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52D50CD5BBF
	for <kexec@archiver.kernel.org>; Mon, 25 May 2026 06:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tYxwosLkp+8p8G15z4kXkSPo4todC1a7rfK+baWf0Ng=; b=M7DGMzvMK07gIChoeYtFdlFYGR
	XEEDwN3ppVVyo6U9CkmIKE7KItoXKdrhy5ASyjaWrLlJnq7l2okn9Vs+8ag5QpFpuW5/eDesoTRk/
	AWdaJIYqKON9ZTevvXTHH8pTKtbEnvQ/NpIt5T9nmv5K4ufmSv+zjrtO5kZ30ALsbzW5OOn/zO0Gd
	pDIGNxQvPC7QcqBrmePubDJsNL0fZSR2trsSYpdZgZ+Ljn6cOOeNyT9R2ypeOVpAqPNf07n01Fdjt
	pi4IKjrzyZqk5ceo8ddNxTxzvAqISIcKRKPQOe0wzKgfnLfMUojH0AQx2Sco3PQIkbZzt1lfDm32x
	9OD0d11A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wROnt-0000000GQBs-1uhx;
	Mon, 25 May 2026 06:28:45 +0000
Received: from out-186.mta1.migadu.com ([95.215.58.186])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wROnr-0000000GQ98-0ZW4
	for kexec@lists.infradead.org;
	Mon, 25 May 2026 06:28:44 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779690520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tYxwosLkp+8p8G15z4kXkSPo4todC1a7rfK+baWf0Ng=;
	b=tapMzdVlPtDDpbGp9ExBzdrIWJd5Y2uo8fnGLvCqnWZtlCYloM8DKKodK5W+vk8n8kh2zT
	bfsvelwOgxjow3PTKnfGN1YfC+4DEJwagn4PVMZlpiRhbPSa+9NbkpAWv3FaTpceQHBKZy
	McUhOyUC4DTF/o7X/PEECcln0mOrJ/Y=
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
	George Guo <guodongtai@kylinos.cn>
Subject: [PATCH 7/7] selftests/kho: handle QEMU not exiting after kexec on LoongArch
Date: Mon, 25 May 2026 14:28:10 +0800
Message-Id: <20260525062810.103367-8-dongtai.guo@linux.dev>
In-Reply-To: <20260525062810.103367-1-dongtai.guo@linux.dev>
References: <20260525062810.103367-1-dongtai.guo@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260524_232843_319828_F54BDF6E 
X-CRM114-Status: UNSURE (   7.95  )
X-CRM114-Notice: Please train this message.
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
its infinite idle loop and QEMU never exits after kexec.

Poll the serial output for the test verdict and kill QEMU once
it appears, rather than waiting for QEMU to exit naturally.

Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 tools/testing/selftests/kho/vmtest.sh | 35 +++++++++++++++++++++------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/kho/vmtest.sh b/tools/testing/selftests/kho/vmtest.sh
index a6ae9ac09595..3cb9674e4475 100755
--- a/tools/testing/selftests/kho/vmtest.sh
+++ b/tools/testing/selftests/kho/vmtest.sh
@@ -103,16 +103,37 @@ function run_qemu() {
 	local qemu_cmd=$1
 	local cmdline=$2
 	local kernel=$3
+	local arch=$4
 	local serial="$tmp_dir/qemu.serial"
 
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
+	# On LoongArch, EFI runtime services are unavailable after kexec so
+	# machine_restart() hangs and QEMU never exits on its own.  Run QEMU
+	# in the background, poll for the test result, then kill it.
+	if [[ "$arch" == "loongarch" ]]; then
+		$qemu_cmd "${qemu_args[@]}" &
+		local qemu_pid=$!
+		local timeout=100
+		while ((timeout-- > 0)); do
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
@@ -179,7 +200,7 @@ function main() {
 	local kernel="$build_dir/arch/$arch/boot/$KERNEL_IMAGE"
 	mkinitrd "$kernel"
 
-	run_qemu "$QEMU_CMD" "$KERNEL_CMDLINE" "$kernel"
+	run_qemu "$QEMU_CMD" "$KERNEL_CMDLINE" "$kernel" "$arch"
 
 	ktap_test_pass "KHO succeeded"
 }
-- 
2.25.1


