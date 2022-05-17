From: Guilherme G. Piccoli <gpiccoli@igalia.com>
Date: Tue, 17 May 2022 13:42:06 -0300
Subject: [PATCH 19/30] panic: Add the panic hypervisor notifier list
In-Reply-To: <YoOpyW1+q+Z5as78@alley>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
 <20220427224924.592546-20-gpiccoli@igalia.com> <YoJZVZl/MH0KiE/J@alley>
 <ad082ce7-db50-13bb-3dbb-9b595dfa78be@igalia.com> <YoOpyW1+q+Z5as78@alley>
Message-ID: <d72b9aab-675c-ac89-b73a-b1de4a0b722d@igalia.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 17/05/2022 10:57, Petr Mladek wrote:
> [...]
>>>> --- a/drivers/misc/bcm-vk/bcm_vk_dev.c
>>>> +++ b/drivers/misc/bcm-vk/bcm_vk_dev.c
>>>> @@ -1446,7 +1446,7 @@ static int bcm_vk_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>>> [... snip ...]
>>> It seems to reset some hardware or so. IMHO, it should go into the
>>> pre-reboot list.
>>
>> Mixed feelings here, I'm looping Broadcom maintainers to comment.
>> (CC Scott and Broadcom list)
>>
>> I'm afraid it breaks kdump if this device is not reset beforehand - it's
>> a doorbell write, so not high risk I think...
>>
>> But in case the not-reset device can be probed normally in kdump kernel,
>> then I'm fine in moving this to the reboot list! I don't have the HW to
>> test myself.
> 
> Good question. Well, it if has to be called before kdump then
> even "hypervisor" list is a wrong place because is not always
> called before kdump.

Agreed! I'll defer that to Scott and Broadcom folks to comment.
If it's not strictly necessary, I'll happily move it to the reboot list.

If necessary, we could use the machine_crash_kexec() approach, but we'll
fall into the case arm64 doesn't support it and I'm not sure if this
device is available for arm - again a question for the maintainers.


>  [...]
>>>> --- a/drivers/power/reset/ltc2952-poweroff.c
>>>> +++ b/drivers/power/reset/ltc2952-poweroff.c
>> [...]
>> This is setting a variable only, and once it's set (data->kernel_panic
>> is the bool's name), it just bails out the IRQ handler and a timer
>> setting - this timer seems kinda tricky, so bailing out ASAP makes sense
>> IMHO.
> 
> IMHO, the timer informs the hardware that the system is still alive
> in the middle of panic(). If the timer is not working then the
> hardware (chip) will think that the system frozen in panic()
> and will power off the system. See the comments in
> drivers/power/reset/ltc2952-poweroff.c:
> [.... snip ...]
> IMHO, we really have to keep it alive until we reach the reboot stage.
> 
> Another question is how it actually works when the interrupts are
> disabled during panic() and the timer callbacks are not handled.

Agreed here! Guess I can move this one the reboot list, fine by me.
Unless PM folks think otherwise.


> [...]
>> Disagree here, I'm CCing Florian for information.
>>
>> This notifier preserves RAM so it's *very interesting* if we have
>> kmsg_dump() for example, but maybe might be also relevant in case kdump
>> kernel is configured to store something in a persistent RAM (then,
>> without this notifier, after kdump reboots the system data would be lost).
> 
> I see. It is actually similar problem as with
> drivers/firmware/google/gsmi.c.
> 
> I does similar things like kmsg_dump() so it should be called in
> the same location (after info notifier list and before kdump).
> 
> A solution might be to put it at these notifiers at the very
> end of the "info" list or make extra "dump" notifier list.

Here I still disagree. I've commented in the other response thread
(about Google gsmi) about the semantics of the hypervisor list, but
again: this list should contain callbacks that

(a) Should run early, _by default_ before a kdump;
(b) Communicate with the firmware/hypervisor in a "low-risk" way;

Imagine a scenario where users configure kdump kernel to save something
in a persistent form in DRAM - it'd be like a late pstore, in the next
kernel. This callback enables that, it's meant to inform FW "hey, panic
happened, please from now on don't clear the RAM in the next FW-reboot".
I don't see a reason to postpone that - let's see if the maintainers
have an opinion.

Cheers,


Guilherme

