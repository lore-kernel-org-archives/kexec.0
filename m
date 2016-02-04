Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ig0-x22f.google.com ([2607:f8b0:4001:c05::22f])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aRORg-0001gO-3F
 for kexec@lists.infradead.org; Thu, 04 Feb 2016 18:15:57 +0000
Received: by mail-ig0-x22f.google.com with SMTP id hb3so40927259igb.0
 for <kexec@lists.infradead.org>; Thu, 04 Feb 2016 10:15:35 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1454526390-19792-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1454526390-19792-1-git-send-email-zohar@linux.vnet.ibm.com>
Date: Thu, 4 Feb 2016 10:15:34 -0800
Message-ID: <CAGXu5jKve+Lcm+m69L_hGDWtL67H8ndJLq+MpRNVsF9N0-buAw@mail.gmail.com>
Subject: Re: [PATCH v3 00/22] vfs: support for a common kernel file loader
From: Kees Cook <keescook@chromium.org>
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
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, "Luis R. Rodriguez" <mcgrof@suse.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kexec Mailing List <kexec@lists.infradead.org>, David Howells <dhowells@redhat.com>, linux-security-module <linux-security-module@vger.kernel.org>, Eric Biederman <ebiederm@xmission.com>, David Woodhouse <dwmw2@infradead.org>, linux-modules@vger.kernel.org

On Wed, Feb 3, 2016 at 11:06 AM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> For a while it was looked down upon to directly read files from Linux.
> These days there exists a few mechanisms in the kernel that do just this
> though to load a file into a local buffer. There are minor but important
> checks differences on each, we should take all the best practices from
> each of them, generalize them and make all places in the kernel that
> read a file use it.[1]
>
> One difference is the method for opening the file.  In some cases we
> have a file, while in other cases we have a pathname or a file descriptor.
>
> Another difference is the security hook calls, or lack of them.  In
> some versions there is a post file read hook, while in others there
> is a pre file read hook.
>
> This patch set attempts to resolve these differences.  It does not attempt
> to merge the different methods of opening a file, but defines a single
> common kernel file read function with two wrappers. In addition, as none
> of the upstreamed LSMs define either a kernel_module_from_file or a
> kernel_fw_from_file hook, this patch set removes these hooks and the
> associated functions.  The ima_module_check() and ima_fw_from_file()
> functions are renamed and called from the pre and post kernel_read_file
> security functions respectively.

I'm very happy about the pre and post hooks; this solves the primary
problem I'd had when comparing the firmware and module hooks. Thanks!

Once this series is in -next, I'll resend my rebased "loadpin" LSM.

-Kees

>
> Changelog:
> - Rebased on top of some of the "firmware_class: extensible firmware API"
> patches posted by Luis.
> - Removed the kernel_module_from_file and kernel_fw_from_file security
> hooks and functions.
> - Defined "kernel_read_file_id" enumeration, independently of "ima_hooks".
> - Split patches for ease of review.
>
> The latest version of these patches can be found in the next-kernel-read-v3
> branch of:
> git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
>
> [1] Taken from Luis Rodriguez's wiki -
> http://kernelnewbies.org/KernelProjects/common-kernel-loader
>
> Mimi
>
> David Howells (1):
>   firmware: fold successful fw read early
>
> Dmitry Kasatkin (3):
>   ima: separate 'security.ima' reading functionality from collect
>   ima: provide buffer hash calculation function
>   ima: load policy using path
>
> Luis R. Rodriguez (2):
>   firmware: simplify dev_*() print messages for generic helpers
>   firmware: move completing fw into a helper
>
> Mimi Zohar (16):
>   ima: refactor ima_policy_show() to display "ima_hooks" rules
>   ima: use "ima_hooks" enum as function argument
>   vfs: define a generic function to read a file from the kernel
>   vfs: define kernel_read_file_id enumeration
>   ima: calculate the hash of a buffer using aynchronous hash(ahash)
>   ima: define a new hook to measure and appraise a file already in
>     memory
>   vfs: define kernel_read_file_from_path
>   firmware: replace call to fw_read_file_contents() with kernel version
>   security: define kernel_read_file hook
>   vfs: define kernel_copy_file_from_fd()
>   module: replace copy_module_from_fd with kernel version
>   ima: remove firmware and module specific cached status info
>   kexec: replace call to copy_file_from_fd() with kernel version
>   ima: support for kexec image and initramfs
>   ima: measure and appraise the IMA policy itself
>   ima: require signed IMA policy
>
>  Documentation/ABI/testing/ima_policy      |   2 +-
>  drivers/base/firmware_class.c             |  76 ++++++-------------
>  fs/exec.c                                 |  95 +++++++++++++++++++++++
>  include/linux/fs.h                        |  15 ++++
>  include/linux/ima.h                       |  10 ++-
>  include/linux/lsm_hooks.h                 |  35 ++++-----
>  include/linux/security.h                  |  16 ++--
>  kernel/kexec_file.c                       |  73 +++---------------
>  kernel/module.c                           |  68 ++---------------
>  security/integrity/iint.c                 |   4 +-
>  security/integrity/ima/ima.h              |  49 ++++++++----
>  security/integrity/ima/ima_api.c          |  25 +++----
>  security/integrity/ima/ima_appraise.c     |  69 ++++++++---------
>  security/integrity/ima/ima_crypto.c       | 120 +++++++++++++++++++++++++++++-
>  security/integrity/ima/ima_fs.c           |  50 ++++++++++++-
>  security/integrity/ima/ima_init.c         |   2 +-
>  security/integrity/ima/ima_main.c         | 104 +++++++++++++++++++-------
>  security/integrity/ima/ima_policy.c       | 107 +++++++++++++++++---------
>  security/integrity/ima/ima_template.c     |   2 -
>  security/integrity/ima/ima_template_lib.c |   1 -
>  security/integrity/integrity.h            |  15 ++--
>  security/security.c                       |  32 ++++----
>  22 files changed, 605 insertions(+), 365 deletions(-)
>
> --
> 2.1.0
>



-- 
Kees Cook
Chrome OS & Brillo Security

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
