Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bFiJg-00061Y-4m
 for kexec@lists.infradead.org; Wed, 22 Jun 2016 13:35:41 +0000
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5MDXncf076289
 for <kexec@lists.infradead.org>; Wed, 22 Jun 2016 09:35:19 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23q6ym0cac-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Wed, 22 Jun 2016 09:35:19 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Wed, 22 Jun 2016 23:35:16 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 41A7B2CE8046
 for <kexec@lists.infradead.org>; Wed, 22 Jun 2016 23:35:14 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5MDZEwP21102620
 for <kexec@lists.infradead.org>; Wed, 22 Jun 2016 23:35:14 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5MDZDZv001537
 for <kexec@lists.infradead.org>; Wed, 22 Jun 2016 23:35:13 +1000
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [PATCH 0/3] support other types of measurements 
Date: Wed, 22 Jun 2016 09:35:02 -0400
Message-Id: <1466602505-21915-1-git-send-email-zohar@linux.vnet.ibm.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: linux-security-module <linux-security-module@vger.kernel.org>, linux-ima-devel <linux-ima-devel@lists.sourceforge.net>
Cc: kexec@lists.infradead.org, Mimi Zohar <zohar@linux.vnet.ibm.com>, Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>

In addition to file measurements, other types of measurements should be
included in the IMA measurement list to attest to the integrity of the
running system.  This patch set introduces two new types of measurements -
buffer and pre-calculated digests.

The first, for example, can be used to measure the kexec boot command
line, while the latter could be used for including asymmetric key id
information.

Mimi Zohar (3):
  ima: measure other types of data
  kexec: measure boot command line
  ima: add pre-calculated measurements (experimental)

 Documentation/ABI/testing/ima_policy |   1 +
 include/linux/ima.h                  |  24 +++++
 kernel/kexec_file.c                  |   4 +
 security/integrity/ima/Kconfig       |   8 ++
 security/integrity/ima/Makefile      |   2 +-
 security/integrity/ima/ima.h         |   4 +
 security/integrity/ima/ima_buffer.c  | 164 +++++++++++++++++++++++++++++++++++
 security/integrity/ima/ima_policy.c  |  51 ++++++++++-
 8 files changed, 255 insertions(+), 3 deletions(-)
 create mode 100644 security/integrity/ima/ima_buffer.c
-- 
2.1.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
