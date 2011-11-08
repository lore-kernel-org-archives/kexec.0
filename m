Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1RNeAT-0001W4-06
 for kexec@lists.infradead.org; Tue, 08 Nov 2011 05:24:18 +0000
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
 (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
 by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id pA85OFxq014647
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
 for <kexec@lists.infradead.org>; Tue, 8 Nov 2011 00:24:15 -0500
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
 by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id
 pA85OE4P019319
 for <kexec@lists.infradead.org>; Tue, 8 Nov 2011 00:24:15 -0500
Received: from darkstar.nay.redhat.com (wlan-5-111.nay.redhat.com
 [10.66.12.111] (may be forged))
 by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id pA85OCpF016785
 for <kexec@lists.infradead.org>; Tue, 8 Nov 2011 00:24:13 -0500
Date: Tue, 8 Nov 2011 13:26:23 +0800
From: Dave Young <dyoung@redhat.com>
Subject: [PATCH] remove unnecessary check code for hole_align
Message-ID: <20111108052623.GA22922@darkstar.nay.redhat.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

hole_align == 0 check is not neccesary, because it will be set to
pagesize if it's zero. Just remove it here.

Signed-off-by: Dave Young <dyoung@redhat.com>
---
 kexec/kexec.c |    4 ----
 1 file changed, 4 deletions(-)

Index: kexec-tools/kexec/kexec.c
===================================================================
--- kexec-tools.orig/kexec/kexec.c
+++ kexec-tools/kexec/kexec.c
@@ -203,10 +203,6 @@ unsigned long locate_hole(struct kexec_i
 	/* Set an intial invalid value for the hole base */
 	hole_base = ULONG_MAX;
 
-	/* Ensure I have a sane alignment value */
-	if (hole_align == 0) {
-		hole_align = 1;
-	}
 	/* Align everything to at least a page size boundary */
 	if (hole_align < (unsigned long)getpagesize()) {
 		hole_align = getpagesize();

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
