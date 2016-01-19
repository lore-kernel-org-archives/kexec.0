Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Tue, 19 Jan 2016 11:59:50 +0000
From: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH 04/19] arm64: Cleanup SCTLR flags
Message-ID: <20160119115946.GC4436@e103592.cambridge.arm.com>
References: <cover.1452884156.git.geoff@infradead.org>
 <701b44f00cdb8dbc7881c12508f55e993b9ce6dd.1452884156.git.geoff@infradead.org>
 <20160115200727.GQ3262@leverpostej> <569CBA82.9050102@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <569CBA82.9050102@arm.com>
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
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Geoff Levand <geoff@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, James Morse <james.morse@arm.com>, linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org, christoffer.dall@linaro.org

On Mon, Jan 18, 2016 at 10:12:18AM +0000, Marc Zyngier wrote:
> On 15/01/16 20:07, Mark Rutland wrote:

[...]

> > Marc, Christoffer, I note that in SCTLR_EL2_FLAGS we don't set the RES1
> > bits of SCTLR_EL2 (not in head.S el2_setup). Should we perhaps be doing
> > so so as to avoid any future surprises?
> 
> Yes, that's one of the numerous instances of the same problem - I think
> Dave Martin also has some fixes in that area.
> 
> I'll definitely take patches!

Yep, we have a similar problem with CPTR_EL2, patch to follow at some
point.  There are likely other instances...

Cheers
---Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
