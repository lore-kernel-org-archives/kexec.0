Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp2130.oracle.com ([156.151.31.86])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj8Db-0000JI-BV
 for kexec@lists.infradead.org; Mon, 14 Jan 2019 19:48:39 +0000
From: Eric DeVolder <eric.devolder@oracle.com>
Subject: [RFC v1 6/8] kexec: support files for PECOFF Authenticode signature
 verification
Date: Mon, 14 Jan 2019 13:48:03 -0600
Message-Id: <1547495285-28907-7-git-send-email-eric.devolder@oracle.com>
In-Reply-To: <1547495285-28907-1-git-send-email-eric.devolder@oracle.com>
References: <1547495285-28907-1-git-send-email-eric.devolder@oracle.com>
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
To: xen-devel@lists.xen.org
Cc: daniel.kiper@oracle.com, eric.devolder@oracle.com, kexec@lists.infradead.org, boris.ostrovsky@oracle.com

This patch contains the files from the standalone utility that
are to be integrated into Xen to provide signature verification
of a PECOFF file.

- TrustedCert.h is the public root certificate for Oracle signed
  binaries. This created by taking the DER encoded file at
  http://cacerts.digicert.com/DigiCertHighAssuranceEVRootCA.crt and
  converting it into this compilable C header file.
- dlcl.h is my double linked circular list set of helper macros, and
  should be replaced with corresponding Xen list handling.
- pecoff.h is a transcription of the data structures and constants
  described in the Microsoft spec
  https://msdn.microsoft.com/en-us/library/windows/desktop/ms680547(v=vs.85).aspx.
- ped.[ch] is the PECOFF decoder/parser I wrote, and probably could
  stand to be replaced with a more mature library.
- v_openssl.c is the "glue" code that utilizes OpenSSL routines to
  perform signature verification. This file essentially contains the
  two files https://github.com/vathpela/verify/Cryptlib/Pk/[CryptPkcs7.c|CryptAuthenticode.c]
  which together provide the signature verification capability.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 xen/common/TrustedCert.h |  113 ++++
 xen/common/dlcl.h        |  323 +++++++++++
 xen/common/pecoff.h      |  283 ++++++++++
 xen/common/ped.c         |  579 ++++++++++++++++++++
 xen/common/ped.h         |  128 +++++
 xen/common/v_openssl.c   | 1348 ++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 2774 insertions(+)
 create mode 100644 xen/common/TrustedCert.h
 create mode 100755 xen/common/dlcl.h
 create mode 100644 xen/common/pecoff.h
 create mode 100644 xen/common/ped.c
 create mode 100644 xen/common/ped.h
 create mode 100644 xen/common/v_openssl.c

diff --git a/xen/common/TrustedCert.h b/xen/common/TrustedCert.h
new file mode 100644
index 0000000..5b744e4
--- /dev/null
+++ b/xen/common/TrustedCert.h
@@ -0,0 +1,113 @@
+
+uint8_t TrustedCert[] = 
+{
+0x30,  0x82,  0x03,  0xC5,  0x30,  0x82,  0x02,  0xAD,  0xA0,  
+0x03,  0x02,  0x01,  0x02,  0x02,  0x10,  0x02,  0xAC,  0x5C,  
+0x26,  0x6A,  0x0B,  0x40,  0x9B,  0x8F,  0x0B,  0x79,  0xF2,  
+0xAE,  0x46,  0x25,  0x77,  0x30,  0x0D,  0x06,  0x09,  0x2A,  
+0x86,  0x48,  0x86,  0xF7,  0x0D,  0x01,  0x01,  0x05,  0x05,  
+0x00,  0x30,  0x6C,  0x31,  0x0B,  0x30,  0x09,  0x06,  0x03,  
+0x55,  0x04,  0x06,  0x13,  0x02,  0x55,  0x53,  0x31,  0x15,  
+0x30,  0x13,  0x06,  0x03,  0x55,  0x04,  0x0A,  0x13,  0x0C,  
+0x44,  0x69,  0x67,  0x69,  0x43,  0x65,  0x72,  0x74,  0x20,  
+0x49,  0x6E,  0x63,  0x31,  0x19,  0x30,  0x17,  0x06,  0x03,  
+0x55,  0x04,  0x0B,  0x13,  0x10,  0x77,  0x77,  0x77,  0x2E,  
+0x64,  0x69,  0x67,  0x69,  0x63,  0x65,  0x72,  0x74,  0x2E,  
+0x63,  0x6F,  0x6D,  0x31,  0x2B,  0x30,  0x29,  0x06,  0x03,  
+0x55,  0x04,  0x03,  0x13,  0x22,  0x44,  0x69,  0x67,  0x69,  
+0x43,  0x65,  0x72,  0x74,  0x20,  0x48,  0x69,  0x67,  0x68,  
+0x20,  0x41,  0x73,  0x73,  0x75,  0x72,  0x61,  0x6E,  0x63,  
+0x65,  0x20,  0x45,  0x56,  0x20,  0x52,  0x6F,  0x6F,  0x74,  
+0x20,  0x43,  0x41,  0x30,  0x1E,  0x17,  0x0D,  0x30,  0x36,  
+0x31,  0x31,  0x31,  0x30,  0x30,  0x30,  0x30,  0x30,  0x30,  
+0x30,  0x5A,  0x17,  0x0D,  0x33,  0x31,  0x31,  0x31,  0x31,  
+0x30,  0x30,  0x30,  0x30,  0x30,  0x30,  0x30,  0x5A,  0x30,  
+0x6C,  0x31,  0x0B,  0x30,  0x09,  0x06,  0x03,  0x55,  0x04,  
+0x06,  0x13,  0x02,  0x55,  0x53,  0x31,  0x15,  0x30,  0x13,  
+0x06,  0x03,  0x55,  0x04,  0x0A,  0x13,  0x0C,  0x44,  0x69,  
+0x67,  0x69,  0x43,  0x65,  0x72,  0x74,  0x20,  0x49,  0x6E,  
+0x63,  0x31,  0x19,  0x30,  0x17,  0x06,  0x03,  0x55,  0x04,  
+0x0B,  0x13,  0x10,  0x77,  0x77,  0x77,  0x2E,  0x64,  0x69,  
+0x67,  0x69,  0x63,  0x65,  0x72,  0x74,  0x2E,  0x63,  0x6F,  
+0x6D,  0x31,  0x2B,  0x30,  0x29,  0x06,  0x03,  0x55,  0x04,  
+0x03,  0x13,  0x22,  0x44,  0x69,  0x67,  0x69,  0x43,  0x65,  
+0x72,  0x74,  0x20,  0x48,  0x69,  0x67,  0x68,  0x20,  0x41,  
+0x73,  0x73,  0x75,  0x72,  0x61,  0x6E,  0x63,  0x65,  0x20,  
+0x45,  0x56,  0x20,  0x52,  0x6F,  0x6F,  0x74,  0x20,  0x43,  
+0x41,  0x30,  0x82,  0x01,  0x22,  0x30,  0x0D,  0x06,  0x09,  
+0x2A,  0x86,  0x48,  0x86,  0xF7,  0x0D,  0x01,  0x01,  0x01,  
+0x05,  0x00,  0x03,  0x82,  0x01,  0x0F,  0x00,  0x30,  0x82,  
+0x01,  0x0A,  0x02,  0x82,  0x01,  0x01,  0x00,  0xC6,  0xCC,  
+0xE5,  0x73,  0xE6,  0xFB,  0xD4,  0xBB,  0xE5,  0x2D,  0x2D,  
+0x32,  0xA6,  0xDF,  0xE5,  0x81,  0x3F,  0xC9,  0xCD,  0x25,  
+0x49,  0xB6,  0x71,  0x2A,  0xC3,  0xD5,  0x94,  0x34,  0x67,  
+0xA2,  0x0A,  0x1C,  0xB0,  0x5F,  0x69,  0xA6,  0x40,  0xB1,  
+0xC4,  0xB7,  0xB2,  0x8F,  0xD0,  0x98,  0xA4,  0xA9,  0x41,  
+0x59,  0x3A,  0xD3,  0xDC,  0x94,  0xD6,  0x3C,  0xDB,  0x74,  
+0x38,  0xA4,  0x4A,  0xCC,  0x4D,  0x25,  0x82,  0xF7,  0x4A,  
+0xA5,  0x53,  0x12,  0x38,  0xEE,  0xF3,  0x49,  0x6D,  0x71,  
+0x91,  0x7E,  0x63,  0xB6,  0xAB,  0xA6,  0x5F,  0xC3,  0xA4,  
+0x84,  0xF8,  0x4F,  0x62,  0x51,  0xBE,  0xF8,  0xC5,  0xEC,  
+0xDB,  0x38,  0x92,  0xE3,  0x06,  0xE5,  0x08,  0x91,  0x0C,  
+0xC4,  0x28,  0x41,  0x55,  0xFB,  0xCB,  0x5A,  0x89,  0x15,  
+0x7E,  0x71,  0xE8,  0x35,  0xBF,  0x4D,  0x72,  0x09,  0x3D,  
+0xBE,  0x3A,  0x38,  0x50,  0x5B,  0x77,  0x31,  0x1B,  0x8D,  
+0xB3,  0xC7,  0x24,  0x45,  0x9A,  0xA7,  0xAC,  0x6D,  0x00,  
+0x14,  0x5A,  0x04,  0xB7,  0xBA,  0x13,  0xEB,  0x51,  0x0A,  
+0x98,  0x41,  0x41,  0x22,  0x4E,  0x65,  0x61,  0x87,  0x81,  
+0x41,  0x50,  0xA6,  0x79,  0x5C,  0x89,  0xDE,  0x19,  0x4A,  
+0x57,  0xD5,  0x2E,  0xE6,  0x5D,  0x1C,  0x53,  0x2C,  0x7E,  
+0x98,  0xCD,  0x1A,  0x06,  0x16,  0xA4,  0x68,  0x73,  0xD0,  
+0x34,  0x04,  0x13,  0x5C,  0xA1,  0x71,  0xD3,  0x5A,  0x7C,  
+0x55,  0xDB,  0x5E,  0x64,  0xE1,  0x37,  0x87,  0x30,  0x56,  
+0x04,  0xE5,  0x11,  0xB4,  0x29,  0x80,  0x12,  0xF1,  0x79,  
+0x39,  0x88,  0xA2,  0x02,  0x11,  0x7C,  0x27,  0x66,  0xB7,  
+0x88,  0xB7,  0x78,  0xF2,  0xCA,  0x0A,  0xA8,  0x38,  0xAB,  
+0x0A,  0x64,  0xC2,  0xBF,  0x66,  0x5D,  0x95,  0x84,  0xC1,  
+0xA1,  0x25,  0x1E,  0x87,  0x5D,  0x1A,  0x50,  0x0B,  0x20,  
+0x12,  0xCC,  0x41,  0xBB,  0x6E,  0x0B,  0x51,  0x38,  0xB8,  
+0x4B,  0xCB,  0x02,  0x03,  0x01,  0x00,  0x01,  0xA3,  0x63,  
+0x30,  0x61,  0x30,  0x0E,  0x06,  0x03,  0x55,  0x1D,  0x0F,  
+0x01,  0x01,  0xFF,  0x04,  0x04,  0x03,  0x02,  0x01,  0x86,  
+0x30,  0x0F,  0x06,  0x03,  0x55,  0x1D,  0x13,  0x01,  0x01,  
+0xFF,  0x04,  0x05,  0x30,  0x03,  0x01,  0x01,  0xFF,  0x30,  
+0x1D,  0x06,  0x03,  0x55,  0x1D,  0x0E,  0x04,  0x16,  0x04,  
+0x14,  0xB1,  0x3E,  0xC3,  0x69,  0x03,  0xF8,  0xBF,  0x47,  
+0x01,  0xD4,  0x98,  0x26,  0x1A,  0x08,  0x02,  0xEF,  0x63,  
+0x64,  0x2B,  0xC3,  0x30,  0x1F,  0x06,  0x03,  0x55,  0x1D,  
+0x23,  0x04,  0x18,  0x30,  0x16,  0x80,  0x14,  0xB1,  0x3E,  
+0xC3,  0x69,  0x03,  0xF8,  0xBF,  0x47,  0x01,  0xD4,  0x98,  
+0x26,  0x1A,  0x08,  0x02,  0xEF,  0x63,  0x64,  0x2B,  0xC3,  
+0x30,  0x0D,  0x06,  0x09,  0x2A,  0x86,  0x48,  0x86,  0xF7,  
+0x0D,  0x01,  0x01,  0x05,  0x05,  0x00,  0x03,  0x82,  0x01,  
+0x01,  0x00,  0x1C,  0x1A,  0x06,  0x97,  0xDC,  0xD7,  0x9C,  
+0x9F,  0x3C,  0x88,  0x66,  0x06,  0x08,  0x57,  0x21,  0xDB,  
+0x21,  0x47,  0xF8,  0x2A,  0x67,  0xAA,  0xBF,  0x18,  0x32,  
+0x76,  0x40,  0x10,  0x57,  0xC1,  0x8A,  0xF3,  0x7A,  0xD9,  
+0x11,  0x65,  0x8E,  0x35,  0xFA,  0x9E,  0xFC,  0x45,  0xB5,  
+0x9E,  0xD9,  0x4C,  0x31,  0x4B,  0xB8,  0x91,  0xE8,  0x43,  
+0x2C,  0x8E,  0xB3,  0x78,  0xCE,  0xDB,  0xE3,  0x53,  0x79,  
+0x71,  0xD6,  0xE5,  0x21,  0x94,  0x01,  0xDA,  0x55,  0x87,  
+0x9A,  0x24,  0x64,  0xF6,  0x8A,  0x66,  0xCC,  0xDE,  0x9C,  
+0x37,  0xCD,  0xA8,  0x34,  0xB1,  0x69,  0x9B,  0x23,  0xC8,  
+0x9E,  0x78,  0x22,  0x2B,  0x70,  0x43,  0xE3,  0x55,  0x47,  
+0x31,  0x61,  0x19,  0xEF,  0x58,  0xC5,  0x85,  0x2F,  0x4E,  
+0x30,  0xF6,  0xA0,  0x31,  0x16,  0x23,  0xC8,  0xE7,  0xE2,  
+0x65,  0x16,  0x33,  0xCB,  0xBF,  0x1A,  0x1B,  0xA0,  0x3D,  
+0xF8,  0xCA,  0x5E,  0x8B,  0x31,  0x8B,  0x60,  0x08,  0x89,  
+0x2D,  0x0C,  0x06,  0x5C,  0x52,  0xB7,  0xC4,  0xF9,  0x0A,  
+0x98,  0xD1,  0x15,  0x5F,  0x9F,  0x12,  0xBE,  0x7C,  0x36,  
+0x63,  0x38,  0xBD,  0x44,  0xA4,  0x7F,  0xE4,  0x26,  0x2B,  
+0x0A,  0xC4,  0x97,  0x69,  0x0D,  0xE9,  0x8C,  0xE2,  0xC0,  
+0x10,  0x57,  0xB8,  0xC8,  0x76,  0x12,  0x91,  0x55,  0xF2,  
+0x48,  0x69,  0xD8,  0xBC,  0x2A,  0x02,  0x5B,  0x0F,  0x44,  
+0xD4,  0x20,  0x31,  0xDB,  0xF4,  0xBA,  0x70,  0x26,  0x5D,  
+0x90,  0x60,  0x9E,  0xBC,  0x4B,  0x17,  0x09,  0x2F,  0xB4,  
+0xCB,  0x1E,  0x43,  0x68,  0xC9,  0x07,  0x27,  0xC1,  0xD2,  
+0x5C,  0xF7,  0xEA,  0x21,  0xB9,  0x68,  0x12,  0x9C,  0x3C,  
+0x9C,  0xBF,  0x9E,  0xFC,  0x80,  0x5C,  0x9B,  0x63,  0xCD,  
+0xEC,  0x47,  0xAA,  0x25,  0x27,  0x67,  0xA0,  0x37,  0xF3,  
+0x00,  0x82,  0x7D,  0x54,  0xD7,  0xA9,  0xF8,  0xE9,  0x2E,  
+0x13,  0xA3,  0x77,  0xE8,  0x1F,  0x4A,  
+};
+
diff --git a/xen/common/dlcl.h b/xen/common/dlcl.h
new file mode 100755
index 0000000..709e53e
--- /dev/null
+++ b/xen/common/dlcl.h
@@ -0,0 +1,323 @@
+/*
+ *  Linked list macros
+ *
+ * Copyright 2004 Eric DeVolder
+ *
+ */
+
+#ifndef _DSS_SRC_INCLUDE_DLCL_H
+#define _DSS_SRC_INCLUDE_DLCL_H
+
+/********************************************************************/
+/*
+ * This macro appends ELEMENT to the end of a list
+ */
+#define DLCL_APPEND(TYPE, QUEUE, ELEMENT)	\
+	DLCL_APPEND_NP(TYPE, QUEUE, ELEMENT, next, prev)
+
+/********************************************************************/
+/*
+ * This macro removes ELEMENT from the list.
+ */
+#define DLCL_REMOVE(TYPE, QUEUE, ELEMENT)	\
+	DLCL_REMOVE_NP(TYPE, QUEUE, ELEMENT, next, prev)
+
+/********************************************************************/
+/*
+ * This macro extracts ELEMENT from the list. It doesn't
+ * update the list head.
+ */
+#define DLCL_EXTRACT(TYPE, ELEMENT)	\
+	DLCL_EXTRACT_NP(TYPE, ELEMENT, next, prev)
+
+/********************************************************************/
+/*
+ * This macro inserts ELEMENT into the list before NELEMENT
+ */
+#define DLCL_INSERT_BEFORE(TYPE, ELEMENT, NELEMENT)	\
+	DLCL_INSERT_BEFORE_NP(TYPE, ELEMENT, NELEMENT, next, prev)
+
+/********************************************************************/
+/*
+ * This macro inserts ELEMENT into the list after PELEMENT
+ */
+#define DLCL_INSERT_AFTER(TYPE, ELEMENT, PELEMENT)	\
+	DLCL_INSERT_AFTER_NP(TYPE, ELEMENT, PELEMENT, next, prev)
+
+/********************************************************************/
+/*
+ * This macro inserts LIST into the list before element NELEMENT.
+ */
+#define DLCL_INSERT_LIST_BEFORE(TYPE, ELEMENT, NELEMENT)	\
+	DLCL_INSERT_LIST_BEFORE_NP(TYPE, LIST, NLIST, next, prev)
+
+/********************************************************************/
+/*
+ * This macro inserts LIST into the list after element PELEMENT
+ */
+#define DLCL_INSERT_LIST_AFTER(TYPE, ELEMENT, PELEMENT)	\
+	DLCL_INSERT_LIST_AFTER_NP(TYPE, LIST, PLIST, next, prev)
+
+/********************************************************************/
+/********************************************************************/
+/********************************************************************/
+/********************************************************************/
+/*
+ * This macro appends ELEMENT to [the end of] a list
+ */
+#define DLCL_APPEND_NP(TYPE, QUEUE, ELEMENT, NEXT, PREV)	\
+{										\
+	TYPE *fel, *lel;				\
+	if ((fel = QUEUE) == NULL)			\
+	{									\
+		QUEUE = ELEMENT->NEXT = ELEMENT->PREV = ELEMENT;	\
+	}									\
+	else								\
+	{									\
+		lel = fel->PREV;				\
+		lel->NEXT = ELEMENT;			\
+		ELEMENT->PREV = lel;			\
+		ELEMENT->NEXT = fel;			\
+		fel->PREV = ELEMENT;			\
+	}									\
+}
+
+/********************************************************************/
+/*
+ * This macro prepends ELEMENT to [the beginning of] a list
+ */
+#define DLCL_PREPEND_NP(TYPE, QUEUE, ELEMENT, NEXT, PREV)	\
+{										\
+	TYPE *fel, *lel;				\
+	if ((fel = QUEUE) == NULL)			\
+	{									\
+		QUEUE = ELEMENT->NEXT = ELEMENT->PREV = ELEMENT;	\
+	}									\
+	else								\
+	{									\
+		lel = fel->PREV;				\
+		lel->NEXT = ELEMENT;			\
+		ELEMENT->PREV = lel;			\
+		ELEMENT->NEXT = fel;			\
+		fel->PREV = ELEMENT;			\
+		QUEUE = ELEMENT;	    		\
+	}									\
+}
+
+/********************************************************************/
+/*
+ * This macro removes ELEMENT from the list.
+ *
+ * NOTE: This requires that ELEMENT actually be on the list!
+ */
+#define DLCL_REMOVE_NP(TYPE, QUEUE, ELEMENT, NEXT, PREV)	\
+{										\
+	TYPE *nel, *pel;				\
+	if (QUEUE != NULL)					\
+	{									\
+		nel = ELEMENT->NEXT;			\
+		pel = ELEMENT->PREV;			\
+		if (QUEUE == ELEMENT)			\
+		{								\
+			/* FIX!!!! should use (nel == pel) */	\
+            /*if (nel == pel) */    \
+			if (ELEMENT->NEXT == ELEMENT)			\
+			{							\
+				ELEMENT->NEXT = ELEMENT->PREV = NULL;		\
+				QUEUE = NULL;			\
+			}							\
+			else						\
+			{							\
+				pel->NEXT = nel;		\
+				nel->PREV = pel;		\
+				QUEUE = nel;			\
+			}							\
+		}								\
+		else							\
+		{								\
+			pel->NEXT = nel;			\
+			nel->PREV = pel;			\
+		}								\
+	}									\
+}
+
+
+/********************************************************************/
+/********************************************************************/
+/********************************************************************/
+/********************************************************************/
+
+/*
+ * The following insert and extract macros simply manipulate the
+ * element(s) provided. That is, the list head is not modified.
+ * Furthermore, it is REQUIRED that the ELEMENT be valid (ie not NULL)
+ */
+
+/*
+ * This macro extracts ELEMENT from the list. It doesn't
+ * change the list head.
+ *
+ * NOTE: This requires that the element actually be on the list!
+ */
+#define DLCL_EXTRACT_NP(TYPE, ELEMENT, NEXT, PREV)	\
+{									\
+	TYPE *nel, *pel;			\
+	nel = ELEMENT->NEXT;			\
+	pel = ELEMENT->PREV;			\
+	pel->NEXT = nel;				\
+	nel->PREV = pel;				\
+}
+
+/********************************************************************/
+/*
+ * This macro inserts ELEMENT into the list before NELEMENT.
+ */
+#define DLCL_INSERT_BEFORE_NP(TYPE, QUEUE, ELEMENT, NELEMENT, NEXT, PREV)	\
+{									\
+	TYPE *pel;					\
+	pel = NELEMENT->PREV;			\
+	pel->NEXT = ELEMENT;			\
+	ELEMENT->NEXT = NELEMENT;		\
+	NELEMENT->PREV = ELEMENT;		\
+	ELEMENT->PREV = pel;			\
+    if (QUEUE == NELEMENT)          \
+        QUEUE = ELEMENT;            \
+}
+
+/********************************************************************/
+/*
+ * This macro inserts ELEMENT into the list after PELEMENT.
+ */
+#define DLCL_INSERT_AFTER_NP(TYPE, QUEUE, ELEMENT, PELEMENT, NEXT, PREV)	\
+{									\
+    TYPE *nel;					    \
+	nel = PELEMENT->NEXT;			\
+	PELEMENT->NEXT = ELEMENT;		\
+	ELEMENT->NEXT = nel;			\
+	nel->PREV = ELEMENT;			\
+	ELEMENT->PREV = PELEMENT; 		\
+}
+
+/********************************************************************/
+/*
+ * This macro inserts ELEMENT into the list in sorted order via EXPR.
+ */
+#define DLCL_INSERT_SORTED_NP(TYPE, QUEUE, ELEMENT, EXPR, NEXT, PREV)	\
+{									                                    \
+    TYPE *cel;                                                          \
+    if ((cel = QUEUE) == NULL)                                          \
+    {                                                                   \
+        DLCL_APPEND_NP(TYPE, QUEUE, ELEMENT, NEXT, PREV); /* Start the list */ \
+    }                                                                   \
+    else                                                                \
+    while (cel != NULL)                                                 \
+    {                                                                   \
+        if (EXPR)                                                       \
+        {                                                               \
+            DLCL_INSERT_BEFORE_NP(TYPE, QUEUE, ELEMENT, cel, NEXT, PREV); /* Insert in list */ \
+            break;                                                      \
+        }                                                               \
+                                                                        \
+        if ((cel = cel->NEXT) == QUEUE)                                 \
+        {                                                               \
+            DLCL_APPEND_NP(TYPE, QUEUE, ELEMENT, NEXT, PREV); /* Insert at end of list */ \
+            cel = NULL;                                                 \
+        }                                                               \
+    }                                                                   \
+}
+
+/*
+ * This macro joins two DLCLs together, by concatenating LIST2 at the
+ * end of LIST1.
+ */
+#define DLCL_JOIN_NP(TYPE, QUEUE, LIST1, LIST2, NEXT, PREV) \
+{                                                           \
+    if (LIST1 && LIST2)                                     \
+    {                                                       \
+        TYPE *fel1, *fel2, *lel1, *lel2;                    \
+        fel1 = LIST1;                                       \
+        lel1 = fel1->PREV;                                  \
+        fel2 = LIST2;                                       \
+        lel2 = fel2->PREV;                                  \
+        fel1->PREV = lel2;                                  \
+        lel2->NEXT = fel1;                                  \
+        lel1->NEXT = fel2;                                  \
+        fel2->PREV = lel1;                                  \
+        QUEUE = LIST1;                                      \
+    }                                                       \
+    else                                                    \
+    {                                                       \
+        if (LIST1)                                          \
+            QUEUE = LIST1;                                  \
+        else                                                \
+            QUEUE = LIST2;                                  \
+    }                                                       \
+} 
+
+/*
+ * This macro splits QUEUE into two DLCLs at element ELEMENT.
+ * This requires that ELEMENT be on the QUEUE. When complete,
+ * ELEMENT points to a list (as does QUEUE).
+ */
+#define DLCL_SPLIT_NP(TYPE, QUEUE, ELEMENT, NEXT, PREV) \
+{                                                           \
+    if (QUEUE && ELEMENT)                                   \
+    {                                                       \
+        TYPE *fel1, *fel2, *lel1, *lel2;                    \
+        fel1 = QUEUE;                                       \
+        fel2 = ELEMENT;                                     \
+        lel1 = fel2->PREV;                                  \
+        lel2 = fel1->PREV;                                  \
+        fel1->PREV = lel1;                                  \
+        lel1->NEXT = fel1;                                  \
+        fel2->PREV = lel2;                                  \
+        lel2->NEXT = fel2;                                  \
+    }                                                       \
+}
+
+/********************************************************************/
+
+/*
+ * The following insert macros operate on lists, but do not modify
+ * the list head.
+ * Furthermore, it is REQUIRED that the LIST be valid (ie not NULL)
+ */
+
+/*
+ * This macro inserts LIST into the list BEFORE element NELEMENT.
+ */
+#define DLCL_INSERT_LIST_BEFORE_NP(TYPE, LIST, NELEMENT, NEXT, PREV)	\
+{									\
+	TYPE *nel, *pel, *lf, *ll;	\
+	lf = LIST; ll = lf->PREV;		\
+	nel = NELEMENT; pel = nel->PREV;\
+	ll->NEXT = nel;					\
+	nel->PREV = ll;					\
+	pel->NEXT = lf;					\
+	lf->PREV = pel;					\
+}
+
+/********************************************************************/
+/*
+ * This macro inserts LIST into the list AFTER element PELEMENT
+ */
+#define DLCL_INSERT_LIST_AFTER_NP(TYPE, LIST, PELEMENT, NEXT, PREV)	\
+{									\
+	TYPE *nel, *pel, *lf, *ll;	\
+	lf = LIST; ll = lf->PREV;		\
+	pel = PELEMENT; nel = pel->NEXT;\
+	ll->NEXT = nel;					\
+	nel->PREV = ll;					\
+	pel->NEXT = lf;					\
+	lf->PREV = pel;					\
+}
+
+/********************************************************************/
+ 
+#define DLCL_FOR_EACH(TYPE, LIST, VAR, NEXT, PREV) \
+    for (VAR = LIST; VAR; VAR = (VAR->NEXT == LIST) ? NULL : VAR->NEXT)
+
+/********************************************************************/
+
+#endif	/* _DSS_SRC_INCLUDE_DLCL_H */
+
diff --git a/xen/common/pecoff.h b/xen/common/pecoff.h
new file mode 100644
index 0000000..26d998d
--- /dev/null
+++ b/xen/common/pecoff.h
@@ -0,0 +1,283 @@
+
+// google microsoft pecoff format
+// wiki microsoft pecoff format
+// https://msdn.microsoft.com/en-us/library/windows/desktop/ms680547(v=vs.85).aspx
+// https://upload.wikimedia.org/wikipedia/commons/thumb/1/1b/Portable_Executable_32_bit_Structure_in_SVG_fixed.svg/2000px-Portable_Executable_32_bit_Structure_in_SVG_fixed.svg.png
+
+// FIX!!! Microsoft type names
+#define BYTE uint8_t
+#define WORD uint16_t
+#define DWORD uint32_t
+#define QWORD uint64_t
+
+/********************************************************************/
+
+typedef struct dos_header_s
+{
+    BYTE Signature[2];
+    BYTE header[58];
+    DWORD pe_header_offset;
+} dos_header_t;
+
+#define IMAGE_FILE_SIGNATURE_0 0x4D
+#define IMAGE_FILE_SIGNATURE_1 0x5A
+
+typedef struct coff_header_s
+{
+    DWORD Signature;
+    WORD Machine;
+    WORD NumberOfSections;
+    DWORD TimeDateStamp;
+    DWORD PointerToSymbolTable;
+    DWORD NumberOfSymbolTable;
+    WORD SizeofOptionalHeader;
+    WORD Characteristics;
+} coff_header_t;
+
+#define IMAGE_FILE_MACHINE_UNKNOWN 0x0 // The contents of this field are assumed to be applicable to any machine type
+#define IMAGE_FILE_MACHINE_AM33 0x1d3 // Matsushita AM33
+#define IMAGE_FILE_MACHINE_AMD64 0x8664 // x64 
+#define IMAGE_FILE_MACHINE_ARM 0x1c0 // ARM little endian
+#define IMAGE_FILE_MACHINE_ARM64 0xaa64 // ARM64 little endian
+#define IMAGE_FILE_MACHINE_ARMNT 0x1c4 // ARM Thumb-2 little endian
+#define IMAGE_FILE_MACHINE_EBC 0xebc // EFI byte code
+#define IMAGE_FILE_MACHINE_I386 0x14c // Intel 386 or later processors and compatible processors
+#define IMAGE_FILE_MACHINE_IA64 0x200 // Intel Itanium processor family
+#define IMAGE_FILE_MACHINE_M32R 0x9041 // Mitsubishi M32R little endian
+#define IMAGE_FILE_MACHINE_MIPS16 0x266 // MIPS16
+#define IMAGE_FILE_MACHINE_MIPSFPU 0x366 // MIPS with FPU
+#define IMAGE_FILE_MACHINE_MIPSFPU16 0x466 // MIPS16 with FPU
+#define IMAGE_FILE_MACHINE_POWERPC 0x1f0 // Power PC little endian
+#define IMAGE_FILE_MACHINE_POWERPCFP 0x1f1 // Power PC with floating point support
+#define IMAGE_FILE_MACHINE_R4000 0x166 // MIPS little endian 
+#define IMAGE_FILE_MACHINE_RISCV32 0x5032 // RISC-V 32-bit address space
+#define IMAGE_FILE_MACHINE_RISCV64 0x5064 // RISC-V 64-bit address space
+#define IMAGE_FILE_MACHINE_RISCV128 0x5128 // RISC-V 128-bit address space
+#define IMAGE_FILE_MACHINE_SH3 0x1a2 // Hitachi SH3 
+#define IMAGE_FILE_MACHINE_SH3DSP 0x1a3 // Hitachi SH3 DSP 
+#define IMAGE_FILE_MACHINE_SH4 0x1a6 // Hitachi SH4 
+#define IMAGE_FILE_MACHINE_SH5 0x1a8 // Hitachi SH5
+#define IMAGE_FILE_MACHINE_THUMB 0x1c2 // Thumb
+#define IMAGE_FILE_MACHINE_WCEMIPSV2 0x169 // MIPS little-endian WCE v2 
+
+#define IMAGE_FILE_RELOCS_STRIPPED 0x0001 // Image only, Windows CE, and Microsoft Windows NT and later. This indicates that the file does not contain base relocations and must therefore be loaded at its preferred base address. If the base address is not available, the loader reports an error. The default behavior of the linker is to strip base relocations from executable (EXE) files.
+#define IMAGE_FILE_EXECUTABLE_IMAGE 0x0002 // Image only. This indicates that the image file is valid and can be run. If this flag is not set, it indicates a linker error.  
+#define IMAGE_FILE_LINE_NUMS_STRIPPED 0x0004 // COFF line numbers have been removed. This flag is deprecated and should be zero.
+#define IMAGE_FILE_LOCAL_SYMS_STRIPPED 0x0008 // COFF symbol table entries for local symbols have been removed. This flag is deprecated and should be zero.
+#define IMAGE_FILE_AGGRESSIVE_WS_TRIM 0x0010 // Obsolete. Aggressively trim working set. This flag is deprecated for Windows 2000 and later and must be zero.
+#define IMAGE_FILE_LARGE_ADDRESS_AWARE 0x0020 // Application can handle > 2-GB addresses.
+//#define 0x0040 This flag is reserved for future use.
+#define IMAGE_FILE_BYTES_REVERSED_LO 0x0080 // Little endian: the least significant bit (LSB) precedes the most significant bit (MSB) in memory. This flag is deprecated and should be zero.
+#define IMAGE_FILE_32BIT_MACHINE 0x0100 // Machine is based on a 32-bit-word architecture.  
+#define IMAGE_FILE_DEBUG_STRIPPED 0x0200 // Debugging information is removed from the image file.
+#define IMAGE_FILE_REMOVABLE_RUN_FROM_SWAP 0x0400 // If the image is on removable media, fully load it and copy it to the swap file.
+#define IMAGE_FILE_NET_RUN_FROM_SWAP 0x0800 // If the image is on network media, fully load it and copy it to the swap file.
+#define IMAGE_FILE_SYSTEM 0x1000 // The image file is a system file, not a user program.
+#define IMAGE_FILE_DLL 0x2000 // The image file is a dynamic-link library (DLL). Such files are considered executable files for almost all purposes, although they cannot be directly run.
+#define IMAGE_FILE_UP_SYSTEM_ONLY 0x4000 // The file should be run only on a uniprocessor machine.
+#define IMAGE_FILE_BYTES_REVERSED_HI 0x8000 // Big endian: the MSB precedes the LSB in memory. This flag is deprecated and should be zero. 
+
+typedef struct coff_fields_s
+{
+    WORD Magic;
+    BYTE MajorLinkerVersion;
+    BYTE MinorLinkerVersion;
+    DWORD SizeOfCode;
+    DWORD SizeOfInitializedData;
+    DWORD SizeOfUninitializedData;
+    DWORD AddressOfEntryPoint;
+    DWORD BaseOfCode;
+} coff_fields_t;
+
+#define IMAGE_MAGIC_PE32 0x10b
+#define IMAGE_MAGIC_PE32PLUS 0x20b
+
+typedef struct pe32_coff_fields_s
+{
+    DWORD BaseOfData;
+    DWORD ImageBase;
+    DWORD SectionAlignment;
+    DWORD FileAlignment;
+    WORD MajorOperatingSystemVersion;
+    WORD MinorOperatingSystemVersion;
+    WORD MajorImageVersion;
+    WORD MinorImageVersion;
+    WORD MajorSubsystemVersion;
+    WORD MinorSubsystemVersion;
+    DWORD Win32VersionValue;
+    DWORD SizeOfImage;
+    DWORD SizeOfHeaders;
+    DWORD CheckSum;
+    WORD Subsystem;
+    WORD DllCharacteristics;
+    DWORD SizeOfStackReserve;
+    DWORD SizeOfStackCommit;
+    DWORD SizeOfHeapReserve;
+    DWORD SizeOfHeapCommit;
+    DWORD LoaderFlags;
+    DWORD NumberOfRvaAndSizes;
+} pe32_coff_fields_t;
+
+typedef struct pe32plus_coff_fields_s
+{
+    QWORD ImageBase;
+    DWORD SectionAlignment;
+    DWORD FileAlignment;
+    WORD MajorOperatingSystemVersion;
+    WORD MinorOperatingSystemVersion;
+    WORD MajorImageVersion;
+    WORD MinorImageVersion;
+    WORD MajorSubsystemVersion;
+    WORD MinorSubsystemVersion;
+    DWORD Win32VersionValue;
+    DWORD SizeOfImage;
+    DWORD SizeOfHeaders;
+    DWORD CheckSum;
+    WORD Subsystem;
+    WORD DllCharacteristics;
+    QWORD SizeOfStackReserve;
+    QWORD SizeOfStackCommit;
+    QWORD SizeOfHeapReserve;
+    QWORD SizeOfHeapCommit;
+    DWORD LoaderFlags;
+    DWORD NumberOfRvaAndSizes;
+} pe32plus_coff_fields_t;
+
+typedef union pe_coff_fields_u
+{
+    pe32_coff_fields_t pe32;
+    pe32plus_coff_fields_t pe32plus;
+} pe_coff_fields_t;
+
+#define IMAGE_SUBSYSTEM_UNKNOWN 0 // An unknown subsystem
+#define IMAGE_SUBSYSTEM_NATIVE 1 // Device drivers and native Windows processes
+#define IMAGE_SUBSYSTEM_WINDOWS_GUI 2 // The Windows graphical user interface (GUI) subsystem
+#define IMAGE_SUBSYSTEM_WINDOWS_CUI 3 // The Windows character subsystem
+#define IMAGE_SUBSYSTEM_OS2_CUI 5 // The OS/2 character subsystem
+#define IMAGE_SUBSYSTEM_POSIX_CUI 7 // The Posix character subsystem
+#define IMAGE_SUBSYSTEM_NATIVE_WINDOWS 8 // Native Win9x driver 
+#define IMAGE_SUBSYSTEM_WINDOWS_CE_GUI 9 // Windows CE 
+#define IMAGE_SUBSYSTEM_EFI_APPLICATION 10 // An Extensible Firmware Interface (EFI) application
+#define IMAGE_SUBSYSTEM_EFI_BOOT_SERVICE_DRIVER 11 // An EFI driver with boot services
+#define IMAGE_SUBSYSTEM_EFI_RUNTIME_DRIVER 12 // An EFI driver with run-time services
+#define IMAGE_SUBSYSTEM_EFI_ROM 13 // An EFI ROM image
+#define IMAGE_SUBSYSTEM_XBOX 14 // XBOX
+#define IMAGE_SUBSYSTEM_WINDOWS_BOOT_APPLICATION 16 // Windows boot application. 
+
+// 0x0001 Reserved, must be zero.
+// 0x0002 Reserved, must be zero.
+// 0x0004 Reserved, must be zero. 
+// 0x0008 Reserved, must be zero.
+#define IMAGE_DLLCHARACTERISTICS_HIGH_ENTROPY_VA 0x0020 // Image can handle a high entropy 64-bit virtual address space.
+#define IMAGE_DLLCHARACTERISTICS_DYNAMIC_BASE 0x0040 // DLL can be relocated at load time.
+#define IMAGE_DLLCHARACTERISTICS_FORCE_INTEGRITY 0x0080 // Code Integrity checks are enforced.
+#define IMAGE_DLLCHARACTERISTICS_NX_COMPAT 0x0100 // Image is NX compatible.
+#define IMAGE_DLLCHARACTERISTICS_NO_ISOLATION 0x0200 // Isolation aware, but do not isolate the image. 
+#define IMAGE_DLLCHARACTERISTICS_NO_SEH 0x0400 // Does not use structured exception (SE) handling. No SE handler may be called in this image.
+#define IMAGE_DLLCHARACTERISTICS_NO_BIND 0x0800 // Do not bind the image.
+#define IMAGE_DLLCHARACTERISTICS_PPCONTAINER 0x1000 // Image must execute in an AppContainer.
+#define IMAGE_DLLCHARACTERISTICS_WDM_DRIVER 0x2000 // A WDM driver.
+#define IMAGE_DLLCHARACTERISTICS_GUARD_CF 0x4000 // Image supports Control Flow Guard.
+#define IMAGE_DLLCHARACTERISTICS_TERMINAL_SERVER_AWARE 0x8000 // Terminal Server aware. 
+
+typedef struct data_directory_entry_s
+{
+    DWORD VirtualAddress;
+    DWORD Size;
+} data_directory_entry_t;
+
+typedef struct image_data_directory_s
+{
+    data_directory_entry_t ExportTable;
+    data_directory_entry_t ImportTable;
+    data_directory_entry_t ResourceTable;
+    data_directory_entry_t ExceptionTable;
+    data_directory_entry_t CertificateTable;
+    data_directory_entry_t BaseRelocationTable;
+    data_directory_entry_t Debug;
+    data_directory_entry_t Architecture;
+    data_directory_entry_t GlobalPtr;
+    data_directory_entry_t TLSTable;
+    data_directory_entry_t LoadConfigTable;
+    data_directory_entry_t BoundImport;
+    data_directory_entry_t ImportAddressTable;
+    data_directory_entry_t DelayImportDescriptor;
+    data_directory_entry_t CLRRuntimeHeader;
+    data_directory_entry_t Reserved;
+} image_data_directory_t;
+
+typedef struct pecoff_section_s
+{
+    BYTE Name[8];
+    DWORD VirtualSize;
+    DWORD VirtualAddress;
+    DWORD SizeOfRawData;
+    DWORD PointerToRawData;
+    DWORD PointerToRelocations;
+    DWORD PointerToLinenumbers;
+    WORD NumberOfRelocations;
+    WORD NumberOfLinenumbers;
+    DWORD Characteristics;
+} pecoff_section_t;
+
+// 0x00000000 Reserved for future use.
+// 0x00000001 Reserved for future use.
+// 0x00000002 Reserved for future use.
+// 0x00000004 Reserved for future use.
+#define IMAGE_SCN_TYPE_NO_PAD 0x00000008 // The section should not be padded to the next boundary. This flag is obsolete and is replaced by IMAGE_SCN_ALIGN_1BYTES. This is valid only for object files.
+// 0x00000010 Reserved for future use.  
+#define IMAGE_SCN_CNT_CODE 0x00000020 // The section contains executable code.
+#define IMAGE_SCN_CNT_INITIALIZED_DATA 0x00000040 // The section contains initialized data.
+#define IMAGE_SCN_CNT_UNINITIALIZED_DATA 0x00000080 // The section contains uninitialized data.
+#define IMAGE_SCN_LNK_OTHER 0x00000100 // Reserved for future use.
+#define IMAGE_SCN_LNK_INFO 0x00000200 // The section contains comments or other information. The .drectve section has this type. This is valid for object files only.
+// 0x00000400 Reserved for future use.  
+#define IMAGE_SCN_LNK_REMOVE 0x00000800 // The section will not become part of the image. This is valid only for object files.
+#define IMAGE_SCN_LNK_COMDAT 0x00001000 // The section contains COMDAT data. For more information, see COMDAT Sections (Object Only). This is valid only for object files.
+#define IMAGE_SCN_GPREL 0x00008000 // The section contains data referenced through the global pointer (GP).
+#define IMAGE_SCN_MEM_PURGEABLE 0x00020000 // Reserved for future use.
+#define IMAGE_SCN_MEM_16BIT 0x00020000 // Reserved for future use.
+#define IMAGE_SCN_MEM_LOCKED 0x00040000 // Reserved for future use.
+#define IMAGE_SCN_MEM_PRELOAD 0x00080000 // Reserved for future use.  
+#define IMAGE_SCN_ALIGN_1BYTES 0x00100000 // Align data on a 1-byte boundary. Valid only for object files.
+#define IMAGE_SCN_ALIGN_2BYTES 0x00200000 // Align data on a 2-byte boundary. Valid only for object files.
+#define IMAGE_SCN_ALIGN_4BYTES 0x00300000 // Align data on a 4-byte boundary. Valid only for object files.
+#define IMAGE_SCN_ALIGN_8BYTES 0x00400000 // Align data on an 8-byte boundary. Valid only for object files.
+#define IMAGE_SCN_ALIGN_16BYTES 0x00500000 // Align data on a 16-byte boundary. Valid only for object files.
+#define IMAGE_SCN_ALIGN_32BYTES 0x00600000 // Align data on a 32-byte boundary. Valid only for object files.
+#define IMAGE_SCN_ALIGN_64BYTES 0x00700000 // Align data on a 64-byte boundary. Valid only for object files.  
+#define IMAGE_SCN_ALIGN_128BYTES 0x00800000 // Align data on a 128-byte boundary. Valid only for object files.  
+#define IMAGE_SCN_ALIGN_256BYTES 0x00900000 // Align data on a 256-byte boundary. Valid only for object files.  
+#define IMAGE_SCN_ALIGN_512BYTES 0x00A00000 // Align data on a 512-byte boundary. Valid only for object files.  
+#define IMAGE_SCN_ALIGN_1024BYTES 0x00B00000 // Align data on a 1024-byte boundary. Valid only for object files.
+#define IMAGE_SCN_ALIGN_2048BYTES 0x00C00000 // Align data on a 2048-byte boundary. Valid only for object files.
+#define IMAGE_SCN_ALIGN_4096BYTES 0x00D00000 // Align data on a 4096-byte boundary. Valid only for object files.
+#define IMAGE_SCN_ALIGN_8192BYTES 0x00E00000 // Align data on an 8192-byte boundary. Valid only for object files.
+#define IMAGE_SCN_LNK_NRELOC_OVFL 0x01000000 // The section contains extended relocations.
+#define IMAGE_SCN_MEM_DISCARDABLE 0x02000000 // The section can be discarded as needed.
+#define IMAGE_SCN_MEM_NOT_CACHED 0x04000000 // The section cannot be cached.
+#define IMAGE_SCN_MEM_NOT_PAGED 0x08000000 // The section is not pageable.
+#define IMAGE_SCN_MEM_SHARED 0x10000000 // The section can be shared in memory.
+#define IMAGE_SCN_MEM_EXECUTE 0x20000000 // The section can be executed as code.
+#define IMAGE_SCN_MEM_READ 0x40000000 // The section can be read.
+#define IMAGE_SCN_MEM_WRITE 0x80000000 // The section can be written to. 
+
+typedef struct attribute_certificate_s
+{
+    DWORD dwLength;
+    WORD wRevision;
+    WORD wCertificateType;
+} attribute_certificate_t;
+
+#define WIN_CERT_REVISION_1_0 0x0100 // Version 1, legacy version of the Win_Certificate structure. It is supported only for purposes of verifying legacy Authenticode signatures
+#define WIN_CERT_REVISION_2_0 0x0200 // Version 2 is the current version of the Win_Certificate structure.
+
+#define WIN_CERT_TYPE_X509 0x0001 // bCertificate contains an X.509 Certificate Not Supported
+#define WIN_CERT_TYPE_PKCS_SIGNED_DATA 0x0002 // bCertificate contains a PKCS#7 SignedData structure
+#define WIN_CERT_TYPE_RESERVED_1 0x0003 // Reserved
+#define WIN_CERT_TYPE_TS_STACK_SIGNED 0x0004 // Terminal Server Protocol Stack Certificate signing Not Supported
+
+
+
+#define PE_COFF_IMAGE 0x00004550 // ..EP (or PE.. in EB)
+
diff --git a/xen/common/ped.c b/xen/common/ped.c
new file mode 100644
index 0000000..b44b971
--- /dev/null
+++ b/xen/common/ped.c
@@ -0,0 +1,579 @@
+
+#ifndef __XEN__
+#include <stdio.h>
+#include <stdint.h>
+#include <sys/types.h>
+#else
+#include <xen/lib.h>
+#endif
+
+#include "dlcl.h"
+
+// google microsoft pecoff format
+// wiki microsoft pecoff format
+#include "ped.h"
+
+// FIX!!! see discussion wrt/ typeof()
+#define min(A,B) (((A)<(B)) ? (A) : (B))
+#define max(A,B) (((A)>(B)) ? (A) : (B))
+
+/********************************************************************/
+#define LABEL "%35s: "
+#define CHKDUMP(field, value) PRINTK(LABEL "0x%02X %c %d\n", field, value, (value >= ' ' && value <= '~') ? value : '.', value)
+#define FIELD_B(field, value) PRINTK(LABEL "0x%02X %c %d\n", #field, value, (value >= ' ' && value <= '~') ? value : '.', value)
+#define FIELD_W(field, value) PRINTK(LABEL "0x%04X\n", #field, value)
+#define FIELD_D(field, value) PRINTK(LABEL "0x%08X\n", #field, value)
+#define FIELD_Q(field, value) PRINTK(LABEL "0x%016llX\n", #field, (unsigned long long)value)
+
+#define CHKBIT(var, bit) if ((var)  & (bit)) CHKDUMP(#bit, bit)
+#define CHKDEF(var, def) if ((var) == (def)) CHKDUMP(#def, def)
+
+/********************************************************************/
+/********************************************************************/
+/********************************************************************/
+/********************************************************************/
+
+#define xOFFSET_OF(TYPE, MEMBER) { offset_t o; TYPE *p = (TYPE *)0; o = (&p->MEMBER - p); o; }
+#define OFFSET_OF(PTR, MEMBER) (((BYTE *)&PTR->MEMBER) - ((BYTE *)PTR))
+
+/********************************************************************/
+range_t *
+pecoff_append_range (pecoff_image_t *pe, DWORD offset, DWORD length, BYTE *data, const char *description)
+{
+    range_t *range = NULL;
+//PRINTK("RANGE %6u %6u %s\n", offset, length, description);
+    if (length)
+    {
+        range = zsalloc(range_t);
+        range->offset = offset;
+        range->length = length;
+        range->data = data;
+        range->description = description;
+        DLCL_APPEND(range_t, pe->ranges, range);
+    }
+    return range;
+}
+
+/********************************************************************/
+pecoff_image_t *
+pecoff_image_alloc (uint8_t *imageBase, size_t imageSize)
+{
+    pecoff_image_t *pe = zsalloc(pecoff_image_t);
+    if (pe)
+    {
+        pe->imageBase = imageBase;
+        pe->imageSize = imageSize;
+    }
+    return pe;
+}
+
+void
+pecoff_image_free (pecoff_image_t *pe)
+{
+    if (pe)
+    {
+        range_t *range;
+        DLCL_FOR_EACH(range_t, pe->ranges, range, next, prev)
+        {
+            DLCL_REMOVE(range_t, pe->ranges, range);
+            zsfree(range);
+            // FIX!!! accessing range->next after free()
+        }
+        zsfree(pe);
+    }
+}
+
+/********************************************************************/
+static void *
+pe_make_pointer (pecoff_image_t *pe, size_t size)
+{
+    void *p = NULL;
+
+    if ((pe->offset >= pe->imageSize) || (pe->offset+size > pe->imageSize))
+    {
+        PRINTK("Error: offset %lu > imageSize %lu\n", pe->offset, pe->imageSize);
+    }
+    else
+    {
+        p = (void *)(pe->imageBase + pe->offset);
+        pe->offset += size;
+    }
+    return p;
+}
+#define mkptr(TYPE) (TYPE *)pe_make_pointer(pe, sizeof(TYPE))
+
+/********************************************************************/
+pecoff_image_t *
+pecoff_image_decode (uint8_t *imageBase, size_t imageSize)
+{
+    pecoff_image_t *pe;
+    dos_header_t *dh;
+
+    pe = pecoff_image_alloc(imageBase, imageSize);
+
+    // MSDOS header/stub
+    pe->dhc.fileOffset = pe->offset;
+    if (NULL == (pe->dhc.dh = mkptr(dos_header_t))) goto error;
+    dh = pe->dhc.dh;
+    FIELD_B(Signature, dh->Signature[0]);
+    FIELD_B(Signature, dh->Signature[1]);
+    FIELD_D(PE_Header_Offset, dh->pe_header_offset);
+
+    if ((IMAGE_FILE_SIGNATURE_0 == dh->Signature[0]) &&
+        (IMAGE_FILE_SIGNATURE_1 == dh->Signature[1]))
+    {
+        coff_header_t *ch;
+
+        // Read in DOS stub
+        if (NULL == (pe->dhc.ds = mkptr(uint8_t))) goto error;
+        pe->offset = dh->pe_header_offset;
+
+        // COFF header
+        pe->chc.fileOffset = pe->offset;
+        if (NULL == (pe->chc.ch = mkptr(coff_header_t))) goto error;
+        ch = pe->chc.ch;
+
+        FIELD_D(Signature, ch->Signature);
+        FIELD_W(Machine, ch->Machine);
+
+        if (PE_COFF_IMAGE != ch->Signature)
+        {
+            goto error;
+        }
+        CHKDEF(ch->Machine, IMAGE_FILE_MACHINE_UNKNOWN);
+        CHKDEF(ch->Machine, IMAGE_FILE_MACHINE_AM33);
+        CHKDEF(ch->Machine, IMAGE_FILE_MACHINE_AMD64);
+        CHKDEF(ch->Machine, IMAGE_FILE_MACHINE_ARM);
+        CHKDEF(ch->Machine, IMAGE_FILE_MACHINE_ARM64);
+        CHKDEF(ch->Machine, IMAGE_FILE_MACHINE_ARMNT);
+        CHKDEF(ch->Machine, IMAGE_FILE_MACHINE_EBC);
+        CHKDEF(ch->Machine, IMAGE_FILE_MACHINE_I386);
+        CHKDEF(ch->Machine, IMAGE_FILE_MACHINE_IA64);
+        CHKDEF(ch->Machine, IMAGE_FILE_MACHINE_M32R);
+        CHKDEF(ch->Machine, IMAGE_FILE_MACHINE_MIPS16);
+        CHKDEF(ch->Machine, IMAGE_FILE_MACHINE_MIPSFPU);
+        CHKDEF(ch->Machine, IMAGE_FILE_MACHINE_MIPSFPU16);
+        CHKDEF(ch->Machine, IMAGE_FILE_MACHINE_POWERPC);
+        CHKDEF(ch->Machine, IMAGE_FILE_MACHINE_POWERPCFP);
+        CHKDEF(ch->Machine, IMAGE_FILE_MACHINE_R4000);
+        CHKDEF(ch->Machine, IMAGE_FILE_MACHINE_RISCV32);
+        CHKDEF(ch->Machine, IMAGE_FILE_MACHINE_RISCV64);
+        CHKDEF(ch->Machine, IMAGE_FILE_MACHINE_RISCV128);
+        CHKDEF(ch->Machine, IMAGE_FILE_MACHINE_SH3);
+        CHKDEF(ch->Machine, IMAGE_FILE_MACHINE_SH3DSP);
+        CHKDEF(ch->Machine, IMAGE_FILE_MACHINE_SH4);
+        CHKDEF(ch->Machine, IMAGE_FILE_MACHINE_SH5);
+        CHKDEF(ch->Machine, IMAGE_FILE_MACHINE_THUMB);
+        CHKDEF(ch->Machine, IMAGE_FILE_MACHINE_WCEMIPSV2);
+        FIELD_W(NumberOfSections, ch->NumberOfSections);
+        FIELD_D(TimeDateStamp, ch->TimeDateStamp);
+        FIELD_D(PointerToSymbolTable, ch->PointerToSymbolTable);
+        FIELD_D(NumberOfSymbolTable, ch->NumberOfSymbolTable);
+        FIELD_W(SizeofOptionalHeader, ch->SizeofOptionalHeader);
+        FIELD_W(Characteristics, ch->Characteristics);
+        CHKBIT(ch->Characteristics, IMAGE_FILE_RELOCS_STRIPPED);
+        CHKBIT(ch->Characteristics, IMAGE_FILE_EXECUTABLE_IMAGE);
+        CHKBIT(ch->Characteristics, IMAGE_FILE_LINE_NUMS_STRIPPED);
+        CHKBIT(ch->Characteristics, IMAGE_FILE_LOCAL_SYMS_STRIPPED);
+        CHKBIT(ch->Characteristics, IMAGE_FILE_AGGRESSIVE_WS_TRIM);
+        CHKBIT(ch->Characteristics, IMAGE_FILE_LARGE_ADDRESS_AWARE );
+        CHKBIT(ch->Characteristics, IMAGE_FILE_BYTES_REVERSED_LO);
+        CHKBIT(ch->Characteristics, IMAGE_FILE_32BIT_MACHINE);
+        CHKBIT(ch->Characteristics, IMAGE_FILE_DEBUG_STRIPPED);
+        CHKBIT(ch->Characteristics, IMAGE_FILE_REMOVABLE_RUN_FROM_SWAP);
+        CHKBIT(ch->Characteristics, IMAGE_FILE_NET_RUN_FROM_SWAP);
+        CHKBIT(ch->Characteristics, IMAGE_FILE_SYSTEM);
+        CHKBIT(ch->Characteristics, IMAGE_FILE_DLL);
+        CHKBIT(ch->Characteristics, IMAGE_FILE_UP_SYSTEM_ONLY);
+        CHKBIT(ch->Characteristics, IMAGE_FILE_BYTES_REVERSED_HI);
+
+        if (ch->SizeofOptionalHeader) // required for Image
+        {
+            WORD Subsystem = 0;
+
+            // COFF fields
+            pe->cfc.fileOffset = pe->offset;
+            if (NULL == (pe->cfc.cf = mkptr(coff_fields_t))) goto error;
+
+            FIELD_W(Magic, pe->cfc.cf->Magic);
+            FIELD_B(MajorLinkerVersion, pe->cfc.cf->MajorLinkerVersion);
+            FIELD_B(MinorLinkerVersion, pe->cfc.cf->MinorLinkerVersion);
+            FIELD_D(SizeOfCode, pe->cfc.cf->SizeOfCode);
+            FIELD_D(SizeOfInitializedData, pe->cfc.cf->SizeOfInitializedData);
+            FIELD_D(SizeOfUninitializedData, pe->cfc.cf->SizeOfUninitializedData);
+            FIELD_D(AddressOfEntryPoint, pe->cfc.cf->AddressOfEntryPoint);
+            FIELD_D(BaseOfCode, pe->cfc.cf->BaseOfCode);
+
+            // Optional Header Windows-Specific fields (Image Only)
+            pe->pecfc.fileOffset = pe->offset;
+
+            if (is_pe32())
+            {
+                pe32_coff_fields_t *pecf;
+                pe->pecfc.fileOffset = pe->offset;
+                if (NULL == (pe->pecfc.pe32 = mkptr(pe32_coff_fields_t))) goto error;
+                pecf = pe->pecfc.pe32;
+
+                FIELD_D(BaseOfData, pecf->BaseOfData);
+                FIELD_D(ImageBase, pecf->ImageBase);
+                FIELD_D(SectionAlignment, pecf->SectionAlignment);
+                FIELD_D(FileAlignment, pecf->FileAlignment);
+                FIELD_W(MajorOperatingSystemVersion, pecf->MajorOperatingSystemVersion);
+                FIELD_W(MinorOperatingSystemVersion, pecf->MinorOperatingSystemVersion);
+                FIELD_W(MajorImageVersion, pecf->MajorImageVersion);
+                FIELD_W(MinorImageVersion, pecf->MinorImageVersion);
+                FIELD_W(MajorSubsystemVersion, pecf->MajorSubsystemVersion);
+                FIELD_W(MinorSubsystemVersion, pecf->MinorSubsystemVersion);
+                FIELD_D(Win32VersionValue, pecf->Win32VersionValue);
+                FIELD_D(SizeOfImage, pecf->SizeOfImage);
+                FIELD_D(SizeOfHeaders, pecf->SizeOfHeaders);
+                FIELD_D(CheckSum, pecf->CheckSum);
+                FIELD_W(Subsystem, pecf->Subsystem);
+                FIELD_W(DllCharacteristics, pecf->DllCharacteristics);
+                FIELD_D(SizeOfStackReserve, pecf->SizeOfStackReserve);
+                FIELD_D(SizeOfStackCommit, pecf->SizeOfStackCommit);
+                FIELD_D(SizeOfHeapReserve, pecf->SizeOfHeapReserve);
+                FIELD_D(SizeOfHeapCommit, pecf->SizeOfHeapCommit);
+                FIELD_D(LoaderFlags, pecf->LoaderFlags);
+                FIELD_D(NumberOfRvaAndSizes, pecf->NumberOfRvaAndSizes);
+                Subsystem = pecf->Subsystem;
+                pe->NumberOfRvaAndSizes = pecf->NumberOfRvaAndSizes;
+            }
+            else
+            {
+                pe32plus_coff_fields_t *pecf;
+                pe->pecfc.fileOffset = pe->offset;
+                if (NULL == (pe->pecfc.pe32plus = mkptr(pe32plus_coff_fields_t))) goto error;
+                pecf = pe->pecfc.pe32plus;
+
+                FIELD_Q(ImageBase, pecf->ImageBase);
+                FIELD_D(SectionAlignment, pecf->SectionAlignment);
+                FIELD_D(FileAlignment, pecf->FileAlignment);
+                FIELD_W(MajorOperatingSystemVersion, pecf->MajorOperatingSystemVersion);
+                FIELD_W(MinorOperatingSystemVersion, pecf->MinorOperatingSystemVersion);
+                FIELD_W(MajorImageVersion, pecf->MajorImageVersion);
+                FIELD_W(MinorImageVersion, pecf->MinorImageVersion);
+                FIELD_W(MajorSubsystemVersion, pecf->MajorSubsystemVersion);
+                FIELD_W(MinorSubsystemVersion, pecf->MinorSubsystemVersion);
+                FIELD_D(Win32VersionValue, pecf->Win32VersionValue);
+                FIELD_D(SizeOfImage, pecf->SizeOfImage);
+                FIELD_D(SizeOfHeaders, pecf->SizeOfHeaders);
+                FIELD_D(CheckSum, pecf->CheckSum);
+                FIELD_W(Subsystem, pecf->Subsystem);
+                FIELD_W(DllCharacteristics, pecf->DllCharacteristics);
+                FIELD_Q(SizeOfStackReserve, pecf->SizeOfStackReserve);
+                FIELD_Q(SizeOfStackCommit, pecf->SizeOfStackCommit);
+                FIELD_Q(SizeOfHeapReserve, pecf->SizeOfHeapReserve);
+                FIELD_Q(SizeOfHeapCommit, pecf->SizeOfHeapCommit);
+                FIELD_D(LoaderFlags, pecf->LoaderFlags);
+                FIELD_D(NumberOfRvaAndSizes, pecf->NumberOfRvaAndSizes);
+                Subsystem = pecf->Subsystem;
+                pe->NumberOfRvaAndSizes = pecf->NumberOfRvaAndSizes;
+            }
+            CHKDEF(Subsystem, IMAGE_SUBSYSTEM_UNKNOWN);
+            CHKDEF(Subsystem, IMAGE_SUBSYSTEM_NATIVE);
+            CHKDEF(Subsystem, IMAGE_SUBSYSTEM_WINDOWS_GUI);
+            CHKDEF(Subsystem, IMAGE_SUBSYSTEM_WINDOWS_CUI);
+            CHKDEF(Subsystem, IMAGE_SUBSYSTEM_OS2_CUI);
+            CHKDEF(Subsystem, IMAGE_SUBSYSTEM_POSIX_CUI);
+            CHKDEF(Subsystem, IMAGE_SUBSYSTEM_NATIVE_WINDOWS);
+            CHKDEF(Subsystem, IMAGE_SUBSYSTEM_WINDOWS_CE_GUI);
+            CHKDEF(Subsystem, IMAGE_SUBSYSTEM_EFI_APPLICATION);
+            CHKDEF(Subsystem, IMAGE_SUBSYSTEM_EFI_BOOT_SERVICE_DRIVER);
+            CHKDEF(Subsystem, IMAGE_SUBSYSTEM_EFI_RUNTIME_DRIVER);
+            CHKDEF(Subsystem, IMAGE_SUBSYSTEM_EFI_ROM);
+            CHKDEF(Subsystem, IMAGE_SUBSYSTEM_XBOX);
+            CHKDEF(Subsystem, IMAGE_SUBSYSTEM_WINDOWS_BOOT_APPLICATION);
+
+            // Data directory entries
+            pe->iddc.fileOffset = pe->offset;
+            if (NULL == (pe->iddc.dd = mkptr(image_data_directory_t))) goto error;
+            pe->offset -= sizeof(image_data_directory_t); // reset
+            pe->offset += (pe->NumberOfRvaAndSizes * sizeof(data_directory_entry_t));
+
+#define DDE(name) \
+            FIELD_D(name##Rva, pe->iddc.dd->name.VirtualAddress); \
+            FIELD_D(name##Size, pe->iddc.dd->name.Size);
+            for (unsigned idx = 0; idx < pe->NumberOfRvaAndSizes; ++idx)
+            {
+                switch (idx)
+                {
+                case 0: DDE(ExportTable); break;
+                case 1: DDE(ImportTable); break;
+                case 2: DDE(ResourceTable); break;
+                case 3: DDE(ExceptionTable); break;
+                case 4: DDE(CertificateTable); break;
+                case 5: DDE(BaseRelocationTable); break;
+                case 6: DDE(Debug); break;
+                case 7: DDE(Architecture); break;
+                case 8: DDE(GlobalPtr); break;
+                case 9: DDE(TLSTable); break;
+                case 10: DDE(LoadConfigTable); break;
+                case 11: DDE(BoundImport); break;
+                case 12: DDE(ImportAddressTable); break;
+                case 13: DDE(DelayImportDescriptor); break;
+                case 14: DDE(CLRRuntimeHeader); break;
+                default:
+                case 15: DDE(Reserved); break;
+                }
+            }
+        }
+
+        // Section headers
+        pe->SectionHeaderBase = pe->offset;
+        for (unsigned idx = 0; idx < ch->NumberOfSections; ++idx)
+        {
+            pecoff_section_ct *sc;
+            pecoff_section_t *s;
+            DWORD align; (void)align;
+
+            sc = &pe->sectioncs[idx];
+            DLCL_APPEND(pecoff_section_ct, pe->sections, sc);
+
+            pe->offset = pe->SectionHeaderBase + (idx * sizeof(pecoff_section_t));
+            sc->fileOffset = pe->offset;
+            if (NULL == (sc->s = mkptr(pecoff_section_t))) goto error;
+            s = sc->s;
+
+            if (s->SizeOfRawData)
+            {
+                pe->offset = s->PointerToRawData;
+                if (NULL == (sc->data = mkptr(uint8_t))) goto error;
+            }
+
+            // Name
+            for (unsigned k = 0; k < sizeof(s->Name); ++k)
+            {
+                FIELD_B(Name, s->Name[k]);
+            }
+            FIELD_D(VirtualSize, s->VirtualSize);
+            FIELD_D(VirtualAddress, s->VirtualAddress);
+            FIELD_D(SizeOfRawData, s->SizeOfRawData);
+            FIELD_D(PointerToRawData, s->PointerToRawData);
+            FIELD_D(PointerToRelocations, s->PointerToRelocations);
+            FIELD_D(PointerToLinenumbers, s->PointerToLinenumbers);
+            FIELD_W(NumberOfRelocations, s->NumberOfRelocations);
+            FIELD_W(NumberOfLinenumbers, s->NumberOfLinenumbers);
+            FIELD_D(Characteristics, s->Characteristics);
+            CHKBIT(s->Characteristics, IMAGE_SCN_TYPE_NO_PAD);
+            CHKBIT(s->Characteristics, IMAGE_SCN_CNT_CODE);
+            CHKBIT(s->Characteristics, IMAGE_SCN_CNT_INITIALIZED_DATA);
+            CHKBIT(s->Characteristics, IMAGE_SCN_CNT_UNINITIALIZED_DATA);
+            CHKBIT(s->Characteristics, IMAGE_SCN_LNK_OTHER);
+            CHKBIT(s->Characteristics, IMAGE_SCN_LNK_INFO);
+            CHKBIT(s->Characteristics, IMAGE_SCN_LNK_REMOVE);
+            CHKBIT(s->Characteristics, IMAGE_SCN_LNK_COMDAT);
+            CHKBIT(s->Characteristics, IMAGE_SCN_GPREL);
+            CHKBIT(s->Characteristics, IMAGE_SCN_MEM_PURGEABLE);
+            CHKBIT(s->Characteristics, IMAGE_SCN_MEM_16BIT);
+            CHKBIT(s->Characteristics, IMAGE_SCN_MEM_LOCKED);
+            CHKBIT(s->Characteristics, IMAGE_SCN_MEM_PRELOAD);
+            align = s->Characteristics & (IMAGE_SCN_ALIGN_8192BYTES|IMAGE_SCN_ALIGN_1BYTES);
+            CHKDEF(align, IMAGE_SCN_ALIGN_1BYTES);
+            CHKDEF(align, IMAGE_SCN_ALIGN_2BYTES);
+            CHKDEF(align, IMAGE_SCN_ALIGN_4BYTES);
+            CHKDEF(align, IMAGE_SCN_ALIGN_8BYTES);
+            CHKDEF(align, IMAGE_SCN_ALIGN_16BYTES);
+            CHKDEF(align, IMAGE_SCN_ALIGN_32BYTES);
+            CHKDEF(align, IMAGE_SCN_ALIGN_64BYTES);
+            CHKDEF(align, IMAGE_SCN_ALIGN_128BYTES);
+            CHKDEF(align, IMAGE_SCN_ALIGN_256BYTES);
+            CHKDEF(align, IMAGE_SCN_ALIGN_512BYTES);
+            CHKDEF(align, IMAGE_SCN_ALIGN_1024BYTES);
+            CHKDEF(align, IMAGE_SCN_ALIGN_2048BYTES);
+            CHKDEF(align, IMAGE_SCN_ALIGN_4096BYTES);
+            CHKDEF(align, IMAGE_SCN_ALIGN_8192BYTES);
+            CHKBIT(s->Characteristics, IMAGE_SCN_LNK_NRELOC_OVFL);
+            CHKBIT(s->Characteristics, IMAGE_SCN_MEM_DISCARDABLE);
+            CHKBIT(s->Characteristics, IMAGE_SCN_MEM_NOT_CACHED);
+            CHKBIT(s->Characteristics, IMAGE_SCN_MEM_NOT_PAGED);
+            CHKBIT(s->Characteristics, IMAGE_SCN_MEM_SHARED);
+            CHKBIT(s->Characteristics, IMAGE_SCN_MEM_EXECUTE);
+            CHKBIT(s->Characteristics, IMAGE_SCN_MEM_READ);
+            CHKBIT(s->Characteristics, IMAGE_SCN_MEM_WRITE);
+            if (sc->data)
+            {
+                for (unsigned k = 0; k < 8; ++k)
+                {
+                    FIELD_B(SECTION_BYTE, sc->data[k]);
+                }
+            }
+        }
+
+        // Certificate Table handling
+        if (pe->iddc.dd->CertificateTable.VirtualAddress)
+        {
+// FIX!!! not allowing for more than one cert!!!
+            attribute_certificate_t *ac;
+            pe->offset = pe->iddc.dd->CertificateTable.VirtualAddress;
+            if (NULL == (pe->cert.ac = mkptr(attribute_certificate_t))) goto error;
+            ac = pe->cert.ac;
+
+            FIELD_D(dwLength, ac->dwLength);
+            FIELD_W(wRevision, ac->wRevision);
+            FIELD_W(wCertificateType, ac->wCertificateType);
+            CHKDEF(ac->wRevision, WIN_CERT_REVISION_1_0);
+            CHKDEF(ac->wRevision, WIN_CERT_REVISION_2_0);
+            CHKDEF(ac->wCertificateType, WIN_CERT_TYPE_X509);
+            CHKDEF(ac->wCertificateType, WIN_CERT_TYPE_PKCS_SIGNED_DATA);
+            CHKDEF(ac->wCertificateType, WIN_CERT_TYPE_RESERVED_1);
+            CHKDEF(ac->wCertificateType, WIN_CERT_TYPE_TS_STACK_SIGNED);
+            // FIX!!! verify dwLength < CertificateTable.Size
+            if (NULL == (pe->cert.data = mkptr(uint8_t))) goto error;
+        }
+
+    }
+    else
+        goto error;
+
+    return pe;
+
+    error:
+        if (pe) pecoff_image_free(pe);
+        return NULL;
+}
+
+/********************************************************************/
+void
+pecoff_setup_verify (pecoff_image_t *pe)
+{
+    if (pe && pe->iddc.dd->CertificateTable.VirtualAddress)
+    {
+        // Generate signature byte stream
+        // See Windows Authenticode Portable Executable Signature Format
+        // 'Calculating the PE Image Hash'
+        DWORD off1, len1;
+        DWORD off2, len2;
+        BYTE *dat1, *dat2;
+        pecoff_section_ct *sc;
+        pecoff_section_t *s;
+        DWORD StartOfRawData = ~0;
+        DWORD EndOfRawData = 0;
+        DWORD EndOfImageHeader = 0;
+        unsigned SUM_OF_BYTES_HASHED;
+        BYTE *buf;
+        unsigned FILE_SIZE;
+        unsigned EXTRA;
+        range_t *range;
+        int sorted;
+
+        // DOS header and stub
+        off1 = pe->dhc.fileOffset;
+        len1 = sizeof(dos_header_t);
+        dat1 = (BYTE *)pe->dhc.dh;
+        off2 = off1 + len1;
+        len2 = pe->chc.fileOffset - sizeof(dos_header_t);
+        dat2 = pe->dhc.ds;
+        pecoff_append_range(pe, off1, len1, dat1, "DOS header");
+        pecoff_append_range(pe, off2, len2, dat2, "DOS stub");
+        // COFF headers
+        pecoff_append_range(pe, pe->chc.fileOffset, sizeof(coff_header_t), (BYTE *)pe->chc.ch, "COFF header");
+        // COFF fields
+        pecoff_append_range(pe, pe->cfc.fileOffset, sizeof(coff_fields_t), (BYTE *)pe->cfc.cf, "COFF fields");
+        // Windows specific fields, excluding Checksum
+        if (is_pe32())
+        {
+            off1 = pe->pecfc.fileOffset;
+            len1 = OFFSET_OF(pe->pecfc.pe32, CheckSum);
+            dat1 = (BYTE *)pe->pecfc.pe32;
+            off2 = off1 + len1 + sizeof(DWORD);
+            len2 = sizeof(pe32_coff_fields_t) - OFFSET_OF(pe->pecfc.pe32, Subsystem);
+            dat2 = dat1 + len1 + sizeof(DWORD);
+        }
+        else
+        {
+            off1 = pe->pecfc.fileOffset;
+            len1 = OFFSET_OF(pe->pecfc.pe32plus, CheckSum);
+            dat1 = (BYTE *)pe->pecfc.pe32plus;
+            off2 = off1 + len1 + sizeof(DWORD);
+            len2 = sizeof(pe32plus_coff_fields_t) - OFFSET_OF(pe->pecfc.pe32plus, Subsystem);
+            dat2 = dat1 + len1 + sizeof(DWORD);
+        }
+        pecoff_append_range(pe, off1, len1, dat1, "Win-specific COFF, minus Checksum");
+        pecoff_append_range(pe, off2, len2, dat2, "Win-specific COFF, minus Checksum");
+        // Image Data Directories, excluding CertificateTable
+        off1 = pe->iddc.fileOffset;
+        len1 = OFFSET_OF(pe->iddc.dd, CertificateTable);
+        dat1 = (BYTE *)pe->iddc.dd;
+        off2 = off1 + len1 + sizeof(data_directory_entry_t);
+        len2 = sizeof(pe32plus_coff_fields_t) - OFFSET_OF(pe->pecfc.pe32plus, Subsystem);
+        len2 = pe->NumberOfRvaAndSizes * sizeof(data_directory_entry_t);
+        len2 -= OFFSET_OF(pe->iddc.dd, BaseRelocationTable);
+        dat2 = dat1 + len1 + sizeof(data_directory_entry_t);
+        pecoff_append_range(pe, off1, len1, dat1, "Data Directory, minus CertificateTable");
+        pecoff_append_range(pe, off2, len2, dat2, "Data Directory, minus CertificateTable");
+        // Section Headers - are to be sorted according to PointerToRawData
+        // FIX!!! this code does not properly sort the list of section headers
+        SUM_OF_BYTES_HASHED = is_pe32() ? pe->pecfc.pe32->SizeOfHeaders : pe->pecfc.pe32plus->SizeOfHeaders;
+        DLCL_FOR_EACH(pecoff_section_ct, pe->sections, sc, next, prev)
+        {
+            s = sc->s;
+            pecoff_append_range(pe, sc->fileOffset, sizeof(pecoff_section_t), (BYTE *)s, "SectionHeader");
+            if (s->SizeOfRawData)
+            {
+//              PRINTK(LABEL "\n", s->Name);
+                pecoff_append_range(pe, s->PointerToRawData, s->SizeOfRawData, sc->data, "SectionContent");
+                SUM_OF_BYTES_HASHED += s->SizeOfRawData;
+                StartOfRawData = min(s->PointerToRawData, StartOfRawData);
+                EndOfRawData = max(s->PointerToRawData + s->SizeOfRawData, StartOfRawData);
+            }
+        }
+        EndOfImageHeader = pe->SectionHeaderBase + (pe->chc.ch->NumberOfSections * sizeof(pecoff_section_t));
+//      PRINTK("End of Image Hedr: %08X\n", EndOfImageHeader);
+//      PRINTK("Start of Raw Data: %08X\n", StartOfRawData);
+        pe->offset = EndOfImageHeader;
+        buf = mkptr(BYTE);
+        pecoff_append_range(pe, EndOfImageHeader, StartOfRawData - EndOfImageHeader, buf, "Padding after Header to Raw Data");
+
+        // The start of raw data officially ends the image header
+        FILE_SIZE = pe->imageSize;
+        EXTRA = FILE_SIZE - ((pe->iddc.dd->CertificateTable.Size) + SUM_OF_BYTES_HASHED);
+        PRINTK("FILE_SIZE %u(%x) SOBH %u EXTRA %u\n", FILE_SIZE, FILE_SIZE, SUM_OF_BYTES_HASHED, EXTRA);
+        if (EXTRA)
+        {
+            // FIX??? Not clear if should be sorted (spec only describes sorting sections)
+            BYTE *buf;
+            pe->offset = EndOfRawData;
+            buf = mkptr(BYTE);
+            pecoff_append_range(pe, EndOfRawData, EXTRA, buf, "Extra");
+        }
+
+        // FIX!!! Must sort sections according to file offset
+        // Simple brute force linear sort
+        do
+        {
+            sorted = 1;
+            DLCL_FOR_EACH(range_t, pe->ranges, range, next, prev)
+            {
+                if ((range->next != pe->ranges) && (range->offset > range->next->offset))
+                {
+                    DLCL_REMOVE(range_t, pe->ranges, range);
+                    DLCL_APPEND(range_t, pe->ranges, range);
+                    sorted = 0;
+                    //break; - safe to continue to traverse list
+                }
+            }
+        } while (!sorted);
+
+#if 0
+        // Now output signature byte stream
+        {
+            range_t *range;
+            range_t *prevRange = NULL;
+            DLCL_FOR_EACH(range_t, pe->ranges, range, next, prev)
+            {
+                if (prevRange)
+                {
+                    if ((prevRange->offset + prevRange->length) != range->offset)
+                        PRINTK("Warning: not consecutive!\n");
+                }
+                PRINTK("digesting %x + %x (%x) : %s\n", range->offset, range->length, range->offset + range->length, range->description);
+                prevRange = range;
+            }
+        }
+#endif
+    }
+}
+
+/********************************************************************/
+
diff --git a/xen/common/ped.h b/xen/common/ped.h
new file mode 100644
index 0000000..5b4121f
--- /dev/null
+++ b/xen/common/ped.h
@@ -0,0 +1,128 @@
+
+#ifndef PED_H
+
+/********************************************************************/
+
+#ifndef __XEN__
+#define ztalloc(TYPE, SIZE) (TYPE *)calloc( 1, SIZE )
+#define zsalloc(TYPE) ztalloc(TYPE, sizeof(TYPE) )
+#define zsfree(P) free(P)
+#include <stdint.h>
+#define PRINTK(FMT...) printf(FMT)
+
+#else
+#define zsalloc(TYPE) xzalloc_array(TYPE, 1)
+#define zsfree(P) xfree(P)
+#include <xen/types.h>
+#define PRINTK(FMT...) printk(FMT)
+
+#endif
+
+//#define malloc MALLOC_DO_NOT_USE
+//#define free FREE_DO_NOT_USE
+
+#include "pecoff.h"
+
+/********************************************************************/
+struct pecoff_image_s;
+
+typedef struct range_s
+{
+    DWORD offset; // from file
+    DWORD length; // inclusive
+    BYTE *data; // to in-memory copy of file
+    const char *description; // for debug
+
+    struct range_s *next;
+    struct range_s *prev;
+} range_t;
+
+range_t *
+pecoff_append_range (struct pecoff_image_s *pe, DWORD offset, DWORD length, BYTE *data, const char *description);
+
+/********************************************************************/
+// NOTE: The _cs means container struct, as in it contains the first
+// member plus items related to it that I need in the code
+typedef struct dos_header_cs
+{
+    dos_header_t *dh;
+    BYTE *ds;
+    DWORD fileOffset;
+} dos_header_ct;
+
+typedef struct coff_header_cs
+{
+    coff_header_t *ch;
+    DWORD fileOffset;
+} coff_header_ct;
+
+typedef struct coff_fields_cs
+{
+    coff_fields_t *cf;
+#define is_pe32() (IMAGE_MAGIC_PE32 == pe->cfc.cf->Magic)
+    DWORD fileOffset;
+} coff_fields_ct;
+
+typedef struct pe_coff_fields_cs
+{
+    pe32_coff_fields_t *pe32;
+    pe32plus_coff_fields_t *pe32plus;
+    DWORD fileOffset;
+} pe_coff_fields_ct;
+
+typedef struct image_data_directory_cs
+{
+    image_data_directory_t *dd;
+    DWORD fileOffset;
+} image_data_directory_ct;
+
+typedef struct pecoff_section_cs
+{
+    pecoff_section_t *s;
+    BYTE *data;
+    DWORD fileOffset;
+    struct pecoff_section_cs *next, *prev;
+} pecoff_section_ct;
+
+typedef struct attribute_certificate_cs
+{
+    attribute_certificate_t *ac;
+    BYTE *data;
+} attribute_certificate_ct;
+
+typedef struct pecoff_image_s
+{
+    // For managing parse/decode
+    uint8_t *imageBase;
+    size_t imageSize;
+    size_t offset;
+
+    dos_header_ct dhc;
+    coff_header_ct chc;
+    coff_fields_ct cfc;
+    pe_coff_fields_ct pecfc;
+    image_data_directory_ct iddc;
+#ifndef PECOFF_MAX_SECTIONS
+#define PECOFF_MAX_SECTIONS 32
+#endif
+    pecoff_section_ct sectioncs[PECOFF_MAX_SECTIONS];
+    attribute_certificate_ct cert;
+
+    DWORD SectionHeaderBase;
+
+    // for hash computation/verification
+    range_t *ranges;
+    DWORD NumberOfRvaAndSizes;
+    pecoff_section_ct *sections;
+
+
+} pecoff_image_t;
+
+pecoff_image_t * pecoff_image_alloc (uint8_t *imageBase, size_t imageSize);
+void pecoff_image_free (pecoff_image_t *pe);
+
+pecoff_image_t * pecoff_image_decode (uint8_t *imageBase, size_t imageSize);
+void pecoff_setup_verify (pecoff_image_t *pe);
+
+#endif // PED_H
+
diff --git a/xen/common/v_openssl.c b/xen/common/v_openssl.c
new file mode 100644
index 0000000..9bcba2e
--- /dev/null
+++ b/xen/common/v_openssl.c
@@ -0,0 +1,1348 @@
+
+#ifdef __XEN__
+#define OPENSSL_1_1
+//#define OPENSSL_NO_FP_API
+//#define OPENSSL_NO_SCTP
+//#define OPENSSL_NO_BIO
+#include <stdlib.h>
+#include "ped.h"
+#include "dlcl.h"
+#define CopyMem(SRC,DEST,SIZE) memcpy((void *)DEST,(const void *)SRC,SIZE)
+#define PRINTK(FMT...) printk(FMT)
+#else
+#define PRINTK(FMT...) printf(FMT)
+#endif
+
+#define INT8 int8_t
+#define INT16 int16_t
+#define INT32 int32_t
+#define INT64 int64_t
+#define INTN signed long
+#define UINT8 uint8_t
+#define UINT16 uint16_t
+#define UINT32 uint32_t
+#define UINT64 uint64_t
+#define UINTN unsigned long
+#define BOOLEAN int
+#define EFIAPI
+#define CONST const
+#define IN
+#define OUT
+#ifndef FALSE
+#define FALSE 0
+#endif
+#ifndef TRUE
+#define TRUE 1
+#endif
+#define CompareMem(A,B,SIZE) memcmp(A,B,SIZE)
+#ifndef CopyMem
+#define CopyMem(SRC,DEST,SIZE) memcpy(DEST,SRC,SIZE)
+#endif
+#include <openssl/evp.h>
+#include <openssl/objects.h>
+#include <openssl/pkcs7.h>
+#include <openssl/x509.h>
+#include <openssl/x509v3.h>
+#include <openssl/cms.h>
+#include <openssl/err.h>
+
+//#ifndef OPENSSL_API_COMPAT
+//#define OPENSSL_API_COMPAT 0x10000000L
+//#endif
+//# if OPENSSL_API_COMPAT < 0x10100000L
+//# endif
+
+static int cert_in_store(X509 *cert, X509_STORE_CTX *ctx)
+{
+#ifndef OPENSSL_1_1
+    X509_OBJECT obj;
+
+    obj.type = X509_LU_X509;
+    obj.data.x509 = cert;
+
+    return X509_OBJECT_retrieve_match(ctx->ctx->objs, &obj) != NULL;
+#else
+    X509_OBJECT *obj;
+    int rc = 0;
+    if ((obj = X509_OBJECT_new()) != NULL)
+    {
+        if (X509_OBJECT_set1_X509(obj, cert))
+        {
+            STACK_OF(X509_OBJECT) *objs;
+            objs = X509_STORE_get0_objects( X509_STORE_CTX_get0_store(ctx) );
+            rc = X509_OBJECT_retrieve_match(objs, obj) != NULL;
+        }
+        X509_OBJECT_free(obj);
+    }
+    return rc;
+#endif
+}
+
+/** @file
+  PKCS#7 SignedData Verification Wrapper Implementation over OpenSSL.
+
+  Caution: This module requires additional review when modified.
+  This library will have external input - signature (e.g. UEFI Authenticated
+  Variable). It may by input in SMM mode.
+  This external input must be validated carefully to avoid security issue like
+  buffer overflow, integer overflow.
+
+  WrapPkcs7Data(), Pkcs7GetSigners(), Pkcs7Verify() will get UEFI Authenticated
+  Variable and will do basic check for data structure.
+
+Copyright (c) 2009 - 2012, Intel Corporation. All rights reserved.<BR>
+This program and the accompanying materials
+are licensed and made available under the terms and conditions of the BSD License
+which accompanies this distribution.  The full text of the license may be found at
+http://opensource.org/licenses/bsd-license.php
+
+THE PROGRAM IS DISTRIBUTED UNDER THE BSD LICENSE ON AN "AS IS" BASIS,
+WITHOUT WARRANTIES OR REPRESENTATIONS OF ANY KIND, EITHER EXPRESS OR IMPLIED.
+
+**/
+/*
+#include "InternalCryptLib.h"
+
+#include <openssl/objects.h>
+#include <openssl/x509.h>
+#include <openssl/pkcs7.h>
+#include <limits.h>
+*/
+UINT8 mOidValue[9] = { 0x2A, 0x86, 0x48, 0x86, 0xF7, 0x0D, 0x01, 0x07, 0x02 };
+
+/**
+  Verification callback function to override any existing callbacks in OpenSSL
+  for intermediate certificate supports.
+
+  @param[in]  Status   Original status before calling this callback.
+  @param[in]  Context  X509 store context.
+
+  @retval     1        Current X509 certificate is verified successfully.
+  @retval     0        Verification failed.
+
+**/
+int
+X509VerifyCb (
+  IN int            Status,
+  IN X509_STORE_CTX *Context
+  )
+{
+#if 0
+  X509_OBJECT  *Obj;
+  INTN         Error;
+  INTN         Index;
+  INTN         Count;
+
+  Obj   = NULL;
+  Error = (INTN) X509_STORE_CTX_get_error (Context);
+
+  //
+  // X509_V_ERR_UNABLE_TO_GET_ISSUER_CERT and X509_V_ERR_UNABLE_TO_GET_ISSUER_
+  // CERT_LOCALLY mean a X509 certificate is not self signed and its issuer
+  // can not be found in X509_verify_cert of X509_vfy.c.
+  // In order to support intermediate certificate node, we override the
+  // errors if the certification is obtained from X509 store, i.e. it is
+  // a trusted ceritifcate node that is enrolled by user.
+  // Besides,X509_V_ERR_CERT_UNTRUSTED and X509_V_ERR_UNABLE_TO_VERIFY_LEAF_SIGNATURE
+  // are also ignored to enable such feature.
+  //
+  if ((Error == X509_V_ERR_UNABLE_TO_GET_ISSUER_CERT) ||
+      (Error == X509_V_ERR_UNABLE_TO_GET_ISSUER_CERT_LOCALLY)) {
+    Obj = (X509_OBJECT *) malloc (sizeof (X509_OBJECT));
+    if (Obj == NULL) {
+      return 0;
+    }
+
+    Obj->type      = X509_LU_X509;
+    Obj->data.x509 = Context->current_cert;
+
+    CRYPTO_w_lock (CRYPTO_LOCK_X509_STORE);
+
+    if (X509_OBJECT_retrieve_match (Context->ctx->objs, Obj)) {
+      Status = 1;
+    } else {
+      //
+      // If any certificate in the chain is enrolled as trusted certificate,
+      // pass the certificate verification.
+      //
+      if (Error == X509_V_ERR_UNABLE_TO_GET_ISSUER_CERT_LOCALLY) {
+        Count = (INTN) sk_X509_num (Context->chain);
+        for (Index = 0; Index < Count; Index++) {
+          Obj->data.x509 = sk_X509_value (Context->chain, (int) Index);
+          if (X509_OBJECT_retrieve_match (Context->ctx->objs, Obj)) {
+            Status = 1;
+            break;
+          }
+        }
+      }
+    }
+
+    CRYPTO_w_unlock (CRYPTO_LOCK_X509_STORE);
+  }
+
+  if ((Error == X509_V_ERR_CERT_UNTRUSTED) ||
+      (Error == X509_V_ERR_UNABLE_TO_VERIFY_LEAF_SIGNATURE)) {
+    Status = 1;
+  }
+
+  if (Obj != NULL) {
+    OPENSSL_free (Obj);
+  }
+#else
+    int err = X509_STORE_CTX_get_error(Context);
+#ifdef OPENSSL_1_1
+    X509 *cert = X509_STORE_CTX_get0_cert(Context);
+    uint32_t ex_xkusage = X509_get_extended_key_usage(cert);
+#endif
+    /* also accept code-signing keys */
+    if (err == X509_V_ERR_INVALID_PURPOSE
+#ifndef OPENSSL_1_1
+            && Context->cert->ex_xkusage == XKU_CODE_SIGN
+#else
+            && ex_xkusage == XKU_CODE_SIGN
+#endif
+        )
+        Status = 1;
+
+    /* all certs given with the --cert argument are trusted */
+    else if (err == X509_V_ERR_UNABLE_TO_GET_ISSUER_CERT_LOCALLY ||
+            err == X509_V_ERR_UNABLE_TO_GET_ISSUER_CERT ||
+            err == X509_V_ERR_CERT_UNTRUSTED) {
+#ifndef OPENSSL_1_1
+        if (cert_in_store(Context->current_cert, Context))
+#else
+        if (cert_in_store(X509_STORE_CTX_get_current_cert(Context), Context))
+#endif
+            Status = 1;
+    }
+    /* UEFI doesn't care about expired signatures, so we shouldn't either. */
+    else if (err == X509_V_ERR_CERT_HAS_EXPIRED ||
+            err == X509_V_ERR_ERROR_IN_CERT_NOT_BEFORE_FIELD ||
+            err == X509_V_ERR_CERT_NOT_YET_VALID ||
+            err == X509_V_ERR_ERROR_IN_CERT_NOT_AFTER_FIELD) {
+        Status = 1;
+    }
+#endif
+    return Status;
+}
+
+/**
+  Creates a PKCS#7 signedData as described in "PKCS #7: Cryptographic Message
+  Syntax Standard, version 1.5". This interface is only intended to be used for
+  application to perform PKCS#7 functionality validation.
+
+  @param[in]  PrivateKey       Pointer to the PEM-formatted private key data for
+                               data signing.
+  @param[in]  PrivateKeySize   Size of the PEM private key data in bytes.
+  @param[in]  KeyPassword      NULL-terminated passphrase used for encrypted PEM
+                               key data.
+  @param[in]  InData           Pointer to the content to be signed.
+  @param[in]  InDataSize       Size of InData in bytes.
+  @param[in]  SignCert         Pointer to signer's DER-encoded certificate to sign with.
+  @param[in]  OtherCerts       Pointer to an optional additional set of certificates to
+                               include in the PKCS#7 signedData (e.g. any intermediate
+                               CAs in the chain).
+  @param[out] SignedData       Pointer to output PKCS#7 signedData.
+  @param[out] SignedDataSize   Size of SignedData in bytes.
+
+  @retval     TRUE             PKCS#7 data signing succeeded.
+  @retval     FALSE            PKCS#7 data signing failed.
+
+**/
+#if 0
+BOOLEAN
+EFIAPI
+Pkcs7Sign (
+  IN   CONST UINT8  *PrivateKey,
+  IN   UINTN        PrivateKeySize,
+  IN   CONST UINT8  *KeyPassword,
+  IN   UINT8        *InData,
+  IN   UINTN        InDataSize,
+  IN   UINT8        *SignCert,
+  IN   UINT8        *OtherCerts      OPTIONAL,
+  OUT  UINT8        **SignedData,
+  OUT  UINTN        *SignedDataSize
+  )
+{
+  BOOLEAN   Status;
+  EVP_PKEY  *Key;
+  BIO       *DataBio;
+  PKCS7     *Pkcs7;
+  UINT8     *RsaContext;
+  UINT8     *P7Data;
+  UINTN     P7DataSize;
+  UINT8     *Tmp;
+
+  //
+  // Check input parameters.
+  //
+  if (PrivateKey == NULL || KeyPassword == NULL || InData == NULL ||
+    SignCert == NULL || SignedData == NULL || SignedDataSize == NULL || InDataSize > INT_MAX) {
+    return FALSE;
+  }
+
+  RsaContext = NULL;
+  Key        = NULL;
+  Pkcs7      = NULL;
+  DataBio    = NULL;
+  Status     = FALSE;
+
+  //
+  // Retrieve RSA private key from PEM data.
+  //
+  Status = RsaGetPrivateKeyFromPem (
+             PrivateKey,
+             PrivateKeySize,
+             (CONST CHAR8 *) KeyPassword,
+             (VOID **) &RsaContext
+             );
+  if (!Status) {
+    return Status;
+  }
+
+  //
+  // Register & Initialize necessary digest algorithms and PRNG for PKCS#7 Handling
+  //
+  EVP_add_digest (EVP_md5());
+  EVP_add_digest (EVP_sha1());
+  EVP_add_digest (EVP_sha256());
+  RandomSeed (NULL, 0);
+
+  //
+  // Construct OpenSSL EVP_PKEY for private key.
+  //
+  Key = EVP_PKEY_new ();
+  if (Key == NULL) {
+    Status = FALSE;
+    goto _Exit;
+  }
+  Key->save_type = EVP_PKEY_RSA;
+  Key->type      = EVP_PKEY_type (EVP_PKEY_RSA);
+  Key->pkey.rsa  = (RSA *) RsaContext;
+
+  //
+  // Convert the data to be signed to BIO format. 
+  //
+  DataBio = BIO_new (BIO_s_mem ());
+  BIO_write (DataBio, InData, (int) InDataSize);
+
+  //
+  // Create the PKCS#7 signedData structure.
+  //
+  Pkcs7 = PKCS7_sign (
+            (X509 *) SignCert,
+            Key,
+            (STACK_OF(X509) *) OtherCerts,
+            DataBio,
+            PKCS7_BINARY | PKCS7_NOATTR | PKCS7_DETACHED
+            );
+  if (Pkcs7 == NULL) {
+    Status = FALSE;
+    goto _Exit;
+  }
+
+  //
+  // Convert PKCS#7 signedData structure into DER-encoded buffer.
+  //
+  P7DataSize = i2d_PKCS7 (Pkcs7, NULL);
+  if (P7DataSize <= 19) {
+    Status = FALSE;
+    goto _Exit;
+  }
+
+  P7Data     = malloc (P7DataSize);
+  if (P7Data == NULL) {
+    Status = FALSE;
+    goto _Exit;
+  }
+
+  Tmp        = P7Data;
+  P7DataSize = i2d_PKCS7 (Pkcs7, (unsigned char **) &Tmp);
+
+  //
+  // Strip ContentInfo to content only for signeddata. The data be trimmed off
+  // is totally 19 bytes.
+  //
+  *SignedDataSize = P7DataSize - 19;
+  *SignedData     = malloc (*SignedDataSize);
+  if (*SignedData == NULL) {
+    Status = FALSE;
+    OPENSSL_free (P7Data);
+    goto _Exit;
+  }
+
+  CopyMem (*SignedData, P7Data + 19, *SignedDataSize);
+  
+  OPENSSL_free (P7Data);
+
+  Status = TRUE;
+
+_Exit:
+  //
+  // Release Resources
+  //
+  if (RsaContext != NULL) {
+    RsaFree (RsaContext);
+    if (Key != NULL) {
+      Key->pkey.rsa = NULL;
+    }
+  }
+
+  if (Key != NULL) {
+    EVP_PKEY_free (Key);
+  }
+
+  if (DataBio != NULL) {
+    BIO_free (DataBio);
+  }
+
+  if (Pkcs7 != NULL) {
+    PKCS7_free (Pkcs7);
+  }
+
+  return Status;
+}
+#endif
+
+/**
+  Check input P7Data is a wrapped ContentInfo structure or not. If not construct
+  a new structure to wrap P7Data.
+
+  Caution: This function may receive untrusted input.
+  UEFI Authenticated Variable is external input, so this function will do basic
+  check for PKCS#7 data structure.
+
+  @param[in]  P7Data       Pointer to the PKCS#7 message to verify.
+  @param[in]  P7Length     Length of the PKCS#7 message in bytes.
+  @param[out] WrapFlag     If TRUE P7Data is a ContentInfo structure, otherwise
+                           return FALSE.
+  @param[out] WrapData     If return status of this function is TRUE: 
+                           1) when WrapFlag is TRUE, pointer to P7Data.
+                           2) when WrapFlag is FALSE, pointer to a new ContentInfo
+                           structure. It's caller's responsibility to free this
+                           buffer.
+  @param[out] WrapDataSize Length of ContentInfo structure in bytes.
+
+  @retval     TRUE         The operation is finished successfully.
+  @retval     FALSE        The operation is failed due to lack of resources.
+
+**/
+BOOLEAN
+WrapPkcs7Data (
+  IN  CONST UINT8  *P7Data,
+  IN  UINTN        P7Length,
+  OUT BOOLEAN      *WrapFlag,
+  OUT UINT8        **WrapData,
+  OUT UINTN        *WrapDataSize
+  )
+{
+  BOOLEAN          Wrapped;
+  UINT8            *SignedData;
+
+  //
+  // Check whether input P7Data is a wrapped ContentInfo structure or not.
+  //
+  Wrapped = FALSE;
+  if ((P7Data[4] == 0x06) && (P7Data[5] == 0x09)) {
+    if (CompareMem (P7Data + 6, mOidValue, sizeof (mOidValue)) == 0) {
+      if ((P7Data[15] == 0xA0) && (P7Data[16] == 0x82)) {
+        Wrapped = TRUE;
+      }
+    }
+  }
+
+  if (Wrapped) {
+    *WrapData     = (UINT8 *) P7Data;
+    *WrapDataSize = P7Length;
+  } else {
+    //
+    // Wrap PKCS#7 signeddata to a ContentInfo structure - add a header in 19 bytes.
+    //
+    *WrapDataSize = P7Length + 19;
+    *WrapData     = (UINT8 *)malloc (*WrapDataSize);
+    if (*WrapData == NULL) {
+      *WrapFlag = Wrapped;
+      return FALSE;
+    }
+
+    SignedData = *WrapData;
+
+    //
+    // Part1: 0x30, 0x82.
+    //
+    SignedData[0] = 0x30;
+    SignedData[1] = 0x82;
+
+    //
+    // Part2: Length1 = P7Length + 19 - 4, in big endian.
+    //
+    SignedData[2] = (UINT8) (((UINT16) (*WrapDataSize - 4)) >> 8);
+    SignedData[3] = (UINT8) (((UINT16) (*WrapDataSize - 4)) & 0xff);
+
+    //
+    // Part3: 0x06, 0x09.
+    //
+    SignedData[4] = 0x06;
+    SignedData[5] = 0x09;
+
+    //
+    // Part4: OID value -- 0x2A 0x86 0x48 0x86 0xF7 0x0D 0x01 0x07 0x02.
+    //
+    CopyMem (SignedData + 6, mOidValue, sizeof (mOidValue));
+
+    //
+    // Part5: 0xA0, 0x82.
+    //
+    SignedData[15] = 0xA0;
+    SignedData[16] = 0x82;
+
+    //
+    // Part6: Length2 = P7Length, in big endian.
+    //
+    SignedData[17] = (UINT8) (((UINT16) P7Length) >> 8);
+    SignedData[18] = (UINT8) (((UINT16) P7Length) & 0xff);
+
+    //
+    // Part7: P7Data.
+    //
+    CopyMem (SignedData + 19, P7Data, P7Length);
+  }
+
+  *WrapFlag = Wrapped;
+  return TRUE;
+}
+
+/**
+  Pop single certificate from STACK_OF(X509).
+
+  If X509Stack, Cert, or CertSize is NULL, then return FALSE.
+
+  @param[in]  X509Stack       Pointer to a X509 stack object.
+  @param[out] Cert            Pointer to a X509 certificate.
+  @param[out] CertSize        Length of output X509 certificate in bytes.
+                                 
+  @retval     TRUE            The X509 stack pop succeeded.
+  @retval     FALSE           The pop operation failed.
+
+**/
+#if 0
+BOOLEAN
+X509PopCertificate (
+  IN  VOID  *X509Stack,
+  OUT UINT8 **Cert,
+  OUT UINTN *CertSize
+  )
+{
+  BIO             *CertBio;
+  X509            *X509Cert;
+  STACK_OF(X509)  *CertStack;
+  BOOLEAN         Status;
+  INT32           Result;
+  INT32           Length;
+  VOID            *Buffer;
+
+  Status = FALSE;
+
+  if ((X509Stack == NULL) || (Cert == NULL) || (CertSize == NULL)) {
+    return Status;
+  }
+
+  CertStack = (STACK_OF(X509) *) X509Stack;
+
+  X509Cert = sk_X509_pop (CertStack);
+
+  if (X509Cert == NULL) {
+    return Status;
+  }
+
+  Buffer = NULL;
+
+  CertBio = BIO_new (BIO_s_mem ());
+  if (CertBio == NULL) {
+    return Status;
+  }
+
+  Result = i2d_X509_bio (CertBio, X509Cert);
+  if (Result == 0) {
+    goto _Exit;
+  }
+
+  Length = ((BUF_MEM *) CertBio->ptr)->length;
+  if (Length <= 0) {
+    goto _Exit;
+  }
+
+  Buffer = malloc (Length);
+  if (Buffer == NULL) {
+    goto _Exit;
+  }
+
+  Result = BIO_read (CertBio, Buffer, Length);
+  if (Result != Length) {
+    goto _Exit;
+  }
+
+  *Cert     = Buffer;
+  *CertSize = Length;
+
+  Status = TRUE;
+
+_Exit:
+
+  BIO_free (CertBio);
+
+  if (!Status && (Buffer != NULL)) {
+    free (Buffer);
+  }
+
+  return Status;
+}
+#endif
+
+/**
+  Get the signer's certificates from PKCS#7 signed data as described in "PKCS #7:
+  Cryptographic Message Syntax Standard". The input signed data could be wrapped
+  in a ContentInfo structure.
+
+  If P7Data, CertStack, StackLength, TrustedCert or CertLength is NULL, then
+  return FALSE. If P7Length overflow, then return FAlSE.
+
+  Caution: This function may receive untrusted input.
+  UEFI Authenticated Variable is external input, so this function will do basic
+  check for PKCS#7 data structure.
+
+  @param[in]  P7Data       Pointer to the PKCS#7 message to verify.
+  @param[in]  P7Length     Length of the PKCS#7 message in bytes.
+  @param[out] CertStack    Pointer to Signer's certificates retrieved from P7Data.
+                           It's caller's responsiblity to free the buffer.
+  @param[out] StackLength  Length of signer's certificates in bytes.
+  @param[out] TrustedCert  Pointer to a trusted certificate from Signer's certificates.
+                           It's caller's responsiblity to free the buffer.
+  @param[out] CertLength   Length of the trusted certificate in bytes.
+
+  @retval  TRUE            The operation is finished successfully.
+  @retval  FALSE           Error occurs during the operation.
+
+**/
+#if 0
+BOOLEAN
+EFIAPI
+Pkcs7GetSigners (
+  IN  CONST UINT8  *P7Data,
+  IN  UINTN        P7Length,
+  OUT UINT8        **CertStack,
+  OUT UINTN        *StackLength,
+  OUT UINT8        **TrustedCert,
+  OUT UINTN        *CertLength
+  )
+{
+  PKCS7            *Pkcs7;
+  BOOLEAN          Status;
+  UINT8            *SignedData;
+  UINT8            *Temp;
+  UINTN            SignedDataSize;
+  BOOLEAN          Wrapped;
+  STACK_OF(X509)   *Stack;
+  UINT8            Index;
+  UINT8            *CertBuf;
+  UINT8            *OldBuf;
+  UINTN            BufferSize;
+  UINTN            OldSize;
+  UINT8            *SingleCert;
+  UINTN            SingleCertSize;
+
+  if ((P7Data == NULL) || (CertStack == NULL) || (StackLength == NULL) ||
+      (TrustedCert == NULL) || (CertLength == NULL) || (P7Length > INT_MAX)) {
+    return FALSE;
+  }
+  
+  Status = WrapPkcs7Data (P7Data, P7Length, &Wrapped, &SignedData, &SignedDataSize);
+  if (!Status) {
+    return Status;
+  }
+
+  Status     = FALSE;
+  Pkcs7      = NULL;
+  Stack      = NULL;
+  CertBuf    = NULL;
+  OldBuf     = NULL;
+  SingleCert = NULL;
+
+  //
+  // Retrieve PKCS#7 Data (DER encoding)
+  //
+  if (SignedDataSize > INT_MAX) {
+    goto _Exit;
+  }
+
+  Temp = SignedData;
+  Pkcs7 = d2i_PKCS7 (NULL, (const unsigned char **) &Temp, (int) SignedDataSize);
+  if (Pkcs7 == NULL) {
+    goto _Exit;
+  }
+
+  //
+  // Check if it is PKCS#7 Signed Data (for Authenticode Scenario)
+  //
+  if (!PKCS7_type_is_signed (Pkcs7)) {
+    goto _Exit;
+  }
+
+  Stack = PKCS7_get0_signers(Pkcs7, NULL, PKCS7_BINARY);
+  if (Stack == NULL) {
+    goto _Exit;
+  }
+
+  //
+  // Convert CertStack to buffer in following format:
+  // UINT8  CertNumber;
+  // UINT32 Cert1Length;
+  // UINT8  Cert1[];
+  // UINT32 Cert2Length;
+  // UINT8  Cert2[];
+  // ...
+  // UINT32 CertnLength;
+  // UINT8  Certn[];
+  //
+  BufferSize = sizeof (UINT8);
+  OldSize    = BufferSize;
+  
+  for (Index = 0; ; Index++) {
+    Status = X509PopCertificate (Stack, &SingleCert, &SingleCertSize);
+    if (!Status) {
+      break;
+    }
+
+    OldSize    = BufferSize;
+    OldBuf     = CertBuf;
+    BufferSize = OldSize + SingleCertSize + sizeof (UINT32);
+    CertBuf    = malloc (BufferSize);
+
+    if (CertBuf == NULL) {
+      goto _Exit;
+    }
+
+    if (OldBuf != NULL) {
+      CopyMem (CertBuf, OldBuf, OldSize);
+      free (OldBuf);
+      OldBuf = NULL;
+    }
+
+    WriteUnaligned32 ((UINT32 *) (CertBuf + OldSize), (UINT32) SingleCertSize);
+    CopyMem (CertBuf + OldSize + sizeof (UINT32), SingleCert, SingleCertSize);
+
+    free (SingleCert);
+    SingleCert = NULL;
+  }
+
+  if (CertBuf != NULL) {
+    //
+    // Update CertNumber.
+    //
+    CertBuf[0] = Index;
+
+    *CertLength = BufferSize - OldSize - sizeof (UINT32);
+    *TrustedCert = malloc (*CertLength);
+    if (*TrustedCert == NULL) {
+      goto _Exit;
+    }
+
+    CopyMem (*TrustedCert, CertBuf + OldSize + sizeof (UINT32), *CertLength);
+    *CertStack   = CertBuf;
+    *StackLength = BufferSize;
+    Status = TRUE;
+  } 
+
+_Exit:
+  //
+  // Release Resources
+  //
+  if (!Wrapped) {
+    free (SignedData);
+  }
+
+  if (Pkcs7 != NULL) {
+    PKCS7_free (Pkcs7);
+  }
+
+  if (Stack != NULL) {
+    sk_X509_pop_free(Stack, X509_free);
+  }
+
+  if (SingleCert !=  NULL) {
+    free (SingleCert);
+  }
+
+  if (!Status && (CertBuf != NULL)) {
+    free (CertBuf);
+    *CertStack = NULL;
+  }
+
+  if (OldBuf != NULL) {
+    free (OldBuf);
+  }
+  
+  return Status;
+}
+#endif
+
+/**
+  Wrap function to use free() to free allocated memory for certificates.
+
+  @param[in]  Certs        Pointer to the certificates to be freed.
+
+**/
+#if 0
+VOID
+EFIAPI
+Pkcs7FreeSigners (
+  IN  UINT8        *Certs
+  )
+{
+  if (Certs == NULL) {
+    return;
+  }
+
+  free (Certs);
+}
+#endif
+
+/**
+  Verifies the validility of a PKCS#7 signed data as described in "PKCS #7:
+  Cryptographic Message Syntax Standard". The input signed data could be wrapped
+  in a ContentInfo structure.
+
+  If P7Data, TrustedCert or InData is NULL, then return FALSE.
+  If P7Length, CertLength or DataLength overflow, then return FAlSE.
+
+  Caution: This function may receive untrusted input.
+  UEFI Authenticated Variable is external input, so this function will do basic
+  check for PKCS#7 data structure.
+
+  @param[in]  P7Data       Pointer to the PKCS#7 message to verify.
+  @param[in]  P7Length     Length of the PKCS#7 message in bytes.
+  @param[in]  TrustedCert  Pointer to a trusted/root certificate encoded in DER, which
+                           is used for certificate chain verification.
+  @param[in]  CertLength   Length of the trusted certificate in bytes.
+  @param[in]  InData       Pointer to the content to be verified.
+  @param[in]  DataLength   Length of InData in bytes.
+
+  @retval  TRUE  The specified PKCS#7 signed data is valid.
+  @retval  FALSE Invalid PKCS#7 signed data.
+
+**/
+BOOLEAN
+EFIAPI
+Pkcs7Verify (
+  IN  CONST UINT8  *P7Data,
+  IN  UINTN        P7Length,
+  IN  CONST UINT8  *TrustedCert,
+  IN  UINTN        CertLength,
+  IN  CONST UINT8  *InData,
+  IN  UINTN        DataLength
+  )
+{
+  PKCS7       *Pkcs7;
+  BIO         *CertBio;
+  BIO         *DataBio;
+  BOOLEAN     Status;
+  X509        *Cert;
+  X509_STORE  *CertStore;
+  UINT8       *SignedData;
+  UINT8       *Temp;
+  UINTN       SignedDataSize;
+  BOOLEAN     Wrapped;
+
+  //
+  // Check input parameters.
+  //
+  if (P7Data == NULL || TrustedCert == NULL || InData == NULL || 
+    P7Length > INT_MAX || CertLength > INT_MAX || DataLength > INT_MAX) {
+    return FALSE;
+  }
+  
+  Pkcs7     = NULL;
+  CertBio   = NULL;
+  DataBio   = NULL;
+  Cert      = NULL;
+  CertStore = NULL;
+
+  //
+  // Register & Initialize necessary digest algorithms for PKCS#7 Handling
+  //
+  EVP_add_digest (EVP_md5());
+  EVP_add_digest (EVP_sha1());
+  EVP_add_digest_alias (SN_sha1WithRSAEncryption, SN_sha1WithRSA);
+  EVP_add_digest (EVP_sha256());
+
+  Status = WrapPkcs7Data (P7Data, P7Length, &Wrapped, &SignedData, &SignedDataSize);
+  if (!Status) {
+    return Status;
+  }
+
+  Status = FALSE;
+  
+  //
+  // Retrieve PKCS#7 Data (DER encoding)
+  //
+  if (SignedDataSize > INT_MAX) {
+    goto _Exit;
+  }
+
+  Temp = SignedData;
+  Pkcs7 = d2i_PKCS7 (NULL, (const unsigned char **) &Temp, (int) SignedDataSize);
+  if (Pkcs7 == NULL) {
+    goto _Exit;
+  }
+
+  //
+  // Check if it's PKCS#7 Signed Data (for Authenticode Scenario)
+  //
+  if (!PKCS7_type_is_signed (Pkcs7)) {
+    goto _Exit;
+  }
+
+  //
+  // Read DER-encoded root certificate and Construct X509 Certificate
+  //
+  CertBio = BIO_new (BIO_s_mem ());
+  BIO_write (CertBio, TrustedCert, (int)CertLength);
+  if (CertBio == NULL) {
+    goto _Exit;
+  }
+  Cert = d2i_X509_bio (CertBio, NULL);
+  if (Cert == NULL) {
+    goto _Exit;
+  }
+
+  //
+  // Setup X509 Store for trusted certificate
+  //
+  CertStore = X509_STORE_new ();
+  if (CertStore == NULL) {
+    goto _Exit;
+  }
+  if (!(X509_STORE_add_cert (CertStore, Cert))) {
+    goto _Exit;
+  }
+
+  //
+  // Register customized X509 verification callback function to support
+  // trusted intermediate certificate anchor.
+  //
+#ifndef OPENSSL_1_1
+  CertStore->verify_cb = X509VerifyCb;
+#else
+  X509_STORE_set_verify_cb(CertStore, X509VerifyCb);
+#endif
+
+
+  //
+  // For generic PKCS#7 handling, InData may be NULL if the content is present
+  // in PKCS#7 structure. So ignore NULL checking here.
+  //
+  DataBio = BIO_new (BIO_s_mem ());
+  BIO_write (DataBio, InData, (int)DataLength);
+
+  //
+  // Verifies the PKCS#7 signedData structure
+  //
+  Status = (BOOLEAN) PKCS7_verify (Pkcs7, NULL, CertStore, DataBio, NULL, PKCS7_BINARY);
+
+_Exit:
+  //
+  // Release Resources
+  //
+  BIO_free (DataBio);
+  BIO_free (CertBio);
+  X509_free (Cert);
+  X509_STORE_free (CertStore);
+  PKCS7_free (Pkcs7);
+
+  if (!Wrapped) {
+    OPENSSL_free (SignedData);
+  }
+
+  return Status;
+}
+
+/** @file
+  Authenticode Portable Executable Signature Verification over OpenSSL.
+
+  Caution: This module requires additional review when modified.
+  This library will have external input - signature (e.g. PE/COFF Authenticode).
+  This external input must be validated carefully to avoid security issue like
+  buffer overflow, integer overflow.
+
+  AuthenticodeVerify() will get PE/COFF Authenticode and will do basic check for
+  data structure.
+
+Copyright (c) 2011 - 2012, Intel Corporation. All rights reserved.<BR>
+This program and the accompanying materials
+are licensed and made available under the terms and conditions of the BSD License
+which accompanies this distribution.  The full text of the license may be found at
+http://opensource.org/licenses/bsd-license.php
+
+THE PROGRAM IS DISTRIBUTED UNDER THE BSD LICENSE ON AN "AS IS" BASIS,
+WITHOUT WARRANTIES OR REPRESENTATIONS OF ANY KIND, EITHER EXPRESS OR IMPLIED.
+
+**/
+
+//#include "InternalCryptLib.h"
+
+#include <openssl/objects.h>
+#include <openssl/x509.h>
+#include <openssl/pkcs7.h>
+
+#include <limits.h>
+//
+// OID ASN.1 Value for SPC_INDIRECT_DATA_OBJID
+//
+UINT8 mSpcIndirectOidValue[] = {
+  0x2B, 0x06, 0x01, 0x04, 0x01, 0x82, 0x37, 0x02, 0x01, 0x04
+  };
+
+/**
+  Verifies the validility of a PE/COFF Authenticode Signature as described in "Windows
+  Authenticode Portable Executable Signature Format".
+
+  If AuthData is NULL, then return FALSE.
+  If ImageHash is NULL, then return FALSE.
+
+  Caution: This function may receive untrusted input.
+  PE/COFF Authenticode is external input, so this function will do basic check for
+  Authenticode data structure.
+
+  @param[in]  AuthData     Pointer to the Authenticode Signature retrieved from signed
+                           PE/COFF image to be verified.
+  @param[in]  DataSize     Size of the Authenticode Signature in bytes.
+  @param[in]  TrustedCert  Pointer to a trusted/root certificate encoded in DER, which
+                           is used for certificate chain verification.
+  @param[in]  CertSize     Size of the trusted certificate in bytes.
+  @param[in]  ImageHash    Pointer to the original image file hash value. The procudure
+                           for calculating the image hash value is described in Authenticode
+                           specification.
+  @param[in]  HashSize     Size of Image hash value in bytes.
+
+  @retval  TRUE   The specified Authenticode Signature is valid.
+  @retval  FALSE  Invalid Authenticode Signature.
+
+**/
+BOOLEAN
+EFIAPI
+AuthenticodeVerify (
+  IN  CONST UINT8  *AuthData,
+  IN  UINTN        DataSize,
+  IN  CONST UINT8  *TrustedCert,
+  IN  UINTN        CertSize,
+  IN  CONST UINT8  *ImageHash,
+  IN  UINTN        HashSize
+  )
+{
+  BOOLEAN      Status;
+  PKCS7        *Pkcs7;
+  CONST UINT8  *OrigAuthData;
+  UINT8        *SpcIndirectDataContent;
+  UINT8        Asn1Byte;
+  UINTN        ContentSize;
+/*  UINT8        *SpcIndirectDataOid; */
+unsigned i;
+
+  //
+  // Check input parameters.
+  //
+  if ((AuthData == NULL) || (TrustedCert == NULL) || (ImageHash == NULL)) {
+    return FALSE;
+  }
+
+  if ((DataSize > INT_MAX) || (CertSize > INT_MAX) || (HashSize > INT_MAX)) {
+    return FALSE;
+  }
+
+  Status       = FALSE;
+  Pkcs7        = NULL;
+  OrigAuthData = AuthData;
+
+  //
+  // Retrieve & Parse PKCS#7 Data (DER encoding) from Authenticode Signature
+  //
+  Pkcs7 = d2i_PKCS7 (NULL, &AuthData, (int)DataSize);
+  if (Pkcs7 == NULL) {
+    goto _Exit;
+  }
+
+  //
+  // Check if it's PKCS#7 Signed Data (for Authenticode Scenario)
+  //
+  if (!PKCS7_type_is_signed (Pkcs7)) {
+    goto _Exit;
+  }
+
+#if 0 // FIX!!! this needs to be revisited
+  //
+  // NOTE: OpenSSL PKCS7 Decoder didn't work for Authenticode-format signed data due to
+  //       some authenticode-specific structure. Use opaque ASN.1 string to retrieve
+  //       PKCS#7 ContentInfo here.
+  //
+#ifndef OPENSSL_1_1
+  SpcIndirectDataOid = (UINT8 *)(Pkcs7->d.sign->contents->type->data);
+#else
+  SpcIndirectDataOid = (UINT8 *)ASN1_STRING_get0_data(Pkcs7->d.sign->contents->type);
+#endif
+PRINTK("SpcIndirectDataOid %p %p %08X\n", SpcIndirectDataOid, mSpcIndirectOidValue, OPENSSL_API_COMPAT);
+  if (CompareMem (
+        SpcIndirectDataOid,
+        mSpcIndirectOidValue,
+        sizeof (mSpcIndirectOidValue)
+        ) != 0) {
+    //
+    // Un-matched SPC_INDIRECT_DATA_OBJID.
+    //
+    goto _Exit;
+  }  
+#endif
+
+  SpcIndirectDataContent = (UINT8 *)(Pkcs7->d.sign->contents->d.other->value.asn1_string->data);
+
+  //
+  // Retrieve the SEQUENCE data size from ASN.1-encoded SpcIndirectDataContent.
+  //
+  Asn1Byte = *(SpcIndirectDataContent + 1);
+
+  if ((Asn1Byte & 0x80) == 0) {
+    //
+    // Short Form of Length Encoding
+    //
+    ContentSize = (UINTN) (Asn1Byte & 0x7F);
+    //
+    // Skip the SEQUENCE Tag;
+    //
+    SpcIndirectDataContent += 2;
+  } else if ((Asn1Byte & 0x82) == 0x82) {
+    //
+    // Long Form of Length Encoding, only support two bytes.
+    //
+    ContentSize  = (UINTN) (*(SpcIndirectDataContent + 2));
+    ContentSize = (ContentSize << 8) + (UINTN)(*(SpcIndirectDataContent + 3));
+    //
+    // Skip the SEQUENCE Tag;
+    //
+    SpcIndirectDataContent += 4;
+  } else {
+    goto _Exit;
+  }
+
+  //
+  // Compare the original file hash value to the digest retrieve from SpcIndirectDataContent
+  // defined in Authenticode
+  // NOTE: Need to double-check HashLength here!
+  //
+PRINTK("PKCS7 hash: "); for (i = 0; i < HashSize; ++i) PRINTK("%02X ", ImageHash[i]); PRINTK("\n");
+  if (CompareMem (SpcIndirectDataContent + ContentSize - HashSize, ImageHash, HashSize) != 0) {
+    //
+    // Un-matched PE/COFF Hash Value
+    //
+    goto _Exit;
+  }
+
+  //
+  // Verifies the PKCS#7 Signed Data in PE/COFF Authenticode Signature
+  //
+  Status = (BOOLEAN) Pkcs7Verify (OrigAuthData, DataSize, TrustedCert, CertSize, SpcIndirectDataContent, ContentSize);
+
+_Exit:
+  //
+  // Release Resources
+  //
+  PKCS7_free (Pkcs7);
+
+  return Status;
+}
+static const int cert_name_len = 160;
+
+#if 0
+static void print_signature_info(PKCS7 *p7)
+{
+    char subject_name[cert_name_len + 1], issuer_name[cert_name_len + 1];
+    PKCS7_SIGNER_INFO *si;
+    X509 *cert;
+    int i;
+
+    PRINTK("image signature issuers:\n");
+
+    for (i = 0; i < sk_PKCS7_SIGNER_INFO_num(p7->d.sign->signer_info);
+            i++) {
+        si = sk_PKCS7_SIGNER_INFO_value(p7->d.sign->signer_info, i);
+        X509_NAME_oneline(si->issuer_and_serial->issuer,
+                issuer_name, cert_name_len);
+        PRINTK(" - %s\n", issuer_name);
+    }
+
+    PRINTK("image signature certificates:\n");
+
+    for (i = 0; i < sk_X509_num(p7->d.sign->cert); i++) {
+        cert = sk_X509_value(p7->d.sign->cert, i);
+        X509_NAME_oneline(cert->cert_info->subject,
+                subject_name, cert_name_len);
+        X509_NAME_oneline(cert->cert_info->issuer,
+                issuer_name, cert_name_len);
+
+        PRINTK(" - subject: %s\n", subject_name);
+        PRINTK("   issuer:  %s\n", issuer_name);
+    }
+}
+static void print_certificate_store_certs(X509_STORE *certs)
+{
+    char subject_name[cert_name_len + 1], issuer_name[cert_name_len + 1];
+    X509_OBJECT *obj;
+    int i;
+
+    PRINTK("certificate store:\n");
+
+    for (i = 0; i < sk_X509_OBJECT_num(certs->objs); i++) {
+        obj = sk_X509_OBJECT_value(certs->objs, i);
+
+        if (obj->type != X509_LU_X509)
+            continue;
+
+        X509_NAME_oneline(obj->data.x509->cert_info->subject,
+                subject_name, cert_name_len);
+        X509_NAME_oneline(obj->data.x509->cert_info->issuer,
+                issuer_name, cert_name_len);
+
+        PRINTK(" - subject: %s\n", subject_name);
+        PRINTK("   issuer:  %s\n", issuer_name);
+    }
+}
+#endif
+
+int
+verify_openssl (pecoff_image_t *pe, const uint8_t *TrustedCert, int TrustedCertSize)
+{
+    // https://www.openssl.org/docs/manmaster/man3/EVP_DigestInit.html#EXAMPLE
+    range_t *range;
+    range_t *ranges = pe->ranges;
+    uint8_t answer[32];
+    unsigned answer_len;
+    unsigned k;
+    EVP_MD_CTX *mdctx;
+    const EVP_MD *md;
+    BOOLEAN Status = 0;
+
+    md = EVP_sha256();
+    if (NULL == md) {
+        PRINTK("Unknown message digest\n");
+        return 0;
+    }
+    mdctx = EVP_MD_CTX_create();
+    EVP_DigestInit_ex(mdctx, md, NULL);
+    DLCL_FOR_EACH(range_t, ranges, range, next, prev)
+    {
+    EVP_DigestUpdate(mdctx, range->data, range->length);
+    }
+    EVP_DigestFinal_ex(mdctx, answer, &answer_len);
+    for (k = 0; k < 32; ++k)
+        PRINTK("%02X ", answer[k]);
+    PRINTK("\n");
+    EVP_MD_CTX_destroy(mdctx);
+
+    if (TrustedCertSize)
+    {
+    Status =
+    AuthenticodeVerify (
+        pe->cert.data, // AuthData
+        pe->cert.ac->dwLength, // DataSize
+        TrustedCert,
+        TrustedCertSize,
+        answer, // ImageHash,
+        answer_len // HashSize
+        );
+    PRINTK("PKCS7 Status %d\n", Status);
+    /* ERR_print_errors_fp(stderr); */
+/*
+    unsigned long err;
+    const char *f;
+    int l;
+    err = ERR_peek_last_error_line(&f, &l);
+    PRINTK("PKCS7 Status err %ul 0x%lx : line %d %s\n", err, err, l, f);
+*/
+    }
+
+    return Status;
+}
+
+/*
+ Rather than another file full of glue code, just put it here
+*/
+#ifdef __XEN__
+#include <xenossl.h>
+time_t time (time_t *ts)
+{
+    (void)ts;
+    PRINTK("Not yet impl: time\n");
+    return (time_t)0x123456768;
+}
+
+void abort (void)
+{
+    PRINTK("Not yet impl: abort\n");
+    while(1);
+}
+
+void qsort (void *base, size_t nmemb, size_t size,
+    int (*compar)(const void *, const void *))
+{
+    (void)base;
+    (void)nmemb;
+    (void)size;
+    (void)compar;
+    PRINTK("Not yet impl: qsort\n");
+}
+
+int errno = 0;
+
+char *strerror (int errnum)
+{
+    (void)errnum;
+    PRINTK("Not yet impl: strerror\n");
+    return "strerr";
+}
+
+char *strncpy (char *dest, const char *src, size_t n)
+{
+    (void)src;
+    (void)n;
+    PRINTK("Not yet impl: strcpy\n");
+    return dest;
+}
+
+char *strcat (char *dest, const char *src)
+{
+    (void)src;
+    PRINTK("Not yet impl: strcat\n");
+    return dest;
+}
+
+uid_t getuid (void) { return (uid_t)0; }
+uid_t geteuid (void) { return (uid_t)0; }
+gid_t getgid (void) { return (gid_t)0; }
+gid_t getegid (void) { return (gid_t)0; }
+
+int sscanf (const char *str, const char *format, ...)
+{
+    (void)str;
+    (void)format;
+    PRINTK("Not yet impl: sscanf\n");
+    return 0;
+}
+
+int gettimeofday (struct timeval *tv, struct timezone *tz)
+{
+    (void)tv;
+    (void)tz;
+    PRINTK("Not yet impl: gettimeofday\n");
+    return 0;
+}
+
+#endif
+
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
