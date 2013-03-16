Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UHmKd-0005lm-Vt
 for kexec@lists.infradead.org; Tue, 19 Mar 2013 02:31:21 +0000
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 757373EE0BB
 for <kexec@lists.infradead.org>; Tue, 19 Mar 2013 11:31:17 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
 by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 5872445DE5A
 for <kexec@lists.infradead.org>; Tue, 19 Mar 2013 11:31:17 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
 by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 3E51F45DE52
 for <kexec@lists.infradead.org>; Tue, 19 Mar 2013 11:31:17 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 2CD0EE18005
 for <kexec@lists.infradead.org>; Tue, 19 Mar 2013 11:31:17 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id DA2A31DB803B
 for <kexec@lists.infradead.org>; Tue, 19 Mar 2013 11:31:16 +0900 (JST)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [PATCH v3 14/21] kexec, elf: introduce NT_VMCORE_DEBUGINFO note type
Date: Sat, 16 Mar 2013 13:02:05 +0900
Message-ID: <20130316040205.15064.31351.stgit@localhost6.localdomain6>
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

This patch introduces NT_VMCORE_DEBUGINFO to a unique note type in
VMCOREINFO name, which has had no name so far. The name means that
it's a kind of note type in vmcoreinfo that contains system kernel's
debug information.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---

 include/uapi/linux/elf.h |    4 ++++
 kernel/kexec.c           |    4 ++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
index 8072d35..b869904 100644
--- a/include/uapi/linux/elf.h
+++ b/include/uapi/linux/elf.h
@@ -398,6 +398,10 @@ typedef struct elf64_shdr {
 #define NT_METAG_CBUF	0x500		/* Metag catch buffer registers */
 #define NT_METAG_RPIPE	0x501		/* Metag read pipeline state */
 
+/*
+ * Notes exported from /proc/vmcore, belonging to "VMCOREINFO" name.
+ */
+#define NT_VMCORE_DEBUGINFO	0	/* vmcore system kernel's debuginfo */
 
 /* Note header in a PT_NOTE section */
 typedef struct elf32_note {
diff --git a/kernel/kexec.c b/kernel/kexec.c
index 195de6d..6597b82 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -1438,8 +1438,8 @@ static void update_vmcoreinfo_note(void)
 
 	if (!vmcoreinfo_size)
 		return;
-	buf = append_elf_note(buf, VMCOREINFO_NOTE_NAME, 0, vmcoreinfo_data,
-			      vmcoreinfo_size);
+	buf = append_elf_note(buf, VMCOREINFO_NOTE_NAME, NT_VMCORE_DEBUGINFO,
+			      vmcoreinfo_data, vmcoreinfo_size);
 	final_note(buf);
 }
 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
