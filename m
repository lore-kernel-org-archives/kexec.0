Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp1040.oracle.com ([156.151.31.81])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TaHdB-0005qm-AD
 for kexec@lists.infradead.org; Mon, 19 Nov 2012 03:02:43 +0000
From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 0/6] kexec: put bzImage and ramdisk above 4G for x86 64bit
Date: Sun, 18 Nov 2012 19:02:25 -0800
Message-Id: <1353294151-32133-1-git-send-email-yinghai@kernel.org>
In-Reply-To: <878v9zp55t.fsf@xmission.com>
References: <878v9zp55t.fsf@xmission.com>
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

-v2: remove mem64-min/mem64-max
     add purgartory changes from Eric, that make it relocatable
     put command line above 4g.

Eric W. Biederman (1):
  kexec, x86: Make x64_64 purgatory relocatable above 4G

Yinghai Lu (5):
  kexec, x86: add boot header member for version 2.12
  kexec: don't die during buffer finding
  kexec, x86: put ramdisk high for 64bit bzImage
  kexec, x86: set ext_cmd_line_ptr when boot_param is put high
  kexec, x86_64: put 64bit bzImage high

 include/x86/x86-linux.h                |   22 ++-
 kexec/arch/i386/x86-linux-setup.c      |   40 +++-
 kexec/arch/x86_64/Makefile             |    1 +
 kexec/arch/x86_64/kexec-bzImage64.c    |  316 ++++++++++++++++++++++++++++++++
 kexec/arch/x86_64/kexec-x86_64.c       |    1 +
 kexec/arch/x86_64/kexec-x86_64.h       |    5 +
 kexec/kexec.c                          |    7 +-
 purgatory/arch/i386/entry32-16-debug.S |   22 ++-
 purgatory/arch/i386/entry32-16.S       |   22 ++-
 purgatory/arch/x86_64/Makefile         |    4 +-
 purgatory/arch/x86_64/entry64-32.S     |   68 +++++--
 purgatory/arch/x86_64/entry64.S        |    5 +-
 purgatory/arch/x86_64/setup-x86_64.S   |    4 +-
 13 files changed, 458 insertions(+), 59 deletions(-)
 create mode 100644 kexec/arch/x86_64/kexec-bzImage64.c

-- 
1.7.7


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
