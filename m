Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp1040.oracle.com ([156.151.31.81])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TjH7D-000100-0a
 for kexec@lists.infradead.org; Thu, 13 Dec 2012 22:18:53 +0000
From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v6 0/6] kexec: put bzImage and ramdisk above 4G for x86 64bit
Date: Thu, 13 Dec 2012 14:18:26 -0800
Message-Id: <1355437112-9250-1-git-send-email-yinghai@kernel.org>
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

here patches are for kexec tools to load bzImage and ramdisk above 4G
acccording to new added boot header fields.

-v3: address review from Eric to use locate_hole at first.
     use xloadflags instead.
-v4: remove the restriction about bzImage not crossing GB boundary.
     add real-mode fix for bzImage.
     add --entry-32bit and --real-mode for skip bzImage64.
-v5: use USE_EXT_BOOT_PARAMS bit in xloadflags.
-v6: use sentinel instead of USE_EXT_BOOT_PARAMS.
     add crashkernel_low support

Yinghai Lu (6):
  kexec, x86: add boot header member for version 2.12
  kexec, x86: clean boot_params area for entry-32bit path
  kexec, x86: Fix bzImage real-mode booting
  kexec, x86: put ramdisk/cmd_line above 4G for 64bit bzImage
  kexec, x86_64: Load bzImage64 above 4G
  kexec, x86: handle Crash low kernel range

 include/x86/x86-linux.h                |   33 +++-
 kexec/arch/i386/crashdump-x86.c        |   21 +++
 kexec/arch/i386/include/arch/options.h |    4 +-
 kexec/arch/i386/kexec-bzImage.c        |   81 +++++++--
 kexec/arch/i386/x86-linux-setup.c      |   27 ++-
 kexec/arch/x86_64/Makefile             |    1 +
 kexec/arch/x86_64/kexec-bzImage64.c    |  312 ++++++++++++++++++++++++++++++++
 kexec/arch/x86_64/kexec-x86_64.c       |    1 +
 kexec/arch/x86_64/kexec-x86_64.h       |    5 +
 9 files changed, 461 insertions(+), 24 deletions(-)
 create mode 100644 kexec/arch/x86_64/kexec-bzImage64.c

-- 
1.7.10.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
