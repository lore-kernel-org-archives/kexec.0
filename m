Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gy5Sw-0006gO-Q4
 for kexec@lists.infradead.org; Mon, 25 Feb 2019 01:54:01 +0000
Date: Mon, 25 Feb 2019 09:53:46 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCHv7] x86/kdump: bugfix, make the behavior of crashkernel=X
 consistent with kaslr
Message-ID: <20190225015346.GC1941@dhcp-128-65.nay.redhat.com>
References: <20190211204816.GB21473@dhcp-128-65.nay.redhat.com>
 <20190215102458.GD10433@zn.tnic>
 <20190218014820.GA10711@dhcp-128-65.nay.redhat.com>
 <20190220083241.GA3447@zn.tnic>
 <20190220094146.GA8597@dhcp-128-65.nay.redhat.com>
 <20190221171321.GD12997@zn.tnic>
 <20190222021101.GA11654@dhcp-128-65.nay.redhat.com>
 <20190222084241.GC8380@suse.de> <20190222130026.GA30766@zn.tnic>
 <CAFgQCTtYJOU=rdpzMaxXxRFAHGkOWYXFD+XiHSHMhGdRFmK+9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAFgQCTtYJOU=rdpzMaxXxRFAHGkOWYXFD+XiHSHMhGdRFmK+9Q@mail.gmail.com>
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
To: Pingfan Liu <kernelfans@gmail.com>
Cc: Joerg Roedel <jroedel@suse.de>, Baoquan He <bhe@redhat.com>, konrad.wilk@oracle.com, x86@kernel.org, kexec@lists.infradead.org, Jerry Hoemann <jerry.hoemann@hpe.com>, LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org, Mike Rapoport <rppt@linux.vnet.ibm.com>, Borislav Petkov <bp@alien8.de>, Randy Dunlap <rdunlap@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Yinghai Lu <yinghai@kernel.org>, vgoyal@redhat.com

On 02/24/19 at 09:25pm, Pingfan Liu wrote:
> On Fri, Feb 22, 2019 at 9:00 PM Borislav Petkov <bp@alien8.de> wrote:
> >
> > On Fri, Feb 22, 2019 at 09:42:41AM +0100, Joerg Roedel wrote:
> > > The current default of 256MB was found by experiments on a bigger
> > > number of machines, to create a reasonable default that is at least
> > > likely to be sufficient of an average machine.
> >
> > Exactly, and this is what makes sense.
> >
> > The code should try the requested reservation and if it fails, it should
> > try high allocation with default swiotlb size because we need to reserve
> > *some* range.
> >
> > If that reservation succeeds, we should say something along the lines of
> >
> > "... requested range failed, reserved <X> range instead."
> >
> Maybe I misunderstood you, but does "requested range failed" mean that
> user specify the range? If yes, then it should be the duty of user as
> you said later, not the duty of kernel"

If you go with the changes in your current patch it is needed to say
something like:
"crashkernel: can not find free memory under 4G, reserve XM@.. instead" 

Also need to print the reserved low memory area in case ,high being used.

But for 896M -> 4G, the 896M faulure is not necessary to show in dmesg,
it is some in kernel logic.

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
