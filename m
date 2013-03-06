Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e28smtp09.in.ibm.com ([122.248.162.9])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UD9ud-00076C-CG
 for kexec@lists.infradead.org; Wed, 06 Mar 2013 08:41:24 +0000
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <suzuki@in.ibm.com>;
 Wed, 6 Mar 2013 14:09:09 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 683DD394002D
 for <kexec@lists.infradead.org>; Wed,  6 Mar 2013 14:11:16 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r268fC3m25297128
 for <kexec@lists.infradead.org>; Wed, 6 Mar 2013 14:11:12 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r268fBYo011979
 for <kexec@lists.infradead.org>; Wed, 6 Mar 2013 19:41:14 +1100
Subject: [PATCH 3/4] kexec/uImage: Recognize uImage RAM Disks
From: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Date: Wed, 06 Mar 2013 14:10:33 +0530
Message-ID: <20130306083953.18627.97020.stgit@suzukikp.in.ibm.com>
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

Add IH_TYPE_RAMDISK as a recognized image type.

uImage_load shouldn't decompress the RAMDISK type images, since
uboot doesn't do it.

Signed-off-by: Suzuki K. Poulose <suzuki@in.ibm.com>
---
 include/kexec-uImage.h |    1 +
 kexec/kexec-uImage.c   |   19 ++++++++++++++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/include/kexec-uImage.h b/include/kexec-uImage.h
index 266ca73..4725157 100644
--- a/include/kexec-uImage.h
+++ b/include/kexec-uImage.h
@@ -10,5 +10,6 @@ struct Image_info {
 
 int uImage_probe(const unsigned char *buf, off_t len, unsigned int arch);
 int uImage_probe_kernel(const unsigned char *buf, off_t len, unsigned int arch);
+int uImage_probe_ramdisk(const unsigned char *buf, off_t len, unsigned int arch);
 int uImage_load(const unsigned char *buf, off_t len, struct Image_info *info);
 #endif
diff --git a/kexec/kexec-uImage.c b/kexec/kexec-uImage.c
index 9e275b2..1ad02f4 100644
--- a/kexec/kexec-uImage.c
+++ b/kexec/kexec-uImage.c
@@ -47,6 +47,8 @@ int uImage_probe(const unsigned char *buf, off_t len, unsigned int arch)
 	case IH_TYPE_KERNEL:
 	case IH_TYPE_KERNEL_NOLOAD:
 		break;
+	case IH_TYPE_RAMDISK:
+		break;
 	default:
 		printf("uImage type %d unsupported\n", header.ih_type);
 		return -1;
@@ -99,6 +101,12 @@ int uImage_probe_kernel(const unsigned char *buf, off_t len, unsigned int arch)
 			0 : -1;
 }
 
+int uImage_probe_ramdisk(const unsigned char *buf, off_t len, unsigned int arch)
+{
+	int type = uImage_probe(buf, len, arch);
+	return (type == IH_TYPE_RAMDISK) ? 0 : -1;
+}
+
 #ifdef HAVE_LIBZ
 /* gzip flag byte */
 #define ASCII_FLAG	0x01 /* bit 0 set: file probably ascii text */
@@ -231,7 +239,16 @@ int uImage_load(const unsigned char *buf, off_t len, struct Image_info *image)
 		break;
 
 	case IH_COMP_GZIP:
-		return uImage_gz_load(img_buf, img_len, image);
+		/*
+		 * uboot doesn't decompress the RAMDISK images.
+		 * Comply to the uboot behaviour.
+		 */
+		if (header->ih_type == IH_TYPE_RAMDISK) {
+			image->buf = img_buf;
+			image->len = img_len;
+			return 0;
+		} else
+			return uImage_gz_load(img_buf, img_len, image);
 		break;
 
 	default:


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
