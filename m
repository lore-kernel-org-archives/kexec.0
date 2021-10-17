Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mc6G9-00Ceiw-Av
 for kexec@lists.infradead.org; Sun, 17 Oct 2021 13:31:30 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id C7A0E61261
 for <kexec@lists.infradead.org>; Sun, 17 Oct 2021 13:31:28 +0000 (UTC)
Received: by mail-oi1-f175.google.com with SMTP id o204so20620468oih.13
 for <kexec@lists.infradead.org>; Sun, 17 Oct 2021 06:31:28 -0700 (PDT)
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
 <CAMj1kXHjXcFePeRWDtxZnC6eHEeELA6kZXOU=sA9oDZ1HzW_Vg@mail.gmail.com>
 <CAHp75VdLLZsJnektx+n=BGvGeaogN0r=viNJpbR-au5RUURi9Q@mail.gmail.com>
In-Reply-To: <CAHp75VdLLZsJnektx+n=BGvGeaogN0r=viNJpbR-au5RUURi9Q@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sun, 17 Oct 2021 15:31:17 +0200
Message-ID: <CAMj1kXFn+6AfVEksrEhPtPTHx-DmfTPwq=F7xpgs6D7EmKHMmA@mail.gmail.com>
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

On Thu, 7 Oct 2021 at 09:23, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>
> On Thu, Oct 7, 2021 at 10:20 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> > On Wed, 6 Oct 2021 at 18:28, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > > On Mon, Jun 14, 2021 at 08:27:36PM +0300, Andy Shevchenko wrote:
> > > > On Mon, Jun 14, 2021 at 08:07:33PM +0300, Andy Shevchenko wrote:
>
> ...
>
> > > > Double checked, confirmed that it's NOT working.
> > >
> > > Any news here?
> > >
> > > Shall I resend my series?
> >
> > As I said before:
> >
> > """
> > I would still prefer to get to the bottom of this before papering over
> > it with command line options. If the memory gets corrupted by the
> > first kernel, maybe we are not preserving it correctly in the first
> > kernel.
> > """
>
> And I can't agree more, but above I asked about news, implying if
> there is anything to test?
> The issue is still there and it becomes a bit annoying to see my hack
> patches in every tree I have been using.
>

If nobody can be bothered to properly diagnose this, how important is
it, really?

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
