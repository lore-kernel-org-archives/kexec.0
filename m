Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZyaPl-0002Cb-VR
 for kexec@lists.infradead.org; Tue, 17 Nov 2015 07:10:57 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: Support for dynamic allocations of 'struct fpu'
Date: Tue, 17 Nov 2015 07:08:55 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701E04B64@BPXM01GP.gisp.nec.co.jp>
Content-Language: ja-JP
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
To: "Discussion list for crash utility usage,
 maintenance and development (crash-utility@redhat.com)" <crash-utility@redhat.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hello,

This is a follow-up report of the issue I found in the release test
for makedumpfile-1.5.9. The original report was posted in kexec-ML:

  http://lists.infradead.org/pipermail/kexec/2015-October/014620.html

> o Support new kernels
>  - The supported kernel is updated to 4.1 in this version.
>    At first I'm going to extend the supported version to 4.2, but
>    I found an issue that makedumpfile seems to exclude necessary pages
>    by mistake on linux 4.2. When crash-7.1.3 reads that filtered dump file,
>    the following message is shown.
> 
>       crash: page excluded: kernel virtual address: f3fe0000  type: "fill_task_struct"
> 
>    This will be fixed in the next version.

I looked for the cause of this issue and found that it doesn't seem to be an
issue of makedumpfile, it seems to be a crash side issue.

The size of task_struct is decided dynamically by FPU registers since linux 4.2
due to:

  commit 5aaeb5c01c5b6c0be7b7aadbf3ace9f3a4458c3d
  Author: Ingo Molnar <mingo@kernel.org>
  Date:   Fri Jul 17 12:28:12 2015 +0200

      x86/fpu, sched: Introduce CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT and use it on x86

and

  commit 0c8c0f03e3a292e031596484275c14cf39c0ab7a
  Author: Dave Hansen <dave@sr71.net>
  Date:   Fri Jul 17 12:28:11 2015 +0200

      86/fpu, sched: Dynamically allocate 'struct fpu'

This change will cause a difference between dwarf info and the actual size
like below:
(This is an example in linux 4.2 on x86_64)

- dwarf info

    $ dwarfdump vmlinux | grep -A 2 task_struct
    DW_AT_name                  "task_struct"
    DW_AT_byte_size             0x00001940                         // 6464 byte
    DW_AT_decl_file             0x0000001a include/linux/sched.h

- actual size

    crash> p arch_task_struct_size
    arch_task_struct_size = $1 = 2880
    crash>

I don't think crash handle this change, so crash can read an irrelevant
page when trying to read a task_struct. If the dump is filtered by makedumpfile
and the page just behind the task_struct is excluded, the message I reported
will be shown.

To fix the size_table for the crash's initialization is easy, we should
just update it by arch_task_struct_size like:


diff --git a/task.c b/task.c
index 8956fb5..ee94d4e 100755
--- a/task.c
+++ b/task.c
@@ -284,6 +284,17 @@ task_init(void)
        MEMBER_OFFSET_INIT(pid_pid_chain, "pid", "pid_chain");

        STRUCT_SIZE_INIT(task_struct, "task_struct");
+       int task_struct_size;
+       if (kernel_symbol_exists("arch_task_struct_size") &&
+           readmem(symbol_value("arch_task_struct_size"), KVADDR,
+                   &task_struct_size, sizeof(int),
+                   "arch_task_struct_size", RETURN_ON_ERROR)) {
+               ASSIGN_SIZE(task_struct) = task_struct_size;
+               if (CRASHDEBUG(1))
+                       fprintf(fp, "\downsize_task_struct: %ld to %ld\n",
+                               STRUCT_SIZE("task_struct"),
+                               SIZE(task_struct));
+       }


However, struct command always refer to dwarf info since it's probably
designed for general purpose, I can't come up with good way to fix it.

Do you have any comments ?


Thanks,
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
