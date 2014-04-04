Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WW7s5-0001r4-7g
 for kexec@lists.infradead.org; Fri, 04 Apr 2014 17:25:42 +0000
From: Petr Tesarik <ptesarik@suse.cz>
Subject: [PATCH v2 0/3] Generic multi-page exclusion
Date: Fri,  4 Apr 2014 19:25:06 +0200
Message-Id: <cover.1396632131.git.ptesarik@suse.cz>
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
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: Petr Tesarik <ptesarik@suse.cz>, kexec@lists.infradead.org

Kumagai-san,

this patch was inspired by this post of yours:

http://lists.infradead.org/pipermail/kexec/2013-November/010445.html

Unfortunately, this rewrite never happened, so I took the liberty of
overtaking the job. I hope you don't mind.

This is in fact a preparatory series to add hugepage support without
having to care about the appropriate size of the cyclic buffer.

Changelog:
* v2:
  - Keep excluded regions per mem_map_data
  - Process excluded pages in chunks

Petr Tesarik (3):
  Pass mmd pointer to __exclude_unnecessary_pages
  Generic handling of multi-page exclusions
  Get rid of overrun adjustments

 makedumpfile.c | 118 +++++++++++++++++++--------------------------------------
 makedumpfile.h |   7 ++++
 2 files changed, 46 insertions(+), 79 deletions(-)

-- 
1.8.4.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
