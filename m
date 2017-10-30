Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo161.gate.nec.co.jp ([114.179.232.161])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1e93Rx-0001B0-9N
 for kexec@lists.infradead.org; Mon, 30 Oct 2017 06:21:31 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: RE: [makedumpfile PATCH v3 0/4] Fix KASLR problem on sadump
Date: Mon, 30 Oct 2017 06:19:05 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701F20C34@BPXM01GP.gisp.nec.co.jp>
References: <20171026113227.36740-1-indou.takao@jp.fujitsu.com>
In-Reply-To: <20171026113227.36740-1-indou.takao@jp.fujitsu.com>
Content-Language: ja-JP
MIME-Version: 1.0
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
To: Takao Indoh <indou.takao@jp.fujitsu.com>, "d.hatayama@jp.fujitsu.com" <d.hatayama@jp.fujitsu.com>
Cc: Keiichirou Suzuki <kei-suzuki@xr.jp.nec.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hello Indoh-san,

>Hi Kumagai-san, Hatayama-san,
>
>These patch series fix a problem that makedumpfile cannot handle a dumpfile
>which is captured by sadump on KASLR enabled kernel.
>
>When KASLR feature is enabled, a kernel is placed on the memory randomly and
>therefore makedumpfile cannot handle a dumpfile because addresses of kernel
>symbols in vmlinux are different from actual addresses. In the case of kdump,
>information to get actual address is included in the vmcoreinfo, but dumpfile of
>sadump does not have such a information.
>
>These patches calculate kaslr offset and phys_base to solve this problem. The
>basic idea is getting register (IDTR and CR3) from dump header, and calculate
>kaslr_offset/phys_base using them.
>
>changelog:
>v3:
>- Split patch 3/3 into two parts
>  - core part to calculate kaslr_offset and phys_base
>  - Additional part to fix this problem during kdump

Thanks for your work, I'll merge this version into v1.6.3.

Regards,
Atsushi Kumagai

>v2:
>http://lists.infradead.org/pipermail/kexec/2017-October/019554.html
>- Change get_vec0_addr style
>- Some tiny fixes
>
>v1:
>http://lists.infradead.org/pipermail/kexec/2017-October/019530.html
>
>Takao Indoh (4):
>  Support symbol __cpu_online_mask
>  Introduce vtop4_x86_64_pagetable
>  sadump: Fix a KASLR problem of sadump
>  sadump: Fix a KASLR problem of sadump while kdump is working
>
> arch/x86_64.c  |  30 ++++-
> makedumpfile.c |  20 ++-
> makedumpfile.h |   8 +-
> sadump_info.c  | 417 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
> 4 files changed, 462 insertions(+), 13 deletions(-)
>
>--
>2.9.5
>
>



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
