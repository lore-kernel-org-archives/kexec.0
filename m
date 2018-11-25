Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gQwBX-0007FS-OA
 for kexec@lists.infradead.org; Sun, 25 Nov 2018 15:19:01 +0000
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wAPFEWjM123032
 for <kexec@lists.infradead.org>; Sun, 25 Nov 2018 10:18:49 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2nymt4ekeu-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Sun, 25 Nov 2018 10:18:48 -0500
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <nayna@linux.ibm.com>;
 Sun, 25 Nov 2018 15:18:47 -0000
From: Nayna Jain <nayna@linux.ibm.com>
Subject: [PATCH 3/7] efi: Add EFI signature data types
Date: Sun, 25 Nov 2018 20:44:56 +0530
In-Reply-To: <20181125151500.8298-1-nayna@linux.ibm.com>
References: <20181125151500.8298-1-nayna@linux.ibm.com>
Message-Id: <20181125151500.8298-4-nayna@linux.ibm.com>
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
To: linux-integrity@vger.kernel.org
Cc: linux-efi@vger.kernel.org, mpe@ellerman.id.au, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, zohar@linux.ibm.com, dhowells@redhat.com, seth.forshee@canonical.com, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, ebiederm@xmission.com, jforbes@redhat.com, vgoyal@redhat.com

From: Dave Howells <dhowells@redhat.com>

Add the data types that are used for containing hashes, keys and
certificates for cryptographic verification along with their corresponding
type GUIDs.

Signed-off-by: David Howells <dhowells@redhat.com>
Acked-by: Nayna Jain <nayna@linux.ibm.com>
---
Changelog:

v0: 
- No changes

 include/linux/efi.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/include/linux/efi.h b/include/linux/efi.h
index 401e4b254e30..99cba6fe1234 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -663,6 +663,10 @@ void efi_native_runtime_setup(void);
 #define EFI_IMAGE_SECURITY_DATABASE_GUID	EFI_GUID(0xd719b2cb, 0x3d3a, 0x4596,  0xa3, 0xbc, 0xda, 0xd0, 0x0e, 0x67, 0x65, 0x6f)
 #define EFI_SHIM_LOCK_GUID			EFI_GUID(0x605dab50, 0xe046, 0x4300,  0xab, 0xb6, 0x3d, 0xd8, 0x10, 0xdd, 0x8b, 0x23)
 
+#define EFI_CERT_SHA256_GUID			EFI_GUID(0xc1c41626, 0x504c, 0x4092, 0xac, 0xa9, 0x41, 0xf9, 0x36, 0x93, 0x43, 0x28)
+#define EFI_CERT_X509_GUID			EFI_GUID(0xa5c059a1, 0x94e4, 0x4aa7, 0x87, 0xb5, 0xab, 0x15, 0x5c, 0x2b, 0xf0, 0x72)
+#define EFI_CERT_X509_SHA256_GUID		EFI_GUID(0x3bd2a492, 0x96c0, 0x4079, 0xb4, 0x20, 0xfc, 0xf9, 0x8e, 0xf1, 0x03, 0xed)
+
 /*
  * This GUID is used to pass to the kernel proper the struct screen_info
  * structure that was populated by the stub based on the GOP protocol instance
@@ -933,6 +937,27 @@ typedef struct {
 	efi_memory_desc_t entry[0];
 } efi_memory_attributes_table_t;
 
+typedef struct  {
+	efi_guid_t signature_owner;
+	u8 signature_data[];
+} efi_signature_data_t;
+
+typedef struct {
+	efi_guid_t signature_type;
+	u32 signature_list_size;
+	u32 signature_header_size;
+	u32 signature_size;
+	u8 signature_header[];
+	/* efi_signature_data_t signatures[][] */
+} efi_signature_list_t;
+
+typedef u8 efi_sha256_hash_t[32];
+
+typedef struct {
+	efi_sha256_hash_t to_be_signed_hash;
+	efi_time_t time_of_revocation;
+} efi_cert_x509_sha256_t;
+
 /*
  * All runtime access to EFI goes through this structure:
  */
-- 
2.13.6


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
