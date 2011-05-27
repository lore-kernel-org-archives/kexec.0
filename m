Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1QQ1Jm-0005ll-JU
	for kexec@lists.infradead.org; Fri, 27 May 2011 17:59:27 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20110526170722.GB23266@in.ibm.com>
	<20110526171209.GA17988@in.ibm.com>
Date: Fri, 27 May 2011 10:59:11 -0700
In-Reply-To: <20110526171209.GA17988@in.ibm.com> (K. Prasad's message of "Thu, 
	26 May 2011 22:42:09 +0530")
Message-ID: <m1tycg9g9c.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [Patch 1/6] XPANIC: Add extended panic interface
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: prasad@linux.vnet.ibm.com
Cc: "Luck, Tony" <tony.luck@intel.com>, kexec@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, anderson@redhat.com, Vivek Goyal <vgoyal@redhat.com>

"K.Prasad" <prasad@linux.vnet.ibm.com> writes:

> commit e668fa1aea7844ac4c7ea09030a2f3e647a4adb1
> Author: Andi Kleen <ak@linux.intel.com>
> Date:   Fri Nov 19 18:36:44 2010 +0100
>
>     XPANIC: Add extended panic interface
>     
>     One panic size doesn't fit all.
>     
>     Machine check has some special requirements on panic, like:
>     - It wants to do a reboot timeout by default so that the machine
>     check event can be logged to disk after warm reboot.

There is certainly not comment to that effect and I have not see a
mechanism that does that.

>     - For memory errors it usually doesn't want to do crash dumps because
>     that can lead to crash loops (dumping corrupted memory would
>     lead to another machine check)

It usually doesn't, and it would not lead to a crash loop just a failure
to capture the cause of the crash.

>     - It doesn't want to do backtraces because machine checks
>     are not a kernel bug.

But it sure is nice to know where it happened anyway, so you can guess
the damage.  This sounds like more of the Andi thing where he doesn't
want to hear about memory errors, because it is not a software problem.

That is definitely not sufficient reason to turn off backtraces.

>     In a earlier patch this was done with various adhoc hacks,
>     but it's cleaner to extend panic to a 'xpanic' that directly
>     gets a flag and timeout argument.
>     
>     The only user right now will be x86 machine checks, but I consider
>     it likely that other users will switch to this too.
>     
>     For example one obvious candidate would be the "no root
>     found" panic which doesn't really deserve a backtrace.

That does seem like a good fit for that case.  However it doesn't seem
like a good fit for your case.

>     I exported a vpanic() interface too as a global. That's not
>     needed by the current user, but the interface has to exist
>     internally anyways and I could see how other code would
>     find a v* variant of panic useful.
>     
>     Originally based on a suggestion by H. Peter Anvin.
>     Signed-off-by: Andi Kleen <ak@linux.intel.com>

Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>

This entire chunk of two patches appears to be complete non-sense.

mce_panic_timeout is hard coded policy that userspace does not get
to control, that overrides userspace policy.

It looks to me like the right solution is just to delete the 
mce_panic_timeout.

As for the extra flags that you add the panic path.  They can
only make the code more fragile.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
