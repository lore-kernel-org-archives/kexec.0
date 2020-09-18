Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kJ9hK-0003uc-17
 for kexec@lists.infradead.org; Fri, 18 Sep 2020 06:16:44 +0000
Received: by mail-ed1-x543.google.com with SMTP id g4so4971369edk.0
 for <kexec@lists.infradead.org>; Thu, 17 Sep 2020 23:16:39 -0700 (PDT)
Subject: Re: [PATCH printk 2/3] printk: move dictionary keys to dev_printk_info
References: <20200917131644.25838-1-john.ogness@linutronix.de>
 <20200917131644.25838-3-john.ogness@linutronix.de>
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <316cf147-0ae2-1c88-7375-07aedc58bd15@rasmusvillemoes.dk>
Date: Fri, 18 Sep 2020 08:16:37 +0200
MIME-Version: 1.0
In-Reply-To: <20200917131644.25838-3-john.ogness@linutronix.de>
Content-Language: en-US
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
To: John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>

On 17/09/2020 15.16, John Ogness wrote:

>  	if (dev->class)
>  		subsys = dev->class->name;
>  	else if (dev->bus)
>  		subsys = dev->bus->name;
>  	else
> -		return 0;
> +		return;
>  
> -	pos += snprintf(hdr + pos, hdrlen - pos, "SUBSYSTEM=%s", subsys);
> -	if (pos >= hdrlen)
> -		goto overflow;
> +	snprintf(dev_info->subsystem, sizeof(dev_info->subsystem), subsys);

It's unlikely that subsys would contain a %, but this will be yet
another place to spend brain cycles ignoring if doing static analysis.
So can we not do this. Either of strXcpy() for X=s,l will do the same
thing, and likely faster.

Rasmus

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
