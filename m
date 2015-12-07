Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Mon, 7 Dec 2015 17:18:39 +0530
From: Pratyush Anand <panand@redhat.com>
Subject: Re: [PATCH] kexec: Add --lite option
Message-ID: <20151207114839.GF16406@dhcppc13.redhat.com>
References: <1445469125.30908.105.camel@infradead.org>
 <20151022031718.GB11227@dhcp-129-115.nay.redhat.com>
 <20151022125012.GB20847@redhat.com>
 <1445540891.30908.144.camel@infradead.org>
 <1446703011.12676.83.camel@freescale.com>
 <20151207114547.GE16406@dhcppc13.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20151207114547.GE16406@dhcppc13.redhat.com>
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
To: Scott Wood <scottwood@freescale.com>
Cc: Geoff Levand <geoff@infradead.org>, kexec@lists.infradead.org, Simon Horman <horms@verge.net.au>, linux-arm-kernel@lists.infradead.org, Petitboot@lists.ozlabs.org, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>

Sorry, forgot to add linux-arm-kernel@lists.infradead.org. Now CCed.

On 07/12/2015:05:15:47 PM, Pratyush Anand wrote:
> +linux-arm-kernel@lists.infradead.org (May be someone from arm kernel list can
> give some more input)
> 
> On 04/11/2015:11:56:51 PM, Scott Wood wrote:
> > On Thu, 2015-10-22 at 12:08 -0700, Geoff Levand wrote:
> > > I notice the difference on the my arm64 system, so I guess we
> > > are even on that.
> > 
> > For me it was beyond "notice the difference" -- I thought it was completely 
> > broken, and was preparing to debug, until it started spitting out output over 
> > a minute later.
> > 
> > Compiling the sha256 code with -O2 instead of -O0 cut it down to around 10 
> > seconds (still unpleasant, but not quite as crazy... still unacceptable for 
> > non-kdump, though).
> 
> Yes, compiling purgatory code with -O2 helps to improve the timing, and I notice
> that enabling D-cache on top of -O2 does not improve it further. However, I am
> still not able to understand that why there is huge difference between following
> two.
> 
> 1) When we execute kexec() system call in first kernel, at that time it
> calculates sha256 on all the binaries [1]. It take almost un-noticeable time
> (less than a sec) there.
> 
> 2) When purgatory is executed then it re-calculates sha256 using same routines
> [2] on same binary data as that of case (1). But, now it takes 10-20 sec
> (depending of size of binaries)?
> 
> Why did not it take same time with O2 + D-cache enabled? I think, we should be
> able to achieve same time in second case as well. What is missing?
> 
> ~Pratyush
> 
> [1] http://git.kernel.org/cgit/utils/kernel/kexec/kexec-tools.git/tree/kexec/kexec.c#n650
> [2] http://git.kernel.org/cgit/utils/kernel/kexec/kexec-tools.git/tree/purgatory/purgatory.c#n20

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
