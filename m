Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WpR5f-0004jQ-DS
 for kexec@lists.infradead.org; Tue, 27 May 2014 23:47:31 +0000
Date: Wed, 28 May 2014 08:47:08 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 1/2 resend] kexec-tools: add noefi arch cmdline option
Message-ID: <20140527234708.GD7374@verge.net.au>
References: <20140526084856.GA19920@dhcp-16-198.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140526084856.GA19920@dhcp-16-198.nay.redhat.com>
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
Cc: kexec@lists.infradead.org, vgoyal@redhat.com

On Tue, May 27, 2014 at 01:52:08PM +0800, Dave Young wrote:
> For kernel boot with efi=old_map or some quirked machines like SGI UV
> they use old ioremap instead of 1:1 mapping. But kexec efi support
> depends on the 1:1 mapping thus we need to switch to use the old way
> 
> There's a kernel patch for exporting the efi flags so we can check the memory
> mapping method. But user may want to explictly disable efi boot for unknown
> reasons.
> 
> So here add a new arch option '--noefi' for this case.

Thanks, I have applied this and the following patch.

I will now go ahead and make an rc release.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
