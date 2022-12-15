Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F712C25B04
	for <kexec@archiver.kernel.org>; Thu, 15 Dec 2022 18:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=J3ai/04fD8o5628MOJLx4YYZn884fjZ1AUub+1AeOns=; b=g2lPVBixnqew4X
	jzCXp8RBfl7Vi0bQ+SMqoYG/NZZiOAyQDCcniAVTInJ1dOT/mGQb2/+RtwGcaWI2GNsDNFl0pCuYw
	hu8UALsc5G0/6EUMoktBttmufb/WptLL3Gc55ly/nYTMXoksU4OXPJx6QsCpC6OkMqfdme3KOdhZ0
	nm8B2cdfpun51zBX85UJ+fk+ZVKoy0z5ZnYumb2uP1dTt/2nJYvYJ7V1wUTea+NNp60Ztz8QJ51E2
	r3bsmUONE2d+JbP8g/p4TtvG7hMrstrTDZsPOO2eNlj1JCnPgsu8Z4JPSqzVnMI/aUtqax4jY+Sz0
	48mWxiVl9bUoIYrX0/tw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p5sta-00AoSu-Ou; Thu, 15 Dec 2022 18:23:50 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p5stW-00AoSK-AQ
	for kexec@lists.infradead.org; Thu, 15 Dec 2022 18:23:47 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 5051961E94;
	Thu, 15 Dec 2022 18:23:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 727C5C433D2;
	Thu, 15 Dec 2022 18:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1671128624;
	bh=8PNaS5DZTOGpbTorR0Yw13t8v/jr0DO4D+UXelTK8hc=;
	h=From:To:Cc:Subject:Date:From;
	b=i4b68wh65v/O6+kXx38KJmc6T8psOrM32ER6BScfH2hJKDEe06wrjSPnstjpvsKrI
	 p4MgMiyt4NoIwa17EGFXdVFThNmuYFyubtkVMvg2HiXxJhWzEmZMqwXJU2P+nVtaiD
	 Wx3W/clFzJKnjsWgzhbqdbB6UROKSa2vEwrpS5RRy57VgU/DuYPfhzM0rNMFtc/Xcr
	 h/rGurGYsr57sGNU3URxf3smx8E0ZKfFxGnDRoMKSW5IIIlrHoNxM3RhGw3sr5QILn
	 k7Qs8xiLhY8ja0BUkTIV0NsH9oDui1KwRFGAG+yxFSotoGSC0JV8WQV8i4LeRLI+qJ
	 zHbS0BrEf45/Q==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Eric Biederman <ebiederm@xmission.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 0/2] kexec: Remove unnecessary arch hook
Date: Thu, 15 Dec 2022 12:23:37 -0600
Message-Id: <20221215182339.129803-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221215_102346_436291_E3F708CF 
X-CRM114-Status: UNSURE (   9.23  )
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

From: Bjorn Helgaas <bhelgaas@google.com>

There are no arch-specific things in arch_kexec_kernel_image_load(), so
remove it and just use the generic version.

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
