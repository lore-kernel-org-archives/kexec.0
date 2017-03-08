Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH 2/7] uImage: Fix uImage_load() for little-endian machines
Date: Wed,  8 Mar 2017 22:41:09 +0000
Message-Id: <20170308224114.49729-2-dwmw2@infradead.org>
In-Reply-To: <20170308224114.49729-1-dwmw2@infradead.org>
References: <20170308224114.49729-1-dwmw2@infradead.org>
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
To: kexec@lists.infradead.org
Cc: David Woodhouse <dwmw@amazon.co.uk>

From: David Woodhouse <dwmw@amazon.co.uk>

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 kexec/kexec-uImage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kexec/kexec-uImage.c b/kexec/kexec-uImage.c
index 667cd93..49f266a 100644
--- a/kexec/kexec-uImage.c
+++ b/kexec/kexec-uImage.c
@@ -236,7 +236,7 @@ int uImage_load(const unsigned char *buf, off_t len, struct Image_info *image)
 {
 	const struct image_header *header = (const struct image_header *)buf;
 	const unsigned char *img_buf = buf + sizeof(struct image_header);
-	off_t img_len = header->ih_size;
+	off_t img_len = be32_to_cpu(header->ih_size);
 
 	/*
 	 * Prevent loading a modified image.
-- 
2.9.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
