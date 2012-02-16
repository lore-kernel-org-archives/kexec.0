Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e28smtp03.in.ibm.com ([122.248.162.3])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1Rxs8i-000160-1v
 for kexec@lists.infradead.org; Thu, 16 Feb 2012 03:36:13 +0000
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <suzuki@in.ibm.com>;
 Thu, 16 Feb 2012 09:06:03 +0530
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q1G3ZWUM4501508
 for <kexec@lists.infradead.org>; Thu, 16 Feb 2012 09:05:33 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q1G3ZWmY029601
 for <kexec@lists.infradead.org>; Thu, 16 Feb 2012 14:35:32 +1100
From: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Subject: [PATCH v1 0/4][makedumpfile] vmalloc translation support for PPC32
Date: Thu, 16 Feb 2012 09:05:17 +0530
Message-ID: <20120216033411.7972.77705.stgit@suzukikp>
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
To: kumagai-atsushi@mxc.nes.nec.co.jp
Cc: kexec@lists.infradead.org

The series introduces an infrastructure to define platform specific
bits for page translation for PPC and PPC44x support for vmalloc
translation.

This is similar to what we have implemented for Crash-utility.

The patches are based makedumpfile-1.4.2 + PPC32 support patches
which is queued in for 1.4.3.

---

Suzuki K. Poulose (4):
      [makedumpfile][ppc] PPC44x page translation definitions
      [makedumpfile][ppc] Define platform descriptors for page translation
      [makedumpfile][ppc] Generic vmalloc translation support
      [makedumpfile] Add read_string routine


 arch/ppc.c     |  108 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 makedumpfile.c |   14 +++++++
 makedumpfile.h |   21 +++++++++++
 3 files changed, 139 insertions(+), 4 deletions(-)

-- 
Suzuki Poulose


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
