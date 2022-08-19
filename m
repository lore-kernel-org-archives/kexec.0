Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D71DDC00140
	for <kexec@archiver.kernel.org>; Wed, 24 Aug 2022 13:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CpzuvqJ+67ZGjR1mMlFLv91SQJQU+G8ahJKhOJMsXEk=; b=I66W1NKVtN9uZQ
	gGpDe9CB55B9L/RVWzSLkThekNMEijeoZGrEunmp6Zvo66ADoAUzP/aLwZcvEV0H0fK28qKhui76+
	BApPqxbFo8TrmBw1A6w+PdEMInFM8U0jwrbtsxPx/Qdck3ViK/B0084VQRfjVDrG0oe5NPkljcnq/
	R0ETmX2YF/jWavPYQOkMCa/DUCVMeBr4ow3pO8fvAj2qy64qi8DQ91EY/c4Ter7wEk8AZX6OG867i
	HK+2Yrp49M5knU87BmkDbNkjKK1Ai3FwVdUQyaEZUxbAd5ukYaYx1Z4f3dfdUvHjtyEDzg5CnbG7X
	WU7C7rEvauYxUZPD26ng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oQq5E-00D5ut-UV; Wed, 24 Aug 2022 13:06:12 +0000
Received: from fanzine.igalia.com ([178.60.130.6] helo=fanzine2.igalia.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oPANq-00Cp1i-H1
	for kexec@lists.infradead.org; Fri, 19 Aug 2022 22:22:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=c6bNbdkIvWKnXnfsb/cTBvGyb1ZPIuxweFGpqUPvTxs=; b=fvlRUlb5+jeq3HjwBCUDmjRGuw
	FilBZcRWvSvdyCdl3M9r1XaItVZZxUcdRx6Af1/Q/kzO3pO3UiFRTh3n5+uGQ32xPzqt87/q3NWjP
	dXBFA/8ttmKc3J8Ytpzvokb9t9WEPe5cB8SNibeXcLXWO/DmRho3BYUF3JGMV/40ycduXcMApaDPr
	BLxjodof8siwHC75VBwyv2EWv6whqmW1vmyIKVdla1tYuBU4tU80OZWtwW57TYjT9M5BR9Bd4H5TB
	NZ1XLPZJZ2ISvmifyTxMxbLzbSr7rBVPYpaVeSj8Yr1NajLCst5p2OrxgMYVp6BDav9peZIjRMnJp
	rYW0DQqQ==;
Received: from [179.232.144.59] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1oPANk-00Cb3c-5Y; Sat, 20 Aug 2022 00:22:25 +0200
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To: akpm@linux-foundation.org,
	bhe@redhat.com,
	pmladek@suse.com,
	kexec@lists.infradead.org
Subject: [PATCH V3 05/11] parisc: Replace regular spinlock with spin_trylock on panic path
Date: Fri, 19 Aug 2022 19:17:25 -0300
Message-Id: <20220819221731.480795-6-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220819221731.480795-1-gpiccoli@igalia.com>
References: <20220819221731.480795-1-gpiccoli@igalia.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220819_152230_647089_9CDC89FC 
X-CRM114-Status: GOOD (  16.71  )
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
Cc: linux-hyperv@vger.kernel.org, halves@canonical.com, peterz@infradead.org, dave.hansen@linux.intel.com, feng.tang@intel.com, mikelley@microsoft.com, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, will@kernel.org, arnd@arndb.de, corbet@lwn.net, paulmck@kernel.org, fabiomirmar@gmail.com, Helge Deller <deller@gmx.de>, x86@kernel.org, mingo@redhat.com, stern@rowland.harvard.edu, dyoung@redhat.com, vgoyal@redhat.com, alejandro.j.jimenez@oracle.com, keescook@chromium.org, john.ogness@linutronix.de, rostedt@goodmis.org, bp@alien8.de, luto@kernel.org, hidehiro.kawai.ez@hitachi.com, tglx@linutronix.de, andriy.shevchenko@linux.intel.com, jgross@suse.com, linux-parisc@vger.kernel.org, gregkh@linuxfoundation.org, kernel@gpiccoli.net, linux-kernel@vger.kernel.org, xuqiang36@huawei.com, senozhatsky@chromium.org, d.hatayama@jp.fujitsu.com, mhiramat@kernel.org, kernel-dev@igalia.com, netdev@vger.kernel.org, Jeroen Roovers <jer@xs4all.nl>, vkuznets@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

The panic notifiers' callbacks execute in an atomic context, with
interrupts/preemption disabled, and all CPUs not running the panic
function are off, so it's very dangerous to wait on a regular
spinlock, there's a risk of deadlock.

Refactor the panic notifier of parisc/power driver to make use
of spin_trylock - for that, we've added a second version of the
soft-power function. Also, some comments were reorganized and
trailing white spaces, useless header inclusion and blank lines
were removed.

Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Jeroen Roovers <jer@xs4all.nl>
Acked-by: Helge Deller <deller@gmx.de> # parisc
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>

---

V3:
- s/in/on as per Jeroen's suggestion - thanks!

V2:
- Added Helge's ACK - thanks!


 arch/parisc/include/asm/pdc.h |  1 +
 arch/parisc/kernel/firmware.c | 27 +++++++++++++++++++++++----
 drivers/parisc/power.c        | 17 ++++++++++-------
 3 files changed, 34 insertions(+), 11 deletions(-)

diff --git a/arch/parisc/include/asm/pdc.h b/arch/parisc/include/asm/pdc.h
index b643092d4b98..7a106008e258 100644
--- a/arch/parisc/include/asm/pdc.h
+++ b/arch/parisc/include/asm/pdc.h
@@ -83,6 +83,7 @@ int pdc_do_firm_test_reset(unsigned long ftc_bitmap);
 int pdc_do_reset(void);
 int pdc_soft_power_info(unsigned long *power_reg);
 int pdc_soft_power_button(int sw_control);
+int pdc_soft_power_button_panic(int sw_control);
 void pdc_io_reset(void);
 void pdc_io_reset_devices(void);
 int pdc_iodc_getc(void);
diff --git a/arch/parisc/kernel/firmware.c b/arch/parisc/kernel/firmware.c
index 6a7e315bcc2e..3b1f7641e3c9 100644
--- a/arch/parisc/kernel/firmware.c
+++ b/arch/parisc/kernel/firmware.c
@@ -1232,15 +1232,18 @@ int __init pdc_soft_power_info(unsigned long *power_reg)
 }
 
 /*
- * pdc_soft_power_button - Control the soft power button behaviour
- * @sw_control: 0 for hardware control, 1 for software control 
+ * pdc_soft_power_button{_panic} - Control the soft power button behaviour
+ * @sw_control: 0 for hardware control, 1 for software control
  *
  *
  * This PDC function places the soft power button under software or
  * hardware control.
- * Under software control the OS may control to when to allow to shut 
- * down the system. Under hardware control pressing the power button 
+ * Under software control the OS may control to when to allow to shut
+ * down the system. Under hardware control pressing the power button
  * powers off the system immediately.
+ *
+ * The _panic version relies on spin_trylock to prevent deadlock
+ * on panic path.
  */
 int pdc_soft_power_button(int sw_control)
 {
@@ -1254,6 +1257,22 @@ int pdc_soft_power_button(int sw_control)
 	return retval;
 }
 
+int pdc_soft_power_button_panic(int sw_control)
+{
+	int retval;
+	unsigned long flags;
+
+	if (!spin_trylock_irqsave(&pdc_lock, flags)) {
+		pr_emerg("Couldn't enable soft power button\n");
+		return -EBUSY; /* ignored by the panic notifier */
+	}
+
+	retval = mem_pdc_call(PDC_SOFT_POWER, PDC_SOFT_POWER_ENABLE, __pa(pdc_result), sw_control);
+	spin_unlock_irqrestore(&pdc_lock, flags);
+
+	return retval;
+}
+
 /*
  * pdc_io_reset - Hack to avoid overlapping range registers of Bridges devices.
  * Primarily a problem on T600 (which parisc-linux doesn't support) but
diff --git a/drivers/parisc/power.c b/drivers/parisc/power.c
index 456776bd8ee6..8512884de2cf 100644
--- a/drivers/parisc/power.c
+++ b/drivers/parisc/power.c
@@ -37,7 +37,6 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
-#include <linux/notifier.h>
 #include <linux/panic_notifier.h>
 #include <linux/reboot.h>
 #include <linux/sched/signal.h>
@@ -175,16 +174,21 @@ static void powerfail_interrupt(int code, void *x)
 
 
 
-/* parisc_panic_event() is called by the panic handler.
- * As soon as a panic occurs, our tasklets above will not be
- * executed any longer. This function then re-enables the 
- * soft-power switch and allows the user to switch off the system
+/*
+ * parisc_panic_event() is called by the panic handler.
+ *
+ * As soon as a panic occurs, our tasklets above will not
+ * be executed any longer. This function then re-enables
+ * the soft-power switch and allows the user to switch off
+ * the system. We rely in pdc_soft_power_button_panic()
+ * since this version spin_trylocks (instead of regular
+ * spinlock), preventing deadlocks on panic path.
  */
 static int parisc_panic_event(struct notifier_block *this,
 		unsigned long event, void *ptr)
 {
 	/* re-enable the soft-power switch */
-	pdc_soft_power_button(0);
+	pdc_soft_power_button_panic(0);
 	return NOTIFY_DONE;
 }
 
@@ -193,7 +197,6 @@ static struct notifier_block parisc_panic_block = {
 	.priority	= INT_MAX,
 };
 
-
 static int __init power_init(void)
 {
 	unsigned long ret;
-- 
2.37.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
