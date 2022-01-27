From: Guilherme G. Piccoli <gpiccoli@igalia.com>
Date: Thu, 27 Jan 2022 14:16:20 -0300
Subject: [PATCH V4] notifier/panic: Introduce panic_notifier_filter
In-Reply-To: <TYAPR01MB6507D9747647685B554B8F8F955F9@TYAPR01MB6507.jpnprd01.prod.outlook.com>
References: <20220108153451.195121-1-gpiccoli@igalia.com>
 <TYAPR01MB6507D06BA6D32218F6E88198955F9@TYAPR01MB6507.jpnprd01.prod.outlook.com>
 <fda509a5-ea0d-4d1d-a1c1-ca5e80010fc0@igalia.com>
 <TYAPR01MB6507D9747647685B554B8F8F955F9@TYAPR01MB6507.jpnprd01.prod.outlook.com>
Message-ID: <fb5e66b6-049a-22ab-5913-a04cc302b629@igalia.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 25/01/2022 10:06, d.hatayama at fujitsu.com wrote:
> 
> But the pre_dump cannot avoid calling multiple unnecessary handlers, right?
> It's more risky than the previous idea...
> 

I think we could have 2 kernel parameters then:

crash_kernel_disable_pre_notitifers (of course we can think in some
better name here heh)

crash_kernel_enable_post_notifiers (which is the same as the current
"crash_kernel_post_notifiers", we can keep it)

The point being (if I understand correctly): some callbacks are really
simple and don't introduce risks for kdump, like the RCU; a bunch of
them just set one variable. Those could be enable by default, before the
kdump.

The majority would fit in the 2nd group, meaning they are not enabled by
default, requiring some parameter for that.

Petr, let me know if that makes sense and is aligned with your suggestion.


> For example, how about simply maintaining function symbol names in the list
> as string, not address.
> 

I considered that before, it was my first idea but it's not great due to
memory allocation. We'd need to use memblock to allocate a struct to
hold function names, and the comparison on register time is slower, I
guess... so it's much easier to pre-allocate some handlers and only
track the addresses of the function. I personally do not see much use in
this filter for module callbacks, but if that's a use case, we can think
on how to do that. But notice that the current implementation of the
filter wont hold if we end-up following the suggestions in this thread,
not sure even if we're gonna have a filter...

Cheers,


Guilherme

