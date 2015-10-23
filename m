Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Fri, 23 Oct 2015 12:59:50 +0530
From: Pratyush Anand <panand@redhat.com>
Subject: Re: [PATCH 08/16] arm64/kexec: Add core kexec support
Message-ID: <20151023072950.GC25029@dhcppc13.redhat.com>
References: <cover.1445297709.git.geoff@infradead.org>
 <a1c2a702f127d9dade1f9af8ab13decb2ef1c0da.1445297709.git.geoff@infradead.org>
 <20151020085620.GC31893@dhcppc13.redhat.com>
 <1445361565.30908.68.camel@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1445361565.30908.68.camel@infradead.org>
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
Cc: Mark Rutland <mark.rutland@arm.com>, AKASHI@infradead.org, marc.zyngier@arm.com, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Takahiro <takahiro.akashi@linaro.org>, linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org, christoffer.dall@linaro.org

On 20/10/2015:10:19:25 AM, Geoff Levand wrote:
> Hi,
> 
> On Tue, 2015-10-20 at 14:26 +0530, Pratyush Anand wrote:
> > On 19/10/2015:11:38:53 PM, Geoff Levand wrote:
> > > +static void soft_restart(unsigned long addr)
> > > +{
> > > +> > 	> > setup_mm_for_reboot();
> > > +> > 	> > cpu_soft_restart(virt_to_phys(cpu_reset), addr,
> > > +> > 	> > 	> > is_hyp_mode_available());
> > 
> > So now we do not flush cache for any memory region. Shouldn't we still flush
> > at least kernel and purgatory segments. 
> 
> Relevant pages of the kexec list are flushed in the code following the comment
> 'Invalidate dest page to PoC' of the arm64_relocate_new_kernel routine:
> 
>  The dcache is turned off
>  The page is invalidated to PoC
>  The new page is written

Thanks for clarifying it.

I tested your kexec-v10.2 with mustang.

Tested-by: Pratyush Anand <panand@redhat.com>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
