Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([5.9.137.197])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyESa-0006HI-Dw
 for kexec@lists.infradead.org; Mon, 25 Feb 2019 11:30:13 +0000
Date: Mon, 25 Feb 2019 12:30:03 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCHv7] x86/kdump: bugfix, make the behavior of crashkernel=X
 consistent with kaslr
Message-ID: <20190225113003.GE26145@zn.tnic>
References: <20190215102458.GD10433@zn.tnic>
 <20190218014820.GA10711@dhcp-128-65.nay.redhat.com>
 <20190220083241.GA3447@zn.tnic>
 <20190220094146.GA8597@dhcp-128-65.nay.redhat.com>
 <20190221171321.GD12997@zn.tnic>
 <20190222021101.GA11654@dhcp-128-65.nay.redhat.com>
 <20190222084241.GC8380@suse.de> <20190222130026.GA30766@zn.tnic>
 <20190225110043.GA5884@suse.de>
 <20190225111216.GA9276@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190225111216.GA9276@dhcp-128-65.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: Joerg Roedel <jroedel@suse.de>, bhe@redhat.com, konrad.wilk@oracle.com, x86@kernel.org, kexec@lists.infradead.org, Jerry Hoemann <jerry.hoemann@hpe.com>, Pingfan Liu <kernelfans@gmail.com>, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Mike Rapoport <rppt@linux.vnet.ibm.com>, Randy Dunlap <rdunlap@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, yinghai@kernel.org, vgoyal@redhat.com

On Mon, Feb 25, 2019 at 07:12:16PM +0800, Dave Young wrote:
> If we move to high as default, it will allocate 160M high + 256M low. It

We won't move to high by default - we will *fall* back to high if the
default allocation fails.

> To make the process less fragile maybe we can remove the 896M limitation
> and only try <4G then go to high.

Sure, the more robust for the user, the better.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
