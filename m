Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from router-fw.net-space.pl ([89.174.63.77])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1Qv8WZ-0002Vz-Q6
	for kexec@lists.infradead.org; Sun, 21 Aug 2011 13:57:16 +0000
Received: (from localhost user: 'dkiper' uid#4000 fake: STDIN
	(dkiper@router-fw.net-space.pl)) by router-fw-old.local.net-space.pl
	id S1591920Ab1HUNyA (ORCPT <rfc822;kexec@lists.infradead.org>);
	Sun, 21 Aug 2011 15:54:00 +0200
Date: Sun, 21 Aug 2011 15:54:00 +0200
From: Daniel Kiper <dkiper@net-space.pl>
Subject: [PATCH 3/4] kexec/arch/i386: Rename fixup_memory_ranges_sysfs() to
	fixup_memory_ranges()
Message-ID: <20110821135400.GD17323@router-fw-old.local.net-space.pl>
Mime-Version: 1.0
Content-Disposition: inline
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: konrad.wilk@oracle.com, ian.campbell@citrix.com, vgoyal@redhat.com, horms@verge.net.au, olaf@aepfle.de, kexec@lists.infradead.org, xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org

Rename fixup_memory_ranges_sysfs() to fixup_memory_ranges().
It is generic function and it could be used to fixup memory
ranges from other sources than sysfs (e.g. Xen).

Signed-off-by: Daniel Kiper <dkiper@net-space.pl>
---
 kexec/arch/i386/kexec-x86-common.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kexec/arch/i386/kexec-x86-common.c b/kexec/arch/i386/kexec-x86-common.c
index 474e680..8f59c6c 100644
--- a/kexec/arch/i386/kexec-x86-common.c
+++ b/kexec/arch/i386/kexec-x86-common.c
@@ -149,7 +149,7 @@ static void remove_range(struct memory_range *range, int nr_ranges, int index)
  *
  * @return 0 on success, any other value on failure.
  */
-static int fixup_memory_ranges_sysfs(struct memory_range **range, int *ranges)
+static int fixup_memory_ranges(struct memory_range **range, int *ranges)
 {
 	int i;
 	int j;
@@ -162,7 +162,7 @@ again:
 	for (i = 0; i < (nr_ranges-1); i++) {
 		j = i+1;
 		if (rp[i].start > rp[j].start) {
-			fprintf(stderr, "sysfs memory out of order!!\n");
+			fprintf(stderr, "memory out of order!!\n");
 			return 1;
 		}
 
@@ -252,7 +252,7 @@ int get_memory_ranges(struct memory_range **range, int *ranges,
 	if (!efi_map_added() && !xen_present() && have_sys_firmware_memmap()) {
 		ret = get_memory_ranges_sysfs(range, ranges);
 		if (!ret)
-			ret = fixup_memory_ranges_sysfs(range, ranges);
+			ret = fixup_memory_ranges(range, ranges);
 	} else
 		ret = get_memory_ranges_proc_iomem(range, ranges);
 
-- 
1.5.6.5

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
