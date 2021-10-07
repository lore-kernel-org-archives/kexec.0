Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mYNku-00GQ6E-1Z
 for kexec@lists.infradead.org; Thu, 07 Oct 2021 07:23:53 +0000
Received: by mail-ed1-x52d.google.com with SMTP id g8so19355072edt.7
 for <kexec@lists.infradead.org>; Thu, 07 Oct 2021 00:23:49 -0700 (PDT)
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
In-Reply-To: <CAMj1kXHjXcFePeRWDtxZnC6eHEeELA6kZXOU=sA9oDZ1HzW_Vg@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 7 Oct 2021 10:23:12 +0300
Message-ID: <CAHp75VdLLZsJnektx+n=BGvGeaogN0r=viNJpbR-au5RUURi9Q@mail.gmail.com>
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

On Thu, Oct 7, 2021 at 10:20 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> On Wed, 6 Oct 2021 at 18:28, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > On Mon, Jun 14, 2021 at 08:27:36PM +0300, Andy Shevchenko wrote:
> > > On Mon, Jun 14, 2021 at 08:07:33PM +0300, Andy Shevchenko wrote:

...

> > > Double checked, confirmed that it's NOT working.
> >
> > Any news here?
> >
> > Shall I resend my series?
>
> As I said before:
>
> """
> I would still prefer to get to the bottom of this before papering over
> it with command line options. If the memory gets corrupted by the
> first kernel, maybe we are not preserving it correctly in the first
> kernel.
> """

And I can't agree more, but above I asked about news, implying if
there is anything to test?
The issue is still there and it becomes a bit annoying to see my hack
patches in every tree I have been using.

-- 
With Best Regards,
Andy Shevchenko

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
