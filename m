Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from ch1ehsobe003.messaging.microsoft.com ([216.32.181.183]
 helo=ch1outboundpool.messaging.microsoft.com)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1V4ZdG-0004jP-NT
 for kexec@lists.infradead.org; Wed, 31 Jul 2013 16:52:15 +0000
Date: Wed, 31 Jul 2013 11:50:50 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: visible memory seems wrong in kexec crash dump kernel
In-Reply-To: <CFBB0F4944BCD94BAC0398D7DB81D705EAF91D@CAMPUSMB5.usask.ca>
 (from cbf123@mail.usask.ca on Wed Jul 31 11:40:05 2013)
Message-ID: <1375289450.30721.93@snotra>
MIME-Version: 1.0
Content-Disposition: inline
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="Flowed"; DelSp="Yes"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: "Friesen, Christopher" <cbf123@mail.usask.ca>
Cc: Michael Ellerman <michael@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Vivek Goyal <vgoyal@redhat.com>

On 07/31/2013 11:40:05 AM, Friesen, Christopher wrote:
> 
> From: Scott Wood [scottwood@freescale.com]
> Sent: Monday, July 29, 2013 5:10 PM
> To: Friesen, Christopher
> Cc: Michael Ellerman; kexec@lists.infradead.org; Paul Mackerras;  
> linuxppc-dev@lists.ozlabs.org; Vivek Goyal
> Subject: Re: visible memory seems wrong in kexec crash dump kernel
> 
> On 07/13/2013 01:30:50 AM, Chris Friesen wrote:
> > The upshot is that there seems to be a number of things that could  
> be
> > improved:
> >
> > 1) kexec should accept "/memory" and not just "/memory@"
> > 2) lmb_reserve() should really respect the crashkernel memory limit
> > 3) the freescale stuff really shouldn't assume it can map things
> > wherever it feels like
> 
> What "board-specific freescale code" are you referring to?
> 
> -Scott
> 
> 
> Sorry for the crappy quoting, I'm using a web outlook portal.
> 
> I've switched employers so I don't have access to the exact details  
> any more.  The system in question was a Kontron AM4150 which uses the  
> P5020.  As I recall, one of the Freescale drivers (I think it was the  
> buffer or queue manager that the network driver makes use of) was  
> attempting to call lmb_reserve() with a base address in the 4GB range  
> even though the recovery kernel was limited to 224MB of memory.

That's not "board specific" code, and it's not even mainline Linux  
code.  Unfortunately none of the datapath stuff is upstream, still.

> While I've got your attention, the other thing that I found was that  
> the "dpa" network driver didn't properly work in a kexec'd kernel  
> even when given lots of memory.  It would work for a little bit and  
> then hang.

I'm not particularly surprised by this.  It doesn't help that there's  
no way to do a device reset. :-(

Issues with Freescale SDK code should be reported on  
https://community.freescale.com/, to support@freescale.com, or to your  
FAE.

-Scott

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
