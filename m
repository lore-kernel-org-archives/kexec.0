Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1T3qNk-0002no-Bv
 for kexec@lists.infradead.org; Tue, 21 Aug 2012 15:28:41 +0000
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 5F52BA3DDD
 for <kexec@lists.infradead.org>; Tue, 21 Aug 2012 17:28:39 +0200 (CEST)
Resent-To: kexec@lists.infradead.org
Resent-Message-ID: <201208211728.39062.ptesarik@suse.cz>
Message-Id: <20120821084451.998322783@azariah.suse.cz>
Date: Tue, 21 Aug 2012 10:44:53 +0200
From: Petr Tesarik <ptesarik@suse.cz>
Subject: [patch 2/9] Xen: Fix the offset of the _domain field in struct
 page_info
References: <20120821084451.587187471@azariah.suse.cz>
Content-Disposition: inline; filename=02-xen-page_info-_domain.patch
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
Cc: Petr Tesarik <ptesarik@suse.cz>, Norbert Trapp <norbert.trapp@ts.fujitsu.com>

The page_info structure was re-arranged in Xen-3.4 (with changeset
162cdb596b9a), and the _domain field moved from union "u" to union "v"
on x86 and x86_64.

By using OFFSET_IN_UNION_INIT we can cover all cases:

1. old placement in union "u"
2. new placement in union "v" on x86 and x86_64
3. unmodified placement in union "u" on ia64

Unfortunately, the re-arrangement was not reflected in xen/common/kexec.c,
so the page_info _domain offset was still set with:
    VMCOREINFO_OFFSET_ALIAS(page_info, u, _domain);

The bug was spotted during Xen-4.1 development (changeset cb756381087c),
and all Xen-4.1 releases are fixed like this:
    #ifdef __ia64__
	VMCOREINFO_OFFSET_SUB(page_info, u.inuse, _domain);
    #else
	VMCOREINFO_OFFSET_SUB(page_info, v.inuse, _domain);
    #endif

This changeset was also backported to Xen-4.0 branch as changeset
3b90a5353f20, which first went into Xen-4.0.2.
For Xen-3.4, this bug was never fixed.

To sum it up:
1. Xen versions up to and including Xen-3.3 output the correct offset
2. Xen-4.1 and above is also correct
3. Xen-4.0 is broken up to 4.0.2
4. Xen-3.4 is always broken

Some OS vendors may also have backported the patch to an otherwise broken
version, so the above summary may not be reliable.

Anyway, the VMCOREINFO produced by some Xen versions is wrong, and
makedumpfile will behave incorrectly. Adding a workaround to makedumpfile
for a bug in another package is wrong, because:

A. Self-reliant users should upgrade Xen.
B. Users of distro packages should report it as a bug to their vendor, and
   the vendor should backport the patch.
C. Users who need an immediate workaround should generate a vmcoreinfo file
   using makedumpfile, which will be correct after applying this patch.

Signed-off-by: Norbert Trapp <norbert.trapp@ts.fujitsu.com>
Signed-off-by: Petr Tesarik <ptesarik@suse.cz>

---
 makedumpfile.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -5306,10 +5306,7 @@ get_structure_info_xen(void)
 {
 	SIZE_INIT(page_info, "page_info");
 	OFFSET_INIT(page_info.count_info, "page_info", "count_info");
-	/*
-	 * _domain is the first member of union u
-	 */
-	OFFSET_INIT(page_info._domain, "page_info", "u");
+	OFFSET_IN_UNION_INIT(page_info._domain, "page_info", "_domain");
 
 	SIZE_INIT(domain, "domain");
 	OFFSET_INIT(domain.domain_id, "domain", "domain_id");



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
