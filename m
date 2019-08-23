Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i18Kz-0008JU-3L
 for kexec@lists.infradead.org; Fri, 23 Aug 2019 12:06:40 +0000
From: Lianbo Jiang <lijiang@redhat.com>
Subject: [PATCH 4/4 v2] Limit the size of vmcore-dmesg.txt to 2G
Date: Fri, 23 Aug 2019 20:05:39 +0800
Message-Id: <20190823120539.18330-5-lijiang@redhat.com>
In-Reply-To: <20190823120539.18330-1-lijiang@redhat.com>
References: <20190823120539.18330-1-lijiang@redhat.com>
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
To: kexec@lists.infradead.org
Cc: kasong@redhat.com, bhe@redhat.com, piliu@redhat.com, bhsharma@redhat.com, junw99@yahoo.com, horms@verge.net.au, dyoung@redhat.com

With some corrupted vmcore files, the vmcore-dmesg.txt file may grow
forever till the kdump disk becomes full, and also probably causes
the disk error messages as follow:
...
sd 0:0:0:0: [sda] tag#6 FAILED Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
sd 0:0:0:0: [sda] tag#6 CDB: Read(10) 28 00 08 06 4c 98 00 00 08 00
blk_update_request: I/O error, dev sda, sector 134630552
sd 0:0:0:0: [sda] tag#7 FAILED Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
sd 0:0:0:0: [sda] tag#7 CDB: Read(10) 28 00 08 06 4c 98 00 00 08 00
blk_update_request: I/O error, dev sda, sector 134630552
...

If vmcore-dmesg.txt occupies the whole disk, the vmcore can not be
saved, this is also a problem.

Lets limit the size of vmcore-dmesg.txt to avoid such problems.

Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
---
 vmcore-dmesg/vmcore-dmesg.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/vmcore-dmesg/vmcore-dmesg.c b/vmcore-dmesg/vmcore-dmesg.c
index fe7df8ec372c..81c2a58c9d86 100644
--- a/vmcore-dmesg/vmcore-dmesg.c
+++ b/vmcore-dmesg/vmcore-dmesg.c
@@ -5,9 +5,19 @@ typedef Elf32_Nhdr Elf_Nhdr;
 
 extern const char *fname;
 
+/* stole this macro from kernel printk.c */
+#define LOG_BUF_LEN_MAX (uint32_t)(1 << 31)
+
 static void write_to_stdout(char *buf, unsigned int nr)
 {
 	ssize_t ret;
+	static uint32_t n_bytes = 0;
+
+	n_bytes += nr;
+	if (n_bytes > LOG_BUF_LEN_MAX) {
+		fprintf(stderr, "The vmcore-dmesg.txt over 2G in size is not supported.\n");
+		exit(53);
+	}
 
 	ret = write(STDOUT_FILENO, buf, nr);
 	if (ret != nr) {
-- 
2.17.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
