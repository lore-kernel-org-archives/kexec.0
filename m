Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fLW6D-0006Ix-HT
 for kexec@lists.infradead.org; Wed, 23 May 2018 15:54:55 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20180521025337.GA4627@dhcp-128-65.nay.redhat.com>
 <20180521120215.117d963a7619eb0d1f54bced@linux-foundation.org>
 <20180523070641.GA1689@dhcp-128-65.nay.redhat.com>
Date: Wed, 23 May 2018 10:53:55 -0500
In-Reply-To: <20180523070641.GA1689@dhcp-128-65.nay.redhat.com> (Dave Young's
 message of "Wed, 23 May 2018 15:06:41 +0800")
Message-ID: <877enucqr0.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [PATCH] kdump: add default crashkernel reserve kernel config
 options
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
To: Dave Young <dyoung@redhat.com>
Cc: dzickus@redhat.com, Neil Horman <nhorman@redhat.com>, Tony Luck <tony.luck@intel.com>, bhe@redhat.com, Michael Ellerman <mpe@ellerman.id.au>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Hari Bathini <hbathini@linux.vnet.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Cong Wang <xiyou.wangcong@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Anton Vorontsov <avorontsov@ru.mvista.com>, Ingo Molnar <mingo@kernel.org>, Vivek Goyal <vgoyal@redhat.com>

Dave Young <dyoung@redhat.com> writes:

> [snip]
>
>> >  
>> > +config CRASHKERNEL_DEFAULT_THRESHOLD_MB
>> > +	int "System memory size threshold for kdump memory default reserving"
>> > +	depends on CRASH_CORE
>> > +	default 0
>> > +	help
>> > +	  CRASHKERNEL_DEFAULT_MB is used as default crashkernel value if
>> > +	  the system memory size is equal or bigger than the threshold.
>> 
>> "the threshold" is rather vague.  Can it be clarified?
>> 
>> In fact I'm really struggling to understand the logic here....
>> 
>> 
>> > +config CRASHKERNEL_DEFAULT_MB
>> > +	int "Default crashkernel memory size reserved for kdump"
>> > +	depends on CRASH_CORE
>> > +	default 0
>> > +	help
>> > +	  This is used as the default kdump reserved memory size in MB.
>> > +	  crashkernel=X kernel cmdline can overwrite this value.
>> > +
>> >  config HAVE_IMA_KEXEC
>> >  	bool
>> >  
>> > @@ -143,6 +144,24 @@ static int __init parse_crashkernel_simp
>> >  	return 0;
>> >  }
>> >  
>> > +static int __init get_crashkernel_default(unsigned long long system_ram,
>> > +					  unsigned long long *size)
>> > +{
>> > +	unsigned long long sz = CONFIG_CRASHKERNEL_DEFAULT_MB;
>> > +	unsigned long long thres = CONFIG_CRASHKERNEL_DEFAULT_THRESHOLD_MB;
>> > +
>> > +	thres *= SZ_1M;
>> > +	sz *= SZ_1M;
>> > +
>> > +	if (sz >= system_ram || system_ram < thres) {
>> > +		pr_debug("crashkernel default size can not be used.\n");
>> > +		return -EINVAL;
>> 
>> In other words,
>> 
>> 	if (system_ram <= CONFIG_CRASHKERNEL_DEFAULT_MB ||
>> 	    system_ram < CONFIG_CRASHKERNEL_DEFAULT_THRESHOLD_MB)
>> 		fail;
>> 
>> yes?
>> 
>> How come?  What's happening here?  Perhaps a (good) explanatory comment
>> is needed.  And clearer Kconfig text.
>> 
>> All confused :(
>
> Andrew, I tuned it a bit, removed the check of sz >= system_ram, so if
> the size is too large and kernel can not find enough memory it will
> still fail in latter code.
>
> Is below version looks clearer?

What is the advantage of providing this in a kconfig option rather
than on the kernel command line as we can now?

Eric

> ---
>
> This is a rework of the crashkernel=auto patches back to 2009 although
> I'm not sure if below is the last version of the old effort:
> https://lkml.org/lkml/2009/8/12/61
> https://lwn.net/Articles/345344/
>
> I changed the original design, instead of adding the auto reserve logic
> in code, in this patch just introduce two kernel config options for
> the default crashkernel value in MB and the threshold of system memory
> in MB so that only reserve default when system memory is equal or
> above the threshold.
>
> Signed-off-by: Dave Young <dyoung@redhat.com>
> ---
> Another difference is with original design the crashkernel size scales
> with system memory, according to test, large machine may need more
> memory in kdump kernel because of several factors:
> 1. cpu numbers, because of the percpu memory allocated for cpus.
>    (kdump can use nr_cpus=1 to workaround this, but some
>     arches do not support nr_cpus=X for example powerpc) 
> 2. IO devices, large system can have a lot of io devices, although we
>    can try to only add those device drivers we needed, it is still a
>    problem because of some built-in drivers, some stacked logical devices
>    eg. device mapper devices, acpi etc.  Even if only considering the
>    meta data for driver model it will still be a big number eg. sysfs
>    files etc.
> 3. The minimum memory requirement for some device drivers are big, even
>    if some of them have implemented low meory profile.  It is usual to see
>    10M memory use for a storage driver.
> 4. user space initramfs size growing.  Busybox is not usable if we need
>    to add udev support and some complicate storage support.  Use dracut
>    with systemd, especially networking stuff need more memory.
>
> So probably add another kernel config option to scale the memory size
> eg.  CRASHKERNEL_DEFAULT_SCALE_RATIO is also good to have,  in RHEL we
> use base_value + system_mem >> (2^14) for x86.  I'm still hesatating
> how to describe and add this option. Any suggestions will be appreciated.
>
>  arch/Kconfig        |   17 +++++++++++++++++
>  kernel/crash_core.c |   19 ++++++++++++++++++-
>  2 files changed, 35 insertions(+), 1 deletion(-)
>
> --- linux-x86.orig/arch/Kconfig
> +++ linux-x86/arch/Kconfig
> @@ -10,6 +10,23 @@ config KEXEC_CORE
>  	select CRASH_CORE
>  	bool
>  
> +config CRASHKERNEL_DEFAULT_THRESHOLD_MB
> +	int "System memory size threshold for using CRASHKERNEL_DEFAULT_MB"
> +	depends on CRASH_CORE
> +	default 0
> +	help
> +	  CRASHKERNEL_DEFAULT_MB will be reserved for kdump if the system
> +	  memory is above or equal to CRASHKERNEL_DEFAULT_THRESHOLD_MB MB.
> +	  It is only effective in case no crashkernel=X parameter is used.
> +
> +config CRASHKERNEL_DEFAULT_MB
> +	int "Default crashkernel memory size reserved for kdump"
> +	depends on CRASH_CORE
> +	default 0
> +	help
> +	  This is used as the default kdump reserved memory size in MB.
> +	  crashkernel=X kernel cmdline can overwrite this value.
> +
>  config HAVE_IMA_KEXEC
>  	bool
>  
> --- linux-x86.orig/kernel/crash_core.c
> +++ linux-x86/kernel/crash_core.c
> @@ -143,6 +143,21 @@ static int __init parse_crashkernel_simp
>  	return 0;
>  }
>  
> +static int __init get_crashkernel_default(unsigned long long system_ram,
> +					  unsigned long long *size)
> +{
> +	unsigned long long system_ram_mb = system_ram >> 20;
> +
> +	if (system_ram_mb < CONFIG_CRASHKERNEL_DEFAULT_THRESHOLD_MB) {
> +		pr_debug("crashkernel: system memory size is lower than %d\n",
> +			 CONFIG_CRASHKERNEL_DEFAULT_THRESHOLD_MB);
> +		return -EINVAL;
> +	}
> +	*size = (unsigned long long)CONFIG_CRASHKERNEL_DEFAULT_MB << 20;
> +
> +	return 0;
> +}
> +
>  #define SUFFIX_HIGH 0
>  #define SUFFIX_LOW  1
>  #define SUFFIX_NULL 2
> @@ -240,8 +255,10 @@ static int __init __parse_crashkernel(ch
>  	*crash_size = 0;
>  	*crash_base = 0;
>  
> -	ck_cmdline = get_last_crashkernel(cmdline, name, suffix);
> +	if (!strstr(cmdline, "crashkernel="))
> +		return get_crashkernel_default(system_ram, crash_size);
>  
> +	ck_cmdline = get_last_crashkernel(cmdline, name, suffix);
>  	if (!ck_cmdline)
>  		return -EINVAL;
>  

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
