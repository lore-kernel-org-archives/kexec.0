Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qv1-xf2d.google.com ([2607:f8b0:4864:20::f2d])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l47Oc-00074B-Ln
 for kexec@lists.infradead.org; Mon, 25 Jan 2021 19:19:36 +0000
Received: by mail-qv1-xf2d.google.com with SMTP id dj6so6732285qvb.1
 for <kexec@lists.infradead.org>; Mon, 25 Jan 2021 11:19:29 -0800 (PST)
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Subject: [PATCH v10 02/18] arm64: hibernate: variable pudp is used instead of
 pd4dp
Date: Mon, 25 Jan 2021 14:19:07 -0500
Message-Id: <20210125191923.1060122-3-pasha.tatashin@soleen.com>
In-Reply-To: <20210125191923.1060122-1-pasha.tatashin@soleen.com>
References: <20210125191923.1060122-1-pasha.tatashin@soleen.com>
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
To: pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org, ebiederm@xmission.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org, linux-arm-kernel@lists.infradead.org, maz@kernel.org, james.morse@arm.com, vladimir.murzin@arm.com, matthias.bgg@gmail.com, linux-mm@kvack.org, mark.rutland@arm.com, steve.capper@arm.com, rfontana@redhat.com, tglx@linutronix.de, selindag@gmail.com, tyhicks@linux.microsoft.com

There should be p4dp used when p4d page is allocated.
This is not a functional issue, but for the logical correctness this
should be fixed.

Fixes: e9f6376858b9 ("arm64: add support for folded p4d page tables")
Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/kernel/hibernate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index 9c9f47e9f7f4..0a54d81c90f9 100644
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -190,10 +190,10 @@ static int trans_pgd_map_page(pgd_t *trans_pgd, void *page,
 
 	pgdp = pgd_offset_pgd(trans_pgd, dst_addr);
 	if (pgd_none(READ_ONCE(*pgdp))) {
-		pudp = (void *)get_safe_page(GFP_ATOMIC);
-		if (!pudp)
+		p4dp = (void *)get_safe_page(GFP_ATOMIC);
+		if (!pgdp)
 			return -ENOMEM;
-		pgd_populate(&init_mm, pgdp, pudp);
+		pgd_populate(&init_mm, pgdp, p4dp);
 	}
 
 	p4dp = p4d_offset(pgdp, dst_addr);
-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
