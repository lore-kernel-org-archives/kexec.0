Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1eg8xj-0005Ho-IG
 for kexec@lists.infradead.org; Mon, 29 Jan 2018 12:55:05 +0000
Received: by mail-pg0-x241.google.com with SMTP id z17so4389422pgc.4
 for <kexec@lists.infradead.org>; Mon, 29 Jan 2018 04:54:52 -0800 (PST)
From: Zhou Wenjian <zhouwj.fi@gmail.com>
Subject: [PATCH] makedumpfile: Fix a bug when multi-threads feature meets
 enospace
Date: Mon, 29 Jan 2018 20:54:39 +0800
Message-Id: <1517230479-8440-1-git-send-email-zhouwj.fi@gmail.com>
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
To: kexec@lists.infradead.org
Cc: ats-kumagai@wm.jp.nec.com, Zhou Wenjian <zhouwj.fi@gmail.com>

Currently, when multi-threads feature meets enospace error,
the main thread will call pthread_join(). However, there is one
thread doing while{} and won't stop.

                pthread_mutex_lock(&info->page_data_mutex);
                while (page_data_buf[index].used != FALSE) {
                        index = (index + 1) % info->num_buffers;
                }
                page_data_buf[index].used = TRUE;
                pthread_mutex_unlock(&info->page_data_mutex);

Then makedumpfile hangs.

This patch add a cancel point in while{}.

Signed-off-by: Zhou Wenjian <zhouwj.fi@gmail.com>
---
 makedumpfile.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index ed138d3..f7ad50c 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -7731,11 +7731,13 @@ kdump_thread_function_cyclic(void *arg) {
 		buf_ready = FALSE;
 
 		pthread_mutex_lock(&info->page_data_mutex);
+		pthread_cleanup_push(pthread_mutex_unlock, &info->page_data_mutex);
 		while (page_data_buf[index].used != FALSE) {
+			pthread_testcancel();
 			index = (index + 1) % info->num_buffers;
 		}
 		page_data_buf[index].used = TRUE;
-		pthread_mutex_unlock(&info->page_data_mutex);
+		pthread_cleanup_pop(1); 
 
 		while (buf_ready == FALSE) {
 			pthread_testcancel();
-- 
1.8.3.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
