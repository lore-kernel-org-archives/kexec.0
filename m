Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TGWm5-0005vt-At
 for kexec@lists.infradead.org; Tue, 25 Sep 2012 15:10:14 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <E1TGHkf-0006ZB-22@eag09.americas.sgi.com>
 <877grissof.fsf@xmission.com> <20120925141834.GA6184@sgi.com>
Date: Tue, 25 Sep 2012 08:10:04 -0700
In-Reply-To: <20120925141834.GA6184@sgi.com> (Cliff Wickman's message of "Tue, 
 25 Sep 2012 09:18:34 -0500")
Message-ID: <871uhqnnoz.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: 896MB address limit
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Cliff Wickman <cpw@sgi.com>
Cc: kexec@lists.infradead.org

Cliff Wickman <cpw@sgi.com> writes:

> Hi Eric, and all,
>
> On Mon, Sep 24, 2012 at 08:11:12PM -0700, Eric W. Biederman wrote:
>> Cliff Wickman <cpw@sgi.com> writes:
>> 
>> > Gentlemen,
>> >
>> > In dumping very large memories we are running up against the 896MB 
>> > limit in SLES11SP2 (3.0.38 kernel).
>> 
>> Odd.  That limit should be the maximum address in memory to load the
>> crash kernel.  Tha limit should have nothing to do with the dump process
>> itself.
>> 
>> Are you saying you need more that 512MiB reserved for the crash kernel
>> to be able to dump all of the memory in your system?
>> 
>> Eric
>
> As I noted to Eric privately, yes we need to bump up to crashkernel=1G
> or more for some very large memories.
>
> As an experiment I bumped
> +++ linux/arch/x86/kernel/setup.c
> @@ -528,7 +528,7 @@ static inline unsigned long long get_tot
>  #ifdef CONFIG_X86_32
>  # define CRASH_KERNEL_ADDR_MAX (512 << 20)
>  #else
> -# define CRASH_KERNEL_ADDR_MAX (896 << 20)
> +# define CRASH_KERNEL_ADDR_MAX (1700 << 20)
>
> And that seems to work.  i.e. I'm currently dumping a system where
> crashkernel=1G and it seems to be working.
>
> Am I just living dangerously? 

So fundamentally this should work.  However there have been a lot of
kinks and silly limitations in the x86 boot protocol.

So it used to be that the bootloader protocol variable ramdisk_max was
set to 896M for 32bit kernels.  Because the ramdisk could not be located
in high memory.

Looking today it appears that ramdisk_max has been upped to 4G.

I will let you look through the /sbin/kexec source code.

As for testing I would up the limit to 4G on x86_64 and see how far
you get.

The practical question does the system still work with crashkernel=32M
when you have raised the limit much higher. 

So I would test with crashkernel=1G@2G and see if that works.  If that
works I figure that in practice all of the bugs are historical and we
can forget them.  But a sweep through the /sbin/kexec code for the magic
number 896 might not be out of order.

Eric





_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
