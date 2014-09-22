Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <1411422351.6001.28.camel@smoke>
Subject: Re: [PATCH 01/13] arm64: Add ESR_EL2_EC macros to hyp-stub
From: Geoff Levand <geoff@infradead.org>
Date: Mon, 22 Sep 2014 14:45:51 -0700
In-Reply-To: <20140915161014.GB13789@leverpostej>
References: <cover.1410302383.git.geoff@infradead.org>
 <5e1b1892eb3ecc3bccff47766675c24c650a1a14.1410302383.git.geoff@infradead.org>
 <20140915161014.GB13789@leverpostej>
Mime-Version: 1.0
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
To: Mark Rutland <mark.rutland@arm.com>
Cc: Marc Zyngier <Marc.Zyngier@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>


Hi Mark,

On Mon, 2014-09-15 at 17:10 +0100, Mark Rutland wrote:
> On Tue, Sep 09, 2014 at 11:49:04PM +0100, Geoff Levand wrote:
> > +#define ESR_EL2_EC_SHIFT	26
> > +#define ESR_EL2_EC_HVC64	0x16
> 
> These exist in arch/arm64/include/asm/kvm_arm.h, no?
> 
> If anything that should be folded into arch/arm64/include/asm/esr.h...

OK, I'll remove this patch and add the esr.h fixup into my generic
'arm64 enhancements' series.

-Geoff



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
