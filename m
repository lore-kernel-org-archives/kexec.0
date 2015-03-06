Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YTolA-0002E1-Iw
 for kexec@lists.infradead.org; Fri, 06 Mar 2015 09:41:34 +0000
Message-Id: <cover.1425634290.git.ptesarik@suse.cz>
From: Petr Tesarik <ptesarik@suse.cz>
Date: Fri, 6 Mar 2015 10:31:30 +0100
Subject: [PATCH 0/4] Clean up makedumpfile cache handling
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
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>, Michael Holzheu <holzheu@linux.vnet.ibm.com>
Cc: kexec mailing list <kexec@lists.infradead.org>, Jan Willeke <willeke@de.ibm.com>

The cache code is somewhat clumsy. This patch series tries to clean up
the code and clarify the concept, especially the meaning of the pending
list (allocated cache entries whose content is not yet valid).

The last patch adds some basic statistics to the final report.

Petr Tesarik (4):
  cache: get rid of search loop in cache_add()
  cache: allow to return a page to the pool
  cache: do not allocate from the pending list
  cache: add hit/miss statistics to the final report

 cache.c        | 46 +++++++++++++++++++---------------------------
 cache.h        | 11 +++++++++--
 makedumpfile.c | 29 ++++++++++++++++++++++-------
 3 files changed, 50 insertions(+), 36 deletions(-)

-- 
1.8.4.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
