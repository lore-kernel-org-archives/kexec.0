Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mYNhz-00GPSD-80
 for kexec@lists.infradead.org; Thu, 07 Oct 2021 07:20:52 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id A500F61248
 for <kexec@lists.infradead.org>; Thu,  7 Oct 2021 07:20:50 +0000 (UTC)
Received: by mail-oi1-f177.google.com with SMTP id y201so7776909oie.3
 for <kexec@lists.infradead.org>; Thu, 07 Oct 2021 00:20:50 -0700 (PDT)
MIME-Version: 1.0
References: <YLss6ZNPMIXleLLF@dhcp-128-65.nay.redhat.com>
 <YL5HvUqtsDXx5CzM@smile.fi.intel.com>
 <YL5U/zSb50SnbLgW@smile.fi.intel.com>
 <YL9hxPdPj0dYMyaD@dhcp-128-65.nay.redhat.com>
 <CAHp75VcPuf6BLGf7Y3RO2M-gHMFZMTeb4ftnj_tbGS4TxvThxA@mail.gmail.com>
 <YMCsSqzmG4jb1Ojo@dhcp-128-65.nay.redhat.com>
 <YMQ62d1EFFjRcv6w@dhcp-128-65.nay.redhat.com>
 <YMd39tIPercgljll@smile.fi.intel.com> <YMeM1Xee9Yg3j21D@smile.fi.intel.com>
 <YMeRiDMet2JyOV4P@smile.fi.intel.com> <YV3Oonc5s3UpzRq0@smile.fi.intel.com>
In-Reply-To: <YV3Oonc5s3UpzRq0@smile.fi.intel.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 7 Oct 2021 09:20:38 +0200
Message-ID: <CAMj1kXHjXcFePeRWDtxZnC6eHEeELA6kZXOU=sA9oDZ1HzW_Vg@mail.gmail.com>
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
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Dave Young <dyoung@redhat.com>, Jean Delvare <jdelvare@suse.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, =?UTF-8?Q?Javier_Ti=C3=A1?= <javier.tia@gmail.com>, kexec@lists.infradead.org, Eric Biederman <ebiederm@xmission.com>, linux-efi <linux-efi@vger.kernel.org>, Matt Fleming <matt@codeblueprint.co.uk>

On Wed, 6 Oct 2021 at 18:28, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>
> On Mon, Jun 14, 2021 at 08:27:36PM +0300, Andy Shevchenko wrote:
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
> Any news here?
>
> Shall I resend my series?
>

As I said before:

"""
I would still prefer to get to the bottom of this before papering over
it with command line options. If the memory gets corrupted by the
first kernel, maybe we are not preserving it correctly in the first
kernel.
"""

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
