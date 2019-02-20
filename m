Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwOO8-0003Hf-23
 for kexec@lists.infradead.org; Wed, 20 Feb 2019 09:42:01 +0000
Date: Wed, 20 Feb 2019 17:41:46 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCHv7] x86/kdump: bugfix, make the behavior of crashkernel=X
 consistent with kaslr
Message-ID: <20190220094146.GA8597@dhcp-128-65.nay.redhat.com>
References: <20190131105732.GC6749@zn.tnic> <20190131222732.GA946@anatevka>
 <20190131234740.GO6749@zn.tnic> <20190204223016.GB11986@anatevka>
 <20190205081552.GG21801@zn.tnic>
 <20190206120804.GC10062@dhcp-128-65.nay.redhat.com>
 <20190211204816.GB21473@dhcp-128-65.nay.redhat.com>
 <20190215102458.GD10433@zn.tnic>
 <20190218014820.GA10711@dhcp-128-65.nay.redhat.com>
 <20190220083241.GA3447@zn.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190220083241.GA3447@zn.tnic>
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

On 02/20/19 at 09:32am, Borislav Petkov wrote:
> On Mon, Feb 18, 2019 at 09:48:20AM +0800, Dave Young wrote:
> > It is ideal if kernel can do it automatically, but I'm not sure if
> > kernel can predict the swiotlb reserved size automatically.
> 
> Do you see how even more absurd this gets?
> 
> If the kernel cannot know the swiotlb reserved size automatically, how
> is the normal user even supposed to know?!
> 
> I see swiotlb_size_or_default() so we have a sane default which we fall
> back to. Now where's the problem with that?

Good question, I expect some answer from people who know more about the
background.  It would be good to have some actual test results, Pingfan
is trying to do some tests.

Previously Joerg posted below patch, maybe he has some idea. Joerg?

commit 94fb9334182284e8e7e4bcb9125c25dc33af19d4
Author: Joerg Roedel <jroedel@suse.de>
Date:   Wed Jun 10 17:49:42 2015 +0200

    x86/crash: Allocate enough low memory when crashkernel=high

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
