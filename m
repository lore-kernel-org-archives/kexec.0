Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kroah.org ([198.145.64.141] helo=coco.kroah.org)
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1PJYyW-0001cU-Uo
	for kexec@lists.infradead.org; Fri, 19 Nov 2010 21:58:33 +0000
Message-Id: <20101119215640.476005407@clark.site>
Date: Fri, 19 Nov 2010 13:55:42 -0800
From: Greg KH <gregkh@suse.de>
Subject: [21/82] x86, kdump: Change copy_oldmem_page() to use cached addressing
In-Reply-To: <20101119215658.GA7804@kroah.com
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Ingo Molnar <mingo@elte.hu>, kexec@lists.infradead.org, Cliff Wickman <cpw@sgi.com>, "Eric W. Biederman" <ebiederm@xmission.com>, akpm@linux-foundation.org, torvalds@linux-foundation.org, stable-review@kernel.org, alan@lxorguk.ukuu.org.uk

2.6.35-stable review patch.  If anyone has any objections, please let us know.

------------------

From: Cliff Wickman <cpw@sgi.com>

commit 37a2f9f30a360fb03522d15c85c78265ccd80287 upstream.

The copy of /proc/vmcore to a user buffer proceeds much faster
if the kernel addresses memory as cached.

With this patch we have seen an increase in transfer rate from
less than 15MB/s to 80-460MB/s, depending on size of the
transfer. This makes a big difference in time needed to save a
system dump.

Signed-off-by: Cliff Wickman <cpw@sgi.com>
Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: kexec@lists.infradead.org
LKML-Reference: <E1OtMLz-0001yp-Ia@eag09.americas.sgi.com>
Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 arch/x86/kernel/crash_dump_64.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kernel/crash_dump_64.c
+++ b/arch/x86/kernel/crash_dump_64.c
@@ -34,7 +34,7 @@ ssize_t copy_oldmem_page(unsigned long p
 	if (!csize)
 		return 0;
 
-	vaddr = ioremap(pfn << PAGE_SHIFT, PAGE_SIZE);
+	vaddr = ioremap_cache(pfn << PAGE_SHIFT, PAGE_SIZE);
 	if (!vaddr)
 		return -ENOMEM;
 



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
