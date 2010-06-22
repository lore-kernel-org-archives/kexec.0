Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
Subject: [PATCH 2/3] page_to_pfn(): use ULONGLONG_MAX to for invalid pfn
Date: Tue, 22 Jun 2010 09:59:11 +0300
Message-Id: <c9fc6b9efa07b4e203d9c4bf13c94e84e9d0bb40.1277188128.git.ext-mika.1.westerberg@nokia.com>
In-Reply-To: <cover.1277188127.git.ext-mika.1.westerberg@nokia.com>
References: <cover.1277188127.git.ext-mika.1.westerberg@nokia.com>
In-Reply-To: <cover.1277188127.git.ext-mika.1.westerberg@nokia.com>
References: <cover.1277188127.git.ext-mika.1.westerberg@nokia.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: oomichi@mxs.nes.nec.co.jp, tachibana@mxm.nes.nec.co.jp
Cc: kexec@lists.infradead.org, "\\\"Mika Westerberg\\\"" <ext-mika.1.westerberg@nokia.com>, linux-arm-kernel@lists.infradead.org

Some architectures define PHYS_PFN_OFFSET to be != 0 (ARM for example). This
means that mem_map[0] is actually first page in kernel direct mapped view (which
is a valid page).

Change invalid pfn to be ULONGLONG_MAX instead of 0 to handle such cases.

Signed-off-by: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
---
 makedumpfile.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index a33bab6..89360bd 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -4383,7 +4383,8 @@ unsigned long long
 page_to_pfn(unsigned long page)
 {
 	unsigned int num;
-	unsigned long long pfn = 0, index = 0;
+	unsigned long long pfn = ULONGLONG_MAX;
+	unsigned long long index = 0;
 	struct mem_map_data *mmd;
 
 	mmd = info->mem_map_data;
@@ -4398,7 +4399,7 @@ page_to_pfn(unsigned long page)
 		pfn = mmd->pfn_start + index;
 		break;
 	}
-	if (!pfn) {
+	if (pfn == ULONGLONG_MAX) {
 		ERRMSG("Can't convert the address of page descriptor (%lx) to pfn.\n", page);
 		return ULONGLONG_MAX;
 	}
-- 
1.5.6.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
