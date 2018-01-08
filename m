Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-io0-f178.google.com ([209.85.223.178])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1eYdam-0002ho-6T
 for kexec@lists.infradead.org; Mon, 08 Jan 2018 20:00:28 +0000
Received: by mail-io0-f178.google.com with SMTP id 87so15925501ior.5
 for <kexec@lists.infradead.org>; Mon, 08 Jan 2018 12:00:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CACi5LpNRtXh-j9Y9HwRatDZwRMr++-ZeaSnk62vD3btpxsVv7w@mail.gmail.com>
References: <CAKv+Gu-gmbWdZ7rxp5qGrtSBQ7dM=3FqF-Pw=J0LaL=oKTMg4w@mail.gmail.com>
 <CACi5LpOscbcBecWaC3Q9P22kheRYc+M2Ynfusszk14fPY-cJ5A@mail.gmail.com>
 <20171221103440.GJ28046@linaro.org>
 <CACi5LpMUnUKxiALAHW9_PE2RYC8GNWLPGpdJ5ca53g=v3rNkfg@mail.gmail.com>
 <20171222083308.cy3vwlyhig22q5ee@fireball>
 <CACi5LpNF5i3Eo7nMLr_z9r4VVbXhDwSJCQoiOh-A_jB6hV0_2Q@mail.gmail.com>
 <20171225032500.GA8877@linaro.org>
 <CACi5LpMzYidDaC0_yfwgVOisH-FqcNViYj+Z54uKfUtHkJKKXA@mail.gmail.com>
 <20171226013217.GA2119@dhcp-128-65.nay.redhat.com>
 <20171226013517.GA2186@dhcp-128-65.nay.redhat.com>
 <20171226022807.GB8877@linaro.org>
 <CACi5LpNRtXh-j9Y9HwRatDZwRMr++-ZeaSnk62vD3btpxsVv7w@mail.gmail.com>
From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Tue, 9 Jan 2018 01:30:07 +0530
Message-ID: <CACi5LpNeSNHoUcM9xOq0bjN_okaEUDbaz1qyuqAct7BSNLQqKQ@mail.gmail.com>
Subject: Re: arm64 crashkernel fails to boot on acpi-only machines due to ACPI
 regions being no longer mapped as NOMAP
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
To: AKASHI Takahiro <takahiro.akashi@linaro.org>, Dave Young <dyoung@redhat.com>, Bhupesh Sharma <bhsharma@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Bhupesh SHARMA <bhupesh.linux@gmail.com>, Matt Fleming <matt@codeblueprint.co.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, James Morse <james.morse@arm.com>, kexec@lists.infradead.org

Hello Akashi,

On Tue, Dec 26, 2017 at 8:26 AM, Bhupesh Sharma <bhsharma@redhat.com> wrote:
> On Tue, Dec 26, 2017 at 7:58 AM, AKASHI Takahiro
> <takahiro.akashi@linaro.org> wrote:
>> On Tue, Dec 26, 2017 at 09:35:17AM +0800, Dave Young wrote:
>>> [snip]
>>> > > > Well, we may be able to change pr_warn() to pr_warn_once() here, but
>>> > > > I hope that adding "numa=off" to kernel command line should also work.
>>> > >
>>> > > Hmm, adding "numa=off" to crashkernel bootargs works, and TBH it was
>>> > > my initial thought process as well, but I am not sure if this will
>>> > > cause any regressions on aarch64 systems which use crashdump feature.
>>> >
>>> > It should be fine since we use numa=off by default for all other arches
>>> > ie. x86, ppc64 and s390. Actually disabling numa in kdump kernel can save
>>> > mm component memory usage.
>>> >
>>>
>>> Forgot to say I means in RHEL and Fedora we use numa=off for kdump..
>>
>> Thank you for the clarification.
>> (It might be better to make numa off automatically if maxcpus == 0 (and 1?).)
>>
>
> Not sure if we can leave this to the distribution-specific kdump
> scripts (as the crashkernel boot can be held up for sufficient time
> and may appear stuck). The distribution scripts may be different (for
> e.g. ubuntu and RHEL/fedora) across distributions and may have
> different bootarg options.
>
> So how about considering a kernel fix only which doesn't require
> relying on changing the distribution-specific kdump scripts, as we
> should avoid introducing a regression while trying to fix a regression
> :)
>
> Just my 2 cents.
>

Sorry for the delay but I was on holidays in the last week.

Are you planning to send a patch to fix this issue or do you want me
to send a RFC version instead?

i think this is a blocking issue for aarch64 kdump support on newer
kernels (v4.14) and we are already hearing about this issue from other
users as well, so it would be great to get this fixed now that we have
root-caused the issue and found a possible way around.

Regards,
Bhupesh

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
