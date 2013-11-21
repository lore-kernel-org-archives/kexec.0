Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-pb0-x232.google.com ([2607:f8b0:400e:c01::232])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VjZa6-0004Lc-T0
 for kexec@lists.infradead.org; Thu, 21 Nov 2013 19:06:27 +0000
Received: by mail-pb0-f50.google.com with SMTP id rr13so166655pbb.23
 for <kexec@lists.infradead.org>; Thu, 21 Nov 2013 11:06:02 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1384969851-7251-1-git-send-email-vgoyal@redhat.com>
References: <1384969851-7251-1-git-send-email-vgoyal@redhat.com>
Date: Thu, 21 Nov 2013 20:06:02 +0100
Message-ID: <CAMuHMdVoGC3+q2UKvogL=BjkXO3k3Dq9+gGF+7CczG-PJcQPxw@mail.gmail.com>
Subject: Re: [PATCH 0/6] kexec: A new system call to allow in kernel loading
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Greg Kroah-Hartman <greg@kroah.com>, kexec@lists.infradead.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>

On Wed, Nov 20, 2013 at 6:50 PM, Vivek Goyal <vgoyal@redhat.com> wrote:
> Now a new system call kexec_file_load() is implemented which takes
> kernel fd and initrd fd as parameters. Now kernel should be able
> to verify signature of newly loaded kernel.

Only kernel fd and initrd fd?
What about other fds (e.g. device tree, bootinfo)?

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
