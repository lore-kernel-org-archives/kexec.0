Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-we0-f177.google.com ([74.125.82.177])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SLAbh-00081b-NP
 for kexec@lists.infradead.org; Fri, 20 Apr 2012 09:58:26 +0000
Received: by werp11 with SMTP id p11so7288409wer.36
 for <kexec@lists.infradead.org>; Fri, 20 Apr 2012 02:58:23 -0700 (PDT)
From: Helmut Schaa <helmut.schaa@googlemail.com>
Subject: [PATCH] kexec-tools: Fix CRC calculation for padded uImage
Date: Fri, 20 Apr 2012 11:58:16 +0200
Message-Id: <1334915896-32034-1-git-send-email-helmut.schaa@googlemail.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: horms@verge.net.au, Helmut Schaa <helmut.schaa@googlemail.com>

Instead of calulating the CRC on the whole file just calculate the CRC
on the actual uImage length as given by the uImage header. This fixes
loading padded uImages, for example from a mtd partition.

Signed-off-by: Helmut Schaa <helmut.schaa@googlemail.com>
---
 kexec/kexec-uImage.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/kexec/kexec-uImage.c b/kexec/kexec-uImage.c
index 409e516..83e7910 100644
--- a/kexec/kexec-uImage.c
+++ b/kexec/kexec-uImage.c
@@ -72,7 +72,7 @@ int uImage_probe(const unsigned char *buf, off_t len, unsigned int arch)
 		return -1;
 	}
 #ifdef HAVE_LIBZ
-	crc = crc32(0, (void *)buf + sizeof(header), len - sizeof(header));
+	crc = crc32(0, (void *)buf + sizeof(header), be32_to_cpu(header.ih_size));
 	if (crc != be32_to_cpu(header.ih_dcrc)) {
 		printf("The data CRC does not match. Computed: %08x "
 				"expected %08x\n", crc,
-- 
1.7.7


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
