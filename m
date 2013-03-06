Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e28smtp09.in.ibm.com ([122.248.162.9])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UD9s4-0006Pi-QV
 for kexec@lists.infradead.org; Wed, 06 Mar 2013 08:38:46 +0000
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <suzuki@in.ibm.com>;
 Wed, 6 Mar 2013 14:06:30 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id CD4FF3940058
 for <kexec@lists.infradead.org>; Wed,  6 Mar 2013 14:08:37 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r268cXjS29950012
 for <kexec@lists.infradead.org>; Wed, 6 Mar 2013 14:08:33 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r268cXJW031399
 for <kexec@lists.infradead.org>; Wed, 6 Mar 2013 19:38:34 +1100
Subject: [PATCH 1/4] kexec/uImage: Introduce uImage_probe_kernel
From: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Date: Wed, 06 Mar 2013 14:08:33 +0530
Message-ID: <20130306083741.18627.46603.stgit@suzukikp.in.ibm.com>
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

uImage supports different types of payloads, including kernel,
ramdisks etc. uImage_probe() as of now checks whether the supplied
payload is of type KERNEL ( i.e, IH_TYPE_KERNEL or IH_TYPE_KERNEL_NOLOAD ).

Change this behaviour to return the image type, if it is one of the supported
payloads. This change is in prepartion to support ramdisks in uImage format.

Introduce a uImage_probe_kernel() which can be used by the archs to check if
the supplied payload is one of the KERNEL types.

Signed-off-by: Suzuki K. Poulose <suzuki@in.ibm.com>
---
 include/kexec-uImage.h            |    1 +
 kexec/arch/arm/kexec-uImage-arm.c |    2 +-
 kexec/arch/ppc/kexec-uImage-ppc.c |    2 +-
 kexec/arch/sh/kexec-uImage-sh.c   |    2 +-
 kexec/kexec-uImage.c              |   14 +++++++++++++-
 5 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/include/kexec-uImage.h b/include/kexec-uImage.h
index 8c7707d..266ca73 100644
--- a/include/kexec-uImage.h
+++ b/include/kexec-uImage.h
@@ -9,5 +9,6 @@ struct Image_info {
 };
 
 int uImage_probe(const unsigned char *buf, off_t len, unsigned int arch);
+int uImage_probe_kernel(const unsigned char *buf, off_t len, unsigned int arch);
 int uImage_load(const unsigned char *buf, off_t len, struct Image_info *info);
 #endif
diff --git a/kexec/arch/arm/kexec-uImage-arm.c b/kexec/arch/arm/kexec-uImage-arm.c
index 4875185..03c2f4d 100644
--- a/kexec/arch/arm/kexec-uImage-arm.c
+++ b/kexec/arch/arm/kexec-uImage-arm.c
@@ -11,7 +11,7 @@
 
 int uImage_arm_probe(const char *buf, off_t len)
 {
-	return uImage_probe(buf, len, IH_ARCH_ARM);
+	return uImage_probe_kernel(buf, len, IH_ARCH_ARM);
 }
 
 int uImage_arm_load(int argc, char **argv, const char *buf, off_t len,
diff --git a/kexec/arch/ppc/kexec-uImage-ppc.c b/kexec/arch/ppc/kexec-uImage-ppc.c
index e55bf94..ef9adc4 100644
--- a/kexec/arch/ppc/kexec-uImage-ppc.c
+++ b/kexec/arch/ppc/kexec-uImage-ppc.c
@@ -48,7 +48,7 @@ void uImage_ppc_usage(void)
 
 int uImage_ppc_probe(const char *buf, off_t len)
 {
-	return uImage_probe(buf, len, IH_ARCH_PPC);
+	return uImage_probe_kernel(buf, len, IH_ARCH_PPC);
 }
 
 static int ppc_load_bare_bits(int argc, char **argv, const char *buf,
diff --git a/kexec/arch/sh/kexec-uImage-sh.c b/kexec/arch/sh/kexec-uImage-sh.c
index e983165..130f12c 100644
--- a/kexec/arch/sh/kexec-uImage-sh.c
+++ b/kexec/arch/sh/kexec-uImage-sh.c
@@ -13,7 +13,7 @@
 
 int uImage_sh_probe(const char *buf, off_t len)
 {
-	return uImage_probe(buf, len, IH_ARCH_SH);
+	return uImage_probe_kernel(buf, len, IH_ARCH_SH);
 }
 
 int uImage_sh_load(int argc, char **argv, const char *buf, off_t len,
diff --git a/kexec/kexec-uImage.c b/kexec/kexec-uImage.c
index 3bc85c5..3799a3b 100644
--- a/kexec/kexec-uImage.c
+++ b/kexec/kexec-uImage.c
@@ -16,6 +16,10 @@
  * Basic uImage loader. Not rocket science.
  */
 
+/*
+ * Returns the image type if everything goes well. This would
+ * allow the user to decide if the image is of their interest.
+ */
 int uImage_probe(const unsigned char *buf, off_t len, unsigned int arch)
 {
 	struct image_header header;
@@ -84,7 +88,15 @@ int uImage_probe(const unsigned char *buf, off_t len, unsigned int arch)
 		return -1;
 	}
 #endif
-	return 0;
+	return (int)header.ih_type;
+}
+
+int uImage_probe_kernel(const unsigned char *buf, off_t len, unsigned int arch)
+{
+	int type = uImage_probe(buf, len, arch);
+
+	return (type == IH_TYPE_KERNEL || type == IH_TYPE_KERNEL_NOLOAD) ? 
+			0 : -1;
 }
 
 #ifdef HAVE_LIBZ


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
