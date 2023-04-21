Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06E46C77B75
	for <kexec@archiver.kernel.org>; Fri, 21 Apr 2023 07:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Message-Id:MIME-Version:Subject:
	Date:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=lzp5Tb1g+IHYXMnOZCXCBknZKvljVhuGRwU058hrdns=; b=FibuqQZzo5B+dh
	F80xTO4qhVYWN4tiFxueHx7MnMfoVPaVHlpeo4OLz80cFxYCGoyAm6qzcGf0kZjo4b7dJUpD6YVbF
	kMs9lhEvxrBo/Bf/Ov7XgZWjQSnCxjeHxzWfYDF/dZYr37RAYKzTQOqJuedppk808uP/iJDeSEmo8
	szF8WceaQYYeyK8qQtG92wIDM3EdDqZBNw7t+A/yfdmdwzEZMW7zyRGTgi37jcuGAxUEIWel+bBBY
	qGrqy3wPzo4wjckJWhl3C8m6NEgbPXcZ/5pbHAXaIfpko+E7hWIjfnYV1BZXP8D6Tg8IXWXJljLba
	morYAoekNuPMPu9LpLzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ppkw1-009vfx-0p;
	Fri, 21 Apr 2023 07:11:57 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ppkvy-009vfL-1v;
	Fri, 21 Apr 2023 07:11:55 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 9EC2860C69;
	Fri, 21 Apr 2023 07:11:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA54AC433D2;
	Fri, 21 Apr 2023 07:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1682061113;
	bh=rMUILe+lzNtFjuK4Wo8tbKNwjXvMBXiBfW9We8f4vr8=;
	h=From:Date:Subject:To:Cc:From;
	b=UI5MuaE4/UikemG6JhQ1dvCw3HjcJDedvlypUJW+49LIfPBKusmfQe+xb+bqGx2bt
	 h4KFH8SPmALftGENd9XPx7uUe+Kmwu+vn6wYpejqwQL4uzJH3B5dsLqK251VJLDpf1
	 j6/IZx1mQ7aruuKhv2/dPQ9YNj9BUNuouD53rJwyF4+BvxUeZpL/t4DFGRDwcNFXHn
	 UdjGJwGlCfgw614HAjzy1sciY4FSKtVhrK0A2tX5bMTeHqt/KO/JvUF55jvb6bmmFd
	 sTpk4q1qNbMHN2XfktvsXsHicgpsjnNQAyBLyDhY0wL/yLGqTy0BY89f+UDIBTPFFl
	 GdI2UqwjTVcyQ==
From: Simon Horman <horms@kernel.org>
Date: Fri, 21 Apr 2023 09:11:49 +0200
Subject: [PATCH] m68k: kexec: include reboot.h
MIME-Version: 1.0
Message-Id: <20230421-m68k-kexec-include-reboot-v1-1-7552963a0f25@kernel.org>
X-B4-Tracking: v=1; b=H4sIADQ3QmQC/x2NywqDMBBFf0Vm3QGTaCj9ldJFHmMdTCcl0SKI/
 97g8lw49xxQqTBVeHQHFPpx5SwN1K2DMDt5E3JsDLrXph+0wo+9L7jQTgFZQtoiYSGf84rWqOg
 mM47aOmi+d5XQFydhbg+ypdTGb6GJ9yv4fJ3nH82Mj92AAAAA
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Baoquan He <bhe@redhat.com>, 
 "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>, 
 linux-arm-kernel@lists.infradead.org, linux-m68k@lists.linux-m68k.org, 
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.12.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230421_001154_690946_89AB1CFA 
X-CRM114-Status: UNSURE (   9.05  )
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

 arch/m68k/kernel/machine_kexec.c:26:6: warning: no previous prototype for 'machine_shutdown' [-Wmissing-prototypes]
    26 | void machine_shutdown(void)
       |      ^~~~~~~~~~~~~~~~
 arch/m68k/kernel/machine_kexec.c:30:6: warning: no previous prototype for 'machine_crash_shutdown' [-Wmissing-prototypes]
    30 | void machine_crash_shutdown(struct pt_regs *regs)
       |      ^~~~~~~~~~~~~~~~~~~~~~

No functional changes intended.
Compile tested only.

Signed-off-by: Simon Horman <horms@kernel.org>
---
 arch/m68k/kernel/machine_kexec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/m68k/kernel/machine_kexec.c b/arch/m68k/kernel/machine_kexec.c
index 206f84983120..739875540e89 100644
--- a/arch/m68k/kernel/machine_kexec.c
+++ b/arch/m68k/kernel/machine_kexec.c
@@ -6,6 +6,7 @@
 #include <linux/kexec.h>
 #include <linux/mm.h>
 #include <linux/delay.h>
+#include <linux/reboot.h>
 
 #include <asm/cacheflush.h>
 #include <asm/page.h>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
