Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5312C5AC7C
	for <kexec@archiver.kernel.org>; Fri,  7 Aug 2026 08:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JHeB88vqilDpwozn+bZS5UOoDvrvofPnePWIeVZSifQ=; b=G64gPHFMltIkPexm5dOvPR9zNg
	oFYh51H4O4g3N/5OrCLpVuayC+6GsLjsy2mRHOFAicpYTL4eCXvY583TDRWOsFCGSa7m/m3txn/Ts
	U6RbOubQiejJTsg1JVT30aqxIwtiF/UjV7qGj2GvtJDTLI7aWEQyeq6+CutyVkfJ3+EqrUvpjYp0/
	pYiyw9Y8XvJ9U6ImVsApblrDEQbZmv1k0avFD7cMxAM6Dg+XrmyyJJ8UN1rTE8Bj8KrSyzXbhCxOX
	zyIt84oXi99j3maFgZwI4fwF3+akEL8wfXXPgRKwt79TmftBjUh8pwEXCxsBVrO1q31B/UE6GnHHZ
	oq45wA9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wsFWo-00000007K41-1DyZ;
	Fri, 07 Aug 2026 08:02:06 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wsFWl-00000007K3D-3UcO
	for kexec@lists.infradead.org;
	Fri, 07 Aug 2026 08:02:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786089721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JHeB88vqilDpwozn+bZS5UOoDvrvofPnePWIeVZSifQ=;
	b=ABGFLBYRUffoEf5eOwisvUZX8RV+OGrihlT94aOHJS/Rn3wkxFgYr7tiWw9x+fIEKrJkGd
	xn0+iFIVkt00Og/L8YGa1v0w7L6zIN9fcHXUwlXdUttL+y6lM7g8njBxyCR89hryLhpKD4
	KkwIkcslw0wwkMAVf5YKnhgHMCCmQWk=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-OZH7vkrKMzChRfvaNm6XFg-1; Fri, 07 Aug 2026 03:58:34 -0400
X-MC-Unique: OZH7vkrKMzChRfvaNm6XFg-1
X-Mimecast-MFC-AGG-ID: OZH7vkrKMzChRfvaNm6XFg_1786089514
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-907c59bd73bso50989846d6.3
        for <kexec@lists.infradead.org>; Fri, 07 Aug 2026 00:58:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786089514; x=1786694314;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JHeB88vqilDpwozn+bZS5UOoDvrvofPnePWIeVZSifQ=;
        b=LTKtFzbZL+A9JnyeGltOTWI9IAHfmOXzoK+DdCfj71yYhRvI7N1b0BkB+vMG2LLZYo
         cKC8MG1Vh4X2B1LWJGevrF/5L1yPZQISRiydPrGCVbZ5WDtw72V094uyXM+zj1GpIt3g
         ge5YXxL3suVPOADgAUFwPi+V36BgC8KBboOk1akXWdGmyQkInGEItXBQGXWvxMiE3OVN
         jzWqnf3/XHAhw1t5IbIkFOb2JWdiWPZiqEhp32xPJP0/y+nkwkVZ1aTqx/R2KUrCsKQc
         Bxqxg5m+Qmqgc0sGRwDHPDFP12ONM86aAD/zOUh2cJOMpFn16+jUFmWlYdsoCAkXymiD
         6X9A==
X-Forwarded-Encrypted: i=1; AHgh+RrPSH4yqp61CKS5fiwyJyxlRmWvKoWlAxuV2Q+bhz+mdh4KjElfLL3TcutZ4HBLUvWxNwr8Xg==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz2pRJ5bCiNQZVkusAajPYxnbI4yVr0KwJy+GhgZjDEJT1aeDPD
	e/BNpvZVJds8Fnho+S1+yDgpkEqD7yam++e+rsicm7RhHwOM+w9JbeZvzAOrNGkeizSnpUf/+3J
	yZhJ1OlYIWXIFSfGGgAOKabVKrG0WmXYd6tKm7VObW3iE1J6bQ5lmBXPy251pX11y5AlqImBlSr
	7kwCTanFA9paLWno+92aT3dC1EDJm8jxUEbkgeY8ootOCP3Sw=
X-Gm-Gg: AR+sD13C7GWNsxWZfKCrErfv9osZxZgiEKApVRiKrTVPjOlyydV4Q2EAEFsKgGTlKCK
	6ofUUWqnZPPmIF8msOhehNTi8/11Z5cZk8eP6bGmGg1DKjUU6hkiVpbvDRlvWril2O3BZueaNVC
	S9A+Zm0IqYj09o0d7kgp+ZbRMwUdzKBeTM8pzmQpBiwhdYVugun3E7mrRu
X-Received: by 2002:a05:622a:1b8c:b0:51c:2685:2964 with SMTP id d75a77b69052e-52d0b29c07fmr80460161cf.43.1786089514037;
        Fri, 07 Aug 2026 00:58:34 -0700 (PDT)
X-Received: by 2002:a05:622a:1b8c:b0:51c:2685:2964 with SMTP id
 d75a77b69052e-52d0b29c07fmr80459871cf.43.1786089513597; Fri, 07 Aug 2026
 00:58:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260714004550.3698175-1-stephen.s.brennan@oracle.com> <7af7b171-88c0-4eb6-a18e-8e64fb4a71c0@nec.com>
In-Reply-To: <7af7b171-88c0-4eb6-a18e-8e64fb4a71c0@nec.com>
From: Tao Liu <ltao@redhat.com>
Date: Fri, 7 Aug 2026 19:57:57 +1200
X-Gm-Features: AUfX_mz7V6nMwWYFbP3sXq7AtP3KuWsWyrwCGnwVcGPe-7-0LK9YcFslpvjwZZg
Message-ID: <CAO7dBbX---qP-Bqjza=z2HM4Nxn5+KtB-51WF4mvv++p666JYQ@mail.gmail.com>
Subject: Re: [PATCH makedumpfile 0/9] Improvements to makedumpfile extensions,
 plus userspace stack tracing extension
To: =?UTF-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+IOS4gOS7gSk=?= <k-hagio-ab@nec.com>
Cc: Stephen Brennan <stephen.s.brennan@oracle.com>, 
	=?UTF-8?B?WUFNQVpBS0kgTUFTQU1JVFNVKOWxseW0jiDnnJ/lhYkp?= <yamazaki-msmt@nec.com>, 
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _y9rfuOEREw6htAW-kIPoFK9kQIHiZm3fq_pljDhaWI_1786089514
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260807_010203_941151_31065BCB 
X-CRM114-Status: GOOD (  43.66  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hi Kazu,

On Fri, Aug 7, 2026 at 1:52=E2=80=AFPM HAGIO KAZUHITO(=E8=90=A9=E5=B0=BE=E3=
=80=80=E4=B8=80=E4=BB=81) <k-hagio-ab@nec.com> wrote:
>
> On 2026/07/14 9:45, Stephen Brennan wrote:
> > Hello all,
> >
> > Building on Tao Liu's excellent work for makedumpfile extensions, I'd l=
ike to
> > share some incremental improvements to the extension system, as well as=
 my own
> > two extensions which enable userspace stack tracing. There are three to=
pics
> > related to the core makedumpfile extension system which are addressed h=
ere:
> >
> > 1. Tail pages handling. As patch 1 explains, extensions currently get c=
alled for
> > tail pages, but their decisions are not respected. I believe the best a=
pproach
> > is to only call extensions for the head page, but allow extensions to r=
eturn a
> > decision related to just a subset of the pages. To this end, patch 7 ad=
ds
> > PG_INCLUDE_HEAD to include just the head page (leaving the rest up to t=
he
> > default policy), and patch 9 shows the elfheader extension which uses t=
hat
> > functionality.
> >
> > 2. Counting pages included by extensions. This is done by patch 4. It a=
lters the
> > logic because it's really helpful to know whether a page would have bee=
n
> > included by makedumpfile's dump-level filtering anyway, so we only coun=
t the
> > additional pages.
> >
> > 3. Sharing makedumpfile's logic and knowledge about page metadata. Curr=
ently,
> > extensions just get a "pcache" pointer, which means they must redo what=
ever
> > logic makedumpfile has already done, in order to get information like
> > compound_order. Patches 3, 5, and 6 factor out the page metadata into a=
 new
> > struct pginfo, which gets passed to extensions, and it also makes more =
of the
> > helpers like "isSlab()" usable with this pointer.
> >
> > With those improvements, the final two patches (8 & 9) implement a pair=
 of
> > extensions that are useful for including a minimal amount of informatio=
n which
> > can be used to do stack traces of the userspace processes in a vmcore. =
The
> > "userstack" extension includes the stack memory itself for each thread,=
 and the
> > "elfheader" extension includes the first page of mapped ELF files, so t=
hat ELF
> > build IDs can be identified from the vmcore.
> >
> > My testing so far:
> > - Live testing (/proc/kcore) x86_64 on Oracle UEK 8 (6.12.x based)
> > - Refiltering on vmcores generated from UEK8, 7 (5.15.x based), 6 (5.4.=
x based)
> > - Using the resulting filtered vmcores with drgn's contrib/pstack.py to=
 generate
> >    userspace stack traces.
> >
> > I still have significantly more testing to do and then share out:
> > - Testing in kexec environment
> > - Testing with upstream kernels, also verifying in a Fedora userspace
> > - Sharing runtime and size comparisons with different workloads
> >
> > Despite the limited testing, I wanted to share these patches as they ar=
e,
> > because I think the improvements for the core extensions framework are =
useful
> > already, and don't require as much verification.
> >
> > For the extensions themselves, I would like to consider merging them as=
 well, if
> > there is interest. I think it would be useful for makedumpfile to conta=
in shared
> > extensions, including those for the GPU buffers which Tao Liu was worki=
ng on, as
> > well as the userspace stack tracing ones which I'm sharing.
>
> Hi Stephen, (and Tao)
>
> sorry for my slow review and thank you for your nice improvements!
> I've reviewed the patches 1 to 7, these make good sense and look very
> clean to me.
>
> few comments:
> * I also think that including extensions is very useful, but for now,
> I have to not increase the maintenance cost as far as possible, so
> will not include them.  (this way has some good points, for example
> you can update them freely without my slow review :-)
>
> For user access, I'm thinking about adding makedumpfile extension list
> to its wiki page [1].  If you agree on this, please provide their
> information (extension name, author, link, description).
>
> * Could you add a description why PG_INCLUDE_HEAD is needed to the
> patch 7, as we cannot add the cover letter and the patch 9.
> (Text alone is ok, or you can use v2 just for the patch 7.)
>
> Otherwise, there are typos and comment style gaps, but those can
> be fixed when merging.
>
> and Tao, please check if your extension can be rebased on this
> patchset.  and also if you agree the extension list, please provide
> the information.

Sure, I will check for the rebase. In the meantime, will the
extensions to be maintained in one repo (e.g. makedumpfile extensions
repo, so everyone can PR to it), or they are maintained in each of
individual repos, and link them under
https://github.com/makedumpfile/makedumpfile/wiki#extensions?

Thanks,
Tao Liu

>
> [1] https://github.com/makedumpfile/makedumpfile/wiki#extensions
>
> Thanks,
> Kazu
>
> >
> > Thanks,
> > Stephen
> >
> > Stephen Brennan (9):
> >    Do not call extensions for tail pages
> >    Honor CFLAGS in extension/Makefile
> >    Share page information with extension callbacks
> >    Introduce a stat for pages retained by extension
> >    Move page checks into makedumpfile.h
> >    Simplify arguments for page checks
> >    Add PG_INCLUDE_HEAD extension return status
> >    Add userstack extension
> >    Add elfheader extension
> >
> >   extension.c             |  10 +-
> >   extension.h             |  10 +-
> >   extensions/Makefile     |   8 +-
> >   extensions/elfheader.c  |  93 ++++++++++++
> >   extensions/userstack.c  | 325 +++++++++++++++++++++++++++++++++++++++=
+
> >   extensions/vma_mtree.c  | 140 +++++++++++++++++
> >   extensions/vma_mtree.h  |   7 +
> >   extensions/vma_rbtree.c |  56 +++++++
> >   extensions/vma_rbtree.h |  12 ++
> >   makedumpfile.c          | 188 +++++++++--------------
> >   makedumpfile.h          |  78 +++++++++-
> >   11 files changed, 798 insertions(+), 129 deletions(-)
> >   create mode 100644 extensions/elfheader.c
> >   create mode 100644 extensions/userstack.c
> >   create mode 100644 extensions/vma_mtree.c
> >   create mode 100644 extensions/vma_mtree.h
> >   create mode 100644 extensions/vma_rbtree.c
> >   create mode 100644 extensions/vma_rbtree.h
> >


