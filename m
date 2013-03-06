Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e28smtp07.in.ibm.com ([122.248.162.7])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UD9tF-0006dn-QA
 for kexec@lists.infradead.org; Wed, 06 Mar 2013 08:39:59 +0000
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <suzuki@in.ibm.com>;
 Wed, 6 Mar 2013 14:06:35 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id D79453940058
 for <kexec@lists.infradead.org>; Wed,  6 Mar 2013 14:09:48 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r268dh8q37421104
 for <kexec@lists.infradead.org>; Wed, 6 Mar 2013 14:09:43 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r268dm58004872
 for <kexec@lists.infradead.org>; Wed, 6 Mar 2013 19:39:48 +1100
Subject: [PATCH 2/4] kexec/uImage: Fix the payload length in uImage_load
From: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Date: Wed, 06 Mar 2013 14:09:47 +0530
Message-ID: <20130306083838.18627.97448.stgit@suzukikp.in.ibm.com>
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

For payloads without any compression, the image->len
is set to the length of the entire uImage which includes
the uImage header. This should be filled in from
ih_size field of the uImage header.

This can cause a buffer overflow, leading the sha256_process
to overrun the initrd buffer. Also, prevents a vulnerability
where the image has been appended with additional data. The
crc check is performed only when compiled with zlib.

TODO: Implement CRC check if ZLIB is not compiled in.

Reported-by: Nathan Miller <nathanm2@us.ibm.com>

Signed-off-by: Suzuki K. Poulose <suzuki@in.ibm.com>
---
 kexec/kexec-uImage.c |   15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/kexec/kexec-uImage.c b/kexec/kexec-uImage.c
index 3799a3b..9e275b2 100644
--- a/kexec/kexec-uImage.c
+++ b/kexec/kexec-uImage.c
@@ -208,14 +208,25 @@ int uImage_load(const unsigned char *buf, off_t len, struct Image_info *image)
 {
 	const struct image_header *header = (const struct image_header *)buf;
 	const unsigned char *img_buf = buf + sizeof(struct image_header);
-	off_t img_len = len - sizeof(struct image_header);
+	off_t img_len = header->ih_size;
+
+	/*
+	 * Prevent loading a modified image.
+	 * CRC check is perfomed only when zlib is compiled
+	 * in. This check will help us to detect
+	 * size related vulnerabilities. 	
+	 */
+ 	if (img_len != (len - sizeof(struct image_header))) {
+		printf("Image size doesn't match the header\n");
+		return -1;
+	}
 
 	image->base = cpu_to_be32(header->ih_load);
 	image->ep = cpu_to_be32(header->ih_ep);
 	switch (header->ih_comp) {
 	case IH_COMP_NONE:
 		image->buf = img_buf;
-		image->len = len;
+		image->len = img_len;
 		return 0;
 		break;
 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
