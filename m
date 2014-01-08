Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1W0lsw-0003V5-Ke
 for kexec@lists.infradead.org; Wed, 08 Jan 2014 05:40:59 +0000
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
 (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
 by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s085ea3Q006364
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
 for <kexec@lists.infradead.org>; Wed, 8 Jan 2014 00:40:36 -0500
Date: Wed, 8 Jan 2014 13:40:33 +0800
From: WANG Chao <chaowang@redhat.com>
Subject: [PATCH] makedumpfile: -v shows if lzo or snappy support enabled or not
Message-ID: <20140108054033.GA6109@dhcp-17-89.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
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
To: kexec@lists.infradead.org

It would be great to have makedumpfile -v to show if lzo or snappy
support is enabled or not, since --help prints too much and we have to
scroll back three screens to check it out.

Using "+lzo" to indicate lzo is enabled and vice versa "-lzo" for lzo is
disabled. Same for snappy.

For exmaple, If lzo and snappy support are enabled,

    $ ./makedumpfile -v
    makedumpfile: version 1.5.5 (released on 18 Dec 2013)
    +lzo +snappy

If both of them are disabled,

    $ ./makedumpfile -v
    makedumpfile: version 1.5.5 (released on 18 Dec 2013)
    -lzo -snappy

Signed-off-by: WANG Chao <chaowang@redhat.com>
---
 print_info.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/print_info.c b/print_info.c
index 90b6cee..242b42c 100644
--- a/print_info.c
+++ b/print_info.c
@@ -26,7 +26,17 @@ void
 show_version(void)
 {
 	MSG("makedumpfile: version " VERSION " (released on " RELEASE_DATE ")\n");
-	MSG("\n");
+#ifdef USELZO
+	MSG("+lzo ");
+#else
+	MSG("-lzo ");
+#endif
+#ifdef USESNAPPY
+	MSG("+snappy ");
+#else
+	MSG("-snappy ");
+#endif
+	MSG("\n\n");
 }
 
 void
-- 
1.8.4.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
