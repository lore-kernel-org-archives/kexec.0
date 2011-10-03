Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e23smtp09.au.ibm.com ([202.81.31.142])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1RAfar-0003uY-7w
	for kexec@lists.infradead.org; Mon, 03 Oct 2011 10:17:57 +0000
Received: from /spool/local by au.ibm.com with XMail ESMTP
	for <kexec@lists.infradead.org> from <suzuki@in.ibm.com>;
	Mon, 3 Oct 2011 11:13:18 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p93AFLmt1941626
	for <kexec@lists.infradead.org>; Mon, 3 Oct 2011 21:15:21 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p93AHUDb022304
	for <kexec@lists.infradead.org>; Mon, 3 Oct 2011 21:17:30 +1100
From: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Subject: [PATCH] Series short description
Date: Mon, 03 Oct 2011 15:47:28 +0530
Message-ID: <20111003101723.30768.72889.stgit@suzukikp.in.ibm.com>
MIME-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Simon Horman <horms@verge.net.au>
Cc: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>, "M. Mohan Kumar" <mohan@in.ibm.com>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Vivek Goyal <vgoyal@redhat.com>

The following series implements...

---

Suzuki K. Poulose (1):
      kexec: powerpc: crash_dump: No backup region for PPC BookE


 configure.ac                       |    5 +++++
 kexec/arch/ppc/crashdump-powerpc.c |    7 ++++++-
 kexec/arch/ppc/crashdump-powerpc.h |    8 ++++++++
 kexec/arch/ppc/kexec-ppc.c         |    5 +++++
 purgatory/arch/ppc/purgatory-ppc.c |    2 ++
 5 files changed, 26 insertions(+), 1 deletions(-)

-- 
Signature


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
