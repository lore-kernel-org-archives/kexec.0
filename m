Return-path: <kexec-bounces@lists.infradead.org>
Received: from tyo200.gate.nec.co.jp ([210.143.35.50])
	by pentafluge.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1Idgbm-0002an-In
	for kexec@lists.infradead.org; Fri, 05 Oct 2007 07:24:25 +0100
Received: from tyo202.gate.nec.co.jp ([10.7.69.202])
	by tyo200.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id l956MIkg017439
	for <kexec@lists.infradead.org>; Fri, 5 Oct 2007 15:22:18 +0900 (JST)
Message-ID: <4705D77E.5000703@ah.jp.nec.com>
Date: Fri, 05 Oct 2007 15:19:42 +0900
From: Takenori Nagano <t-nagano@ah.jp.nec.com>
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] implement new notifier function to panic_notifier_list
References: <4704D0CA.4080001@ah.jp.nec.com> <20071005054952.GC4893@in.ibm.com>
In-Reply-To: <20071005054952.GC4893@in.ibm.com>
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
To: vgoyal@in.ibm.com
Cc: k-miyoshi@cb.jp.nec.com, Bernhard Walle <bwalle@suse.de>, kdb@oss.sgi.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Keith Owens <kaos@ocs.com.au>, Andrew Morton <akpm@linux-foundation.org>

Vivek Goyal wrote:
> On Thu, Oct 04, 2007 at 08:38:50PM +0900, Takenori Nagano wrote:
>
>> @@ -522,8 +530,8 @@ setup_arch(char **cmdline_p)
>>  	}
>>
>>  	/* Register a call for panic conditions. */
>> -	atomic_notifier_chain_register(&panic_notifier_list,
>> -			&alpha_panic_block);
>> +	tunable_notifier_chain_register(&panic_notifier_list,
>> +			&alpha_panic_block, "alpha_panic", NULL);
>>
> 
> I think it might be good idea to somehow create provisions for another a
> help string. This help string will inform admin that what a registered
> user does? Ideally this should be visible in /sys/kernel/debug/<user module>/description file.

Hi Vivek,

We can make description file with tunable_notifier_chain_register 4th argument.
If developer sets 4th argument, tunable_notifier_chain_register makes
/sys/kernel/debug/<name>/description file. Admin can get information from the
description file.

+/**
+ *	tunable_notifier_chain_register - Add notifier to an tunable notifier chain
+ *	@nh: Pointer to head of the tunable notifier chain
+ *	@n: New entry in notifier chain
+ *	@name: Pointer to the name of the new notifier entry
+ *	@desc: Pointer to the description of new entry
+ *
+ *	Adds a notifier to an tunable notifier chain and makes control dir.
+ *
+ *	Returns zero on success or %-ENODEV on failure.
+ */

Thanks,

Takenori Nagano <t-nagano@ah.jp.nec.com>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
