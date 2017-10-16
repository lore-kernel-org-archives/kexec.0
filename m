Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mgwkm01.jp.fujitsu.com ([202.219.69.168])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1e41vA-0006W8-Je
 for kexec@lists.infradead.org; Mon, 16 Oct 2017 09:42:58 +0000
Received: from g01jpfmpwkw02.exch.g01.fujitsu.local
 (g01jpfmpwkw02.exch.g01.fujitsu.local [10.0.193.56])
 by kw-mxoi2.gw.nic.fujitsu.com (Postfix) with ESMTP id A4BA5AC0151
 for <kexec@lists.infradead.org>; Mon, 16 Oct 2017 18:42:25 +0900 (JST)
From: Takao Indoh <indou.takao@jp.fujitsu.com>
Subject: [makedumpfile PATCH v2 0/3] Fix KASLR problem on sadump
Date: Mon, 16 Oct 2017 18:42:14 +0900
Message-ID: <20171016094217.1020-1-indou.takao@jp.fujitsu.com>
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

Hatayama-san, thanks for your review, I updated may patch.

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

changelog:
v2:
- Change get_vec0_addr style
- Some tiny fixes

v1:
http://lists.infradead.org/pipermail/kexec/2017-October/019530.html

Takao Indoh (3):
  Support symbol __cpu_online_mask
  Introduce vtop4_x86_64_pagetable
  sadump: Fix a KASLR problem of sadump

 arch/x86_64.c  |  30 ++++-
 makedumpfile.c |  20 ++-
 makedumpfile.h |   8 +-
 sadump_info.c  | 418 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 463 insertions(+), 13 deletions(-)

-- 
2.9.5



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
