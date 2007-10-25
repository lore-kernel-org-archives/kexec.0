Return-path: <kexec-bounces@lists.infradead.org>
Received: from tyo200.gate.nec.co.jp ([210.143.35.50])
	by pentafluge.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1Ikxjl-0006Ii-0A
	for kexec@lists.infradead.org; Thu, 25 Oct 2007 09:06:43 +0100
Received: from tyo202.gate.nec.co.jp ([10.7.69.202])
	by tyo200.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id l9P84doY017472
	for <kexec@lists.infradead.org>; Thu, 25 Oct 2007 17:04:39 +0900 (JST)
Message-ID: <47204D84.1060706@ah.jp.nec.com>
Date: Thu, 25 Oct 2007 17:02:12 +0900
From: Takenori Nagano <t-nagano@ah.jp.nec.com>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] add tunable_notifier function ,take2
References: <4716FFDB.7090502@ah.jp.nec.com>	<47171EEC.4030408@ah.jp.nec.com>
	<20071024111629.3e28b452.rdunlap@xenotime.net>
In-Reply-To: <20071024111629.3e28b452.rdunlap@xenotime.net>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces@lists.infradead.org
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: k-miyoshi@cb.jp.nec.com, Bernhard Walle <bwalle@suse.de>, kdb@oss.sgi.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, vgoyal@in.ibm.com, "Eric W. Biederman" <ebiederm@xmission.com>, Keith Owens <kaos@ocs.com.au>, Andrew Morton <akpm@linux-foundation.org>

Randy Dunlap wrote:
> On Thu, 18 Oct 2007 17:53:00 +0900 Takenori Nagano wrote:
> 
>> This patch adds new notifier function tunable_notifier_chain. Its base is
>> atomic_notifier_chain.
>>
>> Thanks,
>>
>> ---
>>
>> Signed-off-by: Takenori Nagano <t-nagano@ah.jp.nec.com>
>>
>> ---
>> diff -uprN linux-2.6.23.orig/kernel/sys.c linux-2.6.23/kernel/sys.c
>> --- linux-2.6.23.orig/kernel/sys.c	2007-10-10 05:31:38.000000000 +0900
>> +++ linux-2.6.23/kernel/sys.c	2007-10-18 10:08:52.728000000 +0900
>> @@ -38,6 +38,7 @@
>>  #include <linux/syscalls.h>
>>  #include <linux/kprobes.h>
>>  #include <linux/user_namespace.h>
>> +#include <linux/debugfs.h>
>>  
>>  #include <asm/uaccess.h>
>>  #include <asm/io.h>
>> @@ -393,6 +394,243 @@ int blocking_notifier_call_chain(struct 
>>  EXPORT_SYMBOL_GPL(blocking_notifier_call_chain);
> 
>> +/**
>> + *	tunable_atomic_notifier_chain_register
>> + *				- Add notifier to an tunable notifier chain
> 
> Function name & short description must be on one (long?) line.  :(

OK. I'll fix next version.

>> +
>> +int __kprobes __tunable_atomic_notifier_call_chain(
>> +					struct tunable_atomic_notifier_head *nh,
>> +					unsigned long val, void *v,
>> +					int nr_to_call, int *nr_calls)
>> +{
>> +	int ret;
>> +
>> +	rcu_read_lock();
>> +	ret = notifier_call_chain(&nh->head, val, v, nr_to_call, nr_calls);
>> +	rcu_read_unlock();
>> +	return ret;
>> +}
>> +
>> +EXPORT_SYMBOL_GPL(__tunable_atomic_notifier_call_chain);
> 
> Blank line is usually omitted before EXPORT_SYMBOL....

OK. I'll fix, too.

Thanks,
  Takenori

> ---
> ~Randy
> 
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
