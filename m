Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bXQO7-0003yw-UN
 for kexec@lists.infradead.org; Wed, 10 Aug 2016 10:05:28 +0000
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7AA4w8f065552
 for <kexec@lists.infradead.org>; Wed, 10 Aug 2016 06:05:05 -0400
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [125.16.236.5])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24qm9sp4d4-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Wed, 10 Aug 2016 06:05:05 -0400
Received: from localhost
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <hbathini@linux.vnet.ibm.com>;
 Wed, 10 Aug 2016 15:35:01 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 64FD93940067
 for <kexec@lists.infradead.org>; Wed, 10 Aug 2016 15:34:58 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7AA4vMH55836794
 for <kexec@lists.infradead.org>; Wed, 10 Aug 2016 15:34:57 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7AA4sG6025973
 for <kexec@lists.infradead.org>; Wed, 10 Aug 2016 15:34:57 +0530
Subject: [PATCH v3 0/2] powerpc/fadump: support memory range syntax for
 fadump memory reservation
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Wed, 10 Aug 2016 15:34:51 +0530
MIME-Version: 1.0
Message-Id: <147082324660.4631.6557186560310369015.stgit@hbathini.in.ibm.com>
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
To: Michael Ellerman <mpe@ellerman.id.au>, dyoung@redhat.com, ebiederm@xmission.com, vgoyal@redhat.com, linuxppc-dev <linuxppc-dev@ozlabs.org>
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


 arch/powerpc/kernel/fadump.c |   63 ++++++++++++++++++++++---
 include/linux/kernel.h       |    5 ++
 kernel/kexec_core.c          |   63 ++-----------------------
 lib/cmdline.c                |  104 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 168 insertions(+), 67 deletions(-)


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
