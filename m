Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cpmpc-0002To-DI
 for kexec@lists.infradead.org; Mon, 20 Mar 2017 02:14:02 +0000
Date: Mon, 20 Mar 2017 10:13:30 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v2] kexec: Introduce vmcoreinfo signature verification
Message-ID: <20170320021330.GA22469@x1>
References: <1489722318-13695-1-git-send-email-xlpang@redhat.com>
 <874lyrhl81.fsf@xmission.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <874lyrhl81.fsf@xmission.com>
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
Cc: kexec@lists.infradead.org, akpm@linux-foundation.org, Dave Young <dyoung@redhat.com>, Xunlei Pang <xlpang@redhat.com>, linux-kernel@vger.kernel.org

On 03/17/17 at 12:22pm, Eric W. Biederman wrote:
> Xunlei Pang <xlpang@redhat.com> writes:
> 
> > Currently vmcoreinfo data is updated at boot time subsys_initcall(),
> > it has the risk of being modified by some wrong code during system
> > is running.
> >
> > As a result, vmcore dumped may contain the wrong vmcoreinfo. Later on,
> > when using "crash" or "makedumpfile"(etc) utility to parse this vmcore,
> > we probably will get "Segmentation fault" or other unexpected/confusing
> > errors.
> 
> If this is a real concern and the previous discussion sounds like it is
> part of what we need to do is move the variable vmcoreinfo_note out
> of the kernel's .bss section.  And modify the code to regenerate
> and keep this information in something like the control page.

I guess this is not from a real issue, just from Xunlei's worry. But
Xunlei didn't give a direct answer to this, and Petr's question. Not
very sure if this will impact other implementation. fadump will be
impacted by this or other dump? Maybe yet or maybe not.

I don't object this strongly, but please at least add code comment to
explain why vmcoreinfo need be saved twice because it does look weird.

> 
> Definitely something like this needs a page all to itself, and ideally
> far away from any other kernel data structures.  I clearly was not
> watching closely the data someone decided to keep this silly thing
> in the kernel's .bss section.
> 
> > As vmcoreinfo is the most fundamental information for vmcore, we better
> > double check its correctness. Here we generate a signature(using crc32)
> > after it is saved, then verify it in crash_save_vmcoreinfo() to see if
> > the signature was broken, if so we have to re-save the vmcoreinfo data
> > to get the correct vmcoreinfo for kdump as possible as we can.
> 
> Sigh.  We already have a sha256 that is supposed to cover this sort of
> thing.  The bug rather is that apparently it isn't covering this data.
> That sounds like what we should be fixing.
> 
> Please let's not invent new mechanisms we have to maintain.  Let's
> reorganize this so this static data is protected like all other static
> data in the kexec-on-panic path.  We have good mechanims and good
> strategies for avoiding and detecting corruption we just need to use
> them.
> 
> Eric
> 
> 
> 
> > Signed-off-by: Xunlei Pang <xlpang@redhat.com>
> > ---
> > v1->v2:
> > - Keep crash_save_vmcoreinfo_init() because "makedumpfile --mem-usage"
> >   uses the information.
> > - Add crc32 verification for vmcoreinfo, re-save when failure.
> >
> >  arch/Kconfig        |  1 +
> >  kernel/kexec_core.c | 43 +++++++++++++++++++++++++++++++++++--------
> >  2 files changed, 36 insertions(+), 8 deletions(-)
> >
> > diff --git a/arch/Kconfig b/arch/Kconfig
> > index c4d6833..66eb296 100644
> > --- a/arch/Kconfig
> > +++ b/arch/Kconfig
> > @@ -4,6 +4,7 @@
> >  
> >  config KEXEC_CORE
> >  	bool
> > +	select CRC32
> >  
> >  config HAVE_IMA_KEXEC
> >  	bool
> > diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> > index bfe62d5..012acbe 100644
> > --- a/kernel/kexec_core.c
> > +++ b/kernel/kexec_core.c
> > @@ -38,6 +38,7 @@
> >  #include <linux/syscore_ops.h>
> >  #include <linux/compiler.h>
> >  #include <linux/hugetlb.h>
> > +#include <linux/crc32.h>
> >  
> >  #include <asm/page.h>
> >  #include <asm/sections.h>
> > @@ -53,9 +54,10 @@
> >  
> >  /* vmcoreinfo stuff */
> >  static unsigned char vmcoreinfo_data[VMCOREINFO_BYTES];
> > -u32 vmcoreinfo_note[VMCOREINFO_NOTE_SIZE/4];
> > +static u32 vmcoreinfo_sig;
> >  size_t vmcoreinfo_size;
> >  size_t vmcoreinfo_max_size = sizeof(vmcoreinfo_data);
> > +u32 vmcoreinfo_note[VMCOREINFO_NOTE_SIZE/4];
> >  
> >  /* Flag to indicate we are going to kexec a new kernel */
> >  bool kexec_in_progress = false;
> > @@ -1367,12 +1369,6 @@ static void update_vmcoreinfo_note(void)
> >  	final_note(buf);
> >  }
> >  
> > -void crash_save_vmcoreinfo(void)
> > -{
> > -	vmcoreinfo_append_str("CRASHTIME=%ld\n", get_seconds());
> > -	update_vmcoreinfo_note();
> > -}
> > -
> >  void vmcoreinfo_append_str(const char *fmt, ...)
> >  {
> >  	va_list args;
> > @@ -1402,7 +1398,7 @@ phys_addr_t __weak paddr_vmcoreinfo_note(void)
> >  	return __pa_symbol((unsigned long)(char *)&vmcoreinfo_note);
> >  }
> >  
> > -static int __init crash_save_vmcoreinfo_init(void)
> > +static void do_crash_save_vmcoreinfo_init(void)
> >  {
> >  	VMCOREINFO_OSRELEASE(init_uts_ns.name.release);
> >  	VMCOREINFO_PAGESIZE(PAGE_SIZE);
> > @@ -1474,6 +1470,37 @@ static int __init crash_save_vmcoreinfo_init(void)
> >  #endif
> >  
> >  	arch_crash_save_vmcoreinfo();
> > +}
> > +
> > +static u32 crash_calc_vmcoreinfo_sig(void)
> > +{
> > +	return crc32(~0, vmcoreinfo_data, vmcoreinfo_size);
> > +}
> > +
> > +static bool crash_verify_vmcoreinfo(void)
> > +{
> > +	if (crash_calc_vmcoreinfo_sig() == vmcoreinfo_sig)
> > +		return true;
> > +
> > +	return false;
> > +}
> > +
> > +void crash_save_vmcoreinfo(void)
> > +{
> > +	/* Re-save if verification fails */
> > +	if (!crash_verify_vmcoreinfo()) {
> > +		vmcoreinfo_size = 0;
> > +		do_crash_save_vmcoreinfo_init();
> > +	}
> > +
> > +	vmcoreinfo_append_str("CRASHTIME=%ld\n", get_seconds());
> > +	update_vmcoreinfo_note();
> > +}
> > +
> > +static int __init crash_save_vmcoreinfo_init(void)
> > +{
> > +	do_crash_save_vmcoreinfo_init();
> > +	vmcoreinfo_sig = crash_calc_vmcoreinfo_sig();
> >  	update_vmcoreinfo_note();
> >  
> >  	return 0;

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
