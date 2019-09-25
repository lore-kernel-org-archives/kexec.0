Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iD9Tb-0003wk-2D
 for kexec@lists.infradead.org; Wed, 25 Sep 2019 15:45:12 +0000
Received: by mail-wm1-x341.google.com with SMTP id 7so6303394wme.1
 for <kexec@lists.infradead.org>; Wed, 25 Sep 2019 08:45:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190805083553.GA27708@dhcp-128-65.nay.redhat.com>
 <CAKv+Gu-my6EpLfxBnbMn21be62oHrF6PKFu2rt-4Pqk9wG9SXA@mail.gmail.com>
 <fbea659c-6e8f-b854-66d2-2c928d1d3783@redhat.com>
 <CACdnJusU7FKPFTz9MbXWvs-NHLX7bPLwkVynyK6cLxbxCNjrNQ@mail.gmail.com>
 <CAKv+Gu9_GDHiU2iBD7Lsk5dKupKBQO9Cfn3V2rhSU+DqQkAHOw@mail.gmail.com>
 <CACdnJut3t+TNLKg0=hUEFCT6wXmJtE2ju1hg6tuXue6L9Bxp6Q@mail.gmail.com>
In-Reply-To: <CACdnJut3t+TNLKg0=hUEFCT6wXmJtE2ju1hg6tuXue6L9Bxp6Q@mail.gmail.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Wed, 25 Sep 2019 17:44:57 +0200
Message-ID: <CAKv+Gu-dPZNGoH2TzRTuh5K6rwjZ87A9z0NhQaJ_8Ef3RXVtUQ@mail.gmail.com>
Subject: Re: [PATCH] do not clean dummy variable in kexec path
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
To: Matthew Garrett <mjg59@google.com>
Cc: Dave Young <dyoung@redhat.com>, Laszlo Ersek <lersek@redhat.com>, kexec devel list <kexec@lists.infradead.org>

On Tue, 17 Sep 2019 at 19:52, Matthew Garrett <mjg59@google.com> wrote:
>
> On Fri, Sep 13, 2019 at 2:18 AM Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
>
> > > > - Remove the cleanup from the kexec path -- the cleanup logic from [4],
> > > >   even if justified for the cold boot path, should have never modified
> > > >   the kexec path.
> > >
> > > I agree that there's no benefit in it being called in the kexec path.
> >
> > Can I take that as an ack?
>
> An ack of this hunk.

Given that the patch in question has only one hunk, I'll take this as
an ack of the entire patch, and queue it as a fix.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
