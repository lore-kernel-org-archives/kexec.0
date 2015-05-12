Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail4.hitachi.co.jp ([133.145.228.5])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Ys5mm-0004c8-Ix
 for kexec@lists.infradead.org; Tue, 12 May 2015 08:43:33 +0000
Message-ID: <5551BD17.6040606@hitachi.com>
Date: Tue, 12 May 2015 17:43:03 +0900
From: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
MIME-Version: 1.0
Subject: Re: Re: Re: [PATCH v2] kernel/panic/kexec: fix
 "crash_kexec_post_notifiers" option issue in oops path
References: <54F9D645.2050008@jp.fujitsu.com>
 <20150323034752.GD2068@dhcp-16-105.nay.redhat.com>
 <20150323071943.GA22765@gmail.com> <5510DA42.6040708@hitachi.com>
 <20150324071129.GA28619@gmail.com> <20150324144608.GB2970@redhat.com>
 <20150324161814.GB8661@gmail.com> <20150324170417.GA5030@redhat.com>
In-Reply-To: <20150324170417.GA5030@redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, =?UTF-8?B?IkhhdGF5YW1hLCBEYWlzdWtlL+eVkeWxsQ==?= =?UTF-8?B?IOWkp+i8lCI=?= <d.hatayama@jp.fujitsu.com>, mingo@redhat.com, ebiederm@xmission.com, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, akpm@linux-foundation.org, bp@suse.de, Ingo Molnar <mingo@kernel.org>

Hi all,

What is the current status of this bug fix patch?
I think it's OK if resending Hatayama-san's patch with Ingo's.

Thanks,

(2015/03/25 2:04), Vivek Goyal wrote:
> On Tue, Mar 24, 2015 at 05:18:14PM +0100, Ingo Molnar wrote:
>>
>> * Vivek Goyal <vgoyal@redhat.com> wrote:
>>
>>>> Yet the actual bug is in that commit, 'crash_kexec_post_notifiers' 
>>>> was clearly not a no-op in the default case, against expectations.
>>>
>>> Hi Ingo,
>>>
>>> I did a quick test and in default case crash_kexec() runs before 
>>> panic notifiers. So it does look like crash_kexec_post_notifiers is 
>>> a no-op in default case.
>>>
>>> What am I missing.
>>
>> Well, look at f06e5153f4ae:
>>
>> diff --git a/kernel/panic.c b/kernel/panic.c
>> index d02fa9fef46a..62e16cef9cc2 100644
>> --- a/kernel/panic.c
>> +++ b/kernel/panic.c
>> @@ -32,6 +32,7 @@ static unsigned long tainted_mask;
>>  static int pause_on_oops;
>>  static int pause_on_oops_flag;
>>  static DEFINE_SPINLOCK(pause_on_oops_lock);
>> +static bool crash_kexec_post_notifiers;
>>  
>>  int panic_timeout = CONFIG_PANIC_TIMEOUT;
>>  EXPORT_SYMBOL_GPL(panic_timeout);
>> @@ -112,9 +113,11 @@ void panic(const char *fmt, ...)
>>  	/*
>>  	 * If we have crashed and we have a crash kernel loaded let it handle
>>  	 * everything else.
>> -	 * Do we want to call this before we try to display a message?
>> +	 * If we want to run this after calling panic_notifiers, pass
>> +	 * the "crash_kexec_post_notifiers" option to the kernel.
>>  	 */
>> -	crash_kexec(NULL);
>> +	if (!crash_kexec_post_notifiers)
>> +		crash_kexec(NULL);
>>  
>>  	/*
>>  	 * Note smp_send_stop is the usual smp shutdown function, which
>> @@ -131,6 +134,15 @@ void panic(const char *fmt, ...)
>>  
>>  	kmsg_dump(KMSG_DUMP_PANIC);
>>  
>> +	/*
>> +	 * If you doubt kdump always works fine in any situation,
>> +	 * "crash_kexec_post_notifiers" offers you a chance to run
>> +	 * panic_notifiers and dumping kmsg before kdump.
>> +	 * Note: since some panic_notifiers can make crashed kernel
>> +	 * more unstable, it can increase risks of the kdump failure too.
>> +	 */
>> +	crash_kexec(NULL);
>> +
>>  	bust_spinlocks(0);
>>  
>>  	if (!panic_blink)
>>
>>
>> Without knowing what crash_kexec() does, the patch looks buggy: it 
>> should preserve the old behavior by default, yet it will now execute a 
>> second crash_kexec() after the kmsg_dump() line.
>>
>> So the invariant change would have been to do:
>>
>> -	crash_kexec(NULL);
>> +	if (!crash_kexec_post_notifiers)
>> +		crash_kexec(NULL);
>>
>> ...
>>
>> +	if (crash_kexec_post_notifiers)
>> +		crash_kexec(NULL);
>>
>> Which in the !crash_kexec_post_notifiers flag case reduces to:
>>
>> 	crash_kexec();
>>
>> 	...
>>
>> 	/* NOP */
>>
>> I.e. to exactly what the kernel was doing without the patch 
>> originally.
>>
>> Which is what my patch does. Nothing more, nothing less.
> 
> Ok, I got it what you mean.
> 
> crash_kexec() does not return if a kdump kernel is loaded. If kdump
> kernel is not loaded, then crash_kexec() returns without doing anything.
> 
> I think that explains why not making second call to crash_kexec() under
> if, did not create problems. In first case it will never be called and
> in second case, it will do nothing and simply return back.
> 
> But anyway, we need your patch as that's right thing to do.
> 
> Thanks
> Vivek
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 


-- 
Hidehiro Kawai
Hitachi, Ltd. Research & Development Group



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
