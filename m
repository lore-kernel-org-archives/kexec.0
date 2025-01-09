Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 741CAE77199
	for <kexec@archiver.kernel.org>; Thu,  9 Jan 2025 14:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bFcppKCEUBjugJ7xwZiGVN+OuHVqmS8GOG0BIifw77s=; b=lWqTPZHlByIzFRUQDCXiNXp0Yj
	bEIHIvTtS3iiyxgMh+hfC5nS7N+xb6XtHJjzyO3+9m9r37O5Vk1x/crt5oUPvM3oU93rSjwbBrkfk
	hu5uddAbU8Vn5PpeqQ9959Xi7FZVkFd8kVw1B844UgdD8i9wIF4QH7sP3MgvWqYmYqgv5DuMb6tY/
	3JQfdaRxTdH8QwSg68R10P7+hgsurEGYi0ZyVLFtVUM0XMLSHhpeu+6KFahHfciZZzLoPPseM9yWL
	v8MOu2fsCcgXi35IT6Zpcx2BwlS2SZGzs18HGnA2E2qrC3Xqo1JeYdxmi/T3A5jUtYDDd2WfT9HLy
	Ajj9cm8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVtDv-0000000CB3C-0eAd;
	Thu, 09 Jan 2025 14:09:23 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVtCh-0000000CAfU-157s
	for kexec@bombadil.infradead.org;
	Thu, 09 Jan 2025 14:08:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description;
	bh=bFcppKCEUBjugJ7xwZiGVN+OuHVqmS8GOG0BIifw77s=; b=qh68UCXENO/RYJFF8kUFvYLW+Y
	01DQVBz9CP2uynDSDCh7y+78zF7+fMfrmnOdrr9gMkpR2zAsy4p/Zfn/kaTkgM5WJmLL9yv0R2op7
	T72cPT1au2Hz0HiQqTDp2ik0OQrpbYzTEoipTWQgvMP0n4oeQa3PwY7wC+y43mgPv37taurGILhj3
	ZRNib6VCwnkDIEmkfd4MHTFHU9H4UNv6BOU3IfGAQAoI5c9blASIIvLfimYyCafBZOhHcLv/bYNfJ
	Gb2xdvlmK9CWpkOBTFSS49wPAvHdhnozIkve9D20xYbtOPC3qL7WqG/6j5Hq4gPBvcKdmRLffVgI6
	a50uzDiA==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tVtCa-00000009Zhg-3Cr9;
	Thu, 09 Jan 2025 14:08:01 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tVtCY-0000000Bx6P-3fUv;
	Thu, 09 Jan 2025 14:07:58 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
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
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
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
Subject: [PATCH v2 7/9] kexec_core: Add and update comments regarding the KEXEC_JUMP flow
Date: Thu,  9 Jan 2025 14:04:19 +0000
Message-ID: <20250109140757.2841269-8-dwmw2@infradead.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250109140757.2841269-1-dwmw2@infradead.org>
References: <20250109140757.2841269-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html
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
index c0caa14880c3..464ab059c58d 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1001,6 +1001,12 @@ int kernel_kexec(void)
 
 #ifdef CONFIG_KEXEC_JUMP
 	if (kexec_image->preserve_context) {
+		/*
+		 * This flow is analogous to hibernation flows that occur
+		 * before creating an image and before jumping from the
+		 * restore kernel to the image one, so it uses the same
+		 * device callbacks as those two flows.
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


