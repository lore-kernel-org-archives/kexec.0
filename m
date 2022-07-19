Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E0D7C433EF
	for <kexec@archiver.kernel.org>; Wed, 20 Jul 2022 06:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XDK3QPz0SGliH3wdiktWI0fpCDzJv7L64ZnHRDAI73c=; b=L7tC5xlYL60FWJ
	arUUkmO9zP4EqTw0qoyimXcZaqVDNB85fKkxZM7kNfkt4K2U39RITnjrllT7Fcj0BMMn7Xj3T+oif
	H2Hr9v/P6+Wow9ZcTJr6OxBoLx0wPjJC3tpxHhDR488l2KBCOZr7UNSMO07bIiiSkyQlQzwxGAaXD
	U1r8Nx9KvFVw4NzDtk+mgaE7X9tLx8NzYO9Y+mip0lt4O1gmNxNqcFiwL/+68qw7EzQ9Z/C6gbSkC
	ez3Wz/o6g06NOTbsN8Y6JKiPyE5tJpZ7iC1n0T1Chm17TsDv7VhQtakdwYEgaMGu/GQJ1k97t5byP
	Kt2FT/mxpyF/j3wWI9cg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oE2nK-000sFu-QK; Wed, 20 Jul 2022 06:02:50 +0000
Received: from fanzine.igalia.com ([178.60.130.6] helo=fanzine2.igalia.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDtJT-00C9zy-Je
	for kexec@lists.infradead.org; Tue, 19 Jul 2022 19:55:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=9D78nvhNUhUxf7wmYwWEZuYxWa9Y1RQxDBYD6eiYeI0=; b=ANVqZt3uY+4+newhyHw8DUfIMW
	ZTvApb4f3Jm9BcYZjq2qtfJGQa+zx/pVl5BeiDlgRBJUKSQG5CP6Y89+Dqv5h9pv3FzRFI53PaKG0
	SPnA5NAhvnfEQNcRnX4dY2lgUj5VbIwHIGulS5/S+pnvU1NZMhH/x2VPIoeaa4jeXQiHgBmSZCgm1
	/4JOcqlyu552/GukWc3OJfImeExg2+lqoi2thzgNaQO30Uj78q0PTaFdLgkZDCr/Pbf/lC0Oj12Qm
	4nAsgoUKojt7jq30UnpB96DXsF/+2zIKk+WFsnT+MgG80c0Bjj9IcYCQZSI/QRSgPfkZA1iGRBQBG
	YvVnsU8w==;
Received: from 200-100-212-117.dial-up.telesp.net.br ([200.100.212.117] helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1oDtJO-006fLG-08; Tue, 19 Jul 2022 21:55:18 +0200
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To: akpm@linux-foundation.org,
	bhe@redhat.com,
	pmladek@suse.com,
	kexec@lists.infradead.org
Subject: [PATCH v2 03/13] firmware: google: Test spinlock on panic path to avoid lockups
Date: Tue, 19 Jul 2022 16:53:16 -0300
Message-Id: <20220719195325.402745-4-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220719195325.402745-1-gpiccoli@igalia.com>
References: <20220719195325.402745-1-gpiccoli@igalia.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220719_125523_667332_E66A1FAD 
X-CRM114-Status: GOOD (  11.36  )
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
Cc: linux-hyperv@vger.kernel.org, linux-efi@vger.kernel.org, halves@canonical.com, David Gow <davidgow@google.com>, peterz@infradead.org, dave.hansen@linux.intel.com, feng.tang@intel.com, mikelley@microsoft.com, will@kernel.org, Ard Biesheuvel <ardb@kernel.org>, arnd@arndb.de, corbet@lwn.net, paulmck@kernel.org, fabiomirmar@gmail.com, x86@kernel.org, Evan Green <evgreen@chromium.org>, mingo@redhat.com, stern@rowland.harvard.edu, dyoung@redhat.com, vgoyal@redhat.com, alejandro.j.jimenez@oracle.com, keescook@chromium.org, john.ogness@linutronix.de, rostedt@goodmis.org, bp@alien8.de, luto@kernel.org, hidehiro.kawai.ez@hitachi.com, tglx@linutronix.de, andriy.shevchenko@linux.intel.com, jgross@suse.com, gregkh@linuxfoundation.org, kernel@gpiccoli.net, linux-kernel@vger.kernel.org, senozhatsky@chromium.org, d.hatayama@jp.fujitsu.com, mhiramat@kernel.org, kernel-dev@igalia.com, netdev@vger.kernel.org, Julius Werner <jwerner@chromium.org>, vkuznets@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Currently the gsmi driver registers a panic notifier as well as
reboot and die notifiers. The callbacks registered are called in
atomic and very limited context - for instance, panic disables
preemption and local IRQs, also all secondary CPUs (not executing
the panic path) are shutdown.

With that said, taking a spinlock in this scenario is a dangerous
invitation for lockup scenarios. So, fix that by checking if the
spinlock is free to acquire in the panic notifier callback - if not,
bail-out and avoid a potential hang.

Fixes: 74c5b31c6618 ("driver: Google EFI SMI")
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: David Gow <davidgow@google.com>
Cc: Evan Green <evgreen@chromium.org>
Cc: Julius Werner <jwerner@chromium.org>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>

---

V2:
- do not use spin_trylock anymore, to avoid messing with
non-panic paths; now we just check the spinlock state in
the panic notifier before taking it. Thanks Evan for the
review/idea!

 drivers/firmware/google/gsmi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/firmware/google/gsmi.c b/drivers/firmware/google/gsmi.c
index adaa492c3d2d..3ef5f3c0b4e4 100644
--- a/drivers/firmware/google/gsmi.c
+++ b/drivers/firmware/google/gsmi.c
@@ -681,6 +681,14 @@ static struct notifier_block gsmi_die_notifier = {
 static int gsmi_panic_callback(struct notifier_block *nb,
 			       unsigned long reason, void *arg)
 {
+	/*
+	 * Perform the lock check before effectively trying
+	 * to acquire it on gsmi_shutdown_reason() to avoid
+	 * potential lockups in atomic context.
+	 */
+	if (spin_is_locked(&gsmi_dev.lock))
+		return NOTIFY_DONE;
+
 	gsmi_shutdown_reason(GSMI_SHUTDOWN_PANIC);
 	return NOTIFY_DONE;
 }
-- 
2.37.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
