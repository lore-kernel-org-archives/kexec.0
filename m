Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1f6kv4-0008JM-Lo
 for kexec@lists.infradead.org; Thu, 12 Apr 2018 22:42:19 +0000
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w3CMdElt035025
 for <kexec@lists.infradead.org>; Thu, 12 Apr 2018 18:42:06 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2hadr6pc0v-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Thu, 12 Apr 2018 18:42:06 -0400
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Thu, 12 Apr 2018 23:42:04 +0100
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [PATCH 0/3] kexec: limit kexec_load syscall
Date: Thu, 12 Apr 2018 18:41:48 -0400
Message-Id: <1523572911-16363-1-git-send-email-zohar@linux.vnet.ibm.com>
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
To: David Howells <dhowells@redhat.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Matthew Garrett <mjg59@google.com>, linux-security-module@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.vnet.ibm.com>

In environments that require the kexec kernel image to be signed, prevent
using the kexec_load syscall.  In order for LSMs and IMA to differentiate
between kexec_load and kexec_file_load syscalls, this patch set adds a
call to security_kernel_read_file() in kexec_load_check().

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>

Mimi Zohar (3):
  ima: based on the "secure_boot" policy limit syscalls
  kexec: call LSM hook for kexec_load syscall
  ima: based on policy require signed kexec kernel images

 kernel/kexec.c                      | 11 +++++++++++
 security/integrity/ima/ima.h        |  1 +
 security/integrity/ima/ima_main.c   |  9 +++++++++
 security/integrity/ima/ima_policy.c | 27 ++++++++++++++++++++-------
 4 files changed, 41 insertions(+), 7 deletions(-)

-- 
2.7.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
