From: Guilherme G. Piccoli <gpiccoli@igalia.com>
Date: Mon, 16 May 2022 13:05:44 -0300
Subject: [PATCH 21/30] panic: Introduce the panic pre-reboot notifier list
In-Reply-To: <YoJgcC8c6LaKADZV@alley>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
 <20220427224924.592546-22-gpiccoli@igalia.com> <YoJgcC8c6LaKADZV@alley>
Message-ID: <63a74b56-89ef-8d1f-d487-cdb986aab798@igalia.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Thanks again for the review! Comments inline below:


On 16/05/2022 11:33, Petr Mladek wrote:
> [...]
>> --- a/drivers/edac/altera_edac.c
>> +++ b/drivers/edac/altera_edac.c
>> @@ -2163,7 +2162,7 @@ static int altr_edac_a10_probe(struct platform_device *pdev)
>>  		int dberror, err_addr;
>>  
>>  		edac->panic_notifier.notifier_call = s10_edac_dberr_handler;
>> -		atomic_notifier_chain_register(&panic_notifier_list,
>> +		atomic_notifier_chain_register(&panic_pre_reboot_list,
> 
> My understanding is that this notifier first prints info about ECC
> errors and then triggers reboot. It might make sense to split it
> into two notifiers.

I disagree here - looping the maintainers for comments (CCing Dinh /
Tony). BTW, sorry for not having you on CC already Dinh, it was my mistake.

So, my reasoning here is: this notifier should fit the info list,
definitely! But...it's very high risk for kdump. It deep dives into the
regmap API (there are locks in such code) plus there is an (MM)IO write
to the device and an ARM firmware call. So, despite the nature of this
notifier _fits the informational list_, the _code is risky_ so we should
avoid running it before a kdump.

Now, we indeed have a chicken/egg problem: want to avoid it before
kdump, BUT in case kdump is not set, kmsg_dump() (and console flushing,
after your suggestion Petr) will run before it and not save collected
information from EDAC PoV.

My idea: I could call a second kmsg_dump() or at least a panic console
flush for within such notifier. Let me know what you think Petr (also
Dinh / Tony and all interested parties).


> [...] 
>> --- a/drivers/leds/trigger/ledtrig-panic.c
>> +++ b/drivers/leds/trigger/ledtrig-panic.c
>> @@ -64,7 +63,7 @@ static long led_panic_blink(int state)
>>  
>>  static int __init ledtrig_panic_init(void)
>>  {
>> -	atomic_notifier_chain_register(&panic_notifier_list,
>> +	atomic_notifier_chain_register(&panic_pre_reboot_list,
>>  				       &led_trigger_panic_nb);
> 
> Blinking => should go to the last "post_reboot/loop" list.
> [...] 
>> --- a/drivers/misc/ibmasm/heartbeat.c
>> +++ b/drivers/misc/ibmasm/heartbeat.c
>> @@ -32,20 +31,23 @@ static int suspend_heartbeats = 0;
>>  static int panic_happened(struct notifier_block *n, unsigned long val, void *v)
>>  {
>>  	suspend_heartbeats = 1;
>> -	return 0;
>> +	return NOTIFY_DONE;
>>  }
>>  
>> -static struct notifier_block panic_notifier = { panic_happened, NULL, 1 };
>> +static struct notifier_block panic_notifier = {
>> +	.notifier_call = panic_happened,
>> +};
>>  
>>  void ibmasm_register_panic_notifier(void)
>>  {
>> -	atomic_notifier_chain_register(&panic_notifier_list, &panic_notifier);
>> +	atomic_notifier_chain_register(&panic_pre_reboot_list,
>> +					&panic_notifier);
> 
> Same here. Blinking => should go to the last "post_reboot/loop" list.

Ack on both.

IBMasm is not blinking IIUC, but still fits properly the loop list. This
notifier would make a heartbeat mechanism stop, and once it's stopped,
service processor is allowed to reboot - that's my understanding.


Cheers,


Guilherme

