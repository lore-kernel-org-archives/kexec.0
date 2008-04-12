Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JkX2C-0002tl-A5
	for kexec@lists.infradead.org; Sat, 12 Apr 2008 04:08:12 +0000
Date: Fri, 11 Apr 2008 21:07:51 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 0/2] add new notifier function ,take3
Message-Id: <20080411210751.e4a468b2.akpm@linux-foundation.org>
In-Reply-To: <47FF190B.6030406@ah.jp.nec.com>
References: <47FF190B.6030406@ah.jp.nec.com>
Mime-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Takenori Nagano <t-nagano@ah.jp.nec.com>
Cc: nickpiggin@yahoo.com.au, k-miyoshi@cb.jp.nec.com, greg@kroah.com, Bernhard Walle <bwalle@suse.de>, kdb@oss.sgi.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@xenotime.net>, vgoyal@in.ibm.com, "Eric W. Biederman" <ebiederm@xmission.com>, Keith Owens <kaos@ocs.com.au>

On Fri, 11 Apr 2008 16:53:47 +0900 Takenori Nagano <t-nagano@ah.jp.nec.com> wrote:

> Hi,
> 
> A big thanks to everybody who read and replied to previous version.
> 
> changelog take2 -> take3
> 
> - Rebased 2.6.25-rc8-mm1
> - comment updated
> - renamed the notifiner name "tunable_notifier" to "tunable_atomic_notifier"
> - fixed typo
> - move control files debugfs to /sys/kernel
> 
> These patches add new notifier function and implement it to panic_notifier_list.
> We used the hardcoded notifier chain so far, but it was not flexible. New
> notifier is very flexible, because user can change a list of order by control files.
> 
> Example)
> 
> # cd /sys/kernel/notifiers/
> # ls
> panic_notifier_list
> # cd panic_notifier_list/
> # ls
> ipmi_msghandler  ipmi_wdog
> # insmod notifier_test.ko
> # ls
> ipmi_msghandler  ipmi_wdog  notifier_test1  notifier_test2
> # cat */priority
> 200
> 150
> 500
> 1000
> Kernel panic - not syncing: Panic by panic_module.
> __tunable_atomic_notifier_call_chain enter
> notifier_test: notifier_test_panic2() is called.
> notifier_test: notifier_test_panic() is called.
> msg_handler:panic_event was called.
> ipmi_wdog:wdog_panic_handler was called.
> 
> .....(reboot)
> 
> # cd /sys/kernel/notifiers/panic_notifier_list/
> # ls
> ipmi_msghandler  ipmi_wdog  notifier_test1  notifier_test2
> # cat */priority
> 200
> 150
> 500
> 1000
> # echo 10000 > ipmi_msghandler/priority
> # echo 5000 > ipmi_wdog/priority
> # echo 3000 > notifier_test1/priority
> # echo 1500 > notifier_test2/priority
> # cat */priority
> 10000
> 5000
> 3000
> 1500
> Kernel panic - not syncing: Panic by panic_module.
> __tunable_atomic_notifier_call_chain enter
> msg_handler:panic_event was called.
> ipmi_wdog:wdog_panic_handler was called.
> notifier_test: notifier_test_panic() is called.
> notifier_test: notifier_test_panic2() is called.

OK.  But I don't see anywhere in here the most important piece of
information: why do we need this feature in Linux?

What are the use-cases?  What is the value?  etc.

Often I can guess (but I like the originator to remove the guesswork).  In
this case I'm stumped - I can't see any reason why anyone would want this.

Awaiting enlightenment ;)

Thanks.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
