Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kJFZE-0003wJ-3V
 for kexec@lists.infradead.org; Fri, 18 Sep 2020 12:32:45 +0000
Received: by mail-ej1-x643.google.com with SMTP id z23so7805726ejr.13
 for <kexec@lists.infradead.org>; Fri, 18 Sep 2020 05:32:43 -0700 (PDT)
Subject: Re: [PATCH printk 2/3] printk: move dictionary keys to dev_printk_info
References: <20200917131644.25838-1-john.ogness@linutronix.de>
 <20200917131644.25838-3-john.ogness@linutronix.de>
 <316cf147-0ae2-1c88-7375-07aedc58bd15@rasmusvillemoes.dk>
 <20200918121342.GD14605@alley>
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <3123b0b5-ca4f-e964-ecc7-95fe8409f1d2@rasmusvillemoes.dk>
Date: Fri, 18 Sep 2020 14:32:41 +0200
MIME-Version: 1.0
In-Reply-To: <20200918121342.GD14605@alley>
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
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, John Ogness <john.ogness@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>

On 18/09/2020 14.13, Petr Mladek wrote:
> On Fri 2020-09-18 08:16:37, Rasmus Villemoes wrote:
>> On 17/09/2020 15.16, John Ogness wrote:
>>
>>>  	if (dev->class)
>>>  		subsys = dev->class->name;
>>>  	else if (dev->bus)
>>>  		subsys = dev->bus->name;
>>>  	else
>>> -		return 0;
>>> +		return;
>>>  
>>> -	pos += snprintf(hdr + pos, hdrlen - pos, "SUBSYSTEM=%s", subsys);
>>> -	if (pos >= hdrlen)
>>> -		goto overflow;
>>> +	snprintf(dev_info->subsystem, sizeof(dev_info->subsystem), subsys);
>>
>> It's unlikely that subsys would contain a %, but this will be yet
>> another place to spend brain cycles ignoring if doing static analysis.
>> So can we not do this. Either of strXcpy() for X=s,l will do the same
>> thing, and likely faster.
> 
> Good point! Better be on the safe size in a generic printk() API.
> 
> Well, I am afraid that this would be only small drop in a huge lake.
> class->name and bus->name seems to be passed to %s in so many
> *print*() calls all over the kernel code.

So what? printf("%s", some_string_that_might_contain_percent_chars) is
not a problem.

printf(some_string_that_might_contain_percent_chars) is.

And yes, one could do

  snprintf(dev_info->subsystem, sizeof(dev_info->subsystem), "%s", subsys);

but one might as well avoid the snprintf overhead and use one of the
strX functions that have the exact same semantics (copy as much as
there's room for, ensure nul-termination).

Rasmus

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
