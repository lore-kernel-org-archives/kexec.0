Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <1425422151.9265.13.camel@infradead.org>
Subject: Re: [PATCH v2 2/8] arm64: Convert hcalls to use ISS field
From: Geoff Levand <geoff@infradead.org>
Date: Tue, 03 Mar 2015 14:35:51 -0800
In-Reply-To: <54F62BF4.1070306@codeaurora.org>
References: <cover.1421449714.git.geoff@infradead.org>
 <6719b2520095926ae0e8ac888663b87f2098f565.1421449714.git.geoff@infradead.org>
 <1422660828.21823.40.camel@infradead.org> <20150219205714.GC24460@cbox>
 <1424902170.17282.9.camel@infradead.org> <20150302221355.GA12902@lvm>
 <1425338536.9265.2.camel@infradead.org> <54F62BF4.1070306@codeaurora.org>
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
To: Christopher Covington <cov@codeaurora.org>
Cc: marc.zyngier@arm.com, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org, Grant Likely <grant.likely@linaro.org>, kexec@lists.infradead.org, Christoffer Dall <christoffer.dall@linaro.org>

Hi Christopher,

On Tue, 2015-03-03 at 16:47 -0500, Christopher Covington wrote:
> On 03/02/2015 06:22 PM, Geoff Levand wrote:
> > Yes, in general it will make marshaling of args, etc. easier.  Also,
> > to me, if we are going to change the implementation it seems to be
> > the most natural way.
> 
> From reading the architecture documentation, I too expected the hypervisor
> call instruction's immediate and the instruction specific syndrome to be used.
> However I vaguely recall someone pointing out that reading the exception
> syndrome register and extracting the instruction specific syndrome is bound to
> take longer than simply using a general purpose register.
> 
> One might also consider alignment with the SMC Calling Convention document
> [1], which while originally written for SMC, is also used for HVC by PSCI [2].
> 
> 1. http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.den0028a/index.html
> 2. http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.den0022c/index.html

On looking at the SMC document, I found this:
 
  The SMC instruction encodes an immediate value as defined by the ARM
  architecture [1][2]. The size of this and mechanism to access the
  immediate value differ between the ARM instruction sets. Additionally,
  it is time consuming for 32-bit Secure Monitor code to access this
  immediate value. Consequently:

   o An SMC immediate value of Zero must be used.
   o All other SMC immediate values are reserved. 

The first problem of differing access methods does not exist for our
case, the kernel will always use the same method.

As for the second problem, the current implementation already reads
esr_el2.  The new code just adds an AND instruction to mask the ISS
field.  I don't think this would be more overhead than shifting
registers.

One alternative would be to use a high register, say x7, and limit the
hcalls to args x0-x6, but I don't think this gains much over using the
immediate.

-Geoff


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
