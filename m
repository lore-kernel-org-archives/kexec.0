Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mgwym04.jp.fujitsu.com ([211.128.242.43])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1e1qpR-0005dr-LB
 for kexec@lists.infradead.org; Tue, 10 Oct 2017 09:28:00 +0000
Received: from g01jpfmpwyt01.exch.g01.fujitsu.local
 (g01jpfmpwyt01.exch.g01.fujitsu.local [10.128.193.38])
 by yt-mxq.gw.nic.fujitsu.com (Postfix) with ESMTP id 45333AC0146
 for <kexec@lists.infradead.org>; Tue, 10 Oct 2017 18:27:28 +0900 (JST)
From: Takao Indoh <indou.takao@jp.fujitsu.com>
Subject: [PATCH 0/3] Fix KASLR problem on sadump
Date: Tue, 10 Oct 2017 18:27:14 +0900
Message-ID: <20171010092717.7392-1-indou.takao@jp.fujitsu.com>
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
To: ats-kumagai@wm.jp.nec.com, d.hatayama@jp.fujitsu.com
Cc: kexec@lists.infradead.org

Hi Kumagai-san, Hatayama-san,

These patch series fix a problem that makedumpfile cannot handle a dumpfile
which is captured by sadump on KASLR enabled kernel.

When KASLR feature is enabled, a kernel is placed on the memory randomly and
therefore makedumpfile cannot handle a dumpfile because addresses of kernel
symbols in vmlinux are different from actual addresses. In the case of kdump,
information to get actual address is included in the vmcoreinfo, but dumpfile of
sadump does not have such a information.

These patches calculate kaslr offset and phys_base to solve this problem. The
basic idea is getting register (IDTR and CR3) from dump header, and calculate
kaslr_offset/phys_base using them.

Takao Indoh (3):
  Support symbol __cpu_online_mask
  makedumpfile: Introduce vtop4_x86_64_pagetable
  makedumpfile: sadump: Fix a KASLR problem of sadump

 arch/x86_64.c  |  30 ++++-
 makedumpfile.c |  22 ++-
 makedumpfile.h |   7 +-
 sadump_info.c  | 420 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 466 insertions(+), 13 deletions(-)

-- 
2.9.5



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
