Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB106606A325
	for <kexec@archiver.kernel.org>; Tue, 27 Oct 2026 00:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Curo7mWB;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=trssUPbI
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=0rDUgYp8MSkkxbz0QJpm44/zZryJwi/MN1DJH+bVzxg=; b=Curo7mWBKbKGLB
	6iuI4pTA7ovmOh9QlayOCbZd+agX51n2+7KozWoru3SDOMpCc4OacJu9lxN1OuxsY3+mcGXFrMqnf
	CnMVMO19KLA/eU2ZkzyLCSYcLim06WbwS/TZXrwXb8QNSsfeXNVhxWAhOxZKsGeH+kYiglrchJPfh
	aH7CtUFKrCiu+bsjYYgiOtXYJEmAdrGDkbpenl5GqPzi5JxZ+xvIC2+lW2OSIZZI8NoSo2PiATCBf
	ehRx76KSv9Z8iYk8GkdvM63h2DGsd7DbNX18EWAE2d0caCoYPlIHJA4hc9pdGfhpzORtZrPc5P7GE
	6i1X9zhEnPLw+rae3U8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLVTi-00000003YxM-3Bm9;
	Tue, 27 Oct 2026 00:55:50 +0000
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLVTg-00000003YwH-0aqz
	for kexec@lists.infradead.org;
	Tue, 27 Oct 2026 00:55:49 +0000
Received: by mail-yx1-xb132.google.com with SMTP id 956f58d0204a3-6798eb0d13fso3816253d50.0
        for <kexec@lists.infradead.org>; Mon, 26 Oct 2026 17:55:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793062546; cv=none;
        d=google.com; s=arc-20260327;
        b=big2KaYl7G44RmzXd9f2tO685x+J4NBthzuFF/+drkzdWQy3tnhSwb01SowPv9+aCP
         4jyjfIRKL2ULaqXknXYUjeQNJ+1finqHSLzHpsRtPwn22iAVQVTuhiqskpWDDwzMLbIR
         LLBWs3R38RBwFznj7hThlJeQPdpeHeu9KnFp+j97/Tbka/Ew5kEK5cCFBE2Y+EY6alb5
         VhXlxdKKt1Sqv+cRnjvvE1IoG//V7jF9Rj7tIAbPCQdUaP1t24FRCmz5BGUMxCXFBocP
         o5fZhvhgQXYio66/v5H41/ixF9oemAei6BRYKTv+XEeq3x9/nDA/0kuoWsbJtWKrPgLx
         GGYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0rDUgYp8MSkkxbz0QJpm44/zZryJwi/MN1DJH+bVzxg=;
        fh=NFC/jmd3EUiO6DiC+/7EHqIGlnceuR3KuWwbLh9KPvo=;
        b=lhVpF6kjxjCeiZdRISPdw2ocL6XlRp8p+pPfoiJ64uIX3RJtDjB5gMUl8o/mnA6zFQ
         zbflLnIMILGrcv09QdX1waaGxCFr4lGYmf5VY5LYXusW/GMfF8T8GWFpxowEoyF6nnPN
         LKGuXxpsjBIzL4sqIrWKUbPgR3u2tpWXA2WJ4d3e4n9b+qbXJI5iyv6C8FlfGA+mcUSV
         Eilk2Wfg2Yh+mpitoCexY6Nbe9xHQS2E9hpHpqzCZFETFgwjg2Oc1zkmlYsOWbmg/8nr
         FQI9Knof2Tl+qWxn+Wp3azyix6w+XLExRfIkj9DnGdDnmQtdHrd67d8wqvWG2qgADeC1
         Ky6g==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793062546; x=1793667346; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0rDUgYp8MSkkxbz0QJpm44/zZryJwi/MN1DJH+bVzxg=;
        b=trssUPbI/ExpCcRrf1U3evlwApeq6DXn5idgU+0ZLq/dgY1lCg7NEkMEhtPZ2n2NhM
         06fDZhbG96Z+rBRvtTe3CWY6ShmhpoWgzAfx7rZEledGRsdIhvcaPbAK73oDX3ILvhwm
         plOz/grs9xxkbg9IX0BfSiZ1hgP3uYTACyBZY21kUeDfMlcYUiHPDG58I6KQygsj9c7N
         CklImfwJUOLvJxbhwiFWQ/rgmQIQ3uR2fW1+aULqEC8yM/XJsjRbEH5iCjBlV8dP2kHE
         t0q3MKbaVLdQrdGr2jfcR5ku/nbOR/ohPaYMQ5hxcakWv8kT8iE9uybLw6Yqw1ekPJXg
         P0SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793062546; x=1793667346;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0rDUgYp8MSkkxbz0QJpm44/zZryJwi/MN1DJH+bVzxg=;
        b=fjghy9nzgkju/Y8YrYxbkecadJO4eer3y91AOx28rGm6bLY8s1KX1WH60s+ozI6NEm
         WR1FxvfOT0YH/s+qgU1jG+umMvmZUz8iOJd4Kws31TA59m5qFVE1csW50re8JkJxHVrL
         Y/2w+rtEjCHKHjpt6Z1MiFZcPvZwpWZsP81YZ6ezDvCP+yHY6T9FLmAXTPhT8+A/+Zwu
         h5qOwBDNzclN1oVWSpNX82b7weeUEJQ8dY2Z1XzTa0CMGqnvljNT//IuJjbkNegEC9Pm
         WrJ7iYgRqRY9RCLk3jag7D9fKlyTbtZk/R4oQH5hlResetyveToZJMB0Ho8fTa3lsMQG
         JnHA==
X-Forwarded-Encrypted: i=1; AKwUvBznNou/9TfUpHqp3f0DfahR2V8l7zbiELL8D5ehJfSRRCg2WYnFUOrf8gwJ+Yx0gjJU8+FQ0g==@lists.infradead.org
X-Gm-Message-State: AFq9FYLJ/QUxKTCIDpl9Inbu/eKTnTuvIXUn2ikQuB8pGTKIKyF5/a6+
	gdVMlREkC6JS+CkRL+DO4pMhPsayUzMoe1qa3As1slWVILC2R76UibxmYtODcCxP7tc4cC7o5B0
	NYG9QEEKx9eOKuVUxD/czNjitvrrkGiT0/Kx4jJ46
X-Gm-Gg: AYBFou1jBpxgdE7Jyakrr3LTySsNBxVzr4Tjb7e1GudBTdXGuORrBBtMr3azRYgRFYP
	P7ay0Ek6Ci2/Tm1Sx9lK2W+m+k5KDfl+u0QLxvMGPrLNeWmCttYuU4p8xSvyx98Yzu9zrKuaFmH
	3/t9LGvv0s2+v9rrhWsyea/WztMe0G6n4CtDUgOHizYGeu/XEs8+TnCxgt1HClIfdAXtvcuZPFh
	0XgR9yYcZgYTQzGWDheFI/Zkp1C6kRWDXDsqCwO5C7YDD/5VUCKOaLq3lfNhM4B8I/XfcTbL3ss
	HJLM8DnSApNM4QgPFZZYgpIhf07cqs9aQpbC7UodNRmahJIrh3XV63JofRt1YkKaLqsptMDppnc
	+aOCOHdLUlSz9/rY6gfE4axrLn7RZQBLNCGGBppz31NLgKHCBRxuUAaV25eDNZhU4AQcJJtbyg8
	GhnjX6/J1eeiP3ruol2l5QkqxY1HzCE5E3UQor/KsThh63Xxvd9btLd1eqlQ==
X-Received: by 2002:a05:690e:4193:b0:679:ab13:5517 with SMTP id
 956f58d0204a3-67a454185a9mr4463627d50.104.1793062545192; Mon, 26 Oct 2026
 17:55:45 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261021152527.375070-1-tarunsahu@google.com> <20261021152527.375070-4-tarunsahu@google.com>
 <atlQ_Er0Ig7CCSxv@google.com> <CALzav=f00C4yOAseNunW8GgQTDUGWT927Qy=TLm-3-J0TEDH8Q@mail.gmail.com>
 <9huzzew0el59.fsf@tarunix.c.googlers.com> <at_CncIPYCxOVkLo@google.com>
 <9huzecdcghxu.fsf@tarunix.c.googlers.com> <at_pxoULR1Tp5anN@google.com>
In-Reply-To: <at_pxoULR1Tp5anN@google.com>
From: Tarun Sahu <tarunsahu@google.com>
Date: Tue, 27 Oct 2026 01:55:34 +0100
X-Gm-Features: AclHuK8fanKHLtbPQb3b8Hh9aMr64vlKSACVWw1UZzkklpf-Ls0Hu1JyLQFmaw8
Message-ID: <CALe+6DxTR0BpvW7mXMjq_+dczT2jO=R_qLbHhSduhnuSPcXhzQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/4] liveupdate: Replace compatibility string with
 a 2-bit pair feature header
To: David Matlack <dmatlack@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, joro@8bytes.org, 
	Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, maz@kernel.org, arnd@arndb.de, 
	jgg@nvidia.com, robin.murphy@arm.com, loganodell@google.com, 
	oupton@kernel.org, kevin.tian@intel.com, alex@shazbot.org, 
	dwmw2@infradead.org, pbonzini@redhat.com, seanjc@google.com, will@kernel.org, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Alexander Graf <graf@amazon.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, baolu.lu@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, 
	sagis@google.com, linux-mm@kvack.org, kvmarm@lists.linux.dev, 
	iommu@lists.linux.dev, linux-pci@vger.kernel.org, kexec@lists.infradead.org, 
	skhawaja@google.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261026_175548_213547_B3A34235 
X-CRM114-Status: GOOD (  53.30  )
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

On Tue, Oct 27, 2026 at 1:01=E2=80=AFAM David Matlack <dmatlack@google.com>=
 wrote:
>
> On 2026-10-26 11:28 PM, tarunsahu@google.com wrote:
> > David Matlack <dmatlack@google.com> writes:
>
> > > But looking at this again, I think the required bit is redundant. Whe=
ther
> > > a feature can be safely ignored is a property of the feature itself, =
not
> > > of any particular file. Every file that has a feature present will ha=
ve
> > > the same required bit for it. The only thing that actually varies per
> > > file is whether the feature is present.
> >
> > The required bit is subsystem property not the per-file. e.g. memfd_luo=
,
> > it is set at compile time for a kernel. So every file will get that req=
uired
> > bit set. It is not per file property.
> >
> > struct u8 memfd_luo_feature_state {
> >        [MEMFD_LUO_CORE_FEATURE] =3D LUO_FEATURE_REQUIRED
> > }
>
> Right, whether a feature is required is a static property of the
> feature.  That's exactly why it's redundant to send it in every header.

I meant the different thing.I was saying if a Feature in a kernel will have
constant value either required or optional which is fixed at compile time.
But the same feature can have different values in two different kernels.

I am not finding a good example, But I am skeptical about making the
assumption for all future kernels that the features will always be
required if they were required before.

Maybe a seal added in kernel version M. Later in kernel  version N this sea=
l is
deprecated and replaced by a new seal.

So transition from M->N
source kernel will preserve the seal values and flag the feature as require=
d.
target kernel will mark it supported and use its value to translate
into a new seal.

From N -> Z (latest)

Old seal is no longer required, But the new seal is required, so kernel N w=
ill
mark the new seal as required. and Z will support it.

This is hypothetical example. I'm not sure this is enough to convince the p=
oint.
So, I will rely on others to chime in with their thoughts.

>
> > > The required bit still has to be conveyed to the target somehow, sinc=
e
> > > the kernel that needs it is the one that doesn't know about the featu=
re.
> > > But it can be conveyed by the feature's number rather than an extra b=
it:
> > > split the flag space into required features and optional features, an=
d
> > > assign each feature to one of them when it is defined. This is simila=
r
> > > to the required_flags and optional_flags approach in struct pci_ser [=
1].
> > >
> > > Keeping the same header shape as discussed with Pasha:
> > >
> > > struct kho_ser_hdr {
> > >     __u32 size;           /* Size of header + payload in bytes */
> > >     __u16 nr_required;    /* Number of required feature bits */
> > >     __u16 nr_optional;    /* Number of optional feature bits */
> > >     __u64 flags[];        /* Required bits, followed by optional bits=
 */
> > > };
> > >
> > > Required feature N is bit N of flags[], and optional feature N is bit
> > > nr_required + N (using nr_required from the incoming header). The len=
gth
> > > of flags[] is DIV_ROUND_UP(nr_required + nr_optional, 64). Both space=
s
> > > are numbered contiguously, so there are no gaps, and up to 64 feature=
s
> > > still fit in a 16-byte header.
> > >
> > > Each bit just means the feature is present, so the truth table become=
s:
> > >
> > > Source bit       Target supports  Action
> > > ---------------  ---------------  ------------------------------
> > > Not set          -                Accept: feature absent
> > > Optional set     No               Accept: ignore the feature data
> > > Optional set     Yes              Accept: use the feature data
> > > Required set     No               Reject: -EOPNOTSUPP
> > > Required set     Yes              Accept: use the feature data
> > >
> > > There is no invalid encoding left to check.
> >
> >
> > IIUC, I believe this will not work.
> >
> > To Communicate between source and target, We are defining a protocol, A
> > protocol which will be standard for all the kernel. And each bit locati=
on in
> > flags must have the same meaning in both the source and target kernel.
> >
> > Now in you approach, If Source kernel send feature N to target kernel,
> > target kernel must understand Nth bit as the same feature. Even though
> > the bit position in your approach is not fixed but they are fixed
> > relative to their starting point.
>
> I think you misunderstood the proposal. I'm not proposing to pack only
> the set bits, and I'm not proposing that each feature have a bit in both
> ranges.
>
> In my proposal, there is no such thing as "feature N", there is
> "required feature N" and "optional feature N".  Required feature N can
> be found at bit position flags[N]. Optional feature N can be found at
> flags[nr_required + N].
>
> In more detail:
>
>  - Each feature is defined as either required or optional, once, when
>    the feature is added. That choice is permanent.
>
>  - Each feature gets exactly one bit, in its range, and that bit is
>    always at the same position whether or not it is set. Required
>    feature N is bit N. Optional feature N is bit nr_required + N.
>
>  - nr_required and nr_optional are the number of features of each kind
>    the source kernel knows about, not the number of bits set. They tell
>    the target where the optional range starts and how long flags[] is.
>
>  - A set bit means the feature is present in this file's payload. A clear
>    bit means it is absent.

So For #NR number of features, We will end up using 2*NR bits which
is exactly same number of bits, V3 [2] uses. So this is just a different
way of encoding in implementation perspective.

>
>  - There is no invalid or reserved encoding to define. Each bit just
>    means "present".

What if a buggy source sets both required and optional for a feature?
That is an invalid case here. Same as 0b10 is an invalid value set by
buggy kernel.

>
>  - The target doesn't need a supported table. Required features are only
>    ever appended, so it rejects any required bit at or beyond its own
>    MEMFD_LUO_NR_REQUIRED. Optional bits need no validation; the target
>    just checks the ones it knows about.
>

As I explained above, incase a feature is replaced by another feature,
new kernel
can support it deserialization but it will not be required from there on. S=
o
The supported table will still be needed.

> > For the current appraoch and V3 [2]. Think the below one as msb is
> > required bit and lsb is feature present in payload bit.
> >
> > 00  FEATURE_ABSENT / DEPRECATED
> > 01  FEATURE_OPTIONAL
> > 11  FEATURE_REQUIRED
> > 10  IS INVALID (analogy: required set but feature is not present) which=
 can
> > have different meaning in future if in future, a need arises to reuse t=
his
> > field.
>
> In v3, 0b10 is reserved and not checked by the target. That means an
> older kernel will silently accept it, so the only meaning it could ever
> safely take on is "safe to ignore", which is what 0b01 already means.
> A reserved encoding is only useful if older kernels reject it, and at
> that point it's no different from adding a new required feature.

Yes, because I thought 0b10 could be used in the future. And Currently
If it is set by a source kernel, it is buggy source kernel. But I can chang=
e
back to INVALID, As you said, it overlaps with valid field 0b00.

~Tarun

>
> > Deserialization can happen per feature from right to left. without
> > jumping back and forth.
> >
> > Because of all these reasons, I believe current approach presented in
> > V3 [2] is the better. It is close to your PCI series with two flags
> > field for required and optional except I combined both field into one
> > flags. In your above approach you do have two counts but not having gap=
s
> > (which is wrong) and the way you proposed to parse with an offset is di=
fferent.

