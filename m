Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KRSPC-0003FS-NO
	for kexec@lists.infradead.org; Fri, 08 Aug 2008 13:53:22 +0000
Date: Fri, 8 Aug 2008 09:52:25 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 2/6] kexec jump: check code size in control page
Message-ID: <20080808135225.GD3840@redhat.com>
References: <1218099926.5164.33.camel@caritas-dev.intel.com>
	<20080807131557.GB27783@redhat.com> <20080807203130.GA10331@ucw.cz>
	<1218163477.22039.10.camel@caritas-dev.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1218163477.22039.10.camel@caritas-dev.intel.com>
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
To: Huang Ying <ying.huang@intel.com>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@suse.cz>, "Eric W. Biederman" <ebiederm@xmission.com>, mingo@elte.hu, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>

On Fri, Aug 08, 2008 at 10:44:37AM +0800, Huang Ying wrote:
> On Thu, 2008-08-07 at 22:31 +0200, Pavel Machek wrote:
> > Hi!
> > 
> > > > PAGE_SIZE/2. This patch adds runtime checking for this.
> > > > 
> > > > Signed-off-by: Huang Ying <ying.huang@intel.com>
> > ...
> > 
> > > >  {
> > > >  	if (nx_enabled)
> > > >  		set_pages_x(image->control_code_page, 1);
> > > > +
> > > > +	BUG_ON((unsigned long)kexec_control_page_code_end - \
> > > > +	       (unsigned long)relocate_kernel >= PAGE_SIZE/2);
> > > > +
> > > 
> > 
> > > Run time check is better than nothing but I think in this case it would
> > > be better if we can catch it at compile time. 
> > > 
> > > One of the methods will be to write a small program of your own and
> > > put in script/ and at build time check for the size and flag error. May
> > > be there are other better ways to do this.
> > 
> > BUILD_BUG_ON()?
> 
> I tried with BUILD_BUG_ON(), and compiling is OK for both of following
> statement:
> 
> BUILD_BUG_ON((unsigned long)kexec_control_page_code_end - \
> 	     (unsigned long)relocate_kernel >= PAGE_SIZE/2);
> 
> BUILD_BUG_ON((unsigned long)kexec_control_page_code_end - \
> 	     (unsigned long)relocate_kernel < PAGE_SIZE/2);
> 
> In general, I think value of kexec_control_page_code_end and
> relocate_kernel is not determined during compiling time. So
> BUILD_BUG_ON() doesn't work.
> 
> Another idea, use ASSERT() command of ld link script as in the following
> patch:
> 
> --- a/arch/x86/kernel/vmlinux_32.lds.S
> +++ b/arch/x86/kernel/vmlinux_32.lds.S
> @@ -209,3 +209,5 @@ SECTIONS
>  
>    DWARF_DEBUG
>  }
> +
> +#include "vmlinux_check_32.lds.S"
> --- /dev/null
> +++ b/arch/x86/kernel/vmlinux_check_32.lds.S
> @@ -0,0 +1,3 @@
> +#include <asm/kexec.h>
> +
> +ASSERT(kexec_control_page_code_end - relocate_kernel >= 2048, "kexec control page code size is too big")
> 
> 

Use of ASSERT() looks good to me. I think creation of extra file for a 
single ASSERT() can be avoided. Instead, we can just put this assert in
vmlinux_32.lds.S itself?

Thansk
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
