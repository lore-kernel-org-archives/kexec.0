From: Guilherme G. Piccoli <gpiccoli@igalia.com>
Date: Mon, 7 Mar 2022 10:11:41 -0300
Subject: [PATCH V4] notifier/panic: Introduce panic_notifier_filter
In-Reply-To: <YiV/HbXftVF2iAvU@MiWiFi-R3L-srv>
References: <20220108153451.195121-1-gpiccoli@igalia.com>
 <TYAPR01MB6507D06BA6D32218F6E88198955F9@TYAPR01MB6507.jpnprd01.prod.outlook.com>
 <fda509a5-ea0d-4d1d-a1c1-ca5e80010fc0@igalia.com>
 <TYAPR01MB6507D9747647685B554B8F8F955F9@TYAPR01MB6507.jpnprd01.prod.outlook.com>
 <fb5e66b6-049a-22ab-5913-a04cc302b629@igalia.com> <YfPxvzSzDLjO5ldp@alley>
 <73011b6f-084b-43f5-cc01-1818a8a57e56@igalia.com>
 <YiV/HbXftVF2iAvU@MiWiFi-R3L-srv>
Message-ID: <e1033adc-46ff-5dbc-e739-1bf725b6fed0@igalia.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 07/03/2022 00:42, bhe at redhat.com wrote:
> [...]
>> Let me know your thoughts Petr / Baoquan - it would add slightly more
>> code / complexity, but in my opinion the payback is very good.
>> Cheers,
> 
> The ideal situation is each panic notifier has an order or index to
> indicate its priority. Wondering how to make it. What I think of is
> copying initcall. We have several priorities, at the same priority,
> execution sequence is not important. Not sure if I get your point.
> 
> ~~~~~~~
> #define core_initcall(fn)               __define_initcall(fn, 1)
> #define core_initcall_sync(fn)          __define_initcall(fn, 1s)
> ......
> #define late_initcall(fn)               __define_initcall(fn, 7)
> #define late_initcall_sync(fn)          __define_initcall(fn, 7s)
> 

Hi Baoquan, thanks for you consideration! In fact, the notifiers
infrastructure already have a mechanism of ordering, my idea is to make
use of that. It's not that different from the initcall system...

For instance, the code in the notifier register function checks for the
priority field in the notifier block:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/notifier.c#n31
.

For example, the Xen panic notifier is one of the few blocks that make
use of that, currently:

static struct notifier_block xen_panic_block = {
	.notifier_call = xen_panic_event,
	.priority = INT_MIN
};

(see
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/xen/enlighten.c#n286)

In this case, xen_panic_event() will be the latest one to run. My idea
is to make use of that in *all* panic notifiers, having a table/list on
panic_notifier.h (defines or enum, I'll think about that when writing
this part) so all notifiers are documented and the ordering is clear and
enforced.

Makes sense to you?
Cheers,


Guilherme

