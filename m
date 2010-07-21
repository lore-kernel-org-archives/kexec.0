Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from db3ehsobe001.messaging.microsoft.com ([213.199.154.139]
	helo=DB3EHSOBE001.bigfish.com)
	by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1Obahj-00072E-78
	for kexec@lists.infradead.org; Wed, 21 Jul 2010 14:55:28 +0000
Subject: Re: [PATCH v3 0/7] Fixup booting with device trees and uImage/elf on
	ppc32
MIME-Version: 1.0 (Apple Message framework v1081)
From: Matthew McClintock <msm@freescale.com>
In-Reply-To: <20100721130944.GM6418@verge.net.au>
Date: Wed, 21 Jul 2010 09:54:59 -0500
Message-ID: <A223EDA2-40A9-468D-BA6C-C8D7C8B80643@freescale.com>
References: <1279687384-9770-1-git-send-email-msm@freescale.com>
	<20100721080518.GA13972@Chamillionaire.breakpoint.cc>
	<20100721130944.GM6418@verge.net.au>
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
Cc: muvarov@gmail.com, Sebastian Andrzej Siewior <sebastian@breakpoint.cc>, kexec@lists.infradead.org


On Jul 21, 2010, at 8:09 AM, Simon Horman wrote:

> On Wed, Jul 21, 2010 at 10:05:18AM +0200, Sebastian Andrzej Siewior wrote:
>> * Matthew McClintock | 2010-07-20 23:42:57 [-0500]:
>> 
>>> This patch series adds full support for booting with a flat device tree
>>> with either uImage or elf file formats. Kexec and Kdump should work, and
>>> you should also be able to use ramdisks or reuse your current ramdisk as well
>> 
>> just had a brief look and will try to look deeper once I'm able to. One
>> thing I'm not sure is whether we want to introduce the --reuse-initrd
>> option. In my opinion it is just bloat. Yes I know the kernel reserves
>> the region where the initrd is loaded by the boot loader but I'm unsure
>> if we want to keep it that way. We are talking here about 10 MiB which
>> remain unused once the system finished booting. If you kexec you have to
>> specify the kernel, why not the initrd as well?
> 
> I tend to agree with Sebastian on this one.

Well, I think it was already around in the code (git grep OPT_REUSE_INITRD) in some format so I just made it work. I don't tend to have an opinion one way or the other, but I can see it being quite useful for people starting off and don't know how to extract their initrd from their flash or something like that. Otherwise, there is very little overhead code wise to have it in there.

-Matthew

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
