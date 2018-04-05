Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1f43Ew-0004p4-LL
 for kexec@lists.infradead.org; Thu, 05 Apr 2018 11:39:40 +0000
Date: Thu, 5 Apr 2018 13:39:26 +0200
From: Petr Tesarik <ptesarik@suse.cz>
Subject: [PATCH] Fix a segmentation fault when trying to run "kexec -p"
Message-ID: <20180405133926.14cc92ef@ezekiel.suse.cz>
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
To: kexec@lists.infradead.org, Michal Suchanek <msuchanek@suse.de>
Cc: horms@verge.net.au, Dave Young <dyoung@redhat.com>

Do not fall through to "--mem-min" when "-p" option is parsed. The
break statement was apparently removed by mistake...

Fixes: cb434cbe6f401037e448276bb12056d1fdc3dbfc
Signed-off-by: Petr Tesarik <ptesarik@suse.com>
---
 kexec/kexec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kexec/kexec.c b/kexec/kexec.c
index 612c1c2..313d9fe 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -1349,6 +1349,7 @@ int main(int argc, char *argv[])
 			do_sync = 0;
 			kexec_file_flags |= KEXEC_FILE_ON_CRASH;
 			kexec_flags = KEXEC_ON_CRASH;
+			break;
 		case OPT_MEM_MIN:
 			mem_min = strtoul(optarg, &endptr, 0);
 			if (*endptr) {
-- 
2.13.6

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
