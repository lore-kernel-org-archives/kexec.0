Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bV1uh-0000pq-2l
 for kexec@lists.infradead.org; Wed, 03 Aug 2016 19:33:11 +0000
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u73JNdUb139775
 for <kexec@lists.infradead.org>; Wed, 3 Aug 2016 15:32:49 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24kkahs11a-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Wed, 03 Aug 2016 15:32:49 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <hbathini@linux.vnet.ibm.com>;
 Thu, 4 Aug 2016 05:32:46 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 3EF062CE8056
 for <kexec@lists.infradead.org>; Thu,  4 Aug 2016 05:32:43 +1000 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u73JWhm724314094
 for <kexec@lists.infradead.org>; Thu, 4 Aug 2016 05:32:43 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u73JWggN006400
 for <kexec@lists.infradead.org>; Thu, 4 Aug 2016 05:32:42 +1000
Subject: [RESEND][PATCH v2 0/2] powerpc/fadump: support memory range syntax
 for fadump memory reservation
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Thu, 04 Aug 2016 01:02:37 +0530
MIME-Version: 1.0
Message-Id: <147025270324.29229.8322429758761407397.stgit@hbathini.in.ibm.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Michael Ellerman <mpe@ellerman.id.au>, rusty@rustcorp.com.au, ebiederm@xmission.com, vgoyal@redhat.com, linuxppc-dev <linuxppc-dev@ozlabs.org>
Cc: kexec@lists.infradead.org, lkml <linux-kernel@vger.kernel.org>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>

This patchset adds support to input system memory range based memory size
for fadump reservation. The crashkernel parameter already supports such
syntax. The first patch refactors the parsing code of crashkernel parameter
for reuse. The second patch uses the newly refactored parsing code to reserve
memory for fadump based on system memory size.

---

Hari Bathini (2):
      kexec: refactor code parsing size based on memory range
      powerpc/fadump: parse fadump reserve memory size based on memory range


 arch/powerpc/kernel/fadump.c |   64 ++++++++++++++++++++++++----
 include/linux/kernel.h       |    5 ++
 kernel/kexec_core.c          |   63 ++--------------------------
 kernel/params.c              |   96 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 161 insertions(+), 67 deletions(-)


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
