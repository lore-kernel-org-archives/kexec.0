Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Z0mYJ-0004sJ-5T
 for kexec@lists.infradead.org; Fri, 05 Jun 2015 08:00:32 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
 [127.0.0.1])
 by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t557wYJa029017
 for <kexec@lists.infradead.org>; Fri, 5 Jun 2015 15:58:34 +0800
From: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
Subject: [PATCH RFC 06/11] Add filter_data_buffer_parallel
Date: Fri, 5 Jun 2015 15:57:00 +0800
Message-ID: <1433491025-7291-7-git-send-email-zhouwj-fnst@cn.fujitsu.com>
In-Reply-To: <1433491025-7291-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
References: <1433491025-7291-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
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
To: kexec@lists.infradead.org
Cc: Qiao Nuohan <qiaonuohan@cn.fujitsu.com>

From: Qiao Nuohan <qiaonuohan@cn.fujitsu.com>

filter_data_buffer_parallel is used to enable filtering buffer
parallely.

Signed-off-by: Qiao Nuohan <qiaonuohan@cn.fujitsu.com>
---
 erase_info.c |   29 ++++++++++++++++++++++++++++-
 erase_info.h |    2 ++
 2 files changed, 30 insertions(+), 1 deletions(-)

diff --git a/erase_info.c b/erase_info.c
index e0e0f71..0b253d7 100644
--- a/erase_info.c
+++ b/erase_info.c
@@ -2328,7 +2328,6 @@ extract_filter_info(unsigned long long start_paddr,
 	return TRUE;
 }
 
-
 /*
  * External functions.
  */
@@ -2413,6 +2412,34 @@ filter_data_buffer(unsigned char *buf, unsigned long long paddr,
 	}
 }
 
+/*
+ * Filter buffer if the physical address is in filter_info.
+ */
+void
+filter_data_buffer_parallel(unsigned char *buf, unsigned long long paddr,
+					size_t size, pthread_mutex_t *mutex)
+{
+	struct filter_info fl_info;
+	unsigned char *buf_ptr;
+	int found = FALSE;
+
+	while (TRUE) {
+		pthread_mutex_lock(mutex);
+		found = extract_filter_info(paddr, paddr + size, &fl_info);
+		pthread_mutex_unlock(mutex);
+
+		if (found) {
+			buf_ptr = buf + (fl_info.paddr - paddr);
+			if (fl_info.nullify)
+				memset(buf_ptr, 0, fl_info.size);
+			else
+				memset(buf_ptr, fl_info.erase_ch, fl_info.size);
+		} else {
+			break;
+		}
+	}
+}
+
 unsigned long
 get_size_eraseinfo(void)
 {
diff --git a/erase_info.h b/erase_info.h
index 4d4957e..b363a40 100644
--- a/erase_info.h
+++ b/erase_info.h
@@ -60,6 +60,8 @@ extern unsigned long		num_erase_info;
 int gather_filter_info(void);
 void clear_filter_info(void);
 void filter_data_buffer(unsigned char *buf, unsigned long long paddr, size_t size);
+void filter_data_buffer_parallel(unsigned char *buf, unsigned long long paddr,
+					size_t size, pthread_mutex_t *mutex);
 unsigned long get_size_eraseinfo(void);
 int update_filter_info_raw(unsigned long long, int, int);
 
-- 
1.7.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
