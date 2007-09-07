Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1ITZer-0001bx-9s
	for kexec@lists.infradead.org; Fri, 07 Sep 2007 04:57:51 -0400
Subject: [PATCH 0/2] vmcoreinfo support for dump filtering #2
Message-Id: <20070907175746oomichi@mail.jp.nec.com>
Mime-Version: 1.0
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
Date: Fri, 7 Sep 2007 17:57:46 +0900
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
To: kexec-ml <kexec@lists.infradead.org>
Cc: Vivek Goyal <vgoyal@in.ibm.com>, Dan Aloni <da-x@monatomic.org>


Hi,

I released a new makedumpfile (version 1.2.0) with vmcoreinfo support.
I updated the patches for linux and kexec-tools.

- Change of linux patch:
  Old makedumpfile assumed some values (the size of nodemask_t and the
  value of NR_FREE_PAGES), and it was not good on the reliability viewpoint.
  For the reliability improvement, makedumpfile came to need these values
  and I updated the kernel patch to output them.

- Chage of kexec-tools patch:
  Vivek Goyal informed that the kexec command with old vmcoreinfo patch
  didn't work on kernels without vmcoreinfo patch. It gave the following
  error message, so I updated the patch of kexec-tools for fixing the
  problem:
    Could not open "/sys/kernel/vmcoreinfo": No such file or directory


PATCH SET:
[1/2] [linux-2.6.22] Add vmcoreinfo
  The patch is for linux-2.6.22.
  The patch adds the vmcoreinfo data. Its address and size are output
  to /sys/kernel/vmcoreinfo.

  Changelog:
  - Add the size of nodemask_t and the value of NR_FREE_PAGES to the
    vmcoreinfo data.

[2/2] [kexec-tools] Pass vmcoreinfo's address and size
  The patch is for kexec-tools-testing-20070330.
  (http://www.kernel.org/pub/linux/kernel/people/horms/kexec-tools/)
  kexec command gets the address and size of the vmcoreinfo data from
  /sys/kernel/vmcoreinfo, and passes them to the second kernel through
  ELF header of /proc/vmcore. When the second kernel is booting, the
  kernel gets them from the ELF header and creates vmcoreinfo's PT_NOTE
  segment into /proc/vmcore.

  Changelog:
  - Fix the problem that the kexec command cannnot be executed on kernels
    without vmcoreinfo.


Thanks
Ken'ichi Ohmichi

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
