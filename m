Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jOF2X-0001qx-2Z
 for kexec@lists.infradead.org; Tue, 14 Apr 2020 06:27:22 +0000
Received: by mail-wr1-x443.google.com with SMTP id f13so12914680wrm.13
 for <kexec@lists.infradead.org>; Mon, 13 Apr 2020 23:27:20 -0700 (PDT)
Date: Tue, 14 Apr 2020 08:27:16 +0200
From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] efi/x86: Revert struct layout change to fix kexec boot
 regression
Message-ID: <20200414062716.GB84326@gmail.com>
References: <20200410074320.16589-1-ardb@kernel.org>
 <20200410135644.GB6772@dhcp-128-65.nay.redhat.com>
 <20200410140151.GC6772@dhcp-128-65.nay.redhat.com>
 <CAMj1kXEM13Y5FCh8GvJGTueen3fa0u_JX66j0X10KPf4Z0c4Jg@mail.gmail.com>
 <20200410143313.GB8205@zn.tnic>
 <CAMj1kXGn+RuJx2PJ+X5KJ3rtMyRRX2eOK2Zu5GuK1NHxum1M4w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAMj1kXGn+RuJx2PJ+X5KJ3rtMyRRX2eOK2Zu5GuK1NHxum1M4w@mail.gmail.com>
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
Cc: linux-efi <linux-efi@vger.kernel.org>, "Theodore Y. Ts'o" <tytso@mit.edu>, X86 ML <x86@kernel.org>, kexec@lists.infradead.org, Borislav Petkov <bp@alien8.de>, Dave Young <dyoung@redhat.com>


* Ard Biesheuvel <ardb@kernel.org> wrote:

> On Fri, 10 Apr 2020 at 16:34, Borislav Petkov <bp@alien8.de> wrote:
> >
> > On Fri, Apr 10, 2020 at 04:22:49PM +0200, Ard Biesheuvel wrote:
> > > > BTW, a fixes tag is good to have..
> > >
> > > I usually omit those for patches that fix bugs that were introduced in
> > > the current cycle.
> >
> > A valid use case for having the Fixes: tag anyway are the backporting
> > kernels gangs which might pick up the first patch for whatever reason
> > and would probably be thankful if they find the second one, i.e., the
> > fix for the first one, through grepping or other, automated means.
> >
> 
> Fair point.

I've added:

  Fixes: 0a67361dcdaa29 ("efi/x86: Remove runtime table address from kexec EFI setup data")

Out of abundance of caution. :-)

Thanks,

	Ingo

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
