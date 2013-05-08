Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from usindpps04.hds.com ([207.126.252.17])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UaDdx-0004EQ-SW
 for kexec@lists.infradead.org; Wed, 08 May 2013 23:19:31 +0000
From: Seiji Aguchi <seiji.aguchi@hds.com>
Subject: [PATCH]Add kmsg_dump() to kexec path
Date: Wed, 8 May 2013 23:18:52 +0000
Message-ID: <A5ED84D3BB3A384992CBB9C77DEDA4D41AFEF289@USINDEM103.corp.hds.com>
Content-Language: en-US
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kexec-list (kexec@lists.infradead.org)" <kexec@lists.infradead.org>, "ebiederm@xmission.com" <ebiederm@xmission.com>
Cc: "dle-develop@lists.sourceforge.net" <dle-develop@lists.sourceforge.net>, "Luck, Tony (tony.luck@intel.com)" <tony.luck@intel.com>, "keescook@chromium.org" <keescook@chromium.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "kay@vrfy.org" <kay@vrfy.org>, Tomoki Sekiyama <tomoki.sekiyama@hds.com>, "cbouatmailru@gmail.com" <cbouatmailru@gmail.com>, "vgoyal@redhat.com" <vgoyal@redhat.com>

Problem
=======

From our support service experience, we always need to detect root cause of OS panic.
And customers in enterprise area never forgive us if we can't detect the root cause 
of panic due to lack of materials for investigation.

Kdump is a powerful troubleshooting feature, but it may accesses to multiple hardware, 
like HBA, FC-cable, to get to dump disk.

This means kdump is not robust against hardware failure.

Solution
========

Logging kernel message to persistent device is an effective way to get materials 
for investigation in case of kdump failure.

So, this patch adds kmsg_dump() to a kexec path.
Also, it adds KMSG_DUMP_KEXEC to pstore_cannot_block_path()
so that it can avoid deadlocking in kexec path.

Please see the detail of pstore_cannot_block_path().
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/fs/pstore/platform.c?id=9f244e9cfd70c7c0f82d3c92ce772ab2a92d9f64   

Actually, there are some objections about kmsg_dump(KMSG_DUMP_KEXEC) and EFI below.
But I still think adding kmsg_dump() to a kexec path is useful.

- http://marc.info/?l=linux-kernel&m=130698519720887&w=2

(1) kdump already saves kernel messages inside /proc/vmcore

- https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/kernel/kexec.c?id=a3dd3323058d281abd584b15ad4c5b65064d7a61

    It is correct, but the content of /proc/vmcore is stored a dump disk as well.
    So, if kdump fails due to hardware failures, the kernel messages will be lost.

(2) EFI firmware is buggy

- http://marc.info/?l=linux-kernel&m=130698519720887&w=2

I haven't seen actual firmware bugs which may cause kdump failure. 
So I don't think we need to care about it too much.
However, just to be safe, I introduced pstore_cannot_block_path() avoid deadlocking to pstore.

Also, this patch doesn't affect almost all users because kmsg_dump() is kicked only when 
specifying both pstore.backend and printk.always_kmsg_dump parameters.
Even if a buggy firmware causes a kdump failure and someone blames kdump,
we can ask them to reproduce the kdump failure by removing the parameters.

In addition, I checked current coding of platform drivers.
There is no obvious problem as follows.

- mtdoops/ramoops
  They are designed to be kicked in panic and oops cases only.
  So, they never run in a kexec path.

- erst/efi/early_printk_mrst/nvram driver for powerpc
  I don't see any bugs which may causes kdump failure because
  deadlocking/dynamic memory allocation don't happen in their write callbacks.

Signed-off-by: Seiji Aguchi <seiji.aguchi@hds.com>
---
 fs/pstore/platform.c      |    4 ++++
 include/linux/kmsg_dump.h |    1 +
 kernel/kexec.c            |    2 ++
 3 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index 86d1038..e6f651f 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -91,6 +91,8 @@ static const char *get_reason_str(enum kmsg_dump_reason reason)
 		return "Halt";
 	case KMSG_DUMP_POWEROFF:
 		return "Poweroff";
+	case KMSG_DUMP_KEXEC:
+		return "Kexec";
 	default:
 		return "Unknown";
 	}
@@ -110,6 +112,8 @@ bool pstore_cannot_block_path(enum kmsg_dump_reason reason)
 	case KMSG_DUMP_PANIC:
 	/* Emergency restart shouldn't be blocked by spin lock. */
 	case KMSG_DUMP_EMERG:
+	/* In kexec path, pstore shouldn't be blocked to avoid kexec failure. */
+	case KMSG_DUMP_KEXEC:
 		return true;
 	default:
 		return false;
diff --git a/include/linux/kmsg_dump.h b/include/linux/kmsg_dump.h
index 2e7a1e0..c943ecb 100644
--- a/include/linux/kmsg_dump.h
+++ b/include/linux/kmsg_dump.h
@@ -28,6 +28,7 @@ enum kmsg_dump_reason {
 	KMSG_DUMP_RESTART,
 	KMSG_DUMP_HALT,
 	KMSG_DUMP_POWEROFF,
+	KMSG_DUMP_KEXEC,
 };
 
 /**
diff --git a/kernel/kexec.c b/kernel/kexec.c
index 59f7b55..f084132 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -32,6 +32,7 @@
 #include <linux/vmalloc.h>
 #include <linux/swap.h>
 #include <linux/syscore_ops.h>
+#include <linux/kmsg_dump.h>
 
 #include <asm/page.h>
 #include <asm/uaccess.h>
@@ -1089,6 +1090,7 @@ void crash_kexec(struct pt_regs *regs)
 
 			crash_setup_regs(&fixed_regs, regs);
 			crash_save_vmcoreinfo();
+			kmsg_dump(KMSG_DUMP_KEXEC);
 			machine_crash_shutdown(&fixed_regs);
 			machine_kexec(kexec_crash_image);
 		}
-- 1.7.1

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
