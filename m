Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Tue, 26 Dec 2017 14:58:45 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: arm64 crashkernel fails to boot on acpi-only machines due to
 ACPI regions being no longer mapped as NOMAP
Message-ID: <20171226065845.GB5354@dhcp-128-65.nay.redhat.com>
References: <20171221103440.GJ28046@linaro.org>
 <CACi5LpMUnUKxiALAHW9_PE2RYC8GNWLPGpdJ5ca53g=v3rNkfg@mail.gmail.com>
 <20171222083308.cy3vwlyhig22q5ee@fireball>
 <CACi5LpNF5i3Eo7nMLr_z9r4VVbXhDwSJCQoiOh-A_jB6hV0_2Q@mail.gmail.com>
 <20171225032500.GA8877@linaro.org>
 <CACi5LpMzYidDaC0_yfwgVOisH-FqcNViYj+Z54uKfUtHkJKKXA@mail.gmail.com>
 <20171226013217.GA2119@dhcp-128-65.nay.redhat.com>
 <20171226013517.GA2186@dhcp-128-65.nay.redhat.com>
 <20171226022807.GB8877@linaro.org>
 <CACi5LpNRtXh-j9Y9HwRatDZwRMr++-ZeaSnk62vD3btpxsVv7w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CACi5LpNRtXh-j9Y9HwRatDZwRMr++-ZeaSnk62vD3btpxsVv7w@mail.gmail.com>
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
To: Bhupesh Sharma <bhsharma@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>, "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Matt Fleming <matt@codeblueprint.co.uk>, kexec@lists.infradead.org, AKASHI Takahiro <takahiro.akashi@linaro.org>, James Morse <james.morse@arm.com>, Bhupesh SHARMA <bhupesh.linux@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 12/26/17 at 08:26am, Bhupesh Sharma wrote:
> On Tue, Dec 26, 2017 at 7:58 AM, AKASHI Takahiro
> <takahiro.akashi@linaro.org> wrote:
> > On Tue, Dec 26, 2017 at 09:35:17AM +0800, Dave Young wrote:
> >> [snip]
> >> > > > Well, we may be able to change pr_warn() to pr_warn_once() here, but
> >> > > > I hope that adding "numa=off" to kernel command line should also work.
> >> > >
> >> > > Hmm, adding "numa=off" to crashkernel bootargs works, and TBH it was
> >> > > my initial thought process as well, but I am not sure if this will
> >> > > cause any regressions on aarch64 systems which use crashdump feature.
> >> >
> >> > It should be fine since we use numa=off by default for all other arches
> >> > ie. x86, ppc64 and s390. Actually disabling numa in kdump kernel can save
> >> > mm component memory usage.
> >> >
> >>
> >> Forgot to say I means in RHEL and Fedora we use numa=off for kdump..
> >
> > Thank you for the clarification.
> > (It might be better to make numa off automatically if maxcpus == 0 (and 1?).)
> >
> 
> Not sure if we can leave this to the distribution-specific kdump
> scripts (as the crashkernel boot can be held up for sufficient time
> and may appear stuck). The distribution scripts may be different (for
> e.g. ubuntu and RHEL/fedora) across distributions and may have
> different bootarg options.

Personally I think distribution should take care of this param as for
kdump.  But as AKASHI said it could be a issue for 1st kernel with
nr_cpus=1 booting.  Problem is why we do not see this issue on other
machines.

> 
> So how about considering a kernel fix only which doesn't require
> relying on changing the distribution-specific kdump scripts, as we
> should avoid introducing a regression while trying to fix a regression
> :)
> 
> Just my 2 cents.
> 
> Thanks,
> Bhupesh

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
