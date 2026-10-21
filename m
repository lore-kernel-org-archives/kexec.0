Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183D2606A324
	for <kexec@archiver.kernel.org>; Wed, 21 Oct 2026 23:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=CHL0lPJ+;
	dkim=temperror header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=l2/TtjCZ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j1gtu/2ECGchElAdjQsJmcTzWPpoWAuSh1B1l3W6hUU=; b=CHL0lPJ+U2xtypg2Jfnt/fhSKV
	T4+IkcwBbrp/KxkPDSPb9mNlPWuRI3Pe4CkFzwZiCaXFOKw80JeJK5PNF0wKHu+LxHtB6+1W71Br4
	N2w6F7dqd7rSxd/WKvanumEwss4qQR9Ry6sJyjxIKzRiCiTOL+NbrTRPGdClPTcSxAS52jGZ8IfPz
	54wg5cvL9PwiNuh36ElBEwESQpVkbAx+pPiTXOlIHk/6atoLuFDE3I32uZqUq7wEIPiuLrzY2O5am
	w2nJ4hRNS0AeRi1PCFciRCB65pm1hRbaFFrKv/0kZ2YjDMjmYSMvFJCfU/JBuPUo72oX/W+tt/MJv
	/QsY3+QQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJfjt-0000000D2CQ-4Be2;
	Wed, 21 Oct 2026 23:28:58 +0000
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJfjr-0000000D2Bk-1KKV
	for kexec@lists.infradead.org;
	Wed, 21 Oct 2026 23:28:56 +0000
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-cc4ca696de6so693968a12.2
        for <kexec@lists.infradead.org>; Wed, 21 Oct 2026 16:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792625334; x=1793230134; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=j1gtu/2ECGchElAdjQsJmcTzWPpoWAuSh1B1l3W6hUU=;
        b=l2/TtjCZE2B0isG8uuN3xCr8qrQqAkxAriBtNHA9UgCGNRZ5GSAlWPNlfx1gyAPyba
         3/HAt8ppbxzAcYLEv0h+n15c7NQO9qYizfpHaRMhR31P7wGwGoDg7hQ3TBbFQ4sGJF44
         DrIEWGa3aiW9AQXZdFFXpvf24YEne1nilauGrPINKdkMHeJoy7IcrQmtvoW0niM76fze
         VswTCaYrsM/65K6TnXSjVu64inS4OC908hQr73XyyxbfKc0LR/ALvNXdzG96RzQb9x4q
         OCIGXrh3ggHKxHWdbCHLiM0gFOwb0KsMPWGF6JMiPgiA4UpPD2zdMMenR5L37wG/9pTI
         Z/vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792625334; x=1793230134;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=j1gtu/2ECGchElAdjQsJmcTzWPpoWAuSh1B1l3W6hUU=;
        b=hzGKUgIxdfLW2EaHE+NfYRTMhvvgPTbB/cSSE7K4yQfXORNY4owtywXgYWwU810w+l
         W0kOYcr0+4yv4udJGg5hXCqHLhHOhT5uUwM9WcrgwU8HhRC4P7iNxRxas57k0zVlt19d
         KvwG0Pc6TPmWs0mhV1vEMZ0QXTY5f77Eb1W7LvJMEQ3vw4b0P9vi0+7o5t3j0IeDhve8
         hCKGajZdPJZK7iWNXZ8NNjO/4JrvcVxbvtEhLlYrueALNZL8K53rglLTDuBISQqNpdZk
         f0Vg6CkLyOvPvcEsQRvA64KpJFM06wIPNO6YnUwEapEjlocZo/guS9+b5FcYRWqwxd2E
         3qsQ==
X-Forwarded-Encrypted: i=1; AKwUvBy+vJdH4SKBi8qVPuEmSTrtSwThrGVlk1963OEh2cZLcaBGHf56t6h9B2HAGvZpxwX1UbDbMA==@lists.infradead.org
X-Gm-Message-State: AFq9FYI0PNG+jchyE59+YDxzKvbyLilFztBICEtWgeZmjhlZEhmFUawv
	wh0iaIh2yydgX5FsdI1lPy3VixBm67tkf2gYOPZy4colarLzLQWhw3/pL2FHa8o0BQ==
X-Gm-Gg: AYBFou12d1tHWeV6F23Yqy94TWEzSV6dWXq/N0xDfduIvVRrwy6UQiDAz2AbSAGiaQw
	U0bxgWSFeTq6jm+dx25In6t3C+orR54ROKyJyPnlGUe2jRhQJv75A/Ndq3bHFAk4NOYEgGcnyuK
	xN4kYhYRGl7n56sPCCD+/X+AO1ayvuw9986pCvkivD4OPdpGHLQmnvnWfSZbjkg7dV011zFFbdi
	X5jX07UdWYHosX4otH0jDLxpfadv2ZNiaaiO92ARbufewQ4lGdELyzRpMYYYllVqvV5nJt9Gmow
	3ielNxKheuuMF+Qxd32PrxLzt3yt/9M4TmtqfRfu5bMi8XGlxBJQ4WFLdVIm7EKnTuSOZKc4R5h
	K6oFxVEc35B4G0WWOYAeR8wC1lItwlduScD0RvKYNqKPP+pWrBmMO+bgW2hdrbqLKQok5X1gh03
	dKRRONoeolhEJ35qPV3mgVQFW4aRh8vkP3sMNYn1gz4L/HSmVdkaxyNz3ykH4lIxACWhUpe78zc
	l8jEZKUwlTO92ImHj8Of5uvCMFy+l5BFLkmVr739MBOiec/WYh/S/lC6OX0uc5aOFK/w+/1N7w1
	YCMlAFSU+ueAiCbx
X-Received: by 2002:a05:6a00:448b:b0:88b:7278:ebf4 with SMTP id d2e1a72fcca58-8a089dc6e77mr2781314b3a.18.1792625333734;
        Wed, 21 Oct 2026 16:28:53 -0700 (PDT)
Received: from google.com (64.75.127.34.bc.googleusercontent.com. [34.127.75.64])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a08933aec9sm1368611b3a.2.2026.10.21.16.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 16:28:52 -0700 (PDT)
Date: Wed, 21 Oct 2026 23:28:48 +0000
From: David Matlack <dmatlack@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: tarunsahu@google.com, Andrew Morton <akpm@linux-foundation.org>,
	joro@8bytes.org, Mike Rapoport <rppt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>, maz@kernel.org, arnd@arndb.de,
	jgg@nvidia.com, robin.murphy@arm.com, loganodell@google.com,
	oupton@kernel.org, kevin.tian@intel.com, alex@shazbot.org,
	dwmw2@infradead.org, pbonzini@redhat.com, seanjc@google.com,
	will@kernel.org, Alexander Graf <graf@amazon.com>,
	Bjorn Helgaas <bhelgaas@google.com>, baolu.lu@linux.intel.com,
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
	sagis@google.com, linux-mm@kvack.org, kvmarm@lists.linux.dev,
	iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	kexec@lists.infradead.org, skhawaja@google.com, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 3/4] liveupdate: Replace compatibility string with
 a 2-bit pair feature header
Message-ID: <atlKsD-aJB3mJr2j@google.com>
References: <20261021152527.375070-1-tarunsahu@google.com>
 <20261021152527.375070-4-tarunsahu@google.com>
 <CA+CK2bAQbmq3ArP3XMErF_8RC2CUwvgpLY0H83D0nCJTaVKYyA@mail.gmail.com>
 <9huzecdi6go0.fsf@tarunix.c.googlers.com>
 <CALzav=dLdJoVy=B1pv0FAurD9OhAzLSTjJNbtjTdJRmSqaB0yw@mail.gmail.com>
 <CA+CK2bAQRMAEXZyHTEuUN0_Fo59Sn0hBmYbme_J9ewjx6gPyJQ@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bAQRMAEXZyHTEuUN0_Fo59Sn0hBmYbme_J9ewjx6gPyJQ@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261021_162855_359912_C9A76FBA 
X-CRM114-Status: GOOD (  39.75  )
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

On 2026-10-21 02:50 PM, Pasha Tatashin wrote:
> On Wed, Oct 21, 2026 at 2:47 PM David Matlack <dmatlack@google.com> wrote:
> >
> > On Wed, Oct 21, 2026 at 11:40 AM <tarunsahu@google.com> wrote:
> > >
> > > Pasha Tatashin <pasha.tatashin@soleen.com> writes:
> > >
> > > > On Wed, Oct 21, 2026 at 11:25 AM Tarun Sahu <tarunsahu@google.com> wrote:
> > > >>
> > > >> LUO and its file handlers validate handed-over state with monolithic
> > > >> compatibility strings ("luo-v5", "memfd-v2"). Any change to a serialized
> > > >> structure, even an optional additive one, must bump the string, which
> > > >> breaks live update between adjacent kernels. Replace the string in
> > > >> struct luo_ser with a feature header, so that the target kernel can
> > > >> accept or reject the source kernel state per feature.
> > > >>
> > > >> struct luo_feature_hdr is a fixed 128-byte header: the serialized
> > > >
> > > > This patch is all wrong; 128 bytes is far too large. For every _ser
> > > > struct, we only need 8 bytes instead.
> > >
> > > NOO, It is not. It is intended to avoid complex mess with unnecessary
> > > over-engineering.
> 
> 128-byte per serialized struct is not starter.
> 
> > >
> > > >
> > > > The first 4 bytes are the size, and the next 4 bytes are flags (i.e.,
> > > > 30 feature flags + 2 reserved bits for flags extension). The last two
> > > > bits of the flags indicate whether an extended flags field is present.
> > > > Each extended flags field is 8 bytes, and its last two bits indicate
> > > > that yet another extended flags field follows.
> > >
> > > If we will have dynamic extension of flags, Think about this.
> >
> > To support dynamic extensions in a backward compatible way you want
> > something like this:
> >
> > struct luo_feature_hdr {
> >    size
> >    flags
> 
> __u32 size
> __u32 flags
> 
> >    extensions  // offset of first luo_feature_extensions (or 0)
> 
> __u64 extensions[0]  --> but the size should be specificed in
> declaration macro that I showed in the next patch.

I think you may have misunderstood what I meant. In my proposal,
extensions is an offset to the first extension, not an array of
extensions that immediately follow the header.

If the extensions immediately follow the header, then the number of
extensions is baked into the struct layout. Every field after them sits
at an offset that depends on how many extensions there are. If we ever
need one more extension, all the fields shift and old and new kernels
can no longer read each other's struct. That is the problem Tarun
pointed out. So in practice the number of extensions is fixed forever
when the struct is first declared, and we have to guess up front how
many features a struct will ever need. That's the same as Tarun's
128-byte header, just with a smaller guess.

What I'm proposing is a linked list of extensions, where each link is
an offset from the start of the struct. A new extension is never
inserted into the middle of the struct. It is appended at the end along
with the new fields that need it, like any other new field, so existing
field offsets never change.

Something like this:

struct luo_ser_hdr {
	__u32 flags;
	__u32 next;    /* Offset of first struct luo_ser_ext, or 0 */
};

struct luo_ser_ext {
	__u32 flags;
	__u32 next;    /* Offset of next struct luo_ser_ext, or 0 */
};

That's the same 8 bytes as your proposal. And because "is there an
extension" is next != 0 instead of reserved flag bits, all of the flag
bits are available for features.

For example, a struct starts out like this:

struct foo_ser {
	struct luo_ser_hdr hdr;        /* hdr.next = 0 */
	__u64 a;
	__u64 b;
};

Over time we add features and fields until the header flags run out.
Then we add one more feature, FOO_FEAT_C, which needs a new field c:

struct foo_ser {
	struct luo_ser_hdr hdr;        /* hdr.next = offsetof(struct foo_ser, ext1) */
	__u64 a;
	__u64 b;
	/* ... fields added for features in hdr.flags ... */
	struct luo_ser_ext ext1;    /* ext1.next = 0 */
	__u64 c;
};

- a, b, and every other existing field stay at the same offsets. Both
kernels can keep casting the KHO memory directly to struct foo_ser.
No memcpy() or variable offset math.

- An old kernel that knows nothing about ext1 can still find it by
following hdr.next, because the chain describes itself. So the old
kernel can still reject the struct if ext1 has a required feature it
doesn't support, and ignore ext1 otherwise.

- A new kernel receiving the struct from an old kernel sees
hdr.next == 0. It treats every feature in ext1 as absent and never
touches c, so it never reads past the end of the old, smaller struct.

The only rule for subsystems is that a field can only be accessed after
checking its feature, which a LUO helper can do by walking the chain:

if (luo_ser_has_feature(&ser->hdr, FOO_FEAT_C))
    c = ser->c;

If we keep size in the header, this is where it would be useful: LUO
can check that every next offset is within size and strictly increasing
(so there are no loops) before walking the chain.

> 
> > }
> >
> > struct luo_feature_extentions {
> >     flags
> >     extensions // offset of next luo_feature_extensions (or 0)
> > }
> >
> > And then an example serialization struct would be:
> >
> > struct foo_ser {
> >     struct luo_feature_hdr header;
> >     ... fields ...
> >     struct luo_feature_extension extensions1;
> >     ... fields ...
> >     struct luo_feature_extension extensions2;
> > }

