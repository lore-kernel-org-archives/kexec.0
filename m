Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1U5vnO-0002uS-LM
 for kexec@lists.infradead.org; Thu, 14 Feb 2013 10:12:03 +0000
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 2EB813EE0BD
 for <kexec@lists.infradead.org>; Thu, 14 Feb 2013 19:12:01 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 0E17845DEB6
 for <kexec@lists.infradead.org>; Thu, 14 Feb 2013 19:12:01 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id EB87645DEB2
 for <kexec@lists.infradead.org>; Thu, 14 Feb 2013 19:12:00 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id DD29BE18001
 for <kexec@lists.infradead.org>; Thu, 14 Feb 2013 19:12:00 +0900 (JST)
Received: from m1000.s.css.fujitsu.com (m1000.s.css.fujitsu.com
 [10.240.81.136])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 929811DB803C
 for <kexec@lists.infradead.org>; Thu, 14 Feb 2013 19:12:00 +0900 (JST)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [PATCH 03/13] vmcore: fill unused part of buffer for ELF headers with
 0
Date: Thu, 14 Feb 2013 19:11:59 +0900
Message-ID: <20130214101159.22466.38580.stgit@localhost6.localdomain6>
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

Via mmap() we export the range [elfcorebuf_sz, roundup(elfcorebuf_sz,
PAGE_SIZE)] to user-space. We need to fill this range with 0.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---

 fs/proc/vmcore.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 5010ead..43d338a 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -328,6 +328,11 @@ static int __init merge_note_headers_elf64(char *elfptr, size_t *elfsz,
 	*elfsz = *elfsz - i;
 	memmove(tmp, tmp+i, ((*elfsz)-sizeof(Elf64_Ehdr)-sizeof(Elf64_Phdr)));
 
+	/* Fill unused part with zero */
+	memset(elfptr + sizeof(Elf64_Ehdr) +
+	       (ehdr_ptr->e_phnum - nr_ptnote + 1) * sizeof(Elf64_Phdr), 0,
+	       (nr_ptnote - 1) * sizeof(Elf64_Phdr));
+
 	/* Modify e_phnum to reflect merged headers. */
 	ehdr_ptr->e_phnum = ehdr_ptr->e_phnum - nr_ptnote + 1;
 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
