Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e23smtp02.au.ibm.com ([202.81.31.144])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aHcdV-0005kI-Rm
 for kexec@lists.infradead.org; Fri, 08 Jan 2016 19:23:46 +0000
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Sat, 9 Jan 2016 05:23:21 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 2456B3578052
 for <kexec@lists.infradead.org>; Sat,  9 Jan 2016 06:23:19 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u08JNA3546923884
 for <kexec@lists.infradead.org>; Sat, 9 Jan 2016 06:23:19 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u08JMj2E018589
 for <kexec@lists.infradead.org>; Sat, 9 Jan 2016 06:22:46 +1100
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [RFC PATCH 0/5] vfs: support for a common kernel file loader (step 1)
Date: Fri,  8 Jan 2016 14:21:59 -0500
Message-Id: <1452280924-28774-1-git-send-email-zohar@linux.vnet.ibm.com>
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
To: linux-security-module@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>, fsdevel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, "Luis R. Rodriguez" <mcgrof@suse.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, kexec@lists.infradead.org, David Howells <dhowells@redhat.com>, Mimi Zohar <zohar@linux.vnet.ibm.com>, linux-modules@vger.kernel.org

For a while it was looked down upon to directly read files from Linux.
These days there exists a few mechanisms in the kernel that do just this
though to load a file into a local buffer. There are minor but important
checks differences on each, we should take all the best practices from
each of them, generalize them and make all places in the kernel that
read a file use it.[1]

One difference is the method for opening the file.  In some cases we
have a file, while in other cases we have a pathname or a file descriptor.

Another difference is the security hook calls, or lack of them.  In
some versions there is a post file read hook, while in others there
is a pre file read hook.

This patch set is the first attempt at resolving these differences.  It
does not attempt to merge the different methods of opening a file, but
defines a single common kernel file read function with two wrappers.
Although this patch set defines two new security hooks for pre and post
file read, it does not attempt to merge the existing security hooks.
That is left as future work.

These patches are based on top of the "ima: measuring/appraising files
read by the kernel".  The latest version of these patches can be found
in the next-kernel-read branch of:
git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git

Mimi Zohar (5):
  vfs: define a generic function to read a file from the kernel
  firmware: replace call to fw_read_file_contents() with kernel version
  kexec: replace call to copy_file_from_fd() with kernel version
  ima: replace call to integrity_read_file() with kernel version
  module: replace copy_module_from_fd with kernel version

 drivers/base/firmware_class.c         | 51 +++++--------------
 fs/exec.c                             | 96 +++++++++++++++++++++++++++++++++++
 include/linux/fs.h                    |  3 ++
 include/linux/ima.h                   |  7 +--
 include/linux/lsm_hooks.h             | 19 +++++++
 include/linux/security.h              | 14 +++--
 kernel/kexec_file.c                   | 76 +++------------------------
 kernel/module.c                       | 67 +++---------------------
 security/integrity/ima/ima.h          |  1 -
 security/integrity/ima/ima_appraise.c |  7 ---
 security/integrity/ima/ima_fs.c       | 15 +++---
 security/integrity/ima/ima_main.c     | 21 ++++----
 security/integrity/ima/ima_policy.c   | 16 +++---
 security/integrity/integrity.h        | 12 ++---
 security/security.c                   | 46 ++++++++++++-----
 15 files changed, 217 insertions(+), 234 deletions(-)

-- 
2.1.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
