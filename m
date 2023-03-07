Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF724C678D5
	for <kexec@archiver.kernel.org>; Tue,  7 Mar 2023 22:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=IDAjJJGXllM6NKUfJ/t2zJa7KB2nSJDKkSXP8DcVqnw=; b=H1WABELFS6Zuf2
	+YY0G0qz97w+jb6sx9GKHcPLe68S3IA1zYCAOWWASerRElgY9KLeE3SPUBUjWwhRCAMA0sEwnhlbi
	TZT9L1wm1YDKijl+7lJPn//HEVmNLkwxf6u43e1jTgKItotgd0TN7gx6b0dOMvrJ8t5djwvIRPEOO
	ETEl7IBY6GwuUd9vPTnza52c4oT7W303j3tzAekNGhHk+bc7rnSSU0hCJGrUccgijNmTLGDk+rvz9
	L7hNWxOrwAbaJqWd6ycZ6GoXfpInvBzOpSy1C4rYShQC+3yjjkRm68CZ34jF8t/9BChx+78B8P5sG
	/yu7qQvcaSixQVelTB6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZg36-002kPD-7N; Tue, 07 Mar 2023 22:44:48 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZg32-002kN0-K7
	for kexec@lists.infradead.org; Tue, 07 Mar 2023 22:44:46 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 301E8B81AB8;
	Tue,  7 Mar 2023 22:44:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C954C433D2;
	Tue,  7 Mar 2023 22:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1678229081;
	bh=ra2ig/GUIIdjFMBuwDWCO4KS9VvonAX7AhGw6h3HB6g=;
	h=From:To:Cc:Subject:Date:From;
	b=lHOHdGcXvzFRcEhvkX8UwLfx7BODSYMt8zRBGoAa4KEJX//F+7uixuv2E91/CJnDD
	 1/aEeeDIl30OvcYrP/4iu+MIl3jIeda2kKAediFQ8JZICj+vhh4js/aKFScOcn4jWx
	 jvUyfihhDt9QgbcLCcH+gfwJssfNYd9EYbBiEjHS1SVhU3mV/pgLMQC5pCdDLbHt1v
	 tH1bdcoAtpemrJJA4N2iFFqHKqR7igYMxsZVUJ+ik3rMQE/EktLRDdxsfv/VRG6QI/
	 HvBxebRNTFq5K0REXwhEMEO+rOhzTKfdPtpb7gqCgRpktMxVE39+nP2H8EKqwT1yeK
	 yuU3IJEEQLrOw==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Eric Biederman <ebiederm@xmission.com>,
	Dave Hansen <dave.hansen@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Baoquan He <bhe@redhat.com>,
	x86@kernel.org,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 0/2] kexec: Remove unnecessary arch hook
Date: Tue,  7 Mar 2023 16:44:14 -0600
Message-Id: <20230307224416.907040-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230307_144444_841033_F06FF881 
X-CRM114-Status: GOOD (  10.29  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

From: Bjorn Helgaas <bhelgaas@google.com>

There are no arch-specific things in arch_kexec_kernel_image_load(), so
remove it and just use the generic version.

v1 is at:
https://lore.kernel.org/all/20221215182339.129803-1-helgaas@kernel.org/

This v2 is trivially rebased to v6.3-rc1 and the commit log expanded
slightly.


Bjorn Helgaas (2):
  x86/kexec: Remove unnecessary arch_kexec_kernel_image_load()
  kexec: Remove unnecessary arch_kexec_kernel_image_load()

 arch/x86/include/asm/kexec.h       |  3 ---
 arch/x86/kernel/machine_kexec_64.c | 11 -----------
 include/linux/kexec.h              |  8 --------
 kernel/kexec_file.c                |  6 +++---
 4 files changed, 3 insertions(+), 25 deletions(-)

-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
