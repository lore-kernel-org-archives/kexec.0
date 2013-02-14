Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1U5vnq-00035y-1e
 for kexec@lists.infradead.org; Thu, 14 Feb 2013 10:12:31 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 6A1893EE0AE
 for <kexec@lists.infradead.org>; Thu, 14 Feb 2013 19:12:28 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 4CA1945DE53
 for <kexec@lists.infradead.org>; Thu, 14 Feb 2013 19:12:28 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 33A7B45DD78
 for <kexec@lists.infradead.org>; Thu, 14 Feb 2013 19:12:28 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 26A061DB8038
 for <kexec@lists.infradead.org>; Thu, 14 Feb 2013 19:12:28 +0900 (JST)
Received: from m1000.s.css.fujitsu.com (m1000.s.css.fujitsu.com
 [10.240.81.136])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id D2D72E08002
 for <kexec@lists.infradead.org>; Thu, 14 Feb 2013 19:12:27 +0900 (JST)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [PATCH 08/13] vmcore: remove unused helper function
Date: Thu, 14 Feb 2013 19:12:27 +0900
Message-ID: <20130214101227.22466.12503.stgit@localhost6.localdomain6>
In-Reply-To: <20130214100945.22466.4172.stgit@localhost6.localdomain6>
References: <20130214100945.22466.4172.stgit@localhost6.localdomain6>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: ebiederm@xmission.com, vgoyal@redhat.com, cpw@sgi.com, kumagai-atsushi@mxc.nes.nec.co.jp, lisa.mitchell@hp.com
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org

Remove map_offset_to_paddr(), which is no longer used.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---

 fs/proc/vmcore.c |   21 ---------------------
 1 files changed, 0 insertions(+), 21 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 4125a65..3aedb52 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -117,27 +117,6 @@ static ssize_t read_from_oldmem(char *buf, size_t count,
 	return read;
 }
 
-/* Maps vmcore file offset to respective physical address in memroy. */
-static u64 map_offset_to_paddr(loff_t offset, struct list_head *vc_list,
-					struct vmcore **m_ptr)
-{
-	struct vmcore *m;
-	u64 paddr;
-
-	list_for_each_entry(m, vc_list, list) {
-		u64 start, end;
-		start = m->offset;
-		end = m->offset + m->size - 1;
-		if (offset >= start && offset <= end) {
-			paddr = m->paddr + offset - start;
-			*m_ptr = m;
-			return paddr;
-		}
-	}
-	*m_ptr = NULL;
-	return 0;
-}
-
 /* Read from the ELF header and then the crash dump. On error, negative value is
  * returned otherwise number of bytes read are returned.
  */


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
