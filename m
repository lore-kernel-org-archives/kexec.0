Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ihcQ4-0006Zr-UV
 for kexec@lists.infradead.org; Wed, 18 Dec 2019 16:43:32 +0000
Received: by mail-qk1-x744.google.com with SMTP id c16so2093172qko.6
 for <kexec@lists.infradead.org>; Wed, 18 Dec 2019 08:43:27 -0800 (PST)
From: Masayoshi Mizuma <msys.mizuma@gmail.com>
Subject: [PATCH v3 1/3] kexec: add variant helper functions for handling
 memory regions
Date: Wed, 18 Dec 2019 11:42:30 -0500
Message-Id: <20191218164232.6086-2-msys.mizuma@gmail.com>
In-Reply-To: <20191218164232.6086-1-msys.mizuma@gmail.com>
References: <20191218164232.6086-1-msys.mizuma@gmail.com>
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
To: kexec mailing list <kexec@lists.infradead.org>, Simon Horman <horms@verge.net.au>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>, Bhupesh Sharma <bhsharma@redhat.com>, Masayoshi Mizuma <msys.mizuma@gmail.com>, James Morse <james.morse@arm.com>

From: AKASHI Takahiro <takahiro.akashi@linaro.org>

mem_regions_alloc_and_add() and mem_regions_alloc_and_exclude() are
functionally equivalent to, respectively, mem_regions_add() and
mem_regions_exclude() except the formers will re-allocate memory
dynamically when no more entries are available in 'ranges' array.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Tested-by: Bhupesh Sharma <bhsharma@redhat.com>
Tested-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
---
 kexec/mem_regions.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 kexec/mem_regions.h |  7 +++++++
 2 files changed, 49 insertions(+)

diff --git a/kexec/mem_regions.c b/kexec/mem_regions.c
index 50c8abc..ad7d3f1 100644
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
index ae9e972..e306d67 100644
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
2.18.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
