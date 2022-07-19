Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25AE2C43334
	for <kexec@archiver.kernel.org>; Wed, 20 Jul 2022 06:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=d0J86Cd0IXWy3JwLLH5Mch85nafmzP3Ede/n5cqhm0M=; b=29DlM7Yrt7GVED
	1aigdi8ml1pZQ6SYPZAsoUSBf1+gThHXg6PwbK/2J3lzoUZLUkYUVNv5dsGHQ2mmyh2ChXLk22A+y
	+UHf1xznFDEYINTemSehYNkbrJiP9HHHmAnsGisvWjeEbw4oXPcLK3bHBuvPKqc1VtIL5RwqdM2oP
	4wwF2SousvFF8IiqdLklqg0Ti0teDmkI+Cz/OLk0QBqHXjGDytkTIqFcnRIyOX+9z1Nq48qnI7Iqp
	ULgUtLvJIkszK8YjhvsYrFlqC+C6rol44wqPtKtz7ZFXoAL+7SLk3xiNCeSGpVXAK8/UTPNILM3y2
	+8I39Ias1pOKXa/CwTag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oE2nM-000sH0-Do; Wed, 20 Jul 2022 06:02:52 +0000
Received: from fanzine.igalia.com ([178.60.130.6] helo=fanzine2.igalia.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDtJo-00CAJb-CF
	for kexec@lists.infradead.org; Tue, 19 Jul 2022 19:55:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=hvFngS+SbTqGKT0e1yD1Flbk7O+3mk0+bQWnmDbivHg=; b=M7NtTBbllawpOvTPCtUXyQYrO3
	ALhnZaAkIF7GELFRa+HHmcpunYKDBRXEarjjsjqgbaYk5qxIvZxn4RJ7595HAkdjHbv359ZL37BFb
	NhwIsMNhkqm59nWgarDJPIl5SoZA3vvxo1F3NQE6HTjudo4mf1NcQCpWFFopt5+kOCctQs1gGkSzo
	vhH9WYJF1N/oQeLYAOL/w1rEbKcuPSgkuZgtTqMrTNVaBQjMMKrvARQ1M2RvZLOIC6rIO5dDF7KiS
	C3EL0HOtOX6zk5OWjhAfny3yrw7xSrb4hmzoOKuurM/2LLYaD037g0y0hXZ3Fok5yhYKfJ2MZdsIn
	sbn4nutw==;
Received: from 200-100-212-117.dial-up.telesp.net.br ([200.100.212.117] helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1oDtJi-006fNi-SW; Tue, 19 Jul 2022 21:55:39 +0200
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To: akpm@linux-foundation.org,
	bhe@redhat.com,
	pmladek@suse.com,
	kexec@lists.infradead.org
Subject: [PATCH v2 04/13] soc: bcm: brcmstb: Document panic notifier action and remove useless header
Date: Tue, 19 Jul 2022 16:53:17 -0300
Message-Id: <20220719195325.402745-5-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220719195325.402745-1-gpiccoli@igalia.com>
References: <20220719195325.402745-1-gpiccoli@igalia.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220719_125544_436834_BA39003D 
X-CRM114-Status: GOOD (  14.05  )
X-Mailman-Approved-At: Tue, 19 Jul 2022 23:02:40 -0700
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
Cc: linux-hyperv@vger.kernel.org, halves@canonical.com, Markus Mayer <mmayer@broadcom.com>, peterz@infradead.org, dave.hansen@linux.intel.com, feng.tang@intel.com, mikelley@microsoft.com, Justin Chen <justinpopo6@gmail.com>, will@kernel.org, Doug Berger <opendmb@gmail.com>, arnd@arndb.de, corbet@lwn.net, paulmck@kernel.org, fabiomirmar@gmail.com, x86@kernel.org, mingo@redhat.com, stern@rowland.harvard.edu, bcm-kernel-feedback-list@broadcom.com, dyoung@redhat.com, vgoyal@redhat.com, alejandro.j.jimenez@oracle.com, keescook@chromium.org, john.ogness@linutronix.de, Lee Jones <lee.jones@linaro.org>, rostedt@goodmis.org, Florian Fainelli <f.fainelli@gmail.com>, bp@alien8.de, luto@kernel.org, hidehiro.kawai.ez@hitachi.com, tglx@linutronix.de, andriy.shevchenko@linux.intel.com, jgross@suse.com, Brian Norris <computersforpeace@gmail.com>, gregkh@linuxfoundation.org, kernel@gpiccoli.net, linux-kernel@vger.kernel.org, senozhatsky@chromium.org, d.hatayama@jp.fujitsu.com, mhiramat@kernel.org, kernel-dev@igalia.com, netdev@vger.kernel.org, vkuznets@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

The panic notifier of this driver is very simple code-wise, just a
memory write to a special position with some numeric code. But this
is not clear from the semantic point-of-view, and there is no public
documentation about that either.

After discussing this in the mailing-lists [0] and having Florian
explained it very well, document that in the code for the future
generations asking the same questions. Also, while at it, remove
a useless header.

[0] https://lore.kernel.org/lkml/781cafb0-8d06-8b56-907a-5175c2da196a@gmail.com

Cc: Brian Norris <computersforpeace@gmail.com>
Cc: Doug Berger <opendmb@gmail.com>
Cc: Justin Chen <justinpopo6@gmail.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Markus Mayer <mmayer@broadcom.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>

---

V2:
- Removed the Fixes tag;
- Added Florian's ACK - thanks!

 drivers/soc/bcm/brcmstb/pm/pm-arm.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/bcm/brcmstb/pm/pm-arm.c b/drivers/soc/bcm/brcmstb/pm/pm-arm.c
index 70ad0f3dce28..2a6adaa29596 100644
--- a/drivers/soc/bcm/brcmstb/pm/pm-arm.c
+++ b/drivers/soc/bcm/brcmstb/pm/pm-arm.c
@@ -25,7 +25,6 @@
 #include <linux/kernel.h>
 #include <linux/memblock.h>
 #include <linux/module.h>
-#include <linux/notifier.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/panic_notifier.h>
@@ -664,7 +663,20 @@ static void __iomem *brcmstb_ioremap_match(const struct of_device_id *matches,
 
 	return of_io_request_and_map(dn, index, dn->full_name);
 }
-
+/*
+ * The AON is a small domain in the SoC that can retain its state across
+ * various system wide sleep states and specific reset conditions; the
+ * AON DATA RAM is a small RAM of a few words (< 1KB) which can store
+ * persistent information across such events.
+ *
+ * The purpose of the below panic notifier is to help with notifying
+ * the bootloader that a panic occurred and so that it should try its
+ * best to preserve the DRAM contents holding that buffer for recovery
+ * by the kernel as opposed to wiping out DRAM clean again.
+ *
+ * Reference: comment from Florian Fainelli, at
+ * https://lore.kernel.org/lkml/781cafb0-8d06-8b56-907a-5175c2da196a@gmail.com
+ */
 static int brcmstb_pm_panic_notify(struct notifier_block *nb,
 		unsigned long action, void *data)
 {
-- 
2.37.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
