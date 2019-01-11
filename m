Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-yw1-xc44.google.com ([2607:f8b0:4864:20::c44])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghtbd-0003h5-8T
 for kexec@lists.infradead.org; Fri, 11 Jan 2019 10:00:05 +0000
Received: by mail-yw1-xc44.google.com with SMTP id b63so5565040ywc.11
 for <kexec@lists.infradead.org>; Fri, 11 Jan 2019 02:00:00 -0800 (PST)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v2 1/3] kexec: add variant helper functions for handling
 memory regions
Date: Fri, 11 Jan 2019 18:59:44 +0900
Message-Id: <20190111095946.28070-2-takahiro.akashi@linaro.org>
In-Reply-To: <20190111095946.28070-1-takahiro.akashi@linaro.org>
References: <20190111095946.28070-1-takahiro.akashi@linaro.org>
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
To: horms@verge.net.au, james.morse@arm.com, bhsharma@redhat.com
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>, kexec@lists.infradead.org

mem_regions_alloc_and_add() and mem_regions_alloc_and_exclude() are
functionally equivalent to, respectively, mem_regions_add() and
mem_regions_exclude() except the formers will re-allocate memory
dynamically when no more entries are available in 'ranges' array.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 kexec/mem_regions.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 kexec/mem_regions.h |  7 +++++++
 2 files changed, 49 insertions(+)

diff --git a/kexec/mem_regions.c b/kexec/mem_regions.c
index 50c8abccb93a..ad7d3f13fd84 100644
--- a/kexec/mem_regions.c
+++ b/kexec/mem_regions.c
@@ -125,3 +125,45 @@ int mem_regions_exclude(struct memory_ranges *ranges,
 	}
 	return 0;
 }
+
+#define KEXEC_MEMORY_RANGES 16
+
+int mem_regions_alloc_and_add(struct memory_ranges *ranges,
+			      unsigned long long base,
+			      unsigned long long length, int type)
+{
+	void *new_ranges;
+
+	if (ranges->size >= ranges->max_size) {
+		new_ranges = realloc(ranges->ranges,
+				sizeof(struct memory_range) *
+				(ranges->max_size + KEXEC_MEMORY_RANGES));
+		if (!new_ranges)
+			return -1;
+
+		ranges->ranges = new_ranges;
+		ranges->max_size += KEXEC_MEMORY_RANGES;
+	}
+
+	return mem_regions_add(ranges, base, length, type);
+}
+
+int mem_regions_alloc_and_exclude(struct memory_ranges *ranges,
+				  const struct memory_range *range)
+{
+	void *new_ranges;
+
+	/* for safety, we should have at least one free entry in ranges */
+	if (ranges->size >= ranges->max_size) {
+		new_ranges = realloc(ranges->ranges,
+				sizeof(struct memory_range) *
+				(ranges->max_size + KEXEC_MEMORY_RANGES));
+		if (!new_ranges)
+			return -1;
+
+		ranges->ranges = new_ranges;
+		ranges->max_size += KEXEC_MEMORY_RANGES;
+	}
+
+	return mem_regions_exclude(ranges, range);
+}
diff --git a/kexec/mem_regions.h b/kexec/mem_regions.h
index ae9e972b0206..e306d67e3261 100644
--- a/kexec/mem_regions.h
+++ b/kexec/mem_regions.h
@@ -12,4 +12,11 @@ int mem_regions_exclude(struct memory_ranges *ranges,
 int mem_regions_add(struct memory_ranges *ranges, unsigned long long base,
                     unsigned long long length, int type);
 
+int mem_regions_alloc_and_exclude(struct memory_ranges *ranges,
+				  const struct memory_range *range);
+
+int mem_regions_alloc_and_add(struct memory_ranges *ranges,
+			      unsigned long long base,
+			      unsigned long long length, int type);
+
 #endif
-- 
2.19.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
