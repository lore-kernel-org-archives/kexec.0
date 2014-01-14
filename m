Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1W39k0-0006vw-FR
 for kexec@lists.infradead.org; Tue, 14 Jan 2014 19:33:37 +0000
Date: Tue, 14 Jan 2014 14:33:11 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: [PATCH] kdump: Fix exported size of vmcoreinfo note
Message-ID: <20140114193311.GL3096@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: linux kernel mailing list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Greg KH <gregkh@suse.de>, Kexec Mailing List <kexec@lists.infradead.org>

Right now we seem to be exporting the max data size contained inside
vmcoreinfo note. But this does not include the size of meta data around
vmcore info data. Like name of the note and starting and ending elf_note.

I think user space expects total size and that size is put in PT_NOTE
elf header. Things seem to be fine so far because we are not using
vmcoreinfo note to the maximum capacity. But as it starts filling up,
to capacity, at some point of time, problem will be visible.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 kernel/ksysfs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/kernel/ksysfs.c
===================================================================
--- linux-2.6.orig/kernel/ksysfs.c	2014-01-14 14:09:42.107767503 -0500
+++ linux-2.6/kernel/ksysfs.c	2014-01-14 14:15:24.385510314 -0500
@@ -126,7 +126,7 @@ static ssize_t vmcoreinfo_show(struct ko
 {
 	return sprintf(buf, "%lx %x\n",
 		       paddr_vmcoreinfo_note(),
-		       (unsigned int)vmcoreinfo_max_size);
+		       (unsigned int)sizeof(vmcoreinfo_note));
 }
 KERNEL_ATTR_RO(vmcoreinfo);
 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
