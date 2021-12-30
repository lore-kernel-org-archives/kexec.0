Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fanzine2.igalia.com ([213.97.179.56])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n2y9o-004kBD-CN
 for kexec@lists.infradead.org; Thu, 30 Dec 2021 16:20:01 +0000
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: [PATCH] panic: Move panic_print before kmsg dumpers
Date: Thu, 30 Dec 2021 13:18:28 -0300
Message-Id: <20211230161828.121858-1-gpiccoli@igalia.com>
MIME-Version: 1.0
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
To: linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Cc: gpiccoli@igalia.com, kernel@gpiccoli.net, pmladek@suse.com, senozhatsky@chromium.org, rostedt@goodmis.org, john.ogness@linutronix.de, feng.tang@intel.com, kexec@lists.infradead.org, dyoung@redhat.com, keescook@chromium.org, anton@enomsg.org, ccross@android.com, tony.luck@intel.com

The panic_print setting allows users to collect more information in a
panic event, like memory stats, tasks, CPUs backtraces, etc.
This is a pretty interesting debug mechanism, but currently the print
event happens *after* kmsg_dump(), meaning that Pstore, for example,
cannot collect a dmesg with the panic_print information.

This patch changes that by moving the panic_print_sys_info() function
call up some lines, in order kmsg_dump() accounts this new information
and exposes it through Pstore or other kmsg dumpers.

Cc: Feng Tang <feng.tang@intel.com>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---


Hey folks, thanks in advance for reviews/comments!
One alternative I've considered was to move kmsg_dump() some
lines down, I'm not sure which approach is better, can't see
much difference. Opinions are very welcome =)
Cheers,


Guilherme


 kernel/panic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index cefd7d82366f..d918da0a1c29 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -271,6 +271,8 @@ void panic(const char *fmt, ...)
 	 */
 	atomic_notifier_call_chain(&panic_notifier_list, 0, buf);
 
+	panic_print_sys_info();
+
 	kmsg_dump(KMSG_DUMP_PANIC);
 
 	/*
@@ -301,8 +303,6 @@ void panic(const char *fmt, ...)
 	debug_locks_off();
 	console_flush_on_panic(CONSOLE_FLUSH_PENDING);
 
-	panic_print_sys_info();
-
 	if (!panic_blink)
 		panic_blink = no_blink;
 
-- 
2.34.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
