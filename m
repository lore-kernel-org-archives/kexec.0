Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1434E7717F
	for <kexec@archiver.kernel.org>; Mon, 16 Dec 2024 23:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xrUqJHk+DC7MJiWSLIDNfBawd31aIE7V5wzrcp1W6yM=; b=Waug0NVCXi4CrSuIFxkA1uPyWj
	xgXqCTkT6Lx28yWzXXErWIbiFU+DEfEAX41hafAWwsl/YgO0XgEl692+zTKO2pjw+GQWJEMKsxl9E
	SY8sVd0g84XJpdsbUQHNa+WCFSjqkutoL8i88UyfSdXh1dgbX1uJBJVR13FcLFVfD71MT3KalsP7H
	/ZZyEhJFvPAS8rfmG/RlDAe6cpr0ntpshuWv0MeEsjbxOy14OwF2hZyqvWfAhD9FXQQZ8bakzS/IK
	F87ZNeTHz+Szk0ldQOukJhf0Goxopdk6R449Q98whaUGjVqpzYpsJq9Bhw3U/e4KM8S4srbRycM25
	ZxjOh6ig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tNKeJ-0000000BesD-1D9x;
	Mon, 16 Dec 2024 23:37:15 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNKeI-0000000Berf-0c7l
	for kexec@bombadil.infradead.org;
	Mon, 16 Dec 2024 23:37:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description;
	bh=xrUqJHk+DC7MJiWSLIDNfBawd31aIE7V5wzrcp1W6yM=; b=Zx7gwPn0rmONbPxIOvq+ePXTKW
	Zk15pJZDZDIkZLHFUp+nojiZHr5XeijgkL8l3gO/TpUea3CrhEhTjETXv6Y4iJY/jLacu/A1U5SEU
	UEVnOqaYEe6+B+OU8nCinx2QzHl/Vy0g5vpoMhcqyuNdibs++Cyh8pRrpIsbJX8Y3GpTO2XiWAozH
	7539NDgNLojJl0KsYBe+6LAOwmS1NfJ3wguZtVUXGGlisG+9LJ1X+ndafT77hAKn5b3vsjqvv/Dv7
	POPmXVwbmLF0IRf5vJKX/AIlVT86HwqM2md1pmSvQinWdKVQxuujVZUJdM1MHsHWoITKTDtxmzCVu
	nxh12/jQ==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tNKeA-000000034na-2gcj;
	Mon, 16 Dec 2024 23:37:07 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tNKeA-0000000DeWQ-1HY4;
	Mon, 16 Dec 2024 23:37:06 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Eric Biederman <ebiederm@xmission.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Yuntao Wang <ytcoode@gmail.com>,
	David Kaplan <david.kaplan@amd.com>,
	Tao Liu <ltao@redhat.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Wei Yang <richard.weiyang@gmail.com>,
	Rong Xu <xur@google.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	Simon Horman <horms@kernel.org>,
	Dave Young <dyoung@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	bsz@amazon.de,
	nathan@kernel.org
Subject: [PATCH 7/9] kexec_core: Add and update comments regarding the KEXEC_JUMP flow
Date: Mon, 16 Dec 2024 23:24:14 +0000
Message-ID: <20241216233704.3208607-8-dwmw2@infradead.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241216233704.3208607-1-dwmw2@infradead.org>
References: <20241216233704.3208607-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
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

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

The KEXEC_JUMP flow is analogous to hibernation flows occurring before
and after creating an image and before and after jumping from the
restore kernel to the image one, which is why it uses the same device
callbacks as those hibernation flows.

Add comments explaining that to the code in question and update an
existing comment in it which appears a bit out of context.

No functional changes.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 kernel/kexec_core.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index c0caa14880c3..7cf8437e0f38 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1001,6 +1001,12 @@ int kernel_kexec(void)
 
 #ifdef CONFIG_KEXEC_JUMP
 	if (kexec_image->preserve_context) {
+		/*
+		 * This flow is analogous to hibernation flows that occur before
+		 * creating an image and before jumping from the restore kernel
+		 * to the image one, so it uses the same device device callbacks
+		 * as those two flows.
+		 */
 		pm_prepare_console();
 		error = freeze_processes();
 		if (error) {
@@ -1011,12 +1017,10 @@ int kernel_kexec(void)
 		error = dpm_suspend_start(PMSG_FREEZE);
 		if (error)
 			goto Resume_console;
-		/* At this point, dpm_suspend_start() has been called,
-		 * but *not* dpm_suspend_end(). We *must* call
-		 * dpm_suspend_end() now.  Otherwise, drivers for
-		 * some devices (e.g. interrupt controllers) become
-		 * desynchronized with the actual state of the
-		 * hardware at resume time, and evil weirdness ensues.
+		/*
+		 * dpm_suspend_end() must be called after dpm_suspend_start()
+		 * to complete the transition, like in the hibernation flows
+		 * mentioned above.
 		 */
 		error = dpm_suspend_end(PMSG_FREEZE);
 		if (error)
@@ -1052,6 +1056,13 @@ int kernel_kexec(void)
 
 #ifdef CONFIG_KEXEC_JUMP
 	if (kexec_image->preserve_context) {
+		/*
+		 * This flow is analogous to hibernation flows that occur after
+		 * creating an image and after the image hernel has got control
+		 * back, and in case the devices have been reset or otherwise
+		 * manipulated in the meantime, it uses the device callbacks
+		 * used by the latter.
+		 */
 		syscore_resume();
  Enable_irqs:
 		local_irq_enable();
-- 
2.47.0


