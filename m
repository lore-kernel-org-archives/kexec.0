Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XKnVA-0007R3-GU
 for kexec@lists.infradead.org; Fri, 22 Aug 2014 11:59:29 +0000
Date: Fri, 22 Aug 2014 19:59:02 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: kexec fails to boot kernels where CONFIG_RANDOMIZE_BASE=y is set
Message-ID: <20140822115902.GA12681@dhcp-16-116.nay.redhat.com>
References: <53F11882.3060803@whissi.de> <20140818145718.GD4745@redhat.com>
 <20140819090724.GB21724@dhcp-17-37.nay.redhat.com>
 <20140820143315.GC16303@redhat.com>
 <CAGXu5jLxEoKEy0nw8qj0MW0f2Vpog-DtDi7OwnUrkh7jGSkdWw@mail.gmail.com>
 <20140821181000.GB21891@redhat.com>
 <20140822031941.GB2651@dhcp-17-37.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140822031941.GB2651@dhcp-17-37.nay.redhat.com>
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
To: WANG Chao <chaowang@redhat.com>
Cc: "Thomas D." <whissi@whissi.de>, Kexec Mailing List <kexec@lists.infradead.org>, Kees Cook <keescook@chromium.org>, Vivek Goyal <vgoyal@redhat.com>

On 08/22/14 at 11:19am, WANG Chao wrote:
> On 08/21/14 at 02:10pm, Vivek Goyal wrote:
> >
> > If kernel is being moved physically, then we potentially have the issue of
> > it stomping other things. So how do we make sure that it does not overwrite
> > initramfs, or previous kernel's page tables or something else?
> 
> In case you don't read that part, memory of initrd, cmdline and others
> won't be overwritten.
> 
> This work is done in x86/boot/compressed/aslr.c::mem_avoid_init().

Yeah, it's just as Chao said.

And I think it's still about the relocation calculation issue. I tried
the patch Lu Yinghai suggested, now kexec can work.

But this patch only make kexec work. The slot choosing still
doesn't work per the limitation checking, since only range below
CONFIG_RANDOMIZE_BASE_MAX_OFFSET can be chosen and kexec-tools
always likes putting kexec kernel from the end of system ram.

So we have 2 choices for kexec/kdump:
1) kexec/kdump kernel need not randomize the kernel starting point.
Since kexec/kdump kernel is only for testing or emergencey, its life is
not too long.

2) makes slots around the kernel input addr. This is only useful for
kexec. I can't imagine why kdump need it. 




Hi Thomas,
Could you test below patch? 


This is patch is from Lu Yinghai.
---
 arch/x86/boot/compressed/misc.c |   14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

Index: linux-2.6/arch/x86/boot/compressed/misc.c
===================================================================
--- linux-2.6.orig/arch/x86/boot/compressed/misc.c
+++ linux-2.6/arch/x86/boot/compressed/misc.c
@@ -235,8 +235,9 @@ static void error(char *x)
 		asm("hlt");
 }
 
-#if CONFIG_X86_NEED_RELOCS
-static void handle_relocations(void *output, unsigned long output_len)
+#ifdef CONFIG_X86_NEED_RELOCS
+static void handle_relocations(void *output_orig, void *output,
+			       unsigned long output_len)
 {
 	int *reloc;
 	unsigned long delta, map, ptr;
@@ -247,7 +248,7 @@ static void handle_relocations(void *out
 	 * Calculate the delta between where vmlinux was linked to load
 	 * and where it was actually loaded.
 	 */
-	delta = min_addr - LOAD_PHYSICAL_ADDR;
+	delta = min_addr - (unsigned long)output_orig;
 	if (!delta) {
 		debug_putstr("No relocation needed... ");
 		return;
@@ -304,7 +305,8 @@ static void handle_relocations(void *out
 #endif
 }
 #else
-static inline void handle_relocations(void *output, unsigned long output_len)
+static inline void handle_relocations(void *output_orig, void *output,
+				      unsigned long output_len)
 { }
 #endif
 
@@ -365,6 +367,8 @@ asmlinkage void *decompress_kernel(void
 				  unsigned char *output,
 				  unsigned long output_len)
 {
+	unsigned char *output_orig = output;
+
 	real_mode = rmode;
 
 	sanitize_boot_params(real_mode);
@@ -417,7 +421,7 @@ asmlinkage void *decompress_kernel(void
 	debug_putstr("... ");
 	decompress(input_data, input_len, NULL, NULL, output, NULL, error);
 	parse_elf(output);
-	handle_relocations(output, output_len);
+	handle_relocations(output_orig, output, output_len);
 	debug_putstr("done.\nBooting the kernel.\n");
 	return output;
 }

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
