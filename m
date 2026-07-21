Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 473BCC44533
	for <kexec@archiver.kernel.org>; Tue, 21 Jul 2026 15:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=AqVZhRNLNOhvukqy4uccnfnDMk+VUTfv9FzIh5myaVo=; b=xA66w2/0GaFgy5
	16cBAyySO7dRXPm0Q58Ku6npSizYWL4UzIX/ZiZbTUOSVy6uHM6LfdcYwx6XWxncqp0fhUN7CA3Td
	wGT1odHHIGBCbb7oDYkDupLKJ/0xuoZxapDnLv8hHLH+eWsXIqoNrMl2FVKAXInfDS/ymQ+LSV+yw
	DFH12HUwbMDABhNLcjSBpckOVaERY8p8Bgc6d7pdz3zLusN191f+U+gbLIWypVIpZKD2nJJ/U4DCq
	0KzjaweiLRXz5U5Lf93HXkHRx4VUW54ZXWHnuBOe9WqQwLCXNwPknSmln953UCjFL4DT5FWEEtNDh
	LVuaaNVXLtRph9xarfjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmCAk-00000009lmx-1BAF;
	Tue, 21 Jul 2026 15:14:18 +0000
Received: from devianza.investici.org ([198.167.222.108])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmCAd-00000009lha-44EG
	for kexec@lists.infradead.org;
	Tue, 21 Jul 2026 15:14:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1784646848;
	bh=AqVZhRNLNOhvukqy4uccnfnDMk+VUTfv9FzIh5myaVo=;
	h=From:To:Cc:Subject:Date:From;
	b=bVf8mKCgOdCpS0U5u6MNxrXNcb5joU93Df3XYVZ8oP89W3oWPBLmAzgJ5H934aSJd
	 zsQE/SxYK87w/92M6+swL4wq4dvLY6oFABGnh0VNejn3gxXAfC9PMuLe134Z8Euo6q
	 AB6FxO11v5ymmwGg+2SNPTAoKdvvq64hMu9di6bw=
Received: from mx2.investici.org (unknown [127.0.0.1])
	by devianza.investici.org (Postfix) with ESMTP id 4h4LWh4Kl4z6vMZ;
	Tue, 21 Jul 2026 15:14:08 +0000 (UTC)
Received: by mx2.investici.org (Postfix) id 4h4LWg5G3Wz4vyJ;
	Tue, 21 Jul 2026 15:14:07 +0000 (UTC)
From: Bradley Morgan <include@grrlz.net>
To: akpm@linux-foundation.org
Subject: [PATCH v2 0/3] reboot: log the task that initiated
Date: Tue, 21 Jul 2026 16:13:55 +0100
Message-ID: <20260721151358.4185467-1-include@grrlz.net>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260721_081412_160620_906A76C0 
X-CRM114-Status: UNSURE (   9.46  )
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
Cc: pavel@kernel.org, tony.luck@intel.com, baoquan.he@linux.dev, rafael@kernel.org, kees@kernel.org, linux-pm@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, rppt@kernel.org, Bradley Morgan <include@grrlz.net>, pasha.tatashin@soleen.com, pratyush@kernel.org, lenb@kernel.org
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

When a machine reboots, powers off, kexecs or hibernates, the kernel
log records what happened but not who asked for it. This series logs
the comm and pid of the initiating task once the transition is
committed:

  reboot: initiated by systemd-shutdow[1]
  reboot: Restarting system

Patch 1 covers the restart, halt and power off commands of the
reboot syscall. Patches 2 and 3 give kexec and the hibernation power
down the same treatment at their own points of no return, as
suggested in the v1 review [1]. The kexec and PM maintainers are on
cc for their input on those two.

v1 -> v2:
- Reworded the justification in patch 1: dropped the fleet operator
  claim and spelled out the concrete gap in userspace logging
- New patch 2: log the initiator for kexec reboots
- New patch 3: log the initiator for the hibernation power down
- Added the kexec and PM maintainers and lists to cc

[1] https://lore.kernel.org/all/20260719160938.3692-1-include@grrlz.net/

Bradley Morgan (3):
  reboot: log the task that initiated the reboot
  kexec: log the task that initiated the kexec reboot
  PM: hibernate: log the task that initiated the power down

 include/linux/reboot.h   |  1 +
 kernel/kexec_core.c      |  1 +
 kernel/power/hibernate.c |  2 ++
 kernel/reboot.c          | 16 ++++++++++++++++
 4 files changed, 20 insertions(+)

-- 
2.50.1

