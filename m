Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D21ECC54F54
	for <kexec@archiver.kernel.org>; Fri, 31 Jul 2026 16:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WDJuTD8Vcay2+Rdlju8jd0+4JfwRzRzUz3/gOwvyzEk=; b=URpNc1l2chVjCjzExguEzT3BwE
	nd4NNaUKF3nCgP4FVckNAVn85Qay+Rgahl5nduVi7BZWgv96TpsBnsfh6AdT0PxqUyrRr3kB0BF2G
	R39Sct4OOpJGWka4bVnfADl/U3mvQVeKY7DTXazjLd88VJkm/oBC2znO/E87Dhuend/7Hk3GH7LNr
	IrvNTFtUiNCPyy8/DqR0cjXpt+FuK8SSzILwcrXP3BklMj7ZMw2cLYRrLbNm/9sj3BcalBv2+sNC8
	nUaUp9bugwz6NS9mDbPEaaRy6bF0lDIfcCJFrzo/GryQ1YqSVytZzlqZ9yQs4Ka6OnQM9uAnTNgqO
	IiAm2Heg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpq5S-0000000D7OJ-2wCQ;
	Fri, 31 Jul 2026 16:27:54 +0000
Received: from fout-b1-smtp.messagingengine.com ([202.12.124.144])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpq5Q-0000000D7Mn-1iBv
	for kexec@lists.infradead.org;
	Fri, 31 Jul 2026 16:27:53 +0000
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 41BD21D000DD;
	Fri, 31 Jul 2026 12:27:51 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 31 Jul 2026 12:27:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaseg.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1785515271;
	 x=1785601671; bh=WDJuTD8Vcay2+Rdlju8jd0+4JfwRzRzUz3/gOwvyzEk=; b=
	Hclb6FV2E4h7miUmIFatF7vgILbkq5iEkCMeqX58TuS1emswDoozRst6lCLKrT1r
	IwITO94liQrRfXoq/UR1Cp45KPNsviPwwaTbL5dl1J8NxCPQ13RczR1dczbxjxZP
	9yc1a8zrGTfnHzhDuEwa7y5ErpPHcdhwPrDPhXLxII/PT8FJzNMWEp4NwHhtdTXf
	h4j/3BmUkYfS/ar6hgh3ffuMnR6LX31WkKnzR/LgTwG20Zs/bgUe0u2jMR8u2zXW
	9R/T76b5+qNd+cj2Mbi7EhQyyRkH8+/nDEC5w5Lp3crhvIugjKbgkLBw0MzF4u84
	yWx3dHwY61PVrsiE8Ham3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1785515271; x=
	1785601671; bh=WDJuTD8Vcay2+Rdlju8jd0+4JfwRzRzUz3/gOwvyzEk=; b=W
	v7tZH1Q/YHqS3HUVGTuTIPse3MKFqCZelV6q9mYHY4epWM2zC+aAKpHYzUeAySVC
	rDOKrgHWMN+O21uy3IjLf3ebGB2cUpbFc3LQ7G6aurdaEeA5N6MEJv2wJ/zSiWbP
	AzPKJ8WKMUGeylC2516STchvP0vG+fB7DTU5uv3wEV052H0Mrkg6lwAozynmpeTi
	YNJKnLkhgerLAIWp2Np26HbQP2WFTZGHiQTXKltDpnYyfV5XOCXl40+zj4O6UJTE
	TXsFg/Igq8SRvisRCMykDMbxchMDiktjSKPctY0bjnbFHdBJG4S74Lyu6QKijenN
	vK/oIJEMFzMqNN3Xz1HSw==
X-ME-Sender: <xms:Bs1saljrSp7mk7qc2Vw1p5p4ABiZpUtE60indWxE6MA5Q3FhEyBU3g>
    <xme:Bs1saqf6GAyquJwmY98GouY6oCpUCPdALmTT7XE8-BnueW-XHa7BuRsZrY-sZhLL0
    71t9bxQKpzUn9I3ByU6kqK0wgaPTPoLDFrC6U7kzqL28z-XRlA>
X-ME-Received: <xmr:Bs1saly_z0Ti2R2ioYZbzjjBljD6tu9JbMmznqN9gcb7hoNzzCACiHHQ7pbGe-iM2Mabw2lZcTJhboptqA>
X-ME-Proxy-Cause: dmFkZTELfHAaFlN+kIG6IssmIq8q0/JRtHYiEDamnKwtHAGTm/rIkphiM7dmck7n/tEVID
    Jll9XZRXegS5DA66U1m8pj9kUlkWW6jbmxkpZ2Vy+f9sbLWY4LPn/k9o06nVK28CzSnHlD
    lWYRxoJf+HWhSZ1zy9/rODG5OphaTJnkZfxiinHtBeukYGRaEV6rsOpAthbf9Rnwd5neaW
    b5ga7UTCgjqgAq9wYXuIHu4RL0lK64k1SgzKLwhWoz9uN8eIJVTlSs/QiafsKJeCqGBPP+
    mXVeoA/rZsAKFBE67k4yvTZ9NpiBwhCbzC9zQWp6wR2HnNM114K5oGLjvHnZO8zy7kGoVA
    hWs1HmKnirvo6badLfxFLC1ngv0vJGoRz2yU1pHhumbJcOkKOI1TtNPdhNaBkQabzrHwSs
    Y+7ylrnEBz1FMgf9G6IsR8hTGiv7XS1m50dEM7iVhvYlPUG0379fhge2f9V/z3oUvLoxr9
    ROaKaguFReJhiqZNhkD2XnlISmZ06TLF+XHEmpScoNRo1mg4BzI04MU+Oxq/K72xAlD1/c
    lRg7SLxd+kAXPrpQII8V7zbztgUBuWpkzKb8l+6UjlDsNcWEj2Tr5qCKIMZOXP0v6qIQIy
    +V+eXG639NjJ3RxuUWndaCx4R8t6V8NOngjS48abG8QAD/cuG5n/twKPLx9w
X-ME-Proxy: <xmx:Bs1sah0J_Zqx9Wm495aAHKKyq_zeBhRa8kYfGRkR0LXdWure1xaNMA>
    <xmx:Bs1sajwoT1TWg_kbaEU9yClxnpO-kipWVN0DCX0fgJ9aab9iuIojBA>
    <xmx:Bs1sauUKn1OLfclDrDHmd_7hCcA_KhPZF7HTuDRW2QMgnsxL2ZKuiA>
    <xmx:Bs1san85u3s4a8sam9gCd9BRSEWPxpnzprbbAhoOLGglgWyESU-nig>
    <xmx:B81salKYXEKXujICpl4UbPwDur3BiZlPUHWa6w3bSr8Ec7HpXLwZQlpO>
Feedback-ID: i60a14417:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Jul 2026 12:27:49 -0400 (EDT)
From: =?UTF-8?q?Jan=20Sebastian=20G=C3=B6tte?= <linux@jaseg.de>
To: =?UTF-8?q?Jan=20Sebastian=20G=C3=B6tte?= <linux@jaseg.de>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	keyrings@vger.kernel.org,
	linux-mm@kvack.org,
	linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org
Subject: [PATCH 2/4] kexec: add CRASH_ZEROIZE to wipe secrets before kdump
Date: Fri, 31 Jul 2026 18:27:37 +0200
Message-ID: <20260731162739.158320-3-linux@jaseg.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260731162739.158320-1-linux@jaseg.de>
References: <20260731162739.158320-1-linux@jaseg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260731_092752_667792_C4144E68 
X-CRM114-Status: GOOD (  14.53  )
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

When kdump is used to capture system memory after a panic(), any secret
keys currently in RAM end up in the dump. Add an opt-in atomic notifier
chain, crash_zeroize_notifier_list, invoked late into __crash_kexec().
Subsystems holding secrets can register a callback to scrub them.

Callbacks are run after machine_crash_shutdown() has already stopped the
other CPUs and disabled preemption. Callbacks must not wait on locks,
which will never be released.

This is a best-effort, defence-in-depth measure, not a guarantee.
Secrets in flight on the stack, in registers, in DMA buffers, or in
other places in memory are out of scope.

Signed-off-by: Jan Sebastian Götte <linux@jaseg.de>
---
 include/linux/crash_core.h |  5 +++++
 kernel/Kconfig.kexec       |  8 ++++++++
 kernel/crash_core.c        | 18 ++++++++++++++++++
 3 files changed, 31 insertions(+)

diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index bc087124cd78..5c7207c0bba1 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -5,6 +5,7 @@
 #include <linux/linkage.h>
 #include <linux/elfcore.h>
 #include <linux/elf.h>
+#include <linux/notifier.h>
 
 struct kimage;
 
@@ -34,6 +35,10 @@ static inline void arch_kexec_protect_crashkres(void) { }
 static inline void arch_kexec_unprotect_crashkres(void) { }
 #endif
 
+#ifdef CONFIG_CRASH_ZEROIZE
+extern struct atomic_notifier_head crash_zeroize_notifier_list;
+#endif
+
 #ifndef arch_crash_handle_hotplug_event
 static inline void arch_crash_handle_hotplug_event(struct kimage *image, void *arg) { }
 #endif
diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
index 15632358bcf7..92ab0a69c8ec 100644
--- a/kernel/Kconfig.kexec
+++ b/kernel/Kconfig.kexec
@@ -179,4 +179,12 @@ config CRASH_MAX_MEMORY_RANGES
 	  the computation behind the value provided through the
 	  /sys/kernel/crash_elfcorehdr_size attribute.
 
+config CRASH_ZEROIZE
+	bool "Zeroize secrets on panic"
+	depends on CRASH_DUMP
+	help
+	  Wipe secrets (e.g. kernel keyring and memfd_secret pages) on crash or panic.
+
+	  If unsure, say N.
+
 endmenu
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 2b36aa9fade0..d3a7763e2759 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -23,6 +23,7 @@
 #include <linux/objtool.h>
 #include <linux/delay.h>
 #include <linux/panic.h>
+#include <linux/timekeeping.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -33,6 +34,22 @@
 /* Per cpu memory for storing cpu states in case of system crash. */
 note_buf_t __percpu *crash_notes;
 
+#ifdef CONFIG_CRASH_ZEROIZE
+ATOMIC_NOTIFIER_HEAD(crash_zeroize_notifier_list);
+EXPORT_SYMBOL_GPL(crash_zeroize_notifier_list);
+
+static void crash_zeroize(void)
+{
+	ktime_t zeroize_start = ktime_get();
+
+	pr_info("Wiping sensitive secrets...\n");
+	atomic_notifier_call_chain(&crash_zeroize_notifier_list, 0, NULL);
+	pr_info("Done in %lld us\n", ktime_us_delta(ktime_get(), zeroize_start));
+}
+#else
+static inline void crash_zeroize(void) { }
+#endif /* CONFIG_CRASH_ZEROIZE */
+
 /* time to wait for possible DMA to finish before starting the kdump kernel
  * when a CMA reservation is used
  */
@@ -142,6 +159,7 @@ void __noclone __crash_kexec(struct pt_regs *regs)
 			crash_save_vmcoreinfo();
 			machine_crash_shutdown(&fixed_regs);
 			crash_cma_clear_pending_dma();
+			crash_zeroize();
 			machine_kexec(kexec_crash_image);
 		}
 		kexec_unlock();
-- 
2.53.0


