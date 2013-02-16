Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1U6ec4-0006lp-NZ
 for kexec@lists.infradead.org; Sat, 16 Feb 2013 10:03:22 +0000
Message-ID: <511F597A.2030900@redhat.com>
Date: Sat, 16 Feb 2013 18:03:38 +0800
From: Dave Young <dyoung@redhat.com>
MIME-Version: 1.0
Subject: Re: makedumpfile-1.5.2: Secret data scrubbing with eppic language.
References: <20130214110716.7b2b9f9b0eba662caefc9410@mxc.nes.nec.co.jp>
In-Reply-To: <20130214110716.7b2b9f9b0eba662caefc9410@mxc.nes.nec.co.jp>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: kexec@lists.infradead.org

On 02/14/2013 10:07 AM, Atsushi Kumagai wrote:
> Hello,
> 
> makedumpfile version 1.5.2 is released.
> Your comments/patches are welcome.

Hi,
ppc64 build fails with "undefined reference to readpage_sadump".

Below patch fixes this, but feel free to fix it without the #if in other way.

diff -uprN makedumpfile/makedumpfile.c makedumpfile.new/makedumpfile.c
--- makedumpfile/makedumpfile.c	2013-02-16 17:58:58.158576503 +0800
+++ makedumpfile.new/makedumpfile.c	2013-02-16 17:59:19.775577017 +0800
@@ -412,9 +412,11 @@ readmem(int type_addr, unsigned long lon
 		if (info->flag_refiltering) {
 			if (!readpage_kdump_compressed(pgaddr, pgbuf))
 				goto error;
+#if defined(__x86__) || defined(__x86_64__)
 		} else if (info->flag_sadump) {
 			if (!readpage_sadump(pgaddr, pgbuf))
 				goto error;
+#endif
 		} else {
 			if (!readpage_elf(pgaddr, pgbuf))
 				goto error;

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
