Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WTEWc-0005KJ-T0
 for kexec@lists.infradead.org; Thu, 27 Mar 2014 17:55:35 +0000
From: Petr Tesarik <ptesarik@suse.cz>
Date: Thu, 27 Mar 2014 18:49:40 +0100
Subject: [PATCH 0/2] Allow Xen Dom0 page filtering
Message-Id: <20140327175508.5F86560141@nathan.suse.cz>
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
Cc: kexec@lists.infradead.org

Trying to use makedumpfile on a Xen Dom0 ELF file currently fails, but there
are in fact only a few missing pieces. With the following two patches, I was
able to produce a dump even with high dump levels (-d17 and -d31).

Needless to say, this can reduce the size of Dom0 dumps considerably.

Petr Tesarik (2):
  Earlier initialization of dom0_mapnr
  Get Dom0 max_pfn using pfn_mfn_frame_list if max_pfn unavailable

 makedumpfile.c | 35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

-- 
1.8.4.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
