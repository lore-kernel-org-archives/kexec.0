Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZoMsU-0002XJ-P4
 for kexec@lists.infradead.org; Tue, 20 Oct 2015 02:42:20 +0000
Date: Tue, 20 Oct 2015 08:11:53 +0530
From: Pratyush Anand <panand@redhat.com>
Subject: Re: [PATCH V2 11/11] arm64: wait for transmit completion before next
 character transmission
Message-ID: <20151020024153.GA31893@dhcppc13.redhat.com>
References: <cover.1431582203.git.panand@redhat.com>
 <51d1170ea05f86a1ed7bf42f384c600e98447b7a.1431582203.git.panand@redhat.com>
 <1445293795.30908.50.camel@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1445293795.30908.50.camel@infradead.org>
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
To: Geoff Levand <geoff@infradead.org>
Cc: takahiro.akashi@linaro.org, kexec@lists.infradead.org

On 19/10/2015:03:29:55 PM, Geoff Levand wrote:
Hi Geoff,
> 
> I tested this on the foundation model and it hangs.

Thanks for testing it.

Which uart model has been used in foundation model?
Does it have LSR register at offset 0x14? Should we expect 0x60 in LSR for TX
buffer to be empty? May be I can do a V3 of this patch where we pass
--port="uart_base","LSR","TX_EMPTY" (like --port=0x1c020000,0x14,0x60).

~Pratyush

> 
> -Geoff
> 
> On Thu, 2015-05-14 at 11:25 +0530, Pratyush Anand wrote:
> > Previous transmission must be completed before next character to be
> > transmitted, otherwise TX buffer may saturate and we will not see all
> > the characters on screen.
> > 
> > Signed-off-by: Pratyush Anand <panand@redhat.com>
> > ---
> >  purgatory/arch/arm64/purgatory-arm64.c | 24 +++++++++++++++++++++++-
> >  1 file changed, 23 insertions(+), 1 deletion(-)
> > 
> > diff --git a/purgatory/arch/arm64/purgatory-arm64.c
> > b/purgatory/arch/arm64/purgatory-arm64.c
> > index 25960c30bd05..3a1c9243bfa2 100644
> > --- a/purgatory/arch/arm64/purgatory-arm64.c
> > +++ b/purgatory/arch/arm64/purgatory-arm64.c
> > @@ -11,15 +11,37 @@ extern uint32_t *arm64_sink;
> >  extern void (*arm64_kernel_entry)(uint64_t);
> >  extern uint64_t arm64_dtb_addr;
> >  
> > +static void wait_for_xmit_complete(void)
> > +{
> > +	volatile uint32_t status;
> > +	volatile uint32_t *status_reg;
> > +
> > +	/*
> > +	 * Since most of the UART with ARM platform has LSR register
> > at
> > +	 * offset 0x14 and should have value as 0x60 for TX empty,
> > so we
> > +	 * have hardcoded these values. Can modify in future if need
> > +	 * arises.
> > +	 */
> > +	status_reg = (volatile uint32_t *)((uint64_t)arm64_sink +
> > 0x14);
> > +	while (1) {
> > +		status = *status_reg;
> > +		if ((status & 0x60) == 0x60)
> > +			break;
> > +	}
> > +}
> > +
> >  void putchar(int ch)
> >  {
> >  	if (!arm64_sink)
> >  		return;
> >  
> > +	wait_for_xmit_complete();
> >  	*arm64_sink = ch;
> >  
> > -	if (ch == '\n')
> > +	if (ch == '\n') {
> > +		wait_for_xmit_complete();
> >  		*arm64_sink = '\r';
> > +	}
> >  }
> >  
> >  void setup_arch(void)

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
