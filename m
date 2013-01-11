Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e28smtp03.in.ibm.com ([122.248.162.3])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TtYJo-0007JE-JD
 for kexec@lists.infradead.org; Fri, 11 Jan 2013 06:42:21 +0000
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <suzuki@in.ibm.com>;
 Fri, 11 Jan 2013 12:11:01 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id CCEB9125804E
 for <kexec@lists.infradead.org>; Fri, 11 Jan 2013 12:12:26 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r0B6g9VW34210042
 for <kexec@lists.infradead.org>; Fri, 11 Jan 2013 12:12:10 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r0B6gBIR007103
 for <kexec@lists.infradead.org>; Fri, 11 Jan 2013 17:42:11 +1100
Subject: [PATCH 3/3] ppc/uImage: Add support for RAM Disks
From: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Date: Fri, 11 Jan 2013 12:12:11 +0530
Message-ID: <20130111064203.11490.72998.stgit@suzukikp.in.ibm.com>
In-Reply-To: <20130111063547.11490.28174.stgit@suzukikp.in.ibm.com>
References: <20130111063547.11490.28174.stgit@suzukikp.in.ibm.com>
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
To: horms@verge.net.au
Cc: bigeasy@linutronix.de, lethal@linux-sh.org, kexec@lists.infradead.org, mat@brain-dump.org

From: Suzuki K. Poulose <suzuki@in.ibm.com>

Handle the RAM Disks in uImage format

Signed-off-by: Suzuki K. Poulose <suzuki@in.ibm.com>
---
 kexec/arch/ppc/kexec-uImage-ppc.c |   22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/kexec/arch/ppc/kexec-uImage-ppc.c b/kexec/arch/ppc/kexec-uImage-ppc.c
index eaea3c1..58935c0 100644
--- a/kexec/arch/ppc/kexec-uImage-ppc.c
+++ b/kexec/arch/ppc/kexec-uImage-ppc.c
@@ -46,6 +46,26 @@ void uImage_ppc_usage(void)
 	);
 }
 
+char* slurp_ramdisk_ppc(const char *filename, off_t *r_size)
+{
+	struct Image_info img;
+	off_t size;
+	const unsigned char *buf = 
+			(const unsigned char *)slurp_file(filename, &size);
+
+	/* Check if this is a uImage RAMDisk */
+	if (buf != (void*)0 &&
+		uImage_probe(buf, size, IH_ARCH_PPC) == IH_TYPE_RAMDISK) {
+		if (uImage_load(buf, size, &img) != 0)
+			die ("uImage: Reading %ld bytes from %s failed\n", size, filename);
+		buf = img.buf;
+		size = img.len;
+	}
+
+	*r_size = size;
+	return buf;
+}
+	
 int uImage_ppc_probe(const char *buf, off_t len)
 {
 	int type;
@@ -196,7 +216,7 @@ static int ppc_load_bare_bits(int argc, char **argv, const char *buf,
 	blob_buf = fixup_dtb_init(info, blob_buf, &blob_size, load_addr, &dtb_addr);
 
 	if (ramdisk) {
-		seg_buf = slurp_file(ramdisk, &seg_size);
+		seg_buf = slurp_ramdisk_ppc(ramdisk, &seg_size);
 		/* Load ramdisk at top of memory */
 		hole_addr = add_buffer(info, seg_buf, seg_size, seg_size,
 				0, dtb_addr + blob_size, max_addr, -1);


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
