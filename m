Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WBITw-0004zW-5i
 for kexec@lists.infradead.org; Thu, 06 Feb 2014 06:30:41 +0000
From: Dave Young <dyoung@redhat.com>
Subject: [PATCH 2/2] kernel image probe function return value checking fix
Date: Thu,  6 Feb 2014 14:30:44 +0800
Message-Id: <1391668244-13631-3-git-send-email-dyoung@redhat.com>
In-Reply-To: <1391668244-13631-1-git-send-email-dyoung@redhat.com>
References: <1391668244-13631-1-git-send-email-dyoung@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: horms@verge.net.au
Cc: kexec@lists.infradead.org

Currently kexec will use the kernel image type when probe function return
value >=0. It looks odd, but previously it works. Since commit bf06cf2095
it does not work anymore.

During my testing for arm zImage, in 2nd kernel the atags pointer and the
machine_id are not valid, I did a lot of debugging in kernel, finally I found
this is caused by a kexec tools bug instead.

Because uImage will be probed before zImage, also the uImage probe return 1
instead of -1 since bf06cf2095, thus kexec will mistakenly think it is uImage.

Fix this issue by regarding it's valid only when probe return 0.

Signed-off-by: Dave Young <dyoung@redhat.com>
---
 kexec/kexec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kexec/kexec.c b/kexec/kexec.c
index f13e512..703d524 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -691,7 +691,7 @@ static int my_load(const char *type, int fileind, int argc, char **argv,
 	}
 	if (!type || guess_only) {
 		for (i = 0; i < file_types; i++) {
-			if (file_type[i].probe(kernel_buf, kernel_size) >= 0)
+			if (file_type[i].probe(kernel_buf, kernel_size) == 0)
 				break;
 		}
 		if (i == file_types) {
-- 
1.8.3.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
