Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WpAK0-0003Fd-8L
 for kexec@lists.infradead.org; Tue, 27 May 2014 05:53:12 +0000
Date: Tue, 27 May 2014 13:52:46 +0800
From: Dave Young <dyoung@redhat.com>
Subject: [PATCH 2/2 resend] kexec-tools: usage text fix
Message-ID: <20140526084856.GA19921@dhcp-16-198.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140526084856.GA19920@dhcp-16-198.nay.redhat.com>
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
To: kexec@lists.infradead.org, horms@verge.net.au, vgoyal@redhat.com

There's one more '-' in arch_usage, thus
s/pass--memmap-cmdline/pass-memmap-cmdline

Signed-off-by: Dave Young <dyoung@redhat.com>
---
 kexec/arch/i386/kexec-x86.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: kexec-tools/kexec/arch/i386/kexec-x86.c
===================================================================
--- kexec-tools.orig/kexec/arch/i386/kexec-x86.c
+++ kexec-tools/kexec/arch/i386/kexec-x86.c
@@ -54,7 +54,7 @@ void arch_usage(void)
 		"     --console-serial          Enable the serial console\n"
 		"     --elf32-core-headers      Prepare core headers in ELF32 format\n"
 		"     --elf64-core-headers      Prepare core headers in ELF64 format\n"
-		"     --pass--memmap-cmdline    Pass memory map via command line in kexec on panic case\n"
+		"     --pass-memmap-cmdline     Pass memory map via command line in kexec on panic case\n"
 		"     --noefi                   Disable efi support\n"
 		);
 }

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
