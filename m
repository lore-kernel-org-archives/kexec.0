Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1INTfi-0008Lo-Jy
	for kexec@lists.infradead.org; Tue, 21 Aug 2007 09:21:28 -0400
Date: Tue, 21 Aug 2007 15:21:19 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [patch] add kdump_after_notifier
Message-ID: <20070821132119.GC4244@suse.de>
References: <20070802112852.GA7054@in.ibm.com>
	<31687.1186113947@kao2.melbourne.sgi.com>
	<20070805110746.GA12540@in.ibm.com>
	<46C1691E.7090708@ah.jp.nec.com> <20070814083710.GA14538@suse.de>
	<20070814132454.GA8293@in.ibm.com> <46C4184B.5030303@ah.jp.nec.com>
	<20070817105630.GA18167@in.ibm.com> <46CAE627.7070908@sgi.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <46CAE627.7070908@sgi.com>
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
Cc: k-miyoshi@cb.jp.nec.com, kexec@lists.infradead.org, Takenori Nagano <t-nagano@ah.jp.nec.com>, linux-kernel@vger.kernel.org, vgoyal@in.ibm.com, "Eric W. Biederman" <ebiederm@xmission.com>, Keith Owens <kaos@ocs.com.au>, Andrew Morton <akpm@linux-foundation.org>

* Jay Lan <jlan@sgi.com> [2007-08-21 15:18]:
> Vivek Goyal wrote:
> > On Thu, Aug 16, 2007 at 06:26:35PM +0900, Takenori Nagano wrote:
> >> Vivek Goyal wrote:
> >>  > So for the time being I think we can put RAS tools on die notifier list
> >>> and if it runs into issues we can always think of creating a separate list.
> >>>
> >>> Few things come to mind.
> >>>
> >>> - Why there is a separate panic_notifier_list? Can't it be merged with
> >>>   die_chain? die_val already got one of the event type as PANIC. If there
> >>>   are no specific reasons then we should merge the two lists. Registering
> >>>   RAS tools on a single list is easier.
> >> I think it is difficult, because die_chain is defined by each architecture.
> >>
> > 
> > I think die_chain is arch independent definition (kernel/die_notifier.c)? 
> > But anyway, to begin with it can be done only for panic_notifier.
> > 
> >>> - Modify Kdump to register on die_chain list. 
> >>> - Modify Kdb to register on die_chain list.
> >>> - Export all the registered members of die_chain through sysfs along with
> >>>   their priorities. Priorities should be modifiable. Most likely one 
> >>>   shall have to introduce additional field in struct notifier_block. This
> >>>   field will be a string as an identifier of the user registerd. e.g
> >>>   "Kdump", "Kdb" etc.
> >>>
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

Well, it's more intuitive to set the priority in that case. You don't
have to know a special syntax. However, it may be a good idea to
implement a second read-only file that lists the sorted priorities in
that order the kernel executues the handlers the handlers.

> What do we decide priority if more than one component has
> the same priority value?

You can check this and return EINVAL in that case.


Thanks,
   Bernhard

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
