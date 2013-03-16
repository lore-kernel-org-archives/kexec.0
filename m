Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UHmKl-0005qM-Cm
 for kexec@lists.infradead.org; Tue, 19 Mar 2013 02:31:28 +0000
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id E73C53EE0BC
 for <kexec@lists.infradead.org>; Tue, 19 Mar 2013 11:31:23 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id BF02945DECE
 for <kexec@lists.infradead.org>; Tue, 19 Mar 2013 11:31:23 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id A7CD445DECC
 for <kexec@lists.infradead.org>; Tue, 19 Mar 2013 11:31:23 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 970701DB803B
 for <kexec@lists.infradead.org>; Tue, 19 Mar 2013 11:31:23 +0900 (JST)
Received: from m1000.s.css.fujitsu.com (m1000.s.css.fujitsu.com
 [10.240.81.136])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 24A3F1DB8040
 for <kexec@lists.infradead.org>; Tue, 19 Mar 2013 11:31:23 +0900 (JST)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [PATCH v3 15/21] elf: introduce NT_VMCORE_PAD type
Date: Sat, 16 Mar 2013 13:02:11 +0900
Message-ID: <20130316040211.15064.1645.stgit@localhost6.localdomain6>
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

The NT_VMCORE_PAD type is introduced to make both crash_notes buffer
and vmcoreinfo_note buffer satisfy mmap()'s page-size boundary
requirement by filling them with this note type.

The purpose of this type is just to align the buffer in page-size
boundary; it has no meaning in contents, which are fully filled with
zero.

This note type belongs to "VMCOREINFO" name space and the type in this
name space is 7. The reason why the numbers from 1 to 5 is not chosen
is that for the ones from 1 to 4, there are the corresponding note
types using the same number in "CORE" name space, and crash utility
and makedumpfile don't distinguish note types by name space at all;
for the remaining 5, this has somehow not been used since v2.4.0
kernel despite the fact that NT_AUXV is defined as 6. It looks that it
avoids some dependency to 5. Here simply 5 is not chosen for
conservative viewpoint.

By this change, gdb and binutils work well without any change, but
makedumpfile and crash utility need their changes to distinguish two
note types in "VMCOREINFO" name space.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---

 include/uapi/linux/elf.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
index b869904..9753e4c 100644
--- a/include/uapi/linux/elf.h
+++ b/include/uapi/linux/elf.h
@@ -402,6 +402,7 @@ typedef struct elf64_shdr {
  * Notes exported from /proc/vmcore, belonging to "VMCOREINFO" name.
  */
 #define NT_VMCORE_DEBUGINFO	0	/* vmcore system kernel's debuginfo */
+#define NT_VMCORE_PAD		7	/* vmcore padding of note segments */
 
 /* Note header in a PT_NOTE section */
 typedef struct elf32_note {


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
