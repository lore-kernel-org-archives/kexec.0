Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-tul01m020-f177.google.com ([209.85.214.177])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1S5h9v-0004bf-5z
 for kexec@lists.infradead.org; Thu, 08 Mar 2012 17:29:47 +0000
Received: by obbta2 with SMTP id ta2so1115666obb.36
 for <kexec@lists.infradead.org>; Thu, 08 Mar 2012 09:29:45 -0800 (PST)
MIME-Version: 1.0
From: Maxim Kammerer <mk@dee.su>
Date: Thu, 8 Mar 2012 19:29:25 +0200
Message-ID: <CAHsXYDC2=ZUQH_22jH+XV5Z7P6uebkby5gvKjfiN2Mu0o9_aWw@mail.gmail.com>
Subject: kexec-tools-2.0.2 prints unnecessary message on stderr when loaded in
 VESA framebuffer
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: horms@verge.net.au

Hi,

In kexec/arch/i386/x86-linux-setup.c:setup_linux_vesafb():

    fprintf(stderr, "%s: %dx%dx%d @ %lx +%x\n", __FUNCTION__,
        var.xres, var.yres, var.bits_per_pixel,
        fix.smem_start, fix.smem_len);

This message is pretty annoying (especially if kexec is loaded several
times with different parameters during startup/shutdown). Looking in
that source file, that's the only fprintf which is not an error. Is it
really necessary?

I opened a Gentoo bug report
(https://bugs.gentoo.org/show_bug.cgi?id=3D407445), and the assignee
suggested reporting upstream.

Thanks,
Maxim

-- =

Maxim Kammerer
Libert=E9 Linux (discussion / support: http://dee.su/liberte-contribute)

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
