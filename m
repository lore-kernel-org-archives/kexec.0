Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from db3ehsobe003.messaging.microsoft.com ([213.199.154.141]
	helo=DB3EHSOBE003.bigfish.com)
	by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1OeVaa-0002wo-IY
	for kexec@lists.infradead.org; Thu, 29 Jul 2010 16:04:13 +0000
Subject: Re: [PATCH v2 5/7] Add support for ramdisk on ppc32 for uImage-ppc
	and Elf-ppc
MIME-Version: 1.0 (Apple Message framework v1081)
From: Matthew McClintock <msm@freescale.com>
In-Reply-To: <20100729083324.GC10021@verge.net.au>
Date: Thu, 29 Jul 2010 11:03:54 -0500
Message-ID: <96019506-16C7-46A2-A051-2EFA5CE910B2@freescale.com>
References: <1279656900-27458-1-git-send-email-msm@freescale.com>
	<1279656900-27458-2-git-send-email-msm@freescale.com>
	<1279656900-27458-3-git-send-email-msm@freescale.com>
	<1279656900-27458-4-git-send-email-msm@freescale.com>
	<1279656900-27458-5-git-send-email-msm@freescale.com>
	<20100729083324.GC10021@verge.net.au>
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
To: Simon Horman <horms@verge.net.au>
Cc: linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org


On Jul 29, 2010, at 3:33 AM, Simon Horman wrote:

> On Tue, Jul 20, 2010 at 03:14:58PM -0500, Matthew McClintock wrote:
>> This fixes --reuseinitrd and --ramdisk option for ppc32 on
>> uImage-ppc and Elf. It works for normal kexec as well as for
>> kdump.
>> 
>> When using --reuseinitrd you need to specifify retain_initrd
>> on the command line. Also, if you are doing kdump you need to make
>> sure your initrd lives in the crashdump region otherwise the
>> kdump kernel will not be able to access it. The --ramdisk option
>> should always work.
> 
> Thanks, I have applied this change.
> I had to do a minor merge on the Makefile,
> could you verify that the result is correct?
> 

Tested and looks good.

-M


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
