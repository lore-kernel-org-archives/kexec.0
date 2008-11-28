Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1L5zZD-0005lG-OA
	for kexec@lists.infradead.org; Fri, 28 Nov 2008 09:23:15 +0000
Date: Fri, 28 Nov 2008 10:23:11 +0100
Subject: [patch] Remove stdlib.h
Message-ID: <20081128092311.GA29648@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
From: bwalle@suse.de (Bernhard Walle)
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: oomichi@mxs.nes.nec.co.jp

This patch just removes stdlib.h reference in makedumpfile.c.
It's already included in makedumpfile.h.


Signed-off-by: Bernhard Walle <bwalle@suse.de>

---
 makedumpfile.c |    1 -
 1 file changed, 1 deletion(-)

--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -13,7 +13,6 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  */
-#include <stdlib.h>
 #include "makedumpfile.h"
 
 struct symbol_table	symbol_table;

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
