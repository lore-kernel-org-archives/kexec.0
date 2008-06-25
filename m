Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KBapE-00063J-Mf
	for kexec@lists.infradead.org; Wed, 25 Jun 2008 19:38:41 +0000
From: Bernhard Walle <bwalle@suse.de>
Subject: [PATCH] x86: Limit E820 map when a user-defined memory map is
	specified
Date: Wed, 25 Jun 2008 21:39:16 +0200
Message-Id: <1214422756-10923-1-git-send-email-bwalle@suse.de>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: x86@kernel.org
Cc: Bernhard Walle <bwalle@suse.de>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, vgoyal@redhat.com, yhlu.kernel@gmail.com

This patch brings back limiting of the E820 map when a user-defined
E820 map is specified. While the behaviour of i386 (32 bit) was to limit
the E820 map (and /proc/iomem), the behaviour of x86-64 (64 bit) was not to
limit.

That patch limits the E820 map again for both x86 architectures.

Code was tested for compilation and booting on a 32 bit and 64 bit system.


Signed-off-by: Bernhard Walle <bwalle@suse.de>
---
 arch/x86/kernel/e820.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index a1b0548..3771386 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -988,6 +988,9 @@ static int __init parse_memopt(char *p)
 
 	mem_size = memparse(p, &p);
 	end_user_pfn = mem_size>>PAGE_SHIFT;
+	e820_update_range(mem_size, ULLONG_MAX - mem_size,
+		E820_RAM, E820_RESERVED);
+
 	return 0;
 }
 early_param("mem", parse_memopt);
@@ -1032,6 +1035,8 @@ static int __init parse_memmap_opt(char *p)
 		e820_add_region(start_at, mem_size, E820_RESERVED);
 	} else {
 		end_user_pfn = (mem_size >> PAGE_SHIFT);
+		e820_update_range(mem_size, ULLONG_MAX - mem_size,
+			E820_RAM, E820_RESERVED);
 	}
 	return *p == '\0' ? 0 : -EINVAL;
 }
-- 
1.5.4.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
