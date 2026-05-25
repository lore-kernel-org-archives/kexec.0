Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DAF4CD5BCB
	for <kexec@archiver.kernel.org>; Mon, 25 May 2026 06:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1DpUemWUGyJtUUApdw/ETRvltxpRFxe9n1wlPX0btGE=; b=3UBTijVWcm+jaoWZOUGK3r09x4
	eSIDUuvH9bBk1mYqTF6c+6OA3KpZXfhr/+a9uPC6Y2Pv8iQ2YH9hrV5fDnd/rmPg42C20C4noRBBu
	vNNJ2HCtd9Wr3esga19ZmMrobbzrwprJuDqO+r+I5znrpVJnD3hpQwZbBTHWSdPZVAvxDDCVVx+AN
	QR8HQd8v/wSILvYD5JGrPZdmYgSmZ7lEbes9RxtOxiw5wEmNudAecKLS/i87+XypACSnpYJdk/Huv
	7/0pGM2IfmtwL/rTVC51/icjBoF/G7BKteZj4yEJJii6SmMo7ZbzsyjYrt71oB/z2k+jKY956Twbu
	xdsKNtLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wROnq-0000000GQA0-1crN;
	Mon, 25 May 2026 06:28:42 +0000
Received: from out-174.mta1.migadu.com ([95.215.58.174])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wROno-0000000GQ6q-0Cvk
	for kexec@lists.infradead.org;
	Mon, 25 May 2026 06:28:41 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779690517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1DpUemWUGyJtUUApdw/ETRvltxpRFxe9n1wlPX0btGE=;
	b=Yucifz/sdS2vKuW192qxuRBEWgSXVsddVL+KNGf+XI6D7sznnV9iJsKaKPcj5drGUYn+YD
	JBL+Z4v3QQJ3d074krQwygVweZ8fObWIwiw8MI7MMywq3T+IFQ2Ebk0zut2bAiCsDUu7KV
	PVHuh2mBNxiXm+o0Usrwp+1/B1cI60E=
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
Subject: [PATCH 6/7] selftests/kho: LoongArch: disable PS/2 input devices for QEMU virt
Date: Mon, 25 May 2026 14:28:09 +0800
Message-Id: <20260525062810.103367-7-dongtai.guo@linux.dev>
In-Reply-To: <20260525062810.103367-1-dongtai.guo@linux.dev>
References: <20260525062810.103367-1-dongtai.guo@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260524_232840_240732_84395A79 
X-CRM114-Status: UNSURE (   9.89  )
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

QEMU's LoongArch virt machine has no i8042 PS/2 controller.  When PNP
detection finds nothing, i8042_init() falls back to probing the ports
directly.  On LoongArch the I/O ports are memory-mapped, and the i8042
port addresses are not backed by any device on the virt machine, so
i8042_flush() takes a page fault and the kernel panics:

  i8042: PNP: No PS/2 controller found.
  i8042: Probing ports directly.
  CPU 0 Unable to handle kernel paging request at virtual address ffff800000008064
  ERA: i8042_flush+0x50/0x198
   RA: i8042_init+0x2a8/0x35c
  Kernel panic - not syncing: Attempted to kill init!

Disable SERIO_I8042 and its dependents (KEYBOARD_ATKBD, MOUSE_PS2) in
the QEMU_KCONFIG fragment to prevent the driver from being built.

Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 tools/testing/selftests/kho/loongarch.conf | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/kho/loongarch.conf b/tools/testing/selftests/kho/loongarch.conf
index b0551e0c2d77..0145cb49e5b2 100644
--- a/tools/testing/selftests/kho/loongarch.conf
+++ b/tools/testing/selftests/kho/loongarch.conf
@@ -2,6 +2,9 @@ QEMU_CMD="qemu-system-loongarch64 -M virt -cpu la464"
 QEMU_KCONFIG="
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
+# CONFIG_KEYBOARD_ATKBD is not set
+# CONFIG_MOUSE_PS2 is not set
+# CONFIG_SERIO_I8042 is not set
 "
 KERNEL_IMAGE="vmlinux.efi"
 KERNEL_CMDLINE="console=ttyS0 earlycon"
-- 
2.25.1


