Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e23smtp01.au.ibm.com ([202.81.31.143])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1Rxs8x-00017U-7d
 for kexec@lists.infradead.org; Thu, 16 Feb 2012 03:36:29 +0000
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <suzuki@in.ibm.com>;
 Thu, 16 Feb 2012 03:30:10 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q1G3UkRZ3371060
 for <kexec@lists.infradead.org>; Thu, 16 Feb 2012 14:30:46 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q1G3ZvgA027269
 for <kexec@lists.infradead.org>; Thu, 16 Feb 2012 14:35:57 +1100
From: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Subject: [PATCH v1 1/4] [makedumpfile] Add read_string routine
Date: Thu, 16 Feb 2012 09:05:40 +0530
Message-ID: <20120216033535.7972.21257.stgit@suzukikp>
In-Reply-To: <20120216033411.7972.77705.stgit@suzukikp>
References: <20120216033411.7972.77705.stgit@suzukikp>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kumagai-atsushi@mxc.nes.nec.co.jp
Cc: kexec@lists.infradead.org

This patch adds a read_string() wrapper around readmem().

int read_string(int type_addr, unsigned long long addr, char *bufptr, size_t len);

The functionality is similar to that of readmem(), except that we stop reading
when we find an end-of-string marker than reading 'len' bytes.

This will be useful for reading the name of the 'powerpc' platform which is
needed for dynamic page address definition bits.


Signed-off-by: Suzuki K. Poulose <suzuki@in.ibm.com>
---

 makedumpfile.c |   12 ++++++++++++
 makedumpfile.h |    1 +
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 901b85c..e978e1c 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -373,6 +373,18 @@ error:
 	return FALSE;
 }
 
+int
+read_string(int type_addr, unsigned long long addr, char *buf, size_t len)
+{
+	int i;
+
+	memset(buf, 0, len);
+	for (i = 0; i < len; i ++)
+		if (!readmem(VADDR, addr + i, &buf[i], 1))
+			break;
+	return i;
+}
+
 int32_t
 get_kernel_version(char *release)
 {
diff --git a/makedumpfile.h b/makedumpfile.h
index e43ea84..9dc254e 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -1243,6 +1243,7 @@ extern struct srcfile_table	srcfile_table;
 
 
 int readmem(int type_addr, unsigned long long addr, void *bufptr, size_t size);
+int read_string(int type_addr, unsigned long long addr, char *bufptr, size_t len);
 int get_str_osrelease_from_vmlinux(void);
 int read_vmcoreinfo_xen(void);
 int exclude_xen_user_domain(void);


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
