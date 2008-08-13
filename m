Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KT7Gr-0002ke-O5
	for kexec@lists.infradead.org; Wed, 13 Aug 2008 03:43:38 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <1218589475.24951.59.camel@caritas-dev.intel.com>
	<20080813024701.GA19201@verge.net.au>
	<1218596715.24951.69.camel@caritas-dev.intel.com>
Date: Tue, 12 Aug 2008 20:40:19 -0700
In-Reply-To: <1218596715.24951.69.camel@caritas-dev.intel.com> (Huang Ying's
	message of "Wed, 13 Aug 2008 11:05:15 +0800")
Message-ID: <m1d4kdk2fw.fsf@frodo.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [PATCH] kexec jump: fix code size checking
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
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Simon Horman <horms@verge.net.au>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, mingo@elte.hu, Vivek Goyal <vgoyal@redhat.com>

Huang Ying <ying.huang@intel.com> writes:

> On Wed, 2008-08-13 at 12:47 +1000, Simon Horman wrote:
>> On Wed, Aug 13, 2008 at 09:04:35AM +0800, Huang Ying wrote:
>> > Fix building issue when CONFIG_KEXEC=n. Thanks to Vivek Goyal for his
>> > reminding.
>> > 
>> > Signed-off-by: Huang Ying <ying.huang@intel.com>
>> > 
>> > ---
>> >  include/asm-x86/kexec.h |    3 +++
>> >  1 file changed, 3 insertions(+)
>> > 
>> > --- a/include/asm-x86/kexec.h
>> > +++ b/include/asm-x86/kexec.h
>> > @@ -43,6 +43,9 @@
>> >  
>> >  #ifdef CONFIG_X86_32
>> >  # define KEXEC_CONTROL_CODE_MAX_SIZE	2048
>> > +# ifndef CONFIG_KEXEC
>> > +#  define kexec_control_code_size	0
>> > +# endif
>> >  #endif
>> >  
>> >  #ifndef __ASSEMBLY__
>> 
>> Is it impossible to skip the linker check in the !CONFIG_KEXEC case?
>
> It is possible. I think there are several ways to do that.
>
> 1) use #ifdef in vmlinux_32.lds.S, such as:
>
> #ifdef CONFIG_KEXEC
> ASSERT(kexec_control_code_size <= KEXEC_CONTROL_CODE_MAX_SIZE,
>        "kexec control code size is too big")
> #endif
>
> 2) #define a macro for kexec check ld script in asm/kexec.h, such as:
>
> #define LD_CHECK_KEXEC() ASSERT(kexec_control_code_size <=
> KEXEC_CONTROL_CODE_MAX_SIZE, \
> 				       "kexec control code size is too big")
>
> and use that in vmlinux_32.lds.S.
>
> 3) #define kexec_control_code_size 0. So that the check can be passed
> always. And, code size = 0 is reasonable for no code (CONFIG_KEXEC=n).
>
>
> I think 3) is better. What do you think about?

4) Put the code is a special section .text.kexec? and have the linker
   always do the size comparison and the computation of the section size.

The fewer conditionals we have the less likely something is to break.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
