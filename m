Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1Mb8Si-0007xS-5e
	for kexec@lists.infradead.org; Wed, 12 Aug 2009 07:41:36 +0000
Message-ID: <4A827223.8090907@suse.de>
Date: Wed, 12 Aug 2009 09:41:23 +0200
From: Hannes Reinecke <hare@suse.de>
MIME-Version: 1.0
Subject: [PATCH] Increase kernel text size for x86_64
Content-Type: multipart/mixed; boundary="------------060901090906070506000801"
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: kexec mailing list <kexec@lists.infradead.org>

This is a multi-part message in MIME format.
--------------060901090906070506000801
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi all,

I cannot load a x86_64 kernel with kexec on 2.6.31; the error message is:

Can't find kernel text map area from kcore
Cannot load /boot/vmlinuz

Digging through the source I found a mismatch between the assumed
kernel text size; kexec has:

#define KERNEL_TEXT_SIZE  (40UL*1024*1024)

but on the kernel side we have:

include/asm/page_64_types.h:
#define KERNEL_IMAGE_SIZE   (512 * 1024 * 1024)

And, indeed, changing the definition in kexec-tools to the kernel one
fixed the problem.

Not sure if this has been reported before, if so please ignore
the noise.

Cheers,

Hannes
--=20
Dr. Hannes Reinecke		      zSeries & Storage
hare@suse.de			      +49 911 74053 688
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N=FCrnberg
GF: Markus Rex, HRB 16746 (AG N=FCrnberg)

--------------060901090906070506000801
Content-Type: text/plain;
 name="kexec-tools-increase-kernel-text-size"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kexec-tools-increase-kernel-text-size"

diff --git a/kexec/arch/x86_64/crashdump-x86_64.h b/kexec/arch/x86_64/crashdump-x86_64.h
index 9f4dee9..0e83527 100644
--- a/kexec/arch/x86_64/crashdump-x86_64.h
+++ b/kexec/arch/x86_64/crashdump-x86_64.h
@@ -11,7 +11,7 @@ int load_crashdump_segments(struct kexec_info *info, char *mod_cmdline,
 #define MAXMEM           0x3fffffffffffUL
 
 /* Kernel text size */
-#define KERNEL_TEXT_SIZE  (40UL*1024*1024)
+#define KERNEL_TEXT_SIZE  (512UL*1024*1024)
 
 #define CRASH_MAX_MEMMAP_NR	(KEXEC_MAX_SEGMENTS + 1)
 #define CRASH_MAX_MEMORY_RANGES	(MAX_MEMORY_RANGES + 2)

--------------060901090906070506000801
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--------------060901090906070506000801--

