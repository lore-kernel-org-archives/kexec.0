Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga02.intel.com ([134.134.136.20])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KRHy5-0001tp-OF
	for kexec@lists.infradead.org; Fri, 08 Aug 2008 02:44:43 +0000
Subject: Re: [PATCH 2/6] kexec jump: check code size in control page
From: Huang Ying <ying.huang@intel.com>
In-Reply-To: <20080807203130.GA10331@ucw.cz>
References: <1218099926.5164.33.camel@caritas-dev.intel.com>
	<20080807131557.GB27783@redhat.com>  <20080807203130.GA10331@ucw.cz>
Date: Fri, 08 Aug 2008 10:44:37 +0800
Message-Id: <1218163477.22039.10.camel@caritas-dev.intel.com>
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
To: Pavel Machek <pavel@suse.cz>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, mingo@elte.hu, Vivek Goyal <vgoyal@redhat.com>

On Thu, 2008-08-07 at 22:31 +0200, Pavel Machek wrote:
> Hi!
> 
> > > PAGE_SIZE/2. This patch adds runtime checking for this.
> > > 
> > > Signed-off-by: Huang Ying <ying.huang@intel.com>
> ...
> 
> > >  {
> > >  	if (nx_enabled)
> > >  		set_pages_x(image->control_code_page, 1);
> > > +
> > > +	BUG_ON((unsigned long)kexec_control_page_code_end - \
> > > +	       (unsigned long)relocate_kernel >= PAGE_SIZE/2);
> > > +
> > 
> 
> > Run time check is better than nothing but I think in this case it would
> > be better if we can catch it at compile time. 
> > 
> > One of the methods will be to write a small program of your own and
> > put in script/ and at build time check for the size and flag error. May
> > be there are other better ways to do this.
> 
> BUILD_BUG_ON()?

I tried with BUILD_BUG_ON(), and compiling is OK for both of following
statement:

BUILD_BUG_ON((unsigned long)kexec_control_page_code_end - \
	     (unsigned long)relocate_kernel >= PAGE_SIZE/2);

BUILD_BUG_ON((unsigned long)kexec_control_page_code_end - \
	     (unsigned long)relocate_kernel < PAGE_SIZE/2);

In general, I think value of kexec_control_page_code_end and
relocate_kernel is not determined during compiling time. So
BUILD_BUG_ON() doesn't work.

Another idea, use ASSERT() command of ld link script as in the following
patch:

--- a/arch/x86/kernel/vmlinux_32.lds.S
+++ b/arch/x86/kernel/vmlinux_32.lds.S
@@ -209,3 +209,5 @@ SECTIONS
 
   DWARF_DEBUG
 }
+
+#include "vmlinux_check_32.lds.S"
--- /dev/null
+++ b/arch/x86/kernel/vmlinux_check_32.lds.S
@@ -0,0 +1,3 @@
+#include <asm/kexec.h>
+
+ASSERT(kexec_control_page_code_end - relocate_kernel >= 2048, "kexec control page code size is too big")


It works for me. What do you think about that?

Best Regards,
Huang Ying



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
