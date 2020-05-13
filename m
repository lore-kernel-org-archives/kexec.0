Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf1-f196.google.com ([209.85.210.196])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jYtC7-0000xf-Jk
 for kexec@lists.infradead.org; Wed, 13 May 2020 15:21:22 +0000
Received: by mail-pf1-f196.google.com with SMTP id x77so8144844pfc.0
 for <kexec@lists.infradead.org>; Wed, 13 May 2020 08:21:14 -0700 (PDT)
From: Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 0/3] fs: reduce export usage of kerne_read*() calls
Date: Wed, 13 May 2020 15:21:05 +0000
Message-Id: <20200513152108.25669-1-mcgrof@kernel.org>
MIME-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org, rafael@kernel.org, ebiederm@xmission.com, jeyu@kernel.org, jmorris@namei.org, keescook@chromium.org, paul@paul-moore.com, stephen.smalley.work@gmail.com, eparis@parisplace.org, nayna@linux.ibm.com, zohar@linux.ibm.com
Cc: scott.branden@broadcom.com, selinux@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, dhowells@redhat.com, linux-security-module@vger.kernel.org, geert@linux-m68k.org, dan.carpenter@oracle.com, skhan@linuxfoundation.org, linux-fsdevel@vger.kernel.org, tglx@linutronix.de, linux-integrity@vger.kernel.org, bauerman@linux.ibm.com, Luis Chamberlain <mcgrof@kernel.org>

While reviewing Scott Branden's submission of the new Broadcom VK driver
driver upstream [0], part of which included 4 new pread varaints of the
existing kernel_read*(), calls I grew shivers of the possibility of drivers
using these exported symbols loosely. If we're going to grow these, it
seems best to restrict the symbols to a namespace so drivers and
subsystem maintainers don't use these carelessly.

This should also help with making it easier to audit future locations in
the kernel such read calls happen by just looking at the imports of the
namespace.

This goes compile tested with allyesconfig and allmodconfig on x86_64.
0-day should have a report on build status with other configs later of
my branch [1].

[0] https://lkml.kernel.org/r/20200508002739.19360-1-scott.branden@broadcom.com
[1] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git/log/?h=20200513-kernel-read-sym

Luis Chamberlain (3):
  fs: unexport kernel_read_file()
  security: add symbol namespace for reading file data
  fs: move kernel_read*() calls to its own symbol namespace

 drivers/base/firmware_loader/fallback.c | 1 +
 drivers/base/firmware_loader/main.c     | 1 +
 fs/exec.c                               | 9 +++++----
 kernel/kexec.c                          | 2 ++
 kernel/kexec_file.c                     | 2 ++
 kernel/module.c                         | 3 +++
 security/integrity/digsig.c             | 3 +++
 security/integrity/ima/ima_fs.c         | 3 +++
 security/integrity/ima/ima_main.c       | 2 ++
 security/loadpin/loadpin.c              | 2 ++
 security/security.c                     | 8 +++++---
 security/selinux/hooks.c                | 2 ++
 12 files changed, 31 insertions(+), 7 deletions(-)

-- 
2.26.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
