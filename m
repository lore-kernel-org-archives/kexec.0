Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IS75V-0006yt-QI
	for kexec@lists.infradead.org; Mon, 03 Sep 2007 04:15:17 -0400
Subject: Re: [PATCH 0/3] vmcoreinfo support for dump filtering
In-reply-to: <20070822210838oomichi@mail.jp.nec.com>
Message-Id: <20070903171508oomichi@mail.jp.nec.com>
References: <20070822210838oomichi@mail.jp.nec.com>
Mime-Version: 1.0
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
Date: Mon, 3 Sep 2007 17:15:08 +0900
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
Cc: Don Zickus <dzickus@redhat.com>, Neil Horman <nhorman@redhat.com>, Dan Aloni <da-x@monatomic.org>, Bernhard Walle <bwalle@suse.de>, lkml <linux-kernel@vger.kernel.org>, Vivek Goyal <vgoyal@in.ibm.com>, Andrew Morton <akpm@linux-foundation.org>


Hi,

2007/08/22 21:08:38 +0900, Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp> wrote:
>
>Hi Andrew,
>
>This patch set frees the restriction that makedumpfile users should
>install a vmlinux file (including the debugging information) into
>each system.
>
>makedumpfile command is the dump filtering feature for kdump.
>It creates a small dumpfile by filtering unnecessary pages for the
>analysis. To distinguish unnecessary pages, it needs a vmlinux file
>including the debugging information. These days, the debugging package
>becomes a huge file, and it is hard to install it into each system.
>
>To solve the problem, kdump developers discussed it at lkml and kexec-ml.
>As the result, we reached the conclusion that necessary information
>for dump filtering (called "vmcoreinfo") should be embedded into the
>first kernel file and it should be accessed through /proc/vmcore
>during the second kernel.
>(http://www.uwsg.iu.edu/hypermail/linux/kernel/0707.0/1806.html) 
>
>Dan Aloni created the patch set for the above implementation.
>(http://www.uwsg.iu.edu/hypermail/linux/kernel/0707.1/1053.html)
>
>And I updated it for multi architectures and memory models.
>(http://lists.infradead.org/pipermail/kexec/2007-August/000479.html)
>
>
>PATCH SET:
>[1/3] [linux] Add vmcoreinfo
>  The patch is for linux-2.6.22.
>  The patch adds the vmcoreinfo data. Its address and size are output
>  to /sys/kernel/vmcoreinfo.

The patch for linux (add-vmcoreinfo.patch) is included in 2.6.23-rc4-mm1.
http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.23-rc4/2.6.23-rc4-mm1/announce.txt

Thank you for your cooperation.


>[2/3] [kexec-tools] Pass vmcoreinfo's address and size
>  The patch is for kexec-tools-testing-20070330.
>  (http://www.kernel.org/pub/linux/kernel/people/horms/kexec-tools/)
>  kexec command gets the address and size of the vmcoreinfo data from
>  /sys/kernel/vmcoreinfo, and passes them to the second kernel through
>  ELF header of /proc/vmcore. When the second kernel is booting, the
>  kernel gets them from the ELF header and creates vmcoreinfo's PT_NOTE
>  segment into /proc/vmcore.

Horms, could you please merge the above patch ?


>[3/3] [makedumpfile] Extract vmcoreinfo from /proc/vmcore
>  The patch is for makedumpfile v1.1.6.
>  (https://sourceforge.net/projects/makedumpfile/)
>  makedumpfile command extracts the vmcoreinfo data from /proc/vmcore
>  and uses it for dump filtering.

I will release the next makedumpfile with the above patch.


Thanks
Ken'ichi Ohmichi

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
