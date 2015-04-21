Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e17.ny.us.ibm.com ([129.33.205.207])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZOVkf-0004UN-Qw
 for kexec@lists.infradead.org; Sun, 09 Aug 2015 18:55:23 +0000
Received: from /spool/local
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <schwidefsky@de.ibm.com>;
 Sun, 9 Aug 2015 14:54:59 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id BFA1138C8039
 for <kexec@lists.infradead.org>; Sun,  9 Aug 2015 14:54:56 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t79IsuOG36569234
 for <kexec@lists.infradead.org>; Sun, 9 Aug 2015 18:54:56 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t79Isuve028323
 for <kexec@lists.infradead.org>; Sun, 9 Aug 2015 14:54:56 -0400
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH] kexec: override GFP flag for the control page allocation
Date: Tue, 21 Apr 2015 14:06:31 +0200
Message-Id: <1429617992-31686-1-git-send-email-schwidefsky@de.ibm.com>
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
To: Eric Biederman <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>

Greetings,

I got a bug report that kexec does not work on s390 if the system has
lots of memory. It is the kexec load step that dies with out-of-memory. 

The reason why this happens is the value of KEXEC_CONTROL_MEMORY_LIMIT
for s390. To start the new kernel the code in the kexec control page
needs to switch to the ESA mode (31-bit), therefore the memory limit
is 2GB for s390. The allocation of the control page is done with
GFP_KERNEL in kimage_alloc_normal_control_pages. If the allocated page
is a target page in the kexec destination range or if its address is
larger than the memory limit, it is put on the list of extra pages
and another page is allocated until one is found that fits the
requirements.

With a large memory size not only does this loop take a long time to
complete (think 10 terabyte of memory), but eventually the OOM killer
steps in and terminates the program that called kexec load.

The fix for s390 is to use a different GFP flag, GFP_DMA instead of
GFP_KERNEL. To do this a new #define for kexec is introduced that
can be overruled by the architecture.

Martin Schwidefsky (1):
  kexec: allocate the kexec control page with KEXEC_CONTROL_MEMORY_GFP

 arch/s390/include/asm/kexec.h | 3 +++
 include/linux/kexec.h         | 4 ++++
 kernel/kexec.c                | 2 +-
 3 files changed, 8 insertions(+), 1 deletion(-)

-- 
1.9.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
