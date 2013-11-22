Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vjr3x-0006wO-AT
 for kexec@lists.infradead.org; Fri, 22 Nov 2013 13:46:25 +0000
Date: Fri, 22 Nov 2013 08:46:00 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 0/6] kexec: A new system call to allow in kernel loading
Message-ID: <20131122134600.GC4046@redhat.com>
References: <1384969851-7251-1-git-send-email-vgoyal@redhat.com>
 <8761rl73s7.fsf@xmission.com> <20131122015518.GA31921@redhat.com>
 <CAMuHMdUVvhKLBfZo2gBf=FoQxMEM42yzBjYS8r5sVfXgp940ng@mail.gmail.com>
 <alpine.LRH.2.00.1311221429470.9932@twin.jikos.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.00.1311221429470.9932@twin.jikos.cz>
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
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Greg Kroah-Hartman <greg@kroah.com>, kexec@lists.infradead.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>

On Fri, Nov 22, 2013 at 02:30:17PM +0100, Jiri Kosina wrote:
> On Fri, 22 Nov 2013, Geert Uytterhoeven wrote:
> 
> > > Why ELF case is so interesting. I have not use kexec to boot ELF
> > > images in years and have not seen others using it too. In fact bzImage
> > > seems to be the most common kernel image format for x86, most of the distros
> > > ship and use.
> > >
> > > So first I did the loader for the common use case. There is no reason
> > > that one can't write another loader for ELF images. It just bloats
> > > the code. Hence I thought that other image loaders can follow slowly. I am
> > > not sure why do you say that bzImage is uninteresting.
> > 
> > Welcome to the non-x86-centric world ;-)
> > 
> > Looking at kexec-tools, all of arm, cris, i386, ia64, m68k, mips, ppc, ppc64,
> > s390, sh, and x86_64 support ELF.
> > Only arm, i386, ppc, ppc64, sh, and x86_64 support zImage.
> > It's not clear to me what alpha supports (if it supports anything at all?).
> 
> OTOH, does this feature make any sense whatsover on architectures that 
> don't support secure boot anyway?

I guess if signed modules makes sense, then being able to kexec signed
kernel images should make sense too, in general.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
