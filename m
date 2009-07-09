Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1MOneY-0002fc-7G
	for kexec@lists.infradead.org; Thu, 09 Jul 2009 07:02:54 +0000
Received: from m5.gw.fujitsu.co.jp ([10.0.50.75])
	by fgwmail7.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id
	n6972eJE011509 for <kexec@lists.infradead.org> (envelope-from
	seto.hidetoshi@jp.fujitsu.com); Thu, 9 Jul 2009 16:02:40 +0900
Received: from smail (m5 [127.0.0.1])
	by outgoing.m5.gw.fujitsu.co.jp (Postfix) with ESMTP id C8B4845DE2F
	for <kexec@lists.infradead.org>; Thu,  9 Jul 2009 16:02:39 +0900 (JST)
Received: from s5.gw.fujitsu.co.jp (s5.gw.fujitsu.co.jp [10.0.50.95])
	by m5.gw.fujitsu.co.jp (Postfix) with ESMTP id A00E945DE54
	for <kexec@lists.infradead.org>; Thu,  9 Jul 2009 16:02:39 +0900 (JST)
Received: from s5.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s5.gw.fujitsu.co.jp (Postfix) with ESMTP id 5CECFE1800A
	for <kexec@lists.infradead.org>; Thu,  9 Jul 2009 16:02:39 +0900 (JST)
Received: from m105.s.css.fujitsu.com (m105.s.css.fujitsu.com [10.249.87.105])
	by s5.gw.fujitsu.co.jp (Postfix) with ESMTP id 8B7701DB805B
	for <kexec@lists.infradead.org>; Thu,  9 Jul 2009 16:02:38 +0900 (JST)
Message-ID: <4A5595F3.2050609@jp.fujitsu.com>
Date: Thu, 09 Jul 2009 16:02:11 +0900
From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
MIME-Version: 1.0
Subject: [PATCH v2 0/7] Patches for kdump vs. INIT
References: <4A39E247.4030908@jp.fujitsu.com>
In-Reply-To: <4A39E247.4030908@jp.fujitsu.com>
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
Cc: Haren Myneni <hbabu@us.ibm.com>, "Luck, Tony" <tony.luck@intel.com>, kexec@lists.infradead.org, Vivek Goyal <vgoyal@redhat.com>, "Yu,
	Fenghua" <fenghua.yu@intel.com>

Hi all,

Here is the updated version:
 - Better descriptions with justifiable reasons
 - Add comments to point where the mask is removed
 - Move extern to header file
 - Minor fix for style, typo
 - No changes in logic

Thanks,
H.Seto

===

Hidetoshi Seto (7):
      ia64, kdump: Mask MCA/INIT on frozen cpus
      ia64, kexec: Make INIT safe while transition to kdump/kexec kernel
      ia64, kexec: Unregister MCA handler before kexec
      ia64, kdump: Don't return APs to SAL from kdump
      ia64, kdump: Mask INIT first in panic-kdump path
      ia64, kdump: Try INIT regardless of kdump_on_init
      ia64, kdump: Short path to freeze CPUs

 arch/ia64/include/asm/mca.h        |    2 +
 arch/ia64/kernel/crash.c           |   83 ++++++++++++++++++++++++-----------
 arch/ia64/kernel/head.S            |    2 +-
 arch/ia64/kernel/machine_kexec.c   |   15 ++++++
 arch/ia64/kernel/mca.c             |   15 ++++++-
 arch/ia64/kernel/mca_asm.S         |   47 ++++++++++++++++++++
 arch/ia64/kernel/relocate_kernel.S |    2 +-
 7 files changed, 136 insertions(+), 30 deletions(-)

Hidetoshi Seto wrote:
> Hi Tony-san, and kdump folks,
> 
> I got some trouble on kdump on IPF with INIT, and my investigation
> proves there are some bugs and races in startup of kdump.
> Here are fixes based on .30, for issues I found.
> 
> Since it must be serious problem for (likely big) IPF servers if we
> could fail to retrieve crashdump via kdump, so I believe these patches
> should be applied asap.
> 
> 
> Thanks,
> H.Seto
> 
> ===
> 
> Hidetoshi Seto (7):
>       ia64, kdump: Mask MCA/INIT on freezing cpus
>       ia64, kexec: Make INIT safe while kdump/kexec
>       ia64, kexec: Unregister MCA handler before kexec
>       ia64, kdump: Don't offline APs
>       ia64, kdump: Mask INIT first in panic-kdump path
>       ia64, kdump: Try INIT regardless of kdump_on_init
>       ia64, kdump: Short path to freeze CPUs
> 
>  arch/ia64/kernel/crash.c         |   85 ++++++++++++++++++++++++++------------
>  arch/ia64/kernel/machine_kexec.c |   17 ++++++++
>  arch/ia64/kernel/mca.c           |   15 ++++++-
>  arch/ia64/kernel/mca_asm.S       |   47 +++++++++++++++++++++
>  4 files changed, 136 insertions(+), 28 deletions(-)



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
