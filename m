Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Isr0Q-0007Wy-Fh
	for kexec@lists.infradead.org; Thu, 15 Nov 2007 21:32:37 -0500
Message-Id: <473D0156.3000203@mxs.nes.nec.co.jp>
Date: Fri, 16 Nov 2007 11:32:54 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Subject: [PATCH 0/5] vmcoreinfo patches for linux-2.6.24-rc3
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1737520464=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: lkml <linux-kernel@vger.kernel.org>, kexec-ml <kexec@lists.infradead.org>

--===============1737520464==
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit


Hi,

This patchset is for the vmcoreinfo data.

The vmcoreinfo data has the minimum debugging information only
for dump filtering. makedumpfile (dump filtering command) gets
it to distinguish unnecessary pages, and makedumpfile creates
a small dumpfile.

[PATCH 1/5] Rename vmcoreinfo's macros returning the size
[PATCH 2/5] Use the existing offsetof() for VMCOREINFO_OFFSET()
[PATCH 3/5] Add "VMCOREINFO_" to all the call for vmcoreinfo_append_str()
[PATCH 4/5] Fix the configuration dependencies
[PATCH 5/5] Add the array length of "free_list" for filtering free pages

Patch 1-3 are cleanup patches, and they are the same as I sent before:
 http://www.ussg.iu.edu/hypermail/linux/kernel/0709.3/0582.html
 http://www.ussg.iu.edu/hypermail/linux/kernel/0709.3/0584.html
 http://www.ussg.iu.edu/hypermail/linux/kernel/0709.3/0586.html
Patch 4 is a new patch for fixing the configuration dependencies.
Patch 5 is a new patch for filtering free pages of linux-2.6.24.

Their details are explained in each patch.

I confirmed that their coding styles are right by checkpatch.pl and tested
them on my i386, x86_64 and ia64.


Thanks
Ken'ichi Ohmichi












--===============1737520464==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============1737520464==--
