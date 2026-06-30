Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC893C43458
	for <kexec@archiver.kernel.org>; Tue, 30 Jun 2026 22:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DR0tH2IO3fN80hPp68tJnACbZx0ZviQ8SFdx1MtberI=; b=Ay9Rb6lcZeZ5hKU4dZSs750s7H
	USupkE7VMZPG/RFTCYUcnpRSftLodEquzr95aGOv1wv43gMuZADSsnhOXncnO/MN1hh8+WqR0x2m5
	XNXtxEmKI5HH+vnzyG7YJuPOibGX1MR2/kV4XzH3DQdzHAAQ1RI0VyirOMusgM9/bD5tq0DRXlSqO
	F7qdaxMT9duotBgWb1GMVNHvPuWfOeGiwb24ltdP3+Rtb7pelz4fkuz1XrkZhUwvG0hcsV1KC6s4p
	XXIk7pD48AQXGjpt4bt1sFHdXaB0MDMtnjT2w6tTpeMfe2jJgbneU3vt5/QC7oHxVjG6K84AkGFD9
	escKYcfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wegq2-00000000IiV-2zWw;
	Tue, 30 Jun 2026 22:21:54 +0000
Received: from mail-dl1-x122a.google.com ([2607:f8b0:4864:20::122a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wegq0-00000000Ii8-1ZZp
	for kexec@lists.infradead.org;
	Tue, 30 Jun 2026 22:21:53 +0000
Received: by mail-dl1-x122a.google.com with SMTP id a92af1059eb24-139f1dfc9faso5304269c88.0
        for <kexec@lists.infradead.org>; Tue, 30 Jun 2026 15:21:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782858111; cv=none;
        d=google.com; s=arc-20260327;
        b=GZJ59JGmDeI7AsFGc271hd/b3OC3VQV8yw6Su5BSe+4PktMv72Sfr9/M8nLqTHAOXn
         1GTSFEzCK/N3Au2vM1/QT4K8jsSimqoKr1cLgQma2Go0sn3fRqyl/xzD6y0qeN/Kue5v
         Ip+HHNedEcLDNBSweyhuBU2ywX26uVv8vPxXcBTncP/nrmXtjDZaJBHJ4NiyPLk/AAFB
         UzBlJZhscOW7ZVJZmhm5NmU3g45j0HbZpquMOj3AEfz5IJDB3fjXaroHTVr+fOweaVVg
         SbBqjJbkg7VMLsRk7gjShel3uuk0WW8X/pNsXo854Lh+n+IgWpPC2j+SEBaOo37VhWt+
         Fjbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DR0tH2IO3fN80hPp68tJnACbZx0ZviQ8SFdx1MtberI=;
        fh=pfP+BzDql7tB8k+MiQF3fg2Cf8K/w/Bfhnlq6/knhtA=;
        b=gd4RNgXHehcF6+MeypWI46pTk3zJbR3vzJlrTenHF0gxhf/cP6AioRD9j+HPKy/f5n
         G609hd5/NKLKnK25anE7VCSAD+B3PVTve594AH/qjwD6y0MWEDD7Tib5kNR/GKqSSwQ4
         BmSZO97qWpXDO3xcqykqf2wK76ET46GPiY+0wq6BotefnQ0GQgJMVVsuGRRI+VDTUI0B
         a2JDz+XNw45ageegUDTJ2THxAElBYN+jXEHveN9nOW4JcKWWVdpJWGpDv/bJ5alF3gxE
         TkQKiCS5BRGV8dtLDJT557Kk8iIEKq5XWMwX2HVUcwkLvlb4yayjhwLm/PeCDdUgp3n0
         pueA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782858111; x=1783462911; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DR0tH2IO3fN80hPp68tJnACbZx0ZviQ8SFdx1MtberI=;
        b=lkvVsPIyidCRYacdQ7IESMRXvYQLKaA7ZMH1ryGL5itrlooIr80hcBpHlJ3dxLSAcu
         rGOZW44POgBTf9IoccGHKa0PJsZ/G3S1tSDqhduj4o13VkmKIiUR+4rxHgsKeiwgvSzJ
         TC4s+W5bL7WYSoFgebiUgpzBgedKCCmPwQ769lPyzm6rRPDujvVy5oLX6EaaN2PZLqxF
         6WNr52oQs9e1LQZoOVikGLTZZW84BX9n9xWGqTAD1KWUncTmadqepPoa8QKDhjBCLQaQ
         pq9JWIcylpYbRH6bPgG7n78WnVpPJwwrEJF8Mn2ZlYa2/BCPRvURWCfYl3AbgpexSXYu
         IPlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782858111; x=1783462911;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DR0tH2IO3fN80hPp68tJnACbZx0ZviQ8SFdx1MtberI=;
        b=DMl+OgHvwpJ2s8zLqzDsRRK2fZQCCBTVUtNvqAmnGOQAT6zKGhR/uSeFYnN7H3KNOS
         OrqdNpSbLzhbGUH2EgPaxDjB2AWkzUsoH7zTBb5TDS4qc2tMG8r/RzH7jBWPZIfap2h7
         FNz7sAuT04PHQ+GhWpYmKNzVdtYYGZZLugLG+/sDTXl5DXdz5QEc7tGQOAMsiiFzUbeb
         c68utO5P4G9LEt/qB97ir2UKWTWj3tSErRXFiw6mV2rzNc9zstv+DkJCoK5O8yBVEAUu
         v439JgdVR2Tasn4QBx4J7A8CW0YofCa9aI0itflFjwNEw4OLr5jNp2MDGAdyr9iNnPRv
         drVQ==
X-Forwarded-Encrypted: i=1; AFNElJ+idoxNwSKjzBDT86A/8Wo/nojRoo2VFCeat46Co7u5dOOoE27sDQX7iVChHlwL5bWIMU8mQw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yzed5dVt3RdJ5re1r20yCkdoaFsuOyBEgpG2ojQHk1PsLIeTygR
	UTUy84kFmfsLwR3WhPh/et7fbCerD5QGPw1fu7uB5XpX8B6JDNMBdJ4dffF+IBQFwTsFN4Hllvm
	o5UW0tB+d6MKTQAezBPlXtx7OmHJlB/JwSr7pF/9O
X-Gm-Gg: AfdE7cklKBeuWTAHKtWRWg9iOR1ZxPsoGm8TRKgQexdBHdPdWr8WA4Gv4LMN3P6K2bg
	hWDxgYfdFCbHUDnphk3/GzrGo6i7NujBSdN1fQn5jmvhTvKUJl7ZJr/2DlPJ55RXxbIIJ1pJOTt
	UY0vCuUsawRUuZ1kTE+GLfEZr0iuBzx44kRBpaFVtSOhAI2T3xZOetw1WpN+TifvKR4p5p5RPNf
	fgutoLQj1xwof8jI2csKb1NnsDW1Ch2O4MYQRHwTepAnPU4jXpwjSB/83Nq+BLFc7gQiyM0
X-Received: by 2002:a05:7022:923:b0:139:ed5d:5c9f with SMTP id
 a92af1059eb24-13b2a1c08bamr3407677c88.40.1782858109859; Tue, 30 Jun 2026
 15:21:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260522202410.3104264-1-dmatlack@google.com> <20260522202410.3104264-9-dmatlack@google.com>
 <aiXWmR-ettxin4LC@google.com> <aiaeOVomxQZhoM3K@google.com>
 <20260608181640.GO1962447@nvidia.com> <aigtS3UDdhUGp3m0@google.com> <aigyn66-xQ_9JBW6@google.com>
In-Reply-To: <aigyn66-xQ_9JBW6@google.com>
From: David Matlack <dmatlack@google.com>
Date: Tue, 30 Jun 2026 15:21:22 -0700
X-Gm-Features: AVVi8CdGaAQOsRR3GiQD5WoDqKgNzoVt-sa6rd2Hjmz3ldGohaSjMHvZ8NY85tg
Message-ID: <CALzav=d-JD6ZbUNEbRMQwnvOhCBJ3ruodr3wbHM=1WA++MCKCw@mail.gmail.com>
Subject: Re: [PATCH v6 08/12] PCI: liveupdate: Inherit ACS flags in incoming
 preserved devices
To: Pranjal Shrivastava <praan@google.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260630_152152_459384_8028D818 
X-CRM114-Status: GOOD (  25.07  )
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

On Tue, Jun 9, 2026 at 8:35=E2=80=AFAM Pranjal Shrivastava <praan@google.co=
m> wrote:
>
> On Tue, Jun 09, 2026 at 03:12:11PM +0000, Pranjal Shrivastava wrote:
> > On Mon, Jun 08, 2026 at 03:16:40PM -0300, Jason Gunthorpe wrote:
> > > On Mon, Jun 08, 2026 at 10:49:29AM +0000, Pranjal Shrivastava wrote:
> > >
> > > > My point was that a FW exploit can meddle with the bitfields of the
> > > > ACS_CTRL to spoof and mis-report the ACS flags.
> > >
> > > Devices can also ignore the ACS flags. I don't think this is an area
> > > where we should be worrying about devices being actively hostile.
> >
> > I'm wondering what happens if we preserve IOMMU groups across a kexec,
> > but a switch's ACS capability is dropped or the ACS_RR bit gets cleared=
?
> > The incoming kernel assumes that it's the same ACS cap from the old one
> >
> > Now, the incoming kernel restores the groups assuming they're still
> > isolated, but the hardware no longer enforces it, silently allowing DMA=
s
> > & breaking isolation?
>
> Again, to clarify, I'm aware that we aren't preserving IOMMU groups,
> the incoming kernel has to rebuild the groups. My concern is that if the
> ACS_RR bit is cleared during the kexec window, the produced grouping woul=
d
> be different than the old kernel. What happens if two devices on the
> same bridge were assigned to 2 different VMs?

In this patch the kernel reads PCI_ACS_CTRL after kexec to determine
the bridge's state and uses that information going forward. We don't
assume that if ACS_RR was set on the previous kernel then it is still
set now.

So if ACS_RR were cleared during kexec somehow, the new kernel would
see that and place those devices into the same group. Someitme after
that (I'm a little fuzzy on the iommufd restore path during Live
Update) the kernel would try and fail to restore the 2 devices into
separate domains because they are in the same group and thus the 2
different VMs would fail to come up.

Of course maybe ACS_RR can somehow get cleared after the kernel reads
it, but at that point the issue has nothing to do with Live Update.

So that's what would happen if ACS_RR ever got cleared during kexec
and seems reasonable to me?

