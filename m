Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mailout.stusta.mhn.de ([141.84.69.5] helo=mailhub.stusta.mhn.de)
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IGxHH-0005cV-Mm
	for kexec@lists.infradead.org; Fri, 03 Aug 2007 09:33:40 -0400
Date: Fri, 3 Aug 2007 15:30:54 +0200
From: Adrian Bunk <bunk@stusta.de>
Subject: Re: [RFC] Handling kernel stack overflows
Message-ID: <20070803133054.GB3972@stusta.de>
References: <31700.1186113953@kao2.melbourne.sgi.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <31700.1186113953@kao2.melbourne.sgi.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Keith Owens <kaos@ocs.com.au>
Cc: k-miyoshi@cb.jp.nec.com, Bernhard Walle <bwalle@suse.de>, kexec@lists.infradead.org, Takenori Nagano <t-nagano@ah.jp.nec.com>, linux-kernel@vger.kernel.org, vgoyal@in.ibm.com, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>

On Fri, Aug 03, 2007 at 02:05:53PM +1000, Keith Owens wrote:
>...
> Long answer:
> 
> * Define a config option to control whether or not extra kernel stacks
>   are to be used.  Set this config option by default on i386 and
>   x86_64, unless EMBEDDED is set, in which case it becomes a user
>   selectable option.  It can never be set on IA64, the 'struct task'
>   embedded in the stack prevents that.  Decide about other
>   architectures as required.
> 
> * Create a tunable number of extra kernel stacks on each cpu as it
>   boots.  They are created on each cpu to avoid taking all the memory
>   from any one node.

None of this should be in any way user selectable.

We are currently having problems although distributions ship with
4k stacks. Any option offering less than the default distributions 
ship with, in the worst case hidden under EMBEEDED, could be called
CONFIG_NONWORKING_KERNEL since it will be an untested configuration that 
will no longer be working after some time.

>...
> * If the usage threshold has been reached, do down_trylock() on the
>   counting semaphore.  If all of the extra stacks are in use then
>   down_trylock() will fail, log a rate limited error and return -EIO.
>   The caller will get an I/O error, but that is far better than
>   overflowing the kernel stack and crashing the entire machine.
>
> * At each critical point, if the config option is true we check how
>   much of the current stack is in use.  If that figure is less than a
>   threshold value then continue with normal processing on the current
>   stack, no change.  Checking the stack usage requires an arch specific
>   routine.
>...

Even with the current stack usage in the kernel the threshold value must 
be at a value that you can't do this with only 4 kB of initial stack 
since you'd have to use extra stack when you have 3 kB left.

Why?

Consider that the highest stack usage of a single function of a network 
device driver (sic) is currently over 2 kB. [1]

And since relaxed stack usage rules will result in driver authors 
becoming more sloppy, only 3 kB of free stack won't always be enough...

cu
Adrian

[1] http://lkml.org/lkml/2006/12/13/87

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
