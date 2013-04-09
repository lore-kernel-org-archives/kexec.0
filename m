Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UPUUe-0004Jb-7W
 for kexec@lists.infradead.org; Tue, 09 Apr 2013 09:05:34 +0000
Received: from mailgate3.nec.co.jp ([10.7.69.193])
 by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id r3995N3o016468
 for <kexec@lists.infradead.org>; Tue, 9 Apr 2013 18:05:23 +0900 (JST)
Received: (from root@localhost) by mailgate3.nec.co.jp
 (8.11.7/3.7W-MAILGATE-NEC)
 id r3995Mh09882 for kexec@lists.infradead.org;
 Tue, 9 Apr 2013 18:05:22 +0900 (JST)
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
 by mailsv4.nec.co.jp (8.13.8/8.13.4) with ESMTP id r3995M6W007688
 for <kexec@lists.infradead.org>; Tue, 9 Apr 2013 18:05:22 +0900 (JST)
Date: Tue, 9 Apr 2013 17:27:06 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: [PATCH 0/4] Add support for vmap_area_list.
Message-Id: <20130409172706.d6eda15764b0ef2700588e74@mxc.nes.nec.co.jp>
Mime-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

Hello,

This patchset is to work with "remove vm_struct list management":

  https://lkml.org/lkml/2013/3/13/40

I tested this on i386/x86_64, but I can't do it on other 
architectures. So, please let me know if you find any problems.

---

Atsushi Kumagai (4):
      Introduce new symbols to look at the first vmap_area.
      Use vmap_area_list to get vmalloc_start for i386.
      Use vmap_area_list to get vmalloc_start for ppc32.
      Use vmap_area_list to get vmalloc_start for ppc64.

 arch/ppc.c     | 46 ++++++++++++++++++++++++++++++++--------------
 arch/ppc64.c   | 46 ++++++++++++++++++++++++++++++++--------------
 arch/x86.c     | 46 ++++++++++++++++++++++++++++++++--------------
 makedumpfile.c |  9 +++++++++
 makedumpfile.h |  5 +++++
 5 files changed, 110 insertions(+), 42 deletions(-)


Thanks
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
