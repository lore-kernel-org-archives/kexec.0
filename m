Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 502CDC43334
	for <kexec@archiver.kernel.org>; Wed, 20 Jul 2022 06:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=97Rr4noO05zsiVr4A/Aj1GqJp71lIIUS62xYnaz0cZc=; b=uggfdX9n1so7dj
	f7FSU+3knwadEf6+TM1plUmHD/SBLYK1R67KrrPyRW8CrQaEbbKr7LuYNxd/F2KDXLrootf9LAOyK
	HzLcT0wOnJuvzsrHV0bEMJw/EBod5QpEkl+l7uMutm9l3ZvcLSSmNiN4oSkWTVEULb8PEUaT2vX2u
	eTlc2FxEWw4Tf16TWLRCMZfmaLrUQ5XuIO1WZRLQxUQAL+POevdwApkqOM9iISiiX9zAWlzRMGX+7
	weCnLMENXVqSB1sRN9d27Pdvnc6KQwc7q5W3+22lxsD/r0kQGxpQF+x11j68Oqutfi3Zb5NVEZzGv
	7XYe8ODPVj94uiv65O6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oE2nb-000sWr-Cv; Wed, 20 Jul 2022 06:03:07 +0000
Received: from fanzine.igalia.com ([178.60.130.6] helo=fanzine2.igalia.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDtLY-00CCVf-Dv
	for kexec@lists.infradead.org; Tue, 19 Jul 2022 19:57:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=osYWLXybRPL1xf3tnhpVcbfelhXywT0IUwZfpUOrny0=; b=IXkzcOlBT4OGdUHgU7aHfj0gli
	49Z2HkBI8rJTWZvNxtsQF3UUZvJboNHXnI209t363+SRKm0rCzJ8ics+R9zP8hPgfd6PUu8k+sbGp
	2pOjkSQUBSbKuZ86jgn3hXy5lLltVdvfBB9GVgZHgKtZXE5LJvkQ6m6GClNOi2syoBYf8wnVstdQb
	qbyDM3KLIK8M5eDBWF4Hw46IwDbnITXJBIpfke/l9omy1kBy4onAazVeSSt3RcZYuliplx/5YKaf/
	PKugx+keEi1ue3p3eGyTIhz8EbJxCxjLfbT65IaCsF16pSIADVP1EVpnEvXe1xAcyJ85JNiwgocXU
	SVRequxg==;
Received: from 200-100-212-117.dial-up.telesp.net.br ([200.100.212.117] helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1oDtLR-006fd6-O6; Tue, 19 Jul 2022 21:57:26 +0200
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To: akpm@linux-foundation.org,
	bhe@redhat.com,
	pmladek@suse.com,
	kexec@lists.infradead.org
Subject: [PATCH v2 10/13] EDAC/altera: Skip the panic notifier if kdump is loaded
Date: Tue, 19 Jul 2022 16:53:23 -0300
Message-Id: <20220719195325.402745-11-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220719195325.402745-1-gpiccoli@igalia.com>
References: <20220719195325.402745-1-gpiccoli@igalia.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220719_125732_524563_D8CFC35C 
X-CRM114-Status: GOOD (  13.72  )
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
Cc: linux-hyperv@vger.kernel.org, halves@canonical.com, peterz@infradead.org, dave.hansen@linux.intel.com, feng.tang@intel.com, mikelley@microsoft.com, will@kernel.org, arnd@arndb.de, corbet@lwn.net, paulmck@kernel.org, fabiomirmar@gmail.com, x86@kernel.org, mingo@redhat.com, stern@rowland.harvard.edu, dyoung@redhat.com, vgoyal@redhat.com, alejandro.j.jimenez@oracle.com, keescook@chromium.org, john.ogness@linutronix.de, Dinh Nguyen <dinguyen@kernel.org>, rostedt@goodmis.org, bp@alien8.de, luto@kernel.org, hidehiro.kawai.ez@hitachi.com, tglx@linutronix.de, andriy.shevchenko@linux.intel.com, linux-edac@vger.kernel.org, jgross@suse.com, Tony Luck <tony.luck@intel.com>, gregkh@linuxfoundation.org, kernel@gpiccoli.net, linux-kernel@vger.kernel.org, senozhatsky@chromium.org, d.hatayama@jp.fujitsu.com, mhiramat@kernel.org, kernel-dev@igalia.com, netdev@vger.kernel.org, vkuznets@redhat.com
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

Cc: Dinh Nguyen <dinguyen@kernel.org>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Tony Luck <tony.luck@intel.com>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>

---

V2:
- new patch, based on the discussion in [0].
[0] https://lore.kernel.org/lkml/62a63fc2-346f-f375-043a-fa21385279df@igalia.com/

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
2.37.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
