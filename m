From: Guilherme G. Piccoli <gpiccoli@igalia.com>
Date: Thu, 6 Jan 2022 18:05:09 -0300
Subject: [PATCH V2] notifier/panic: Introduce panic_notifier_filter
In-Reply-To: <YddQOFye7Rhr9NDl@rowland.harvard.edu>
References: <20220106200007.112357-1-gpiccoli@igalia.com>
 <YddQOFye7Rhr9NDl@rowland.harvard.edu>
Message-ID: <4e416d20-13f2-25ea-6ff7-b8c0c1818eac@igalia.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 06/01/2022 17:25, Alan Stern wrote:
> [...]
>> +	if (unlikely(panic_nf_count) && nh == &panic_notifier_list)
>> +		if (!is_panic_notifier_filtered(n))
>> +			goto panic_filtered_out;
> 
> Forget the unlikely(); this is not a hot path.
> 

Thanks for the review Alan! Sure, I can remove that in the V3 - good point.


>> +
>>  	ret = notifier_chain_register(&nh->head, n);
>> +
>> +panic_filtered_out:
>>  	spin_unlock_irqrestore(&nh->lock, flags);
>>  	return ret;
>>  }
> 
> It would be simpler to do:
> 
> 	if (!(nh == &panic_notifier_list && panic_nf_count > 0 &&
> 			is_panic_notifier_filtered(n)))
> 		ret = notifier_chain_register(&nh->head, n);
> 
> If there were special-purpose functions just for registering and 
> unregistering callbacks on the panic_notifier_list, the design would be 
> cleaner (no need to modify core notifier code).  But making that change 
> would mean altering a lot of call sites.  :-(
> 

Good suggestion, I'll change the code with your suggestion in the V3.

And I agree, I considered something like that when writing this "hijack"
into core code just for the sake of panic notifier filtering...
I'm not sure though it worth the effort and code addition, to change all
the call sites and add a special register mechanism to the panic
notifier only. Let's see what the others think...

Cheers,


Guilherme


>> @@ -162,10 +194,16 @@ int atomic_notifier_chain_unregister(struct atomic_notifier_head *nh,
>>  		struct notifier_block *n)
>>  {
>>  	unsigned long flags;
>> -	int ret;
>> +	int ret = 0;
>>  
>>  	spin_lock_irqsave(&nh->lock, flags);
>> +	if (unlikely(panic_nf_count) && nh == &panic_notifier_list)
>> +		if (!is_panic_notifier_filtered(n))
>> +			goto panic_filtered_out;
>> +
>>  	ret = notifier_chain_unregister(&nh->head, n);
>> +
>> +panic_filtered_out:
> 
> Same idea here.
> 
> Alan Stern
> 

