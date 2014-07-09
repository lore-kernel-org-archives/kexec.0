Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1X4tca-0001LT-Ix
 for kexec@lists.infradead.org; Wed, 09 Jul 2014 15:17:25 +0000
Subject: [PATCH15/17] pefile: Handle pesign using the wrong OID
From: David Howells <dhowells@redhat.com>
Date: Wed, 09 Jul 2014 16:17:02 +0100
Message-ID: <20140709151702.23074.15597.stgit@warthog.procyon.org.uk>
In-Reply-To: <20140709151525.23074.32315.stgit@warthog.procyon.org.uk>
References: <20140709151525.23074.32315.stgit@warthog.procyon.org.uk>
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
To: keyrings@linux-nfs.org
Cc: linux-security-module@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

The pesign utility had a bug where it was using OID_msIndividualSPKeyPurpose
instead of OID_msPeImageDataObjId - so allow both OIDs.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
Acked-by: Vivek Goyal <vgoyal@redhat.com>
---

 crypto/asymmetric_keys/mscode_parser.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)


diff --git a/crypto/asymmetric_keys/mscode_parser.c b/crypto/asymmetric_keys/mscode_parser.c
index 09336c3..214a992 100644
--- a/crypto/asymmetric_keys/mscode_parser.c
+++ b/crypto/asymmetric_keys/mscode_parser.c
@@ -58,7 +58,13 @@ int mscode_note_content_type(void *context, size_t hdrlen,
 		return -EBADMSG;
 	}
 
-	if (oid != OID_msIndividualSPKeyPurpose) {
+	/*
+	 * pesign utility had a bug where it was putting
+	 * OID_msIndividualSPKeyPurpose instead of OID_msPeImageDataObjId
+	 * So allow both OIDs.
+	 */
+	if (oid != OID_msPeImageDataObjId &&
+	    oid != OID_msIndividualSPKeyPurpose) {
 		pr_err("Unexpected content type OID %u\n", oid);
 		return -EBADMSG;
 	}


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
