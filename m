Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WroRo-00015V-Pt
 for kexec@lists.infradead.org; Tue, 03 Jun 2014 13:08:13 +0000
From: Vivek Goyal <vgoyal@redhat.com>
Subject: [PATCH 05/13] kexec: Make kexec_segment user buffer pointer a union
Date: Tue,  3 Jun 2014 09:06:54 -0400
Message-Id: <1401800822-27425-6-git-send-email-vgoyal@redhat.com>
In-Reply-To: <1401800822-27425-1-git-send-email-vgoyal@redhat.com>
References: <1401800822-27425-1-git-send-email-vgoyal@redhat.com>
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
To: linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Cc: mjg59@srcf.ucam.org, bhe@redhat.com, jkosina@suse.cz, hpa@zytor.com, Vivek Goyal <vgoyal@redhat.com>, bp@alien8.de, ebiederm@xmission.com, greg@kroah.com, akpm@linux-foundation.org, dyoung@redhat.com, chaowang@redhat.com

So far kexec_segment->buf was always a user space pointer as user space
passed the array of kexec_segment structures and kernel copied it.

But with new system call, list of kexec segments will be prepared by
kernel and kexec_segment->buf will point to a kernel memory.

So while I was adding code where I made assumption that ->buf is pointing
to kernel memory, sparse started giving warning.

Make ->buf a union. And where a user space pointer is expected, access
it using ->buf and where a kernel space pointer is expected, access it
using ->kbuf. That takes care of sparse warnings.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 include/linux/kexec.h | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index a756419..d0285cc 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -69,7 +69,18 @@ typedef unsigned long kimage_entry_t;
 #define IND_SOURCE       0x8
 
 struct kexec_segment {
-	void __user *buf;
+	/*
+	 * This pointer can point to user memory if kexec_load() system
+	 * call is used or will point to kernel memory if
+	 * kexec_file_load() system call is used.
+	 *
+	 * Use ->buf when expecting to deal with user memory and use ->kbuf
+	 * when expecting to deal with kernel memory.
+	 */
+	union {
+		void __user *buf;
+		void *kbuf;
+	};
 	size_t bufsz;
 	unsigned long mem;
 	size_t memsz;
-- 
1.9.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
