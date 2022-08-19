Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81A16C00140
	for <kexec@archiver.kernel.org>; Wed, 24 Aug 2022 13:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6erz5vHwSuqNstAw6Bp2RJBHh+U5wm9VlH68hMpWSuw=; b=FQKoyB9iXcvSuB
	4M3ozlsBLX9efm512tqJLDXmoo5yzyUd88u2+aNTcT8K24T8OW56XVTnfNeZvedN+oM36FFH3ENmQ
	nYJslLCIRJrjujVpw58U5eY4s6DLS2mBRixOo/05lJmSnVGmW62uWot6AihN4o59sjRtMwS6XSdSt
	Is/iwytcC6S3FYG9hYj/I9R73u5rs5vN9v0N+1XX3+9xWYYzWU8GjBpJ+YcUORO63UFkdkI0v0AIO
	zzrLJQP372/zNEE0OriB7KpzDdzEn2onX5RWl1d520yOd7jeDedHR4n0uqNz7xxm9Z9/CIfDEfYm2
	JLBtUsuxhKfCPjAJFopQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oQq5Q-00D648-Ti; Wed, 24 Aug 2022 13:06:24 +0000
Received: from fanzine.igalia.com ([178.60.130.6] helo=fanzine2.igalia.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oPAP9-00CptP-Ef
	for kexec@lists.infradead.org; Fri, 19 Aug 2022 22:23:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=OonmUPZkO/emCOphZ8VnLPwYmag4wEjaMQk7IMB+RMQ=; b=frivb87m1aODDLexRXHjILEpy0
	zypuxM1lUa2+Sde0ChP8r+SpXKZTYYQ06rsm4azbLcf835GhtiU/63eTRWcbzZyjLucvdKKHJYKiK
	/euCL6+qpMh2bq+mDBCmd4zfYMRfG4Tqf1qA8tyF9Sf9mTKWE49sFBT6zlM+mWR7kHQzFnNnWU6MW
	lkll9FniO4rDprJKDPgb+tUp2okPeMrFiVLU/alXFetoW59OAkLnidfuhStQMFD628z2AmR0v5dqg
	u9NF7VPoqZwVRcG9G6dqJ9Zqmry2mF8HYNj1eMF0SH2Nd3PIvrPYCM3Wwvafygev10hLlqXwn+n1L
	GJahVPlA==;
Received: from [179.232.144.59] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1oPAP0-00Cb74-3H; Sat, 20 Aug 2022 00:23:47 +0200
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To: akpm@linux-foundation.org,
	bhe@redhat.com,
	pmladek@suse.com,
	kexec@lists.infradead.org
Subject: [PATCH V3 08/11] EDAC/altera: Skip the panic notifier if kdump is loaded
Date: Fri, 19 Aug 2022 19:17:28 -0300
Message-Id: <20220819221731.480795-9-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220819221731.480795-1-gpiccoli@igalia.com>
References: <20220819221731.480795-1-gpiccoli@igalia.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220819_152351_529091_B2F4C172 
X-CRM114-Status: GOOD (  13.54  )
X-Mailman-Approved-At: Wed, 24 Aug 2022 06:05:59 -0700
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
Cc: linux-hyperv@vger.kernel.org, halves@canonical.com, peterz@infradead.org, dave.hansen@linux.intel.com, feng.tang@intel.com, mikelley@microsoft.com, will@kernel.org, arnd@arndb.de, corbet@lwn.net, paulmck@kernel.org, fabiomirmar@gmail.com, x86@kernel.org, mingo@redhat.com, stern@rowland.harvard.edu, dyoung@redhat.com, vgoyal@redhat.com, alejandro.j.jimenez@oracle.com, keescook@chromium.org, john.ogness@linutronix.de, Dinh Nguyen <dinguyen@kernel.org>, rostedt@goodmis.org, bp@alien8.de, luto@kernel.org, hidehiro.kawai.ez@hitachi.com, tglx@linutronix.de, andriy.shevchenko@linux.intel.com, linux-edac@vger.kernel.org, jgross@suse.com, Tony Luck <tony.luck@intel.com>, gregkh@linuxfoundation.org, kernel@gpiccoli.net, linux-kernel@vger.kernel.org, xuqiang36@huawei.com, senozhatsky@chromium.org, d.hatayama@jp.fujitsu.com, mhiramat@kernel.org, kernel-dev@igalia.com, netdev@vger.kernel.org, vkuznets@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

The altera_edac panic notifier performs some data collection with
regards errors detected; such code relies in the regmap layer to
perform reads/writes, so the code is abstracted and there is some
risk level to execute that, since the panic path runs in atomic
context, with interrupts/preemption and secondary CPUs disabled.

Users want the information collected in this panic notifier though,
so in order to balance the risk/benefit, let's skip the altera panic
notifier if kdump is loaded. While at it, remove a useless header
and encompass a macro inside the sole ifdef block it is used.

Cc: Borislav Petkov <bp@alien8.de>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Tony Luck <tony.luck@intel.com>
Acked-by: Dinh Nguyen <dinguyen@kernel.org>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>

---

V3:
- added the ack tag from Dinh - thanks!
- had a good discussion with Boris about that in V2 [0],
hopefully we can continue and reach a consensus in this V3.
[0] https://lore.kernel.org/lkml/46137c67-25b4-6657-33b7-cffdc7afc0d7@igalia.com/

V2:
- new patch, based on the discussion in [1].
[1] https://lore.kernel.org/lkml/62a63fc2-346f-f375-043a-fa21385279df@igalia.com/


 drivers/edac/altera_edac.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index e7e8e624a436..741fe5539154 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -16,7 +16,6 @@
 #include <linux/kernel.h>
 #include <linux/mfd/altera-sysmgr.h>
 #include <linux/mfd/syscon.h>
-#include <linux/notifier.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
@@ -24,6 +23,7 @@
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/types.h>
+#include <linux/kexec.h>
 #include <linux/uaccess.h>
 
 #include "altera_edac.h"
@@ -2063,22 +2063,30 @@ static const struct irq_domain_ops a10_eccmgr_ic_ops = {
 };
 
 /************** Stratix 10 EDAC Double Bit Error Handler ************/
-#define to_a10edac(p, m) container_of(p, struct altr_arria10_edac, m)
-
 #ifdef CONFIG_64BIT
 /* panic routine issues reboot on non-zero panic_timeout */
 extern int panic_timeout;
 
+#define to_a10edac(p, m) container_of(p, struct altr_arria10_edac, m)
+
 /*
  * The double bit error is handled through SError which is fatal. This is
  * called as a panic notifier to printout ECC error info as part of the panic.
+ *
+ * Notice that if kdump is set, we take the risk avoidance approach and
+ * skip the notifier, given that users are expected to have access to a
+ * full vmcore.
  */
 static int s10_edac_dberr_handler(struct notifier_block *this,
 				  unsigned long event, void *ptr)
 {
-	struct altr_arria10_edac *edac = to_a10edac(this, panic_notifier);
+	struct altr_arria10_edac *edac;
 	int err_addr, dberror;
 
+	if (kexec_crash_loaded())
+		return NOTIFY_DONE;
+
+	edac = to_a10edac(this, panic_notifier);
 	regmap_read(edac->ecc_mgr_map, S10_SYSMGR_ECC_INTSTAT_DERR_OFST,
 		    &dberror);
 	regmap_write(edac->ecc_mgr_map, S10_SYSMGR_UE_VAL_OFST, dberror);
-- 
2.37.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
