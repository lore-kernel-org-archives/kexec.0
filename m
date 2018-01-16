Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo162.gate.nec.co.jp ([114.179.232.162])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1ebMlQ-0004zB-94
 for kexec@lists.infradead.org; Tue, 16 Jan 2018 08:38:40 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: RE: [PATCH 4.14 023/159] mm/sparsemem: Allocate mem_section at
 runtime for CONFIG_SPARSEMEM_EXTREME=y
Date: Tue, 16 Jan 2018 08:36:41 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701F35B81@BPXM01GP.gisp.nec.co.jp>
References: <20180108160444.2ol4fvgqbxnjmlpg@gmail.com>
 <20180108174653.7muglyihpngxp5tl@black.fi.intel.com>
 <20180109001303.dy73bpixsaegn4ol@node.shutemov.name>
 <20180109010927.GA2082@dhcp-128-65.nay.redhat.com>
 <20180109054131.GB1935@localhost.localdomain>
 <20180109072440.GA6521@dhcp-128-65.nay.redhat.com>
 <20180109090552.45ddfk2y25lf4uyn@node.shutemov.name>
 <20180110030804.GB1744@dhcp-128-110.nay.redhat.com>
 <20180110111603.56disgew7ipusgjy@black.fi.intel.com>
 <20180112005549.GA2265@dhcp-128-65.nay.redhat.com>
 <20180115055701.GA9071@vader>
In-Reply-To: <20180115055701.GA9071@vader>
Content-Language: ja-JP
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
To: Omar Sandoval <osandov@osandov.com>, Dave Young <dyoung@redhat.com>
Cc: Ingo Molnar <mingo@kernel.org>, Keiichirou Suzuki <kei-suzuki@xr.jp.nec.com>, Baoquan He <bhe@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mike Galbraith <efault@gmx.de>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, Andy Lutomirski <luto@amacapital.net>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Cyrill Gorcunov <gorcunov@openvz.org>, "Kirill A. Shutemov" <kirill@shutemov.name>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>

>Hm, this fix means that the vmlinux symbol table and vmcoreinfo have
>different values for mem_section. That seems... odd. I had to patch
>makedumpfile to fix the case of an explicit vmlinux being passed on the
>command line (which I realized I don't need to do, but it should still
>work):

Looks good to me, I'll merge this into makedumpfile-1.6.4.

Thanks,
Atsushi Kumagai

From 542a11a8f28b0f0a989abc3adff89da22f44c719 Mon Sep 17 00:00:00 2001
>Message-Id: <542a11a8f28b0f0a989abc3adff89da22f44c719.1515995400.git.osandov@fb.com>
>From: Omar Sandoval <osandov@fb.com>
>Date: Sun, 14 Jan 2018 17:10:30 -0800
>Subject: [PATCH] Fix SPARSEMEM_EXTREME support on Linux v4.15 when passing
> vmlinux
>
>Since kernel commit 83e3c48729d9 ("mm/sparsemem: Allocate mem_section at
>runtime for CONFIG_SPARSEMEM_EXTREME=y"), mem_section is a dynamically
>allocated array of pointers to mem_section instead of a static one
>(i.e., struct mem_section ** instead of struct mem_section * []). This
>adds an extra layer of indirection that breaks makedumpfile, which will
>end up with a bunch of bogus mem_maps.
>
>Since kernel commit a0b1280368d1 ("kdump: write correct address of
>mem_section into vmcoreinfo"), the mem_section symbol in vmcoreinfo
>contains the address of the actual struct mem_section * array instead of
>the address of the pointer in .bss, which gets rid of the extra
>indirection. However, makedumpfile still uses the debugging symbol from
>the vmlinux image. Fix this by allowing symbols from the vmcore to
>override symbols from the vmlinux image. As the comment in initial()
>says, "vmcoreinfo in /proc/vmcore is more reliable than -x/-i option".
>
>Signed-off-by: Omar Sandoval <osandov@fb.com>
>---
> makedumpfile.h | 6 ++++--
> 1 file changed, 4 insertions(+), 2 deletions(-)
>
>diff --git a/makedumpfile.h b/makedumpfile.h
>index 57cf4d9..d68c798 100644
>--- a/makedumpfile.h
>+++ b/makedumpfile.h
>@@ -274,8 +274,10 @@ do { \
> } while (0)
> #define READ_SYMBOL(str_symbol, symbol) \
> do { \
>-	if (SYMBOL(symbol) == NOT_FOUND_SYMBOL) { \
>-		SYMBOL(symbol) = read_vmcoreinfo_symbol(STR_SYMBOL(str_symbol)); \
>+	unsigned long _tmp_symbol; \
>+	_tmp_symbol = read_vmcoreinfo_symbol(STR_SYMBOL(str_symbol)); \
>+	if (_tmp_symbol != NOT_FOUND_SYMBOL) { \
>+		SYMBOL(symbol) = _tmp_symbol; \
> 		if (SYMBOL(symbol) == INVALID_SYMBOL_DATA) \
> 			return FALSE; \
> 	} \
>--
>2.9.5
>
>
>_______________________________________________
>kexec mailing list
>kexec@lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/kexec


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
