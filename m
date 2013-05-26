Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UgUUz-0001Rf-Pr
 for kexec@lists.infradead.org; Sun, 26 May 2013 06:32:10 +0000
Received: by mail-pa0-f46.google.com with SMTP id fa10so5762413pad.33
 for <kexec@lists.infradead.org>; Sat, 25 May 2013 23:31:47 -0700 (PDT)
Message-ID: <51A1AC4A.60506@gmail.com>
Date: Sun, 26 May 2013 14:31:38 +0800
From: Zhang Yanfei <zhangyanfei.yes@gmail.com>
MIME-Version: 1.0
Subject: [PATCH v2 0/7] Remove unused /dev/oldmem interface
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>, Simon Horman <horms@verge.net.au>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

/dev/oldmem provides the interface for us to access the "old memory" in
the dump-capture kernel. Unfortunately, no one actually uses this interface.

And this interface could actually cause some real problems if used on ia64
where the cached/uncached accesses are mixed. See the discussion from
the link: https://lkml.org/lkml/2013/4/12/386.

So Eric suggested that we should remove /dev/oldmem as an unused piece of
code.

Besides, we used a global variable saved_max_pfn to let the capture kernel
know the amount of memory that the previous kernel used. And for almost all
architectures (except x86. In x86, saved_max_pfn is used by detect_calgary()),
the only user of this variable is the read_oldmem interface of /dev/oldmem, so
also remove the setting for saved_max_pfn in those architectures.

-v2:
Keep /dev/oldmem and its number 12 in case this number will get reused in the
future. And mark it obsolete since /dev/oldmem will be removed from kernel.

Zhang Yanfei (7):
  /dev/oldmem: Remove this interface
  Documentation/devices.txt: Mark /dev/oldmem obsolete
  Documentation/kdump/kdump.txt: Remove /dev/oldmem description
  mips: Remove savemaxmem parameter setup
  powerpc: Remove savemaxmem parameter setup
  ia64: Remove setting for saved_max_pfn
  s390: Remove setting for saved_max_pfn

 Documentation/devices.txt        |    3 +-
 Documentation/kdump/kdump.txt    |   31 +++++--------------------
 arch/ia64/kernel/efi.c           |    5 ----
 arch/mips/kernel/crash_dump.c    |   10 --------
 arch/powerpc/kernel/crash_dump.c |   10 --------
 arch/s390/kernel/setup.c         |    4 ---
 drivers/char/mem.c               |   47 --------------------------------------
 7 files changed, 7 insertions(+), 103 deletions(-)


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
