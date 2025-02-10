Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFF5FC0219D
	for <kexec@archiver.kernel.org>; Mon, 10 Feb 2025 22:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Wl/1DFtCVA8JUg3JrvOVSDvXuYWKhgnuN/JPe0OCyKE=; b=Pjne0y+ELSYJqyTOFxfjWX/W5b
	1P7X0Wla4kIwPyLmCgz5Rg1G53Mza5roRx7bVPVg8+wUYYKTfmzNDkbmmh9mUR4qSwJSaI8t87ss1
	RRYl1oXBVT5EgqET1lodcQoU4WNgHUuAvT1KdZB2kb4qmJ1l2pMnGbEMpGA18lZ6ybDRyRLqBy3Hh
	rDIooB/qe1JCMGSXioZJ0EAheN6tUA0JTR5KnA+pBgKGdB4sojTE1qJBfUYGy0CNWNOOPNWU4szUY
	RhJs2rUK9a0FixD2rYEyCdW2JQ89uyZ3iyINpKAMGvgL4P2iZH6FSvu6C6weDiQDI4uG5scZqCGnO
	NWU9oFQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1thbzM-00000001bUM-3Sud;
	Mon, 10 Feb 2025 22:10:48 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tharf-00000001QSl-2NuG
	for kexec@bombadil.infradead.org;
	Mon, 10 Feb 2025 20:58:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=Wl/1DFtCVA8JUg3JrvOVSDvXuYWKhgnuN/JPe0OCyKE=; b=F3/q+DDHi9INeM+siW3NvYKHhu
	xgkZawcO5o3lfANZpL6eQRifpMTOeEEzqPidchM53jZNLYJpaSpDlsAvzT8/mTODv9e8viQT8wulH
	uZO4GAHc+9LkmQEi0YEXLwPN3MdPOqlsWgtAVZfEcPgQQw7870X0XUMQ+0LB0e5PlKPXL697X/ZtC
	OWxMv5jVy73BlA8FjjUue9RYL+7TcaMkTM3jbj/6uT/9eaPBdyWZ/K8tD8KoJaYAuCZoMvkOnAdw3
	0olSwRgxZgVvfYy3CGo9QPKp5YjF//TfOWg4xZr2aBkiDZNr6W91nWF3Ebm2nMVdYGciOh1AuLc04
	XzIhwSIg==;
Received: from mail-qt1-x836.google.com ([2607:f8b0:4864:20::836])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tharb-00000000GDd-0RAH
	for kexec@lists.infradead.org;
	Mon, 10 Feb 2025 20:58:46 +0000
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-4718b128eafso6680811cf.3
        for <kexec@lists.infradead.org>; Mon, 10 Feb 2025 12:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1739221118; x=1739825918; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wl/1DFtCVA8JUg3JrvOVSDvXuYWKhgnuN/JPe0OCyKE=;
        b=a3LACJo6zc02gFP/8v2wgcnIHrOlkTSMxlsB+AisYfXlbe/LNc0p29gS0hMRMW1UmV
         uqgvE7D3gIKMsD4AiP4UxZqSFCa97kVH4NG25w0/6I+1NUD+6V1ednv+WM+UIfLzmQfx
         b5CnywVvgZM6gcZPcdfVZ2xJSFOXjiXBTusuA5X4Q/pVh4M2xbD/f3FAaZZMu1tTYItF
         h95QWKbPx1d/n3s8CHUSb5pu4AB5MWSg6yLvElzQL+xN3WHaqhS2hUpueEvTBTdDVanO
         WFs5s0LttU96nzu4I696pVVCHBiIZm889aG0cq/ywHy+PFZB5q0ssGKDLLyHzxNsjvkq
         wP+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739221118; x=1739825918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wl/1DFtCVA8JUg3JrvOVSDvXuYWKhgnuN/JPe0OCyKE=;
        b=Y2w1QkeSRx/7y2dHNMPOqEsd9G+w3DrwHYihUnLSjpDeRkc/pA/WIC+7NjomaGXA+Q
         HoyGxeBVrWT3e0mbq52gDK5ugvrZXoZ5KoiFOV1Jn8TiC2E2go0aTHGcylcQni6x9sQD
         wFk0UXXA1LEfJKX48DAoNJWWbW7vUdycwS+d1NDpcu+Jh7EuqivzYPsL1IFiMB1RsuKZ
         wqZunJZuHPaO24chyYfoWGbANU77pH7sD4/CJ4buSYQrHSCfwNl+C2a4brw3uV3JyzsQ
         YYCt89d60+v0EFWims331jqRJl/7Ddsgm8GMk15sBS1Lw1xaIlHIUsGFYccRU22v/uaX
         0qxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVkzHL2PWU01ep4vDD5AT9L7WiQLSdDIpo151Orzo6uWzQpDnYq5gcKshTu5LaMCFvvq/w9Q==@lists.infradead.org
X-Gm-Message-State: AOJu0Yzxpw6dRyzh3/dbnvdbNC8/ksRsVK1Hg2QhPjy6cBsiJYdpays5
	cPwtSvlP6247gU/gOSDEQ/Doxlmgqn0ldc9EKBbR4XsmYXxZQ0fKb9jTFizo9WeMX2sbW9+DdBr
	lLFX4oj7EXcBCzhmuQhiQjSsEafz/yTFpvOiS+g==
X-Gm-Gg: ASbGncv2wwQWr7AurEzDmaEAg7t3f1QS3JXtlFcAErHaB35fAlVP4NcSwHA7qpu6ZiP
	JUQOUUxTsFqv+7IzJzRiYqrpmcNDoq0bQr9cUbUj/Cjdrj6P82Pjs1oGvQXO0WfnSWVilPQ==
X-Google-Smtp-Source: AGHT+IETHCKadrtvKNJ7fIHLak3uf8ALu7tDsyEEqgrBMvB7GxxInEvWUg2pBVKBZMO1RROtaHb319Yhs3eTr5CpbD4=
X-Received: by 2002:a05:622a:1a05:b0:46c:86d8:fc5 with SMTP id
 d75a77b69052e-471679cb76emr238937621cf.5.1739221117601; Mon, 10 Feb 2025
 12:58:37 -0800 (PST)
MIME-Version: 1.0
References: <20250206132754.2596694-1-rppt@kernel.org> <20250206132754.2596694-6-rppt@kernel.org>
 <20250210202220.GC3765641@nvidia.com>
In-Reply-To: <20250210202220.GC3765641@nvidia.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 10 Feb 2025 15:58:00 -0500
X-Gm-Features: AWEUYZnfXstpOnVhbWRWzg5zc_KYEQnAl1ReknkHBBoTgx3FQhtVYh2voma8nHI
Message-ID: <CA+CK2bBBX+HgD0HLj-AyTScM59F2wXq11BEPgejPMHoEwqj+_Q@mail.gmail.com>
Subject: Re: [PATCH v4 05/14] kexec: Add Kexec HandOver (KHO) generation helpers
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org, 
	Alexander Graf <graf@amazon.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Andy Lutomirski <luto@kernel.org>, Anthony Yznaga <anthony.yznaga@oracle.com>, 
	Arnd Bergmann <arnd@arndb.de>, Ashish Kalra <ashish.kalra@amd.com>, 
	Benjamin Herrenschmidt <benh@kernel.crashing.org>, Borislav Petkov <bp@alien8.de>, 
	Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	David Woodhouse <dwmw2@infradead.org>, Eric Biederman <ebiederm@xmission.com>, 
	Ingo Molnar <mingo@redhat.com>, James Gowans <jgowans@amazon.com>, Jonathan Corbet <corbet@lwn.net>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Peter Zijlstra <peterz@infradead.org>, Pratyush Yadav <ptyadav@amazon.de>, 
	Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, 
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Usama Arif <usama.arif@bytedance.com>, Will Deacon <will@kernel.org>, devicetree@vger.kernel.org, 
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250210_205843_338006_C46235D6 
X-CRM114-Status: GOOD (  43.25  )
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

On Mon, Feb 10, 2025 at 3:22=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Thu, Feb 06, 2025 at 03:27:45PM +0200, Mike Rapoport wrote:
> > diff --git a/Documentation/ABI/testing/sysfs-kernel-kho b/Documentation=
/ABI/testing/sysfs-kernel-kho
> > new file mode 100644
> > index 000000000000..f13b252bc303
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-kernel-kho
> > @@ -0,0 +1,53 @@
> > +What:                /sys/kernel/kho/active
> > +Date:                December 2023
> > +Contact:     Alexander Graf <graf@amazon.com>
> > +Description:
> > +             Kexec HandOver (KHO) allows Linux to transition the state=
 of
> > +             compatible drivers into the next kexec'ed kernel. To do s=
o,
> > +             device drivers will serialize their current state into a =
DT.
> > +             While the state is serialized, they are unable to perform
> > +             any modifications to state that was serialized, such as
> > +             handed over memory allocations.
> > +
> > +             When this file contains "1", the system is in the transit=
ion
> > +             state. When contains "0", it is not. To switch between th=
e
> > +             two states, echo the respective number into this file.
>
> I don't think this is a great interface for the actual state machine..

In our next proposal we are going to remove this "activate" phase.

>
> > +What:                /sys/kernel/kho/dt_max
> > +Date:                December 2023
> > +Contact:     Alexander Graf <graf@amazon.com>
> > +Description:
> > +             KHO needs to allocate a buffer for the DT that gets
> > +             generated before it knows the final size. By default, it
> > +             will allocate 10 MiB for it. You can write to this file
> > +             to modify the size of that allocation.
>
> Seems gross, why can't it use a non-contiguous page list to generate
> the FDT? :\

We will consider some of these ideas in the future version. I like the
idea of using preserved memory to carry sparse KHO tree: i.e FDT over
sparse memory, maybe use the anchor page to describe how it should be
vmapped into a virtually contiguous tree in the next kernel?

>
> See below for a suggestion..
>
> > +static int kho_serialize(void)
> > +{
> > +     void *fdt =3D NULL;
> > +     int err =3D -ENOMEM;
> > +
> > +     fdt =3D kvmalloc(kho_out.dt_max, GFP_KERNEL);
> > +     if (!fdt)
> > +             goto out;
> > +
> > +     if (fdt_create(fdt, kho_out.dt_max)) {
> > +             err =3D -EINVAL;
> > +             goto out;
> > +     }
> > +
> > +     err =3D fdt_finish_reservemap(fdt);
> > +     if (err)
> > +             goto out;
> > +
> > +     err =3D fdt_begin_node(fdt, "");
> > +     if (err)
> > +             goto out;
> > +
> > +     err =3D fdt_property_string(fdt, "compatible", "kho-v1");
> > +     if (err)
> > +             goto out;
> > +
> > +     /* Loop through all kho dump functions */
> > +     err =3D blocking_notifier_call_chain(&kho_out.chain_head, KEXEC_K=
HO_DUMP, fdt);
> > +     err =3D notifier_to_errno(err);
>
> I don't see this really working long term. I think we'd like each
> component to be able to serialize at its own pace under userspace
> control.
>
> This design requires that the whole thing be wrapped in a notifier
> callback just so we can make use of the fdt APIs.
>
> It seems like a poor fit me.
>
> IMHO if you want to keep using FDT I suggest that each serializing
> component (ie driver, ftrace whatever) allocate its own FDT fragment
> from scratch and the main KHO one just link to the memories that holds
> those fragements.
>
> Ie the driver experience would be more like
>
>  kho =3D kho_start_storage("my_compatible_string,v1", some_kind_of_instan=
ce_key);
>
>  fdt...(kho->fdt..)
>
>  kho_finish_storage(kho);
>
> Where this ends up creating a stand alone FDT fragment:
>
> /dts-v1/;
> / {
>   compatible =3D "linux-kho,my_compatible_string,v1";
>   instance =3D some_kind_of_instance_key;
>   key-value-1 =3D <..>;
>   key-value-1 =3D <..>;
> };
>
> And then kho_finish_storage() would remember the phys/length until the
> kexec fdt is produced as the very last step.
>
> This way we could do things like fdbox an iommufd and create the above
> FDT fragment completely seperately from any notifier chain and,
> crucially, disconnected from the fdt_create() for the kexec payload.
>
> Further, if you split things like this (it will waste some small
> amount of memory) you can probably get to a point where no single FDT
> is more than 4k. That looks like it would simplify/robustify alot of
> stuff?
>
> Jason
>

