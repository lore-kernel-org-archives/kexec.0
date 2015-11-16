Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZyJLi-00075E-Uv
 for kexec@lists.infradead.org; Mon, 16 Nov 2015 12:57:35 +0000
Received: by wmec201 with SMTP id c201so118375448wme.1
 for <kexec@lists.infradead.org>; Mon, 16 Nov 2015 04:57:13 -0800 (PST)
From: Andreas Fenkart <afenkart@gmail.com>
Subject: [PATCH 2/2] uImage: fix pointer-sign warning
Date: Mon, 16 Nov 2015 13:56:55 +0100
Message-Id: <1447678615-16987-2-git-send-email-andreas.fenkart@dev.digitalstrom.org>
In-Reply-To: <1447678615-16987-1-git-send-email-andreas.fenkart@dev.digitalstrom.org>
References: <1447678615-16987-1-git-send-email-andreas.fenkart@dev.digitalstrom.org>
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
Cc: Andreas Fenkart <andreas.fenkart@dev.digitalstrom.org>

Signed-off-by: Andreas Fenkart <andreas.fenkart@dev.digitalstrom.org>
---
 kexec/kexec-uImage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kexec/kexec-uImage.c b/kexec/kexec-uImage.c
index 00bc064..9df601b 100644
--- a/kexec/kexec-uImage.c
+++ b/kexec/kexec-uImage.c
@@ -224,7 +224,7 @@ static int uImage_gz_load(const unsigned char *buf, off_t len,
 	return 0;
 }
 #else
-static int uImage_gz_load(const char *UNUSED(buf), off_t UNUSED(len),
+static int uImage_gz_load(const unsigned char *UNUSED(buf), off_t UNUSED(len),
 		struct Image_info *UNUSED(image))
 {
 	return -1;
-- 
2.6.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
