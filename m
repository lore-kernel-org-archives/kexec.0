Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B033C43334
	for <kexec@archiver.kernel.org>; Wed, 20 Jul 2022 06:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BQxI6Dwib8X0lZnMaA1krGnCewf64cn0TPuHJjJQUjw=; b=uApJkmTJdbVc3B
	WLCpv4KoxOJrRC4r/vpTtD05W/upiSWSzwdzRXov5NVQiOUTvXr2ROIK+mrBprASVD5EQrcKrYc1G
	p4HJk+VMNqPUj9+bk+FWej4cz+pvNWAuU1rLsGvHDlM+Xoqo5Ddi75ps+9uTHbWV/3QiZeNSAGB3e
	1d4JyUrceYoQWWaQeMYkcDLhu66e3wod6Bmb3ShEI8ZZeq1ohBGMspGk13V1zHBo5y/LP9H947Pg2
	XUq4ri2AaiPkHEDiqLFy98eLxKaCulWkVnJ9ndXqLFicbLliciurWCD3O7ddIs8j3fOQWHuUDQmU1
	ABp7rl+iUqkEeeznJ3yQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oE2nY-000sTJ-4n; Wed, 20 Jul 2022 06:03:04 +0000
Received: from fanzine.igalia.com ([178.60.130.6] helo=fanzine2.igalia.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDtLD-00CC3h-08
	for kexec@lists.infradead.org; Tue, 19 Jul 2022 19:57:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=sxerzEC6ULnrCK4xFVFRwsVny05lEai+m5Q0OhAgHvc=; b=LydLkzqrM6AQgyUZb/eK78EaTe
	voCyZOYInunbfsTQJhUj6qGYkEcwQqAZoeE5g9fyKdb2pV3SYR9F2oFs7yNM3qsGwT21rp2aZLD+6
	DRVvuKL2t8RP2KNGIJEg0K51V8ryEYddAmBtZ52mC+bH8R+QBJpSRJaHwfoS5PcBpccLkHwPVXH1p
	iZCPDlenLJA0ElBqc9ii7N0UWdszArx91MaroFoXGCYEDCyXx3ZlFTtOCFetlVaWTUnEJssIASGqW
	C9ijI9jv+NNIUzBR7rfC1MtzW0qf9n5kWS+hQY2dFbmdPPKkRpI01y7E60JasW9nNQUJB+6R9Ol6l
	duNmoiYw==;
Received: from 200-100-212-117.dial-up.telesp.net.br ([200.100.212.117] helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1oDtL7-006fav-1R; Tue, 19 Jul 2022 21:57:05 +0200
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To: akpm@linux-foundation.org,
	bhe@redhat.com,
	pmladek@suse.com,
	kexec@lists.infradead.org
Subject: [PATCH v2 09/13] notifier: Show function names on notifier routines if DEBUG_NOTIFIERS is set
Date: Tue, 19 Jul 2022 16:53:22 -0300
Message-Id: <20220719195325.402745-10-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220719195325.402745-1-gpiccoli@igalia.com>
References: <20220719195325.402745-1-gpiccoli@igalia.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220719_125711_086772_54CB67D6 
X-CRM114-Status: GOOD (  12.52  )
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
Cc: linux-hyperv@vger.kernel.org, halves@canonical.com, peterz@infradead.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, dave.hansen@linux.intel.com, feng.tang@intel.com, mikelley@microsoft.com, will@kernel.org, arnd@arndb.de, corbet@lwn.net, paulmck@kernel.org, fabiomirmar@gmail.com, x86@kernel.org, mingo@redhat.com, stern@rowland.harvard.edu, dyoung@redhat.com, Valentin Schneider <valentin.schneider@arm.com>, vgoyal@redhat.com, Xiaoming Ni <nixiaoming@huawei.com>, alejandro.j.jimenez@oracle.com, keescook@chromium.org, john.ogness@linutronix.de, rostedt@goodmis.org, bp@alien8.de, luto@kernel.org, hidehiro.kawai.ez@hitachi.com, Cong Wang <xiyou.wangcong@gmail.com>, tglx@linutronix.de, andriy.shevchenko@linux.intel.com, Arjan van de Ven <arjan@linux.intel.com>, jgross@suse.com, gregkh@linuxfoundation.org, kernel@gpiccoli.net, linux-kernel@vger.kernel.org, senozhatsky@chromium.org, d.hatayama@jp.fujitsu.com, mhiramat@kernel.org, kernel-dev@igalia.com, netdev@vger.kernel.org, vkuznets@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Currently we have a debug infrastructure in the notifiers file, but
it's very simple/limited. Extend it by:

(a) Showing all registered/unregistered notifiers' callback names;

(b) Adding a dynamic debug tuning to allow showing called notifiers'
function names. Notice that this should be guarded as a tunable since
it can flood the kernel log buffer.

Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: Xiaoming Ni <nixiaoming@huawei.com>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>

---

V2:
- Major improvement thanks to the great idea from Xiaoming - changed
all the ksym wheel reinvention to printk %ps modifier;

- Instead of ifdefs, using IS_ENABLED() - thanks Steven.

- Removed an unlikely() hint on debug path.

 kernel/notifier.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/kernel/notifier.c b/kernel/notifier.c
index 0d5bd62c480e..350761b34f8a 100644
--- a/kernel/notifier.c
+++ b/kernel/notifier.c
@@ -37,6 +37,10 @@ static int notifier_chain_register(struct notifier_block **nl,
 	}
 	n->next = *nl;
 	rcu_assign_pointer(*nl, n);
+
+	if (IS_ENABLED(CONFIG_DEBUG_NOTIFIERS))
+		pr_info("notifiers: registered %ps\n", n->notifier_call);
+
 	return 0;
 }
 
@@ -46,6 +50,11 @@ static int notifier_chain_unregister(struct notifier_block **nl,
 	while ((*nl) != NULL) {
 		if ((*nl) == n) {
 			rcu_assign_pointer(*nl, n->next);
+
+			if (IS_ENABLED(CONFIG_DEBUG_NOTIFIERS))
+				pr_info("notifiers: unregistered %ps\n",
+					n->notifier_call);
+
 			return 0;
 		}
 		nl = &((*nl)->next);
@@ -77,13 +86,14 @@ static int notifier_call_chain(struct notifier_block **nl,
 	while (nb && nr_to_call) {
 		next_nb = rcu_dereference_raw(nb->next);
 
-#ifdef CONFIG_DEBUG_NOTIFIERS
-		if (unlikely(!func_ptr_is_kernel_text(nb->notifier_call))) {
-			WARN(1, "Invalid notifier called!");
-			nb = next_nb;
-			continue;
+		if (IS_ENABLED(CONFIG_DEBUG_NOTIFIERS)) {
+			if (!func_ptr_is_kernel_text(nb->notifier_call)) {
+				WARN(1, "Invalid notifier called!");
+				nb = next_nb;
+				continue;
+			}
+			pr_debug("notifiers: calling %ps\n", nb->notifier_call);
 		}
-#endif
 		ret = nb->notifier_call(nb, val, v);
 
 		if (nr_calls)
-- 
2.37.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
