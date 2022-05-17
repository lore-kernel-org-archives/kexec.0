From: Guilherme G. Piccoli <gpiccoli@igalia.com>
Date: Tue, 17 May 2022 12:19:02 -0300
Subject: [PATCH 14/30] panic: Properly identify the panic event to the
 notifiers' callbacks
In-Reply-To: <YoOe7ifxfW8CEHdt@alley>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
 <20220427224924.592546-15-gpiccoli@igalia.com> <YnqBsXBImU64PAOL@alley>
 <244a412c-4589-28d1-bb77-d3648d4f0b12@igalia.com> <YoOe7ifxfW8CEHdt@alley>
Message-ID: <bc485d09-0958-0ddc-7b2d-cbc806cf6a01@igalia.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 17/05/2022 10:11, Petr Mladek wrote:
> [...]
>> You mentioned 2 cases:
>>
>> (a) Same notifier_list used in different situations;
>>
>> (b) Same *notifier callback* used in different lists;
>>
>> Mine is case (b), right? Can you show me an example of case (a)?
> 
> There are many examples of case (a):
> 
> [... snip ...] 
> These all call the same list/chain in different situations.
> The situation is distinguished by @val.
> 
> 
>> You can see in the following patches (or grep the kernel) that people are using
>> this identification parameter to determine which kind of OOPS trigger
>> the callback to condition the execution of the function to specific
>> cases.
> 
> Could you please show me some existing code for case (b)?
> I am not able to find any except in your patches.
> 

Hi Petr, thanks for the examples - I agree with you. In the end, seems
I'm kind of abusing the API. This id is used to distinguish different
situations in which the callback is called, but in the same
"realm"/notifier list.

In my case I have different list calling the same callback and
(ab-)using the id to make distinction. I can rework the patches using
pointer comparison, it's fine =)

So, I'll drop this patch in V2.

> Anyway, the solution in 16th patch is bad, definitely.
> hv_die_panic_notify_crash() uses "val" to disinguish
> both:
> 
>      + "panic_notifier_list" vs "die_chain"
>      + die_val when callen via "die_chain"
> 
> The API around "die_chain" API is not aware of enum panic_notifier_val
> and the API using "panic_notifier_list" is not aware of enum die_val.
> As I said, it is mixing apples and oranges and it is error prone.
> 

OK, I'll re-work that patch - there's more there to be changed, that one
is complex heheh

Cheers!

