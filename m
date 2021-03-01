Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lGmeA-0003of-Jm
 for kexec@lists.infradead.org; Mon, 01 Mar 2021 17:47:55 +0000
Received: by mail-pj1-x1029.google.com with SMTP id d2so27119pjs.4
 for <kexec@lists.infradead.org>; Mon, 01 Mar 2021 09:47:54 -0800 (PST)
From: Stephen Boyd <swboyd@chromium.org>
Subject: [PATCH 0/7] Add build ID to stacktraces
Date: Mon,  1 Mar 2021 09:47:42 -0800
Message-Id: <20210301174749.1269154-1-swboyd@chromium.org>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Petr Mladek <pmladek@suse.com>, Baoquan He <bhe@redhat.com>, linux-doc@vger.kernel.org, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Jessica Yu <jeyu@kernel.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Evan Green <evgreen@chromium.org>, Alexei Starovoitov <ast@kernel.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Jiri Olsa <jolsa@kernel.org>, Hsin-Yi Wang <hsinyi@chromium.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>

This series adds the kernel's build ID to the stacktrace header printed
in oops messages, warnings, etc. and the build ID for any module that
appears in the stacktrace after the module name. The goal is to make the
stacktrace more self-contained and descriptive by including the relevant
build IDs in the kernel logs when something goes wrong. This can be used
by post processing tools like script/decode_stacktrace.sh and kernel
developers to easily locate the debug info associated with a kernel
crash and line up what line and file things started falling apart at.

This also includes a patch to make the buildid.c file use more const
arguments and consolidate logic into buildid.c from kdump. These are
left to the end as they were mostly cleanup patches. I don't know who
exactly maintains this so I guess Andrew is the best option to merge all
this code.

Here's an example lkdtm stacktrace

 WARNING: CPU: 4 PID: 3255 at drivers/misc/lkdtm/bugs.c:83 lkdtm_WARNING+0x28/0x30 [lkdtm] (ed5019fdf5e53be37cb1ba7899292d7e143b259e)
 Modules linked in: lkdtm rfcomm algif_hash algif_skcipher af_alg xt_cgroup uinput xt_MASQUERADE
 CPU: 4 PID: 3255 Comm: bash Not tainted 5.11 #3 aa23f7a1231c229de205662d5a9e0d4c580f19a1
 Hardware name: Google Lazor (rev3+) with KB Backlight (DT)
 pstate: 00400009 (nzcv daif +PAN -UAO -TCO BTYPE=--)
 pc : lkdtm_WARNING+0x28/0x30 [lkdtm] (ed5019fdf5e53be37cb1ba7899292d7e143b259e)
 lr : lkdtm_do_action+0x24/0x40 [lkdtm] (ed5019fdf5e53be37cb1ba7899292d7e143b259e)
 sp : ffffffc0134fbca0
 x29: ffffffc0134fbca0 x28: ffffff92d53ba240
 x27: 0000000000000000 x26: 0000000000000000
 x25: 0000000000000000 x24: ffffffe3622352c0
 x23: 0000000000000020 x22: ffffffe362233366
 x21: ffffffe3622352e0 x20: ffffffc0134fbde0
 x19: 0000000000000008 x18: 0000000000000000
 x17: ffffff929b6536fc x16: 0000000000000000
 x15: 0000000000000000 x14: 0000000000000012
 x13: ffffffe380ed892c x12: ffffffe381d05068
 x11: 0000000000000000 x10: 0000000000000000
 x9 : 0000000000000001 x8 : ffffffe362237000
 x7 : aaaaaaaaaaaaaaaa x6 : 0000000000000000
 x5 : 0000000000000000 x4 : 0000000000000001
 x3 : 0000000000000008 x2 : ffffff93fef25a70
 x1 : ffffff93fef15788 x0 : ffffffe3622352e0
 Call trace:
  lkdtm_WARNING+0x28/0x30 [lkdtm] (ed5019fdf5e53be37cb1ba7899292d7e143b259e)
  direct_entry+0x16c/0x1b4 [lkdtm] (ed5019fdf5e53be37cb1ba7899292d7e143b259e)
  full_proxy_write+0x74/0xa4
  vfs_write+0xec/0x2e8
  ksys_write+0x84/0xf0
  __arm64_sys_write+0x24/0x30
  el0_svc_common+0xf4/0x1c0
  do_el0_svc_compat+0x28/0x3c
  el0_svc_compat+0x10/0x1c
  el0_sync_compat_handler+0xa8/0xcc
  el0_sync_compat+0x178/0x180
 ---[ end trace 3d95032303e59e68 ]---

Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Evan Green <evgreen@chromium.org>
Cc: Hsin-Yi Wang <hsinyi@chromium.org>
Cc: Jessica Yu <jeyu@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: <kexec@lists.infradead.org>
Cc: <linux-doc@vger.kernel.org>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Vivek Goyal <vgoyal@redhat.com>

Stephen Boyd (7):
  buildid: Add method to get running kernel's build ID
  dump_stack: Add vmlinux build ID to stack traces
  buildid: Add API to parse build ID out of buffer
  module: Parse and stash build ID on insertion
  printk: Make %pS and friends print module build ID
  buildid: Mark some arguments const
  kdump: Use vmlinux_build_id() to simplify

 Documentation/core-api/printk-formats.rst |  6 ++
 include/linux/buildid.h                   |  4 +
 include/linux/kallsyms.h                  |  6 +-
 include/linux/module.h                    |  6 +-
 kernel/crash_core.c                       | 46 ++----------
 kernel/kallsyms.c                         | 45 ++++++++----
 kernel/module.c                           | 24 +++++-
 lib/buildid.c                             | 89 +++++++++++++++++++----
 lib/dump_stack.c                          |  5 +-
 9 files changed, 157 insertions(+), 74 deletions(-)


base-commit: fe07bfda2fb9cdef8a4d4008a409bb02f35f1bd8
-- 
https://chromeos.dev


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
