Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i5BgD-0001Bv-2X
 for kexec@lists.infradead.org; Tue, 03 Sep 2019 16:29:18 +0000
From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 142/167] resource: Include resource end in
 walk_*() interfaces
Date: Tue,  3 Sep 2019 12:24:54 -0400
Message-Id: <20190903162519.7136-142-sashal@kernel.org>
In-Reply-To: <20190903162519.7136-1-sashal@kernel.org>
References: <20190903162519.7136-1-sashal@kernel.org>
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
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, Brijesh Singh <brijesh.singh@amd.com>, Lianbo Jiang <lijiang@redhat.com>, bhe@redhat.com, Takashi Iwai <tiwai@suse.de>, x86-ml <x86@kernel.org>, kexec@lists.infradead.org, mingo@redhat.com, Thomas Gleixner <tglx@linutronix.de>, Yaowei Bai <baiyaowei@cmss.chinamobile.com>, "H . Peter Anvin" <hpa@zytor.com>, Bjorn Helgaas <bhelgaas@google.com>, Andrew Morton <akpm@linux-foundation.org>, Borislav Petkov <bp@suse.de>, dyoung@redhat.com, Dan Williams <dan.j.williams@intel.com>, Vivek Goyal <vgoyal@redhat.com>

From: Bjorn Helgaas <bhelgaas@google.com>

[ Upstream commit a98959fdbda1849a01b2150bb635ed559ec06700 ]

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
Signed-off-by: Borislav Petkov <bp@suse.de>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: Brijesh Singh <brijesh.singh@amd.com>
CC: Dan Williams <dan.j.williams@intel.com>
CC: H. Peter Anvin <hpa@zytor.com>
CC: Lianbo Jiang <lijiang@redhat.com>
CC: Takashi Iwai <tiwai@suse.de>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Tom Lendacky <thomas.lendacky@amd.com>
CC: Vivek Goyal <vgoyal@redhat.com>
CC: Yaowei Bai <baiyaowei@cmss.chinamobile.com>
CC: bhe@redhat.com
CC: dan.j.williams@intel.com
CC: dyoung@redhat.com
CC: kexec@lists.infradead.org
CC: mingo@redhat.com
CC: x86-ml <x86@kernel.org>
Link: http://lkml.kernel.org/r/153805812254.1157.16736368485811773752.stgit@bhelgaas-glaptop.roam.corp.google.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/resource.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index 30e1bc68503b5..155ec873ea4d1 100644
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
 
-- 
2.20.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
