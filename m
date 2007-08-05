Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e32.co.us.ibm.com ([32.97.110.150])
	by pentafluge.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IHdxc-0006x2-PH
	for kexec@lists.infradead.org; Sun, 05 Aug 2007 12:07:51 +0100
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id
	l75A1FHj006554
	for <kexec@lists.infradead.org>; Sun, 5 Aug 2007 06:01:15 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l75B7ZQm266610
	for <kexec@lists.infradead.org>; Sun, 5 Aug 2007 05:07:35 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l75B7ZJi013028
	for <kexec@lists.infradead.org>; Sun, 5 Aug 2007 05:07:35 -0600
Date: Sun, 5 Aug 2007 16:37:46 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
Subject: Re: [patch] add kdump_after_notifier
Message-ID: <20070805110746.GA12540@in.ibm.com>
References: <20070802112852.GA7054@in.ibm.com>
	<31687.1186113947@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <31687.1186113947@kao2.melbourne.sgi.com>
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
To: Keith Owens <kaos@sgi.com>
Cc: k-miyoshi@cb.jp.nec.com, Bernhard Walle <bwalle@suse.de>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Takenori Nagano <t-nagano@ah.jp.nec.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>

On Fri, Aug 03, 2007 at 02:05:47PM +1000, Keith Owens wrote:

[..]
> >Some thoughts on possible solutions for this problem.
> >
> >- Stop exporting panic_notifier_list list to modules. Audit the in kernel
> >  users of panic_notifier_list. Let crash_kexec() run once all other users
> >  of panic_notifier_list have been executed. This has fall side of breaking
> >  down external modules using panic_notifier_list and at the same time
> >  there is no gurantee that audited code will not run into the issues.
> >
> >- Continue with existing policy. If kdump is configured, panic_notifier_list
> >  notifications will not be invoked. Any post panic action should be executed
> >  in second kernel. There might be 1-2 odd cases like in kernel debugger
> >  which still needs to be invoked in first kernel. These users should
> >  explicitly put hooks in panic() routine and refrain from using
> >  panic_notifier list.
> >
> >  One thing to keep in mind, doing things in second kernel might not be easy
> >  as we have lost all the config data of the first kernel. For example,
> >  if one wants to send a kernel crash event over network to a system
> >  management software, he might have to pack in lot of software in 
> >  second kernel's initrd.
> >
> >- Let the user decide if he wants to run panic_notifier_list after the
> >  crash or not with the help of a /proc option as suggested by the
> >  Takenori's patch. Fall side is, on what basis an enterprise user will
> >  take a decision whether he wants to run the notifiers or not. My gut
> >  feeling is that distro will end up setting this parameter as 1 by default,
> >  which would mean first run panic notifiers and then run crash_kexec().
> >
> >- Make crash_kexec() a user of panic_notifier_list and let it run after all
> >  the callback handlers have run. This will invariably reduce the reliability
> >  of kdump.  
> >
> >Personally I believe that second solution should bring us best of both
> >the worlds. Making sure post panic actions can be done more reliably at
> >the same time making sure reliability of kdump is not compromised.
> >
> >Keith, do you see a value in second solution and would there be any
> >reason why kdb hook can not be explicitly placed in panic(). There will
> >not be many users like kdb. Rest of the users should end up performing
> >post panic actions in second kernel. 
> >
> >Solutoin 3, can prove to be a stop gap solution but I think this will
> >make situation confusing for customers at the same time everybody will
> >try to take short route of performing post panic operations in first kernel.
> >
> >Thanks
> >Vivek
> 
> Do not concentrate on kdb alone.  The problem above applies to all the
> RAS tools, not just kdb.
> 
> My stance is that _all_ the RAS tools (kdb, kgdb, nlkd, netdump, lkcd,
> crash, kdump etc.) should be using a common interface that safely puts
> the entire system in a stopped state and saves the state of each cpu.
> Then each tool can do what it likes, instead of every RAS tool doing
> its own thing and they all conflict with each other, which is why this
> thread started.
> 

Hi Keith,

Few thoughts. So there are two things there.

- Create a common infrastructure which can be used by various RAS
  tools and common functionality is not duplicated. For ex. functionality
  for stopping cpus, saving register states etc.

- Create a infrastructure so that user can enforce the policy regarding
  in what order various RAS tools should run.

Last time patches did more of first thing. It had put lots of code
and the only user of that code was kexec/kdump. Sometime motivation level
is low regarding why to put so much of infrastructure code in if there
are no users and it can potentially bring down the reliability of kdump.

> It is not the kernel's job to decide which RAS tool runs first, second
> etc., it is the user's decision to set that policy.  Different sites
> will want different orders, some will say "go straight to kdump", other
> sites will want to invoke a debugger first.  Sites must be able to
> define that policy, but we hard code the policy into the kernel.
> 
> I proposed and wrote most of this common interface against 2.6.19-rc5.
> See http://marc.info/?l=linux-arch&w=2&r=1&s=crash_stop&q=b, look for
> crash_stop.  The crash_stop interface stops all the cpus, saves the
> system state in a common format then runs an ordered list of RAS tools.
> 

Agreed. It would be great if during next posting one can also post the
patches for exporting the policy decision to user space.

Having said that, who do you think are potential RAS tools among
which a user has to make a choice while determining the order. I
can think of only two. Crash dump and debugger. 

> The order that the RAS tools are run depends on the priority value that
> each tool passes to register_die_notifier.  Currently each RAS tool
> hard codes its priority but it is trivial to change the tools to make
> that priority a parameter, passing the policy decision back to the
> user, not the kernel.
> 

I have got some concerns here and that's what precisely the core
point where this mail thread started. What does one do with die
notifier and panic notifer list? Should RAS tools like debugger
and crash dumpers register on this list and wait for their turn
to execute?

There are many other in kernel users who register on die or panic
notifier list. Like heartbeat, IPMI,..... Given the fact that
these symbols are exported, there will be proprietary users also
for whom we never get a chance to see their code.

Can one really trust all these users and let them run before
any RAS tool gets the control? After the kernel crash, there
is no gurantee regarding how many of these actions can be
successfully completed. Probably in case of in kernel debuggers
one can afford to do that but I think in case of kdump one
should not as all these actions can be reliably performed
in second kernel.

To sum up, couple of options come to mind.

- Register all the RAS tools on die notifier and panic
  notifier lists with fairly high priority. Export list
  of RAS tools to user space and allow users to decide the
  order of execution and priority of RAS tools.

- Create a separate RAS tool notifier list (ras_tool_notifer_list).
  All the RAS tools register on this list. This list gets priority
  over die or panic notifier list. User decides the oder of execution
  of RAS tools. 

  Here assumption is that above list will not be exported to modules.
  All the RAS tools will be in kernel and they always get a priority
  to inspect an event.

What do others think?

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
