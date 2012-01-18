Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e28smtp06.in.ibm.com ([122.248.162.6])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RnSR2-0006eR-R7
 for kexec@lists.infradead.org; Wed, 18 Jan 2012 10:08:05 +0000
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <suzuki@in.ibm.com>;
 Wed, 18 Jan 2012 15:37:54 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q0IA7oA24423898
 for <kexec@lists.infradead.org>; Wed, 18 Jan 2012 15:37:51 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q0IA7oL0002617
 for <kexec@lists.infradead.org>; Wed, 18 Jan 2012 21:07:50 +1100
From: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Subject: [PATCH v1 0/3][makedumpfile]Add support for  PPC32
Date: Wed, 18 Jan 2012 15:37:49 +0530
Message-ID: <20120118100510.29422.93587.stgit@suzukikp.in.ibm.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: tachibana@mxm.nes.nec.co.jp, usui@mxm.nes.nec.co.jp
Cc: kexec@lists.infradead.org

The following series implements makedumpfile support for PPC32.

The implementation is heavily based on PPC64. This also introduces
cross build support which is required for Embedded PPC Boards.

---

Suzuki K. Poulose (3):
      [makedumpfile] Add support for PPC32
      [ppc64] Rename the __powerpc__ macro to __powerpc64__ for PPC64
      [makedumpfile] Support building for cross build


 Makefile       |   26 ++++++++++++--
 README         |    5 +++
 arch/ppc.c     |  101 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 makedumpfile.c |    4 +-
 makedumpfile.h |   28 +++++++++++++---
 5 files changed, 153 insertions(+), 11 deletions(-)
 create mode 100644 arch/ppc.c

-- 
Suzuki Poulose


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
