Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Wi5JQ-00030G-DI
 for kexec@lists.infradead.org; Wed, 07 May 2014 17:07:21 +0000
From: Petr Tesarik <ptesarik@suse.cz>
Subject: [PATCH v3 0/2] Generic multi-page exclusion
Date: Wed,  7 May 2014 19:06:41 +0200
Message-Id: <1399482403-3656-1-git-send-email-ptesarik@suse.cz>
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
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: Petr Tesarik <ptesarik@suse.cz>, kexec@lists.infradead.org

Kumagai-san,

this patch was inspired by this post of yours:

http://lists.infradead.org/pipermail/kexec/2013-November/010445.html

Unfortunately, this rewrite never happened, so I took the liberty of
overtaking the job. I hope you don't mind.

This is a preparatory series to add hugepage support without having
to care about the appropriate size of the cyclic buffer.

Changelog:
* v2:
  - Keep excluded regions per mem_map_data
  - Process excluded pages in chunks

* v3:
  - Keep excluded region extents in struct cycle

Petr Tesarik (2):
  Generic handling of multi-page exclusions
  Get rid of overrun adjustments

 makedumpfile.c | 108 +++++++++++++++++++--------------------------------------
 makedumpfile.h |   5 +++
 2 files changed, 40 insertions(+), 73 deletions(-)

-- 
1.8.4.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
