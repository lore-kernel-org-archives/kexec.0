Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558E7606A31A
	for <kexec@archiver.kernel.org>; Mon, 26 Oct 2026 18:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=uLvBdGs6;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=i2shCiL5
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=uO/W/z94g5X81Ln9+3SsNcj1ZpjaM4tumvmhkUCPgU4=; b=uLvBdGs6b30rlWPDBz/AMCxChS
	J8O8KW/wHNIjPTAe1XiTxRJVuPh1oc1SQgXAKmEQFW0DKsC6xsAGKlMBNNoayWxs4LZYdkCWYywSZ
	fK3IraEQXzXxHb5KGmsYp+gwFaN6Men2XXmD2ha/gBLpzu5uY6EUbMGDILIyJ4F1hSZCsRC3UXEc8
	FDE8hKHy/VvJDh92zlemBpzJLnde1SdShp8hqsniQ3CXT16/zRnhMVMrWscetThluzxH5Cyw3ivQX
	vQgQ5OFWMMyKTOzjjT/5osWK6BG2hO1lb9zmsPu6OYSnYmjTDR5gbp22Z7h3swtY9AHex8GUHD1DZ
	sOdTJGcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLPuH-000000036yN-1ity;
	Mon, 26 Oct 2026 18:58:53 +0000
Received: from mail-ej1-x647.google.com ([2a00:1450:4864:20::647])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLPuF-000000036xn-0GxV
	for kexec@lists.infradead.org;
	Mon, 26 Oct 2026 18:58:52 +0000
Received: by mail-ej1-x647.google.com with SMTP id a640c23a62f3a-c429d9d05f0so338095566b.1
        for <kexec@lists.infradead.org>; Mon, 26 Oct 2026 11:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793041129; x=1793645929; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uO/W/z94g5X81Ln9+3SsNcj1ZpjaM4tumvmhkUCPgU4=;
        b=i2shCiL5+xJR/2VLEAZPXAJF8PTCuOXG5YBu8CjKdCvAsAU13830xkdeoCRsaS71UJ
         L4CBCcPYDkt7o3TsNToYaZwF+PTNBLWwciipZlkzncqStSC5BX9g6h7ARR7ZlPMXSF22
         XN125NMFmgfFQ38pwoXqXcNHebIt1dWOXdKQKo4+jwzUPWrYzPsFw6noyTWYbpxPNVNI
         jawBHQSza5hfg7XTW420xZqjhooborwGP3dKsNc3K5/Q6AT8EizA7/ohy0NY8e81j6nm
         wqotcQWPMuyNbQkcxZwKi9L0AJuLIzlLPjlOzNqpw/Fhnd57QDfFdGuPBs05JLYHcGnQ
         zT6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793041129; x=1793645929;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uO/W/z94g5X81Ln9+3SsNcj1ZpjaM4tumvmhkUCPgU4=;
        b=1E4q/IwGWXJ69rmK6q5bqu7JhdVvXW+ANi3R9gJhSWbe3lYra7X0F+RaOUxexgu0Rz
         LUqD47wEAFy7zKuBOmHi47pM3K3rsSzXYp8ceBN+GYpdTAbReNxxShZNMM44ImU/vsH2
         1D+r5SoVycJAxZs3HcGhvhRF/0zJ6ZII33TjwtywvpT93W9KodKBSwH3LmAHfzmS5rh6
         BA1dxPEe6S04nC53xan0a37MBffWHweEcLIekKyOXiuRP2JNpOl4uKv/uhWXv7mTs9ci
         wKEsIfsbfY3KYUiFDB1bJ8LOJtlBgZDRp8VcMdyoFXV1FV3tvcR6kx1z4PwdBYrg+rS+
         qG0g==
X-Forwarded-Encrypted: i=1; AKwUvBwFUe51j3Vtrqof0nhDPIrEwf5NKAFe0OciuSs3DT8eqMkU1j6yeYtZbKEi4NmKCzLqgSLxFg==@lists.infradead.org
X-Gm-Message-State: AFq9FYKg2WpxQr4rUfYUrU3s1KxgvLwDvpt5mKt5fi3QjAGmzj+Doxty
	13lO6nDJSyX5pishbd5VnvYRJkSnUXyQZua3U/EQDjEpMCZ5Urx+HRfYJzyuh1sGbRXWRZVlcsv
	g8UsFXRg7vzmCzx72WQ==
X-Received: from ejzi19.prod.google.com ([2002:a17:906:a293:b0:c40:732:2996])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:906:9f88:b0:c46:7462:6332 with SMTP id a640c23a62f3a-c46bdebd370mr947991366b.37.1793041128327;
 Mon, 26 Oct 2026 11:58:48 -0700 (PDT)
Date: Mon, 26 Oct 2026 18:58:47 +0000
In-Reply-To: <20261026174217.603114-1-tarunsahu@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261026174217.603114-1-tarunsahu@google.com>
Message-ID: <9huz8q3k9tlk.fsf@tarunix.c.googlers.com>
Subject: Re: [RFC PATCH v3 0/4] liveupdate: Add feature header for
 fine-grained ABI compatibility
From: tarunsahu@google.com
To: loganodell@google.com, alex@shazbot.org, dwmw2@infradead.org, 
	seanjc@google.com, Mike Rapoport <rppt@kernel.org>, will@kernel.org, pbonzini@redhat.com, 
	jgg@nvidia.com, Pasha Tatashin <pasha.tatashin@soleen.com>, arnd@arndb.de, 
	linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, oupton@kernel.org, 
	baolu.lu@linux.intel.com, David Matlack <dmatlack@google.com>, robin.murphy@arm.com, 
	maz@kernel.org, Alexander Graf <graf@amazon.com>, joro@8bytes.org, 
	Bjorn Helgaas <bhelgaas@google.com>, kevin.tian@intel.com, 
	Pratyush Yadav <pratyush@kernel.org>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261026_115851_131158_3F912360 
X-CRM114-Status: GOOD (  28.61  )
X-Spam-Score: -9.5 (---------)
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
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


Withdrawing this version because of the following reasons.

1. KHO also has versioning which can also share the same concept of the
feature flags, And the header can be shared amongst KHO and LUO. In next
version, I will include this.

2. If there are any open threads in the V2, Can be settled based on this V3
reference. This V3 has included the suggestion from V2, like updated
truth table, nr_features based flags array, ABI wrapper MACRO etc.

~Tarun


Tarun Sahu <tarunsahu@google.com> writes:

> Changes since RFC v2 [1]:
> - Dropped the file handler compatible rename and per-FD handler
>   selection patches.
> - Replaced the fixed 128-byte header with an expandable struct
>   luo_ser_hdr (size, nr_features, flags[]), kept separate from the
>   payload structure. The header is 8 bytes with no features and 16 bytes
>   for 1 to 32 features.
> - Each subsystem declares its wrapper once with DECLARE_LUO_SER_WRAP(),
>   passing its feature enum MAX; the macro sizes the flags entries and
>   generates name##_wrap_init(), so callers never pass sizes or counts.
>   The target kernel reaches the payload with luo_ser_payload().
> - Feature bits describe only what each preserved object uses. The target
>   kernel checks them against its own boolean supported table, and the
>   header is trusted as the source of truth: validation only rejects a
>   required feature the target kernel does not support. 0b10 is reserved.
> - Moved the __packed removal into its own patch (1/4) and added a KUnit
>   test (4/4).
>
> Changes since RFC v1 [2]:
> - Replaced the 3-mask (supp, req, active) design with a header of 2-bit
>   feature states.
>
> [1] https://lore.kernel.org/all/20261021152527.375070-1-tarunsahu@google.com/
> [2] https://lore.kernel.org/all/20260903023452.721732-1-loganodell@google.com/
>
> ==========COVER LETTER==============
>
> LUO and its file handlers rely only on coarse-grained compatibility
> strings (such as luo-v5 and memfd-v2) to validate handed-over state
> across kexec. Any change to a serialized structure, even an optional
> additive field, requires bumping the string and breaks live update
> between adjacent kernels.
>
> This series adds a feature header (struct luo_ser_hdr) ahead of
> serialized LUO structures so subsystems can evolve their serialized state
> per feature. Each subsystem groups its serialized fields under feature
> indices, with index 0 for the base fields. New capabilities append fields
> at the end of the payload under a new feature index, and retired fields
> stay in place so offsets never shift. Only a change that feature flags
> cannot express needs a new handler with a bumped compatibility string.
>
> Each feature has a 2-bit state set by the source kernel:
> - LUO_FEAT_ABSENT (0b00): not in the payload; a target kernel that
>   supports it can use default values.
> - LUO_FEAT_OPTIONAL (0b01): in the payload; a target kernel that does not
>   support it ignores the data.
> - LUO_FEAT_REQUIRED (0b11): in the payload; a target kernel that does not
>   support it rejects the state with -EOPNOTSUPP.
> - LUO_FEAT_RESERVED (0b10): reserved, not checked by the target kernel.
>
> The target kernel checks the header against its own boolean supported
> table:
>
>   Source hdr  Target supported[i]  Action
>   ----------  -------------------  ----------------------------------
>   00          0 or 1               Accept: feature absent in payload
>   01          0                    Accept: ignore the feature data
>   01          1                    Accept: use the feature data
>   11          0                    Reject: -EOPNOTSUPP
>   11          1                    Accept: use the feature data
>   10          0 or 1               Reserved: not checked by target
>
> struct luo_ser_hdr holds the total size of the serialized structure
> (u32), the number of features (u32 nr_features), and 64-bit flags
> entries with 32 features each. With no features the header is 8 bytes;
> with 1 to 32 features it is 16 bytes.
>
> On the source side, a subsystem declares its wrapper once with
> DECLARE_LUO_SER_WRAP(name, expected_size, nr_features), passing its
> feature enum MAX, then calls name##_wrap_init(), marks the features the
> preserved object uses with luo_ser_set_feat(), and fills wrap->ser. On
> the target side, incoming state is never cast to the wrapper, since the
> source kernel may use a different number of flags entries. The target
> kernel calls luo_ser_hdr_validate(), finds the payload with
> luo_ser_payload(), and reads the fields of a feature only after
> luo_ser_get_feat() shows it present.
>
> Patch 1 removes __packed from the LUO and memfd ABI structures. Patch 2
> adds the header and converts struct luo_ser. Patch 3 converts memfd and
> bumps its compatibility string to memfd-v3. Patch 4 adds KUnit tests.
>
> Tarun Sahu (4):
>   liveupdate: Remove __packed from LUO and memfd ABI structures
>   liveupdate: Add feature header for fine-grained ABI compatibility
>   mm: memfd_luo: Add the feature header
>   liveupdate: Add KUnit test for the feature header helpers
>
>  MAINTAINERS                          |   1 +
>  include/linux/kho/abi/luo.h          | 359 ++++++++++++++++++++++++---
>  include/linux/kho/abi/memfd.h        |  43 +++-
>  kernel/liveupdate/luo_core.c         |  62 +++--
>  lib/Kconfig.debug                    |  16 ++
>  lib/tests/Makefile                   |   1 +
>  lib/tests/liveupdate_feature_kunit.c | 118 +++++++++
>  mm/memfd_luo.c                       |  68 +++--
>  8 files changed, 577 insertions(+), 91 deletions(-)
>  create mode 100644 lib/tests/liveupdate_feature_kunit.c
>
> -- 
> 2.56.0.307.g5fe7bd680c-goog

