Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VoGNw-0003R2-Uf
 for kexec@lists.infradead.org; Wed, 04 Dec 2013 17:37:19 +0000
Date: Wed, 4 Dec 2013 12:36:36 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v9] x86, apic, kexec, Documentation: Add disable_cpu_apic
 kernel parameter
Message-ID: <20131204173635.GE19087@redhat.com>
References: <529D34AA.1000809@jp.fujitsu.com>
 <20131203152536.GE4251@redhat.com>
 <529E9CA6.5040200@jp.fujitsu.com> <529ECAAB.8040309@jp.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <529ECAAB.8040309@jp.fujitsu.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: "H. Peter Anvin" <hpa@linux.intel.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jerry Hoemann <jerry.hoemann@hp.com>, Borislav Petkov <bp@alien8.de>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Fengguang Wu <fengguang.wu@intel.com>, Jingbai Ma <jingbai.ma@hp.com>

On Wed, Dec 04, 2013 at 03:24:43PM +0900, HATAYAMA Daisuke wrote:
> (2013/12/04 12:08), HATAYAMA Daisuke wrote:
> >(2013/12/04 0:25), Vivek Goyal wrote:
> >>On Tue, Dec 03, 2013 at 10:32:26AM +0900, HATAYAMA Daisuke wrote:
> >>
> >>[..]
> >>>
> >>>diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
> >>>index 50680a5..dd77bec 100644
> >>>--- a/Documentation/kernel-parameters.txt
> >>>+++ b/Documentation/kernel-parameters.txt
> >>>@@ -774,6 +774,15 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
> >>>      disable=    [IPV6]
> >>>              See Documentation/networking/ipv6.txt.
> >>>
> >>>+    disable_cpu_apicid= [X86,APIC,KEXEC,SMP]
> >>
> >>Hi Hatayama,
> >>
> >>We are almost there. A minor nit. Why have we specified KEXEC here. This
> >>parameter disabled_cpu_apicid does not seem to dependon CONFIG_KEXEC?
> >>
> >>Jerry, this patch looks good to me. Does it work on your system?
> >>
> >
> >Because primary user for the option is currently kexec/kdump only.
> >
> >I referred to acpi_rsdp description:
> >
> >         acpi_rsdp=      [ACPI,EFI,KEXEC]
> >                         Pass the RSDP address to the kernel, mostly used
> >                         on machines running EFI runtime service to boot the
> >                         second kernel for kdump.
> >
> 
> Indo-san, who introduced acpi_rsdp and KEXEC tag, told me that historical reason
> why KEXEC tag was introduced. disable_cpu_apicid is generic at least in the
> current version, so the tag doesn't need to be specified here.

Also Documentation/kernel-parameters.txt says following.

"The parameters listed below are only valid if certain kernel build options
 were enabled and if respective hardware is present. The text in square
 brackets at the beginning of each description states the restrictions within
 which a parameter is applicable:"

As above parameter is not dependent on CONFIG_KEXEC, we should remove
KEXEC from the brackets.

acpi_rsdp is defined only if CONFIG_KEXEC is present, so there specifying
kexec makes sense.

#ifdef CONFIG_KEXEC
static unsigned long acpi_rsdp;
static int __init setup_acpi_rsdp(char *arg)
{
        acpi_rsdp = simple_strtoul(arg, NULL, 16);
        return 0;
}
early_param("acpi_rsdp", setup_acpi_rsdp);
#endif

Thanks
Vivek


> 
> I'll post a new version soon.
> 
> -- 
> Thanks.
> HATAYAMA, Daisuke

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
