Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pb0-f49.google.com ([209.85.160.49])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1Sjxp4-0004RE-RT
 for kexec@lists.infradead.org; Wed, 27 Jun 2012 19:22:43 +0000
Received: by pbbrq13 with SMTP id rq13so2141055pbb.36
 for <kexec@lists.infradead.org>; Wed, 27 Jun 2012 12:22:41 -0700 (PDT)
Date: Wed, 27 Jun 2012 12:22:36 -0700
From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 4/5] Sysfs: Export VMCSINFO via sysfs
Message-ID: <20120627192236.GB1965@kroah.com>
References: <4FEAC945.50700@cn.fujitsu.com> <4FEACA5E.4090009@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4FEACA5E.4090009@cn.fujitsu.com>
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
To: Yanfei Zhang <zhangyanfei@cn.fujitsu.com>
Cc: dzickus@redhat.com, luto@mit.edu, kvm@vger.kernel.org, Joerg Roedel <joerg.roedel@amd.com>, mtosatti@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, paul.gortmaker@windriver.com, ludwig.nussel@suse.de, Avi Kivity <avi@redhat.com>, ebiederm@xmission.com

On Wed, Jun 27, 2012 at 04:54:54PM +0800, Yanfei Zhang wrote:
> This patch export offsets of fields via /sys/devices/cpu/vmcs/.
> Individual offsets are contained in subfiles named by the filed's
> encoding, e.g.: /sys/devices/cpu/vmcs/0800
> 
> Signed-off-by: zhangyanfei <zhangyanfei@cn.fujitsu.com>
> ---
>  drivers/base/core.c |   13 +++++++++++++
>  1 files changed, 13 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 346be8b..dd05ee7 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -26,6 +26,7 @@
>  #include <linux/async.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/netdevice.h>
> +#include <asm/vmcsinfo.h>

Did you just break the build on all other arches?  Not nice.

> @@ -1038,6 +1039,11 @@ int device_add(struct device *dev)
>  	error = dpm_sysfs_add(dev);
>  	if (error)
>  		goto DPMError;
> +#if defined(CONFIG_KVM_INTEL) || defined(CONFIG_KVM_INTEL_MODULE)
> +	error = vmcs_sysfs_add(dev);
> +	if (error)
> +		goto VMCSError;
> +#endif

Oh my no, that's no way to ever do this, you know better than that,
please fix.

greg k-h

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
