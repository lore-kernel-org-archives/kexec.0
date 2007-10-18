Return-path: <kexec-bounces@lists.infradead.org>
Received: from tyo200.gate.nec.co.jp ([210.143.35.50])
	by pentafluge.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IiPD1-0007xE-BO
	for kexec@lists.infradead.org; Thu, 18 Oct 2007 07:50:22 +0100
Received: from tyo201.gate.nec.co.jp ([10.7.69.201])
	by tyo200.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id l9I6lldJ015858
	for <kexec@lists.infradead.org>; Thu, 18 Oct 2007 15:47:47 +0900 (JST)
Message-ID: <471700F4.1080200@ah.jp.nec.com>
Date: Thu, 18 Oct 2007 15:45:08 +0900
From: Takenori Nagano <t-nagano@ah.jp.nec.com>
MIME-Version: 1.0
Subject: [PATCH 0/2] add new notifier function ,take2
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
To: linux-kernel@vger.kernel.org
Cc: k-miyoshi@cb.jp.nec.com, Bernhard Walle <bwalle@suse.de>, kdb@oss.sgi.com, kexec@lists.infradead.org, vgoyal@in.ibm.com, "Eric W. Biederman" <ebiederm@xmission.com>, Keith Owens <kaos@ocs.com.au>, Andrew Morton <akpm@linux-foundation.org>

Hi,

A big thanks to everybody who read and replied to first version. I have tried to
incorporate reviewer's comments and suggestions.

changelog take1 -> take2

- Rebased 2.6.23
- comment updated
- renamed the notifiner name "tunable_notifier" to "tunable_atomic_notifier"
- fixed typo


These patches add new notifier function and implement it to panic_notifier_list.
We used the hardcoded notifier chain so far, but it was not flexible. New
notifier is very flexible, because user can change a list of order by debugfs.

Thanks,

Example)

# cd /sys/kernel/debug/
# ls
kprobes  pktcdvd
# insmod ipmi_msghandler.ko
# ls
kprobes  panic_notifier_list  pktcdvd
# cd panic_notifier_list/
# ls
ipmi_msghandler
# insmod ipmi_watchdog.ko
# ls
ipmi_msghandler  ipmi_wdog
# cat ipmi_msghandler/priority
200
# cat ipmi_wdog/priority
150
#
Kernel panic - not syncing: panic
ipmi_msghandler : notifier calls panic_event().
ipmi_watchdog : notifier calls wdog_panic_handler().

.....(reboot)

# cat ipmi_msghandler/priority
200
# cat ipmi_wdog/priority
150
# echo 300 > ipmi_wdog/priority
#
Kernel panic - not syncing: panic
ipmi_watchdog : notifier calls wdog_panic_handler().
ipmi_msghandler : notifier calls panic_event().

--
Takenori Nagano <t-nagano@ah.jp.nec.com>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
