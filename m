Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-io0-x233.google.com ([2607:f8b0:4001:c06::233])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1eYlyZ-0001mz-CF
 for kexec@lists.infradead.org; Tue, 09 Jan 2018 04:57:29 +0000
Received: by mail-io0-x233.google.com with SMTP id f6so17110815ioh.8
 for <kexec@lists.infradead.org>; Mon, 08 Jan 2018 20:57:16 -0800 (PST)
Date: Tue, 9 Jan 2018 14:02:18 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: arm64 crashkernel fails to boot on acpi-only machines due to
 ACPI regions being no longer mapped as NOMAP
Message-ID: <20180109050216.GB18820@linaro.org>
References: <20171221103440.GJ28046@linaro.org>
 <CACi5LpMUnUKxiALAHW9_PE2RYC8GNWLPGpdJ5ca53g=v3rNkfg@mail.gmail.com>
 <20171222083308.cy3vwlyhig22q5ee@fireball>
 <CACi5LpNF5i3Eo7nMLr_z9r4VVbXhDwSJCQoiOh-A_jB6hV0_2Q@mail.gmail.com>
 <20171225032500.GA8877@linaro.org>
 <CACi5LpMzYidDaC0_yfwgVOisH-FqcNViYj+Z54uKfUtHkJKKXA@mail.gmail.com>
 <20171226013217.GA2119@dhcp-128-65.nay.redhat.com>
 <20171226013517.GA2186@dhcp-128-65.nay.redhat.com>
 <20171226022807.GB8877@linaro.org>
 <20171226065636.GA5354@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20171226065636.GA5354@dhcp-128-65.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>, "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Matt Fleming <matt@codeblueprint.co.uk>, Bhupesh Sharma <bhsharma@redhat.com>, kexec@lists.infradead.org, James Morse <james.morse@arm.com>, Bhupesh SHARMA <bhupesh.linux@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, Dec 26, 2017 at 02:56:36PM +0800, Dave Young wrote:
> On 12/26/17 at 11:28am, AKASHI Takahiro wrote:
> > On Tue, Dec 26, 2017 at 09:35:17AM +0800, Dave Young wrote:
> > > [snip]
> > > > > > Well, we may be able to change pr_warn() to pr_warn_once() here, but
> > > > > > I hope that adding "numa=off" to kernel command line should also work.
> > > > > 
> > > > > Hmm, adding "numa=off" to crashkernel bootargs works, and TBH it was
> > > > > my initial thought process as well, but I am not sure if this will
> > > > > cause any regressions on aarch64 systems which use crashdump feature.
> > > > 
> > > > It should be fine since we use numa=off by default for all other arches
> > > > ie. x86, ppc64 and s390. Actually disabling numa in kdump kernel can save
> > > > mm component memory usage. 
> > > > 
> > > 
> > > Forgot to say I means in RHEL and Fedora we use numa=off for kdump..
> > 
> > Thank you for the clarification.
> > (It might be better to make numa off automatically if maxcpus == 0 (and 1?).)
> 
> Hmm, I did a quick test with qemu/kvm, kdump kernel boot without numa=off
> I'm not sure why I do not see the warning messages on x86
> machines, maybe something arm64 specific?

I didn't see the messages(i.e. "potential offnode page_structs")
on arm64 qemu (with -smp 2 -numa node -numa node).

It seems that qemu doesn't generate acpi slit(inter-node distance table).

Thanks,
-Takahiro AKASHI

> > 
> > -Takahiro AKASHI

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
