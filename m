Return-path: <kexec-bounces@lists.infradead.org>
Received: from tyo200.gate.nec.co.jp ([210.143.35.50])
	by pentafluge.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IiRBt-0004LZ-1P
	for kexec@lists.infradead.org; Thu, 18 Oct 2007 09:57:19 +0100
Received: from tyo201.gate.nec.co.jp ([10.7.69.201])
	by tyo200.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id l9I8t9pF002382
	for <kexec@lists.infradead.org>; Thu, 18 Oct 2007 17:55:09 +0900 (JST)
Message-ID: <47171ED9.7010907@ah.jp.nec.com>
Date: Thu, 18 Oct 2007 17:52:41 +0900
From: Takenori Nagano <t-nagano@ah.jp.nec.com>
MIME-Version: 1.0
Subject: Re: [PATCH 0/2] add new notifier function ,take2
References: <471700F4.1080200@ah.jp.nec.com>
	<20071018000651.35b26e42.akpm@linux-foundation.org>
	<20071018080621.GB8779@in.ibm.com>
In-Reply-To: <20071018080621.GB8779@in.ibm.com>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: k-miyoshi@cb.jp.nec.com, Bernhard Walle <bwalle@suse.de>, kdb@oss.sgi.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, vgoyal@in.ibm.com, "Eric W. Biederman" <ebiederm@xmission.com>, Keith Owens <kaos@ocs.com.au>

Vivek Goyal wrote:
> On Thu, Oct 18, 2007 at 12:06:51AM -0700, Andrew Morton wrote:
>> On Thu, 18 Oct 2007 15:45:08 +0900 Takenori Nagano <t-nagano@ah.jp.nec.com> wrote:
>> I can sort-of see what this is doing.  Runtime-definable management of
>> which notifier functions will be called on a panic?  Or maybe I
>> misunderstood.
>>
>> But even if I did understand, I don't understand why Linux needs this
>> feature - what are the use cases, what is the value to our users?
>>
>> Can you please flesh that information out a bit more?
>>
>
> Hi Andrew,
> 
> Takenori wants to make kdb and kdump co-exist. Currently after panic()
> panic_notifier_list is not executed if kdump is configured. Before list
> is executed, system will boot into second kernel to capture the dump. Hence
> if even if kdb was registered on panic_notifier_list, it will never get
> a chance to run.

Yes, it is true. But I don't mind only kdb and kdump co-exist.

Keith Owen said,

> > My stance is that _all_ the RAS tools (kdb, kgdb, nlkd, netdump, lkcd,
> > crash, kdump etc.) should be using a common interface that safely puts
> > the entire system in a stopped state and saves the state of each cpu.
> > Then each tool can do what it likes, instead of every RAS tool doing
> > its own thing and they all conflict with each other, which is why this
> > thread started.
> > 
> > It is not the kernel's job to decide which RAS tool runs first, second
> > etc., it is the user's decision to set that policy. Different sites
> > will want different orders, some will say "go straight to kdump", other
> > sites will want to invoke a debugger first. Sites must be able to
> > define that policy, but we hard code the policy into the kernel. 

I agreed with him and I made new notifier function that users can change
the order. Priority value in notifier blocks are hardcoded. If users want to
change list order, they have to rebuild kernel. I think it is very unhappy.

This is our discussion.
http://www.gossamer-threads.com/lists/linux/kernel/797220?do=post_view_threaded#797220

In addition, we can use new notifier function to reboot_notifier, die_chain
if users want to use.

>> The patches are somewhat wordwrapped - please check your email client
>> configuration, thanks.

Sorry, I'll resend.

Thanks,
  Takenori
 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
