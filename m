From: Guilherme G. Piccoli <gpiccoli@igalia.com>
Date: Thu, 13 Jan 2022 09:34:01 -0300
Subject: [PATCH V2] panic: Move panic_print before kmsg dumpers
In-Reply-To: <Yd/0K1x7ILw3Qa46@alley>
References: <20220106212835.119409-1-gpiccoli@igalia.com>
 <Yd/0K1x7ILw3Qa46@alley>
Message-ID: <ba0e29ba-0e08-df6e-ade5-eb58ae2495e3@igalia.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 13/01/2022 08:50, Petr Mladek wrote:
>> @@ -249,7 +252,7 @@ void panic(const char *fmt, ...)
>>  	 * show some extra information on kernel log if it was set...
>>  	 */
>>  	if (kexec_crash_loaded())
>> -		panic_print_sys_info();
>> +		panic_print_sys_info(false);
> 
> panic_print_sys_info(false) will be called twice when both
> kexec_crash_loaded() and _crash_kexec_post_notifiers are true.
> 
> Do we really need to call panic_print_sys_info() here? All information
> provided by panic_print_sys_info(false) can be found also in
> the crash dump.
> 
>>  	/*
>>  	 * If we have crashed and we have a crash kernel loaded let it handle
>> @@ -283,6 +286,8 @@ void panic(const char *fmt, ...)
>>  	 */
>>  	atomic_notifier_call_chain(&panic_notifier_list, 0, buf);
>>  
>> +	panic_print_sys_info(false);
> 
> This is where the info might be printed 2nd time.
> 
>> +
>>  	kmsg_dump(KMSG_DUMP_PANIC);
>>  
>>  	/*
> 
> Otherwise, the change makes sense to me.
> 
> Best Regards,
> Petr

Hi Petr, thanks for your great review!
I see you also commented in the thread of the patch introducing the
panic_print_sys_info() before kdump.

Thanks for catching this issue - indeed, if
"_crash_kexec_post_notifiers" is true, with this patch we print stuff
twice. I will submit a V3 that guards against that, using a bool, makes
sense to you?

The interesting question here is:
> Do we really need to call panic_print_sys_info() here? All information
> provided by panic_print_sys_info(false) can be found also in
> the crash dump.

So, we indeed need that in our use case. Crash is meant to be used
post-mortem, i.e., you made a full vmcore collection and then, of
course, you have basically all the data you need accessible though the
crash tool.

Problem is: in our use case, we want more data than a regular dmesg in a
panic event (hence we use panic_print), but we don't collect a full
crash dump, due to its big size. Also, as you can imagine, we do favor
pstore over kdump, but it might fail due to a variety of reasons (like
not having a free RAM buffer for ramoops), so kdump is our fallback.
Hence, we'd like to be able to use panic_print with both kdump and
pstore, and for that, both patches are needed.

Cheers,


Guilherme

