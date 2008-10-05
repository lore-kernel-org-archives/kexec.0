Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KmIBL-0002e2-2n
	for kexec@lists.infradead.org; Sun, 05 Oct 2008 01:13:11 +0000
Date: Sun, 5 Oct 2008 12:13:00 +1100
From: Simon Horman <horms@verge.net.au>
Subject: Re: SetVirtualAddressMap() on Tiano EFI firmware
Message-ID: <20081005011258.GD21956@verge.net.au>
References: <200809111423.58814.bjorn.helgaas@hp.com>
	<200810021216.03922.bjorn.helgaas@hp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200810021216.03922.bjorn.helgaas@hp.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: kexec@lists.infradead.org

On Thu, Oct 02, 2008 at 12:16:03PM -0600, Bjorn Helgaas wrote:
> On Thursday 11 September 2008 02:23:58 pm Bjorn Helgaas wrote:
> > ...
> > The following patch makes kexec-tools work on either old or new
> > firmware.  Masking out the top nibble of either a physical address
> > or a virtual address in region 7 results in a physical address.
> > 
> > diff --git a/purgatory/arch/ia64/purgatory-ia64.c b/purgatory/arch/ia64/purgatory-ia64.c
> > index b2fe6d4..acacb56 100644
> > --- a/purgatory/arch/ia64/purgatory-ia64.c
> > +++ b/purgatory/arch/ia64/purgatory-ia64.c
> > @@ -147,7 +147,7 @@ setup_arch(void)
> >  
> >  inline unsigned long PA(unsigned long addr)
> >  {
> > -	return addr - PAGE_OFFSET;
> > +	return addr & 0x0fffffffffffffffLL;
> >  }
> >  
> >  void
> > 
> 
> I haven't seen any activity on this.
> 
> Simon, if nobody objects to it, would you consider the patch above
> for kexec-tools?

Hi Bjorn,

That looks good to me. Could you provided a Signed-off-by line?

-- 
Simon Horman
  VA Linux Systems Japan K.K., Sydney, Australia Satellite Office
  H: www.vergenet.net/~horms/             W: www.valinux.co.jp/en


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
