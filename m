Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from borg.tf-network.de ([62.75.218.204])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XKoot-0006Oz-Qs
 for kexec@lists.infradead.org; Fri, 22 Aug 2014 13:23:57 +0000
Message-ID: <53F74454.7000405@whissi.de>
Date: Fri, 22 Aug 2014 15:23:32 +0200
From: "Thomas D." <whissi@whissi.de>
MIME-Version: 1.0
Subject: Re: kexec fails to boot kernels where CONFIG_RANDOMIZE_BASE=y is set
References: <53F11882.3060803@whissi.de> <20140818145718.GD4745@redhat.com>
 <20140819090724.GB21724@dhcp-17-37.nay.redhat.com>
 <20140820143315.GC16303@redhat.com>
 <CAGXu5jLxEoKEy0nw8qj0MW0f2Vpog-DtDi7OwnUrkh7jGSkdWw@mail.gmail.com>
 <20140821181000.GB21891@redhat.com>
 <20140822031941.GB2651@dhcp-17-37.nay.redhat.com>
 <20140822115902.GA12681@dhcp-16-116.nay.redhat.com>
 <53F737ED.5070908@whissi.de> <20140822124032.GE5954@redhat.com>
In-Reply-To: <20140822124032.GE5954@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Kexec Mailing List <kexec@lists.infradead.org>, WANG Chao <chaowang@redhat.com>, Baoquan He <bhe@redhat.com>, Kees Cook <keescook@chromium.org>

Hi,

the patch works!

I am able to reboot my system using kexec when the kernel has this patch.

I had to slightly modify the patch, so it will apply against linux-3.15.10:

--- arch/x86/boot/compressed/misc.c.old	2014-08-22 14:52:20.792158801 +0200
+++ arch/x86/boot/compressed/misc.c	2014-08-22 14:58:21.250506919 +0200
@@ -230,8 +230,9 @@
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
@@ -242,7 +243,7 @@
 	 * Calculate the delta between where vmlinux was linked to load
 	 * and where it was actually loaded.
 	 */
-	delta = min_addr - LOAD_PHYSICAL_ADDR;
+	delta = min_addr - (unsigned long)output_orig;
 	if (!delta) {
 		debug_putstr("No relocation needed... ");
 		return;
@@ -299,7 +300,8 @@
 #endif
 }
 #else
-static inline void handle_relocations(void *output, unsigned long
output_len)
+static inline void handle_relocations(void *output_orig, void *output,
+				      unsigned long output_len)
 { }
 #endif

@@ -360,6 +362,8 @@
 				  unsigned char *output,
 				  unsigned long output_len)
 {
+	unsigned char *output_orig = output;
+
 	real_mode = rmode;

 	sanitize_boot_params(real_mode);
@@ -402,7 +406,7 @@
 	debug_putstr("\nDecompressing Linux... ");
 	decompress(input_data, input_len, NULL, NULL, output, NULL, error);
 	parse_elf(output);
-	handle_relocations(output, output_len);
+	handle_relocations(output_orig, output, output_len);
 	debug_putstr("done.\nBooting the kernel.\n");
 	return output;
 }




So now we have two "solutions":

1) Using kexec with "--entry-32bit" parameter

2) Use a patched kernel


-Thomas

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
