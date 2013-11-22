Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VjskD-0001Od-Oq
 for kexec@lists.infradead.org; Fri, 22 Nov 2013 15:34:13 +0000
Date: Fri, 22 Nov 2013 16:33:46 +0100 (CET)
From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 0/6] kexec: A new system call to allow in kernel
 loading
In-Reply-To: <CAMuHMdV4=Z8i0u_rWpQU0HHW0mvyv1k-acW1MyT9ZYy=iNwrfg@mail.gmail.com>
Message-ID: <alpine.LRH.2.00.1311221631100.9932@twin.jikos.cz>
References: <1384969851-7251-1-git-send-email-vgoyal@redhat.com>
 <8761rl73s7.fsf@xmission.com> <20131122015518.GA31921@redhat.com>
 <CAMuHMdUVvhKLBfZo2gBf=FoQxMEM42yzBjYS8r5sVfXgp940ng@mail.gmail.com>
 <20131122134317.GA4046@redhat.com>
 <CAMuHMdV4=Z8i0u_rWpQU0HHW0mvyv1k-acW1MyT9ZYy=iNwrfg@mail.gmail.com>
MIME-Version: 1.0
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Greg Kroah-Hartman <greg@kroah.com>, kexec@lists.infradead.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Vivek Goyal <vgoyal@redhat.com>

On Fri, 22 Nov 2013, Geert Uytterhoeven wrote:

> >> Only arm, i386, ppc, ppc64, sh, and x86_64 support zImage.
> >> It's not clear to me what alpha supports (if it supports anything at all?).
> >
> > Motiviation behind this patchset is secureboot. That is x86 specific
> > only and bzImage is most commonly used format on that platform. So it
> > makes sense to implement bzImage loader first, IMO.
> 
> While secureboot(TM) may be x86-centric

And ARM, right?

> IIRC actually loading signed kernels and modules didn't originate on 
> x86. Anything can have a bootloader that accepts signed kernel images 
> only.

Yes, but if you don't have the whole secure boot security model (i.e. root 
is implicitly untrusted), it's all just a game really.

If you are playing this "signed kernel and modules" game, but have trusted 
root, he's free to replace the bootloader by one that wouldn't be 
verifying the kernel signature, and reboot into arbitrary kernel.

-- 
Jiri Kosina
SUSE Labs


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
