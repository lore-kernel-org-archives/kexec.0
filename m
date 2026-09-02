Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25C7BC61DD6
	for <kexec@archiver.kernel.org>; Wed,  2 Sep 2026 16:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nM61rBP1BrIw92wse1BgxX/qISplnRkVLpz/2YdWlss=; b=OSNCFdoUUqvTo45eOdIFiAtKFD
	ZZj59W/dUyh3N/eIQw9CS9ub827CKZ+qklmgwA/hqJ+9KN7LeT0/vZRaGt3uE1e+2WNRg3N/Z6NhL
	jb+aWLdpzU/PEwxbb3qWhQly6Q40dfCIlRTydhXSc7068+RDS+dcxekXLHLl5x748IAR0R9ji01Ww
	BnYnfmEW5voC0vqDJYYVPrmhv1t4dgHsFM1vomBKGDwFr2TMvZExiTnNfhYEhfo+ub4fgkC8krItT
	bzlZoF91au+io4JiUwxjL9xDgtQ4tgD/P83336W1ANDo3xVXUP3JCFrZDqGw/naFXqPBQMNGGnCLE
	ZIgH883A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1nrj-0000000FCo7-3SGE;
	Wed, 02 Sep 2026 16:31:17 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1nr8-0000000FCj7-2DBr
	for kexec@bombadil.infradead.org;
	Wed, 02 Sep 2026 16:30:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=nM61rBP1BrIw92wse1BgxX/qISplnRkVLpz/2YdWlss=; b=XtCyjNgLzS6K0YXDQwhvttmxkp
	ARLPL4FHLOKY2Lztaoajkt+wawXJN3g7nUMDr/l7JVXzb/M5Agc7KDMw/RuS825aOtaXiipLESZYB
	UIPZOuKQmTabC1Wv55Eg2IdnCoXkcUNgC2hIyJWIanrNREhVQQNXi2O2IdkpjgNn92O5pKEPlkJGE
	S/uGggQI+lYsmx2sQK627KrOOoT8v/4EbjLLdFsuAxVZc0o2LAk7Doa7r5ipRvoixvcT/Pbd7LKZ1
	kcB7nJhKmmEj4o9fpxnw+beTttuSvJ9P64CO1GwTNCHy3VImrxIIuQg+LoxlpxiLaupHhidwg8muu
	8FVs1ZrQ==;
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x1nr3-0000000CCQq-29lI
	for kexec@lists.infradead.org;
	Wed, 02 Sep 2026 16:30:31 +0000
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-c207cb16cf5so181103466b.1
        for <kexec@lists.infradead.org>; Wed, 02 Sep 2026 09:30:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788366625; cv=none;
        d=google.com; s=arc-20260327;
        b=QECWQ8vIlSdgSiS1QPdB8xX7E+/WqticW/0xs1KTlPH4TmDVkKxZFdZHlJlN0aQcea
         SmsGGiMCd5GndCftq8XWAn9sDKdE8Bd3Hr2ZLmAY0CmQHYs4TjL7riCg5HK1TqEy2N0q
         wyC+xKTAv79mBIqkSFeKV0JzMlCpKdYjmJniGEvEiO/Iw0BG1AxB0qt073d/q6KFWCW0
         tQBeXOMjbEx2JTM70cRHzw9J8zmZ2I/R7WXKc4lSzCOGyLi7wQgwgXB2P+4QA4ZnyblZ
         CMCts9pJubjknLbNCn4G0OhkGVuVvWa1TDLG8Rw+8aTzALBCPSJ4iREi+SZirnv+T+U6
         4AZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nM61rBP1BrIw92wse1BgxX/qISplnRkVLpz/2YdWlss=;
        fh=WifwyjTspIiPm4zs+rES/xukqGB7IdRUIA6X+v7zq34=;
        b=ny4CihD8+VDKgpmA+jhEsqgS67qfGlRlJavJI7vmp8l0gEpVyHEfVJrcEiHg5rYHCQ
         6C/Dyi9oPUmRN825/54upFCuePStOnR3sUtOqUjRct/0dNl9gy4nZSUoVR9mJv66vfNK
         CrN1AJ+No/joql6sD0qQP42HdA1+HsCJWI7WCRhPz+e1fAA1XBhadQXLbb0Wf8cKsDi/
         xsBYr+tq2cbeEQZwez1vdFP3htHV27nzYcKH6fK4SykDuc/muhi/0E+M/9NY2jWZuRbZ
         j1j7pMDjUWd78+Qzq+R0sEgGraybo09BdBQte/RL50u/kKr0572uy9rUJ5VkTWWlPnUT
         jfXA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788366625; x=1788971425; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nM61rBP1BrIw92wse1BgxX/qISplnRkVLpz/2YdWlss=;
        b=ValpyAGXzYGH5l6UKnDoK0o+MZZWvXrQ8Z8Ed1YVQS3oBBe+hENY8wWwBt3HcgWwix
         qeUgHm8q1wcsVQnpCDG+GMEbNHZ8QPzArFBZhQJprZzkwQtsJBcuHe6m4OvJ4C6aG1rH
         4o2kPKNejD3oFoLF+hEPd8mtprOYRSiBaYfYlVohbWopBJPvzwzSjyDwHQ/N/quBC44/
         UzLgJjd5ykxplG/cNTt/BbY3MQF6L3TWv6TBX0OYKh9fYawQ5NZmkQDNhGEDxdMizNHK
         1xaRnbTUqgAL7eqx24M8TTLdTBJT02wRYMekZqNJN5+mWWuzQJegOB5OI8nG7MJb11oV
         LIDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788366625; x=1788971425;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nM61rBP1BrIw92wse1BgxX/qISplnRkVLpz/2YdWlss=;
        b=ShM/KT6XQt6h6jkux5OlYx6tJUcoeK/y/wbHDoVKTJzdge8QBP4Yim01/zzrL2uleI
         DvMgBcmJMwa41wzsqIQMIt0vtDODQXUhMcfzNrak80o+PKvVZGuFJkG4Pd570vXR/eyg
         lj9zzFL/6INXmZ0yafbI0PCLlkWGmXvUmEBUTBmQkbCTS65wgGMqpLBgA4KxvNndvfL3
         s5a7JpOzxUzUwrl/ePMSu5Y9TO3dmx6rL6n7We6F9yQ6D36FqA/050IXF3voY0ebgDi8
         YdwIIOQYEmP83Y/hMqqxeMbH5MA61Y900Mva0wMugoT/OEnqlomFpWnQGeFBtCd+PTAi
         IqeA==
X-Forwarded-Encrypted: i=1; AKwUvBx9W1SEjiZfaO6Gy5UpnlxROKigbP7DttMIIwcHzDOr/3NaBhHuifcMtvwhQws7Rd1ou/VT0w==@lists.infradead.org
X-Gm-Message-State: AFuF++kSQASfw/ea+ToNllMpa6lajaCV5IKWb0a2EhrBMBcZlSfISxKy
	wyIUwyAQACPGLr/zkl0NfWCxKjHar50EFnPzVg+rR8YdApyNMtQwaYPHbKRaWQXFqwnE4Yo/2ah
	tnfF+2lm/MRT7p65Ssdw1A80g+DJMh1gouYBr2gxm
X-Gm-Gg: AYBFou3MJnrsnMfqw7QaYXUK685LLPpkIx8fiw8a9v8omY1qt6mbWFQViYjLsq+R3cn
	BfqfCXmUTGD03vMbjPLBuZ/pYiaCAtU+PGNfvffCLP0Niu20NZXEx0wLSpB+5CoIoRFv8LNOh4b
	1XoPXbdef3MuqhWdaZMHuzrhs+LES0Rada8A4gJPxUEZRBEImsEs0mz5VT9ktB07x08OFhclCmQ
	jDn6UCswx+IGYerjQGTh/8a5qizq5O1v0JvMnPN0XI3VAKJRQy6o8Te+c4sW7upsqcKWsm9NlVy
	N8psaEuAfMsfUKU1Ih3pWIjEdgAG7wJDRi3o6A0tvar0fJ0XdqLEWeAB
X-Received: by 2002:a17:906:99ce:b0:c25:1b4f:6d95 with SMTP id
 a640c23a62f3a-c25d529fe25mr473576466b.6.1788366624769; Wed, 02 Sep 2026
 09:30:24 -0700 (PDT)
MIME-Version: 1.0
References: <CALzav=eL-cARsaH4AO4PzeOPNDmTHpCZbYh9yX_U8pbz96qdTQ@mail.gmail.com>
 <apenOdHJmH_VeD-X@kernel.org> <ape5s5tdwV6WwPih@fedora> <apfYhLD0sHt2odi8@kernel.org>
In-Reply-To: <apfYhLD0sHt2odi8@kernel.org>
From: David Matlack <dmatlack@google.com>
Date: Wed, 2 Sep 2026 09:29:55 -0700
X-Gm-Features: AcwNN1W0jNM0_qebUiV26vkDEnpXQXQSrqSNV5dgX0QdrJ2hfQaq5AEYNfT2sGk
Message-ID: <CALzav=e7J8XgdNh8998=qEXjqLVyof1DaYDf8swiApFOLVCpLw@mail.gmail.com>
Subject: Re: RFC: Enable Sashiko code reviews for kexec@lists.infradead.org
To: Mike Rapoport <rppt@kernel.org>
Cc: Baoquan He <baoquan.he@linux.dev>, kexec@lists.infradead.org, 
	Andrew Morton <akpm@linux-foundation.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Dave Young <ruirui.yang@linux.dev>, 
	Alexander Graf <graf@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260902_173029_782448_DF4AAFA4 
X-CRM114-Status: GOOD (  27.08  )
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

On Wed, Sep 2, 2026 at 1:04=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wrot=
e:
>
> Hi Baoquan,
>
> On Wed, Sep 02, 2026 at 01:52:51PM +0800, Baoquan He wrote:
> > On 09/02/26 at 07:34am, Mike Rapoport wrote:
> > > On Tue, Sep 01, 2026 at 01:27:34PM -0700, David Matlack wrote:
> > > > Hi kexec@ mailing list and maintainers,
> > > >
> > > > I would like to enable Sashiko code reviews for patches sent to the
> > > > kexec mailing list. I have found it useful for patches I have sent =
and
> > > > reviewed on the kvm and linux-pci mailing lists, which have Sashiko
> > > > enabled.
> > > >
> > > > I sent a pull request to Sashiko to add kexec here:
> > > >
> > > >   https://github.com/sashiko-dev/sashiko/pull/474
> > >
> > > diff --git a/sashiko.dev/email_policy.toml b/sashiko.dev/email_policy=
.toml
> > > index e6e4fb57f..e9ad97708 100644
> > > --- a/sashiko.dev/email_policy.toml
> > > +++ b/sashiko.dev/email_policy.toml
> > > @@ -175,6 +175,12 @@ reply_to_author =3D false
> > >  cc_individuals =3D false
> > >  cc =3D ["Chuck Lever <cel@kernel.org>", "Jeff Layton <jlayton@kernel=
.org>", "Anna Schumaker <anna@kernel.org>"]
> > >
> > > +[subsystems.kexec]
> > > +lists =3D ["kexec@lists.infradead.org"]
> > > +reply_to_author =3D true
> > > +send_positive_review =3D true
> > >
> > > Do we really want those?
> >
> > Some components don't want to CC list, then other people are welcome to
> > drop any comment during reviewing, while cc to maintainer and author
> > looks good to me. Just an input, no objection to any move.
>
> Sorry, I wasn't clear, I meant do we really want extra emails saying
> sashiko is happy?

This is currently enabled on the PCI mailing list and I have found it
useful there. It makes it trivial to distinguish between "Sashiko
reviewed the patch and found no issues" and "Sashiko did not review
the patch" (could not apply it, backend bugs, whatever) without having
to go to the Sashiko web UI to confirm. I can stay entirely on the
mailing list.

But I am ok with dropping it if you feel strongly. It is a small thing.

