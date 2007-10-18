Return-path: <kexec-bounces@lists.infradead.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14])
	by pentafluge.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IiQ0B-0001TF-4I
	for kexec@lists.infradead.org; Thu, 18 Oct 2007 08:41:10 +0100
Date: Thu, 18 Oct 2007 00:06:51 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 0/2] add new notifier function ,take2
Message-Id: <20071018000651.35b26e42.akpm@linux-foundation.org>
In-Reply-To: <471700F4.1080200@ah.jp.nec.com>
References: <471700F4.1080200@ah.jp.nec.com>
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
Errors-To: kexec-bounces@lists.infradead.org
To: Takenori Nagano <t-nagano@ah.jp.nec.com>
Cc: k-miyoshi@cb.jp.nec.com, Bernhard Walle <bwalle@suse.de>, kdb@oss.sgi.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, vgoyal@in.ibm.com, "Eric W. Biederman" <ebiederm@xmission.com>, Keith Owens <kaos@ocs.com.au>

On Thu, 18 Oct 2007 15:45:08 +0900 Takenori Nagano <t-nagano@ah.jp.nec.com> wrote:

> Hi,
> 
> A big thanks to everybody who read and replied to first version. I have tried to
> incorporate reviewer's comments and suggestions.
> 
> changelog take1 -> take2
> 
> - Rebased 2.6.23
> - comment updated
> - renamed the notifiner name "tunable_notifier" to "tunable_atomic_notifier"
> - fixed typo
> 
> 
> These patches add new notifier function and implement it to panic_notifier_list.
> We used the hardcoded notifier chain so far, but it was not flexible. New
> notifier is very flexible, because user can change a list of order by debugfs.
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
> # cat ipmi_msghandler/priority
> 200
> # cat ipmi_wdog/priority
> 150
> # echo 300 > ipmi_wdog/priority
> #
> Kernel panic - not syncing: panic
> ipmi_watchdog : notifier calls wdog_panic_handler().
> ipmi_msghandler : notifier calls panic_event().

I can sort-of see what this is doing.  Runtime-definable management of
which notifier functions will be called on a panic?  Or maybe I
misunderstood.

But even if I did understand, I don't understand why Linux needs this
feature - what are the use cases, what is the value to our users?

Can you please flesh that information out a bit more?

The patches are somewhat wordwrapped - please check your email client
configuration, thanks.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
