Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D730C83F22
	for <kexec@archiver.kernel.org>; Thu, 10 Jul 2025 14:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8IOiBhpE7k0MjzUA/INlxWVgVc3fXasZWv3rNx0TaJs=; b=e0QBqSVd+m4ZUbv37GPwiAQ75Q
	zASu9I9mQxKq8Jz/z1QdqCtqLPtmEtlvui+lAW4jeIF3zcqymXuoMMpJDIVleART8fAb3H+SpMCqn
	GxxQeG5s2gAClMKxMGxcB+cBBJQEQ+vFMrCFiBWGMBFwoYRsQ+5veEmCZeZX/Rt6q36iUC/NX8WBg
	5POVJHT8GwOdHYXzX3jUrXPZGG3RmwCPzOp9zd/d/aH35jF8AACcTtdnJjDfGPL0FrSqY5Jmxfvk2
	4Sh8Fa/v7SIh0ugOg/6jguYZM8+UDoVg0/mz+5m3mBwLAIaVgWBbGSDNa9LlZzzkob2riIsdQOX42
	ftsT2zzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZsZv-0000000CASI-1eiz;
	Thu, 10 Jul 2025 14:48:51 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZr4s-0000000Bt4z-42FD
	for kexec@lists.infradead.org;
	Thu, 10 Jul 2025 13:12:43 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 04E5D6146C;
	Thu, 10 Jul 2025 13:12:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C85D4C4CEED;
	Thu, 10 Jul 2025 13:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752153161;
	bh=a6txXrLzW35b1zGTDyVpZzhGd+F09XjuI6q5NT4EVMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YRc1SjZNgXXpjmpXsaw4eDEyvO/ho/becbOhM5LEAjK2Z7tINUTXv9DUrzR/6m3fz
	 iu13CBOdgvgemyk9mcBYKjiqLxp2fgBaGvduQZep3H0BCGdWIz2bJFuEG9hlAVvh4o
	 HPoqcqg5X8mXVsv3Vwz9KijDymRgtlQfi+MRWjw/G/72nZZ3Iul1u6M/jd8yhY7moZ
	 6t0Q+FnGF+UyIR+hKlaHmdhaUg54XNRErqDUrGkeJ5NSoAWCoslCE86VBsYYt8JNGz
	 BNiXlka9GW/XAbEA5IQnGfD/cMBGlj2yOmOx2tUfgXm4VxfVe7XvfFGLZr9HA/u270
	 TUMhkIqHYAbrA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: kexec@lists.infradead.org
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH v1 2/2] kexec_core: Drop redundant pm_restore_gfp_mask() call
Date: Thu, 10 Jul 2025 15:12:20 +0200
Message-ID: <1949230.tdWV9SEqCh@rjwysocki.net>
Organization: Linux Kernel Development
In-Reply-To: <5046396.31r3eYUQgx@rjwysocki.net>
References: <5046396.31r3eYUQgx@rjwysocki.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
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

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Drop the direct pm_restore_gfp_mask() call from the KEXEC_JUMP flow in
kernel_kexec() because it is redundant.  Namely, dpm_resume_end()
called beforehand in the same code path invokes that function and
it is sufficient to invoke it once.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 kernel/kexec_core.c |    1 -
 1 file changed, 1 deletion(-)

--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1136,7 +1136,6 @@
  Resume_devices:
 		dpm_resume_end(PMSG_RESTORE);
  Resume_console:
-		pm_restore_gfp_mask();
 		console_resume_all();
 		thaw_processes();
  Restore_console:




