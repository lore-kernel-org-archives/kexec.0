Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <1448909475.31214.27.camel@infradead.org>
Subject: Re: [PATCH v12 08/16] arm64/kexec: Add core kexec support
From: Geoff Levand <geoff@infradead.org>
Date: Mon, 30 Nov 2015 10:51:15 -0800
In-Reply-To: <20151127131306.GE23908@dhcppc13.redhat.com>
References: <cover.1448403503.git.geoff@infradead.org>
 <6ac232ad37d6b02cf2d5848b15236f26f5ac61ac.1448403503.git.geoff@infradead.org>
 <20151127131306.GE23908@dhcppc13.redhat.com>
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
To: Pratyush Anand <panand@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>, marc.zyngier@arm.com, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, linux-arm-kernel@lists.infradead.org, Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, christoffer.dall@linaro.org

Hi,

On Fri, 2015-11-27 at 18:43 +0530, Pratyush Anand wrote:

> On 24/11/2015:10:25:34 PM, Geoff Levand wrote:
> > +> > 	> > /* Test the entry flags. */
> > +.Ltest_source:
> > +> > 	> > tbz> > 	> > x18, IND_SOURCE_BIT, .Ltest_indirection
> > +
> > +> > 	> > mov x20, x13> > 	> > 	> > 	> > 	> > /*  x20 = copy dest */
> > +> > 	> > mov x21, x12> > 	> > 	> > 	> > 	> > /*  x21 = copy src */
> 
> Till v10 we had here invalidation for relocated destination page to PoC. I could
> not understand, why it was removed. Removing that piece of code breaks kexec
> booting with mustang. I need [1] to kexec boot into second kernel with mustang
> platform.

We need to flush the new kernel to PoC.  The code that was here that
was doing that would only be executed when the new kernel needed
relocation (the standard kexec case).  We also need to flush kernels
that do not need relocation (the standard kdump case).

I moved the new kernel flush to kexec_segment_flush(), called
unconditionally in machine_kexec() so we can handle both cases
with one piece of code.

Have you experienced a problem on mustang with the current version?

-Geoff


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
