Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h4k93-0005fM-Ml
 for kexec@lists.infradead.org; Fri, 15 Mar 2019 10:32:59 +0000
From: Lianbo Jiang <lijiang@redhat.com>
Subject: [PATCH 3/3] kdump,
 proc/vmcore: Enable kdumping encrypted memory when SEV was active
Date: Fri, 15 Mar 2019 18:32:03 +0800
Message-Id: <20190315103203.13128-4-lijiang@redhat.com>
In-Reply-To: <20190315103203.13128-1-lijiang@redhat.com>
References: <20190315103203.13128-1-lijiang@redhat.com>
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
To: linux-kernel@vger.kernel.org
Cc: thomas.lendacky@amd.com, brijesh.singh@amd.com, bhe@redhat.com, x86@kernel.org, kexec@lists.infradead.org, mingo@redhat.com, bp@alien8.de, hpa@zytor.com, tglx@linutronix.de, dyoung@redhat.com, akpm@linux-foundation.org

In the kdump kernel, the memory of first kernel needs to be dumped
into the vmcore file.

It is similar to the SME, if SEV is enabled in the first kernel, the
old memory has to be remapped with memory encryption mask in order to
access it properly. Following commit 992b649a3f01 ("kdump, proc/vmcore:
Enable kdumping encrypted memory with SME enabled") took care of the
SME case but it uses sme_active() which checks for SME only. Lets use
the mem_encrypt_active() which returns true when either of them are
active.

Unlike the SME, the first kernel is loaded into the encrypted memory
when SEV was enabled, hence the kernel elf header must be remapped as
encrypted in order to access it properly.

Co-developed-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
---
 fs/proc/vmcore.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 3fe90443c1bb..cda6c1922e4f 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -165,7 +165,7 @@ void __weak elfcorehdr_free(unsigned long long addr)
  */
 ssize_t __weak elfcorehdr_read(char *buf, size_t count, u64 *ppos)
 {
-	return read_from_oldmem(buf, count, ppos, 0, false);
+	return read_from_oldmem(buf, count, ppos, 0, sev_active());
 }
 
 /*
@@ -173,7 +173,7 @@ ssize_t __weak elfcorehdr_read(char *buf, size_t count, u64 *ppos)
  */
 ssize_t __weak elfcorehdr_read_notes(char *buf, size_t count, u64 *ppos)
 {
-	return read_from_oldmem(buf, count, ppos, 0, sme_active());
+	return read_from_oldmem(buf, count, ppos, 0, mem_encrypt_active());
 }
 
 /*
@@ -373,7 +373,7 @@ static ssize_t __read_vmcore(char *buffer, size_t buflen, loff_t *fpos,
 					    buflen);
 			start = m->paddr + *fpos - m->offset;
 			tmp = read_from_oldmem(buffer, tsz, &start,
-					       userbuf, sme_active());
+					       userbuf, mem_encrypt_active());
 			if (tmp < 0)
 				return tmp;
 			buflen -= tsz;
-- 
2.17.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
