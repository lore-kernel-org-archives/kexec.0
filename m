Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by casper.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1S6yg4-0001f2-LB
 for kexec@lists.infradead.org; Mon, 12 Mar 2012 06:24:18 +0000
Date: Mon, 12 Mar 2012 15:04:04 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: kexec-tools-2.0.2 prints unnecessary message on stderr when
 loaded in VESA framebuffer
Message-ID: <20120312060403.GH8448@verge.net.au>
References: <CAHsXYDC2=ZUQH_22jH+XV5Z7P6uebkby5gvKjfiN2Mu0o9_aWw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAHsXYDC2=ZUQH_22jH+XV5Z7P6uebkby5gvKjfiN2Mu0o9_aWw@mail.gmail.com>
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
To: Maxim Kammerer <mk@dee.su>
Cc: kexec@lists.infradead.org

On Thu, Mar 08, 2012 at 07:29:25PM +0200, Maxim Kammerer wrote:
> Hi,
> 
> In kexec/arch/i386/x86-linux-setup.c:setup_linux_vesafb():
> 
>     fprintf(stderr, "%s: %dx%dx%d @ %lx +%x\n", __FUNCTION__,
>         var.xres, var.yres, var.bits_per_pixel,
>         fix.smem_start, fix.smem_len);
> 
> This message is pretty annoying (especially if kexec is loaded several
> times with different parameters during startup/shutdown). Looking in
> that source file, that's the only fprintf which is not an error. Is it
> really necessary?
> 
> I opened a Gentoo bug report
> (https://bugs.gentoo.org/show_bug.cgi?id=407445), and the assignee
> suggested reporting upstream.

Agreed, I have pushed the following patch into
the kexec-tools git tree and it should be included in
the next release.


From f1facd4b11aa141ffd9bbacb2631ad18dc33669c Mon Sep 17 00:00:00 2001
From: Simon Horman <horms@verge.net.au>
Date: Mon, 12 Mar 2012 15:01:35 +0900
Subject: [PATCH] i386: Don't print debug message when VESA framebuffer is
 loaded

This messages seems unnecessarily verbose.

Reported-by: Maxim Kammerer <mk@dee.su>
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 kexec/arch/i386/x86-linux-setup.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/kexec/arch/i386/x86-linux-setup.c b/kexec/arch/i386/x86-linux-setup.c
index 0528cea..08d64ca 100644
--- a/kexec/arch/i386/x86-linux-setup.c
+++ b/kexec/arch/i386/x86-linux-setup.c
@@ -151,9 +151,6 @@ int setup_linux_vesafb(struct x86_linux_param_header *real_mode)
 		real_mode->rsvd_pos   = var.transp.offset;
 		real_mode->rsvd_size  = var.transp.length;
 	}
-	fprintf(stderr, "%s: %dx%dx%d @ %lx +%x\n", __FUNCTION__,
-		var.xres, var.yres, var.bits_per_pixel,
-		fix.smem_start, fix.smem_len);
 	return 0;
 
  out:
-- 
1.7.6.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
