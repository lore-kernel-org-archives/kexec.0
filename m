Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15] helo=mx1.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyE09-0001zW-UG
 for kexec@lists.infradead.org; Mon, 25 Feb 2019 11:00:56 +0000
Date: Mon, 25 Feb 2019 12:00:43 +0100
From: Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCHv7] x86/kdump: bugfix, make the behavior of crashkernel=X
 consistent with kaslr
Message-ID: <20190225110043.GA5884@suse.de>
References: <20190206120804.GC10062@dhcp-128-65.nay.redhat.com>
 <20190211204816.GB21473@dhcp-128-65.nay.redhat.com>
 <20190215102458.GD10433@zn.tnic>
 <20190218014820.GA10711@dhcp-128-65.nay.redhat.com>
 <20190220083241.GA3447@zn.tnic>
 <20190220094146.GA8597@dhcp-128-65.nay.redhat.com>
 <20190221171321.GD12997@zn.tnic>
 <20190222021101.GA11654@dhcp-128-65.nay.redhat.com>
 <20190222084241.GC8380@suse.de> <20190222130026.GA30766@zn.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190222130026.GA30766@zn.tnic>
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
Cc: Randy Dunlap <rdunlap@infradead.org>, bhe@redhat.com, konrad.wilk@oracle.com, yinghai@kernel.org, x86@kernel.org, kexec@lists.infradead.org, Jerry Hoemann <jerry.hoemann@hpe.com>, Pingfan Liu <kernelfans@gmail.com>, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Mike Rapoport <rppt@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Dave Young <dyoung@redhat.com>, vgoyal@redhat.com

On Fri, Feb 22, 2019 at 02:00:26PM +0100, Borislav Petkov wrote:
> On Fri, Feb 22, 2019 at 09:42:41AM +0100, Joerg Roedel wrote:
> > The current default of 256MB was found by experiments on a bigger
> > number of machines, to create a reasonable default that is at least
> > likely to be sufficient of an average machine.
> 
> Exactly, and this is what makes sense.
> 
> The code should try the requested reservation and if it fails, it should
> try high allocation with default swiotlb size because we need to reserve
> *some* range.

Right, makes sense. While at it, maybe it is time to move the default
allocation policy to 'high' again. The change was reverted six years ago
because it broke old kexec tools, but those are probably out-of-service
now. I think this change would make the whole crashdump allocation
process less fragile.

Regards,

	Joerg


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
