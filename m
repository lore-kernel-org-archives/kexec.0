Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Wed, 20 Jan 2016 15:00:44 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH 18/19] arm64: kdump: update a kernel doc
Message-ID: <20160120070044.GF2999@dhcp-128-65.nay.redhat.com>
References: <569CBDBC.5050500@linaro.org>
 <20160119014332.GB2919@dhcp-128-65.nay.redhat.com>
 <569DCB30.9010501@linaro.org>
 <20160119122848.GA2904@dhcp-128-65.nay.redhat.com>
 <20160119125114.GH25024@leverpostej>
 <20160119134553.GA2986@dhcp-128-65.nay.redhat.com>
 <20160119140139.GC26545@leverpostej>
 <20160120024946.GA2999@dhcp-128-65.nay.redhat.com>
 <569F2439.9000604@linaro.org>
 <20160120063856.GA3725@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20160120063856.GA3725@dhcp-128-65.nay.redhat.com>
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
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, ard.biesheuvel@linaro.org, Geoff Levand <geoff@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, marc.zyngier@arm.com, James Morse <james.morse@arm.com>, christoffer.dall@linaro.org, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

> > So I'm not still sure about what are advantages of a property under /chosen
> > over "memmap=" kernel parameter.
> > Both are simple and can have the same effect with minimizing changes to dtb.
> > (But if, in the latter case, we have to provide *all* the memory-related information
> > through "memmap=" parameters, it would be much complicated.)
> 
> Maybe I did not say it clearly, I prefer kexec syscall/tool to modifiy dtb
> or uefi-memmap so that we do not need any extra kernel cmdline.
> 
> For x86 we would like to drop the memmap= usage in kexec-tools but we can not
> do that for a compatibility problem about calgary iommu. So that currently
> kexec-tools supports both recreating E820 maps and passing memmap=.
> 
> We should think it carefully because it will be hard to remove once we support it.
> IMO handling it in code is better than using an external interface.
> 

Also seems semantic of memmap=exactmap is different than current use in the implementation
exactmap means we need pass each range seperately including reserved, acpi and other types
We can not reuse ranges in uefi memmap for other than usable memory.

It will also have the cmdline array size issue.

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
