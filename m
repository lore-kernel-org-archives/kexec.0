Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1MypDe-00044q-CL
	for kexec@lists.infradead.org; Fri, 16 Oct 2009 15:59:58 +0000
Date: Fri, 16 Oct 2009 23:59:37 +0800 (CST)
Message-Id: <20091016.235937.202130176.caiqian@redhat.com>
Subject: Re: [PATCH 0/5] make '-x'/'-i' option unnecessary for re-filtering.
From: CAI Qian <caiqian@redhat.com>
In-Reply-To: <4AD40DB4.6030808@mxs.nes.nec.co.jp>
References: <20091010.165135.12569232.caiqian@redhat.com>
	<4AD3D19F.7000508@mxs.nes.nec.co.jp>
	<4AD40DB4.6030808@mxs.nes.nec.co.jp>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: oomichi@mxs.nes.nec.co.jp
Cc: usui@mxm.nes.nec.co.jp, tindoh@redhat.com, kexec@lists.infradead.org, caiqian@redhat.com, anderson@redhat.com

Hello Ken'ichi!

This series of patches is working great here.

Thanks!
CAI Qian

From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
Subject: [PATCH 0/5] make '-x'/'-i' option unnecessary for re-filtering.
Date: Tue, 13 Oct 2009 14:18:44 +0900

> 
> Hi,
> 
> Ken'ichi Ohmichi wrote:
>> Hi CAI,
>> 
>> Thank you for testing and a good point.
>> 
>> CAI Qian wrote:
>>>> makedumpfile version 1.3.4 is released.
>>>> Your comments/patches are welcome.
>>>>
>>>> Changelog:
>>>>  o New feature
>>>>    - Support kdump-compressed format for input file. (by Takao Indoh)
>>>>       A new makedumpfile can read dumpfile which is kdump-compressed format
>>>>       instead of /proc/vmcore and re-filter it.
>>> Does it need to specify either a vmlinux or vmcoreinfo file?
>> 
>> Yes, we need to do it for re-filtering now.
>> But it is not difficult to implement a feature that it is not
>> necessary to specify either a vmlinux or vmcoreinfo file for
>> re-filtering. I will try to implement the feature.
> 
> I created the patchset for implementing the above feature.
> Any comments/patches are welcome.
> 
> ---
> [PATCH 0/5] make '-x'/'-i' option unnecessary for re-filtering.
> 
> makedumpfile v1.3.4 can read a dumpfile which is kdump-compressed
> format instead of /proc/vmcore and re-filter it.
> 
> When re-filtering, it is necessary to specify '-x'/'-i' option.
> If not specifying, makedumpfile fails like the following:
> 
>  # ./makedumpfile -c -d 3 vmcore vmcore.1
>  ...
>  The dumpfile is saved to vmcore.1
>  ...
>  #
>  # /makedumpfile -c -d 31 vmcore.1 vmcore.2
>  vmcore.1 doesn't contain vmcoreinfo.
>  Specify '-x' option or '-i' option.
>  Commandline parameter is invalid.
>  Try `makedumpfile --help' for more information.
>  #
> 
> For usability, this patchset makes '-x'/'-i' option unnecessary
> for re-filtering.
> 
> 
> Thanks
> Ken'ichi Ohmichi
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
