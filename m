Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JRjzh-0002dX-Ej
	for kexec@lists.infradead.org; Wed, 20 Feb 2008 08:07:57 +0000
Received: from Relay2.suse.de (relay-ext.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 071503711D
	for <kexec@lists.infradead.org>; Wed, 20 Feb 2008 09:07:56 +0100 (CET)
Date: Wed, 20 Feb 2008 09:07:55 +0100
From: Bernhard Walle <bwalle@suse.de>
Subject: [PATCH] Fix compilation warning
Message-ID: <20080220080755.GB5542@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

This patch fixes following compilation warning:

purgatory/purgatory.c:21: warning: passing argument 2 of 'sha256_update' makes pointer from integer without a cast


Signed-off-by: Bernhard Walle <bwalle@suse.de>

---
 purgatory/purgatory.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/purgatory/purgatory.c
+++ b/purgatory/purgatory.c
@@ -18,7 +18,7 @@ void verify_sha256_digest(void)
 	sha256_starts(&ctx);
 	end = &sha256_regions[sizeof(sha256_regions)/sizeof(sha256_regions[0])];
 	for(ptr = sha256_regions; ptr < end; ptr++) {
-		sha256_update(&ctx, ptr->start, ptr->len);
+		sha256_update(&ctx, (uint8_t *)ptr->start, ptr->len);
 	}
 	sha256_finish(&ctx, digest);
 	if (memcmp(digest, sha256_digest, sizeof(digest)) != 0) {

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
