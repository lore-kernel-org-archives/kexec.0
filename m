Return-path: <kexec-bounces@lists.infradead.org>
Received: from over.ny.us.ibm.com ([32.97.182.150])
	by pentafluge.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IiROG-0004x6-A6
	for kexec@lists.infradead.org; Thu, 18 Oct 2007 10:10:08 +0100
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by pokfb.esmtp.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	l9I89khb018011
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <kexec@lists.infradead.org>; Thu, 18 Oct 2007 04:09:47 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l9I86JRU017474
	for <kexec@lists.infradead.org>; Thu, 18 Oct 2007 04:06:19 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9I86IJG431590
	for <kexec@lists.infradead.org>; Thu, 18 Oct 2007 02:06:18 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9I86I4p002774
	for <kexec@lists.infradead.org>; Thu, 18 Oct 2007 02:06:18 -0600
Date: Thu, 18 Oct 2007 13:36:22 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
Subject: Re: [PATCH 0/2] add new notifier function ,take2
Message-ID: <20071018080621.GB8779@in.ibm.com>
References: <471700F4.1080200@ah.jp.nec.com>
	<20071018000651.35b26e42.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20071018000651.35b26e42.akpm@linux-foundation.org>
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
Errors-To: kexec-bounces@lists.infradead.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: k-miyoshi@cb.jp.nec.com, Bernhard Walle <bwalle@suse.de>, kdb@oss.sgi.com, kexec@lists.infradead.org, Takenori Nagano <t-nagano@ah.jp.nec.com>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Keith Owens <kaos@ocs.com.au>

On Thu, Oct 18, 2007 at 12:06:51AM -0700, Andrew Morton wrote:
> On Thu, 18 Oct 2007 15:45:08 +0900 Takenori Nagano <t-nagano@ah.jp.nec.com> wrote:
> 
> > Hi,
> > 
> > A big thanks to everybody who read and replied to first version. I have tried to
> > incorporate reviewer's comments and suggestions.
> > 
> > changelog take1 -> take2
> > 
> > - Rebased 2.6.23
> > - comment updated
> > - renamed the notifiner name "tunable_notifier" to "tunable_atomic_notifier"
> > - fixed typo
> > 
> > 
> > These patches add new notifier function and implement it to panic_notifier_list.
> > We used the hardcoded notifier chain so far, but it was not flexible. New
> > notifier is very flexible, because user can change a list of order by debugfs.
> > 
> > Thanks,
> > 
> > Example)
> > 
> > # cd /sys/kernel/debug/
> > # ls
> > kprobes  pktcdvd
> > # insmod ipmi_msghandler.ko
> > # ls
> > kprobes  panic_notifier_list  pktcdvd
> > # cd panic_notifier_list/
> > # ls
> > ipmi_msghandler
> > # insmod ipmi_watchdog.ko
> > # ls
> > ipmi_msghandler  ipmi_wdog
> > # cat ipmi_msghandler/priority
> > 200
> > # cat ipmi_wdog/priority
> > 150
> > #
> > Kernel panic - not syncing: panic
> > ipmi_msghandler : notifier calls panic_event().
> > ipmi_watchdog : notifier calls wdog_panic_handler().
> > 
> > .....(reboot)
> > 
> > # cat ipmi_msghandler/priority
> > 200
> > # cat ipmi_wdog/priority
> > 150
> > # echo 300 > ipmi_wdog/priority
> > #
> > Kernel panic - not syncing: panic
> > ipmi_watchdog : notifier calls wdog_panic_handler().
> > ipmi_msghandler : notifier calls panic_event().
> 
> I can sort-of see what this is doing.  Runtime-definable management of
> which notifier functions will be called on a panic?  Or maybe I
> misunderstood.
> 
> But even if I did understand, I don't understand why Linux needs this
> feature - what are the use cases, what is the value to our users?
> 
> Can you please flesh that information out a bit more?
> 

Hi Andrew,

Takenori wants to make kdb and kdump co-exist. Currently after panic()
panic_notifier_list is not executed if kdump is configured. Before list
is executed, system will boot into second kernel to capture the dump. Hence
if even if kdb was registered on panic_notifier_list, it will never get
a chance to run.

One of the ideas was to put all the RAS tools on panic_notifier_list, export
the list to user space and let user determine the order in which these
should be called. That's why this patchset is there.

This does bring in some reliability concerns for kdump as now there is
additional dependency on notifier infrastructure after panic.

Eric, had suggested that kdb can put a break point on panic() to handle
the co-existence issue and no need to bring in additional dependencies in
panic path.

I agree with the idea of kdb putting a break point in panic. If there are
more tools down the line who run into co-existence issue with kdump, then
we can re-visit this idea.

Thanks
Vivek


> The patches are somewhat wordwrapped - please check your email client
> configuration, thanks.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
