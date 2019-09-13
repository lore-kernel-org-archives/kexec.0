Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1i8hiY-0003gr-7a
 for kexec@lists.infradead.org; Fri, 13 Sep 2019 09:18:16 +0000
Received: by mail-wr1-x441.google.com with SMTP id u16so31360983wrr.0
 for <kexec@lists.infradead.org>; Fri, 13 Sep 2019 02:18:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190805083553.GA27708@dhcp-128-65.nay.redhat.com>
 <CAKv+Gu-my6EpLfxBnbMn21be62oHrF6PKFu2rt-4Pqk9wG9SXA@mail.gmail.com>
 <fbea659c-6e8f-b854-66d2-2c928d1d3783@redhat.com>
 <CACdnJusU7FKPFTz9MbXWvs-NHLX7bPLwkVynyK6cLxbxCNjrNQ@mail.gmail.com>
In-Reply-To: <CACdnJusU7FKPFTz9MbXWvs-NHLX7bPLwkVynyK6cLxbxCNjrNQ@mail.gmail.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Fri, 13 Sep 2019 10:17:50 +0100
Message-ID: <CAKv+Gu9_GDHiU2iBD7Lsk5dKupKBQO9Cfn3V2rhSU+DqQkAHOw@mail.gmail.com>
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

On Tue, 13 Aug 2019 at 22:14, Matthew Garrett <mjg59@google.com> wrote:
>
> On Tue, Aug 13, 2019 at 4:28 AM Laszlo Ersek <lersek@redhat.com> wrote:
> > (I verified yesterday, using the edk2 source code, that there is no
> > varstore reclaim after ExitBootServices(), indeed.)
>
> Some implementations do reclaim at runtime, in which case the
> create/delete dance will permit variable creation.
>
> > (a) Attempting to delete the dummy variable in efi_enter_virtual_mode().
>
> To be clear, the dummy variable should never actually come into
> existence - we explicitly attempt to create a variable that's bigger
> than the available space, so the expectation is that it will always
> fail. However, should it somehow end up being created, there's a race
> between the creation and the deletion and so there's a (small) risk
> that the variable actually ends up there. The cleanup in
> enter_virtual_mode() is just there to ensure that anything that did
> end up being created on a previous boot is deleted - the expectation
> is that it'll be a noop.
>
> > (b) The following part, in efi_query_variable_store():
> >
> > +               /*
> > +                * The runtime code may now have triggered a garbage collection
> > +                * run, so check the variable info again
> > +                */
> >
> > Let me start with (b). That code is essentially dead, I would say, based
> > on the information that had already been captured in the commit message
> > of [1]. Reclaim would never happen after ExitBootServices(). (I assume
> > efi_query_variable_store() is only invoked after ExitBootServices(),
> > i.e., from kernel space proper -- sorry if that's a wrong assumption.)
>
> It's dead code on Tiano, but not on at least one vendor implementation.
>
> > Considering (a): what justified the attempt to delete the dummy variable
> > in efi_enter_virtual_mode(), in commit [4]? Was that meant as a
> > fail-safe just so we don't leave a dummy variable lying around?
>
> Yes.
>
> > So even if we consider the "clean DUMMY object" hunk from [4] a
> > justified fail-safe for the normal boot path, it doesn't apply to the
> > kexec path -- the cold-booted primary kernel will have gone through
> > those motions already, will it not?
> >
> > Therefore, we should do two things:
> >
> > - Remove the cleanup from the kexec path -- the cleanup logic from [4],
> >   even if justified for the cold boot path, should have never modified
> >   the kexec path.
>
> I agree that there's no benefit in it being called in the kexec path.

Can I take that as an ack?

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
