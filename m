Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1b6Hwg-0006Yl-0e
 for kexec@lists.infradead.org; Fri, 27 May 2016 13:37:00 +0000
Date: Fri, 27 May 2016 14:36:25 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH kexec-tools 18/32] arm: report if crash kernel is out of
 bounds
Message-ID: <20160527133624.GL19428@n2100.arm.linux.org.uk>
References: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
 <E1axXTQ-0004ih-NN@e0050434b2927.dyn.arm.linux.org.uk>
 <CAHB_Guo-N0Coxj=fHBBM=QULMo6QK3uKbzOh15R6FCihGERjMA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAHB_Guo-N0Coxj=fHBBM=QULMo6QK3uKbzOh15R6FCihGERjMA@mail.gmail.com>
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
To: Pratyush Anand <panand@redhat.com>
Cc: kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

On Fri, May 27, 2016 at 04:57:47PM +0530, Pratyush Anand wrote:
> On Tue, May 3, 2016 at 3:52 PM, Russell King <rmk@arm.linux.org.uk> wrote:
> > diff --git a/kexec/arch/arm/crashdump-arm.h b/kexec/arch/arm/crashdump-arm.h
> > index 2dbde04..7314960 100644
> > --- a/kexec/arch/arm/crashdump-arm.h
> > +++ b/kexec/arch/arm/crashdump-arm.h
> > @@ -9,6 +9,7 @@ extern "C" {
> >  #define DEFAULT_PAGE_OFFSET            (0xc0000000)
> >  #define KVBASE_MASK    (0x1ffffff)
> >  #define CRASH_MAX_MEMORY_RANGES        32
> > +#define ARM_MAX_VIRTUAL                UINT32_MAX
> 
> If I see a kernel code then a virtual address is always defined as
> unsigned long. So, shouldn't we use ULONG_MAX instead?

What is the definition of ULONG_MAX?  The maximum unsigned value that
can fit in an unsigned long quantity.

While unsigned long _may_ be 32-bit, it's a very round-about way to
say "the maximum virtual address is the maximum unsigned 32-bit value".
Hence why I'm using UINT32_MAX here - it's a tighter and accurate
macro for what we're wanting.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
