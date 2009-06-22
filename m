Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-yx0-f202.google.com ([209.85.210.202])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1MIdN0-0007SP-5F
	for kexec@lists.infradead.org; Mon, 22 Jun 2009 06:51:17 +0000
Received: by yxe40 with SMTP id 40so951031yxe.28
	for <kexec@lists.infradead.org>; Sun, 21 Jun 2009 23:50:55 -0700 (PDT)
Message-ID: <5AA89A0287224699B8E5C0526CE0EA41@Lanx8664>
From: "Jay Lan" <jay.zen.lan@gmail.com>
References: <4A39E247.4030908@jp.fujitsu.com>
In-Reply-To: <4A39E247.4030908@jp.fujitsu.com>
Subject: Re: [PATCH 0/7] Patches for kdump vs. INIT
Date: Sun, 21 Jun 2009 23:31:13 -0700
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Haren Myneni <hbabu@us.ibm.com>, kexec@lists.infradead.org, Vivek Goyal <vgoyal@redhat.com>

Kdump with INIT on IPF worked on SGI's IA64 servers when i left SGI last 
December.
Is this problem something new to you after .27?

SGI folks should test this patchset to ensure no surprise is introduced to 
their servers.

Cheers,
jay

----- Original Message ----- 
From: "Hidetoshi Seto" <seto.hidetoshi@jp.fujitsu.com>
To: <linux-ia64@vger.kernel.org>; <linux-kernel@vger.kernel.org>
Cc: "Haren Myneni" <hbabu@us.ibm.com>; <kexec@lists.infradead.org>; "Vivek 
Goyal" <vgoyal@redhat.com>
Sent: Wednesday, June 17, 2009 11:44 PM
Subject: [PATCH 0/7] Patches for kdump vs. INIT


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
>      ia64, kdump: Mask MCA/INIT on freezing cpus
>      ia64, kexec: Make INIT safe while kdump/kexec
>      ia64, kexec: Unregister MCA handler before kexec
>      ia64, kdump: Don't offline APs
>      ia64, kdump: Mask INIT first in panic-kdump path
>      ia64, kdump: Try INIT regardless of kdump_on_init
>      ia64, kdump: Short path to freeze CPUs
>
> arch/ia64/kernel/crash.c         |   85 
> ++++++++++++++++++++++++++------------
> arch/ia64/kernel/machine_kexec.c |   17 ++++++++
> arch/ia64/kernel/mca.c           |   15 ++++++-
> arch/ia64/kernel/mca_asm.S       |   47 +++++++++++++++++++++
> 4 files changed, 136 insertions(+), 28 deletions(-)
>
>
>
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
