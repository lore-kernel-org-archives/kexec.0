Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e28smtp09.in.ibm.com ([59.145.155.9])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1MaVdO-00082D-Fw
	for kexec@lists.infradead.org; Mon, 10 Aug 2009 14:14:03 +0000
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by e28smtp09.in.ibm.com (8.14.3/8.13.1) with ESMTP id n7AEAJ43004246
	for <kexec@lists.infradead.org>; Mon, 10 Aug 2009 19:40:19 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7AEDmXj782472
	for <kexec@lists.infradead.org>; Mon, 10 Aug 2009 19:43:48 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	n7AEDmpe031805
	for <kexec@lists.infradead.org>; Mon, 10 Aug 2009 19:43:48 +0530
Date: Mon, 10 Aug 2009 19:43:51 +0530
From: "M. Mohan Kumar" <mohan@in.ibm.com>
Subject: [PATCH 1/2] Make dtstruct variable to be 8 byte aligned
Message-ID: <20090810141351.GD3110@in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Reply-To: mohan@in.ibm.com
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: horms@verge.net.au, kexec@lists.infradead.org
Cc: michael@ellerman.id.au, linuxppc-dev@ozlabs.org, nhorman@redhat.com, miltonm@bga.com

[PATCH 1/2] Make dtstruct variable to be 8 byte aligned

kexec is creating a version 3 device tree to be backwards compatible. This
version of the struct has 8-byte alignment for properties whose value is 8 or
more bytes. As the code directly checks the pointer when deciding to add the
alignment word, the struct memory must start on an 8 byte boundary. Force the
dtstruct variable to be always 8 bytes aligned.

Signed-off-by: M. Mohan Kumar <mohan@in.ibm.com>
---
 kexec/arch/ppc64/fs2dt.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/kexec/arch/ppc64/fs2dt.c b/kexec/arch/ppc64/fs2dt.c
index 1f551fd..b01ff86 100644
--- a/kexec/arch/ppc64/fs2dt.c
+++ b/kexec/arch/ppc64/fs2dt.c
@@ -41,7 +41,7 @@
 
 static char pathname[MAXPATH], *pathstart;
 static char propnames[NAMESPACE] = { 0 };
-static unsigned dtstruct[TREEWORDS], *dt;
+static unsigned dtstruct[TREEWORDS] __attribute__ ((aligned (8))), *dt;
 static unsigned long long mem_rsrv[2*MEMRESERVE] = { 0, 0 };
 
 static int crash_param = 0;
-- 
1.6.2.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
