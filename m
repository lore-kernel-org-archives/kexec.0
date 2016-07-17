Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bOvDI-0006Iu-U4
 for kexec@lists.infradead.org; Sun, 17 Jul 2016 23:11:09 +0000
Subject: [PATCH 2/3] pefile: Fix the failure of calculation for digest
From: David Howells <dhowells@redhat.com>
Date: Mon, 18 Jul 2016 00:10:47 +0100
Message-ID: <146879704739.32133.1831526981378509732.stgit@warthog.procyon.org.uk>
In-Reply-To: <146879703192.32133.3670984393495441516.stgit@warthog.procyon.org.uk>
References: <146879703192.32133.3670984393495441516.stgit@warthog.procyon.org.uk>
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
To: jmorris@namei.org
Cc: keyring@vger.kernel.org, Lans Zhang <jia.zhang@windriver.com>, Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, dhowells@redhat.com, linux-security-module@vger.kernel.org, linux-crypto@vger.kernel.org, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>

From: Lans Zhang <jia.zhang@windriver.com>

Commit e68503bd68 forgot to set digest_len and thus cause the following
error reported by kexec when launching a crash kernel:

	kexec_file_load failed: Bad message

Fixes: e68503bd68 (KEYS: Generalise system_verify_data() to provide access to internal content)
Signed-off-by: Lans Zhang <jia.zhang@windriver.com>
Tested-by: Dave Young <dyoung@redhat.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
cc: kexec@lists.infradead.org
cc: linux-crypto@vger.kernel.org
---

 crypto/asymmetric_keys/mscode_parser.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/crypto/asymmetric_keys/mscode_parser.c b/crypto/asymmetric_keys/mscode_parser.c
index 6a76d5c70ef6..9492e1c22d38 100644
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


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
