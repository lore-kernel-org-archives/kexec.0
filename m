From: Guilherme G. Piccoli <gpiccoli@igalia.com>
Date: Tue, 17 May 2022 13:37:58 -0300
Subject: [PATCH 19/30] panic: Add the panic hypervisor notifier list
In-Reply-To: <YoOi9PFK/JnNwH+D@alley>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
 <20220427224924.592546-20-gpiccoli@igalia.com> <YoJZVZl/MH0KiE/J@alley>
 <ad082ce7-db50-13bb-3dbb-9b595dfa78be@igalia.com>
 <CAE=gft7ds+dHfEkRz8rnSH1EbTpGTpKbi5Wxj9DW0Jr5mX_j4w@mail.gmail.com>
 <YoOi9PFK/JnNwH+D@alley>
Message-ID: <b9ec2fc8-216f-f261-8417-77b6dd95e25c@igalia.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 17/05/2022 10:28, Petr Mladek wrote:
> [...]
>>> Disagree here. I'm looping Google maintainers, so they can comment.
>>> (CCed Evan, David, Julius)
>>>
>>> This notifier is clearly a hypervisor notification mechanism. I've fixed
>>> a locking stuff there (in previous patch), I feel it's low-risk but even
>>> if it's mid-risk, the class of such callback remains a perfect fit with
>>> the hypervisor list IMHO.
>>
>> This logs a panic to our "eventlog", a tiny logging area in SPI flash
>> for critical and power-related events. In some cases this ends up
>> being the only clue we get in a Chromebook feedback report that a
>> panic occurred, so from my perspective moving it to the front of the
>> line seems like a good idea.
> 
> IMHO, this would really better fit into the pre-reboot notifier list:
> 
>    + the callback stores the log so it is similar to kmsg_dump()
>      or console_flush_on_panic()
> 
>    + the callback should be proceed after "info" notifiers
>      that might add some other useful information.
> 
> Honestly, I am not sure what exactly hypervisor callbacks do. But I
> think that they do not try to extract the kernel log because they
> would need to handle the internal format.
> 

I guess the main point in your response is : "I am not sure what exactly
hypervisor callbacks do". We need to be sure about the semantics of such
list, and agree on that.

So, my opinion about this first list, that we call "hypervisor list",
is: it contains callbacks that

(1) should run early, preferably before kdump (or even if kdump isn't
set, should run ASAP);

(2) these callbacks perform some communication with an abstraction that
runs "below" the kernel, like a firmware or hypervisor. Classic example:
pvpanic, that communicates with VMM (usually qemu) and allow such VMM to
snapshot the full guest memory, for example.

(3) Should be low-risk. What defines risk is the level of reliability of
subsequent operations - if the callback have 50% of chance of "bricking"
the system totally and prevent kdump / kmsg_dump() / reboot , this is
high risk one for example.

Some good fits IMO: pvpanic, sstate_panic_event() [sparc], fadump in
powerpc, etc.

So, this is a good case for the Google notifier as well - it's not
collecting data like the dmesg (hence your second bullet seems to not
apply here, info notifiers won't add info to be collected by gsmi). It
is a firmware/hypervisor/whatever-gsmi-is notification mechanism, that
tells such "lower" abstraction a panic occurred. It seems low risk and
we want it to run ASAP, if possible.

So, I'd like to keep it here, unless gsmi maintainers disagree or I'm
perhaps misunderstanding the meaning of this first list.
Cheers,


Guilherme

