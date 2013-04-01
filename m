Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UMXZE-0007AX-OI
 for kexec@lists.infradead.org; Mon, 01 Apr 2013 05:46:05 +0000
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id A9FB93EE0BC
 for <kexec@lists.infradead.org>; Mon,  1 Apr 2013 14:45:57 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
 by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 8BF2245DE50
 for <kexec@lists.infradead.org>; Mon,  1 Apr 2013 14:45:57 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
 by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 6B30145DE4D
 for <kexec@lists.infradead.org>; Mon,  1 Apr 2013 14:45:57 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 5C4AD1DB803F
 for <kexec@lists.infradead.org>; Mon,  1 Apr 2013 14:45:57 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 083181DB8037
 for <kexec@lists.infradead.org>; Mon,  1 Apr 2013 14:45:57 +0900 (JST)
Message-ID: <51591EEE.60401@jp.fujitsu.com>
Date: Mon, 01 Apr 2013 14:45:18 +0900
From: Takao Indoh <indou.takao@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH] intel-iommu: Synchronize gcmd value with global command
 register
References: <1363829556-2128-1-git-send-email-indou.takao@jp.fujitsu.com>
 <20130326144629.GB2727@8bytes.org> <51527D74.9080209@jp.fujitsu.com>
 <20130327103122.GK30540@8bytes.org>
In-Reply-To: <20130327103122.GK30540@8bytes.org>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: joro@8bytes.org
Cc: kexec@lists.infradead.org, iommu@lists.linux-foundation.org, dwmw2@infradead.org, linux-kernel@vger.kernel.org

(2013/03/27 19:31), Joerg Roedel wrote:
> On Wed, Mar 27, 2013 at 02:02:44PM +0900, Takao Indoh wrote:
>> The root cause of this problem is mismatch between iommu->gcmd and
>> global command register in the case of kdump. At boot time, initial
>> value of iommu->gcmd is zero as I wrote above, but actual global command
>> register is *not* zero because some bits like IRE/TE/QIE are already set
>> in *first* kernel. Therefore this patch synchronize them to fix this
>> problem.
> 
> Ok, I understand, but I still don't see why this is a problem. There is
> no point for the kdump kernel to preserve hardware state from the
> previous kernel. So I think the way it is implemented is correct.

Sorry, my explanation was misleading. The purpose is not preserving
hardware state, but cleaning up hardware status at appropriate place.

kdump kernel boots up without power-on-reset, so we have to disable
hardware functions like DMAR before initializing them.

<Current flow on kdump boot>
enable_IR
  intel_enable_irq_remapping
    iommu_disable_irq_remapping  <== IRES/QIES/TES disabled here
    dmar_disable_qi              <== do nothing
    dmar_enable_qi               <== QIES enabled
    intel_setup_irq_remapping    <== IRES enabled

intel_iommu_init
  init_dmars
    iommu_enable_translation     <== TES enabled


<New flow on kdump boot after applying patch>
enable_IR
  intel_enable_irq_remapping
    iommu_disable_irq_remapping  <== IRES disabled
    dmar_disable_qi              <== QIES disabled
    dmar_enable_qi               <== QIES enabled
    intel_setup_irq_remapping    <== IRES enabled

intel_iommu_init
  init_dmars
    iommu_disable_translation    <== TES disabled (added by patch)
    iommu_enable_translation     <== TES enabled

I want to change flow like this to avoid misunderstanding. In that sense,
this patch is a kind of cleanup rather than fixing problem.

Backgroud:
I'm working on kdump problem with iommu and investigated when DMAR and
IR are disabled in kdump kernel boot. As for IR, I can easily find the
code in intel_enable_irq_remapping() since there is good comment for
that.

                /*
                 * Disable intr remapping and queued invalidation, if already
                 * enabled prior to OS handover.
                 */
                iommu_disable_irq_remapping(iommu);

                dmar_disable_qi(iommu);

However, there is no code to disable DMAR on startup, but it is actually
disabled somewhere during bootup. And finally I found out is is done in
intel_enable_irq_remapping(). This is very misleading. Why
"iommu_disable_irq_remapping" is disabling bits other than IR? After
applying patch, it is easy to understand because it disables only IR, as
the name suggests.

Thanks,
Takao Indoh


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
