Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IUdbn-000350-1C
	for kexec@lists.infradead.org; Mon, 10 Sep 2007 03:23:01 -0400
Subject: [PATCH 0/3] [-mm patch] Cleanup add-vmcoreinfo.patch
Message-Id: <20070910162305oomichi@mail.jp.nec.com>
Mime-Version: 1.0
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
Date: Mon, 10 Sep 2007 16:23:05 +0900
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
Cc: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>, kexec-ml <kexec@lists.infradead.org>, lkml <linux-kernel@vger.kernel.org>


Hi Andrew,

On Fri, Aug 31, 2007 at 09:58:22PM -0700, Andrew Morton wrote:
> Changes since 2.6.23-rc3-mm1:
> [snip]
> +add-vmcoreinfo.patch
>

Thank you for merging add-vmcoreinfo.patch.
I created the patchset for your comments and some corrections.
The patchset is for linux-2.6.23-rc4-mm1.

[1/3] Cleanup the coding style according to Andrew's comments:
http://lists.infradead.org/pipermail/kexec/2007-August/000522.html
- vmcoreinfo_append_str() should have suitable __attribute__s so that
  the compiler can check its use.
- vmcoreinfo_max_size should have size_t.
- Use get_seconds() instead of xtime.tv_sec.
- Use init_uts_ns.name.release instead of UTS_RELEASE.

[2/3] Add nodemask_t's size and NR_FREE_PAGES's value to vmcoreinfo_data.
  The dump filetering command 'makedumpfile'(v1.1.6 or before) had assumed
  the above values, and it was not good from the reliability viewpoint.
  So makedumpfile v1.2.0 came to need these values and I created the patch
  to let the kernel output them.
  makedumpfile site:
  https://sourceforge.net/projects/makedumpfile/

[3/3] Use the existing ia64_tpa() instead of asm code.


Thanks
Ken'ichi Ohmichi

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
