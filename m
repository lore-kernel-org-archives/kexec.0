Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jWLNy-0000Zs-LB
 for kexec@lists.infradead.org; Wed, 06 May 2020 14:51:00 +0000
From: John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH v2 3/3] printk: use the lockless ringbuffer
References: <20200501094010.17694-1-john.ogness@linutronix.de>
 <20200501094010.17694-4-john.ogness@linutronix.de>
Date: Wed, 06 May 2020 16:50:49 +0200
In-Reply-To: <20200501094010.17694-4-john.ogness@linutronix.de> (John Ogness's
 message of "Fri, 1 May 2020 11:46:10 +0206")
Message-ID: <87ftcd86d2.fsf@vostro.fn.ogness.net>
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
To: Petr Mladek <pmladek@suse.com>
Cc: Andrea Parri <parri.andrea@gmail.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>

Hi,

I discovered a bug while preparing my next series, which also made me
realize I had never tested the extended mode feature of netconsole. :-/
The only other user of extended output is /dev/kmsg, and it is doing it
correctly.

Explanation and patch below.

On 2020-05-01, John Ogness <john.ogness@linutronix.de> wrote:
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 9a9b6156270b..0d74ca748b82 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2395,12 +2443,17 @@ void console_unlock(void)
>  	static char text[LOG_LINE_MAX + PREFIX_MAX];
>  	unsigned long flags;
>  	bool do_cond_resched, retry;
> +	struct printk_info info;
> +	struct printk_record r;
>  
>  	if (console_suspended) {
>  		up_console_sem();
>  		return;
>  	}
>  
> +	prb_rec_init_rd(&r, &info, text, sizeof(text), ext_text,
> +			sizeof(ext_text));
> +

Using @ext_text for the dictionary buffer. But extended mode will need
that buffer for generating extended output!

>  	/*
>  	 * Console drivers are called with interrupts disabled, so
>  	 * @console_may_schedule should be cleared before; however, we may
> @@ -2470,19 +2514,20 @@ void console_unlock(void)
>  			exclusive_console = NULL;
>  		}
>  
> -		len += msg_print_text(msg,
> +		len = record_print_text(&r,
>  				console_msg_format & MSG_FORMAT_SYSLOG,
> -				printk_time, text + len, sizeof(text) - len);
> +				printk_time);
>  		if (nr_ext_console_drivers) {
> -			ext_len = msg_print_ext_header(ext_text,
> +			ext_len = info_print_ext_header(ext_text,
>  						sizeof(ext_text),
> -						msg, console_seq);
> +						r.info);
>  			ext_len += msg_print_ext_body(ext_text + ext_len,
>  						sizeof(ext_text) - ext_len,
> -						log_dict(msg), msg->dict_len,
> -						log_text(msg), msg->text_len);
> +						&r.dict_buf[0],
> +						r.info->dict_len,
> +						&r.text_buf[0],
> +						r.info->text_len);

2 problems here:

First, record_print_text() works by modifying the record text buffer
"in-place". So when msg_print_ext_body() creates the extended output, it
will be using a modified text buffer (i.e. one with prefix added).

Second, info_print_ext_header() and msg_print_ext_body() are clobbering
the dictionary buffer because @ext_text _is_ @r.dict_buf.

This can be resolved by giving the record a separate dictionary buffer
and calling record_print_text() after preparing any extended console
text. Patch below...

John Ogness

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 0d74ca748b82..cc79ad67e6e3 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2441,6 +2441,7 @@ void console_unlock(void)
 {
 	static char ext_text[CONSOLE_EXT_LOG_MAX];
 	static char text[LOG_LINE_MAX + PREFIX_MAX];
+	static char dict[LOG_LINE_MAX];
 	unsigned long flags;
 	bool do_cond_resched, retry;
 	struct printk_info info;
@@ -2451,8 +2452,7 @@ void console_unlock(void)
 		return;
 	}
 
-	prb_rec_init_rd(&r, &info, text, sizeof(text), ext_text,
-			sizeof(ext_text));
+	prb_rec_init_rd(&r, &info, text, sizeof(text), dict, sizeof(dict));
 
 	/*
 	 * Console drivers are called with interrupts disabled, so
@@ -2514,9 +2514,10 @@ void console_unlock(void)
 			exclusive_console = NULL;
 		}
 
-		len = record_print_text(&r,
-				console_msg_format & MSG_FORMAT_SYSLOG,
-				printk_time);
+		/*
+		 * Handle extended console text first because later
+		 * record_print_text() will modify the record buffer in-place.
+		 */
 		if (nr_ext_console_drivers) {
 			ext_len = info_print_ext_header(ext_text,
 						sizeof(ext_text),
@@ -2528,6 +2529,9 @@ void console_unlock(void)
 						&r.text_buf[0],
 						r.info->text_len);
 		}
+		len = record_print_text(&r,
+				console_msg_format & MSG_FORMAT_SYSLOG,
+				printk_time);
 		console_seq++;
 		raw_spin_unlock(&logbuf_lock);
 
-- 
2.20.1

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
