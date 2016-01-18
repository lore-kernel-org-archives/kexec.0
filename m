Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e28smtp03.in.ibm.com ([125.16.236.3])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aLBfd-000317-Jy
 for kexec@lists.infradead.org; Mon, 18 Jan 2016 15:24:42 +0000
Received: from localhost
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Mon, 18 Jan 2016 20:44:44 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0IFBo9L20185240
 for <kexec@lists.infradead.org>; Mon, 18 Jan 2016 20:41:50 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0IFBgQ9030066
 for <kexec@lists.infradead.org>; Mon, 18 Jan 2016 20:41:49 +0530
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [RFC PATCH v2 00/11] vfss: support for a common kernel file loader
Date: Mon, 18 Jan 2016 10:11:15 -0500
Message-Id: <1453129886-20192-1-git-send-email-zohar@linux.vnet.ibm.com>
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
Cc: Kees Cook <keescook@chromium.org>, fsdevel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, "Luis R. Rodriguez" <mcgrof@suse.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, kexec@lists.infradead.org, David Howells <dhowells@redhat.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Mimi Zohar <zohar@linux.vnet.ibm.com>, linux-modules@vger.kernel.org

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

Changelog v2:
- Combined the "ima: measuring/appraising files read by the kernel" patches
with this patch set to simplify review.
- Split the "ima: measure and appraise kexec image and initramfs" patch to
separate IMA from the kexec changes.

The latest version of these patches can be found in the next-kernel-read-v2
branch of:
git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git

[1] Taken from Luis Rodriguez's wiki -
http://kernelnewbies.org/KernelProjects/common-kernel-loader

Mimi

Dmitry Kasatkin (3):
  ima: separate 'security.ima' reading functionality from collect
  ima: provide buffer hash calculation function
  ima: load policy using path

Mimi Zohar (8):
  vfs: define a generic function to read a file from the kernel
  ima: calculate the hash of a buffer using aynchronous hash(ahash)
  ima: define a new hook to measure and appraise a file already in
    memory
  kexec: replace call to copy_file_from_fd() with kernel version
  firmware: replace call to fw_read_file_contents() with kernel version
  module: replace copy_module_from_fd with kernel version
  ima: measure and appraise the IMA policy itself
  ima: require signed IMA policy

 Documentation/ABI/testing/ima_policy      |   2 +-
 drivers/base/firmware_class.c             |  48 ++++--------
 fs/exec.c                                 |  93 +++++++++++++++++++++++
 include/linux/fs.h                        |   3 +
 include/linux/ima.h                       |  17 ++++-
 include/linux/lsm_hooks.h                 |  19 +++++
 include/linux/security.h                  |  14 ++--
 kernel/kexec_file.c                       |  72 ++----------------
 kernel/module.c                           |  67 ++--------------
 security/integrity/iint.c                 |   1 +
 security/integrity/ima/ima.h              |  35 +++++----
 security/integrity/ima/ima_api.c          |  19 ++---
 security/integrity/ima/ima_appraise.c     |  45 +++++------
 security/integrity/ima/ima_crypto.c       | 120 ++++++++++++++++++++++++++++-
 security/integrity/ima/ima_fs.c           |  50 +++++++++++-
 security/integrity/ima/ima_init.c         |   2 +-
 security/integrity/ima/ima_main.c         |  52 +++++++++----
 security/integrity/ima/ima_policy.c       | 122 +++++++++++++++++++-----------
 security/integrity/ima/ima_template.c     |   2 -
 security/integrity/ima/ima_template_lib.c |   1 -
 security/integrity/integrity.h            |  14 ++--
 security/security.c                       |  46 +++++++----
 22 files changed, 540 insertions(+), 304 deletions(-)

-- 
2.1.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
