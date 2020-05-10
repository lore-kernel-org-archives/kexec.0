Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]
 helo=us-smtp-delivery-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jXqas-0005oe-Sp
 for kexec@lists.infradead.org; Sun, 10 May 2020 18:22:33 +0000
Date: Sun, 10 May 2020 14:22:02 -0400
From: Rafael Aquini <aquini@redhat.com>
Subject: Re: [PATCH v3] kernel: add panic_on_taint
Message-ID: <20200510182202.GA31704@t490s>
References: <20200509135737.622299-1-aquini@redhat.com>
 <20200510025921.GA10165@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200510025921.GA10165@MiWiFi-R3L-srv>
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
To: Baoquan He <bhe@redhat.com>
Cc: linux-doc@vger.kernel.org, tiwai@suse.de, jeffm@suse.com, corbet@lwn.net, labbott@redhat.com, dyoung@redhat.com, AnDavis@suse.com, rpalethorpe@suse.de, keescook@chromium.org, jikos@kernel.org, cai@lca.pw, bunk@kernel.org, tytso@mit.edu, jeyu@suse.de, gregkh@linuxfoundation.org, rdunlap@infradead.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mcgrof@kernel.org, linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org, torvalds@linux-foundation.org

On Sun, May 10, 2020 at 10:59:21AM +0800, Baoquan He wrote:
> On 05/09/20 at 09:57am, Rafael Aquini wrote:
> > Analogously to the introduction of panic_on_warn, this patch
> > introduces a kernel option named panic_on_taint in order to
> > provide a simple and generic way to stop execution and catch
> > a coredump when the kernel gets tainted by any given taint flag.
> > 
> > This is useful for debugging sessions as it avoids rebuilding
> > the kernel to explicitly add calls to panic() or BUG() into
> > code sites that introduce the taint flags of interest.
> > Another, perhaps less frequent, use for this option would be
> > as a mean for assuring a security policy (in paranoid mode)
> > case where no single taint is allowed for the running system.
> > 
> > Suggested-by: Qian Cai <cai@lca.pw>
> > Signed-off-by: Rafael Aquini <aquini@redhat.com>
> > ---
> > Changelog:
> > * v2: get rid of unnecessary/misguided compiler hints		(Luis)
> > * v2: enhance documentation text for the new kernel parameter	(Randy)
> > * v3: drop sysctl interface, keep it only as a kernel parameter (Luis)
> > 
> >  Documentation/admin-guide/kdump/kdump.rst     | 10 +++++
> >  .../admin-guide/kernel-parameters.txt         | 15 +++++++
> >  include/linux/kernel.h                        |  2 +
> >  kernel/panic.c                                | 40 +++++++++++++++++++
> >  kernel/sysctl.c                               |  9 ++++-
> >  5 files changed, 75 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/admin-guide/kdump/kdump.rst
> > index ac7e131d2935..de3cf6d377cc 100644
> > --- a/Documentation/admin-guide/kdump/kdump.rst
> > +++ b/Documentation/admin-guide/kdump/kdump.rst
> > @@ -521,6 +521,16 @@ will cause a kdump to occur at the panic() call.  In cases where a user wants
> >  to specify this during runtime, /proc/sys/kernel/panic_on_warn can be set to 1
> >  to achieve the same behaviour.
> >  
> > +Trigger Kdump on add_taint()
> > +============================
> > +
> > +The kernel parameter, panic_on_taint, calls panic() from within add_taint(),
> > +whenever the value set in this bitmask matches with the bit flag being set
> > +by add_taint(). This will cause a kdump to occur at the panic() call.
> > +In cases where a user wants to specify this during runtime,
> > +/proc/sys/kernel/panic_on_taint can be set to a respective bitmask value
> > +to achieve the same behaviour.
> > +
> >  Contact
> >  =======
> >  
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index 7bc83f3d9bdf..4a69fe49a70d 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -3404,6 +3404,21 @@
> >  	panic_on_warn	panic() instead of WARN().  Useful to cause kdump
> >  			on a WARN().
> >  
> > +	panic_on_taint=	[KNL] conditionally panic() in add_taint()
> > +			Format: <str>
> 			Changed it as 'Format: <string>' to be
> consistent with the existing other options?

I can resubmit with the change, if it's a strong req and the surgery
cannot be done at merge time.


> > +			Specifies, as a string, the TAINT flag set that will
> > +			compose a bitmask for calling panic() when the kernel
> > +			gets tainted.
> > +			See Documentation/admin-guide/tainted-kernels.rst for
> > +			details on the taint flags that users can pick to
> > +			compose the bitmask to assign to panic_on_taint.
> > +			When the string is prefixed with a '-' the bitmask
> > +			set in panic_on_taint will be mutually exclusive
> > +			with the sysctl knob kernel.tainted, and any attempt
> > +			to write to that sysctl will fail with -EINVAL for
> > +			any taint value that masks with the flags set for
> > +			this option.
> > +
> >  	crash_kexec_post_notifiers
> >  			Run kdump after running panic-notifiers and dumping
> >  			kmsg. This only for the users who doubt kdump always
> > diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> > index 9b7a8d74a9d6..66bc102cb59a 100644
> > --- a/include/linux/kernel.h
> > +++ b/include/linux/kernel.h
> > @@ -528,6 +528,8 @@ extern int panic_on_oops;
> >  extern int panic_on_unrecovered_nmi;
> >  extern int panic_on_io_nmi;
> >  extern int panic_on_warn;
> > +extern unsigned long panic_on_taint;
> > +extern bool panic_on_taint_exclusive;
> >  extern int sysctl_panic_on_rcu_stall;
> >  extern int sysctl_panic_on_stackoverflow;
> >  
> > diff --git a/kernel/panic.c b/kernel/panic.c
> > index b69ee9e76cb2..65c62f8a1de8 100644
> > --- a/kernel/panic.c
> > +++ b/kernel/panic.c
> > @@ -25,6 +25,7 @@
> >  #include <linux/kexec.h>
> >  #include <linux/sched.h>
> >  #include <linux/sysrq.h>
> > +#include <linux/ctype.h>
> >  #include <linux/init.h>
> >  #include <linux/nmi.h>
> >  #include <linux/console.h>
> > @@ -44,6 +45,8 @@ static int pause_on_oops_flag;
> >  static DEFINE_SPINLOCK(pause_on_oops_lock);
> >  bool crash_kexec_post_notifiers;
> >  int panic_on_warn __read_mostly;
> > +unsigned long panic_on_taint;
> > +bool panic_on_taint_exclusive = false;
> >  
> >  int panic_timeout = CONFIG_PANIC_TIMEOUT;
> >  EXPORT_SYMBOL_GPL(panic_timeout);
> > @@ -434,6 +437,11 @@ void add_taint(unsigned flag, enum lockdep_ok lockdep_ok)
> >  		pr_warn("Disabling lock debugging due to kernel taint\n");
> >  
> >  	set_bit(flag, &tainted_mask);
> > +
> > +	if (tainted_mask & panic_on_taint) {
> > +		panic_on_taint = 0;
> 
> This panic_on_taint resetting is redundant? It will trigger crash, do we
> need care if it's 0 or not?
>

We might still get more than one CPU hitting a taint adding code path after 
the one that tripped here called panic. To avoid multiple calls to panic, 
in that particular scenario, we clear the panic_on_taint bitmask out. 
Also, albeit non-frequent, we might be tracking TAINT_WARN, and still hit 
a WARN_ON() in the panic / kdump path, thus incurring in a second 
(and unwanted) call to panic here.  

 
> > +		panic("panic_on_taint set ...");
> > +	}
> >  }
> >  EXPORT_SYMBOL(add_taint);
> >  
> > @@ -686,3 +694,35 @@ static int __init oops_setup(char *s)
> >  	return 0;
> >  }
> >  early_param("oops", oops_setup);
> > +
> > +static int __init panic_on_taint_setup(char *s)
> > +{
> > +	/* we just ignore panic_on_taint if passed without flags */
> > +	if (!s)
> > +		goto out;
> > +
> > +	for (; *s; s++) {
> > +		int i;
> > +
> > +		if (*s == '-') {
> > +			panic_on_taint_exclusive = true;
> > +			continue;
> > +		}
> > +
> > +		for (i = 0; i < TAINT_FLAGS_COUNT; i++) {
> > +			if (toupper(*s) == taint_flags[i].c_true) {
> > +				set_bit(i, &panic_on_taint);
> > +				break;
> > +			}
> > +		}
> 
> Read admin-guide/tainted-kernels.rst, but still do not get what 'G' means.
> If I specify 'panic_on_taint="G"' or 'panic_on_taint="-G"' in cmdline,
> what is expected for this customer behaviour?
> 

This will not panic the system as no taint flag gets actually set in 
panic_on_taint bitmask for G.

G is the counterpart of P, and appears on print_tainted() whenever
TAINT_PROPRIETARY_MODULE is not set. panic_on_taint doesn't set
anything for G, as it doesn't represent any taint, but the lack
of one particular taint, instead.

(apparently, TAINT_PROPRIETARY_MODULE is the only taint flag
that follows that pattern of having an extra assigned letter 
that means its absence, and perhaps it should be removed)

> Except of above minor nitpicks, this patch looks good to me, thanks.
> 
> Reviewed-by: Baoquan He <bhe@redhat.com>
> 
> Thanks
> Baoquan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
