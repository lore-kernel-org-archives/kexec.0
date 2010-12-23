Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1PVZ4h-0005AV-K4
	for kexec@lists.infradead.org; Thu, 23 Dec 2010 00:30:32 +0000
Date: Wed, 22 Dec 2010 16:29:35 -0800
From: Greg KH <gregkh@suse.de>
Subject: Re: [RFC][PATCH] Add a sysctl option controlling kexec when MCE
	occurred
Message-ID: <20101223002935.GA9811@suse.de>
References: <5C4C569E8A4B9B42A84A977CF070A35B2C132F68FC@USINDEVS01.corp.hds.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5C4C569E8A4B9B42A84A977CF070A35B2C132F68FC@USINDEVS01.corp.hds.com>
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
To: Seiji Aguchi <seiji.aguchi@hds.com>
Cc: "hawk@comx.dk" <hawk@comx.dk>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "drosenberg@vsecurity.com" <drosenberg@vsecurity.com>, "dle-develop@lists.sourceforge.net" <dle-develop@lists.sourceforge.net>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "rdunlap@xenotime.net" <rdunlap@xenotime.net>, "andi@firstfloor.org" <andi@firstfloor.org>, "hpa@zytor.com" <hpa@zytor.com>, "akpm@linuxfoundation.org" <akpm@linuxfoundation.org>, "ext-andriy.shevchenko@nokia.com" <ext-andriy.shevchenko@nokia.com>, "eric.dumazet@gmail.com" <eric.dumazet@gmail.com>, "x86@kernel.org" <x86@kernel.org>, "opurdila@ixiacom.com" <opurdila@ixiacom.com>, "mingo@redhat.com" <mingo@redhat.com>, "ying.huang@intel.com" <ying.huang@intel.com>, "kees.cook@canonical.com" <kees.cook@canonical.com>, "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>, "dzickus@redhat.com" <dzickus@redhat.com>, "len.brown@intel.com" <len.brown@intel.com>, "seto.hidetoshi@jp.fujitsu.com" <seto.hidetoshi@jp.fujitsu.com>, "hadi@cyberus.ca" <hadi@cyberus.ca>, "tglx@linutronix.de" <tglx@linutronix.de>, "hidave.darkstar@gmail.com" <hidave.darkstar@gmail.com>, "eugeneteo@kernel.org" <eugeneteo@kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Satoru Moriya <satoru.moriya@hds.com>, "ebiederm@xmission.com" <ebiederm@xmission.com>, "tj@kernel.org" <tj@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>

On Wed, Dec 22, 2010 at 06:35:40PM -0500, Seiji Aguchi wrote:
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -81,6 +81,9 @@
>  #include <linux/nmi.h>
>  #endif
>  
> +#ifdef CONFIG_X86_MCE
> +#include <asm/mce.h>
> +#endif

Please don't put ifdefs in .c files, you do that a lot for this option.
Just make it work on all platforms and then you will not need the
#ifdef.

thanks,

greg k-h

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
