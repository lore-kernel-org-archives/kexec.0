Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wg0-x22e.google.com ([2a00:1450:400c:c00::22e])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YaRXM-0007cB-Vr
 for kexec@lists.infradead.org; Tue, 24 Mar 2015 16:18:41 +0000
Received: by wgra20 with SMTP id a20so175209989wgr.3
 for <kexec@lists.infradead.org>; Tue, 24 Mar 2015 09:18:18 -0700 (PDT)
Date: Tue, 24 Mar 2015 17:18:14 +0100
From: Ingo Molnar <mingo@kernel.org>
Subject: Re: Re: [PATCH v2] kernel/panic/kexec: fix
 "crash_kexec_post_notifiers" option issue in oops path
Message-ID: <20150324161814.GB8661@gmail.com>
References: <54F9D645.2050008@jp.fujitsu.com>
 <20150323034752.GD2068@dhcp-16-105.nay.redhat.com>
 <20150323071943.GA22765@gmail.com> <5510DA42.6040708@hitachi.com>
 <20150324071129.GA28619@gmail.com>
 <20150324144608.GB2970@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150324144608.GB2970@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hidehiro.kawai.ez@hitachi.com, =?utf-8?B?IkhhdGF5YW1hLCBEYWlzdWtlL+eVkeWxsSDlpKfovJQi?= <d.hatayama@jp.fujitsu.com>, mingo@redhat.com, ebiederm@xmission.com, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, akpm@linux-foundation.org, bp@suse.de


* Vivek Goyal <vgoyal@redhat.com> wrote:

> > Yet the actual bug is in that commit, 'crash_kexec_post_notifiers' 
> > was clearly not a no-op in the default case, against expectations.
> 
> Hi Ingo,
> 
> I did a quick test and in default case crash_kexec() runs before 
> panic notifiers. So it does look like crash_kexec_post_notifiers is 
> a no-op in default case.
> 
> What am I missing.

Well, look at f06e5153f4ae:

diff --git a/kernel/panic.c b/kernel/panic.c
index d02fa9fef46a..62e16cef9cc2 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -32,6 +32,7 @@ static unsigned long tainted_mask;
 static int pause_on_oops;
 static int pause_on_oops_flag;
 static DEFINE_SPINLOCK(pause_on_oops_lock);
+static bool crash_kexec_post_notifiers;
 
 int panic_timeout = CONFIG_PANIC_TIMEOUT;
 EXPORT_SYMBOL_GPL(panic_timeout);
@@ -112,9 +113,11 @@ void panic(const char *fmt, ...)
 	/*
 	 * If we have crashed and we have a crash kernel loaded let it handle
 	 * everything else.
-	 * Do we want to call this before we try to display a message?
+	 * If we want to run this after calling panic_notifiers, pass
+	 * the "crash_kexec_post_notifiers" option to the kernel.
 	 */
-	crash_kexec(NULL);
+	if (!crash_kexec_post_notifiers)
+		crash_kexec(NULL);
 
 	/*
 	 * Note smp_send_stop is the usual smp shutdown function, which
@@ -131,6 +134,15 @@ void panic(const char *fmt, ...)
 
 	kmsg_dump(KMSG_DUMP_PANIC);
 
+	/*
+	 * If you doubt kdump always works fine in any situation,
+	 * "crash_kexec_post_notifiers" offers you a chance to run
+	 * panic_notifiers and dumping kmsg before kdump.
+	 * Note: since some panic_notifiers can make crashed kernel
+	 * more unstable, it can increase risks of the kdump failure too.
+	 */
+	crash_kexec(NULL);
+
 	bust_spinlocks(0);
 
 	if (!panic_blink)


Without knowing what crash_kexec() does, the patch looks buggy: it 
should preserve the old behavior by default, yet it will now execute a 
second crash_kexec() after the kmsg_dump() line.

So the invariant change would have been to do:

-	crash_kexec(NULL);
+	if (!crash_kexec_post_notifiers)
+		crash_kexec(NULL);

...

+	if (crash_kexec_post_notifiers)
+		crash_kexec(NULL);

Which in the !crash_kexec_post_notifiers flag case reduces to:

	crash_kexec();

	...

	/* NOP */

I.e. to exactly what the kernel was doing without the patch 
originally.

Which is what my patch does. Nothing more, nothing less.

There might be other bugs with the patch, I didn't consider that.

A revert would be fine as well.

Thanks,

	Ingo

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
