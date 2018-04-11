Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-Id: <ad8d17ccc79b8dc1a3d0153a8283d1c695fe5035.1523465700.git.geoff@infradead.org>
In-Reply-To: <cover.1523465700.git.geoff@infradead.org>
References: <cover.1523465700.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Subject: [PATCH 3/4] kexec-elf-rel-ppc64: Fix cast from pointer warning
Date: Wed, 11 Apr 2018 17:03:11 +0000
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
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org, Petitboot@lists.ozlabs.org

Fixes warnings like these when building kexec for powerpc (32 bit):

  kexec-elf-rel-ppc64.c: warning: cast from pointer to integer of different size

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 kexec/arch/ppc64/kexec-elf-rel-ppc64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kexec/arch/ppc64/kexec-elf-rel-ppc64.c b/kexec/arch/ppc64/kexec-elf-rel-ppc64.c
index 5f8e3f2..51b1354 100644
--- a/kexec/arch/ppc64/kexec-elf-rel-ppc64.c
+++ b/kexec/arch/ppc64/kexec-elf-rel-ppc64.c
@@ -104,7 +104,7 @@ void machine_apply_elf_rel(struct mem_ehdr *ehdr, struct mem_sym *sym,
 		break;
 
 	case R_PPC64_REL32:
-		*(uint32_t *)location = value - (uint32_t)(uint64_t)location;
+		*(uint32_t *)location = value - (uint32_t)location;
 		break;
 
 	case R_PPC64_TOC:
-- 
2.14.1



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
