Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail.linuxfoundation.org ([140.211.169.12])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1RJvC3-0002Q6-PW
	for kexec@lists.infradead.org; Fri, 28 Oct 2011 22:46:32 +0000
Date: Fri, 28 Oct 2011 15:46:30 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] kdump: Add udev events for memory online/offline
Message-Id: <20111028154630.77c7b96c.akpm@linux-foundation.org>
In-Reply-To: <1319707965.2830.1.camel@br98xy6r>
References: <1319645292.3321.24.camel@br98xy6r>
	<20111026192449.GE355@redhat.com>
	<20111027073058.GA2422@osiris.boeblingen.de.ibm.com>
	<1319707965.2830.1.camel@br98xy6r>
Mime-Version: 1.0
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
To: holzheu@linux.vnet.ibm.com
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Kay Sievers <kay.sievers@vrfy.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Dave Hansen <haveblue@us.ibm.com>, "Eric W. Biederman" <ebiederm@xmission.com>, schwidefsky@de.ibm.com, Vivek Goyal <vgoyal@redhat.com>

On Thu, 27 Oct 2011 11:32:45 +0200
Michael Holzheu <holzheu@linux.vnet.ibm.com> wrote:

> From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
> 
> Currently no udev events for memory hotplug "online" and "offline" are
> generated:
> 
> # udevadm monitor
> # echo offline > /sys/devices/system/memory/memory4/state
> ==> No event
> 
> When kdump is loaded, kexec detects the current memory configuration and
> stores it in the pre-allocated ELF core header. Therefore, for kdump it is
> necessary to reload the kdump kernel with kexec when the memory
> configuration changes (e.g. for online/offline hotplug memory).
> 
> In order to do this automatically, udev rules should be used. This kernel
> patch adds udev events for "online" and "offline". Together with this kernel
> patch, the following udev rules for online/offline have to be added to
> "/etc/udev/rules.d/98-kexec.rules":
> 
> SUBSYSTEM=="memory", ACTION=="online", PROGRAM="/etc/init.d/kdump restart"
> SUBSYSTEM=="memory", ACTION=="offline", PROGRAM="/etc/init.d/kdump restart"
> 
> Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
> ---
>  drivers/base/memory.c |   10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -310,11 +310,15 @@ store_mem_state(struct sys_device *dev,
>  
>  	mem = container_of(dev, struct memory_block, sysdev);
>  
> -	if (!strncmp(buf, "online", min((int)count, 6)))
> +	if (!strncmp(buf, "online", min((int)count, 6))) {
>  		ret = memory_block_change_state(mem, MEM_ONLINE, MEM_OFFLINE);
> -	else if(!strncmp(buf, "offline", min((int)count, 7)))
> +		if (ret == 0)
> +			kobject_uevent(&dev->kobj, KOBJ_ONLINE);
> +	} else if (!strncmp(buf, "offline", min((int)count, 7))) {
>  		ret = memory_block_change_state(mem, MEM_OFFLINE, MEM_ONLINE);
> -
> +		if (ret == 0)
> +			kobject_uevent(&dev->kobj, KOBJ_OFFLINE);
> +	}
>  	if (ret)
>  		return ret;
>  	return count;

I think a safer place from which to send the uevent is
memory_block_change_state() or even memory_block_action().  Because if
either of those functions later gets new callers, those callers might
forget to send the uevent?


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
