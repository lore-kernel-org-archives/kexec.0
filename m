From: Guilherme G. Piccoli <gpiccoli@igalia.com>
Date: Wed, 19 Jan 2022 13:03:15 -0300
Subject: [PATCH V3] panic: Move panic_print before kmsg dumpers
In-Reply-To: <YegytkfED+QI56Y8@alley>
References: <20220114183046.428796-1-gpiccoli@igalia.com>
 <20220119071318.GA4977@MiWiFi-R3L-srv> <YegytkfED+QI56Y8@alley>
Message-ID: <94bb12a2-a788-cee6-7d4f-dc0ac581fb39@igalia.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Thanks again Petr, for the deep analysis! Much appreciated.
Some comments inline below:


On 19/01/2022 12:48, Petr Mladek wrote:
>[...]
> From my POV, the function of panic notifiers is not well defined. They
> do various things, for example:
> [...] 
> 
> The do more that just providing information. Some are risky. It is not
> easy to disable a particular one.

We are trying to change that here:
https://lore.kernel.org/lkml/20220108153451.195121-1-gpiccoli at igalia.com/

Your review/comments are very welcome =)


> [...] 
> It might make sense to allow to call kmsg_dump before panic notifiers
> to reduce the risk of a breakage. But I do not have enough experience
> with them to judge this.
> 
> I can't remember any bug report in this code. I guess that only
> few people use kmsg_dump.

One of the problems doing that is that RCU and hung task detector, for
example, have panic notifiers to disable themselves in the panic
scenario - if we kmsg_dump() _before_ the panic notifiers, we may have
intermixed messages, all messy...so for me it makes sense to keep the
kmsg_dump() after panic notifiers.


> [...]
> Yes, panic_print_sys_info() increases the risk that the crash dump
> will not succeed. But the change makes sense because:
> 
>   + panic_print_sys_info() does nothing by default. Most users will
>     not enable it together with crash dump.
> 
>   + Guilherme uses crash dump only to dump the kernel log. It might
>     be more reliable than kmsg_dump. In this case, panic_print_sys_info()
>     is the only way to get the extra information.
> 
>   + panic_print_sys_info() might be useful even with full crash dump.
>     For example, ftrace messages are not easy to read from the memory
>     dump.

The last point is really good, I didn't consider that before but makes a
lot of sense - we can now dump (a hopefully small!) ftrace/event trace
buffer to dmesg before a kdump, making it pretty easy to read that later.
Cheers,


Guilherme

