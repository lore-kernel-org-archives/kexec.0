Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1MHBMP-0005sB-OR
	for kexec@lists.infradead.org; Thu, 18 Jun 2009 06:44:41 +0000
Received: from m1.gw.fujitsu.co.jp ([10.0.50.71])
	by fgwmail5.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id
	n5I6iQKl021321 for <kexec@lists.infradead.org> (envelope-from
	seto.hidetoshi@jp.fujitsu.com); Thu, 18 Jun 2009 15:44:26 +0900
Received: from smail (m1 [127.0.0.1])
	by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 1BA9645DE52
	for <kexec@lists.infradead.org>; Thu, 18 Jun 2009 15:44:26 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
	by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id ED0BF45DE4F
	for <kexec@lists.infradead.org>; Thu, 18 Jun 2009 15:44:25 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id CF3F11DB8042
	for <kexec@lists.infradead.org>; Thu, 18 Jun 2009 15:44:25 +0900 (JST)
Received: from m107.s.css.fujitsu.com (m107.s.css.fujitsu.com [10.249.87.107])
	by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 855C51DB803C
	for <kexec@lists.infradead.org>; Thu, 18 Jun 2009 15:44:25 +0900 (JST)
Message-ID: <4A39E247.4030908@jp.fujitsu.com>
Date: Thu, 18 Jun 2009 15:44:23 +0900
From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
MIME-Version: 1.0
Subject: [PATCH 0/7] Patches for kdump vs. INIT
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
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
To: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Haren Myneni <hbabu@us.ibm.com>, kexec@lists.infradead.org, Vivek Goyal <vgoyal@redhat.com>

Hi Tony-san, and kdump folks,

I got some trouble on kdump on IPF with INIT, and my investigation
proves there are some bugs and races in startup of kdump.
Here are fixes based on .30, for issues I found.

Since it must be serious problem for (likely big) IPF servers if we
could fail to retrieve crashdump via kdump, so I believe these patches
should be applied asap.


Thanks,
H.Seto

===

Hidetoshi Seto (7):
      ia64, kdump: Mask MCA/INIT on freezing cpus
      ia64, kexec: Make INIT safe while kdump/kexec
      ia64, kexec: Unregister MCA handler before kexec
      ia64, kdump: Don't offline APs
      ia64, kdump: Mask INIT first in panic-kdump path
      ia64, kdump: Try INIT regardless of kdump_on_init
      ia64, kdump: Short path to freeze CPUs

 arch/ia64/kernel/crash.c         |   85 ++++++++++++++++++++++++++------------
 arch/ia64/kernel/machine_kexec.c |   17 ++++++++
 arch/ia64/kernel/mca.c           |   15 ++++++-
 arch/ia64/kernel/mca_asm.S       |   47 +++++++++++++++++++++
 4 files changed, 136 insertions(+), 28 deletions(-)



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
