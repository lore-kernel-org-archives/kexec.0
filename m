Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UHmKN-0005bX-KW
 for kexec@lists.infradead.org; Tue, 19 Mar 2013 02:31:05 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id EED213EE0C3
 for <kexec@lists.infradead.org>; Tue, 19 Mar 2013 11:31:00 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id D634345DE50
 for <kexec@lists.infradead.org>; Tue, 19 Mar 2013 11:31:00 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id C029045DE4D
 for <kexec@lists.infradead.org>; Tue, 19 Mar 2013 11:31:00 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id B4855E38001
 for <kexec@lists.infradead.org>; Tue, 19 Mar 2013 11:31:00 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 6CDDA1DB802C
 for <kexec@lists.infradead.org>; Tue, 19 Mar 2013 11:31:00 +0900 (JST)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [PATCH v3 11/21] vmcore: read buffers for vmcore objects copied from
 old memory
Date: Sat, 16 Mar 2013 13:01:49 +0900
Message-ID: <20130316040149.15064.6738.stgit@localhost6.localdomain6>
In-Reply-To: <20130316040003.15064.62308.stgit@localhost6.localdomain6>
References: <20130316040003.15064.62308.stgit@localhost6.localdomain6>
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
To: vgoyal@redhat.com, ebiederm@xmission.com, cpw@sgi.com, kumagai-atsushi@mxc.nes.nec.co.jp, lisa.mitchell@hp.com, heiko.carstens@de.ibm.com, akpm@linux-foundation.org
Cc: zhangyanfei@cn.fujitsu.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

If flag MEM_TYPE_CURRENT_KERNEL is set, the object is copied in the
buffer on the 2nd kernel, then read_vmcore() reads the buffer. If the
flag is not set, read_vmcore() reads old memory as usual.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---

 fs/proc/vmcore.c |   15 +++++++++++----
 1 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 7e21d64..b252d17 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -158,10 +158,17 @@ static ssize_t read_vmcore(struct file *file, char __user *buffer,
 			tsz = m->offset + m->size - *fpos;
 			if (buflen < tsz)
 				tsz = buflen;
-			start = m->paddr + *fpos - m->offset;
-			tmp = read_from_oldmem(buffer, tsz, &start, 1);
-			if (tmp < 0)
-				return tmp;
+			if (m->flag & MEM_TYPE_CURRENT_KERNEL) {
+				if (copy_to_user(buffer,
+						 m->buf + *fpos - m->offset,
+						 tsz))
+					return -EFAULT;
+			} else {
+				start = m->paddr + *fpos - m->offset;
+				tmp = read_from_oldmem(buffer, tsz, &start, 1);
+				if (tmp < 0)
+					return tmp;
+			}
 			buflen -= tsz;
 			*fpos += tsz;
 			buffer += tsz;


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
