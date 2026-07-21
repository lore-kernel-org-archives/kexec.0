Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C17F1C44529
	for <kexec@archiver.kernel.org>; Tue, 21 Jul 2026 15:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:To:From:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1TnWlVinJDeOhala/vbIeVYCGUm59YDKqzBVCOS9jWE=; b=HLsKgvRSsOy9ef
	wkzTDnQchqHLwPGhFklkDhRdi9GgeRL8U+27TKXCEBtsg5rD9/VoyRKK7rR0xAqHSEJVzM9L9ukUi
	QD5jPbzc5ePyE96GwhY77MuZOe1hfDNVYHpCtoVFEEThh/iOusT97XaQuHaMO8mxor3hybrtVRlZa
	AzLrySqJdgziihXsPh1D81tA5XfKwhK0DHQHLHMi5uJelZ4lQEPsyQbuHBpTTc99iQpC/Zgv03ytF
	oOgazt3hkv2iu8GSb3tL07ziHLUaNCo+NfV9JeoMUuw4b8B1lWO2mdEBFwtfdZlI4m5yhKNhsvzLY
	GYzXFV6CXuY2pF9iVMKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmCAh-00000009ll7-0Zmk;
	Tue, 21 Jul 2026 15:14:15 +0000
Received: from devianza.investici.org ([198.167.222.108])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmCAe-00000009lig-2uFB
	for kexec@lists.infradead.org;
	Tue, 21 Jul 2026 15:14:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1784646851;
	bh=1TnWlVinJDeOhala/vbIeVYCGUm59YDKqzBVCOS9jWE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pwq7Ef46XWcW85AVc4Id1OZ84DWSL6smZgO4II9+fpMcNuh5e9mfet3Rxc1FYyyo9
	 nQ5LiP3/dlxpRm8vw7jFcNgO+Hm6PpqRbEg+p5IlSMGdCiSKGrMturwHkp4a/lp2RM
	 3HYstfKUxL1oomd0i0sVrmXpzBfnGcR5NMsRvMcc=
Received: from mx2.investici.org (unknown [127.0.0.1])
	by devianza.investici.org (Postfix) with ESMTP id 4h4LWl18Tbz6vP7;
	Tue, 21 Jul 2026 15:14:11 +0000 (UTC)
Received: by mx2.investici.org (Postfix) id 4h4LWk2rKwz4vyJ;
	Tue, 21 Jul 2026 15:14:10 +0000 (UTC)
From: Bradley Morgan <include@grrlz.net>
To: akpm@linux-foundation.org
Subject: [PATCH v2 3/3] PM: hibernate: log the task that initiated the power down
Date: Tue, 21 Jul 2026 16:13:58 +0100
Message-ID: <20260721151358.4185467-4-include@grrlz.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260721151358.4185467-1-include@grrlz.net>
References: <20260721151358.4185467-1-include@grrlz.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260721_081412_900118_E1C41EAE 
X-CRM114-Status: GOOD (  13.61  )
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

Give the hibernation power down the same treatment as the reboot
syscall commands. hibernate() runs in the context of the task that
asked for it, whether through the reboot syscall or a write to
/sys/power/disk, so when power_down() runs current is still the
initiating task.

Log it once the image has been written and the machine is committed
to going down:

  reboot: initiated by systemd-sleep[812]
  reboot: Power down

The line comes from kernel/reboot.c so it keeps the "reboot:" prefix
and sits right next to the final "Restarting system", "Power down"
or "System halted" line, same as a plain reboot.

The one exception is platform mode rolling back on a pending wakeup
event after the line has been printed. The existing "Wakeup event
detected during hibernation, rolling back." line follows immediately
in that case, so the log stays real about what happened.

Signed-off-by: Bradley Morgan <include@grrlz.net>
---
 kernel/power/hibernate.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index d2479c69d71a..bec91bf6a63c 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -687,6 +687,8 @@ static void power_down(void)
 	}
 #endif
 
+	reboot_log_initiator();
+
 	switch (hibernation_mode) {
 	case HIBERNATION_REBOOT:
 		kernel_restart(NULL);
-- 
2.50.1


