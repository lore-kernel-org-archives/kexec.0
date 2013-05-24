Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e06smtp18.uk.ibm.com ([195.75.94.114])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UfrjZ-000746-Kk
 for kexec@lists.infradead.org; Fri, 24 May 2013 13:08:38 +0000
Received: from /spool/local
 by e06smtp18.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Fri, 24 May 2013 14:03:41 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id E237D17D8066
 for <kexec@lists.infradead.org>; Fri, 24 May 2013 14:09:22 +0100 (BST)
Received: from d06av10.portsmouth.uk.ibm.com (d06av10.portsmouth.uk.ibm.com
 [9.149.37.251])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r4OD80d953870784
 for <kexec@lists.infradead.org>; Fri, 24 May 2013 13:08:00 GMT
Received: from d06av10.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av10.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r4OD8Ak3026421
 for <kexec@lists.infradead.org>; Fri, 24 May 2013 07:08:10 -0600
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: [PATCH 0/2] kdump/mmap: Fix mmap of /proc/vmcore for s390
Date: Fri, 24 May 2013 15:08:07 +0200
Message-Id: <1369400889-11064-1-git-send-email-holzheu@linux.vnet.ibm.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, kexec@lists.infradead.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Jan Willeke <willeke@de.ibm.com>, linux-kernel@vger.kernel.org

Hello Vivek and Hatayama,

Currently the /proc/vmcore mmap patches are not working on s390. The
problem is that on s390 the kernel in not relocatable and therefore
always runs in the lower memory area. Therefore for kdump on s390 we
swap the lower memory area with the crashkernel area before starting
the kdump kernel:

[0 - OLDMEM_SIZE] is mapped to [OLDMEM_BASE - OLDMEM_BASE + OLDMEM_SIZE]

To fix /proc/vmcore mmap memory below OLDMEMSIZE needs to be mapped
with OLDMEM_BASE as offset. To achieve that, a new weak function
arch_oldmem_remap_pfn_range() is introduced.

If you agree with our approach, could you integrate the two patches
into the mmap patch series?

Best Regards,
Michael

---
Jan Willeke (2):
  kdump/mmap: Introduce arch_oldmem_remap_pfn_range()
  s390/kdump/mmap: Implement arch_oldmem_remap_pfn_range() for s390

 arch/s390/kernel/crash_dump.c | 27 +++++++++++++++++++++++++++
 fs/proc/vmcore.c              | 15 ++++++++++++++-
 include/linux/crash_dump.h    |  5 +++++
 3 files changed, 46 insertions(+), 1 deletion(-)

-- 
1.8.1.6


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
