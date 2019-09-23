Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iCV2j-0002FT-RD
 for kexec@lists.infradead.org; Mon, 23 Sep 2019 20:34:47 +0000
Received: by mail-pl1-x644.google.com with SMTP id d3so7022378plr.1
 for <kexec@lists.infradead.org>; Mon, 23 Sep 2019 13:34:45 -0700 (PDT)
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Subject: [PATCH v5 03/17] arm64: hibernate: check pgd table allocation
Date: Mon, 23 Sep 2019 16:34:13 -0400
Message-Id: <20190923203427.294286-4-pasha.tatashin@soleen.com>
In-Reply-To: <20190923203427.294286-1-pasha.tatashin@soleen.com>
References: <20190923203427.294286-1-pasha.tatashin@soleen.com>
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
To: pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org, ebiederm@xmission.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org, linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com, james.morse@arm.com, vladimir.murzin@arm.com, matthias.bgg@gmail.com, bhsharma@redhat.com, linux-mm@kvack.org, mark.rutland@arm.com

There is a bug in create_safe_exec_page(), when page table is allocated
it is not checked that table is allocated successfully:

But it is dereferenced in: pgd_none(READ_ONCE(*pgdp)).  Check that
allocation was successful.

Fixes: 82869ac57b5d ("arm64: kernel: Add support for hibernate/suspend-to-disk")

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/kernel/hibernate.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index d52f69462c8f..ef46ce66d7e8 100644
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -217,6 +217,11 @@ static int create_safe_exec_page(void *src_start, size_t length,
 	__flush_icache_range(dst, dst + length);
 
 	trans_pgd = allocator(mask);
+	if (!trans_pgd) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
 	pgdp = pgd_offset_raw(trans_pgd, dst_addr);
 	if (pgd_none(READ_ONCE(*pgdp))) {
 		pudp = allocator(mask);
-- 
2.23.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
