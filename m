Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e31.co.us.ibm.com ([32.97.110.149])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IO3nz-0004SE-K7
	for kexec@lists.infradead.org; Wed, 22 Aug 2007 23:56:25 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l7N3uBsJ027729
	for <kexec@lists.infradead.org>; Wed, 22 Aug 2007 23:56:11 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l7N3uBIC213726
	for <kexec@lists.infradead.org>; Wed, 22 Aug 2007 21:56:11 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l7N3uAEZ002614
	for <kexec@lists.infradead.org>; Wed, 22 Aug 2007 21:56:10 -0600
Date: Thu, 23 Aug 2007 09:26:29 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
Subject: Re: [patch] add kdump_after_notifier
Message-ID: <20070823035629.GB365@in.ibm.com>
References: <20070802112852.GA7054@in.ibm.com>
	<31687.1186113947@kao2.melbourne.sgi.com>
	<20070805110746.GA12540@in.ibm.com>
	<46C1691E.7090708@ah.jp.nec.com> <20070814083710.GA14538@suse.de>
	<20070814132454.GA8293@in.ibm.com> <46C4184B.5030303@ah.jp.nec.com>
	<20070817105630.GA18167@in.ibm.com> <46CAE627.7070908@sgi.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <46CAE627.7070908@sgi.com>
Reply-To: vgoyal@in.ibm.com
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Jay Lan <jlan@sgi.com>
Cc: k-miyoshi@cb.jp.nec.com, Bernhard Walle <bwalle@suse.de>, kexec@lists.infradead.org, Takenori Nagano <t-nagano@ah.jp.nec.com>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Keith Owens <kaos@ocs.com.au>, Andrew Morton <akpm@linux-foundation.org>

On Tue, Aug 21, 2007 at 06:18:31AM -0700, Jay Lan wrote:
[..]
> >>> Now user will be able to view all the die_chain users through sysfs and
> >>> be able to modify the order in which these should run by modifying their
> >>> priority. Hence all the RAS tools can co-exist.
> >> This is my image of your proposal.
> >>
> >> - Print current order
> >>
> >> # cat /sys/class/misc/debug/panic_notifier_list
> >> priority   name
> >> 1          IPMI
> >> 2          watchdog
> >> 3          Kdb
> >> 4          Kdump
> >>
> > 
> > I think Bernhard's suggestion looks better here. I noticed that 
> > /sys/kernel/debug is already present. So how about following.
> > 
> > /sys/kernel/debug/kdump/priority
> > /sys/kernel/debug/kdb/priority
> > /sys/kernel/debug/IPMI/priority
> 
> Why separate priority files is better than a central file?
> At least i think you get a grand picture of priority being
> defined for all parties with a central file?
> 

I thought of couple of reasons.
- A very different syntax to modify the priority.
- Separate directories allow easy future extensions in terms of more
  files. For example, putting a small "description" file in each dir
  where each registered user can specify what does it do.

But I agree that a single file is good for consolidated view. As bernhard
suggested, may be we should also implement a read only file where one
will get a consolidated view.

> What do we decide priority if more than one component has
> the same priority value?
> 

I think first come first serve would be appropriate in this case instead of
returning -EINVAL.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
