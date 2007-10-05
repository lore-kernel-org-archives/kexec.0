Return-path: <kexec-bounces@lists.infradead.org>
Received: from tyo200.gate.nec.co.jp ([210.143.35.50])
	by pentafluge.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IdfMM-0001fY-IF
	for kexec@lists.infradead.org; Fri, 05 Oct 2007 06:04:25 +0100
Received: from tyo201.gate.nec.co.jp ([10.7.69.201])
	by tyo200.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id l95529Jg026547
	for <kexec@lists.infradead.org>; Fri, 5 Oct 2007 14:02:09 +0900 (JST)
Message-ID: <4705C4BF.6060308@ah.jp.nec.com>
Date: Fri, 05 Oct 2007 13:59:43 +0900
From: Takenori Nagano <t-nagano@ah.jp.nec.com>
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] implement new notifier function to panic_notifier_list
References: <4704D0CA.4080001@ah.jp.nec.com>
	<20071004090711.456b6338.randy.dunlap@oracle.com>
In-Reply-To: <20071004090711.456b6338.randy.dunlap@oracle.com>
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
> On Thu, 04 Oct 2007 20:38:50 +0900 Takenori Nagano wrote:
> 
>> This patch implements new notifier function to panic_notifier_list. We can
>> change the list of order by debugfs.
>>
>> Thanks,
>>
>> ---
>>
>> Signed-off-by: Takenori Nagano <t-nagano@ah.jp.nec.com>
>>
>> ---
>>   * Returns seconds, approximately.  We don't need nanosecond
>>   * resolution, and we don't need to waste time with a big divide when
>> @@ -193,5 +201,6 @@ __init void spawn_softlockup_task(void)
>>  	cpu_callback(&cpu_nfb, CPU_ONLINE, cpu);
>>  	register_cpu_notifier(&cpu_nfb);
>>
>> -	atomic_notifier_chain_register(&panic_notifier_list, &panic_block);
>> +	tunable_notifier_chain_register(&panic_notifier_list, &panic_block,
>> +						"softlookup", NULL);
>>  }
> 
>                                                 "softlockup"

Hi Randy,

Thank you for reviewing. :)
I'll fix next version.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
