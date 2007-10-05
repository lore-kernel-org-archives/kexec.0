Return-path: <kexec-bounces@lists.infradead.org>
Received: from e1.ny.us.ibm.com ([32.97.182.141])
	by pentafluge.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1Idevw-0001JF-Ba
	for kexec@lists.infradead.org; Fri, 05 Oct 2007 05:37:08 +0100
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l954XnIA006587
	for <kexec@lists.infradead.org>; Fri, 5 Oct 2007 00:33:49 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l954XnG0486506
	for <kexec@lists.infradead.org>; Fri, 5 Oct 2007 00:33:49 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l954XdTg009260
	for <kexec@lists.infradead.org>; Fri, 5 Oct 2007 00:33:39 -0400
Date: Fri, 5 Oct 2007 10:03:54 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
Subject: Re: [PATCH 0/2] add new notifier function
Message-ID: <20071005043354.GA4893@in.ibm.com>
References: <4704D09D.6080503@ah.jp.nec.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4704D09D.6080503@ah.jp.nec.com>
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
To: Takenori Nagano <t-nagano@ah.jp.nec.com>
Cc: k-miyoshi@cb.jp.nec.com, Bernhard Walle <bwalle@suse.de>, kdb@oss.sgi.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Keith Owens <kaos@ocs.com.au>, Andrew Morton <akpm@linux-foundation.org>

On Thu, Oct 04, 2007 at 08:38:05PM +0900, Takenori Nagano wrote:
> Hi,
> 
> These patches add new notifier function and implement it to panic_notifier_list.
> We used the hardcoded notifier chain so far, but it was not flexible. New
> notifier is very flexible, because user can change a list of order by debugfs.
> 

Hi Takenori,

There were some more discussions regarding configurable notifier list.
Following is the link. Please go through it.

http://marc.info/?l=linux-kernel&m=118968996202991&w=2

Not everybody is too happy about it. Personally I am not against it. My take
is that after panic() there is no gurantee that all the registered notifer
will be executed. Just that kernel will try its best. If a notifier handler
is written badly, kernel can't do much about it. It is left more on to
administrator what he considers most important and give priority accordingly.

So if kdump is of utmost priority, then administrator should give highest
priority to kdump. 

Having said that, what are the RAS tools which require this infrastructure.
Currently only kdb seems to be the only candidate which needs to run in
the crashing kernel. Rest of the actions can be performed in second kernel.
If that is the case, then probably it is better that kdb puts a break point
on panic(), as suggested by Eric, and rest of the post panic actions are
executed in second kernel.

Executing rest of the actions have got both pros and cons. Executing rest
of the notifications in second kernel makes things more reliable. At the same
time it makes things little complex as one needs to pass all the configuration
information required to second kernel, secondly all the notification handlers
need to be ready to run in two contexts. These handlers will run in the 
context of first kernel if kdump is not configured, otherwise these will need
to run in second kernel.

In summary, right now co-existence of kdb with kdump seems to be your pain
point. I would prefer that kdb just puts a break point on panic() and we move
on. If there are more candidates down the line and these can't be easily
executed in second kernel then we can re-visit this notification list
mechanism.
   
 
> Please review, and give some comments.
> 
> Thanks,
> 
> Example)
> 
> # cd /sys/kernel/debug/
> # ls
> kprobes  pktcdvd
> # insmod ipmi_msghandler.ko
> # ls
> kprobes  panic_notifier_list  pktcdvd
> # cd panic_notifier_list/
> # ls
> ipmi_msghandler
> # insmod ipmi_watchdog.ko
> # ls
> ipmi_msghandler  ipmi_wdog
> # cat ipmi_msghandler/priority
> 200
> # cat ipmi_wdog/priority
> 150
> #
> Kernel panic - not syncing: panic
> ipmi_msghandler : notifier calls panic_event().
> ipmi_watchdog : notifier calls wdog_panic_handler().
> 
> .....(reboot)
> 

We also need to implement a file which can give a consolidated view. All
the registered members and their priority.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
