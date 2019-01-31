Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gp7Fj-0002hO-Sl
 for kexec@lists.infradead.org; Thu, 31 Jan 2019 07:59:17 +0000
Date: Thu, 31 Jan 2019 15:59:07 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCHv7] x86/kdump: bugfix, make the behavior of crashkernel=X
 consistent with kaslr
Message-ID: <20190131075907.GB19091@dhcp-128-65.nay.redhat.com>
References: <1548047768-7656-1-git-send-email-kernelfans@gmail.com>
 <20190125103924.GB27998@zn.tnic>
 <20190125134518.GA23595@dhcp-128-65.nay.redhat.com>
 <20190125140823.GC27998@zn.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190125140823.GC27998@zn.tnic>
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
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, Baoquan He <bhe@redhat.com>, Randy Dunlap <rdunlap@infradead.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Pingfan Liu <kernelfans@gmail.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, yinghai@kernel.org, vgoyal@redhat.com

On 01/25/19 at 03:08pm, Borislav Petkov wrote:
> On Fri, Jan 25, 2019 at 09:45:18PM +0800, Dave Young wrote:
> > AFAIK, some people prefer to explictly reserve crash memory at high
> > region even if it is possible to reserve at low area.  May because
> > <4G memory is limited on large server, they want to leave this for other
> > use. 
> > 
> > Yinghai or Vivek should know more about the history, probably they can
> > recall some initial reason.
> 
> Yes, just "prefer" is not good enough. There should be a technical
> reason why that's there.

Got more about this, actually the thing is for large server with very
huge memory and also possible a lot of io devices.  The UEFI IO drivers
could allocate a lot memory under 896M,  so it will leave small room for
crashkernel=X

Also if the memory is huge, then copying the vmcore will be very slow,
people want to use big makedumpfile bitmap buffer, and multithread, then
kdump kernel needs more memory, they can choose ,high to get more
memory.

But for common use cases, if one does not need so much kdump memory
reserved he/she can just use crashkernel=X.


> 
> Also, if the user doesn't care, then the code should be free to force
> "high" and thus probe a different range for allocation.

As Pingfan/me mentioned in another reply, there are two reasons:
1. old kexec-tools can not load kernel to high memory
2. ,high will not work on some systems without some amounts of low
memory so it nees reserve extra low memory, it is bad for people who do
not want it. 

> 
> > Good question, still it may be some historical reason, but it is good to
> > make them clear and rethink about it after long time.
> > 
> > I also want to understand, need dig the log more.
> 
> Good idea. That would be a very nice cleanup. :-)

Let's review these different parameters:
>         crashkernel=size[KMG][@offset[KMG]]

Did not get the initial commit for this, it should be the very old
format, and kernel did not find the base address automatically for the
size

Other arches still use this, for example mips code seems needs explict
@offset, see the function mips_parse_crashkernel in
arch/mips/kernel/setup.c

Probably there are other arches as well which only support this format.

>         crashkernel=range1:size1[,range2:size2,...][@offset]

This is nice param which can help to dynamically reserve different size
depends on system memory.

>         crashkernel=size[KMG],high
>         crashkernel=size[KMG],low

We have talked about these two.  It is not graceful, but seems no way to
improve it due to the swiotlb issue.

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
