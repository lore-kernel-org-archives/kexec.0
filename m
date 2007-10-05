Return-path: <kexec-bounces@lists.infradead.org>
Received: from tyo200.gate.nec.co.jp ([210.143.35.50])
	by pentafluge.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IdfS4-0001il-TA
	for kexec@lists.infradead.org; Fri, 05 Oct 2007 06:10:19 +0100
Received: from tyo201.gate.nec.co.jp ([10.7.69.201])
	by tyo200.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id l9558FeW028579
	for <kexec@lists.infradead.org>; Fri, 5 Oct 2007 14:08:15 +0900 (JST)
Message-ID: <4705C63E.7020408@ah.jp.nec.com>
Date: Fri, 05 Oct 2007 14:06:06 +0900
From: Takenori Nagano <t-nagano@ah.jp.nec.com>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] add tunable_notifier function
References: <4704D0BA.4090507@ah.jp.nec.com>
	<20071004091157.c35f3513.randy.dunlap@oracle.com>
In-Reply-To: <20071004091157.c35f3513.randy.dunlap@oracle.com>
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
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: k-miyoshi@cb.jp.nec.com, Bernhard Walle <bwalle@suse.de>, kdb@oss.sgi.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, vgoyal@in.ibm.com, "Eric W. Biederman" <ebiederm@xmission.com>, Keith Owens <kaos@ocs.com.au>, Andrew Morton <akpm@linux-foundation.org>

Randy Dunlap wrote:
> On Thu, 04 Oct 2007 20:38:34 +0900 Takenori Nagano wrote:
>> diff -uprN linux-2.6.23-rc9.orig/kernel/sys.c linux-2.6.23-rc9/kernel/sys.c
>> --- linux-2.6.23-rc9.orig/kernel/sys.c	2007-10-02 12:24:52.000000000 +0900
>> +++ linux-2.6.23-rc9/kernel/sys.c	2007-10-03 14:48:15.160000000 +0900
>> @@ -38,6 +38,7 @@
>>  #include <linux/syscalls.h>
>>  #include <linux/kprobes.h>
>>  #include <linux/user_namespace.h>
>> +#include <linux/debugfs.h>
>>
>>  #include <asm/uaccess.h>
>>  #include <asm/io.h>
>> @@ -393,6 +394,234 @@ int blocking_notifier_call_chain(struct
> 
>> +/**
>> + *	tunable_notifier_chain_register - Add notifier to an tunable notifier chain
>> + *	@nh: Pointer to head of the tunable notifier chain
>> + *	@n: New entry in notifier chain
>> + *	@name: Pointer to the name of this notifier chain
> 
> Is @name the name of a notifier chain or of the new notifier entry?

Hi Randy,

@name: Pointer to the name of the new notifier entry.

I'll change the explanation.

Thanks,

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
