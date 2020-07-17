Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jwUOE-0005qU-G9
 for kexec@lists.infradead.org; Fri, 17 Jul 2020 17:43:22 +0000
Received: by mail-pl1-x643.google.com with SMTP id p1so5765662pls.4
 for <kexec@lists.infradead.org>; Fri, 17 Jul 2020 10:43:16 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
Subject: [PATCH 00/13] Introduce partial kernel_read_file() support
Date: Fri, 17 Jul 2020 10:42:55 -0700
Message-Id: <20200717174309.1164575-1-keescook@chromium.org>
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
To: Scott Branden <scott.branden@broadcom.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Stephen Boyd <stephen.boyd@linaro.org>, Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>, Peter Jones <pjones@redhat.com>, "Joel Fernandes (Google)" <joel@joelfernandes.org>, linux-security-module@vger.kernel.org, Paul Moore <paul@paul-moore.com>, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Matthew Garrett <matthewgarrett@google.com>, James Morris <jmorris@namei.org>, Matthew Wilcox <willy@infradead.org>, KP Singh <kpsingh@google.com>, "Serge E. Hallyn" <serge@hallyn.com>, Kees Cook <keescook@chromium.org>, selinux@vger.kernel.org, Jessica Yu <jeyu@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-integrity@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Stephen Smalley <stephen.smalley.work@gmail.com>, Randy Dunlap <rdunlap@infradead.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Dave Olsthoorn <dave@bewaar.me>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Casey Schaufler <casey@schaufler-ca.com>, linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

Hi,

Here's my attempt at clearing the path to partial read support in
kernel_read_file(), which fixes a number of issues along the way. I'm
still fighting with the firmware test suite (it doesn't seem to pass
for me even in stock v5.7... ?) But I don't want to block Scott's work[1]
any this week, so here's the series as it is currently.

The primary difference to Scott's approach is to avoid adding a new set of
functions and just adapt the existing APIs to deal with "offset". Also,
the fixes for the enum are first in the series so they can be backported
without the header file relocation.

I'll keep poking at the firmware tests...

-Kees

[1] https://lore.kernel.org/lkml/202007161415.10D015477@keescook/

Kees Cook (12):
  firmware_loader: EFI firmware loader must handle pre-allocated buffer
  fs/kernel_read_file: Remove FIRMWARE_PREALLOC_BUFFER enum
  fs/kernel_read_file: Remove FIRMWARE_EFI_EMBEDDED enum
  fs/kernel_read_file: Split into separate source file
  fs/kernel_read_file: Remove redundant size argument
  fs/kernel_read_file: Switch buffer size arg to size_t
  fs/kernel_read_file: Add file_size output argument
  LSM: Introduce kernel_post_load_data() hook
  firmware_loader: Use security_post_load_data()
  module: Call security_kernel_post_load_data()
  LSM: Add "contents" flag to kernel_read_file hook
  fs/kernel_file_read: Add "offset" arg for partial reads

Scott Branden (1):
  fs/kernel_read_file: Split into separate include file

 drivers/base/firmware_loader/fallback.c       |   8 +-
 .../base/firmware_loader/fallback_platform.c  |  12 +-
 drivers/base/firmware_loader/main.c           |  13 +-
 fs/Makefile                                   |   3 +-
 fs/exec.c                                     | 132 +-----------
 fs/kernel_read_file.c                         | 189 ++++++++++++++++++
 include/linux/fs.h                            |  39 ----
 include/linux/ima.h                           |  19 +-
 include/linux/kernel_read_file.h              |  55 +++++
 include/linux/lsm_hook_defs.h                 |   6 +-
 include/linux/lsm_hooks.h                     |  12 ++
 include/linux/security.h                      |  19 +-
 kernel/kexec.c                                |   2 +-
 kernel/kexec_file.c                           |  18 +-
 kernel/module.c                               |  24 ++-
 security/integrity/digsig.c                   |   8 +-
 security/integrity/ima/ima_fs.c               |   9 +-
 security/integrity/ima/ima_main.c             |  58 ++++--
 security/integrity/ima/ima_policy.c           |   1 +
 security/loadpin/loadpin.c                    |  17 +-
 security/security.c                           |  26 ++-
 security/selinux/hooks.c                      |   8 +-
 22 files changed, 432 insertions(+), 246 deletions(-)
 create mode 100644 fs/kernel_read_file.c
 create mode 100644 include/linux/kernel_read_file.h

-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
