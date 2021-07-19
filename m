Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m5ObD-008qqv-K4
 for kexec@lists.infradead.org; Mon, 19 Jul 2021 08:26:05 +0000
Received: by mail-pl1-x635.google.com with SMTP id o8so9185096plg.11
 for <kexec@lists.infradead.org>; Mon, 19 Jul 2021 01:26:02 -0700 (PDT)
MIME-Version: 1.0
References: <YLdG91qspr19heDS@smile.fi.intel.com>
 <YLss6ZNPMIXleLLF@dhcp-128-65.nay.redhat.com>
 <YL5HvUqtsDXx5CzM@smile.fi.intel.com> <YL5U/zSb50SnbLgW@smile.fi.intel.com>
 <YL9hxPdPj0dYMyaD@dhcp-128-65.nay.redhat.com>
 <CAHp75VcPuf6BLGf7Y3RO2M-gHMFZMTeb4ftnj_tbGS4TxvThxA@mail.gmail.com>
 <YMCsSqzmG4jb1Ojo@dhcp-128-65.nay.redhat.com>
 <YMQ62d1EFFjRcv6w@dhcp-128-65.nay.redhat.com>
 <YMd39tIPercgljll@smile.fi.intel.com> <YMeM1Xee9Yg3j21D@smile.fi.intel.com>
 <YMeRiDMet2JyOV4P@smile.fi.intel.com>
 <CAMj1kXGnVX7JHM6BGRM6t=NSfDfpYnMp7tyTtWzxP+jha7dexQ@mail.gmail.com>
In-Reply-To: <CAMj1kXGnVX7JHM6BGRM6t=NSfDfpYnMp7tyTtWzxP+jha7dexQ@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 19 Jul 2021 11:25:21 +0300
Message-ID: <CAHp75VdaMCoqe62QT1heoeUbqKG0e5H41YcpcqDH97g5gKYJyg@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] firmware: dmi_scan: Make it work in kexec'ed kernel
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
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Dave Young <dyoung@redhat.com>, Jean Delvare <jdelvare@suse.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, =?UTF-8?Q?Javier_Ti=C3=A1?= <javier.tia@gmail.com>, kexec@lists.infradead.org, Eric Biederman <ebiederm@xmission.com>, linux-efi <linux-efi@vger.kernel.org>, Matt Fleming <matt@codeblueprint.co.uk>

On Mon, Jul 19, 2021 at 10:53 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> On Mon, 14 Jun 2021 at 19:27, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > On Mon, Jun 14, 2021 at 08:07:33PM +0300, Andy Shevchenko wrote:
> > > On Mon, Jun 14, 2021 at 06:38:30PM +0300, Andy Shevchenko wrote:
> > > > On Sat, Jun 12, 2021 at 12:40:57PM +0800, Dave Young wrote:
> > > > > > Probably it is doable to have kexec on 32bit efi working
> > > > > > without runtime service support, that means no need the trick of fixed
> > > > > > mapping.
> > > > > >
> > > > > > If I can restore my vm to boot 32bit efi on this weekend then I may provide some draft
> > > > > > patches for test.
> > > > >
> > > > > Unfortunately I failed to setup a 32bit efi guest,  here are some
> > > > > untested draft patches, please have a try.
> > > >
> > > > Thanks for the patches.
> > > >
> > > > As previously, I have reverted my hacks and applied your patches (also I
> > > > dropped patches from previous mail against kernel and kexec-tools) for both
> > > > kernel and user space on first and second environments.
> > > >
> > > > It does NOT solve the issue.
> > > >
> > > > If there is no idea pops up soon, I'm going to resend my series that
> > > > workarounds the issue.
> > >
> > > Hold on, I may have made a mistake during testing. Let me retest this.
> >
> > Double checked, confirmed that it's NOT working.
>
> Apologies for chiming in so late - in my defence, I was on vacation :-)
>
> So if I understand the thread correctly, the Surface 3 provides a
> SMBIOS entry point (not SMBIOS3), and it does not get picked up by the
> second kernel, right?
>
> I would still prefer to get to the bottom of this before papering over
> it with command line options. If the memory gets corrupted by the
> first kernel, maybe we are not preserving it correctly in the first
> kernel.

There are _at least_ two platforms which are affected by this:
 - Intel Galileo
 - Microsoft Surface 3

For the time being I'm testing this on the former one. If we get
something working there, I will perform similar tests on the latter
one. And who knows how many more platforms are affected, because kexec
is usually not what many people are using every day, however we (my
teammates and I) use such a setup _a lot_.on a number of platforms It
appears that only those two were found in our zoo to behave badly.

-- 
With Best Regards,
Andy Shevchenko

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
