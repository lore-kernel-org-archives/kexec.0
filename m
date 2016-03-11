Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aeGbw-00032L-7S
 for kexec@lists.infradead.org; Fri, 11 Mar 2016 06:31:45 +0000
Message-Id: <20160311062953.571397512@redhat.com>
Date: Fri, 11 Mar 2016 14:21:57 +0800
From: dyoung@redhat.com
Subject: [PATCH 1/2] [PATCH 1/2] Introduce new macros min_lt and max_lt for
 comparing with larger type
MIME-Version: 1.0
Content-Disposition: inline;
 filename=0001-Introduce-new-macros-min_lt-and-max_lt-for-comparing.patch
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
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, d.hatayama@jp.fujitsu.com, bhe@redhat.com, vgoyal@redhat.com
Cc: kexec@lists.infradead.org, dyoung@redhat.com

A useful use case for min_t and max_t is comparing two values with larger
type. For example comparing an u64 and an u32, usually we do not want to
truncate the u64, so we need use min_t or max_t with u64.

To simplify the usage introducing two more macros min_lt and max_lt,
'lt' means larger type.

Signed-off-by: Dave Young <dyoung@redhat.com>
---
 include/linux/kernel.h |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- linux.orig/include/linux/kernel.h
+++ linux/include/linux/kernel.h
@@ -798,6 +798,19 @@ static inline void ftrace_dump(enum ftra
 	type __max2 = (y);			\
 	__max1 > __max2 ? __max1: __max2; })
 
+/*
+ * use type of larger size in min_lt and max_lt
+ */
+#define min_lt(x, y) ({			\
+	int sx = sizeof(typeof(x));             \
+	int sy = sizeof(typeof(y));             \
+	sx > sy ? min_t(typeof(x), x, y) : min_t(typeof(y), x, y); })
+
+#define max_lt(x, y) ({			\
+	int sx = sizeof(typeof(x));             \
+	int sy = sizeof(typeof(y));             \
+	sx > sy ? max_t(typeof(x), x, y) : max_t(typeof(y), x, y); })
+
 /**
  * clamp_t - return a value clamped to a given range using a given type
  * @type: the type of variable to use



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
