Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vjta5-0003Mw-3j
 for kexec@lists.infradead.org; Fri, 22 Nov 2013 16:27:47 +0000
Date: Fri, 22 Nov 2013 10:33:50 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 0/6] kexec: A new system call to allow in kernel loading
Message-ID: <20131122153349.GH4046@redhat.com>
References: <1384969851-7251-1-git-send-email-vgoyal@redhat.com>
 <8761rl73s7.fsf@xmission.com> <20131122015518.GA31921@redhat.com>
 <CAMuHMdUVvhKLBfZo2gBf=FoQxMEM42yzBjYS8r5sVfXgp940ng@mail.gmail.com>
 <alpine.LRH.2.00.1311221429470.9932@twin.jikos.cz>
 <20131122134600.GC4046@redhat.com>
 <alpine.LNX.2.00.1311221449120.22082@pobox.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1311221449120.22082@pobox.suse.cz>
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
To: Jiri Kosina <jkosina@suse.cz>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Kees Cook <keescook@chromium.org>, Greg Kroah-Hartman <greg@kroah.com>, kexec@lists.infradead.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>

On Fri, Nov 22, 2013 at 02:50:43PM +0100, Jiri Kosina wrote:
> On Fri, 22 Nov 2013, Vivek Goyal wrote:
> 
> > > OTOH, does this feature make any sense whatsover on architectures that 
> > > don't support secure boot anyway?
> > 
> > I guess if signed modules makes sense, then being able to kexec signed
> > kernel images should make sense too, in general.
> 
> Well, that's really a grey zone, I'd say.
> 
> In a non-secureboot environment, if you are root, you are able to issue 
> reboot into a completely different, self-made kernel anyway, independent 
> on whether signed modules are used or not.

That's a good poing. Frankly speaking I don't know if there is a good
use case to allow loading signed kernels only or not.

Kees mentioned that he would like to know where the kernel came from
and whether it came from trusted disk or not. So he does seem to have
a use case where he wants to launch only trusted kernel or deny execution.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
