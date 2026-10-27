Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0091F606A326
	for <kexec@archiver.kernel.org>; Tue, 27 Oct 2026 03:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=FEpJkOiT;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=MXqL5zRe
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=mFFfrqlGcCKVNylEOU7fJD0/AGoCZ65FALqe+xT5SYA=; b=FEpJkOiT1d1hA3NAwjJKF1Dyez
	jkkEYhWeWBUk0wrPdNpiun6U6ZceMTPiE2HMIbPM+1e60YlQlc/kSBaW1m2NNvFuFpPbpU6T6qPhs
	imgvg0eiTUHo2KxHMoTVI6Nfy5MGGI5GgIQouEalIrPSou5FEMDQr3gMq13GIVcmmh4HZcXehVMX3
	W6ZCoWwuurc3SFYQBi6xaa44rYsS5tjZ1NR79Ylx/nBkN10/Z7aRPpcGpO1s07KwAz4D+9gwSAeLe
	IiRvWAENtHFX7+of+Mox1eh0EMBiLV3DSkZ+X1zd9dvn0ax/ve/0Qk5pRprBYvY5rALETyddWwXmd
	0QsvHrig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLXpe-00000003h4H-3V8R;
	Tue, 27 Oct 2026 03:26:38 +0000
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLXpb-00000003h3D-1EaP
	for kexec@lists.infradead.org;
	Tue, 27 Oct 2026 03:26:37 +0000
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-2e9eb579c0eso20722415ad.3
        for <kexec@lists.infradead.org>; Mon, 26 Oct 2026 20:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793071594; x=1793676394; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mFFfrqlGcCKVNylEOU7fJD0/AGoCZ65FALqe+xT5SYA=;
        b=MXqL5zRe40hw7V/qWq99r9IocEizRWJjXBNpNF4DKEIDcmD1CtFOyjfPb5QiNa5ZYf
         IDAtfk0+1BwxNWXzRuLDvVIbPuHTF4FQDEIhwHpvbKS/ITcoGo+yMF7qDVw6t0Ob0OWM
         cuToSd26P7HHqQ0ODB+N/xywS+NLAD884mmb/bCsSNOS3sPyWoE1erkaKeg9ivEGMPgW
         7zvVuAEwX4yZHTnwuAnwDkgUPnBeUBfHoNHkr22QmDujxg5JYudOQ7Q/gk4ljvvwCkPb
         psq+5sORVprnsBR/dwlhDe8Twoq5PBoMcDNbHVbUKihCARIs+OrU1IHGQd5wYEpndK6G
         +FxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793071594; x=1793676394;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mFFfrqlGcCKVNylEOU7fJD0/AGoCZ65FALqe+xT5SYA=;
        b=GEscHNsQe6G498Mvbywop3PhsTfJHZi4i7s4mm62iz88SX+Cr6QlA0J0z0ELA1am7S
         pgJOrCgmYBGnWolQoNxZcvv9M4yZT5Ffvc1LFmMuOyDd7tP7OsweoPA0vNauXxc/ThEk
         BOu9DIvOGNQrfGlWhQ4BzXDsXoH6aOheXn9gSYHusrO9//9M/jJk+QfbX69LcWxgBiCx
         caSQRNS3fn8qvh2abkKoQBHz4qGFBgpK2B2WNu8AadJcDr+3DTYJ4mva19EM7aSIOMt8
         yAWEZueZ9hirzdKqLtnqcKJyz8dAOL4rPT9blJ6LvVYNya/TAYMXn/9qS7+XyYYdQr/S
         Lkjg==
X-Forwarded-Encrypted: i=1; AKwUvBxdRAuz5zhyj8O9f8IG1yhY7wijP92uzsSnKPvEJC1tFfpfl5qES90ijt7s/mTZtRqJE8WYRA==@lists.infradead.org
X-Gm-Message-State: AFq9FYI/zsnYUVzRXfqNkHv59l9dP0XTVYitTuT1DE9PwzbZZKLWkpsM
	1Aa7+VOlYbQtDLuIj1OVVFCweQUujxichuuPUGhdmauCvs8pVL/YdVzkGJ9p9Bqtqg==
X-Gm-Gg: AYBFou0AK6dXdF7EPbjP0Hj6oVy+HEEm+O+/Ba+1qYB3BmTc330BncDH3gGJ0sSxUJZ
	AD4NsdwFSWrSwmXEa6q/uqFYPlhZrGMYCGsJTYrZOd8xbM7dXGebw++nDg4apUWKsCD1KOKWZxW
	h4qYcdjROfc2t1kk5tgIQEAvHTZiItd40KvW2fEiAiP411l6KXGuTLUIy9IoCxe/MtVGQ6e8/mc
	Og1ZYlhqIN6OwdMYCyy4V1pbhSx2l3PAxTILL7J2tB+5dbNQx6lFWnn9iPd7WZHKa9rYY+/om1R
	MyScA4JNUyktC9qqLsMUypXyc+VtjNJc7UREKeLTnWciTBlnnUh075hi8jjiAKFa6Xw21fjlL8+
	u5K8B1KfD7dcN84tZoyymhRu/4TwaNerinXs+jmNb2jn6y/JU8vsJ6Qt0PxsvBKXlTIZK5HnoJ6
	5eACegIWsjY9T5Rv7wu4iX4p+34SV0gINv1iUTqSKv6DxERhq5vzP61J4qnqaWz6hNyfq9q++RU
	BdKkc8SMw+ftqX6tF/WLLRxNPGcHuQy9szA/6LwOMBijFqcrav7cPSWgmiAQje/2N8HWXbf9Ja3
	NpscjZIod+26uOTfE/Tg5i2hzNGGLG+vyoWOJf3KKANZu48ji9NcgmwakFMlusZNOrVMOWM=
X-Received: by 2002:a17:902:d548:b0:2df:ad58:cf54 with SMTP id d9443c01a7336-2ea9c81ab95mr64373815ad.34.1793071593614;
        Mon, 26 Oct 2026 20:26:33 -0700 (PDT)
Received: from google.com (192.150.203.35.bc.googleusercontent.com. [35.203.150.192])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6ce0f45sm2398915ad.70.2026.10.26.20.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 20:26:32 -0700 (PDT)
Date: Tue, 27 Oct 2026 03:26:29 +0000
From: David Matlack <dmatlack@google.com>
To: Tarun Sahu <tarunsahu@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, joro@8bytes.org,
	Mike Rapoport <rppt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>, maz@kernel.org, arnd@arndb.de,
	jgg@nvidia.com, robin.murphy@arm.com, loganodell@google.com,
	oupton@kernel.org, kevin.tian@intel.com, alex@shazbot.org,
	dwmw2@infradead.org, pbonzini@redhat.com, seanjc@google.com,
	will@kernel.org, Pasha Tatashin <pasha.tatashin@soleen.com>,
	Alexander Graf <graf@amazon.com>,
	Bjorn Helgaas <bhelgaas@google.com>, baolu.lu@linux.intel.com,
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
	sagis@google.com, linux-mm@kvack.org, kvmarm@lists.linux.dev,
	iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	kexec@lists.infradead.org, skhawaja@google.com, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 3/4] liveupdate: Replace compatibility string with
 a 2-bit pair feature header
Message-ID: <auAZ5agR1xBo3RLN@google.com>
References: <20261021152527.375070-1-tarunsahu@google.com>
 <20261021152527.375070-4-tarunsahu@google.com>
 <atlQ_Er0Ig7CCSxv@google.com>
 <CALzav=f00C4yOAseNunW8GgQTDUGWT927Qy=TLm-3-J0TEDH8Q@mail.gmail.com>
 <9huzzew0el59.fsf@tarunix.c.googlers.com>
 <at_CncIPYCxOVkLo@google.com>
 <9huzecdcghxu.fsf@tarunix.c.googlers.com>
 <at_pxoULR1Tp5anN@google.com>
 <CALe+6DxTR0BpvW7mXMjq_+dczT2jO=R_qLbHhSduhnuSPcXhzQ@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALe+6DxTR0BpvW7mXMjq_+dczT2jO=R_qLbHhSduhnuSPcXhzQ@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261026_202635_366533_52A6456A 
X-CRM114-Status: GOOD (  35.30  )
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

On 2026-10-27 01:55 AM, Tarun Sahu wrote:
> On Tue, Oct 27, 2026 at 1:01 AM David Matlack <dmatlack@google.com> wrote:

> > Right, whether a feature is required is a static property of the
> > feature.  That's exactly why it's redundant to send it in every header.
> 
> I meant the different thing.I was saying if a Feature in a kernel will have
> constant value either required or optional which is fixed at compile time.
> But the same feature can have different values in two different kernels.

Those would just be 2 separate features. One optional feature, and one
required feature. They might use the same fields in the struct, that is
fine.

> Maybe a seal added in kernel version M. Later in kernel  version N this seal is
> deprecated and replaced by a new seal.

I think this example works fine. The old seal is still a required
feature. The kernel just stops marking it present and marks the new seal
present instead. Retiring a feature doesn't change whether it is
required, only whether the source sets it.

The only thing this split doesn't allow is changing the whether a
feature is required or optional after it has been introduced. But for
that case we just introduce a new feature of the desired type.

> > I think you misunderstood the proposal. I'm not proposing to pack only
> > the set bits, and I'm not proposing that each feature have a bit in both
> > ranges.
> >
> > In my proposal, there is no such thing as "feature N", there is
> > "required feature N" and "optional feature N".  Required feature N can
> > be found at bit position flags[N]. Optional feature N can be found at
> > flags[nr_required + N].
> >
> > In more detail:
> >
> >  - Each feature is defined as either required or optional, once, when
> >    the feature is added. That choice is permanent.
> >
> >  - Each feature gets exactly one bit, in its range, and that bit is
> >    always at the same position whether or not it is set. Required
> >    feature N is bit N. Optional feature N is bit nr_required + N.
> >
> >  - nr_required and nr_optional are the number of features of each kind
> >    the source kernel knows about, not the number of bits set. They tell
> >    the target where the optional range starts and how long flags[] is.
> >
> >  - A set bit means the feature is present in this file's payload. A clear
> >    bit means it is absent.
> 
> So For #NR number of features, We will end up using 2*NR bits which
> is exactly same number of bits, V3 [2] uses. So this is just a different
> way of encoding in implementation perspective.

No, it's NR bits. I think this is the core misunderstanding.

Let's say you have 3 features. 2 are optional. 1 is required. That gets
encoded in 3 bits:

  nr_required = 1
  nr_optional = 2
  flags[0] = Required-Feature-0
  flags[1] = Optional-Feature-0
  flags[2] = Optional-Feature-1

> >  - There is no invalid or reserved encoding to define. Each bit just
> >    means "present".
> 
> What if a buggy source sets both required and optional for a feature?
> That is an invalid case here. Same as 0b10 is an invalid value set by
> buggy kernel.

That cannot happen. A feature is either required or optional. If you
have a "logical feature" that is sometimes optional and sometimes
required then you would have 2 feature bits for that in flags[]. But
that should be an unusual case.

> >  - The target doesn't need a supported table. Required features are only
> >    ever appended, so it rejects any required bit at or beyond its own
> >    MEMFD_LUO_NR_REQUIRED. Optional bits need no validation; the target
> >    just checks the ones it knows about.
> >
> 
> As I explained above, incase a feature is replaced by another feature,
> new kernel
> can support it deserialization but it will not be required from there on. So
> The supported table will still be needed.

The one case where a count isn't enough is if a newer kernel drops
support for an old required feature entirely (e.g. removes the code
that translates the old seal). That can be handled with an explicit
check in the handler, or we can keep a supported bitmap. Either way, that
question is independent of how the header encodes required vs.
optional.

Certainly in the immediate-term we can just use a count.

