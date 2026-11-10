Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA49606A332
	for <kexec@archiver.kernel.org>; Tue, 10 Nov 2026 17:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=MmuygfL0;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NiY4YlXZ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=vqBeli1UK7UsB0colEXax3/fZJsEEio4CkgX2Fv7UF4=; b=MmuygfL09vM6Hm
	FSZ03akXzWsFIai1WxYAlA7NJEj48K+/lygtle9UJICz/d+D+srKyPWuN95xamZjH6El8T53VEV/P
	KnqV18joOXkKH74467AVrD6EQOwRFi7FAWLdtYhcU4Guo8NyfCBEwoNyw7y3V9FW430E+DxPa2aM1
	XwUQJw8bpXMC8lgn9L7qwvGb6ZO1zSIPvgLXpRNCN3mIsMyMnemNYLaVoXfGlfOxXMyfokciv4yMz
	TrtCdzsC9cEolv1uFcArQAn4lLkGs0dTrjFvMSWEVZmIBFgp8T+2+3jkNhL8TPzatCsM+kO6EMNoC
	tR8x1EkqxuZKHP09P0Og==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQpGF-00000004cgf-0Fjz;
	Tue, 10 Nov 2026 17:03:55 +0000
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQpGB-00000004cfE-3nju
	for kexec@lists.infradead.org;
	Tue, 10 Nov 2026 17:03:53 +0000
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-cdb2893531bso1320385a12.1
        for <kexec@lists.infradead.org>; Tue, 10 Nov 2026 09:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794330231; x=1794935031; darn=lists.infradead.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vqBeli1UK7UsB0colEXax3/fZJsEEio4CkgX2Fv7UF4=;
        b=NiY4YlXZ80P/3lqJBHMCW2GC13KjDNhP6SrS3Psdo2ebbgMikDKuMznLz0wpatHtVk
         VHNi5rWnfV4YIx3TDoKVi1nF85sB8WsCJKGVhfTcMF0EBpU0tqCil5/tFkgrrQljfQzK
         ZHoBsaHQxMlQsJg+mQzRkol6qdmrUgDjjLc7TsQAlRX60KE6RsTbUvhVd5RQK2VLUBkc
         1fer7Vk/npKr+26l+aGp2QAcWXhYIjDdbF2v3sWpOtyZS3RBKgCqZjpJsTYyQlaWCwry
         2YPHneQ1X7LTNzcJJVi8nIr10ZWHS9T1DeZCWnnCrml0Er3ktHYIVLTW65sJuJQ0L7w5
         LufA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794330231; x=1794935031;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vqBeli1UK7UsB0colEXax3/fZJsEEio4CkgX2Fv7UF4=;
        b=b+B7reqNnE50iZf61cbPYbDht7vwFl2rJmrEnNwhg1y+742ESkwuF4I/aHnQXi5e8d
         7iW4mBREARq1UzQRJwF1ukK1gh3XWL5K6gHRL2pz6H3HSPQWseBcwGcwmTSSSV1e+zlS
         AwehNpLcnqbZqNt8736IFdCtbJfpBMHtKdXEJBILooe96soyjZ16dGU9K3C7u2UTPAyg
         aoBi454lcqmg7zFuntF09bUchnfe1Mg2codbsm+8n2Y5JLtMFqnhCzCIABg6QnDWfjbS
         yW1zL3hdalIUP8RHgJWMtV/dtQQnKH3pW6EIEh7XMzbkfHX6IDRu/W3sf3OKEU/DmQT8
         DhBw==
X-Forwarded-Encrypted: i=1; AL+hErHoGgvbHhvO7BBEVnCfOstoAzDrh39AP4nGI8qzaapnjQt3KemAwyDUCxNRKZPnvkys9EXN8A==@lists.infradead.org
X-Gm-Message-State: APuU4Z9STz07P3LwdFlI4Vf98hK2CQFBDdNRzDKG2h5GJWVhQAmGPotY
	k3z3J1e/sYfAVxz9hSbOGsVPkdY7+vLRHTR6U3342qFdJ0FIxHbA7WpbjGabWBsJxw==
X-Gm-Gg: AYBFou3OcZCl0abzxNwiZ8kKacuTCQTc0L+iLhn08TNGaYPkaHv5puXTJuiAkgWsUaU
	inUxDmwgjNc5IN3f3hAQdJgeVmzFZRz2H65kEJWR3LM5O3vtFZjF4rvoGsB6WdhpHw5nWxk9o4a
	ACdrBFJGBF0TzNBpD3RJbn9+R+2pDckLUd34prTfhISPu+6zUIKWIVyIs3opjmEBTTjkQwYffs3
	oI4P7jlAMpQ4V1klecwUsqKAtBtHsBWQXfeV0mKx7AyjelrwfJhfpbhbuoFXs3J2SyH3oyhPK+F
	UnCj9fdO6494KBzrRC7CygEo3glcS3BDKen3IKh6CIHL43QmfBTG+uNNdv+/kBgnBx8ztb0wION
	5qzDuqyvdS4QD4O/KkZr7FRPqej6X4+6qhxol0UiptUte51oIhaaGx5g37MKcUSiv4j9VyAsYdA
	eIulv3gxz0KdvcQn4k21QZSSr8QkLzFJODQcK6qn02VO2U8GVzTdLXoik3SI+y/uBVRy3wCUgqX
	Prm4cLVTy4hxCxPthutCQEC4O+ftUyWjTmaG1+m9T2d1oLwrxQFg6rF8E+tFuxRe6GoVnjlD6OQ
	mdR47JCnqtpMob7xYr/7da/m2cOjPgW+GD0imLpaI6m7wPrA1uawvRLfAZJTTmPg
X-Received: by 2002:a17:90b:524d:b0:3a6:e901:e79b with SMTP id 98e67ed59e1d1-3b166cc14bamr3213232a91.15.1794330230055;
        Tue, 10 Nov 2026 09:03:50 -0800 (PST)
Received: from localhost (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b17db85a9bsm514293a91.14.2026.11.10.09.03.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 09:03:48 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 10 Nov 2026 17:03:48 +0000
Message-Id: <DMROZB8DPEWD.W2BFC7JIBVZP@google.com>
Cc: <kvmarm@lists.linux.dev>, <linux-pci@vger.kernel.org>, "Pratyush Yadav"
 <pratyush@kernel.org>, <kexec@lists.infradead.org>, <kvm@vger.kernel.org>,
 <iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
 <skhawaja@google.com>, <sagis@google.com>, <linux-arch@vger.kernel.org>,
 <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 02/19] kho: block: Record the entry size in the block
 header
From: "David Matlack" <dmatlack@google.com>
To: "Tarun Sahu" <tarunsahu@google.com>, "Pasha Tatashin"
 <pasha.tatashin@soleen.com>, "Mike Rapoport" <rppt@kernel.org>,
 <robin.murphy@arm.com>, <maz@kernel.org>, <will@kernel.org>, "David
 Matlack" <dmatlack@google.com>, "Alexander Graf" <graf@amazon.com>,
 <seanjc@google.com>, <jgg@nvidia.com>, <loganodell@google.com>,
 <arnd@arndb.de>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, <oupton@kernel.org>, <alex@shazbot.org>,
 <gle.com@google.com>, <pbonzini@redhat.com>, "Andrew Morton"
 <akpm@linux-foundation.org>, <kevin.tian@intel.com>, <joro@8bytes.org>
X-Mailer: aerc 0.21.0
References: <20261110050202.529473-1-tarunsahu@google.com>
 <20261110050202.529473-3-tarunsahu@google.com>
In-Reply-To: <20261110050202.529473-3-tarunsahu@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261110_090351_980563_CD44EF87 
X-CRM114-Status: GOOD (  16.17  )
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
X-Spam-Status: No, score=-13.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue Nov 10, 2026 at 5:01 AM UTC, Tarun Sahu wrote:
> Add an entry_size field to struct kho_block_header_ser. On the outgoing
> side, record bs->entry_size into every block header during allocation.
> During restoration, derive the entry stride directly from the block
> header instead of relying on caller-supplied dimensions. The
> kho_block_set_init() interface remains unchanged. A zero entry size,

Since the entry size now comes from the block headers, incoming block
sets should not take an entry size at all. I pointed this out on the
PCI patch (16/19) as well. As is, every incoming path still calls
kho_block_set_init() with this kernel's (outgoing) entry size, which
kho_block_set_restore() then silently overwrites. That makes the
callers (e.g. pci_flb_retrieve() and the LUO session/file restore
paths) read as if they iterate incoming entries with the outgoing entry
size. kho_block_set_restore() should initialize the block set itself
from the incoming block headers, and the incoming paths should drop the
kho_block_set_init() call.

Please also add an accessor for the entry size, e.g.
kho_block_set_entry_size(). Users of the block set need it to check that
incoming entries are large enough for the fields they read, and that
the fields of a feature are within the entry.

[...]

> + * Each block header also records the size of its entries. A newer kerne=
l may
> + * append fields to an entry, so the kernel that writes a block and the =
kernel
> + * that reads it can use different entry sizes. The reader steps through=
 the
> + * entries with the recorded size, so every entry is found, and it does =
not read
> + * beyond the recorded size of an entry.

KHO blocks can't guarantee the last part. The iterator returns a void *
that the caller casts to its own struct, so it is up to the caller to
not read fields beyond the entry size. Please document that callers must
check the entry size before accessing fields that may not be present.


