Return-path: <kexec-bounces@lists.infradead.org>
Received: from tyo200.gate.nec.co.jp ([210.143.35.50])
	by pentafluge.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IkxhQ-0006G7-9t
	for kexec@lists.infradead.org; Thu, 25 Oct 2007 09:04:19 +0100
Received: from tyo202.gate.nec.co.jp ([10.7.69.202])
	by tyo200.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id l9P8044X015882
	for <kexec@lists.infradead.org>; Thu, 25 Oct 2007 17:02:13 +0900 (JST)
Message-ID: <47204CFF.50709@ah.jp.nec.com>
Date: Thu, 25 Oct 2007 16:59:59 +0900
From: Takenori Nagano <t-nagano@ah.jp.nec.com>
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] implement new notifier function to panic_notifier_list
	,take2
References: <4716FFDB.7090502@ah.jp.nec.com>	<47171EEF.7030109@ah.jp.nec.com>
	<20071024111100.0f5d8b58.rdunlap@xenotime.net>
In-Reply-To: <20071024111100.0f5d8b58.rdunlap@xenotime.net>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces@lists.infradead.org
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: k-miyoshi@cb.jp.nec.com, Bernhard Walle <bwalle@suse.de>, kdb@oss.sgi.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, vgoyal@in.ibm.com, "Eric W. Biederman" <ebiederm@xmission.com>, Keith Owens <kaos@ocs.com.au>, Andrew Morton <akpm@linux-foundation.org>

Randy Dunlap wrote:
> On Thu, 18 Oct 2007 17:53:03 +0900 Takenori Nagano wrote:
> 
>> This patch implements new notifier function to panic_notifier_list. We can
>> change the list of order by debugfs.
> 
> Should be sysfs IMO.  debugfs isn't (should not be) required.

OK. We try to find an appropriate place.
http://lkml.org/lkml/2007/10/24/54

>> Thanks,
>>
>> ---
>>
>> Signed-off-by: Takenori Nagano <t-nagano@ah.jp.nec.com>
>>
>> ---
>> diff -uprN linux-2.6.23.orig/arch/alpha/kernel/setup.c linux-2.6.23/arch/alpha/kernel/setup.c
>> --- linux-2.6.23.orig/arch/alpha/kernel/setup.c	2007-10-10 05:31:38.000000000 +0900
>> +++ linux-2.6.23/arch/alpha/kernel/setup.c	2007-10-18 08:56:53.928000000 +0900
>> @@ -45,14 +45,22 @@
>>  #include <asm/io.h>
>>  #include <linux/log2.h>
>>  
>> -extern struct atomic_notifier_head panic_notifier_list;
>> +extern struct tunable_atomic_notifier_head panic_notifier_list;
>>  static int alpha_panic_event(struct notifier_block *, unsigned long, void *);
>> -static struct notifier_block alpha_panic_block = {
>> +static struct notifier_block alpha_panic_block_base = {
>>  	alpha_panic_event,
>>          NULL,
>>          INT_MAX /* try to do it first */
>>  };
>>  
>> +static struct tunable_atomic_notifier_block alpha_panic_block = {
>> +	&alpha_panic_block_base,
> 
> Use C99-style initializer.  and NULLs aren't needed.

OK. I'll fix.

Thanks,
  Takenori

> 
>> +	NULL,
>> +	NULL,
>> +	NULL,
>> +	NULL
>> +};
>> +
>>  #include <asm/uaccess.h>
>>  #include <asm/pgtable.h>
>>  #include <asm/system.h>
> 
>> diff -uprN linux-2.6.23.orig/arch/arm/mach-omap1/board-voiceblue.c linux-2.6.23/arch/arm/mach-omap1/board-voiceblue.c
>> --- linux-2.6.23.orig/arch/arm/mach-omap1/board-voiceblue.c	2007-10-10 05:31:38.000000000 +0900
>> +++ linux-2.6.23/arch/arm/mach-omap1/board-voiceblue.c	2007-10-18 09:00:35.900000000 +0900
>> @@ -228,14 +228,23 @@ static int panic_event(struct notifier_b
>>  	return NOTIFY_DONE;
>>  }
>>  
>> -static struct notifier_block panic_block = {
>> +static struct notifier_block panic_block_base = {
>>  	.notifier_call	= panic_event,
>>  };
>>  
>> +static struct tunable_atomic_notifier_block panic_block = {
>> +	.nb		= &panic_block_base,
>> +	.head		= NULL,
>> +	.dir		= NULL,
>> +	.pri_dentry	= NULL,
>> +	.desc_dentry	= NULL
> 
> Drop the NULLs.
> 
>> +};
>> +
>>  static int __init voiceblue_setup(void)
>>  {
>>  	/* Setup panic notifier */
>> -	notifier_chain_register(&panic_notifier_list, &panic_block);
>> +	tunable_atomic_notifier_chain_register(&panic_notifier_list,
>> +					       &panic_block, "VoiceBlue", NULL);
>>  
>>  	return 0;
>>  }
>> diff -uprN linux-2.6.23.orig/arch/mips/sgi-ip22/ip22-reset.c linux-2.6.23/arch/mips/sgi-ip22/ip22-reset.c
>> --- linux-2.6.23.orig/arch/mips/sgi-ip22/ip22-reset.c	2007-10-10 05:31:38.000000000 +0900
>> +++ linux-2.6.23/arch/mips/sgi-ip22/ip22-reset.c	2007-10-18 09:01:33.408000000 +0900
>> @@ -226,10 +226,18 @@ static int panic_event(struct notifier_b
>>  	return NOTIFY_DONE;
>>  }
>>  
>> -static struct notifier_block panic_block = {
>> +static struct notifier_block panic_block_base = {
>>  	.notifier_call	= panic_event,
>>  };
>>  
>> +static struct tunable_atomic_notifier_block panic_block = {
>> +	.nb		= &panic_block_base,
>> +	.head		= NULL,
>> +	.dir		= NULL,
>> +	.pri_dentry	= NULL,
>> +	.desc_dentry	= NULL
> 
> Ditto.
> 
>> +};
>> +
>>  static int __init reboot_setup(void)
>>  {
>>  	_machine_restart = sgi_machine_restart;
> 
>> diff -uprN linux-2.6.23.orig/arch/mips/sgi-ip32/ip32-reset.c linux-2.6.23/arch/mips/sgi-ip32/ip32-reset.c
>> --- linux-2.6.23.orig/arch/mips/sgi-ip32/ip32-reset.c	2007-10-10 05:31:38.000000000 +0900
>> +++ linux-2.6.23/arch/mips/sgi-ip32/ip32-reset.c	2007-10-18 09:02:20.496000000 +0900
>> @@ -175,10 +175,18 @@ static int panic_event(struct notifier_b
>>  	return NOTIFY_DONE;
>>  }
>>  
>> -static struct notifier_block panic_block = {
>> +static struct notifier_block panic_block_base = {
>>  	.notifier_call = panic_event,
>>  };
>>  
>> +static struct tunable_atomic_notifier_block panic_block = {
>> +	.nb		= &panic_block_base,
>> +	.head		= NULL,
>> +	.dir		= NULL,
>> +	.pri_dentry	= NULL,
>> +	.desc_dentry	= NULL
> 
> Ditto.
> 
>> +};
>> +
>>  static __init int ip32_reboot_setup(void)
>>  {
>>  	/* turn on the green led only */
> 
>> diff -uprN linux-2.6.23.orig/arch/parisc/kernel/pdc_chassis.c linux-2.6.23/arch/parisc/kernel/pdc_chassis.c
>> --- linux-2.6.23.orig/arch/parisc/kernel/pdc_chassis.c	2007-10-10 05:31:38.000000000 +0900
>> +++ linux-2.6.23/arch/parisc/kernel/pdc_chassis.c	2007-10-18 08:56:54.052000000 +0900
>> @@ -101,11 +101,18 @@ static int pdc_chassis_panic_event(struc
>>  }   
>>  
>>  
>> -static struct notifier_block pdc_chassis_panic_block = {
>> +static struct notifier_block pdc_chassis_panic_block_base = {
>>  	.notifier_call = pdc_chassis_panic_event,
>>  	.priority = INT_MAX,
>>  };
>>  
>> +static struct tunable_atomic_notifier_block pdc_chassis_panic_block = {
>> +	.nb		= &pdc_chassis_panic_block_base,
>> +	.head		= NULL,
>> +	.dir		= NULL,
>> +	.pri_dentry	= NULL,
>> +	.desc_dentry	= NULL
> 
> Ditto... (I'll skip mentioning the rest of these.)
> 
>> +};
>>  
>>  /**
>>   * parisc_reboot_event() - Called by the reboot handler.
> 
> 
> ---
> ~Randy
> 
> 

-- 
+=-=+=-=+=-=+=-=+=-=+=-=+=-=+=-=+=-=+=-=+
ＮＥＣ コンピュータソフトウェア事業本部
            ＯＳＳプラットフォーム開発本部

        永野 武則 (Takenori Nagano)

TEL:8-23-57270(MyLine) 042-333-5383(外線)
e-mail:t-nagano@ah.jp.nec.com
+=-=+=-=+=-=+=-=+=-=+=-=+=-=+=-=+=-=+=-=+

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
