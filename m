Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
Subject: [PATCH v2 0/6] crash utility - add ARM support
Date: Thu, 26 Aug 2010 15:02:26 +0300
Message-Id: <cover.1282822832.git.ext-mika.1.westerberg@nokia.com>
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
To: anderson@redhat.com
Cc: kexec@lists.infradead.org, Thomas.Fange@sonyericsson.com, Jan.Karlsson@sonyericsson.com, "\\\"Mika Westerberg\\\"" <ext-mika.1.westerberg@nokia.com>, linux-arm-kernel@lists.infradead.org, crash-utility@redhat.com

Hi Dave,

This series brings ARM support for the crash utility. This is the result of
collaboration work with Nokia and SonyEricsson. Basically we combined our
versions of the code. Previous version of the patches can be found here:

	http://lists.infradead.org/pipermail/linux-arm-kernel/2010-June/019188.html

We tried to keep any ARM specific changes isolated with #ifdefs and similar so
that it should not cause any problems with other archs.

In this series:
	o crash can be build as native ARM binary or "cross" version running on
	  x86 host (make target=ARM to build "cross" version)
	o supports kdump, diskdump and /dev/mem (live system)
	o stack unwinding with both framepointers and ARM unwind tables
	o most of the arch specific code is implemented

The patches apply on top of crash 5.0.6 sources.

Best regards,
MW

Jan Karlsson (1):
  crash: update IRQ flags

Mika Westerberg (5):
  configure/Makefile: add support for ARM targets
  crash: add support for ARM kernel image
  crash/diskdump: add ARM support
  crash/kdump: add ARM support
  crash: add ARM crashdump support

 Makefile            |   30 +-
 arm.c               | 1741 +++++++++++++++++++++++++++++++++++++++++++++++++++
 configure.c         |   32 +-
 defs.h              |  245 +++++++-
 diskdump.c          |   42 ++-
 kernel.c            |    3 +-
 lkcd_vmdump_v2_v3.h |    4 +-
 netdump.c           |  115 ++++
 symbols.c           |   15 +-
 unwind_arm.c        |  697 +++++++++++++++++++++
 10 files changed, 2902 insertions(+), 22 deletions(-)
 create mode 100644 arm.c
 create mode 100644 unwind_arm.c


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
