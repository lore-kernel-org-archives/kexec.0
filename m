Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F44606A31A
	for <kexec@archiver.kernel.org>; Mon, 26 Oct 2026 21:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=XT9wP3Ev;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=bHCQ5wT1
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=gKF3hAWDK1ltcE+SHB5ZbEu9q5rcNDasVCUAn/AhQHg=; b=XT9wP3Ev1y40omARYPpGQP16Ss
	SdqLu08GyEeSRsBPHcp634fO4pSGqq7qdb/ENgXZWAMnFdj35/+klZTalHnpGi3JycrtRI53iSDCn
	BSU1HbSgQ1qoETvfYrxTqt/zkpgL3vaQkk+M+yWmRo8o7HSMpaQ6sB3mpPB87gaArpfb5VuWuk3+v
	gk6Gh5MnUUmBfhOZvyIfB2P5PIMJ8ZkR8BY78QCYT4i24hETSP0BSAA3IxxNK252wx47TEBIGnJrh
	y0bnFZgOVvW/AZ/suOWbqYFtmRy9zfmqbGN8QbXyTuybxXUrze/hKSO+p/wSa8K+WS7hOKjzodBTb
	hNsfzjfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLS1H-00000003HOZ-405q;
	Mon, 26 Oct 2026 21:14:15 +0000
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLS1F-00000003HNt-1EAY
	for kexec@lists.infradead.org;
	Mon, 26 Oct 2026 21:14:14 +0000
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-cd5c9e52398so1223519a12.1
        for <kexec@lists.infradead.org>; Mon, 26 Oct 2026 14:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793049252; x=1793654052; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gKF3hAWDK1ltcE+SHB5ZbEu9q5rcNDasVCUAn/AhQHg=;
        b=bHCQ5wT1RCzj4VcgtIZ7EFt1R+KpXWE1FkeJVjY70I/ZjGkUjkUlimeGNo+NQQbCiO
         /RzbB8tn/E6Dmwl+OStzYkY3a/Xe6t+yvGZQXDG3vtry21U7vrWcd55QeElBEDWIcqGk
         gGsnuCGyRtpPMvQHAGj17fA4rxAytYc2fa7GVOdMRsa3wmS4lZB8YkcxOfyFQeZtzZuD
         viqVG9bugZEj+Q3yNOz53X92SFRKbZtr9GUpS6skwfc7vJnrptfmTpbwfae5JVKmk4SG
         KFANkXA2PrAhyjqMaKpm1CLCksy5vX6o3IRAldREM0uQqcQ1nZSExqAebb224/MZ1kNz
         RU2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793049252; x=1793654052;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gKF3hAWDK1ltcE+SHB5ZbEu9q5rcNDasVCUAn/AhQHg=;
        b=VXpx2Ab+YKPrY3hDwVU+ajdhOFFisgxKCkLomgmGx0Vvb70QBKy2SH2UFOgPWVdmiP
         fxEvPT3j3ZNHtcBBZTGaUNzu0Q72pVshqPfnckSK28QLx3/m4YG01DDt2gsceMV8Ab23
         4S9gQlyEEdc8569cVUPNl5WGDYR+UEtidzMOh+qztJh6dd6JQmvsPHvASN4Uf7XQwjLZ
         SlgGfCs16a43h5K7SiWrqwRERv5dEqG8kgtyU+b/gB4mOMUXYstscherRHSUnspLJ2rS
         XD/1fYIzE+/E/bdV8MpXQJ9uHVoX1/Q2eoS7iyw4ZSEe4Gk/0LR4pXqTL0HJhYpgWQVY
         9wRQ==
X-Forwarded-Encrypted: i=1; AKwUvByvus+NhyAa45JDSpQDl6oZZXmItj5kPC8Vv8vTL7lS94mhpUsYSexXooxFdy6clwI4BFOAow==@lists.infradead.org
X-Gm-Message-State: AFq9FYJaVmRkuwjvlIONRY86+KOR1JOLABHBkKcJtbgs0g0XGka5X8Tb
	BPJlBNkk2aQlF5GR1JTkwIM1ZB7yhOTXeppay8Jdsp2Z7KohzqAPSQ3RvXMTN1MfPg==
X-Gm-Gg: AYBFou13lI/ZGejLd2rYvZge193zOSlZKroD40dYSUi6TSTKJQWyrk+HHJBWYVz4Obo
	KYEDEW22kOxxaTuI6G5APReRO2cfx1Pnfc2KCeXnr6PKesCVvu89D8jyoBN7Yh6mM+85tdF7gYg
	nkWGRVkFuZjRqawnVj2iWmIJJaK8OcHV0yuSzYIG8xq5fHkDQQM0+ezupZRiKY8JroweaFyWPoo
	NcQv2W6u8hr/iNDae39y5ssQQxZ700XsfGiT9q+PbiIY55A2moS39/nQj1Q5G5ILmfWovvJpkhq
	7tu+qzK4eGh3mXnXWCCaUttNXvl/vJbM/gkPBpWUj8tCwl8BXGYRzbYBFFU3zbI72WCo1XEoRmu
	rcflqub2fB1XZ/4nRlOhRQ+UeIFJ9pRA/Ck/N3aS0I3GMvIwQoypLyMWJ4uTmt9bOKTriN5xbAZ
	QcuNKj5g4fHsLVR8L0DvFZGPv4RNY66kEL0HHqwkWhOu6+RKP994ALDtUksxki4WCtKMGewnA/B
	3FA9AV4VJbLQxjD/jOFsiaobatJ96CgDG1JfyAEsb4Lh77L8PjUjX8v8MWJRn/fmf/m9ciXuNSi
	T7BmShTutjcLZ86SyhtWSKfScIZbdwKPlN5LfmAXFZw=
X-Received: by 2002:a05:6300:6bc9:b0:3e2:3392:53e7 with SMTP id adf61e73a8af0-3e7a1b97750mr5308652637.0.1793049251805;
        Mon, 26 Oct 2026 14:14:11 -0700 (PDT)
Received: from google.com (192.150.203.35.bc.googleusercontent.com. [35.203.150.192])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a36b372888sm1666157b3a.30.2026.10.26.14.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 14:14:09 -0700 (PDT)
Date: Mon, 26 Oct 2026 21:14:05 +0000
From: David Matlack <dmatlack@google.com>
To: tarunsahu@google.com
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
Message-ID: <at_CncIPYCxOVkLo@google.com>
References: <20261021152527.375070-1-tarunsahu@google.com>
 <20261021152527.375070-4-tarunsahu@google.com>
 <atlQ_Er0Ig7CCSxv@google.com>
 <CALzav=f00C4yOAseNunW8GgQTDUGWT927Qy=TLm-3-J0TEDH8Q@mail.gmail.com>
 <9huzzew0el59.fsf@tarunix.c.googlers.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9huzzew0el59.fsf@tarunix.c.googlers.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261026_141413_359270_011AB133 
X-CRM114-Status: GOOD (  21.02  )
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

On 2026-10-26 11:50 AM, tarunsahu@google.com wrote:
> Right, Required bit should be source kernel payload property to tell
> target kernel that the payload must be handled to correctly deserialize
> the data. It should be source kernel (userspace) responsiblity to make
> sure it understand the target kernel before doing liveupdate.
> 
> Saying this, During deserialization, target kernel's required bit is not
> necessary. So I propose the following truth table.
> 
> Source hdr  Target supported[i]  Action
> ----------  -------------------  ----------------------------------
> 00          0 or 1               Accept: feature absent in payload
> 01          0                    Accept: ignore the feature data
> 01          1                    Accept: use the feature data
> 11          0                    Reject: -EOPNOTSUPP
> 11          1                    Accept: use the feature data
> 10          0 or 1               Reject: -EINVAL (invalid encoding)

Yes, this matches what I had in mind for the semantics.

To be explicit: the source kernel should set the bits for each Live
Update based on what is actually preserved, rather than generating the
header from a static per-kernel array. E.g. memfd would only mark a
feature present for memfds that actually use it. That's what allows
rollback to an older kernel as long as nothing being preserved depends
on the new feature.

But looking at this again, I think the required bit is redundant. Whether
a feature can be safely ignored is a property of the feature itself, not
of any particular file. Every file that has a feature present will have
the same required bit for it. The only thing that actually varies per
file is whether the feature is present.

The required bit still has to be conveyed to the target somehow, since
the kernel that needs it is the one that doesn't know about the feature.
But it can be conveyed by the feature's number rather than an extra bit:
split the flag space into required features and optional features, and
assign each feature to one of them when it is defined. This is similar
to the required_flags and optional_flags approach in struct pci_ser [1].

Keeping the same header shape as discussed with Pasha:

struct kho_ser_hdr {
    __u32 size;           /* Size of header + payload in bytes */
    __u16 nr_required;    /* Number of required feature bits */
    __u16 nr_optional;    /* Number of optional feature bits */
    __u64 flags[];        /* Required bits, followed by optional bits */
};

Required feature N is bit N of flags[], and optional feature N is bit
nr_required + N (using nr_required from the incoming header). The length
of flags[] is DIV_ROUND_UP(nr_required + nr_optional, 64). Both spaces
are numbered contiguously, so there are no gaps, and up to 64 features
still fit in a 16-byte header.

Each bit just means the feature is present, so the truth table becomes:

Source bit       Target supports  Action
---------------  ---------------  ------------------------------
Not set          -                Accept: feature absent
Optional set     No               Accept: ignore the feature data
Optional set     Yes              Accept: use the feature data
Required set     No               Reject: -EOPNOTSUPP
Required set     Yes              Accept: use the feature data

There is no invalid encoding left to check.

[1] https://lore.kernel.org/linux-pci/20261013162529.1928093-1-dmatlack@google.com/

