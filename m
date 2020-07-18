Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jwlgF-0000WE-1J
 for kexec@lists.infradead.org; Sat, 18 Jul 2020 12:11:03 +0000
Received: by mail-wr1-x443.google.com with SMTP id z13so13667759wrw.5
 for <kexec@lists.infradead.org>; Sat, 18 Jul 2020 05:11:00 -0700 (PDT)
Date: Sat, 18 Jul 2020 14:10:53 +0200
From: Marco Elver <elver@google.com>
Subject: Re: [PATCH v5 4/4] printk: use the lockless ringbuffer
Message-ID: <20200718121053.GA691245@elver.google.com>
References: <20200709132344.760-1-john.ogness@linutronix.de>
 <20200709132344.760-5-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200709132344.760-5-john.ogness@linutronix.de>
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
To: John Ogness <john.ogness@linutronix.de>
Cc: Andrea Parri <parri.andrea@gmail.com>, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Paul McKenney <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>

On Thu, Jul 09, 2020 at 03:29PM +0206, John Ogness wrote:
> Replace the existing ringbuffer usage and implementation with
> lockless ringbuffer usage. Even though the new ringbuffer does not
> require locking, all existing locking is left in place. Therefore,
> this change is purely replacing the underlining ringbuffer.
> 
> Changes that exist due to the ringbuffer replacement:
> 
> - The VMCOREINFO has been updated for the new structures.
> 
> - Dictionary data is now stored in a separate data buffer from the
>   human-readable messages. The dictionary data buffer is set to the
>   same size as the message buffer. Therefore, the total required
>   memory for both dictionary and message data is
>   2 * (2 ^ CONFIG_LOG_BUF_SHIFT) for the initial static buffers and
>   2 * log_buf_len (the kernel parameter) for the dynamic buffers.
> 
> - Record meta-data is now stored in a separate array of descriptors.
>   This is an additional 72 * (2 ^ (CONFIG_LOG_BUF_SHIFT - 5)) bytes
>   for the static array and 72 * (log_buf_len >> 5) bytes for the
>   dynamic array.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> Reviewed-by: Petr Mladek <pmladek@suse.com>

It seems this causes a regression observed at least with newline-only
printks. I noticed this during -next testing because various debugging
tools (K*SAN, lockdep, etc.) use e.g. pr_{err,warn,info}("\n") to format
reports.

Without wanting to wait for a report from one of these debugging tools,
a simple reproducer is below. Without this patch, the expected newline
is printed.

Thanks,
-- Marco

------ >8 ------

--- a/init/main.c
+++ b/init/main.c
@@ -1039,6 +1039,10 @@ asmlinkage __visible void __init start_kernel(void)
 	sfi_init_late();
 	kcsan_init();
 
+	pr_info("EXPECT BLANK LINE --vv\n");
+	pr_info("\n");
+	pr_info("EXPECT BLANK LINE --^^\n");
+
 	/* Do the rest non-__init'ed, we're now alive */
 	arch_call_rest_init();
 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
