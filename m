Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e28smtp07.in.ibm.com ([122.248.162.7])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UD9uy-0007AY-8E
 for kexec@lists.infradead.org; Wed, 06 Mar 2013 08:41:45 +0000
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <suzuki@in.ibm.com>;
 Wed, 6 Mar 2013 14:08:24 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id C7574125804E
 for <kexec@lists.infradead.org>; Wed,  6 Mar 2013 14:12:36 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r268fa2d21692594
 for <kexec@lists.infradead.org>; Wed, 6 Mar 2013 14:11:36 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r268fbl8014577
 for <kexec@lists.infradead.org>; Wed, 6 Mar 2013 19:41:38 +1100
Subject: [PATCH 4/4] ppc/uImage: Add support for RAM Disks
From: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Date: Wed, 06 Mar 2013 14:11:37 +0530
Message-ID: <20130306084111.18627.44615.stgit@suzukikp.in.ibm.com>
In-Reply-To: <20130306083331.18627.82812.stgit@suzukikp.in.ibm.com>
References: <20130306083331.18627.82812.stgit@suzukikp.in.ibm.com>
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
To: horms@verge.net.au
Cc: msm@freescale.com, bigeasy@linutronix.de, lethal@linux-sh.org, kexec@lists.infradead.org

From: Suzuki K. Poulose <suzuki@in.ibm.com>

Handle the RAM Disks in uImage format

Signed-off-by: Suzuki K. Poulose <suzuki@in.ibm.com>
---
 kexec/arch/ppc/kexec-uImage-ppc.c |   27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/kexec/arch/ppc/kexec-uImage-ppc.c b/kexec/arch/ppc/kexec-uImage-ppc.c
index ef9adc4..e0bc7bb 100644
--- a/kexec/arch/ppc/kexec-uImage-ppc.c
+++ b/kexec/arch/ppc/kexec-uImage-ppc.c
@@ -46,6 +46,31 @@ void uImage_ppc_usage(void)
 	);
 }
 
+/*
+ * Load the ramdisk into buffer.
+ *  If the supplied image is in uImage format use
+ *  uImage_load() to read the payload from the image.
+ */
+char *slurp_ramdisk_ppc(const char *filename, off_t *r_size)
+{
+	struct Image_info img;
+	off_t size;
+	const unsigned char *buf = slurp_file(filename, &size);
+
+	/* Check if this is a uImage RAMDisk */
+	if (buf &&
+	    uImage_probe_ramdisk(buf, size, IH_ARCH_PPC) == 0) {
+		if (uImage_load(buf, size, &img) != 0)
+			die("uImage: Reading %ld bytes from %s failed\n",
+				size, filename);
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
 	return uImage_probe_kernel(buf, len, IH_ARCH_PPC);
@@ -190,7 +215,7 @@ static int ppc_load_bare_bits(int argc, char **argv, const char *buf,
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
