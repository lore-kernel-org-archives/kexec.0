Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1W6COl-0005j5-JY
 for kexec@lists.infradead.org; Thu, 23 Jan 2014 05:00:16 +0000
Date: Thu, 23 Jan 2014 13:00:22 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH 0/3] kexec-tools: fix bugs and pass initrd position for arm
Message-ID: <20140123050022.GH3768@dhcp-16-126.nay.redhat.com>
References: <1390387924-73946-1-git-send-email-wangnan0@huawei.com>
 <20140123024716.GF3768@dhcp-16-126.nay.redhat.com>
 <52E084DA.1000507@huawei.com>
 <20140123033851.GG3768@dhcp-16-126.nay.redhat.com>
 <52E097C6.9090509@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <52E097C6.9090509@huawei.com>
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
To: Wang Nan <wangnan0@huawei.com>
Cc: Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, Geng Hui <hui.geng@huawei.com>

On 01/23/14 at 12:17pm, Wang Nan wrote:
> On 2014/1/23 11:38, Dave Young wrote:
> > On 01/23/14 at 10:56am, Wang Nan wrote:
> >> On 2014/1/23 10:47, Dave Young wrote:
> >>> On 01/22/14 at 06:52pm, Wang Nan wrote:
> >>>> Hi,
> >>>>
> >>>> This patch series contains following bug fixes and cleanups for
> >>>> kexec-tools on arm platform:
> >>>>
> >>>> Wang Nan (3):
> >>>>   kexec: align initrd when no --image-size
> >>>>   kexec: pass initrd position in dtb
> >>>>   kexec: increase zImage compress ratio from 4 to 5
> >>>
> >>> One question:
> >>> Is these kexec-tools patches enough for kexec work or still need the
> >>> kernel patches you sent?
> >>>
> >>> Thanks
> >>> Dave
> >>>
> >>
> >> kexec will work without the kernel side patches, but the atag, kernel
> >> cmdline, dtb information and kernel configuration must be carefully
> >> adjusted.
> >>
> > 
> > It does not work for me with below:
> > kexec -l /boot/vmlinuz-`uname -r` --append=`cat /proc/cmdline` --dtb vexpress-v2p-ca9.dtb
> > 
> > The dtb and kexec kernel are exactly same with the 1st kernel.
> > Is there any other things for setup in qemu, but probably it's different from your hardware
> > setup..
> > 
> > Thanks
> > Dave
> > 
> 
> I only tried crash dump case. In my testing, following things need to be check:

Thanks for your suggestion.

> 
> 1. When using dtb, the second kernel should disable CONFIG_ATAGS and CONFIG_ARM_APPENDED_DTB

Will try though I think it should be fixed and detected automaticlly.

> 2. In the second kernel, the memory information must be reconfigured using dtb or cmdline.
> 
> for example:
> 
> first kernel:
>  memory {
>   device_type = "memory";
>   reg = <0x80000000 0x40000000>;
>  };
> 
> if you want to load the second kernel at 0xa0000000: second kernel:
>  memory {
>   device_type = "memory";
>   reg = <0xa0000000 0x20000000>;
>  };
> 
> Pass a mem= option may also work, but when loading crash kernel, kexec-tools also append mem=
> option to cmdline, they may conflict with each other.
> 
> The 3rd patch of my kernel patch is used to avoid the device tree reconfiguration, but it has not been
> accepted.

Great, will take a look and try your patch.

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
