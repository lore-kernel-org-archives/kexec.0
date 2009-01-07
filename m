Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ozlabs.org ([203.10.76.45])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1LKRTx-0007Q8-9e
	for kexec@lists.infradead.org; Wed, 07 Jan 2009 06:01:34 +0000
Subject: [patch] Possible fix for kexec-tools dynamic range allocation
From: Michael Ellerman <michael@ellerman.id.au>
Date: Wed, 07 Jan 2009 17:01:26 +1100
Message-Id: <1231308086.27416.14.camel@localhost>
Mime-Version: 1.0
Reply-To: michael@ellerman.id.au
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: muvarov@gmail.com, linuxppc-dev list <linuxppc-dev@ozlabs.org>, mohan@in.ibm.com, Chandru <chandru@in.ibm.com>, Horms <horms@verge.net.au>

Hi all,

The patch to dynamically allocate memory regions for ppc64 kexec-tools,
ie. "ppc64: kexec memory ranges dynamic allocation" (d182ce5), has never
worked AFAICT.

Chandru reported it as broken when it was posted:
http://lists.infradead.org/pipermail/kexec/2008-October/002751.html

Still, it's in now, and I'm trying to work out what's going wrong.

The symptom is as reported by Chandru, we end up not being able to
allocate any memory (in locate_hole()). This is caused by the list of
memory_ranges being empty.

The memory_ranges are empty because they have been realloc'ed (by the
dynamic alloc code), and the generic code is still looking at the old
version.

What I'm not clear on is why the ppc64 code is even calling
setup_memory_ranges() a second time (in elf_ppc64_load()). It's already
been called by get_memory_ranges() from my_load(). Or is there another
route into elf_ppc64_load() that I'm not seeing?

And in fact if I just remove that call, then everything is peachy.

The following patch makes it work for me at least.

cheers

From 40958d8f957876ca612b666f40bebf28ea335314 Mon Sep 17 00:00:00 2001
From: Michael Ellerman <michael@ellerman.id.au>
Date: Wed, 7 Jan 2009 16:57:05 +1100
Subject: [PATCH] Don't call setup_memory_ranges() again

There's no need to call setup_memory_ranges() again. Furthermore it can
lead to the memory_ranges being realloc'ed, which results in the generic
code (locate_hole() etc.) using the free'd memory_ranges.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 kexec/arch/ppc64/kexec-elf-ppc64.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/kexec/arch/ppc64/kexec-elf-ppc64.c b/kexec/arch/ppc64/kexec-elf-ppc64.c
index 21533cb..1e2d5a3 100644
--- a/kexec/arch/ppc64/kexec-elf-ppc64.c
+++ b/kexec/arch/ppc64/kexec-elf-ppc64.c
@@ -151,8 +151,6 @@ int elf_ppc64_load(int argc, char **argv, const char *buf, off_t len,
 	if (ramdisk && reuse_initrd)
 		die("Can't specify --ramdisk or --initrd with --reuseinitrd\n");
 
-	setup_memory_ranges(info->kexec_flags);
-
 	/* Need to append some command line parameters internally in case of
 	 * taking crash dumps.
 	 */
-- 
1.5.3.7.1.g4e596e




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
