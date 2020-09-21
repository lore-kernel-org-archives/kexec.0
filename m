Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kKIYB-0003Zu-IR
 for kexec@lists.infradead.org; Mon, 21 Sep 2020 09:56:00 +0000
Date: Mon, 21 Sep 2020 11:55:57 +0200
From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH printk v2 2/3] printk: move dictionary keys to
 dev_printk_info
Message-ID: <20200921095557.GH14605@alley>
References: <20200918223421.21621-1-john.ogness@linutronix.de>
 <20200918223421.21621-3-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200918223421.21621-3-john.ogness@linutronix.de>
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
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>

On Sat 2020-09-19 00:40:20, John Ogness wrote:
> Dictionaries are only used for SUBSYSTEM and DEVICE properties. The
> current implementation stores the property names each time they are
> used. This requires more space than otherwise necessary. Also,
> because the dictionary entries are currently considered optional,
> it cannot be relied upon that they are always available, even if the
> writer wanted to store them. These issues will increase should new
> dictionary properties be introduced.
> 
> Rather than storing the subsystem and device properties in the
> dict ring, introduce a struct dev_printk_info with separate fields
> to store only the property values. Embed this struct within the
> struct printk_info to provide guaranteed availability.


> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -629,36 +624,43 @@ static ssize_t msg_print_ext_body(char *buf, size_t size,
>  		else
>  			append_char(&p, e, c);
>  	}
> -	append_char(&p, e, '\n');
> +	append_char(&p, e, endc);
>  
> -	if (dict_len) {
> -		bool line = true;
> +	return p - buf;
> +}
>  
> -		for (i = 0; i < dict_len; i++) {
> -			unsigned char c = dict[i];
> +static ssize_t msg_add_dict_text(char *buf, size_t size,
> +				 const char *key, const char *val)
> +{
> +	size_t val_len = strlen(val);
> +	ssize_t len;
>  
> -			if (line) {
> -				append_char(&p, e, ' ');
> -				line = false;

I double checked this and found that the above code prefixed dict
values by ' ' in /dev/kmsg.

It slightly improves readability and it is handy for eventual filtering.
It would make sense to keep it.

> -			}
> +	if (!val_len)
> +		return 0;
>  
> -			if (c == '\0') {
> -				append_char(&p, e, '\n');
> -				line = true;
> -				continue;
> -			}
> +	len = msg_add_ext_text(buf, size, key, strlen(key), '=');
> +	len += msg_add_ext_text(buf + len, size - len, val, val_len, '\n');

Slightly ugly but simple solution is:

	len = msg_add_ext_text(buf, size, "", 0, ' ');	/* dict prefix */
	len += msg_add_ext_text(buf + len, size - len, key, strlen(key), '=');
	len += msg_add_ext_text(buf + len, size - len, val, val_len, '\n');

With this fix:

Reviewed-by: Petr Mladek <pmladek@suse.com>


Now, this is the only problem that I have found. It is not necessary
to resend the entire patchset just because of this.

It might be enough to either respin just this patch. Or I could
commit the below one on top of the patchset. Either solution works
for me.

From dcc5dc0467c6e7d13202d98bbefb505a1db693fd Mon Sep 17 00:00:00 2001
From: Petr Mladek <pmladek@suse.com>
Date: Mon, 21 Sep 2020 11:45:16 +0200
Subject: [PATCH] printk: Put back dict lines prefix into /dev/kmsg

Put back prefix for dictionary lines in /dev/kmsg. They have been removed
by the commit  XXX ("printk: move dictionary keys to dev_printk_info").

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 77660354a7c5..1fe3d0cb2fe0 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -637,7 +637,8 @@ static ssize_t msg_add_dict_text(char *buf, size_t size,
 	if (!val_len)
 		return 0;
 
-	len = msg_add_ext_text(buf, size, key, strlen(key), '=');
+	len = msg_add_ext_text(buf, size, "", 0, ' ');	/* dict prefix */
+	len += msg_add_ext_text(buf + len, size - len, key, strlen(key), '=');
 	len += msg_add_ext_text(buf + len, size - len, val, val_len, '\n');
 
 	return len;
-- 
2.26.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
