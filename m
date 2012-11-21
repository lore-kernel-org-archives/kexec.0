Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp1040.oracle.com ([141.146.126.69])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1Tb4mg-000680-EV
 for kexec@lists.infradead.org; Wed, 21 Nov 2012 07:31:48 +0000
From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v3 0/4] kexec: put bzImage and ramdisk above 4G for x86 64bit
Date: Tue, 20 Nov 2012 23:31:34 -0800
Message-Id: <1353483098-14883-1-git-send-email-yinghai@kernel.org>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>, "H. Peter Anvin" <hpa@zytor.com>, Vivek Goyal <vgoyal@redhat.com>, Haren Myneni <hbabu@us.ibm.com>, "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Yinghai Lu <yinghai@kernel.org>, kexec@lists.infradead.org

Now we have limit kdump reserved under 896M, because kexec has the limitation.
and also bzImage need to stay under 4g.

kernel parts changes could be found at:
        git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git for-x86-boot

here patches are for kexec tools to load bzImage and ramdisk high acccording
to new added boot header fields.

-v3: address review from Eric to use locate_hole at first.
     use xloadflags instead.

Yinghai Lu (4):
  kexec, x86: add boot header member for version 2.12
  kexec, x86: put ramdisk high for 64bit bzImage
  kexec, x86: set ext_cmd_line_ptr when boot_param is above 4g
  kexec, x86_64: Load bzImage64 above 4G

 include/x86/x86-linux.h             |   26 +++-
 kexec/arch/i386/x86-linux-setup.c   |   25 +++-
 kexec/arch/x86_64/Makefile          |    1 +
 kexec/arch/x86_64/kexec-bzImage64.c |  327 +++++++++++++++++++++++++++++++++++
 kexec/arch/x86_64/kexec-x86_64.c    |    1 +
 kexec/arch/x86_64/kexec-x86_64.h    |    5 +
 6 files changed, 378 insertions(+), 7 deletions(-)
 create mode 100644 kexec/arch/x86_64/kexec-bzImage64.c

-- 
1.7.7


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
