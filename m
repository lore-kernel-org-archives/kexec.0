From: Guilherme G. Piccoli <gpiccoli@igalia.com>
Date: Wed, 18 May 2022 10:16:20 -0300
Subject: [PATCH 19/30] panic: Add the panic hypervisor notifier list
In-Reply-To: <YoSnGmBJ3kYs5WMf@alley>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
 <20220427224924.592546-20-gpiccoli@igalia.com> <YoJZVZl/MH0KiE/J@alley>
 <ad082ce7-db50-13bb-3dbb-9b595dfa78be@igalia.com> <YoOpyW1+q+Z5as78@alley>
 <YoSnGmBJ3kYs5WMf@alley>
Message-ID: <fbbd0a8d-2ef4-4a39-4b75-354918e85778@igalia.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 18/05/2022 04:58, Petr Mladek wrote:
> [...]
>> I does similar things like kmsg_dump() so it should be called in
>> the same location (after info notifier list and before kdump).
>>
>> A solution might be to put it at these notifiers at the very
>> end of the "info" list or make extra "dump" notifier list.
> 
> I just want to point out that the above idea has problems.
> Notifiers storing kernel log need to be treated as kmsg_dump().
> In particular, we would  need to know if there are any.
> We do not need to call "info" notifier list before kdump
> when there is no kernel log dumper registered.
> 

Notifiers respect the priority concept, which is just a number that
orders the list addition (and the list is called in order).

I've used the last position to panic_print() [in patch 25] - one idea
here is to "reserve" the last position (represented by INT_MIN) for
notifiers that act like kmsg_dump(). I couldn't find any IIRC, but that
doesn't prevent us to save this position and comment about that.

Makes sense to you ?
Cheers!

