Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from www.linutronix.de ([62.245.132.108] helo=Galois.linutronix.de)
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TvWfS-0006uT-2U
 for kexec@lists.infradead.org; Wed, 16 Jan 2013 17:20:51 +0000
Date: Wed, 16 Jan 2013 18:20:36 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 1/3] kexec/uImage: Return the image type for uImage_probe
Message-ID: <20130116172036.GA20369@linutronix.de>
References: <20130111063547.11490.28174.stgit@suzukikp.in.ibm.com>
 <20130111064131.11490.22173.stgit@suzukikp.in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20130111064131.11490.22173.stgit@suzukikp.in.ibm.com>
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
To: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Cc: mat@brain-dump.org, horms@verge.net.au, kexec@lists.infradead.org, lethal@linux-sh.org

* Suzuki K. Poulose | 2013-01-11 12:11:36 [+0530]:

>From: Suzuki K. Poulose <suzuki@in.ibm.com>
>
>uImage supports different types of payloads, including kernel,
>ramdisks etc. uImage_probe() as of now checks whether the supplied
>payload is of type KERNEL ( i.e, IH_TYPE_KERNEL or IH_TYPE_KERNEL_NOLOAD ).
>
>Change this behaviour to return the image type, if it is one of the supported
>payloads. This change is in prepartion to support ramdisks in uImage format.
>
>Also, I have changed the code to check for the OS type only for the kernel images.
>
>Is this check really needed ? We shouldn't bother what OS is being loaded. Isn't it ?

We should bother because mostly linux is supported. Other operating
systems like NetBSD might have other ABI for the enter point or some
special requirements. The entry ABI for linux comapared to WindowsCE is
different for ARM just to name one example.

>This change would allow the user to decide if the image is of their interest.
>
>Signed-off-by: Suzuki K. Poulose <suzuki@in.ibm.com>
>---
> kexec/arch/arm/kexec-uImage-arm.c |    8 +++++++-
> kexec/arch/ppc/kexec-uImage-ppc.c |    8 +++++++-
> kexec/arch/sh/kexec-uImage-sh.c   |    9 ++++++++-
> kexec/kexec-uImage.c              |   16 ++++++++++------
> 4 files changed, 32 insertions(+), 9 deletions(-)
>
>diff --git a/kexec/arch/arm/kexec-uImage-arm.c b/kexec/arch/arm/kexec-uImage-arm.c
>index 4875185..dc1bcb8 100644
>--- a/kexec/arch/arm/kexec-uImage-arm.c
>+++ b/kexec/arch/arm/kexec-uImage-arm.c
>@@ -11,7 +11,13 @@
> 
> int uImage_arm_probe(const char *buf, off_t len)
> {
>-	return uImage_probe(buf, len, IH_ARCH_ARM);
>+	int type;
>+	int rc = -1;
>+
>+	type = uImage_probe(buf, len, IH_ARCH_ARM);
>+	if (type == IH_TYPE_KERNEL || type == IH_TYPE_KERNEL_NOLOAD)
>+		rc = 0;
>+	return rc;
> }
> 
> int uImage_arm_load(int argc, char **argv, const char *buf, off_t len,
>diff --git a/kexec/arch/ppc/kexec-uImage-ppc.c b/kexec/arch/ppc/kexec-uImage-ppc.c
>index e55bf94..eaea3c1 100644
>--- a/kexec/arch/ppc/kexec-uImage-ppc.c
>+++ b/kexec/arch/ppc/kexec-uImage-ppc.c
>@@ -48,7 +48,13 @@ void uImage_ppc_usage(void)
> 
> int uImage_ppc_probe(const char *buf, off_t len)
> {
>-	return uImage_probe(buf, len, IH_ARCH_PPC);
>+	int type;
>+	int rc = -1;
>+
>+	type = uImage_probe(buf, len, IH_ARCH_PPC);
>+	if (type == IH_TYPE_KERNEL || type == IH_TYPE_KERNEL_NOLOAD)
>+		rc = 0;
>+	return rc;
> }
> 
> static int ppc_load_bare_bits(int argc, char **argv, const char *buf,
>diff --git a/kexec/arch/sh/kexec-uImage-sh.c b/kexec/arch/sh/kexec-uImage-sh.c
>index e983165..54bb073 100644
>--- a/kexec/arch/sh/kexec-uImage-sh.c
>+++ b/kexec/arch/sh/kexec-uImage-sh.c
>@@ -13,7 +13,14 @@
> 
> int uImage_sh_probe(const char *buf, off_t len)
> {
>-	return uImage_probe(buf, len, IH_ARCH_SH);
>+	int type;
>+	int rc = -1;
>+
>+	type = uImage_probe(buf, len, IH_ARCH_SH);
>+	if (type == IH_TYPE_KERNEL || type == IH_TYPE_KERNEL_NOLOAD)
>+		rc = uImage_probe(buf, len, IH_ARCH_SH);

This looks like a typo compared to ppc/arm above. If so you could create
uImage_probe_kernel() which has the type == check.

>+
>+	return rc;
> }
> 
> int uImage_sh_load(int argc, char **argv, const char *buf, off_t len,
>diff --git a/kexec/kexec-uImage.c b/kexec/kexec-uImage.c
>index 3bc85c5..dcbd635 100644
>--- a/kexec/kexec-uImage.c
>+++ b/kexec/kexec-uImage.c
>@@ -16,6 +16,10 @@
>  * Basic uImage loader. Not rocket science.
>  */
> 
>+/*
>+ * Returns the image type if everything goes well. This would
>+ * allow the user to decide if the image is of their interest.
>+ */
> int uImage_probe(const unsigned char *buf, off_t len, unsigned int arch)
> {
> 	struct image_header header;
>@@ -42,17 +46,17 @@ int uImage_probe(const unsigned char *buf, off_t len, unsigned int arch)
> 	switch (header.ih_type) {
> 	case IH_TYPE_KERNEL:
> 	case IH_TYPE_KERNEL_NOLOAD:
>+		/* XXX: Should we really check this ? */
Yes.
>+		if (header.ih_os != IH_OS_LINUX) {
>+			printf("uImage os %d unsupported\n", header.ih_os);
>+			return -1;
>+		}

Why did move this piece. Is it because ramdisk does not have an OS
selected?

> 		break;
> 	default:
> 		printf("uImage type %d unsupported\n", header.ih_type);
> 		return -1;
> 	}
> 
>-	if (header.ih_os != IH_OS_LINUX) {
>-		printf("uImage os %d unsupported\n", header.ih_os);
>-		return -1;
>-	}
>-
> 	if (header.ih_arch != arch) {
> 		printf("uImage arch %d unsupported\n", header.ih_arch);
> 		return -1;
>@@ -84,7 +88,7 @@ int uImage_probe(const unsigned char *buf, off_t len, unsigned int arch)
> 		return -1;
> 	}
> #endif
>-	return 0;
>+	return (int)header.ih_type;

Why do you return type here?

> }
> 
> #ifdef HAVE_LIBZ
>

Sebastian

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
