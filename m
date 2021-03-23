Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lOlBA-00FSXz-So
 for kexec@lists.infradead.org; Tue, 23 Mar 2021 17:50:58 +0000
Received: by mail-wm1-x336.google.com with SMTP id
 a132-20020a1c668a0000b029010f141fe7c2so11299763wmc.0
 for <kexec@lists.infradead.org>; Tue, 23 Mar 2021 10:50:56 -0700 (PDT)
From: Raphael Ning <raphning@gmail.com>
Subject: [PATCH] kexec: Make --status work with normal kexec images
Date: Tue, 23 Mar 2021 17:50:07 +0000
Message-Id: <20210323175007.3069-1-raphning@gmail.com>
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
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org, Raphael Ning <raphning@gmail.com>, Julien Grall <julien@xen.org>, Hongyan Xia <hx242@xen.org>, Raphael Ning <raphning@amazon.com>

From: Raphael Ning <raphning@amazon.com>

According to kexec(8) manpage, --status (-S) works with both
normal kexec (loaded by -l) and crash kernel (loaded by -p) image
types, and defaults to the latter. However, the implementation does
not match the description: `kexec -l -S` queries the -p image type
as if -l were not specified. This is because there is no internal
flag defined for the normal kexec type, and -S treats the zero flag
as the trigger for the default behaviour (-p).

Fix that by making sure the default behaviour for -S is not applied
when the -l option is present.

Signed-off-by: Raphael Ning <raphning@amazon.com>
---
 kexec/kexec.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kexec/kexec.c b/kexec/kexec.c
index ffc689ac3d7f..0c4b9619bfd7 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -1336,6 +1336,7 @@ static void print_crashkernel_region_size(void)
 
 int main(int argc, char *argv[])
 {
+	int has_opt_load = 0;
 	int do_load = 1;
 	int do_exec = 0;
 	int do_load_jump_back_helper = 0;
@@ -1393,6 +1394,7 @@ int main(int argc, char *argv[])
 			do_exec = 1;
 			break;
 		case OPT_LOAD:
+			has_opt_load = 1;
 			do_load = 1;
 			do_exec = 0;
 			do_shutdown = 0;
@@ -1512,7 +1514,7 @@ int main(int argc, char *argv[])
 		do_sync = 0;
 
 	if (do_status) {
-		if (kexec_flags == 0)
+		if (kexec_flags == 0 && !has_opt_load)
 			kexec_flags = KEXEC_ON_CRASH;
 		do_load = 0;
 		do_reuse_initrd = 0;
-- 
2.23.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
