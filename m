Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VjBwY-00007f-60
 for kexec@lists.infradead.org; Wed, 20 Nov 2013 17:52:04 +0000
From: Vivek Goyal <vgoyal@redhat.com>
Subject: [PATCH 1/6] kexec: Export vmcoreinfo note size properly
Date: Wed, 20 Nov 2013 12:50:46 -0500
Message-Id: <1384969851-7251-2-git-send-email-vgoyal@redhat.com>
In-Reply-To: <1384969851-7251-1-git-send-email-vgoyal@redhat.com>
References: <1384969851-7251-1-git-send-email-vgoyal@redhat.com>
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
To: linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Cc: mjg59@srcf.ucam.org, greg@kroah.com, ebiederm@xmission.com, Vivek Goyal <vgoyal@redhat.com>, hpa@zytor.com

Right now we seem to be exporting the max data size contained inside
vmcoreinfo note. But this does not include the size of meta data around
vmcore info data. Like name of the note and starting and ending elf_note.

I think user space expects total size and that size is put in PT_NOTE
elf header.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 kernel/ksysfs.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/kernel/ksysfs.c b/kernel/ksysfs.c
index 9659d38..d945a94 100644
--- a/kernel/ksysfs.c
+++ b/kernel/ksysfs.c
@@ -126,7 +126,7 @@ static ssize_t vmcoreinfo_show(struct kobject *kobj,
 {
 	return sprintf(buf, "%lx %x\n",
 		       paddr_vmcoreinfo_note(),
-		       (unsigned int)vmcoreinfo_max_size);
+		       (unsigned int)sizeof(vmcoreinfo_note));
 }
 KERNEL_ATTR_RO(vmcoreinfo);
 
-- 
1.7.7.6


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
