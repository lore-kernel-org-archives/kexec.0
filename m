Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from relay2.sgi.com ([192.48.179.30] helo=relay.sgi.com)
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1PsHc4-0002xk-LI
	for kexec@lists.infradead.org; Wed, 23 Feb 2011 16:30:53 +0000
Received: from estes.americas.sgi.com (estes.americas.sgi.com [128.162.236.10])
	by relay2.corp.sgi.com (Postfix) with ESMTP id 5D400304081
	for <kexec@lists.infradead.org>; Wed, 23 Feb 2011 08:30:50 -0800 (PST)
Received: from eag09.americas.sgi.com (eag09.americas.sgi.com [128.162.232.15])
	by estes.americas.sgi.com (Postfix) with ESMTP id 41B557001DAC
	for <kexec@lists.infradead.org>; Wed, 23 Feb 2011 10:30:50 -0600 (CST)
Received: from cpw by eag09.americas.sgi.com with local (Exim 4.69)
	(envelope-from <cpw@sgi.com>) id 1PsHcr-0001Vm-Om
	for kexec@lists.infradead.org; Wed, 23 Feb 2011 10:31:41 -0600
Subject: [PATCH] kexec: extend KCORE_ELF_HEADERS_SIZE again
Message-Id: <E1PsHcr-0001Vm-Om@eag09.americas.sgi.com>
From: Cliff Wickman <cpw@sgi.com>
Date: Wed, 23 Feb 2011 10:31:41 -0600
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org


I thought that this patch was added to the kexec tree, but I don't find it in
git://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git
So I'm submitting it again for your consideration.

A customer machine has run over the limit that we increased in October.

> When boot.kdump runs:
> 
> Loading kdump
> 297 segments require a 16696-byte buffer
> KCORE_ELF_HEADERS_SIZE 16384 too small
> ELF core (kcore) parse failed
> Cannot load /boot/vmlinuz-2.6.32.12-0.7.1-uv
>                                                                     failed

Just barely overflowed. But I suggest doubling the buffer.

Signed-off-by: Cliff Wickman <cpw@sgi.com>

---
 kexec/crashdump.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: kexec-tools-2.0.1/kexec/crashdump.h
===================================================================
--- kexec-tools-2.0.1.orig/kexec/crashdump.h
+++ kexec-tools-2.0.1/kexec/crashdump.h
@@ -7,8 +7,8 @@ extern int get_xen_vmcoreinfo(uint64_t *
 
 /* Need to find a better way to determine per cpu notes section size. */
 #define MAX_NOTE_BYTES		1024
-/* Expecting ELF headers to fit in 16K. Increase it if you need more. */
-#define KCORE_ELF_HEADERS_SIZE  16384
+/* Expecting ELF headers to fit in 32K. Increase it if you need more. */
+#define KCORE_ELF_HEADERS_SIZE  32768
 /* The address of the ELF header is passed to the secondary kernel
  * using the kernel command line option memmap=nnn.
  * The smallest unit the kernel accepts is in kilobytes,

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
