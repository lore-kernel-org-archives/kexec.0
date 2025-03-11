Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C10FBC28B30
	for <kexec@archiver.kernel.org>; Tue, 11 Mar 2025 12:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uMdqx5IAy5RwkV48z9EOvdZc6wlr4q4CS/HOkuwTfFI=; b=PFfjbdIGJpP/sr9Y6eq5rZ5aBd
	tYTasnRkksKpxXrgGyteMGdL9ZkKYt35FHl5iuTBQFPanPYzFG6AIny8Z9wnK7lEbZLSNViizegmO
	U4goTrD8ecOERlDAbPmfqqMVPAe58lGUdV0S+I8KMFpVec23dpIjg2vMLjgQlfCoZmUKzIdp4M3SK
	0f9ieWjsbfXO2GxF4izHC3bjxh6FeTs6OuwIKNzZl01X4nswafHf7Af7OupaZgVMYd9eBy/BvM9ER
	xGMPMEhCjxtc5bFE452XDyUhS5GFZHOxl+vk9hW7lYIkeQVT3SIY8F6D46VbAvmMXiWUeNACSCXj7
	t5l9m0Jg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tryln-00000005eem-0VvN;
	Tue, 11 Mar 2025 12:31:39 +0000
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tryZq-00000005bdV-06vL
	for kexec@lists.infradead.org;
	Tue, 11 Mar 2025 12:19:19 +0000
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-391324ef4a0so253256f8f.2
        for <kexec@lists.infradead.org>; Tue, 11 Mar 2025 05:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741695555; x=1742300355; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uMdqx5IAy5RwkV48z9EOvdZc6wlr4q4CS/HOkuwTfFI=;
        b=eFvZ6SbQIqLf5ydj0C6XA0fVQIvfUfGKHH5ZLizb+C7qyfbVaXwqIScT1+QQ+Aq2NF
         c/a9JjuJTJeenFE97ufivCHJJwT1NusqRrZLQ1qpyhB4hHRePUP2fuCUENNCb8sfTZXD
         m2VA44X2v1WDLeyDKNAApAHhtXWpeZ3H/9F47G25DnRMzuOos1CHbzi2UA+3iSA1pXmW
         Su2OFfumyxgFs3hKYCN16OsxSrCV1Mic1/q6vZJhyOH6AZ8eLqnlTgSI9e3JwKsyBZh9
         HkfQw0VU6Y3umd5sZ37zH7bGObO6IKzVRFxBpeMpkAm1699efJ0xOXZmpf+IeAfFsv8h
         os3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741695555; x=1742300355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uMdqx5IAy5RwkV48z9EOvdZc6wlr4q4CS/HOkuwTfFI=;
        b=hv+SRmbR/MiHzbTq4lOAuFIGA94rdWal+MYmN+BxK9bvbiv4ebZ0Sf8vN1ephV2fMJ
         W26ehSy+N+vDMNbMIO4WLp0sovO2oVLxKYWMWGJeT6WihkJ43sXchXlo8aB9nbogV5mo
         0rpSfKj1X3Xgdair0gjM+WZTE9qe1y6aPE5vGYrcjHgnDFlfJy6ZOTrBCZ3hvkmzHyfV
         Omqfe6nobNChwC+flr+TwwpN2OJpZYnYUKwcnyy6/g2Ygc71I4iE9NoMQ6VUkf058Y9Y
         gaz7cLvoB98K5JtnxRyc4H3nREgJ6ba4Ks6+zsyOVE3vgfS7wkiAATo8chEaEJgVOfwC
         9INA==
X-Forwarded-Encrypted: i=1; AJvYcCWhK6Ulux+DqPmMno7al4oJREj+jUDKgu3AK9Kn6xBmMfHzs/qssXzNCWPTANu5xwLhChI7hA==@lists.infradead.org
X-Gm-Message-State: AOJu0YwJRnMBRc4o59Xnu4qkEp4FZ6DeD6bYBdkFtYSVrL7D2KRh30pb
	WxCqK8h7/l5us6kNWnPTSQowVJMtJBmiNwTzuVwmJOMMoIPQMg2uF0CvUccnQsBB6abt7VzPkZI
	BL/hqafpdzfZP+ul1Wvpy19oX/bw=
X-Gm-Gg: ASbGnctPSHnnRZkr+bv3+RfspWsugh7BON3QPv3rL1EH2d5Qio1/aEuFOrODKbu1jWv
	CmvYQpS5IiAYuaf3SaGhinyl+18ECNZYSVHdeBLPXKdQxM6ASiwKqzFKRoF1sf9PaZKRwupfaY/
	Ne25WSMgfLbnBDEjmYpx2zEu92/OvBfgPyhs+feOZjEDZH0qni94lTmuvT
X-Google-Smtp-Source: AGHT+IGz6yyYStQwXScQVA2NmPU6agIBdpm9T+QAnp5+AsC3//dJ8lHkSh1/zt7aSeT4AfjpaJGHgRPiVMRftVNRVSw=
X-Received: by 2002:a5d:5f90:0:b0:38a:615c:8266 with SMTP id
 ffacd0b85a97d-3913bb2fac5mr4151795f8f.1.1741695555258; Tue, 11 Mar 2025
 05:19:15 -0700 (PDT)
MIME-Version: 1.0
References: <20250310120318.2124-1-arbn@yandex-team.com> <CAM_iQpWewprQzQgMWk0yMr=LCFUCGztJ4+G-NFt8gqe81XuUcg@mail.gmail.com>
In-Reply-To: <CAM_iQpWewprQzQgMWk0yMr=LCFUCGztJ4+G-NFt8gqe81XuUcg@mail.gmail.com>
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Date: Tue, 11 Mar 2025 13:19:02 +0100
X-Gm-Features: AQ5f1Jp-4WIS7zgwSRZD9fIZPznfBSfecmUex3m3QdtGpEpLMxmRqOA6DAx82aU
Message-ID: <CAPAsAGyOcyi1PLK_mjdf9STX4HOxNnBU8t3d20fSS3QO+znwNg@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] KSTATE: a mechanism to migrate some part of the
 kernel state across kexec
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Andrey Ryabinin <arbn@yandex-team.com>, linux-kernel@vger.kernel.org, 
	Alexander Graf <graf@amazon.com>, James Gowans <jgowans@amazon.com>, Mike Rapoport <rppt@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org, 
	Pratyush Yadav <ptyadav@amazon.de>, Jason Gunthorpe <jgg@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250311_051918_081287_CA0A538F 
X-CRM114-Status: GOOD (  23.81  )
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

On Tue, Mar 11, 2025 at 3:28=E2=80=AFAM Cong Wang <xiyou.wangcong@gmail.com=
> wrote:
>
> Hi Andrey,
>
> On Mon, Mar 10, 2025 at 5:04=E2=80=AFAM Andrey Ryabinin <arbn@yandex-team=
.com> wrote:
> >     Each driver/subsystem has to solve this problem in their own way.
> >     Also if we use fdt properties for individual fields, that might be =
wastefull
> >     in terms of used memory, as these properties use strings as keys.
> >
> >    While with KSTATE solves the same problem in more elegant way, with =
this:
> >         struct kstate_description a_state =3D {
> >                 .name =3D "a_struct",
> >                 .version_id =3D 1,
> >                 .id =3D KSTATE_TEST_ID,
> >                 .state_list =3D LIST_HEAD_INIT(test_state.state_list),
> >                 .fields =3D (const struct kstate_field[]) {
> >                         KSTATE_BASE_TYPE(i, struct a, int),
> >                         KSTATE_BASE_TYPE(s, struct a, char [10]),
> >                         KSTATE_POINTER(p_ulong, struct a),
> >                         KSTATE_PAGE(page, struct a),
> >                         KSTATE_END_OF_LIST()
> >                 },
> >         };
>
> Hmm, this still requires manual efforts to implement this, so potentially
> a lot of work given how many drivers we have in-tree.
>

We are not going to have every possible driver to be able to persist its st=
ate.
I think the main target is VFIO driver which also implies PCI/IOMMU.

Besides, we'll need to persist only some fields of the struct, not the
entire thing.
There is no way to automate such decisions, so there will be some
manual effort anyway.


> And those KSTATE_* stuffs look a lot similar to BTF:
> https://docs.kernel.org/bpf/btf.html
>
> So, any possibility to reuse BTF here?

Perhaps, but I don't see it right away. I'll think about it.

> Note, BTF is automatically generated by pahole, no manual effort is requi=
red.

Nothing will save us from manual efforts of what parts of data we want to s=
ave,
so there has to be some way to mark that data.
Also same C types may represent different kind of data, e.g.
we may have an address to some persistent data (in linear mapping)
stored as an 'unsigned long address'.
Because of KASLR we can't copy 'address' by value, we'll need to save
it as an offset from PAGE_OFFSET
and add PAGE_OFFSET of the new kernel on restore.

