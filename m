Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FDEBCAC59A
	for <kexec@archiver.kernel.org>; Sun, 21 Sep 2025 23:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lLMc7S+BvGFbDaO/gJECxMl9cCHViKZI7SeUZwZSwFM=; b=SX2AQ/3b5tLgno4h0nzaPWLKzZ
	Ocrka2Uaaw5fG8DoaooomsUIfSmEO3P57O1lpgaEFz95eCxEkRYCunFYd7grS5sSr84e8od0tZsRu
	6+4UnxycoXIkhg2ZWDcBG/HRM0A+I9lY9nXx/z/DgJIrWBNNAtZjXlc7ttH/Zm/XNYbhIIKXBB2b/
	9IDx3fGBhJf3EEPs68kc7Pc5FGOY6/xlHlJspJWeWiUMTdtpBSCycm3ho4sxJCO22uYWOcC5Q3kE3
	Sa5FkT7JpQUTlMkRzzJe3Pl/NJK/W+8brav7iiPWswE09JCFalDrRIfr+RbFb5KX2fhF5LJwV5nkq
	BHdBlaZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0T9j-00000008Nlh-3GtZ;
	Sun, 21 Sep 2025 23:07:43 +0000
Received: from mail-qt1-x82d.google.com ([2607:f8b0:4864:20::82d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0T9e-00000008Nkb-3ob9
	for kexec@lists.infradead.org;
	Sun, 21 Sep 2025 23:07:41 +0000
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-4b5d5b1bfa3so35250401cf.1
        for <kexec@lists.infradead.org>; Sun, 21 Sep 2025 16:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1758496058; x=1759100858; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lLMc7S+BvGFbDaO/gJECxMl9cCHViKZI7SeUZwZSwFM=;
        b=NlX87hajyAd8Es5v6B0LoPNBfi6FjINsPMPORDBDih2ZFDPhHHl2hvgA3mtTx1k0Xt
         GVfVR/+DfCneM9eT446fR3xfRUalgDmiRPuPbCrNUTyM7bSFc4DS89hLk/Vh5lYZuYtO
         K2nfsMApNTT4ubYrlQsXMpigA4jxLL/j91yU9E2uE5cfHnc7jbVwQElzJ/3M7NcyGXWs
         2R9xd35INDzsDvMbhEMR47U++PsEmvnkfpSx0pymmVOy6eBCV6jqJ0d/+bi6XjRUqQY/
         gj0DS96A5+zEQaeZ59nt0O5ir1NxioG5Pb0gFb37eirqsjL2yM4NEVovI83uENdU23Qj
         5t3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758496058; x=1759100858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lLMc7S+BvGFbDaO/gJECxMl9cCHViKZI7SeUZwZSwFM=;
        b=B+24itV2IG7nfyZEsH6RBrN+l8SjI3VkELIdP/GS+mC5PUV3H+VlbOwNYi9zFjpdVO
         yszUMvIXBsTej4McGKR5eU2NhjCarJ7XvOueRiZ8+sv6YAKG1+0u4aKKX+Y/Z90TohI2
         a6Qm5R68HF7T+YpwCPv+izj+7Jk94cH9NDNoN658IgWuBrsfUw/8Ux0Zfn+Dxdi64iwE
         YfvfIG9L1lD8/eUxjnWIYcS+Qv2p0eijD5iahlqZlVJDhXeEqKRDmYck2gecgVzcpW5Z
         HYfHqNtGtEZSdOKO+fR2wYIJSrH0LaxHX9hKwdWReeRejvnzm3KKSE26CtadQXs5CJ4/
         yKZg==
X-Forwarded-Encrypted: i=1; AJvYcCV2Ke0ksECk3+WV7oolHZ0XJKUKuqUJTTI8AkxlCFanoY20/VVj+399n6dkt3D2mRLX7uyYIA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx7Hu2yEZqOxUcd3TenenO/uv5hB8gGRdPGNQh2+DgcwJeiE2Kh
	1aZVH7EkCzBs1bo5LmQV68iQe/Bflyw7EbieAQsQMFdvUxYZQKWMSbxOThuXdabTy9Drg+DUcFe
	HcZmDiUpdT3p0RYn01eZ2AtJRn91mUOT/ntVPWjAwDQ==
X-Gm-Gg: ASbGnctTuWVmeBeCiVYPRPkMqQEt07omARzrCJuxbr7F9k2ZQFdRyJNRRNHHclHSchr
	paJMUO869fqDKr+ViK9/XGr1+pKSBrDleaev/nNOVAwL84vf25II6PleEQfnPGd6PdKztLXMFso
	2S/pVF5xOGLPTSeLZPeEc24ZgfsL3jesIMj7hXAqVGjF1xwkAiY7A6Hpr4A17ROshj0Ixg1p96t
	lyZ
X-Google-Smtp-Source: AGHT+IHmze5kshtpkjcVDTa3fEK5IBVKNtBZKjp0RsV9bU4OnWjNfFA7pSzx83Z/cbIj8bRK8EXOYxNjbrN+FqGjSUM=
X-Received: by 2002:a05:622a:198b:b0:4b5:e807:75bc with SMTP id
 d75a77b69052e-4c07623261amr138764581cf.80.1758496057664; Sun, 21 Sep 2025
 16:07:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250917025019.1585041-1-jasonmiu@google.com> <20250917113609.GB1086830@nvidia.com>
 <aNB7fTesaVCXHB0E@casper.infradead.org>
In-Reply-To: <aNB7fTesaVCXHB0E@casper.infradead.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Sun, 21 Sep 2025 19:07:01 -0400
X-Gm-Features: AS18NWARkb_6dtXKYB99s3afrmUWcnRiCwC7xnI9uhoqJ6HmAQbNH9XqJVlHJgw
Message-ID: <CA+CK2bDBU4Bb83tUyzdiTa+kjhKK7fvObzpqH1gOPwKqoOnO8Q@mail.gmail.com>
Subject: Re: [RFC v1 0/4] Make KHO Stateless
To: Matthew Wilcox <willy@infradead.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Jason Miu <jasonmiu@google.com>, 
	Alexander Graf <graf@amazon.com>, Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, 
	Changyuan Lyu <changyuanl@google.com>, David Matlack <dmatlack@google.com>, 
	David Rientjes <rientjes@google.com>, Joel Granados <joel.granados@kernel.org>, 
	Marcos Paulo de Souza <mpdesouza@suse.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	Mike Rapoport <rppt@kernel.org>, Petr Mladek <pmladek@suse.com>, 
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Steven Chen <chenste@linux.microsoft.com>, 
	Yan Zhao <yan.y.zhao@intel.com>, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250921_160738_955426_9DB953D7 
X-CRM114-Status: GOOD (  23.76  )
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

On Sun, Sep 21, 2025 at 6:26=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Wed, Sep 17, 2025 at 08:36:09AM -0300, Jason Gunthorpe wrote:
> > On Tue, Sep 16, 2025 at 07:50:15PM -0700, Jason Miu wrote:
> > > This series transitions KHO from an xarray-based metadata tracking
> > > system with serialization to using page table like data structures
> > > that can be passed directly to the next kernel.
> > >
> > > The key motivations for this change are to:
> > > - Eliminate the need for data serialization before kexec.
> > > - Remove the former KHO state machine by deprecating the finalize
> > >   and abort states.
> > > - Pass preservation metadata more directly to the next kernel via the=
 FDT.
> > >
> > > The new approach uses a per-order page table structure (kho_order_tab=
le,
> > > kho_page_table, kho_bitmap_table) to mark preserved pages. The physic=
al
> > > address of the root `kho_order_table` is passed in the FDT, allowing =
the
> > > next kernel to reconstruct the preserved memory map.
> >
> > It is not a "page table" structure, it is just a radix tree with bits
> > as the leaf.
>
> Sounds like the IDA data structure.  Maybe that API needs to be enhanced
> for this use case, but surely using the same data structure would be a
> good thing?

Normally, I would agree, but in this case, this has to be a simple
data structure that, in the long run, is going to be stable between
different kernel versions: the old and the next kernel must understand
it. Therefore, relying on any external data structure would require
the maintainers and other developers to be aware of this rather
unusual kernel requirement. So, I think it is much better to keep this
implementation private to KHO, whose only responsibility is reliably
passing memory pages from the old kernel to the next kernel.

