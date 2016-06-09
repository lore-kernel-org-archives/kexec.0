Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1bB2hR-00005O-IO
 for kexec@lists.infradead.org; Thu, 09 Jun 2016 16:20:55 +0000
In-Reply-To: <20160608012257.GA28638@verge.net.au>
References: <20160608012257.GA28638@verge.net.au>
From: Russell King <rmk@armlinux.org.uk>
Subject: [PATCH] Remove "max" parameter comment
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <E1bB2em-0004ll-0u@e0050434b2927.dyn.armlinux.org.uk>
Date: Thu, 09 Jun 2016 17:18:08 +0100
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
Cc: Pratyush Anand <panand@redhat.com>, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Baoquan He <bhe@redhat.com>

Remove the "max" parameter in the documentation for mem_regions_add()

Signed-off-by: Russell King <rmk@armlinux.org.uk>
---
 kexec/mem_regions.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kexec/mem_regions.c b/kexec/mem_regions.c
index b01a5c89..e61c0747 100644
--- a/kexec/mem_regions.c
+++ b/kexec/mem_regions.c
@@ -31,7 +31,6 @@ void mem_regions_sort(struct memory_ranges *ranges)
 /**
  * mem_regions_add() - add a memory region to a set of ranges
  * @ranges: ranges to add the memory region to
- * @max: maximum number of entries in memory region
  * @base: base address of memory region
  * @length: length of memory region in bytes
  * @type: type of memory region
-- 
1.9.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
