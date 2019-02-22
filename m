Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gx0Iy-0007f9-83
 for kexec@lists.infradead.org; Fri, 22 Feb 2019 02:11:14 +0000
Date: Fri, 22 Feb 2019 10:11:01 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCHv7] x86/kdump: bugfix, make the behavior of crashkernel=X
 consistent with kaslr
Message-ID: <20190222021101.GA11654@dhcp-128-65.nay.redhat.com>
References: <20190131234740.GO6749@zn.tnic> <20190204223016.GB11986@anatevka>
 <20190205081552.GG21801@zn.tnic>
 <20190206120804.GC10062@dhcp-128-65.nay.redhat.com>
 <20190211204816.GB21473@dhcp-128-65.nay.redhat.com>
 <20190215102458.GD10433@zn.tnic>
 <20190218014820.GA10711@dhcp-128-65.nay.redhat.com>
 <20190220083241.GA3447@zn.tnic>
 <20190220094146.GA8597@dhcp-128-65.nay.redhat.com>
 <20190221171321.GD12997@zn.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190221171321.GD12997@zn.tnic>
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
Cc: Randy Dunlap <rdunlap@infradead.org>, bhe@redhat.com, konrad.wilk@oracle.com, x86@kernel.org, kexec@lists.infradead.org, Jerry Hoemann <jerry.hoemann@hpe.com>, Pingfan Liu <kernelfans@gmail.com>, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Mike Rapoport <rppt@linux.vnet.ibm.com>, Joerg Roedel <jroedel@suse.de>, Andrew Morton <akpm@linux-foundation.org>, yinghai@kernel.org, vgoyal@redhat.com

On 02/21/19 at 06:13pm, Borislav Petkov wrote:
> On Wed, Feb 20, 2019 at 05:41:46PM +0800, Dave Young wrote:
> > Previously Joerg posted below patch, maybe he has some idea. Joerg?
> 
> Isn't it clear from the commit message?

Then, does it answered your question?

256M is set as a default value in the patch, but it is not a predict to
satisfy all use cases, from the description it is also possible that some
people run out of the 256M and the ,low and ,high format is still
necessary to exist even if we make crashkernel=X do the allocation
automatically in high in case failed in low area.

crashkernel=X:  allocate in low first, if not possible, then allocate in
high

In case people have a lot of devices need more swiotlb, then he manually
set the ,high with ,low together.

What's your suggestion then?  remove ,low and ,high and increase default
256M in case we get failure bug report?

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
