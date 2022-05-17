From: Guilherme G. Piccoli <gpiccoli@igalia.com>
Date: Tue, 17 May 2022 15:12:25 -0300
Subject: [PATCH 21/30] panic: Introduce the panic pre-reboot notifier list
In-Reply-To: <06d85642fef24bc482642d669242654b@intel.com>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
 <20220427224924.592546-22-gpiccoli@igalia.com> <YoJgcC8c6LaKADZV@alley>
 <63a74b56-89ef-8d1f-d487-cdb986aab798@igalia.com>
 <bed66b9467254a5a8bafc1983dad643a@intel.com>
 <e895ce94-e6b9-caf6-e5d3-06bf0149445c@igalia.com> <YoOs9GJ5Ovq63u5Q@alley>
 <599b72f6-76a4-8e6d-5432-56fb1ffd7e0b@igalia.com>
 <06d85642fef24bc482642d669242654b@intel.com>
Message-ID: <62a63fc2-346f-f375-043a-fa21385279df@igalia.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 17/05/2022 14:02, Luck, Tony wrote:
>> Tony / Dinh - can I just *skip* this notifier *if kdump* is set or else
>> we run the code as-is? Does that make sense to you?
> 
> The "skip" option sounds like it needs some special flag associated with
> an entry on the notifier chain. But there are other notifier chains ... so that
> sounds messy to me.
> 
> Just all the notifiers in priority order. If any want to take different actions
> based on kdump status, change the code. That seems more flexible than
> an "all or nothing" approach by skipping.
> 
> -Tony

I guess I've expressed myself in a poor way - sorry!

What I'm planning to do in the altera_edac notifier is:

if (kdump_is_set)
 return;

/* regular code */

In other words: if the kdump is set, this notifier will be effectively a
nop (although it's gonna be called).

Lemme know your thoughts Tony, if that makes sense.
Thanks,


Guilherme

