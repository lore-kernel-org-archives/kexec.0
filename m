Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UHmKZ-0005hz-7d
 for kexec@lists.infradead.org; Tue, 19 Mar 2013 02:31:16 +0000
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 76D143EE0C7
 for <kexec@lists.infradead.org>; Tue, 19 Mar 2013 11:31:12 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 5963F45DEBE
 for <kexec@lists.infradead.org>; Tue, 19 Mar 2013 11:31:12 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 3FE3645DEB7
 for <kexec@lists.infradead.org>; Tue, 19 Mar 2013 11:31:12 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 1AB6BE1800E
 for <kexec@lists.infradead.org>; Tue, 19 Mar 2013 11:31:12 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 83C8AE18002
 for <kexec@lists.infradead.org>; Tue, 19 Mar 2013 11:31:11 +0900 (JST)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [PATCH v3 13/21] kexec: allocate vmcoreinfo note buffer on page-size
 boundary
Date: Sat, 16 Mar 2013 13:02:00 +0900
Message-ID: <20130316040200.15064.86851.stgit@localhost6.localdomain6>
In-Reply-To: <20130316040003.15064.62308.stgit@localhost6.localdomain6>
References: <20130316040003.15064.62308.stgit@localhost6.localdomain6>
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
To: vgoyal@redhat.com, ebiederm@xmission.com, cpw@sgi.com, kumagai-atsushi@mxc.nes.nec.co.jp, lisa.mitchell@hp.com, heiko.carstens@de.ibm.com, akpm@linux-foundation.org
Cc: zhangyanfei@cn.fujitsu.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

To satisfy mmap()'s page-size boundary requirement, specify aligned
attribute to vmcoreinfo_note objects to allocate it on page-size
boundary.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---

 include/linux/kexec.h |    6 ++++--
 kernel/kexec.c        |    2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index d2e6927..5113570 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -185,8 +185,10 @@ extern struct kimage *kexec_crash_image;
 #define VMCOREINFO_BYTES           (4096)
 #define VMCOREINFO_NOTE_NAME       "VMCOREINFO"
 #define VMCOREINFO_NOTE_NAME_BYTES ALIGN(sizeof(VMCOREINFO_NOTE_NAME), 4)
-#define VMCOREINFO_NOTE_SIZE       (KEXEC_NOTE_HEAD_BYTES*2 + VMCOREINFO_BYTES \
-				    + VMCOREINFO_NOTE_NAME_BYTES)
+#define VMCOREINFO_NOTE_SIZE       ALIGN(KEXEC_NOTE_HEAD_BYTES*2	\
+					 +VMCOREINFO_BYTES		\
+					 +VMCOREINFO_NOTE_NAME_BYTES,	\
+					 PAGE_SIZE)
 
 /* Location of a reserved region to hold the crash kernel.
  */
diff --git a/kernel/kexec.c b/kernel/kexec.c
index d1f365e..195de6d 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -43,7 +43,7 @@ note_buf_t __percpu *crash_notes;
 
 /* vmcoreinfo stuff */
 static unsigned char vmcoreinfo_data[VMCOREINFO_BYTES];
-u32 vmcoreinfo_note[VMCOREINFO_NOTE_SIZE/4];
+u32 vmcoreinfo_note[VMCOREINFO_NOTE_SIZE/4] __aligned(PAGE_SIZE);
 size_t vmcoreinfo_size;
 size_t vmcoreinfo_max_size = sizeof(vmcoreinfo_data);
 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
