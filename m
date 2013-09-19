Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VMaPn-0000Aa-Av
 for kexec@lists.infradead.org; Thu, 19 Sep 2013 09:20:47 +0000
Received: by mail-pd0-f178.google.com with SMTP id w10so8235409pde.9
 for <kexec@lists.infradead.org>; Thu, 19 Sep 2013 02:20:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1379412095-7213-1-git-send-email-geert@linux-m68k.org>
References: <1379412095-7213-1-git-send-email-geert@linux-m68k.org>
Date: Thu, 19 Sep 2013 11:20:22 +0200
Message-ID: <CAMuHMdW8y9_=LXQ1PXjFaPyq-nYTPe+FodE5hQh4P3QSdnP_dg@mail.gmail.com>
Subject: Re: Preliminary kexec support for Linux/m68k
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
To: Anton Blanchard <anton@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, kexec@lists.infradead.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Tue, Sep 17, 2013 at 12:01 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> This is a preliminary set of patches to add kexec support for m68k.

>   - [PATCH 1/3] m68k: Add preliminary kexec support
>   - [PATCH 2/3] m68k: Add support to export bootinfo in procfs
>   - [PATCH 3/3] [RFC] m68k: Add System RAM to /proc/iomem
>
> Notes:
>   - The bootinfo is now saved and exported to /proc/bootinfo, so kexec-tools
>     can read it and pass it (possibly after modification) to the new kernel.
>     This is similar to /proc/atags on ARM.

>   - I based [PATCH 3/3] on the PowerPC version, but it's no longer needed as we
>     now get this information from the bootinfo.
>     Does anyone think this is nice to have anyway?

It seems kexec/kdump on ppc don't use /proc/iomem anymore, and only rely on
/proc/device-tree these days?

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
