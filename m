Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3.mail.elte.hu ([157.181.1.138])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1M2MgD-0004h3-Ql
	for kexec@lists.infradead.org; Fri, 08 May 2009 09:47:57 +0000
Date: Fri, 8 May 2009 11:47:26 +0200
From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 03/14] x86, config: change defaults PHYSICAL_START and
	PHYSICAL_ALIGN
Message-ID: <20090508094726.GE3559@elte.hu>
References: <1241735222-6640-1-git-send-email-hpa@linux.intel.com>
	<1241735222-6640-4-git-send-email-hpa@linux.intel.com>
	<20090508073606.GC12808@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20090508073606.GC12808@uranus.ravnborg.org>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, ebiederm@xmission.com, ying.huang@intel.com, tglx@linutronix.de, "H. Peter Anvin" <hpa@linux.intel.com>, vgoyal@redhat.com


* Sam Ravnborg <sam@ravnborg.org> wrote:

> On Thu, May 07, 2009 at 03:26:51PM -0700, H. Peter Anvin wrote:
> > From: H. Peter Anvin <hpa@zytor.com>
> > 
> > Change the default for CONFIG_PHYSICAL_START to 16 MB; 4 MB if
> > EMBEDDED.  Change the default for CONFIG_PHYSICAL_ALIGN to match up
> > with a large page alignment datum (4 MB for non-PAE, 2 MB for PAE.)
> > 
> > The default of 16 MB is designed to avoid occupying ZONE_DMA, as well
> > as avoiding a 15-16 MB memory hole, which some vendors inexplicably
> > still have in their systems.
> > 
> > [ Impact: minor performance improvement, leave ZONE_DMA free ]
> > 
> > Signed-off-by: H. Peter Anvin <hpa@zytor.com>
> > ---
> >  arch/x86/Kconfig |   19 +++++++++++--------
> >  1 files changed, 11 insertions(+), 8 deletions(-)
> > 
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index 039c3f0..13b3a5a 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -1455,17 +1455,20 @@ config KEXEC_JUMP
> >  
> >  config PHYSICAL_START
> >  	hex "Physical address where the kernel is loaded" if (EMBEDDED || CRASH_DUMP)
> > -	default "0x1000000" if X86_NUMAQ
> > -	default "0x200000" if X86_64
> > -	default "0x100000"
> > +	default "0x400000" if EMBEDDED
> > +	default "0x1000000"
> >  	---help---
> >  	  This gives the physical address where the kernel is loaded.
> >  
> >  	  If kernel is a not relocatable (CONFIG_RELOCATABLE=n) then
> >  	  bzImage will decompress itself to above physical address and
> > -	  run from there. Otherwise, bzImage will run from the address where
> > -	  it has been loaded by the boot loader and will ignore above physical
> > -	  address.
> > +	  run from there. Otherwise, bzImage will run from the either
> > +	  the above physical address or where it has been loaded by
> > +	  the boot loader, whichever is higher.
> > +
> > +	  For embedded machines with very small memory (less than
> > +	  about 24 MB) this may need to be adjusted downward from the
> > +	  default value of 0x1000000 (16 MB).
> 
> But in the above you say that default is "0x400000" if EMBEDDED
> That is in contradiction with the help - no?

Yes, the help text is wrong.

	Ingo

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
