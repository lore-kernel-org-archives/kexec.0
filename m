Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo161.gate.nec.co.jp ([114.179.232.161])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cjIqp-0004mD-JX
 for kexec@lists.infradead.org; Thu, 02 Mar 2017 05:00:29 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: RE: [Makedumpfile Patch v2 7/7] mem-usage: allow to work only with
 -f for kernel version < 4.11
Date: Thu, 2 Mar 2017 04:49:42 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701EAA666@BPXM01GP.gisp.nec.co.jp>
References: <cover.1488260510.git.panand@redhat.com>
 <72c8ce7c8c2a54714a8338a08e2ab5ae31e6d4e2.1488260510.git.panand@redhat.com>
In-Reply-To: <72c8ce7c8c2a54714a8338a08e2ab5ae31e6d4e2.1488260510.git.panand@redhat.com>
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
To: Pratyush Anand <panand@redhat.com>
Cc: "dyoung@redhat.com" <dyoung@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "bhe@redhat.com" <bhe@redhat.com>

Hello Pratyush,

>PT_LOAD of kcore does not have valid p_paddr values for kernel version
>less that v4.11. Therefore, older kernel will no long work for mem-usage
>with current makedumpfile code. They can only work when they are patched
>with fix to "update physical address for kcore ram and text".
>
>This patch fixes the makedumpfile so that it does not allow to work
>older kernel for --mem-usage until someone is sure that kernel is
>rightly patched and so uses -f in command line.
>
>Signed-off-by: Pratyush Anand <panand@redhat.com>
>---
> makedumpfile.c | 6 ++++++
> 1 file changed, 6 insertions(+)
>
>diff --git a/makedumpfile.c b/makedumpfile.c
>index 3b8e9810468d..bf006ea5dd5f 100644
>--- a/makedumpfile.c
>+++ b/makedumpfile.c
>@@ -11269,6 +11269,12 @@ main(int argc, char *argv[])
> 			MSG("Try `makedumpfile --help' for more information.\n");
> 			goto out;
> 		}
>+		if (info->kernel_version < KERNEL_VERSION(4, 11, 0) &&
>+				!info->flag_force) {
>+			MSG("mem-usage not supported for this kernel.\n");
>+			MSG("You can try with -f if your kernel's kcore has valid p_paddr\n");
>+			return COMPLETED;
>+		}

Should use "goto out" to prevent memory leaks since some heap blocks are
allocated at the head of main().

BTW, the descriptions of -f option in man and print_usage() don't mention this usage:

       -f     Force existing DUMPFILE to be overwritten.
              Example:
              # makedumpfile -f -d 31 -x vmlinux /proc/vmcore dumpfile
              This command overwrites DUMPFILE even if it already exists.

so they should be updated.


Thanks,
Atsushi Kumagai


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
