Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4359E674BA
	for <kexec@archiver.kernel.org>; Fri,  1 Nov 2024 08:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=f7Tp6TUJ87SchQUpa97r3RB140451bIoXrFyR1gW+Hw=; b=hnq+UgB+liKi5y
	a/uW0+nR3CXvIuB36YEYu7VMm5K/5f3qSWExxuxX2oGv8cZHAIi97HKl4WSVU4h1WjIkMBXyFeFSm
	dr12SO7CrdUOxwbEbMp5/vV+sNVKPiCwWRx+1NY1zs9GjtprfK+PBcrUvAiYjT8NBpwQEhmGYoBi3
	1FzA4+wZ33mQTtzvHOKgvBC/VzJ8IGgeVXbFQP6YwIcaMjeJlIm7lPat4CSOwPHgyM1L7TXG5KC0z
	h9IG+Mw+yoH5ILHWZqvPj4k2TgIctQmkvK1uLgjd5+5c2g3vW96GSTGtlmc9lAsixO2uHzD9WN9IA
	f04Vubcq/tevsD3KYxdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6nN1-00000006KEZ-18GJ;
	Fri, 01 Nov 2024 08:51:03 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6nMx-00000006KDH-3fun
	for kexec@lists.infradead.org;
	Fri, 01 Nov 2024 08:51:01 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id EABE2A40EE7
	for <kexec@lists.infradead.org>; Fri,  1 Nov 2024 08:49:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE884C4CEE3
	for <kexec@lists.infradead.org>; Fri,  1 Nov 2024 08:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730451057;
	bh=7Gv2CqzecQ8F4MJ4RrKkxM6klDrmuRMoDH8RdhY0ReU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qjR7OsFrdihA7dg0hpyjg9HMDJP61+hracN3Kea7Nu7/Azg1y4PBcP7U99Qkm9Vxk
	 Nn9ff/BEvmY8/t1ltJa0JUCnGcKqGs6hzn/SL10Rr5r4fWRDtAeJ9LXr5sGxyFRx2z
	 F1eIx16Rv+t4TGgSDM0/BtOY2XKAGOhVeoQfojY7DDcw9Hmxvvm7qUULsP1OuZsWPh
	 uShABLy+TSjvZDS+W6NjrA5RiEB2zLVbx89FubLEZdHrOMny0E5nvaJitx/BXfmTyz
	 GfIptvJ+7IXDsC7Oj9MCy6293wyoTHDKT+4Nc+naDTzxTZznrlXvbCTYWjcOJcQaDl
	 w/KVGbLEQtrNw==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2fb3da341c9so17153231fa.2
        for <kexec@lists.infradead.org>; Fri, 01 Nov 2024 01:50:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWCtileUNcVknCRaNE3RnybRMZGCHlXozzvgKWMItJn83PhzxlRKOaMoBC5VvxSj75Wd7xH9w==@lists.infradead.org
X-Gm-Message-State: AOJu0Yxw5L0VQSYvgTiTjRBFc3DLrniebBywC6raxEZt0rjIH9WeECnA
	XI6knZGvwon/jaTIZDGQZ+IbQbPeUforU1d2/XQHQ5XM30/9d09MDx51pbp6WBtZAQUfSrgFgV7
	Z/FqMRQJ7rKv0qKQYuy3kxwTMyd4=
X-Google-Smtp-Source: AGHT+IGq5KFbAI9S4x36ffXOC0opBJXf4wJXpPrXgnubpE+Mpoy/r4fbPNLJGcyf/oa8AjMSFwlnLkaspaUTNz8mWrE=
X-Received: by 2002:a05:651c:211b:b0:2fb:6110:c5cb with SMTP id
 38308e7fff4ca-2fedb7d9117mr14787541fa.34.1730451055747; Fri, 01 Nov 2024
 01:50:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240913200517.3085794-1-ross.philipson@oracle.com>
 <87wmhoulb9.ffs@tglx> <D5ACNMVX5LXB.1L0S9P2J3UDJH@kernel.org>
 <87ldy3vpjh.ffs@tglx> <D5AF4HY1I6AA.27WRBDDGLYH39@kernel.org> <D5AF9K79H8WO.PVW93P31GHMH@kernel.org>
In-Reply-To: <D5AF9K79H8WO.PVW93P31GHMH@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 1 Nov 2024 09:50:44 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHFDMKEH46MG3731FS043XyxHchoTJtDOst6kvfMezUuQ@mail.gmail.com>
Message-ID: <CAMj1kXHFDMKEH46MG3731FS043XyxHchoTJtDOst6kvfMezUuQ@mail.gmail.com>
Subject: Re: [PATCH v11 00/20] x86: Trenchboot secure dynamic launch Linux
 kernel support
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ross Philipson <ross.philipson@oracle.com>, 
	linux-kernel@vger.kernel.org, x86@kernel.org, linux-integrity@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org, 
	kexec@lists.infradead.org, linux-efi@vger.kernel.org, 
	iommu@lists.linux-foundation.org, dpsmith@apertussolutions.com, 
	mingo@redhat.com, bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com, 
	mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de, 
	jgg@ziepe.ca, luto@amacapital.net, nivedita@alum.mit.edu, 
	herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net, 
	ebiederm@xmission.com, dwmw2@infradead.org, baolu.lu@linux.intel.com, 
	kanth.ghatraju@oracle.com, andrew.cooper3@citrix.com, 
	trenchboot-devel@googlegroups.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241101_015100_067313_ABC8AE1E 
X-CRM114-Status: GOOD (  41.18  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Fri, 1 Nov 2024 at 01:40, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> On Fri Nov 1, 2024 at 2:33 AM EET, Jarkko Sakkinen wrote:
> > On Fri Nov 1, 2024 at 1:08 AM EET, Thomas Gleixner wrote:
> > > On Fri, Nov 01 2024 at 00:37, Jarkko Sakkinen wrote:
> > > > On Thu Oct 31, 2024 at 9:25 PM EET, Thomas Gleixner wrote:
> > > >> So this looks pretty reasonable to me by now and I'm inclined to take it
> > > >> through the tip x86 tree, but that needs reviewed/acked-by's from the
> > > >> crypto and TPM folks. EFI has been reviewed already.
> > > >>
> > > >> Can we make progress on this please?
> > > >
> > > > So TPM patches do have bunch of glitches:
> > > >
> > > > - 15/20: I don't get this. There is nothing to report unless tree
> > > >   is falling. The reported-by tag literally meaningless. Maybe this
> > > >   is something that makes sense with this feature. Explain from that
> > > >   angle.
> > > > - 16/20: Is this actually a bug fix? If it is should be before 15/20.
> > > > - 17/20: the commit message could do a better job explaining how the
> > > >   locality can vary. I'm not sure how this will be used by rest of
> > > >   the patch set.
> > > > - 18/20: I'm not confident we want to give privilege to set locality
> > > >   to the user space. The commit message neither makes a case of this.
> > > >   Has this been tested to together with bus encryption (just checking)?
> > >
> > > Can you please explicitely voice your detailed technical concerns in
> > > replies to the actual patches?
> >
> > - 15/20 looks like a rigged patch. I don't really know why it is done
> >   so it is hard to either suggest how "resolve it".
> > - 16/20 probably makes sense but if it is a bug fix or part of it is,
> >   the bug fix should have relevant fixes etc tags so that it can be
> >   picked up to stable kernels.
> > - 17-18/20: I'd speak about this as the "one whole" i.e. here the
> >   privilege to be able change locality during run-time is really
> >   concerning. Could the locality be figured out for the kernel
> >   command-line instead? The sysfs attribute can exist as read-only.
> >
> > So yeah, the way I see it 15-16 are the more trivial issue to sort
> > out (probably) but with 17-18 we have an actual architectural concern
> > for kernel overall.
>
> Further:
>
> 15/20: I can accept this without reported-by tag (or changed as
> suggested-by). It does not harm.
> 16/20: I'll re-review this with time. I'll try to get this done
> latest next week.
>
> So let's put focus only on 17 and 18. Can this problem be sorted out
> by kernel command-line parameter? In the case of locality we want to
> keep regular "chain of trust" i.e. boot-loader makes the decision,
> *even* in the case of DRTM. I would call this almost as constraint
> that would be wise to set.
>

Please don't add a kernel command line parameter for this - the code
running in the decompressor will be the one setting it and there are
better ways to pass information between these components (and the
slaunch stack is already doing that in any case)

Also, let's have this discussion in the appropriate place, i.e., on
the thread for each respective patch.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
