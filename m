Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Thu, 1 Dec 2016 12:27:03 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCHv4 07/10] kexec: Switch to __pa_symbol
Message-ID: <20161201042703.GA13113@dhcp-128-65.nay.redhat.com>
References: <1480445729-27130-1-git-send-email-labbott@redhat.com>
 <1480445729-27130-8-git-send-email-labbott@redhat.com>
 <20161201024103.GA32438@dhcp-128-65.nay.redhat.com>
 <87polc7357.fsf@xmission.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87polc7357.fsf@xmission.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Morton <akpm@linux-foundation.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, x86@kernel.org, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Laura Abbott <labbott@redhat.com>, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Marek Szyprowski <m.szyprowski@samsung.com>

On 11/30/16 at 09:13pm, Eric W. Biederman wrote:
> Dave Young <dyoung@redhat.com> writes:
> 
> > Hi, Laura
> > On 11/29/16 at 10:55am, Laura Abbott wrote:
> >> 
> >> __pa_symbol is the correct api to get the physical address of kernel
> >> symbols. Switch to it to allow for better debug checking.
> >> 
> >
> > I assume __pa_symbol is faster than __pa, but it still need some testing
> > on all arches which support kexec.
> >
> > But seems long long ago there is a commit e3ebadd95cb in the commit log
> > I see below from:
> > "we should deprecate __pa_symbol(), and preferably __pa() too - and
> >  just use "virt_to_phys()" instead, which is is more readable and has
> >  nicer semantics."
> >
> > But maybe in modern code __pa_symbol is prefered I may miss background.
> > virt_to_phys still sounds more readable now for me though.
> 
> There has been a lot of history with the various definitions.
> __pa_symbol used to be x86 specific.
> 
> Now what we have is that __pa_symbol is just __pa(RELOC_HIDE(x));
> 
> Now arguably that whole reloc hide thing should happen by architectures
> having a non-inline version of __pa as was done in the commit you
> mention.  But at this point there appears to be nothing wrong with
> changing a __pa to a __pa_symbol it might make things a tad more
> reliable depending on the implementation of __pa.

Then it is safe and reasonable, thanks for the clarification. 

> 
> Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
> 
> 
> Eric
> 
> >> Signed-off-by: Laura Abbott <labbott@redhat.com>
> >> ---
> >> Found during review of the kernel. Untested.
> >> ---
> >>  kernel/kexec_core.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >> 
> >> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> >> index 5616755..e1b625e 100644
> >> --- a/kernel/kexec_core.c
> >> +++ b/kernel/kexec_core.c
> >> @@ -1397,7 +1397,7 @@ void __weak arch_crash_save_vmcoreinfo(void)
> >>  
> >>  phys_addr_t __weak paddr_vmcoreinfo_note(void)
> >>  {
> >> -	return __pa((unsigned long)(char *)&vmcoreinfo_note);
> >> +	return __pa_symbol((unsigned long)(char *)&vmcoreinfo_note);
> >>  }
> >>  
> >>  static int __init crash_save_vmcoreinfo_init(void)
> >> -- 
> >> 2.7.4
> >> 
> >> 
> >> _______________________________________________
> >> kexec mailing list
> >> kexec@lists.infradead.org
> >> http://lists.infradead.org/mailman/listinfo/kexec
> >
> > Thanks
> > Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
