Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <1466441411.7965.17.camel@infradead.org>
Subject: Re: [PATCH v19 05/13] arm64/kexec: Add pr_debug output
From: Geoff Levand <geoff@infradead.org>
Date: Mon, 20 Jun 2016 09:50:11 -0700
In-Reply-To: <5768147E.1050900@arm.com>
References: <cover.1466120418.git.geoff@infradead.org>
 <dd245cadf97ea0d8fd5b0fe5743ecf9fa512d3c0.1466120418.git.geoff@infradead.org>
 <5768147E.1050900@arm.com>
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
To: James Morse <james.morse@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, marc.zyngier@arm.com, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

On Mon, 2016-06-20 at 17:06 +0100, James Morse wrote:
> --- a/arch/arm64/kernel/machine_kexec.c
> > +++ b/arch/arm64/kernel/machine_kexec.c
> > @@ -11,6 +11,7 @@
> >  
> >  #include 
> >  #include 
> > +#include 
> 
> Now that the get_user(maybe_dtb_addr,.. has gone, I don't think we need this header.

No, we don't.  I have already fixed that in my master branch.

> >  
> >  #include 
> >  #include 
> 
> 
> Reviewed-by: James Morse <james.morse@arm.com>

Thanks again.

-Geoff


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
