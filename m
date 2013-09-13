Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VKR0c-0001Ls-2u
 for kexec@lists.infradead.org; Fri, 13 Sep 2013 10:53:56 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 0BB853EE0AE
 for <kexec@lists.infradead.org>; Fri, 13 Sep 2013 19:53:34 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id F1E5B45DE4D
 for <kexec@lists.infradead.org>; Fri, 13 Sep 2013 19:53:33 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id DC26245DD78
 for <kexec@lists.infradead.org>; Fri, 13 Sep 2013 19:53:33 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id D02021DB803A
 for <kexec@lists.infradead.org>; Fri, 13 Sep 2013 19:53:33 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 89B4B1DB802C
 for <kexec@lists.infradead.org>; Fri, 13 Sep 2013 19:53:33 +0900 (JST)
Subject: [PATCH 2/2] sadump: convert the first three fields of EFI GUID from
 little-endian into big-endian
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Date: Fri, 13 Sep 2013 19:53:32 +0900
Message-ID: <20130913105332.2332.34743.stgit@localhost6.localdomain6>
In-Reply-To: <20130913105216.2332.8060.stgit@localhost6.localdomain6>
References: <20130913105216.2332.8060.stgit@localhost6.localdomain6>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kumagai-atsushi@mxc.nes.nec.co.jp
Cc: kexec@lists.infradead.org

Although RFC 4122 recommends network byte order for all fields of
UUID, EFI GUID uses little-endian for the first three fields TimeLow,
TimeMid and TimeHighAndVersion. Thus, in text representation of the
GUID, converting the three fields from little-endian into big-endian
is needed.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---
 sadump_info.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sadump_info.c b/sadump_info.c
index e563180..84126b1 100644
--- a/sadump_info.c
+++ b/sadump_info.c
@@ -23,6 +23,8 @@
 #include "print_info.h"
 #include "sadump_mod.h"
 
+#include <arpa/inet.h> /* htonl, htons */
+
 #define SADUMP_EFI_GUID_TEXT_REPR_LEN 36
 
 #ifdef __x86__
@@ -334,7 +336,7 @@ guid_to_str(efi_guid_t *guid, char *buf, size_t buflen)
 {
 	snprintf(buf, buflen,
 		 "%08x-%04x-%04x-%02x%02x-%02x%02x%02x%02x%02x%02x",
-		 guid->data1, guid->data2, guid->data3,
+		 htonl(guid->data1), htons(guid->data2), htons(guid->data3),
 		 guid->data4[0], guid->data4[1], guid->data4[2],
 		 guid->data4[3], guid->data4[4], guid->data4[5],
 		 guid->data4[6], guid->data4[7]);


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
