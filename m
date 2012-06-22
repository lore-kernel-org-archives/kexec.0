Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from dgate10.ts.fujitsu.com ([80.70.172.49])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1Si5d2-00042g-NA
 for kexec@lists.infradead.org; Fri, 22 Jun 2012 15:18:34 +0000
Received: from sanpedro.osd.mch.fsc.net (sanpedro.osd.mch.fsc.net
 [172.17.20.6])
 by sanpedro.mch.fsc.net (Postfix) with ESMTP id EF3D2968416
 for <kexec@lists.infradead.org>; Fri, 22 Jun 2012 17:18:05 +0200 (CEST)
From: Norbert Trapp <Norbert.Trapp@ts.fujitsu.com>
Subject: [PATCH 0/3] makedumpfile: Xen4: exclude domU pages for Xen4
Date: Fri, 22 Jun 2012 17:18:05 +0200
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <201206221718.05680.Norbert.Trapp@ts.fujitsu.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org


Saving just the dom0 and Xen pages is a good idea because usually
the crash can be analysed in dom0 and saving just the Xen and dom0 pages
allows the machine to restart quickly.

makedumpfile needs to be modified to exclude domU pages when using Xen4
since the Xen implementation has changed. The Xen version can be determined
in the kcore file and then either Xen3 or Xen4 functions are used. The other
modifications are based on the goal of quickly finding the dom0 and Xen pages.

The domU page exclusion for Xen4 is implemented so far just for x86_64.

The kvtop_xen_x86_64 modification for a faster method to run through the page
table	(last_p.._read)	was seen in the crash utility source code.

 arch/x86_64.c  |  244 ++++++++++++++++++++++++++++----------
 elf_info.c     |    2 +
 makedumpfile.c |  362 ++++++++++++++++++++++++++++++++++++++++++++++++++++----
 makedumpfile.h |   79 +++++++++++--
 4 files changed, 591 insertions(+), 96 deletions(-)

With kind regards

Norbert Trapp
PDG ES&S SWE OS 6

FUJITSU
Fujitsu Technology Solutions GmbH
Domagkstrasse 28, D-80807 Muenchen, Germany
E-mail: Norbert.Trapp@xxxxxxxxxxxxxx
Web: ts.fujitsu.com
Company details: ts.fujitsu.com/imprint
Please be advised that neither Fujitsu, its affiliates, its employees or agents accept liability for any errors,
omissions or damages caused by delays of receipt or by any virus infection in this message or its attachments,
or which may otherwise arise as a result of this e-mail transmission.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
