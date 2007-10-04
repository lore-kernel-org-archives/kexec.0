Return-path: <kexec-bounces@lists.infradead.org>
Received: from tyo200.gate.nec.co.jp ([210.143.35.50])
	by pentafluge.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IdOyZ-0001N5-1I
	for kexec@lists.infradead.org; Thu, 04 Oct 2007 12:34:45 +0100
Received: from tyo202.gate.nec.co.jp ([10.7.69.202])
	by tyo200.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id l94BWaaB012920
	for <kexec@lists.infradead.org>; Thu, 4 Oct 2007 20:32:36 +0900 (JST)
Message-ID: <4704CEC5.3020306@ah.jp.nec.com>
Date: Thu, 04 Oct 2007 20:30:13 +0900
From: Takenori Nagano <t-nagano@ah.jp.nec.com>
MIME-Version: 1.0
Subject: Re: [patch] add kdump_after_notifier
References: <20070802112852.GA7054@in.ibm.com>	<31687.1186113947@kao2.melbourne.sgi.com>	<20070805110746.GA12540@in.ibm.com>	<46C1691E.7090708@ah.jp.nec.com>
	<20070814083710.GA14538@suse.de>	<20070814132454.GA8293@in.ibm.com>
	<46C4184B.5030303@ah.jp.nec.com>	<20070817105630.GA18167@in.ibm.com>
	<46CAE627.7070908@sgi.com> <20070823035629.GB365@in.ibm.com>
	<46CDC51D.5070206@sgi.com>
In-Reply-To: <46CDC51D.5070206@sgi.com>
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
To: Jay Lan <jlan@sgi.com>
Cc: k-miyoshi@cb.jp.nec.com, Bernhard Walle <bwalle@suse.de>, kexec@lists.infradead.org, vgoyal@in.ibm.com, "Eric W. Biederman" <ebiederm@xmission.com>, Keith Owens <kaos@ocs.com.au>, Andrew Morton <akpm@linux-foundation.org>

Hi all,

I finished to implement this function. I will send patches after this mail.
Please review them and give some comments.

Thanks,

Jay Lan wrote:
> Vivek Goyal wrote:
>> On Tue, Aug 21, 2007 at 06:18:31AM -0700, Jay Lan wrote:
>> [..]
>>>>>> Now user will be able to view all the die_chain users through sysfs and
>>>>>> be able to modify the order in which these should run by modifying their
>>>>>> priority. Hence all the RAS tools can co-exist.
>>>>> This is my image of your proposal.
>>>>>
>>>>> - Print current order
>>>>>
>>>>> # cat /sys/class/misc/debug/panic_notifier_list
>>>>> priority   name
>>>>> 1          IPMI
>>>>> 2          watchdog
>>>>> 3          Kdb
>>>>> 4          Kdump
>>>>>
>>>> I think Bernhard's suggestion looks better here. I noticed that 
>>>> /sys/kernel/debug is already present. So how about following.
>>>>
>>>> /sys/kernel/debug/kdump/priority
>>>> /sys/kernel/debug/kdb/priority
>>>> /sys/kernel/debug/IPMI/priority
>>> Why separate priority files is better than a central file?
>>> At least i think you get a grand picture of priority being
>>> defined for all parties with a central file?
>>>
>> I thought of couple of reasons.
>> - A very different syntax to modify the priority.
>> - Separate directories allow easy future extensions in terms of more
>>   files. For example, putting a small "description" file in each dir
>>   where each registered user can specify what does it do.
> 
> The first can be easily resolved by providing a comment section in the
> file with real examples. Users can simply uncomment a line to activate.
> But future expansion is certainly is a good reason for this layout.
> 
>> But I agree that a single file is good for consolidated view. As bernhard
>> suggested, may be we should also implement a read only file where one
>> will get a consolidated view.
> 
> Yep, this will help!
> 
>>> What do we decide priority if more than one component has
>>> the same priority value?
>>>
>> I think first come first serve would be appropriate in this case instead of
>> returning -EINVAL.
> 
> How does the kernel process the configuration files? By alphabetic order
> of the filename? Either way, i think a clear failure/warning dmesg is
> very important.
> 
> Thanks,
>  - jay
> 
>> Thanks
>> Vivek
>>
>> _______________________________________________
>> kexec mailing list
>> kexec@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/kexec
> 
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
