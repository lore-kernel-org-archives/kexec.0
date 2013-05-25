Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Ug599-0003hi-4b
 for kexec@lists.infradead.org; Sat, 25 May 2013 03:27:55 +0000
Received: by mail-pa0-f47.google.com with SMTP id kl12so1536572pab.34
 for <kexec@lists.infradead.org>; Fri, 24 May 2013 20:27:33 -0700 (PDT)
Message-ID: <51A02F9B.6020904@gmail.com>
Date: Sat, 25 May 2013 11:27:23 +0800
From: Zhang Yanfei <zhangyanfei.yes@gmail.com>
MIME-Version: 1.0
Subject: [PATCH 3/7] Documentation/kdump/kdump.txt: Remove /dev/oldmem
 description
References: <51A02E50.5020507@gmail.com>
In-Reply-To: <51A02E50.5020507@gmail.com>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>, Simon Horman <horms@verge.net.au>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>

Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
---
 Documentation/kdump/kdump.txt |   31 ++++++-------------------------
 1 files changed, 6 insertions(+), 25 deletions(-)

diff --git a/Documentation/kdump/kdump.txt b/Documentation/kdump/kdump.txt
index 9c7fd98..bec123e 100644
--- a/Documentation/kdump/kdump.txt
+++ b/Documentation/kdump/kdump.txt
@@ -47,19 +47,12 @@ parameter. Optionally the size of the ELF header can also be passed
 when using the elfcorehdr=[size[KMG]@]offset[KMG] syntax.
 
 
-With the dump-capture kernel, you can access the memory image, or "old
-memory," in two ways:
-
-- Through a /dev/oldmem device interface. A capture utility can read the
-  device file and write out the memory in raw format. This is a raw dump
-  of memory. Analysis and capture tools must be intelligent enough to
-  determine where to look for the right information.
-
-- Through /proc/vmcore. This exports the dump as an ELF-format file that
-  you can write out using file copy commands such as cp or scp. Further,
-  you can use analysis tools such as the GNU Debugger (GDB) and the Crash
-  tool to debug the dump file. This method ensures that the dump pages are
-  correctly ordered.
+With the dump-capture kernel, you can access the memory image through
+/proc/vmcore. This exports the dump as an ELF-format file that you can
+write out using file copy commands such as cp or scp. Further, you can
+use analysis tools such as the GNU Debugger (GDB) and the Crash tool to
+debug the dump file. This method ensures that the dump pages are correctly
+ordered.
 
 
 Setup and Installation
@@ -423,18 +416,6 @@ the following command:
 
    cp /proc/vmcore <dump-file>
 
-You can also access dumped memory as a /dev/oldmem device for a linear
-and raw view. To create the device, use the following command:
-
-    mknod /dev/oldmem c 1 12
-
-Use the dd command with suitable options for count, bs, and skip to
-access specific portions of the dump.
-
-To see the entire memory, use the following command:
-
-   dd if=/dev/oldmem of=oldmem.001
-
 
 Analysis
 ========
-- 
1.7.1

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
