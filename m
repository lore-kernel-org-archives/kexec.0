Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pb0-f49.google.com ([209.85.160.49])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SmR4o-0006Rn-Kq
 for kexec@lists.infradead.org; Wed, 04 Jul 2012 15:01:27 +0000
Received: by pbbrq13 with SMTP id rq13so12442417pbb.36
 for <kexec@lists.infradead.org>; Wed, 04 Jul 2012 08:00:28 -0700 (PDT)
Date: Wed, 4 Jul 2012 07:53:45 -0700
From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4 3/3] Documentation: Add ABI entry for vmcs sysfs
 interface
Message-ID: <20120704145345.GG23020@kroah.com>
References: <4FF413D2.4030006@cn.fujitsu.com> <4FF415A4.8040405@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4FF415A4.8040405@cn.fujitsu.com>
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

On Wed, Jul 04, 2012 at 06:06:28PM +0800, Yanfei Zhang wrote:
> Signed-off-by: zhangyanfei <zhangyanfei@cn.fujitsu.com>
> ---
>  Documentation/ABI/testing/sysfs-devices-system-cpu |   21 ++++++++++++++++++++
>  1 files changed, 21 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
> index 5dab364..6efbd6c 100644
> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
> @@ -9,6 +9,27 @@ Description:
>  
>  		/sys/devices/system/cpu/cpu#/
>  
> +What:		/sys/devices/system/cpu/vmcs_id

Wait, aren't these a per-cpu value?  You have them as a "global" value
for all cpus, is that really the case?  Shouldn't they be under
/sys/devices/system/cpu/cpu#/ instead?

thanks,

greg k-h

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
