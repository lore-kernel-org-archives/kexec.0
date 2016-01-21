Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Thu, 21 Jan 2016 10:57:53 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH 18/19] arm64: kdump: update a kernel doc
Message-ID: <20160121025753.GB7950@dhcp-128-65.nay.redhat.com>
References: <20160119014332.GB2919@dhcp-128-65.nay.redhat.com>
 <569DCB30.9010501@linaro.org>
 <20160119122848.GA2904@dhcp-128-65.nay.redhat.com>
 <20160119125114.GH25024@leverpostej>
 <20160119134553.GA2986@dhcp-128-65.nay.redhat.com>
 <20160119140139.GC26545@leverpostej>
 <20160120024946.GA2999@dhcp-128-65.nay.redhat.com>
 <569F2439.9000604@linaro.org>
 <20160120063856.GA3725@dhcp-128-65.nay.redhat.com>
 <20160120115436.GC25829@leverpostej>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20160120115436.GC25829@leverpostej>
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
Cc: ard.biesheuvel@linaro.org, Geoff Levand <geoff@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, James Morse <james.morse@arm.com>, christoffer.dall@linaro.org, marc.zyngier@arm.com, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

Hi, Mark

On 01/20/16 at 11:54am, Mark Rutland wrote:
> On Wed, Jan 20, 2016 at 02:38:56PM +0800, Dave Young wrote:
> > Maybe I did not say it clearly, I prefer kexec syscall/tool to modifiy dtb
> > or uefi-memmap so that we do not need any extra kernel cmdline.
> 
> I am strongly opposed to modifying the FW-provided memroy map
> information, for the reasons I expressed in other replies.
> 
> What are your concerns with a property under /chosen?
> 
> > For x86 we would like to drop the memmap= usage in kexec-tools but we can not
> > do that for a compatibility problem about calgary iommu. So that currently
> > kexec-tools supports both recreating E820 maps and passing memmap=.
> > 
> > We should think it carefully because it will be hard to remove once we support it.
> 
> I agree that we don't want a plethora of solutions that we have to
> support forever.
> 
> > IMO handling it in code is better than using an external interface.
> 
> I'm not sure what you mean by this. What is the "external interface",
> and which code do you beleive it is better to handle this in?

I think we have covered all these in another reply. Let's continue
the discussion if needed in that thread.

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
