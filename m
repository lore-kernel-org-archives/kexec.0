Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hy6aY-0004eK-Pp
 for kexec@lists.infradead.org; Thu, 15 Aug 2019 03:38:12 +0000
From: Lianbo Jiang <lijiang@redhat.com>
Subject: [PATCH 0/2] Limit the size of vmcore-dmesg.txt to 2G
Date: Thu, 15 Aug 2019 11:37:54 +0800
Message-Id: <20190815033756.15587-1-lijiang@redhat.com>
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
To: kexec@lists.infradead.org
Cc: kasong@redhat.com, bhe@redhat.com, piliu@redhat.com, bhsharma@redhat.com, junw99@yahoo.com, horms@verge.net.au, dyoung@redhat.com

[PATCH 1/2] cleanup: move it back from util_lib/elf_info.c
Some code related to vmcore-dmesg.c is put into the util_lib, which
is not very reasonable, so lets move it back and tidy up those code.
    
In addition, that will also help to limit the size of vmcore-dmesg.txt.

[PATCH 2/2] Limit the size of vmcore-dmesg.txt to 2G
With some corrupted vmcore files, the vmcore-dmesg.txt file may
grow forever till the kdump disk becomes full. Lets limit the
size of vmcore-dmesg.txt to avoid such problems.

BTW: I tested this patch on x86 64 and arm64, it also worked well.

Lianbo Jiang (2):
  cleanup: move it back from util_lib/elf_info.c
  Limit the size of vmcore-dmesg.txt to 2G

 kexec/arch/arm64/kexec-arm64.c |  2 +-
 util_lib/elf_info.c            | 73 ++++++++--------------------------
 util_lib/include/elf_info.h    |  8 +++-
 vmcore-dmesg/vmcore-dmesg.c    | 54 ++++++++++++++++++++++---
 4 files changed, 71 insertions(+), 66 deletions(-)

-- 
2.17.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
