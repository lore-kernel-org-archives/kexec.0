Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1c42C2-00082t-Lb
 for kexec@lists.infradead.org; Tue, 08 Nov 2016 08:55:47 +0000
From: Baoquan He <bhe@redhat.com>
Subject: [PATCH 0/2] makedumpfile: Adapt code to get value of phys_base
Date: Tue,  8 Nov 2016 16:55:17 +0800
Message-Id: <1478595319-9299-1-git-send-email-bhe@redhat.com>
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
To: ats-kumagai@wm.jp.nec.com
Cc: panand@redhat.com, Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, anderson@redhat.com, ebiederm@xmission.com, tglx@linutronix.de, dyoung@redhat.com

This patchset is on top of Pratyush's patchset:
**x86_64: Fix page_offset for randomized base enabled**

Because exporting virtual address of phys_base is really helpless for Crash
and Makedumpfile, so has posted a kernel patch to export value of phys_base
instead. Patch 2/1 is used to adapt code for that.

Patch 2/2 is a clean up patch, it's based on Pratyush's patchset. MODULES_VADDR
is used to judge if a virtual address in inside kernel text region or direct
mapping region. And MODULES_VADDR is decided by KERNEL_IMAGE_SIZE. With Pratyush's
above patchset, KERNEL_IMAGE_SIZE is not needed. Remove it here. But Crash needs
it to check if kaslr is enabled. It still need be exported.

Baoquan He (2):
  makedumpfile: Adapt code to get value of phys_base
  makedumpfile: Clean up unused KERNEL_IMAGE_SIZE

 arch/x86_64.c  |  7 +++++--
 makedumpfile.c | 16 +++-------------
 makedumpfile.h |  5 +----
 3 files changed, 9 insertions(+), 19 deletions(-)

-- 
2.5.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
