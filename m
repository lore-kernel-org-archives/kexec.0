Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bkUp5-0001vE-T4
 for kexec@lists.infradead.org; Thu, 15 Sep 2016 11:27:21 +0000
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8FBNFvg104193
 for <kexec@lists.infradead.org>; Thu, 15 Sep 2016 07:27:00 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0b-001b2d01.pphosted.com with ESMTP id 25fnnxfcwx-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Thu, 15 Sep 2016 07:26:59 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Thu, 15 Sep 2016 21:26:55 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 64D6B3578058
 for <kexec@lists.infradead.org>; Thu, 15 Sep 2016 21:26:52 +1000 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8FBQq2s63963146
 for <kexec@lists.infradead.org>; Thu, 15 Sep 2016 21:26:52 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8FBQp3T008497
 for <kexec@lists.infradead.org>; Thu, 15 Sep 2016 21:26:52 +1000
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [PATCH v4 9/9] ima: platform-independent hash value
Date: Thu, 15 Sep 2016 07:26:11 -0400
In-Reply-To: <1473938771-2782-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1473938771-2782-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-Id: <1473938771-2782-10-git-send-email-zohar@linux.vnet.ibm.com>
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
To: linux-security-module <linux-security-module@vger.kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, Andreas Steffen <andreas.steffen@strongswan.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, "Eric W. Biederman" <ebiederm@xmission.com>, linux-ima-devel@lists.sourceforge.net, Andrew Morton <akpm@linux-foundation.org>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Dave Young <dyoung@redhat.com>

From: Andreas Steffen <andreas.steffen@strongswan.org>

For remote attestion it is important for the ima measurement values
to be platform-independent. Therefore integer fields to be hashed
must be converted to canonical format.

Changelog:
- Define canonical format as little endian (Mimi)

Signed-off-by: Andreas Steffen <andreas.steffen@strongswan.org>
Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 security/integrity/ima/ima_crypto.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
index 38f2ed8..802d5d2 100644
--- a/security/integrity/ima/ima_crypto.c
+++ b/security/integrity/ima/ima_crypto.c
@@ -477,11 +477,13 @@ static int ima_calc_field_array_hash_tfm(struct ima_field_data *field_data,
 		u8 buffer[IMA_EVENT_NAME_LEN_MAX + 1] = { 0 };
 		u8 *data_to_hash = field_data[i].data;
 		u32 datalen = field_data[i].len;
+		u32 datalen_to_hash =
+		    !ima_canonical_fmt ? datalen : cpu_to_le32(datalen);
 
 		if (strcmp(td->name, IMA_TEMPLATE_IMA_NAME) != 0) {
 			rc = crypto_shash_update(shash,
-						(const u8 *) &field_data[i].len,
-						sizeof(field_data[i].len));
+						(const u8 *) &datalen_to_hash,
+						sizeof(datalen_to_hash));
 			if (rc)
 				break;
 		} else if (strcmp(td->fields[i]->field_id, "n") == 0) {
-- 
2.1.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
