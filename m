Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXMwT-009KUR-Ib
 for kexec@lists.infradead.org; Fri, 16 Apr 2021 11:47:22 +0000
Date: Fri, 16 Apr 2021 19:47:08 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: x86/crash: fix crash_setup_memmap_entries() out-of-bounds access
Message-ID: <20210416114708.GB79779@dhcp-128-65.nay.redhat.com>
References: <9efaad2ba042b8791cbe8c3e7cad491fe05e06eb.camel@gmx.de>
 <20210416110701.GA3835@dhcp-128-65.nay.redhat.com>
 <063a63ddea914ac654cbe9a1d1d6c76986af7882.camel@gmx.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <063a63ddea914ac654cbe9a1d1d6c76986af7882.camel@gmx.de>
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
To: Mike Galbraith <efault@gmx.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>

On 04/16/21 at 01:28pm, Mike Galbraith wrote:
> On Fri, 2021-04-16 at 19:07 +0800, Dave Young wrote:
> >
> > > We're excluding two ranges, allocate the scratch space we need to do that.
> >
> > I think 1 range should be fine, have you tested 1?
> 
> Have now, and vzalloc(struct_size(cmem, ranges, 1)) worked just fine.

Ok, thanks for your quick response.  Care to resend and cc x86 list and
Andrew?

Andrew usually takes core kexec/kdump fixes, x86 usually go through x86
maintainer.

Thanks
Dave


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
