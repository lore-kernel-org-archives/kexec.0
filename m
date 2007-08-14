Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IKs5X-0001kO-85
	for kexec@lists.infradead.org; Tue, 14 Aug 2007 04:49:21 -0400
Message-ID: <46C16C7B.603@ah.jp.nec.com>
Date: Tue, 14 Aug 2007 17:48:59 +0900
From: Takenori Nagano <t-nagano@ah.jp.nec.com>
MIME-Version: 1.0
Subject: Re: [patch] add kdump_after_notifier
References: <20070802112852.GA7054@in.ibm.com>
	<31687.1186113947@kao2.melbourne.sgi.com>
	<20070805110746.GA12540@in.ibm.com>
	<46C1691E.7090708@ah.jp.nec.com> <20070814083710.GA14538@suse.de>
In-Reply-To: <20070814083710.GA14538@suse.de>
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Bernhard Walle <bwalle@suse.de>
Cc: Keith Owens <kaos@sgi.com>, k-miyoshi@cb.jp.nec.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, vgoyal@in.ibm.com, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>

Bernhard Walle wrote:
> * Takenori Nagano <t-nagano@ah.jp.nec.com> [2007-08-14 10:34]:
>> Vivek Goyal wrote:
>>> On Fri, Aug 03, 2007 at 02:05:47PM +1000, Keith Owens wrote:
>>>
>>>
>>> To sum up, couple of options come to mind.
>>>
>>> - Register all the RAS tools on die notifier and panic
>>>   notifier lists with fairly high priority. Export list
>>>   of RAS tools to user space and allow users to decide the
>>>   order of execution and priority of RAS tools.
>>>
>>> - Create a separate RAS tool notifier list (ras_tool_notifer_list).
>>>   All the RAS tools register on this list. This list gets priority
>>>   over die or panic notifier list. User decides the oder of execution
>>>   of RAS tools. 
>>>
>>>   Here assumption is that above list will not be exported to modules.
>>>   All the RAS tools will be in kernel and they always get a priority
>>>   to inspect an event.
>>>
>>> What do others think?
>> Very good idea. But there is a problem how to give default priority to RAS tools.
>>
>> How about priority changeable notifier_list? User can change list order
>> dynamically if they want. Of course, we have to give highest priority to kdump
>> by default. It is very useful for users who want to use some RAS tools.
> 
> I think that was the idea of the first “-” (“export list of RAS tools
> to user space”).

Ah, sorry.

I think first idea is very good. How export the list? (sysfs? procfs?)

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
