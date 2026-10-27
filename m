Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE27606A31F
	for <kexec@archiver.kernel.org>; Tue, 27 Oct 2026 17:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=O48tRC0f;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZTglpC/5
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=75xnGPQfUpxl4aF5uqa7AQlJeR6+8S5bvRDT/N741Fo=; b=O48tRC0fenbhTD
	imlJ+VXxVti5woqZeg0hZDmkGRNMikJW9zWKwjqeikwXOwZGxaFjTUzABTLAynx7i1sFOTCwXQalS
	Hd2Em5W5pYXb5Qpr4nbXLRAIV/GvG7dOP+jOo6sNqYzxqI3on87hrcurOBrSfHVSa9nod5QZHOONd
	5h1rS7l4uYKhNUBRZnhQfx0ts/4wjz8h51AznENQNYrnMYJzD2+JlszFUZVD0LiOcYbtLwDRY5ArD
	OAlxlH37X7luVxvjCC5bMiquPXpX4lbDJeNNRVwjNlPC5u4gNMkaqweHSkES5HjJ8XoOTWvUiSgAd
	n/o5nAI4e2tjQdaaf6gw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLl81-00000005TpF-3LgY;
	Tue, 27 Oct 2026 17:38:29 +0000
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLl7y-00000005ToV-20IY
	for kexec@lists.infradead.org;
	Tue, 27 Oct 2026 17:38:28 +0000
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-c4322d310e7so12734266b.0
        for <kexec@lists.infradead.org>; Tue, 27 Oct 2026 10:38:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793122704; cv=none;
        d=google.com; s=arc-20260327;
        b=jPkD/WOlQJuhdsghgJpYgzHTtgD1O9rIjhW+QWpKuJlt+34auRhSaSuetg4Q9Rz8Fk
         vI+IDN2xhwFI0FuqQ/IZWjt1TCrnuJm2AH8+uJy6fuaFjdxxfngnnD8xyQeajZR6dnfU
         YSePp4/XKcFkth5vgZ+NzvEubzxGFa5g8XT1+xtcv7OH62mfVbMHllxi/gkrHuWoZmCx
         SBxPmWu5LTg+w1xc7SMmlt5m6P0JIpDIX7c83bJulH4jrNt+NFKkx1SmmZv1pWUDPvJ0
         4PjlBxEePYTwAkLJEIqfKRxevGpbrUgnK31SuvXK8FziRXpb70lms/523oMpMVZlrWpk
         RfGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=75xnGPQfUpxl4aF5uqa7AQlJeR6+8S5bvRDT/N741Fo=;
        fh=rdjy7wY1oEKlk9G1B4E9x8jtSouXkHSKf4o/dGsi8XE=;
        b=Ub26aOrIPbJEZIFDIcuqjLg2eCFjovG0t4g9C4eLBExiLkBobuoznVLuW71vAk08j2
         uBk7BrozEyILXctcn4vtHdUx3hACg+dzQ8wlKMDxb9+j4TjUaZFAREi6rnxYJuSXEiom
         6ERMYicJTsJZlXXt0aBu3w58HMQ+IPQC1492v9A3P7duRsuzT1zTyYWb+vJ62PL+3xig
         Pc7FCv80q2PlgICskJ+Bly9NO11VCA4gBNEGzFpWNZjDu7bVMOt+vzm9GKDkWC2HrC/k
         8+tVbjjWEHoT4YL/AYXXr9Oo8R3GnoTMiHn7/WZonqhFj+VTwLENnXboUdLlnHZP9iBv
         VE0Q==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793122704; x=1793727504; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=75xnGPQfUpxl4aF5uqa7AQlJeR6+8S5bvRDT/N741Fo=;
        b=ZTglpC/5+Mj/LMpEu5lrM7ARVq/dpB5Pr1zVWgY8yv1XHp2vfK6BH4e88C6t1TXx0A
         xDeycSBvY8a9oOjYfigQBOccz0GxTMSzu5BJhLo3joR7BBA2P4mbclXqeddo1e/W9/t2
         9GA/mC4OiUIdFIhTHR/RVFVJVfZWRFiO6nHZf7BlENaLrK3aRwfcdfiiUOTTEya5HQ0n
         yOFe5yZ1UwcJH+w4WKp8mH6C36bB4oWJB4KabSCzr5vfwjHZ8XD8j94G2ByyGhI0j5YZ
         G4R0FkeLloDLYAG3IIZ89GsofjMO74hc+3m9+OgJLmrFAs3hy5dVOm9yPfSpoN6S+dlj
         voMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793122704; x=1793727504;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=75xnGPQfUpxl4aF5uqa7AQlJeR6+8S5bvRDT/N741Fo=;
        b=PjA7LbPXRrledKANzvzw5aIvkBn0kGByNLukr/BZ8CBZhjTKODKbMJbTGY43l/8e1L
         um9/GLSupN4c2N4keKJ0koy+5SBHVbJBLEfKrUfV8jf/K6JZ3bD3JCuMDe0yK6S1AuWD
         UrOl5eLIguL91mCpchzsHgwONjdIbGNz9TIWynvXJxcQZo9/kJfPH/Fla97KwiYmpkRQ
         hvTNdLrncLdVMN1DBqR5fsemDeAmGYGVzdPp2lZ2EeqcmrYgZg6W6bBO9D4DijUh5wJO
         /4NRKndDHJB/t2hgy6Dhfd7go0s6c9Re6cs0PtqYybd6e/+D39hlH+GoKXdmM/I+3E/5
         tIyQ==
X-Forwarded-Encrypted: i=1; AKwUvBwzEdD3q7rupREuZYy0zlvT/OK4dmul0/3D24FXUga14E1nkBSFGulfmiM0gtavA68vm4Hl2Q==@lists.infradead.org
X-Gm-Message-State: AFq9FYJ7HzgcDghvTgsazmN/Zd3mPkf+FssgWZMJqTBYiJK3v3NvyVBM
	qVzq4jIarOJrzidif7LqxCJxZ1JkERMBQFnuLfquTJE+MdNrRjePE4Rotn9CtirYZX7gp5qKnUz
	7GR6T+dANtWMXt+J/dttLT8fxAz8jRBssTnzQf1Px
X-Gm-Gg: AYBFou0lGbiKkZwV71MJb3/pdtby4bLXnIRrVZ+aWfN2JSxR0KoRSQ5GKSy3/uHAGkR
	4bYHh0szJpVZLwk6slLvBxRimUHHhmTcRbfIPhNfdxwcK+TLKZp3x0vhUwXiaXPNrJuRpuDZMv/
	QWdp5/lqsNsM2UJIqOWL6v+CscUxj5tAhRQ7dyIXIrQkP93JYgEB9zjSgFl8maQJju7pAye6bMd
	FUAqTH+smSex8rLMTKhW5ngIeY2cfqhkdE7DBpeFMAsuqqQP1JiLPfnaq07AUQSCbt+4KOEddyS
	xTJMjthUfGR/SlJDgLAj19wKEi/dvVtknkI+rNndtyIPIUWgbBBfo0+hKJLPkdPDsYPI8qVhBLw
	JZe8ZGMfDzqDp7bAn8jIYlXS4XMZsxl3ewOa8Dg==
X-Received: by 2002:a17:907:d308:b0:c2e:378c:8ce3 with SMTP id
 a640c23a62f3a-c46bde8c44fmr1091193766b.32.1793122703439; Tue, 27 Oct 2026
 10:38:23 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261021152527.375070-1-tarunsahu@google.com> <20261021152527.375070-4-tarunsahu@google.com>
 <atlQ_Er0Ig7CCSxv@google.com> <CALzav=f00C4yOAseNunW8GgQTDUGWT927Qy=TLm-3-J0TEDH8Q@mail.gmail.com>
 <9huzzew0el59.fsf@tarunix.c.googlers.com> <at_CncIPYCxOVkLo@google.com> <auDT5MjXYq3lcQjE@google.com>
In-Reply-To: <auDT5MjXYq3lcQjE@google.com>
From: David Matlack <dmatlack@google.com>
Date: Tue, 27 Oct 2026 10:37:56 -0700
X-Gm-Features: AclHuK9nhZy1yfbGSOSB3h6FsOr-7RUqfg5DsC4iepC4uLqRp9MK3EAsOEkjOYw
Message-ID: <CALzav=dYKAP7pKfoPtz32X1cT_tH4LN0X47_jTO8_HOCT4Pi=w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/4] liveupdate: Replace compatibility string with
 a 2-bit pair feature header
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: tarunsahu@google.com, Andrew Morton <akpm@linux-foundation.org>, joro@8bytes.org, 
	Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, maz@kernel.org, arnd@arndb.de, 
	jgg@nvidia.com, robin.murphy@arm.com, loganodell@google.com, 
	oupton@kernel.org, kevin.tian@intel.com, alex@shazbot.org, 
	dwmw2@infradead.org, pbonzini@redhat.com, seanjc@google.com, will@kernel.org, 
	Alexander Graf <graf@amazon.com>, Bjorn Helgaas <bhelgaas@google.com>, baolu.lu@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, 
	sagis@google.com, linux-mm@kvack.org, kvmarm@lists.linux.dev, 
	iommu@lists.linux.dev, linux-pci@vger.kernel.org, kexec@lists.infradead.org, 
	skhawaja@google.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261027_103826_815526_DDF22915 
X-CRM114-Status: GOOD (  34.85  )
X-Spam-Score: -17.6 (-----------------)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 27, 2026 at 9:40=E2=80=AFAM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> On 10-26 21:14, David Matlack wrote:
> > On 2026-10-26 11:50 AM, tarunsahu@google.com wrote:
> > > Right, Required bit should be source kernel payload property to tell
> > > target kernel that the payload must be handled to correctly deseriali=
ze
> > > the data. It should be source kernel (userspace) responsiblity to mak=
e
> > > sure it understand the target kernel before doing liveupdate.
> > >
> > > Saying this, During deserialization, target kernel's required bit is =
not
> > > necessary. So I propose the following truth table.
> > >
> > > Source hdr  Target supported[i]  Action
> > > ----------  -------------------  ----------------------------------
> > > 00          0 or 1               Accept: feature absent in payload
> > > 01          0                    Accept: ignore the feature data
> > > 01          1                    Accept: use the feature data
> > > 11          0                    Reject: -EOPNOTSUPP
> > > 11          1                    Accept: use the feature data
> > > 10          0 or 1               Reject: -EINVAL (invalid encoding)
> >
> > Yes, this matches what I had in mind for the semantics.
> >
> > To be explicit: the source kernel should set the bits for each Live
> > Update based on what is actually preserved, rather than generating the
> > header from a static per-kernel array. E.g. memfd would only mark a
> > feature present for memfds that actually use it. That's what allows
> > rollback to an older kernel as long as nothing being preserved depends
> > on the new feature.
> >
> > But looking at this again, I think the required bit is redundant. Wheth=
er
> > a feature can be safely ignored is a property of the feature itself, no=
t
> > of any particular file. Every file that has a feature present will have
> > the same required bit for it. The only thing that actually varies per
> > file is whether the feature is present.
> >
> > The required bit still has to be conveyed to the target somehow, since
> > the kernel that needs it is the one that doesn't know about the feature=
.
> > But it can be conveyed by the feature's number rather than an extra bit=
:
> > split the flag space into required features and optional features, and
> > assign each feature to one of them when it is defined. This is similar
> > to the required_flags and optional_flags approach in struct pci_ser [1]=
.
> >
> > Keeping the same header shape as discussed with Pasha:
> >
> > struct kho_ser_hdr {
> >     __u32 size;           /* Size of header + payload in bytes */
> >     __u16 nr_required;    /* Number of required feature bits */
> >     __u16 nr_optional;    /* Number of optional feature bits */
> >     __u64 flags[];        /* Required bits, followed by optional bits *=
/
> > };
> >
> > Required feature N is bit N of flags[], and optional feature N is bit
> > nr_required + N (using nr_required from the incoming header). The lengt=
h
> > of flags[] is DIV_ROUND_UP(nr_required + nr_optional, 64). Both spaces
> > are numbered contiguously, so there are no gaps, and up to 64 features
> > still fit in a 16-byte header.
> >
> > Each bit just means the feature is present, so the truth table becomes:
> >
> > Source bit       Target supports  Action
> > ---------------  ---------------  ------------------------------
> > Not set          -                Accept: feature absent
> > Optional set     No               Accept: ignore the feature data
> > Optional set     Yes              Accept: use the feature data
> > Required set     No               Reject: -EOPNOTSUPP
> > Required set     Yes              Accept: use the feature data
> >
>
> I like this proposal. I bet most features are going to be either
> optional or required, and even if we ever have a magical
> sometimes-optional feature, it can have its own required flag. So, no
> need to pay double the cost on every flag.
>
> Just need to make sure that optional features always start from 0, in
> their own enum, so the offset can be computed correctly in the incoming
> kernel.

Right. Instead of having a single 32-bit feature space where every
feature can either be optional or required, we have 2 16-bit feature
spaces, one for required features and one for optional features. Both
feature spaces span from 0 to 2^16-1, and then are packed into
flags[].

