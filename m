Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVjG1-0002CH-9o
 for kexec@lists.infradead.org; Sat, 08 Dec 2018 20:31:27 +0000
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wB8KT9H8172275
 for <kexec@lists.infradead.org>; Sat, 8 Dec 2018 15:31:12 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2p88fbwmkg-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Sat, 08 Dec 2018 15:31:12 -0500
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <nayna@linux.ibm.com>;
 Sat, 8 Dec 2018 20:31:10 -0000
From: Nayna Jain <nayna@linux.ibm.com>
Subject: [PATCH v2 6/7] efi: Allow the "db" UEFI variable to be suppressed
Date: Sun,  9 Dec 2018 01:57:04 +0530
In-Reply-To: <20181208202705.18673-1-nayna@linux.ibm.com>
References: <20181208202705.18673-1-nayna@linux.ibm.com>
Message-Id: <20181208202705.18673-7-nayna@linux.ibm.com>
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
Cc: linux-efi@vger.kernel.org, mpe@ellerman.id.au, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, zohar@linux.ibm.com, dhowells@redhat.com, seth.forshee@canonical.com, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, ebiederm@xmission.com, jforbes@redhat.com, Josh Boyer <jwboyer@fedoraproject.org>, vgoyal@redhat.com

From: Josh Boyer <jwboyer@fedoraproject.org>

If a user tells shim to not use the certs/hashes in the UEFI db variable
for verification purposes, shim will set a UEFI variable called
MokIgnoreDB. Have the uefi import code look for this and ignore the db
variable if it is found.

Signed-off-by: Josh Boyer <jwboyer@fedoraproject.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Acked-by: Nayna Jain <nayna@linux.ibm.com>
Acked-by: Serge Hallyn <serge@hallyn.com>
---
Changelog:

v0:
- No changes

v2:
- Fixed the checkpatch.pl warnings

 security/integrity/platform_certs/load_uefi.c | 45 +++++++++++++++++++++------
 1 file changed, 35 insertions(+), 10 deletions(-)

diff --git a/security/integrity/platform_certs/load_uefi.c b/security/integrity/platform_certs/load_uefi.c
index acd9db90dde7..8bd2e9b421e1 100644
--- a/security/integrity/platform_certs/load_uefi.c
+++ b/security/integrity/platform_certs/load_uefi.c
@@ -16,6 +16,26 @@ static efi_guid_t efi_cert_x509_sha256_guid __initdata =
 static efi_guid_t efi_cert_sha256_guid __initdata = EFI_CERT_SHA256_GUID;
 
 /*
+ * Look to see if a UEFI variable called MokIgnoreDB exists and return true if
+ * it does.
+ *
+ * This UEFI variable is set by the shim if a user tells the shim to not use
+ * the certs/hashes in the UEFI db variable for verification purposes.  If it
+ * is set, we should ignore the db variable also and the true return indicates
+ * this.
+ */
+static __init bool uefi_check_ignore_db(void)
+{
+	efi_status_t status;
+	unsigned int db = 0;
+	unsigned long size = sizeof(db);
+	efi_guid_t guid = EFI_SHIM_LOCK_GUID;
+
+	status = efi.get_variable(L"MokIgnoreDB", &guid, NULL, &size, &db);
+	return status == EFI_SUCCESS;
+}
+
+/*
  * Get a certificate list blob from the named EFI variable.
  */
 static __init void *get_cert_list(efi_char16_t *name, efi_guid_t *guid,
@@ -116,7 +136,9 @@ static __init efi_element_handler_t get_handler_for_dbx(const efi_guid_t *
 }
 
 /*
- * Load the certs contained in the UEFI databases
+ * Load the certs contained in the UEFI databases into the secondary trusted
+ * keyring and the UEFI blacklisted X.509 cert SHA256 hashes into the blacklist
+ * keyring.
  */
 static int __init load_uefi_certs(void)
 {
@@ -132,15 +154,18 @@ static int __init load_uefi_certs(void)
 	/* Get db, MokListRT, and dbx.  They might not exist, so it isn't
 	 * an error if we can't get them.
 	 */
-	db = get_cert_list(L"db", &secure_var, &dbsize);
-	if (!db) {
-		pr_err("Couldn't get UEFI db list\n");
-	} else {
-		rc = parse_efi_signature_list("UEFI:db",
-					      db, dbsize, get_handler_for_db);
-		if (rc)
-			pr_err("Couldn't parse db signatures: %d\n", rc);
-		kfree(db);
+	if (!uefi_check_ignore_db()) {
+		db = get_cert_list(L"db", &secure_var, &dbsize);
+		if (!db) {
+			pr_err("MODSIGN: Couldn't get UEFI db list\n");
+		} else {
+			rc = parse_efi_signature_list("UEFI:db",
+					db, dbsize, get_handler_for_db);
+			if (rc)
+				pr_err("Couldn't parse db signatures: %d\n",
+				       rc);
+			kfree(db);
+		}
 	}
 
 	mok = get_cert_list(L"MokListRT", &mok_var, &moksize);
-- 
2.13.6


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
