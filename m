Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IW1FE-00026W-7t
	for kexec@lists.infradead.org; Thu, 13 Sep 2007 22:49:27 -0400
Message-Id: <46E9F6A9.8060500@mxs.nes.nec.co.jp>
Date: Fri, 14 Sep 2007 11:49:13 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Subject: [PATCH 0/4] [-mm patch]  Cleanup add-vmcoreinfo.patch v2
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Adrian Bunk <bunk@kernel.org>, kexec-ml <kexec@lists.infradead.org>, lkml <linux-kernel@vger.kernel.org>


Hi Andrew,

I updated the cleanup patchset for add-vmcoreinfo.patch.
* Cleanup add-vmcoreinfo.patch v1:
http://www.ussg.iu.edu/hypermail/linux/kernel/0709.1/0318.html

This patchset (v2) includes a new patch[4/4] for adding a prefix
"VMCOREINFO_" to the vmcoreinfo macros. Other patches ([1/4]-[3/4])
don't have any changes.

Changelog:
  - Add "Add a prefix VMCOREINFO_ to the vmcoreinfo macros" patch.

Patchset:
[1/4] Cleanup the coding style according to Andrew's comments:
  http://lists.infradead.org/pipermail/kexec/2007-August/000522.html
  - vmcoreinfo_append_str() should have suitable __attribute__s so that
    the compiler can check its use.
  - vmcoreinfo_max_size should have size_t.
  - Use get_seconds() instead of xtime.tv_sec.
  - Use init_uts_ns.name.release instead of UTS_RELEASE.

[2/4] Add nodemask_t's size and NR_FREE_PAGES's value to vmcoreinfo_data.
  The dump filetering command 'makedumpfile'(v1.1.6 or before) had assumed
  the above values, and it was not good from the reliability viewpoint.
  So makedumpfile v1.2.0 came to need these values and I created the patch
  to let the kernel output them.
  makedumpfile site:
  https://sourceforge.net/projects/makedumpfile/

[3/4] Use the existing ia64_tpa() instead of asm code.

[4/4] Add a prefix "VMCOREINFO_" to the vmcoreinfo macros.
  Old vmcoreinfo macros were defined as generic names SYMBOL/SIZE/OFFSET
  /LENGTH/CONFIG, and it is impossible to grep for them. So these names
  should be changed. This discussion is the following:
  http://www.ussg.iu.edu/hypermail/linux/kernel/0709.1/0415.html


Thanks
Ken'ichi Ohmichi


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
