Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1W6Gu7-00026Z-TR
 for kexec@lists.infradead.org; Thu, 23 Jan 2014 09:48:57 +0000
From: Baoquan He <bhe@redhat.com>
Subject: [v2 3/3] makedumpfile: remove member variables representing cyclic
 pfn region in struct DumpInfo
Date: Thu, 23 Jan 2014 17:47:34 +0800
Message-Id: <1390470454-14272-4-git-send-email-bhe@redhat.com>
In-Reply-To: <1390470454-14272-1-git-send-email-bhe@redhat.com>
References: <1390470454-14272-1-git-send-email-bhe@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: d.hatayama@jp.fujitsu.com, kumagai-atsushi@mxc.nes.nec.co.jp, Baoquan He <bhe@redhat.com>

Now member variables to store cyclic pfn region in struct DumpInfo
is not needed any more, remove them.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 makedumpfile.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/makedumpfile.h b/makedumpfile.h
index 38df2b3..0d5b086 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -1056,8 +1056,6 @@ struct DumpInfo {
 	 */
 	char               *partial_bitmap1;
 	char               *partial_bitmap2;
-	unsigned long long cyclic_start_pfn;
-	unsigned long long cyclic_end_pfn;  
 	unsigned long long num_dumpable;
 	unsigned long      bufsize_cyclic;
 	unsigned long      pfn_cyclic;
-- 
1.8.3.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
