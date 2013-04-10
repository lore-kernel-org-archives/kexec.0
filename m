Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UPpBW-0005OQ-MT
 for kexec@lists.infradead.org; Wed, 10 Apr 2013 07:11:12 +0000
Date: Wed, 10 Apr 2013 15:05:24 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: [RESEND PATCH 0/4] Add support for vmap_area_list.
Message-Id: <20130410150524.804cd23b99a697f71146be67@mxc.nes.nec.co.jp>
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
Cc: linuxppc-dev@lists.ozlabs.org

# CCing linuxppc-dev to get advice on ppc for makedumpfile.
# makedumpfile is a userspace utility to create a smaller dump file,
# you can download it from the following URL.
# http://sourceforge.net/projects/makedumpfile/

-----
Hello,

This patchset is to work with "remove vm_struct list management":

  https://lkml.org/lkml/2013/3/13/40

In more detail, this patchset try to use vmap_area_list to get the
start address of vmalloc region.

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
