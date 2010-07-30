Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ozlabs.org ([203.10.76.45])
	by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1OehSn-0005Qx-MM
	for kexec@lists.infradead.org; Fri, 30 Jul 2010 04:44:54 +0000
Message-ID: <4C5258C8.1030305@ozlabs.org>
Date: Fri, 30 Jul 2010 14:44:56 +1000
From: Matt Evans <matt@ozlabs.org>
MIME-Version: 1.0
Subject: [PATCH 0/2] powerpc/kexec: Fix orphaned offline CPUs,
	add comments/debug
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
To: linuxppc-dev@ozlabs.org, kexec@lists.infradead.org
Cc: Michael Neuling <mikey@neuling.org>, Milton Miller <miltonm@bga.com>

Separated tidyup comments & debug away from the fix of restarting offline
available CPUs before waiting for them on kexec.


Matt Evans (2):
  powerpc/kexec: Add to and tidy debug/comments in machine_kexec64.c
  powerpc/kexec: Fix orphaned offline CPUs across kexec

 arch/powerpc/kernel/machine_kexec_64.c |   55 ++++++++++++++++++++++++++++---
 1 files changed, 49 insertions(+), 6 deletions(-)


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
