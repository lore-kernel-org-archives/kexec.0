Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BCE9FF8868
	for <kexec@archiver.kernel.org>; Mon, 27 Apr 2026 18:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wr02yN3/yZBXI2xon5jDCKdawxJYqqpUq3piVXy5yYI=; b=1eq0ijIMqWi7FuCVv+xn0gPlOu
	uZa+by6mXWOpozOL9uOkmk/d0TdLoZ3DCpZ02J+i+2XvP25Eqh4l/PSpQSQL4EAQuRp1e0jAIT0g+
	wV8wg+7AXGUT2owJbu0fxYxo3QsCHh4bhoDZyCE8HXdFtPqShJ3fpeuPl8MdAjP29dJ5XwD+v/ar7
	ZsgsbMIBqTkKRQZhXPdqbXWcSaGyaa88fmp+OA02VX9+iH5NFP9py8b1Wg4JUhsoo0C/lVCXNaxCU
	c0FM7IMJ2jburwpyS4zCnivWi+uPr4OmQ/27Aya7Bps8ikSKzYZpJ5sXSOcr362+mMzqx/F0GwGtl
	C320LbzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHR92-000000000Xb-1f88;
	Mon, 27 Apr 2026 18:57:24 +0000
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHR90-000000000Wz-3PWF
	for kexec@lists.infradead.org;
	Mon, 27 Apr 2026 18:57:23 +0000
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-38a01c80c34so103474291fa.0
        for <kexec@lists.infradead.org>; Mon, 27 Apr 2026 11:57:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777316239; cv=none;
        d=google.com; s=arc-20240605;
        b=hN5waqjcdjxeU5clJvUh4/bUYsqo16GSDnT0+1xF+WF1bVUitAzvtp+sKhCZ8EEUtq
         oi2UBNBGdm2pU+NN6PcA3ophaTQ7flE8IQpmfGXxP+gMSWs5KAR8KA4xw/7Iu/KQRDb7
         uZ5aWdK2AS2YMITpayuzsEIypHFDnqoYqWpNdTN0rCkUKedUXmoDTKMKigmc+HNNAEC+
         bepx6OkH/Pwt65eArKFlLJ0JaY89ISWN/PuSP6JKmAqTaDMtjJHx+s7Pz/Jcp1ugIcA0
         KxV5SvI9wdVTqo5hpwhxqEoYna3gUrxbolY9ZQ6Nf/vHbGrmSQDJy0IoXRHYlSWA0yhM
         QmMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wr02yN3/yZBXI2xon5jDCKdawxJYqqpUq3piVXy5yYI=;
        fh=l+fGTkKRbcQGQLsC2YTDIe6/NqzTPoxKT9s2LKQbGIw=;
        b=W/rLFKwR+MSydX5zSTDshdh4+3OASzmpzioCDrtBzLJlgCeNoTEjOpb1EMzvRLVpeR
         qbSdOPfcWn6T5emljn7/IN6AYdiCeT1LAK8Wqiw0VCS9WpZNTXMcSjw3nR+d7WfgoqVy
         0JXU/G0s6UT09vxRHs5yASjdMQ1ojgKQAgUIRLxPI9UBBnKZhSgAuq+8lsPPtvm55et7
         8EOCZ1H4w2aoL43H1Ja4itu/0htoOqratnDVASz4zEG23CDj8GEIeSyoI3Td+hiRG38t
         p+lJFtDveM4DaMk/hIKSPRMUvX3nxw6wgsdE5HuLPv/nhHmOYopJSA9yfzv0g2jEjlAO
         1vdg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777316239; x=1777921039; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wr02yN3/yZBXI2xon5jDCKdawxJYqqpUq3piVXy5yYI=;
        b=iecwnhyvEoNqoCKjQec/cVDMfmeeS9Sb31T5izSWsuS/tNk9uf6uqR33WX8qcjKMl5
         G6q1HKu2oEnQefw+ZawMAV89XQC7Cx9S0Q8+eFPReJ6nxNdhkUD2gJcM7xI1MHw3TDiR
         U7ADS4j0jkwHy3L1fw/3yWazf8qoJJXxhBBFEwveZjGYlW3BjTwqWjKu4r7sJszJ491P
         hHxiAZ2V3pEgkeuI+iJGcGdQBKFH5/knL/j4AQ3apyPW3WPqY3TvVPA7dvr0EPD4Uuqq
         MHJGeiheSnKAARfDZyTewh9mvixwMGziFN1FoavvzH8XW/Ld+nJFL67WMVA43IAKFD6b
         aYBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777316239; x=1777921039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wr02yN3/yZBXI2xon5jDCKdawxJYqqpUq3piVXy5yYI=;
        b=fagaOEhn7MYGtIS/qEE3AZyTPaDpAnB7BxdOGfpyNmwf3glsuWU0AZrMi1Sz1QP0Da
         PQMMvTJqjRccFUaZbiVEvTfqLpd/qTs0hEf994hAVDcvNSJMoc1THBh78ovz6l2a08Sb
         MH6RuTEbv8Po9oCheOTSRSpORYT/+qmqDvXx+ZAWVOqOMImwoJz0F4Lyhq4/t9fL1eTU
         +PWdznQVH63XtcwE4vI4OuVdLsfDrfVSJsZ04m4JNtoR9dFjAoTkMUBuZq1n1ubQEL+H
         MKROJCgFZkb6UyvFE7Qd49R07suClyfE0LiTod0bEqjGudcZM6++OKWg8KJKLPXNawD/
         GCPA==
X-Forwarded-Encrypted: i=1; AFNElJ81KPf4zXqFBElZMAw0flhHwDM7ibcpIIhN2IIfrGC+uUuf7mkYgZmE+XG2d028bhJ7mi18Yw==@lists.infradead.org
X-Gm-Message-State: AOJu0YyaBL1ih/0uBsv/tgHeclq/cOT5tjHdiMyjEF0sLZjM+0RYVIPf
	op5hZfHG7fx2fOTSx8hfwUPEn5S9bK5pACVyukv3y669coJLx8+04x3MPCWzrbsybAiFb8zGAts
	eGTpS82bIfY3+ZvgfUUOGACwAAD8vZ1VOm+d9gnHfAk0ita85SW54znO3
X-Gm-Gg: AeBDietZ+RT+6UfeoKHf3zQMqnRtC0tHJzcO62VAS8hkRW0cACYgB1mymYxS6U7DtV9
	mDeWHbMuzoBrvTDNEY9U076FZMPUNrKHUmWfYcDrv0is6NHYYLbZHcHz1BlWa9LlEmLm1+FIEaB
	gGgqYL09g/x16WODxdfWtUKNNVbQDTbv85m37ak278Wh5WLgIwjyiBGZfOb9GnQ6+XqNPa0LIIH
	e0kSW1FQ2Lbsah1SY1n/YNfTQssm/TfVrMURNv276omOBb64M13Xs9nR0n/nB4LAhUbwhL0m6bl
	+7tp3XYMCw0JSzQrowcqSsUb52vhWg==
X-Received: by 2002:a05:6512:3c98:b0:5a4:b18:427e with SMTP id
 2adb3069b0e04-5a7466047eemr34628e87.1.1777316239065; Mon, 27 Apr 2026
 11:57:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260423212316.3431746-1-dmatlack@google.com> <20260423212316.3431746-3-dmatlack@google.com>
 <20260427085725.00005283@linux.microsoft.com>
In-Reply-To: <20260427085725.00005283@linux.microsoft.com>
From: David Matlack <dmatlack@google.com>
Date: Mon, 27 Apr 2026 11:56:51 -0700
X-Gm-Features: AVHnY4IwEsFxMBzAHVS8KxW2Zq56dU7ADRcx7gdZfScIG7qn-IMwc1DMcXI8nOc
Message-ID: <CALzav=di-fMMPgTEzfWagRgXCWox9CB4XiRhZcVAzc3dUzzfHg@mail.gmail.com>
Subject: Re: [PATCH v4 02/11] PCI: liveupdate: Track outgoing preserved PCI devices
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: iommu@lists.linux.dev, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Alexander Graf <graf@amazon.com>, Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Chris Li <chrisl@kernel.org>, David Rientjes <rientjes@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Hilke <jrhilke@google.com>, Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, 
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Will Deacon <will@kernel.org>, 
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260427_115722_871823_A1CAF9B6 
X-CRM114-Status: UNSURE (   9.91  )
X-CRM114-Notice: Please train this message.
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

On Mon, Apr 27, 2026 at 8:57=E2=80=AFAM Jacob Pan <jacob.pan@linux.microsof=
t.com> wrote:

> > +int pci_liveupdate_preserve(struct pci_dev *dev)
> > +{
> > +     struct pci_ser *ser;
> > +     int i, ret;
> > +
> > +     guard(mutex)(&pci_flb_outgoing_lock);
> > +
> > +     ret =3D liveupdate_flb_get_outgoing(&pci_liveupdate_flb, (void
> > **)&ser);
> > +     if (ret)
> > +             return ret;
> > +
> > +     if (!ser)
> > +             return -ENOENT;
> > +
> > +     if (dev->is_virtfn)
> > +             return -EINVAL;
> This can be left outside the mutex?

Yes indeed. I will move it out in v5. Thanks!

