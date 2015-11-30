Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Mon, 30 Nov 2015 10:58:43 +0530
From: Pratyush Anand <panand@redhat.com>
Subject: Re: [PATCH v12 05/16] arm64: Add back cpu_reset routines
Message-ID: <20151130052843.GG23908@dhcppc13.redhat.com>
References: <cover.1448403503.git.geoff@infradead.org>
 <3279584774ba40f088b79f4df864d69a5b57b516.1448403503.git.geoff@infradead.org>
 <56586679.8060403@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <56586679.8060403@arm.com>
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
Cc: Mark Rutland <mark.rutland@arm.com>, Geoff Levand <geoff@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, christoffer.dall@linaro.org, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

On 27/11/2015:02:19:37 PM, Marc Zyngier wrote:
> On 24/11/15 22:25, Geoff Levand wrote:
> > +ENTRY(cpu_soft_restart)
> > +	mov	x18, x0				// cpu_reset
> > +	mov	x0, x1				// el2_switch
> > +	mov	x1, x2				// entry
> > +	mov	x2, x3				// arg0
> > +	mov	x3, x4				// arg1
> > +	ret	x18
> > +ENDPROC(cpu_soft_restart)
> 
> Grepping through the tree, I can only find a single use of
> cpu_soft_restart, with cpu_reset as its first parameter.
> 
> Why do we need this indirection? Having

It is needed because we need to execute cpu_reset() in physical address space.

> 
> void cpu_soft_restart(el2_switch, entry, arg0, arg1);
> 
> should be enough...

We can do with only cpu_soft_restart(), but then a function pointer to __pa() of
it need to be called. May  be current approach is more cleaner.

~Pratyush

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
