Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from router-fw.net-space.pl ([89.174.63.77])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1Qv8WY-0002Vz-NB
	for kexec@lists.infradead.org; Sun, 21 Aug 2011 13:57:15 +0000
Received: (from localhost user: 'dkiper' uid#4000 fake: STDIN
	(dkiper@router-fw.net-space.pl)) by router-fw-old.local.net-space.pl
	id S1592049Ab1HUNwm (ORCPT <rfc822;kexec@lists.infradead.org>);
	Sun, 21 Aug 2011 15:52:42 +0200
Date: Sun, 21 Aug 2011 15:52:42 +0200
From: Daniel Kiper <dkiper@net-space.pl>
Subject: [PATCH 2/4] kexec: Export compare_ranges() function from
	firmware_memmap.c module
Message-ID: <20110821135242.GC17323@router-fw-old.local.net-space.pl>
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

Export compare_ranges() function from firmware_memmap.c module.
It is generic function and it could be used by other modules.

Signed-off-by: Daniel Kiper <dkiper@net-space.pl>
---
 kexec/firmware_memmap.c |   14 ++------------
 kexec/firmware_memmap.h |   13 +++++++++++++
 2 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/kexec/firmware_memmap.c b/kexec/firmware_memmap.c
index d8afed5..9598933 100644
--- a/kexec/firmware_memmap.c
+++ b/kexec/firmware_memmap.c
@@ -179,18 +179,8 @@ static int parse_memmap_entry(const char *entry, struct memory_range *range)
 	return 0;
 }
 
-/**
- * Compares two memory ranges according to their start address. This function
- * can be used with qsort() as @c compar function.
- *
- * @param[in] first a pointer to the first memory range
- * @param[in] second a pointer to the second memory range
- * @return 0 if @p first and @p second have the same start address,
- *         a value less then 0 if the start address of @p first is less than
- *         the start address of @p second, and a value greater than 0 if
- *         the opposite is in case.
- */
-static int compare_ranges(const void *first, const void *second)
+/* documentation: firmware_memmap.h */
+int compare_ranges(const void *first, const void *second)
 {
 	const struct memory_range *first_range = first;
 	const struct memory_range *second_range = second;
diff --git a/kexec/firmware_memmap.h b/kexec/firmware_memmap.h
index adb03c3..eac0ddb 100644
--- a/kexec/firmware_memmap.h
+++ b/kexec/firmware_memmap.h
@@ -39,6 +39,19 @@
  */
 
 /**
+ * Compares two memory ranges according to their start address. This function
+ * can be used with qsort() as @c compar function.
+ *
+ * @param[in] first a pointer to the first memory range
+ * @param[in] second a pointer to the second memory range
+ * @return 0 if @p first and @p second have the same start address,
+ *         a value less then 0 if the start address of @p first is less than
+ *         the start address of @p second, and a value greater than 0 if
+ *         the opposite is in case.
+ */
+int compare_ranges(const void *first, const void *second);
+
+/**
  * Checks if the kernel provides the /sys/firmware/memmap interface.
  * It makes sense to use that function in advance before calling
  * get_firmware_memmap_ranges() because the latter function prints an error
-- 
1.5.6.5

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
