Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-pb0-x22b.google.com ([2607:f8b0:400e:c01::22b])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VcyMe-0003UG-S2
 for kexec@lists.infradead.org; Sun, 03 Nov 2013 14:09:18 +0000
Received: by mail-pb0-f43.google.com with SMTP id md4so6164614pbc.30
 for <kexec@lists.infradead.org>; Sun, 03 Nov 2013 06:08:53 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20131016072236.GB29696@verge.net.au>
References: <1381859460-13645-1-git-send-email-geert@linux-m68k.org>
 <20131016072236.GB29696@verge.net.au>
Date: Sun, 3 Nov 2013 15:08:50 +0100
Message-ID: <CAMuHMdVsKLBt8MiZ-dpX7expx+37XfO2kUjbRA_h5eMcsWJ1VQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] kexec support for Linux/m68k (tools part)
From: Geert Uytterhoeven <geert@linux-m68k.org>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: linux-m68k <linux-m68k@lists.linux-m68k.org>, kexec@lists.infradead.org

On Wed, Oct 16, 2013 at 9:22 AM, Simon Horman <horms@verge.net.au> wrote:
> I've taken a quick look over this and it seems reasonable to me.

Thanks!

> However, I wonder if I should wait for review of the kernel-side
> to be completed before applying the kexec-tools patches.
>
> Let me know what you think.

The kexec-tools part seems to be stable. The issues to be sorted out are on
the kernel side.

However, it doesn't hurt to wait a little bit more to apply this. We m68k
people are patient and used to multi-year development ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
