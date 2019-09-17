Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-io1-xd2c.google.com ([2607:f8b0:4864:20::d2c])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iAHdz-0005zz-8R
 for kexec@lists.infradead.org; Tue, 17 Sep 2019 17:52:06 +0000
Received: by mail-io1-xd2c.google.com with SMTP id n197so9668867iod.9
 for <kexec@lists.infradead.org>; Tue, 17 Sep 2019 10:52:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190805083553.GA27708@dhcp-128-65.nay.redhat.com>
 <CAKv+Gu-my6EpLfxBnbMn21be62oHrF6PKFu2rt-4Pqk9wG9SXA@mail.gmail.com>
 <fbea659c-6e8f-b854-66d2-2c928d1d3783@redhat.com>
 <CACdnJusU7FKPFTz9MbXWvs-NHLX7bPLwkVynyK6cLxbxCNjrNQ@mail.gmail.com>
 <CAKv+Gu9_GDHiU2iBD7Lsk5dKupKBQO9Cfn3V2rhSU+DqQkAHOw@mail.gmail.com>
In-Reply-To: <CAKv+Gu9_GDHiU2iBD7Lsk5dKupKBQO9Cfn3V2rhSU+DqQkAHOw@mail.gmail.com>
From: Matthew Garrett <mjg59@google.com>
Date: Tue, 17 Sep 2019 10:51:47 -0700
Message-ID: <CACdnJut3t+TNLKg0=hUEFCT6wXmJtE2ju1hg6tuXue6L9Bxp6Q@mail.gmail.com>
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
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Dave Young <dyoung@redhat.com>, Laszlo Ersek <lersek@redhat.com>, kexec devel list <kexec@lists.infradead.org>

On Fri, Sep 13, 2019 at 2:18 AM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:

> > > - Remove the cleanup from the kexec path -- the cleanup logic from [4],
> > >   even if justified for the cold boot path, should have never modified
> > >   the kexec path.
> >
> > I agree that there's no benefit in it being called in the kexec path.
>
> Can I take that as an ack?

An ack of this hunk.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
