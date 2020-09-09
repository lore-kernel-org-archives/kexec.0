Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]
 helo=us-smtp-delivery-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kFute-0000aQ-CY
 for kexec@lists.infradead.org; Wed, 09 Sep 2020 07:52:07 +0000
From: Kairui Song <kasong@redhat.com>
Subject: [RFC PATCH 1/3] vmcore: simplify read_from_olemem
Date: Wed,  9 Sep 2020 15:50:14 +0800
Message-Id: <20200909075016.104407-2-kasong@redhat.com>
In-Reply-To: <20200909075016.104407-1-kasong@redhat.com>
References: <20200909075016.104407-1-kasong@redhat.com>
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
To: linux-kernel@vger.kernel.org
Cc: Kairui Song <kasong@redhat.com>, Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Eric Biederman <ebiederm@xmission.com>, Thomas Gleixner <tglx@linutronix.de>, Dave Young <dyoung@redhat.com>, Alexey Dobriyan <adobriyan@gmail.com>, Vivek Goyal <vgoyal@redhat.com>

Simplify the code logic, also helps reduce object size and stack usage.

Stack usage:
  Before: fs/proc/vmcore.c:106:9:read_from_oldmem.part.0  80     static
          fs/proc/vmcore.c:106:9:read_from_oldmem         16     static
  After:  fs/proc/vmcore.c:106:9:read_from_oldmem         80     static

Size of vmcore.o:
          text    data     bss     dec     hex filename
  Before: 7677     109      88    7874    1ec2 fs/proc/vmcore.o
  After:  7669     109      88    7866    1eba fs/proc/vmcore.o

Signed-off-by: Kairui Song <kasong@redhat.com>
---
 fs/proc/vmcore.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index c3a345c28a93..124c2066f3e5 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -108,25 +108,19 @@ ssize_t read_from_oldmem(char *buf, size_t count,
 			 bool encrypted)
 {
 	unsigned long pfn, offset;
-	size_t nr_bytes;
-	ssize_t read = 0, tmp;
+	size_t nr_bytes, to_copy = count;
+	ssize_t tmp;
 
-	if (!count)
-		return 0;
-
-	offset = (unsigned long)(*ppos % PAGE_SIZE);
+	offset = (unsigned long)(*ppos & (PAGE_SIZE - 1));
 	pfn = (unsigned long)(*ppos / PAGE_SIZE);
 
-	do {
-		if (count > (PAGE_SIZE - offset))
-			nr_bytes = PAGE_SIZE - offset;
-		else
-			nr_bytes = count;
+	while (to_copy) {
+		nr_bytes = min(to_copy, PAGE_SIZE - offset);
 
 		/* If pfn is not ram, return zeros for sparse dump files */
-		if (pfn_is_ram(pfn) == 0)
+		if (pfn_is_ram(pfn) == 0) {
 			memset(buf, 0, nr_bytes);
-		else {
+		} else {
 			if (encrypted)
 				tmp = copy_oldmem_page_encrypted(pfn, buf,
 								 nr_bytes,
@@ -140,14 +134,13 @@ ssize_t read_from_oldmem(char *buf, size_t count,
 				return tmp;
 		}
 		*ppos += nr_bytes;
-		count -= nr_bytes;
 		buf += nr_bytes;
-		read += nr_bytes;
+		to_copy -= nr_bytes;
 		++pfn;
 		offset = 0;
-	} while (count);
+	}
 
-	return read;
+	return count;
 }
 
 /*
-- 
2.26.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
