Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KTJpB-0006sZ-NU
	for kexec@lists.infradead.org; Wed, 13 Aug 2008 17:07:54 +0000
Date: Wed, 13 Aug 2008 10:07:03 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] kexec jump: fix code size checking
Message-Id: <20080813100703.10f50b40.akpm@linux-foundation.org>
In-Reply-To: <20080813131927.GB3957@redhat.com>
References: <1218589475.24951.59.camel@caritas-dev.intel.com>
	<20080813131927.GB3957@redhat.com>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, Huang Ying <ying.huang@intel.com>, mingo@elte.hu, Linus Torvalds <torvalds@linux-foundation.org>

On Wed, 13 Aug 2008 09:19:27 -0400 Vivek Goyal <vgoyal@redhat.com> wrote:

> On Wed, Aug 13, 2008 at 09:04:35AM +0800, Huang Ying wrote:
> > Fix building issue when CONFIG_KEXEC=n. Thanks to Vivek Goyal for his
> > reminding.
> > 
> > Signed-off-by: Huang Ying <ying.huang@intel.com>
> > 
> > ---
> >  include/asm-x86/kexec.h |    3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > --- a/include/asm-x86/kexec.h
> > +++ b/include/asm-x86/kexec.h
> > @@ -43,6 +43,9 @@
> >  
> >  #ifdef CONFIG_X86_32
> >  # define KEXEC_CONTROL_CODE_MAX_SIZE	2048
> > +# ifndef CONFIG_KEXEC
> > +#  define kexec_control_code_size	0
> > +# endif
> >  #endif
> >  
> >  #ifndef __ASSEMBLY__
> 
> I think Andrew already fixed it. Right way is to put code in vmlinux.lds.S
> under #ifdef CONFIG_KEXEC, than defining the symbol kexec_control_code_size
> if CONFIG_KEXEC=n

I was wondering about that.

I resurrected that patch.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
