Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Mon, 25 Jan 2016 11:19:17 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH 18/19] arm64: kdump: update a kernel doc
Message-ID: <20160125031917.GA5616@dhcp-128-65.nay.redhat.com>
References: <20160119122848.GA2904@dhcp-128-65.nay.redhat.com>
 <20160119125114.GH25024@leverpostej>
 <20160119134553.GA2986@dhcp-128-65.nay.redhat.com>
 <20160119140139.GC26545@leverpostej>
 <20160120024946.GA2999@dhcp-128-65.nay.redhat.com>
 <569F2439.9000604@linaro.org> <20160120114929.GB25829@leverpostej>
 <56A08076.8060302@linaro.org> <20160121120210.GD2581@leverpostej>
 <56A1CAD2.70403@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <56A1CAD2.70403@linaro.org>
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

Hi, AKASHI

> >To place "elfcorehdr=" or "memmap="/"usable-memory=" into the command
> >line, one needs to know where it is valid to place it. Appending doesn't
> >always work, as per the example above with 51e158c12aca3c9a.
> 
> So, are you now suggesting that we put both "elfcorehdr=" and
> "usable-memory=" under /chosen in dtb? That's fair enough.
> (as far as nobody cares about incompatibility with other archs.)

You may need move is_kdump_kernel as a weak function so that in arm64 you
can still use it in kdump kernel.

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
