Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from rv-out-0708.google.com ([209.85.198.240])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KsFrz-0001dg-6d
	for kexec@lists.infradead.org; Tue, 21 Oct 2008 11:57:51 +0000
Received: by rv-out-0708.google.com with SMTP id b17so2264532rvf.42
	for <kexec@lists.infradead.org>; Tue, 21 Oct 2008 04:57:49 -0700 (PDT)
From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 21 Oct 2008 20:56:38 +0900
Message-Id: <20081021115638.27749.59642.sendpatchset@rx1.opensource.se>
Subject: [PATCH] vmcore: Remove saved_max_pfn check
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: akpm@linux-foundation.org, horms@verge.net.au, Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org, vgoyal@redhat.com

From: Magnus Damm <damm@igel.co.jp>

This patch removes the saved_max_pfn check from the /proc/vmcore
function read_from_oldmem(). No need to verify, we should be able
to just trust that "elfcorehdr=" is correctly passed to the crash
kernel on the kernel command line like we do with other parameters.

The read_from_oldmem() function in fs/proc/vmcore.c is quite similar
to read_from_oldmem() in drivers/char/mem.c, but only in the latter
it makes sense to use saved_max_pfn. For oldmem it is used to determine
when to stop reading. For vmcore we already have the elf header info
pointing out the physical memory regions, no need to pass the end-of-
old-memory twice.

Removing the saved_max_pfn check from vmcore makes it possible for
architectures to skip oldmem but still support crash dump through
vmcore - without the need for the old saved_max_pfn cruft.

Architectures that want to play safe can do the saved_max_pfn check
in copy_oldmem_page(). Not sure why anyone would want to do that,
but that's even safer than today - the saved_max_pfn check in vmcore
removed by this patch only checks the first page.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
Acked-by: Vivek Goyal <vgoyal@redhat.com>
Acked-by: Simon Horman <horms@verge.net.au>
---

 Andrew, can you please pick up this one?

 fs/proc/vmcore.c |    2 --
 1 file changed, 2 deletions(-)

--- 0001/fs/proc/vmcore.c
+++ work/fs/proc/vmcore.c	2008-10-21 20:45:15.000000000 +0900
@@ -47,8 +47,6 @@ static ssize_t read_from_oldmem(char *bu
 
 	offset = (unsigned long)(*ppos % PAGE_SIZE);
 	pfn = (unsigned long)(*ppos / PAGE_SIZE);
-	if (pfn > saved_max_pfn)
-		return -EINVAL;
 
 	do {
 		if (count > (PAGE_SIZE - offset))

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
