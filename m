Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from plane.gmane.org ([80.91.229.3])
 by bombadil.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1S5uV4-0000Ux-8L
 for kexec@lists.infradead.org; Fri, 09 Mar 2012 07:44:31 +0000
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glkk-kexec@m.gmane.org>) id 1S5uUt-0006Yt-MR
 for kexec@lists.infradead.org; Fri, 09 Mar 2012 08:44:19 +0100
Received: from 180.129.255.93 ([180.129.255.93])
 by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <kexec@lists.infradead.org>; Fri, 09 Mar 2012 08:44:19 +0100
Received: from xiyou.wangcong by 180.129.255.93 with local (Gmexim 0.1
 (Debian)) id 1AlnuQ-0007hv-00
 for <kexec@lists.infradead.org>; Fri, 09 Mar 2012 08:44:19 +0100
From: Cong Wang <xiyou.wangcong@gmail.com>
Subject: Re: kexec-tools-2.0.2 prints unnecessary message on stderr when
 loaded in VESA framebuffer
Date: Fri, 9 Mar 2012 07:44:10 +0000 (UTC)
Message-ID: <jjccc9$8ad$1@dough.gmane.org>
References: <CAHsXYDC2=ZUQH_22jH+XV5Z7P6uebkby5gvKjfiN2Mu0o9_aWw@mail.gmail.com>
Mime-Version: 1.0
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
To: kexec@lists.infradead.org

On Thu, 08 Mar 2012 at 17:29 GMT, Maxim Kammerer <mk@dee.su> wrote:
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

This should be just a debugging message, and should not be printed
unless debugging is enabled, so s/fprintf/dbgprintf/...


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
