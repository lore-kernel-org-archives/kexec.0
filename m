Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.windriver.com ([147.11.1.11])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bNKMy-0006em-2B
 for kexec@lists.infradead.org; Wed, 13 Jul 2016 13:38:33 +0000
From: Lans Zhang <jia.zhang@windriver.com>
Subject: [V2][PATCH 2/2] pefile: Fix the failure of calculation for digest
Date: Wed, 13 Jul 2016 21:35:37 +0800
Message-ID: <1468416937-21237-2-git-send-email-jia.zhang@windriver.com>
In-Reply-To: <1468416937-21237-1-git-send-email-jia.zhang@windriver.com>
References: <1468416937-21237-1-git-send-email-jia.zhang@windriver.com>
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
To: dhowells@redhat.com
Cc: kexec@lists.infradead.org, vgoyal@redhat.com, bhe@redhat.com

The commit e68503bd68 forgot to set digest_len and thus cause the following
error reported by kexec when launching a crash kernel:
"kexec_file_load failed: Bad message"

Fixes: e68503bd68 (KEYS: Generalise system_verify_data() to provide access to internal content)
Signed-off-by: Lans Zhang <jia.zhang@windriver.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
---
 crypto/asymmetric_keys/mscode_parser.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/crypto/asymmetric_keys/mscode_parser.c b/crypto/asymmetric_keys/mscode_parser.c
index 6a76d5c..9492e1c 100644
--- a/crypto/asymmetric_keys/mscode_parser.c
+++ b/crypto/asymmetric_keys/mscode_parser.c
@@ -124,5 +124,10 @@ int mscode_note_digest(void *context, size_t hdrlen,
 	struct pefile_context *ctx = context;
 
 	ctx->digest = kmemdup(value, vlen, GFP_KERNEL);
-	return ctx->digest ? 0 : -ENOMEM;
+	if (!ctx->digest)
+		return -ENOMEM;
+
+	ctx->digest_len = vlen;
+
+	return 0;
 }
-- 
1.9.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
