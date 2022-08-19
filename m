Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4366DC32793
	for <kexec@archiver.kernel.org>; Wed, 24 Aug 2022 13:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pkAjfR8SXLpJqZ9X8WKWy/QdDMWajTcYwTmG71QLjy0=; b=ZeQQK+BslHzGWp
	bRvX/8YQp64HQ+QPloDyGWak5bGwJX4qfU0JDo7tdlp0tF+7O44780s4vAhsb73rUCsXNhPzThgcu
	j50Ex58qjGV9kYPrG+vsyE+e4dh+UmLX0RrXnuzHZptM+gGkCSpxLVtjYZVKzDYF6T7fdvTXY86wb
	m+I1EsDzicj3gL5bdy5BUS6aHebtxQaeg1bsb0sorPTJRi7EiiRQbRuj97lU/qEbPbLFLDXeRR2qN
	G+CVq1QHDNC79W8rdn0x0nC2TLgypKLXbZ8Ynkg/z+wQPnGnfW0Ue1XGPQD1sdhnk5hZZI2a2AbZf
	s7STPY3D7JzjG//PmItw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oQq5D-00D5tn-9K; Wed, 24 Aug 2022 13:06:11 +0000
Received: from fanzine.igalia.com ([178.60.130.6] helo=fanzine2.igalia.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oPAN1-00CoWb-CH; Fri, 19 Aug 2022 22:21:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=I7PX0cg9hYhaVm6PvmjCfqAqk9/uhuAJh0bXjru0KJ8=; b=apxqB5qmqlzzY5vxuVHk/oybLg
	LGISEVYytiLSHzQM1NRBWL9ge/1BR3a5d4xyO3rwazWkQf6rO2OS/n67HAwdwBeLdPfOO/5+ptmdA
	nchEn0YnVSqzWI5LYJNJK99CREIoOfURPC5OxlOLbxBjzRqQBhWocnTVkl+50cp4hx2RdCPpm05KJ
	kQ0gUbNDHLN2x4iyxKfxMIsc6UVssvkUQWUb7CBWr3lNyq23EXMGdsgyAbCl6t5yNi3gsN1Pa8ZaO
	6yXzHFVJTNoduFjBMFPFWJoF5WZJ0C44LC+4711S5JBo2OioK7T+35306PeO7vksSE6XS9+9PuVVj
	ZSO7++KA==;
Received: from [179.232.144.59] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1oPAMu-00Cb1Q-Tz; Sat, 20 Aug 2022 00:21:33 +0200
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To: akpm@linux-foundation.org,
	bhe@redhat.com,
	pmladek@suse.com,
	kexec@lists.infradead.org
Subject: [PATCH V3 04/11] um: Improve panic notifiers consistency and ordering
Date: Fri, 19 Aug 2022 19:17:24 -0300
Message-Id: <20220819221731.480795-5-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220819221731.480795-1-gpiccoli@igalia.com>
References: <20220819221731.480795-1-gpiccoli@igalia.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220819_152139_459033_0C20743D 
X-CRM114-Status: GOOD (  10.40  )
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
Cc: linux-hyperv@vger.kernel.org, halves@canonical.com, peterz@infradead.org, dave.hansen@linux.intel.com, feng.tang@intel.com, mikelley@microsoft.com, will@kernel.org, Anton Ivanov <anton.ivanov@cambridgegreys.com>, arnd@arndb.de, corbet@lwn.net, paulmck@kernel.org, fabiomirmar@gmail.com, x86@kernel.org, mingo@redhat.com, stern@rowland.harvard.edu, dyoung@redhat.com, vgoyal@redhat.com, alejandro.j.jimenez@oracle.com, keescook@chromium.org, john.ogness@linutronix.de, linux-um@lists.infradead.org, rostedt@goodmis.org, Richard Weinberger <richard@nod.at>, bp@alien8.de, luto@kernel.org, hidehiro.kawai.ez@hitachi.com, tglx@linutronix.de, andriy.shevchenko@linux.intel.com, Johannes Berg <johannes@sipsolutions.net>, jgross@suse.com, gregkh@linuxfoundation.org, kernel@gpiccoli.net, linux-kernel@vger.kernel.org, xuqiang36@huawei.com, senozhatsky@chromium.org, d.hatayama@jp.fujitsu.com, mhiramat@kernel.org, kernel-dev@igalia.com, netdev@vger.kernel.org, vkuznets@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Currently the panic notifiers from user mode linux don't follow
the convention for most of the other notifiers present in the
kernel (indentation, priority setting, numeric return).
More important, the priorities could be improved, since it's a
special case (userspace), hence we could run the notifiers earlier;
user mode linux shouldn't care much with other panic notifiers but
the ordering among the mconsole and arch notifier is important,
given that the arch one effectively triggers a core dump.

Fix that by running the mconsole notifier as the first panic
notifier, followed by the architecture one (that coredumps).

Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Richard Weinberger <richard@nod.at>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>

V3:
- No changes.

V2:
- Kept the notifier header to avoid implicit usage - thanks
Johannes for the suggestion!
---
 arch/um/drivers/mconsole_kern.c | 7 +++----
 arch/um/kernel/um_arch.c        | 8 ++++----
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/um/drivers/mconsole_kern.c b/arch/um/drivers/mconsole_kern.c
index 8ca67a692683..69af3ce8407a 100644
--- a/arch/um/drivers/mconsole_kern.c
+++ b/arch/um/drivers/mconsole_kern.c
@@ -846,13 +846,12 @@ static int notify_panic(struct notifier_block *self, unsigned long unused1,
 
 	mconsole_notify(notify_socket, MCONSOLE_PANIC, message,
 			strlen(message) + 1);
-	return 0;
+	return NOTIFY_DONE;
 }
 
 static struct notifier_block panic_exit_notifier = {
-	.notifier_call 		= notify_panic,
-	.next 			= NULL,
-	.priority 		= 1
+	.notifier_call	= notify_panic,
+	.priority	= INT_MAX, /* run as soon as possible */
 };
 
 static int add_notifier(void)
diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index e0de60e503b9..ae272878f692 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -247,13 +247,13 @@ static int panic_exit(struct notifier_block *self, unsigned long unused1,
 	bust_spinlocks(0);
 	uml_exitcode = 1;
 	os_dump_core();
-	return 0;
+
+	return NOTIFY_DONE;
 }
 
 static struct notifier_block panic_exit_notifier = {
-	.notifier_call 		= panic_exit,
-	.next 			= NULL,
-	.priority 		= 0
+	.notifier_call	= panic_exit,
+	.priority	= INT_MAX - 1, /* run as 2nd notifier, won't return */
 };
 
 void uml_finishsetup(void)
-- 
2.37.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
