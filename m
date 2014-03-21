Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WQq1N-0007OC-Dh
 for kexec@lists.infradead.org; Fri, 21 Mar 2014 03:21:26 +0000
From: WANG Chao <chaowang@redhat.com>
Subject: [PATCH] vmcore: continue vmcore initialization if PT_NOTE is found
 empty
Date: Fri, 21 Mar 2014 11:20:53 +0800
Message-Id: <1395372053-19794-1-git-send-email-chaowang@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>, Greg Pearson <greg.pearson@hp.com>, Andrew Morton <akpm@linux-foundation.org>, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, bhe@redhat.com
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org

Currently when an empty PT_NOTE is detected, vmcore initialization
fails. It sounds too harsh. Because PT_NOTE could be empty, for example,
one offlined a cpu but never restarted kdump service, and after crash,
PT_NOTE program header is there but no data contains. It's better to
warn about the empty PT_NOTE and continue to initialise vmcore.

And ultimately the multiple PT_NOTE are merged into a single one, all
empty PT_NOTE are discarded naturally during the merge. So empty PT_NOTE
is not visible to user space and vmcore is as good as expected.

Signed-off-by: WANG Chao <chaowang@redhat.com>
---
 fs/proc/vmcore.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 88d4585..dc71bf9 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -484,7 +484,6 @@ static int __init update_note_header_size_elf64(const Elf64_Ehdr *ehdr_ptr)
 		phdr_ptr->p_memsz = real_sz;
 		if (real_sz == 0) {
 			pr_warn("Warning: Zero PT_NOTE entries found\n");
-			return -EINVAL;
 		}
 	}
 
@@ -671,7 +670,6 @@ static int __init update_note_header_size_elf32(const Elf32_Ehdr *ehdr_ptr)
 		phdr_ptr->p_memsz = real_sz;
 		if (real_sz == 0) {
 			pr_warn("Warning: Zero PT_NOTE entries found\n");
-			return -EINVAL;
 		}
 	}
 
-- 
1.8.5.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
