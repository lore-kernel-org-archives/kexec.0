Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1g4Z8a-00012q-Ml
 for kexec@lists.infradead.org; Mon, 24 Sep 2018 22:15:30 +0000
Subject: [PATCH 2/3] resource: Include resource end in walk_*() interfaces
From: Bjorn Helgaas <helgaas@kernel.org>
Date: Mon, 24 Sep 2018 17:14:55 -0500
Message-ID: <153782729511.130337.17128646882631701192.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <153782698067.130337.12079523922130875402.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <153782698067.130337.12079523922130875402.stgit@bhelgaas-glaptop.roam.corp.google.com>
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
To: Lianbo Jiang <lijiang@redhat.com>
Cc: dan.j.williams@intel.com, brijesh.singh@amd.com, bhe@redhat.com, thomas.lendacky@amd.com, tiwai@suse.de, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, baiyaowei@cmss.chinamobile.com, hpa@zytor.com, tglx@linutronix.de, bp@suse.de, dyoung@redhat.com, akpm@linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>

From: Bjorn Helgaas <bhelgaas@google.com>

find_next_iomem_res() finds an iomem resource that covers part of a range
described by "start, end".  All callers expect that range to be inclusive,
i.e., both start and end are included, but find_next_iomem_res() doesn't
handle the end address correctly.

If it finds an iomem resource that contains exactly the end address, it
skips it, e.g., if "start, end" is [0x0-0x10000] and there happens to be an
iomem resource [mem 0x10000-0x10000] (the single byte at 0x10000), we skip
it:

  find_next_iomem_res(...)
  {
    start = 0x0;
    end = 0x10000;
    for (p = next_resource(...)) {
      # p->start = 0x10000;
      # p->end = 0x10000;
      # we *should* return this resource, but this condition is false:
      if ((p->end >= start) && (p->start < end))
        break;

Adjust find_next_iomem_res() so it allows a resource that includes the
single byte at the end of the range.  This is a corner case that we
probably don't see in practice.

Fixes: 58c1b5b07907 ("[PATCH] memory hotadd fixes: find_next_system_ram catch range fix")
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 kernel/resource.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index 30e1bc68503b..155ec873ea4d 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -319,7 +319,7 @@ int release_resource(struct resource *old)
 EXPORT_SYMBOL(release_resource);
 
 /*
- * Finds the lowest iomem resource existing within [res->start.res->end).
+ * Finds the lowest iomem resource existing within [res->start..res->end].
  * The caller must specify res->start, res->end, res->flags, and optionally
  * desc.  If found, returns 0, res is overwritten, if not found, returns -1.
  * This function walks the whole tree and not just first level children until
@@ -352,7 +352,7 @@ static int find_next_iomem_res(struct resource *res, unsigned long desc,
 			p = NULL;
 			break;
 		}
-		if ((p->end >= start) && (p->start < end))
+		if ((p->end >= start) && (p->start <= end))
 			break;
 	}
 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
