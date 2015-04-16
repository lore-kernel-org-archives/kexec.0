Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Yimxd-00084R-GO
 for kexec@lists.infradead.org; Thu, 16 Apr 2015 16:48:17 +0000
From: Pratyush Anand <panand@redhat.com>
Subject: [PATCH RFC 2/6] purgatory: No need to sha256 update if ptr->len is
 zero
Date: Thu, 16 Apr 2015 22:17:18 +0530
Message-Id: <a66d1e193a9bd27e940edfbb56ca521556e95b39.1429201849.git.panand@redhat.com>
In-Reply-To: <cover.1429201849.git.panand@redhat.com>
References: <cover.1429201849.git.panand@redhat.com>
In-Reply-To: <cover.1429201849.git.panand@redhat.com>
References: <cover.1429201849.git.panand@redhat.com>
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
To: kexec@lists.fedoraproject.org, kexec@lists.infradead.org
Cc: Pratyush Anand <panand@redhat.com>

If ptr->len is zero we do not need to update sha256.

Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 purgatory/purgatory.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/purgatory/purgatory.c b/purgatory/purgatory.c
index 3bbcc0935ad5..f8ed69b8fbfb 100644
--- a/purgatory/purgatory.c
+++ b/purgatory/purgatory.c
@@ -18,6 +18,8 @@ int verify_sha256_digest(void)
 	sha256_starts(&ctx);
 	end = &sha256_regions[sizeof(sha256_regions)/sizeof(sha256_regions[0])];
 	for(ptr = sha256_regions; ptr < end; ptr++) {
+		if (ptr->len == 0)
+			continue;
 		sha256_update(&ctx, (uint8_t *)((uintptr_t)ptr->start),
 			      ptr->len);
 	}
-- 
2.1.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
