Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Zqzu5-0000fH-6p
 for kexec@lists.infradead.org; Tue, 27 Oct 2015 08:46:51 +0000
Date: Tue, 27 Oct 2015 16:46:22 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [V4 PATCH 4/4] x86/apic: Introduce noextnmi boot option
Message-ID: <20151027084622.GA5141@dhcp-128-28.nay.redhat.com>
References: <20150925112803.4258.94241.stgit@softrs>
 <20150925112811.4258.54494.stgit@softrs>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150925112811.4258.54494.stgit@softrs>
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
To: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
Cc: x86@kernel.org, Jonathan Corbet <corbet@lwn.net>, Peter Zijlstra <peterz@infradead.org>, linux-doc@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Vivek Goyal <vgoyal@redhat.com>

Hi,

I just have a look at this thread. I am wondering why we don't use
existing is_kdump_kernel() directly to disable external NMI if it's
in kdump kernel. Then no need to introduce another boot option "noextnmi"
which is used only for kdump kernel.

Thanks
Baoquan

On 09/25/15 at 08:28pm, Hidehiro Kawai wrote:
> This patch introduces new boot option "noextnmi" which disables
> external NMI.  This option is useful for the dump capture kernel
> so that an HA application or administrator wouldn't mistakenly
> shoot down the kernel by NMI.
> 
> Currently, only x86 supports this option.
> 
> Signed-off-by: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> ---
>  Documentation/kernel-parameters.txt |    4 ++++
>  arch/x86/kernel/apic/apic.c         |   17 ++++++++++++++++-
>  2 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
> index 22a4b68..8bcaccd 100644
> --- a/Documentation/kernel-parameters.txt
> +++ b/Documentation/kernel-parameters.txt
> @@ -2379,6 +2379,10 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
>  			noexec=on: enable non-executable mappings (default)
>  			noexec=off: disable non-executable mappings
>  
> +	noextnmi	[X86]
> +			Mask external NMI.  This option is useful for a
> +			dump capture kernel to be shot down by NMI.
> +
>  	nosmap		[X86]
>  			Disable SMAP (Supervisor Mode Access Prevention)
>  			even if it is supported by processor.
> diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
> index 24e94ce..fd47128 100644
> --- a/arch/x86/kernel/apic/apic.c
> +++ b/arch/x86/kernel/apic/apic.c
> @@ -82,6 +82,12 @@
>  static unsigned int disabled_cpu_apicid __read_mostly = BAD_APICID;
>  
>  /*
> + * Don't enable external NMI via LINT1 on BSP.  This is useful for
> + * the dump capture kernel.
> + */
> +static bool apic_noextnmi;
> +
> +/*
>   * Map cpu index to physical APIC ID
>   */
>  DEFINE_EARLY_PER_CPU_READ_MOSTLY(u16, x86_cpu_to_apicid, BAD_APICID);
> @@ -1161,6 +1167,8 @@ void __init init_bsp_APIC(void)
>  	value = APIC_DM_NMI;
>  	if (!lapic_is_integrated())		/* 82489DX */
>  		value |= APIC_LVT_LEVEL_TRIGGER;
> +	if (apic_noextnmi)
> +		value |= APIC_LVT_MASKED;
>  	apic_write(APIC_LVT1, value);
>  }
>  
> @@ -1380,7 +1388,7 @@ void setup_local_APIC(void)
>  	/*
>  	 * only the BP should see the LINT1 NMI signal, obviously.
>  	 */
> -	if (!cpu)
> +	if (!cpu && !apic_noextnmi)
>  		value = APIC_DM_NMI;
>  	else
>  		value = APIC_DM_NMI | APIC_LVT_MASKED;
> @@ -2548,3 +2556,10 @@ static int __init apic_set_disabled_cpu_apicid(char *arg)
>  	return 0;
>  }
>  early_param("disable_cpu_apicid", apic_set_disabled_cpu_apicid);
> +
> +static int __init apic_set_noextnmi(char *arg)
> +{
> +	apic_noextnmi = true;
> +	return 0;
> +}
> +early_param("noextnmi", apic_set_noextnmi);
> 
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
