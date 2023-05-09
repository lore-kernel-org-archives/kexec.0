Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9046BC77B75
	for <kexec@archiver.kernel.org>; Tue,  9 May 2023 07:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Message-Id:MIME-Version:Subject:
	Date:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=ouut3PS5O/yHjyDFhaiZQoJ9ib6CRe5dG3Mc/Cic+Ak=; b=cHQ/4d7uyS6EoV
	DV+GjwG8DdOTJy9+DQ1IzmObxbcGiWDodzb2CbAiBPHi7KGXeHtNc4LlZTl2/nm3Wsxz+Js9RB94w
	bK8CapTLl12aw1qImHLKnJqX0lUw/1Xib8ZQwqF14rA6F5HO82+INb+eJmd5qW2lc3dH3GcVpjovP
	9J10zd77wrNN1qCXBR2YsvNoznM+56OHZvOiO7baboLjkbrCCMhvQsR8ImqPEyNiZENBGqpsb+MRc
	LirSSAKlilbBLdSjcpklhGtYJ3nAvnPrcoFEO8GTRti3dFN+/OOMsUlQD+7QUhIh3M7WxNAM2h5dY
	KVaBYqDJCp/FTJ3Fxj/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pwHMF-002SVg-1h;
	Tue, 09 May 2023 07:01:59 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pwHMC-002SVC-2G
	for kexec@lists.infradead.org;
	Tue, 09 May 2023 07:01:57 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id CE9E662E9B;
	Tue,  9 May 2023 07:01:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C25C0C433D2;
	Tue,  9 May 2023 07:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1683615715;
	bh=9k++FdR+6rYCFlA3FaCYqkc/1LNnURTanvKd2FGb3I4=;
	h=From:Date:Subject:To:Cc:From;
	b=qAE2IQ6/3Kr6cA1tjAfJjzkqJww1WVtG16AXt40kVwldqlU6xjW7UEzegHSKzexLN
	 YuTRgeBqIvehm4UDCH2FHrSpM+ewDgE7Huz89ZKLbg9vviU8HlBxlmTjvuUBGNEJ6M
	 SthkHvH+p7rjjaVQaabaN2rK7jP1DjhJ9XVYhBFRw+baBh2j+cJ8lII2oRPyFovaNA
	 FnXh07sI1aKzDXm5TOmmDRY3z5vZhQfhsbf1K3zdfOMkNdpdoTLaM6VK1nHijKMdyZ
	 VvOv1QMwDj06fgSw3vfKMTIvFzm0nf2ENaAasJcqQceIJehmKfwWGSHEbR/vIHf91w
	 m15CAZe1Bm/tA==
From: Simon Horman <horms@kernel.org>
Date: Tue, 09 May 2023 09:01:50 +0200
Subject: [PATCH] parisc: kexec: include reboot.h
MIME-Version: 1.0
Message-Id: <20230508-parisc-kexec-include-reboot-v1-1-78a155a8a0a4@kernel.org>
X-B4-Tracking: v=1; b=H4sIAN3vWWQC/x2NwQ6CMBAFf4Xs2U0qChh/xXjYlqdsbFqyBUNC+
 HcbjzOHmZ0KTFHo3uxk+GrRnCqcTw2FSdIbrGNlal17cZ278SymJfAHGwJrCnEdwQaf88KdDG7
 ory168VQLXgrYm6Qw1UZaY6xyNrx0+y8fz+P4AcfbVS2CAAAA
To: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>
Cc: Baoquan He <bhe@redhat.com>, 
 "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>, 
 kexec@lists.infradead.org, linux-parisc@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.12.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230509_000156_803147_26802578 
X-CRM114-Status: UNSURE (   9.29  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Include reboot.h in machine_kexec.c for declaration of
machine_crash_shutdown and machine_shutdown.

gcc-12 with W=1 reports:

 arch/parisc/kernel/kexec.c:57:6: warning: no previous prototype for 'machine_crash_shutdown' [-Wmissing-prototypes]
    57 | void machine_crash_shutdown(struct pt_regs *regs)
       |      ^~~~~~~~~~~~~~~~~~~~~~
 arch/parisc/kernel/kexec.c:61:6: warning: no previous prototype for 'machine_shutdown' [-Wmissing-prototypes]
    61 | void machine_shutdown(void)
       |      ^~~~~~~~~~~~~~~~

No functional changes intended.
Compile tested only.

Signed-off-by: Simon Horman <horms@kernel.org>
---
 arch/parisc/kernel/kexec.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/parisc/kernel/kexec.c b/arch/parisc/kernel/kexec.c
index 5eb7f30edc1f..db57345a9daf 100644
--- a/arch/parisc/kernel/kexec.c
+++ b/arch/parisc/kernel/kexec.c
@@ -4,6 +4,8 @@
 #include <linux/console.h>
 #include <linux/kexec.h>
 #include <linux/delay.h>
+#include <linux/reboot.h>
+
 #include <asm/cacheflush.h>
 #include <asm/sections.h>
 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
