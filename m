Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A682E606A32C
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 00:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=yNjCL/fM;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=M98eht46
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=EyfJTg/htaOWoI7HDaUiAyqJ6hW+/dz/pp1CnZqfneQ=; b=yNjCL/fMLYbiOQ
	v+isLh2Q7Fwu92tnjmb5KiewpG7kj/zcSq62K0m/R8L0heRW1Nmduo4O5/SSOmip8W3O6mHau4EJ1
	hGajv7vcgmzIhrykrqc90QegqQXKtsgclhQYYMR/rZheGttdtfsrmbTwYmEVdtrNtFd6QMZ1mJOIi
	vO4utML6MaFNB1AbVigiBQzuGl1qfnJJKgeciIeF3y66/emvRukbgg+Y+MmD/z1DASwYcnT33IVp4
	zQNMB1Cguvh5c7Ox3Y0kJs3A9jeCMlL1KQusn6CZXqaMnphUIAy9eVqOGq2krOLtNaK8QUeHUisWR
	t73xtOQmyrsfRHyO1F5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOP6d-000000040rQ-1Qbt;
	Wed, 04 Nov 2026 00:43:59 +0000
Received: from mail-vk1-xa33.google.com ([2607:f8b0:4864:20::a33])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOP6Z-000000040pI-3hcR
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 00:43:57 +0000
Received: by mail-vk1-xa33.google.com with SMTP id 71dfb90a1353d-5eabf243d05so37038e0c.2
        for <kexec@lists.infradead.org>; Tue, 03 Nov 2026 16:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1793753034; x=1794357834; darn=lists.infradead.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EyfJTg/htaOWoI7HDaUiAyqJ6hW+/dz/pp1CnZqfneQ=;
        b=M98eht466iNabryvC3gofiwU/YsH6Rr7++D3XxxF0DToDgYmXUxVYXM1ybKkQUSF4u
         YZhJyLq/O7If9UuWlWe2NtlreQfWKdneVrQp+5nJcKHk9mK+XkIRBqte/4ZucBtoFBEJ
         TOrSUAkvA7oGqJfeRIWVeWWzqdDlxQ2EPNfT2Rmuxf+iAVRI+WdNM3vHDIkoAmTmAMNV
         DSnbchmbdAEutG5X0I3Wnk69LxwHdBPrL3UXk3VZlMIArzuIkAXjLd3XhDfpN022dNLh
         w2uFL3xN4490SWMEinM2lAt8NOJNfuRYnW2dhI817OLIxeDD0WLNmRAptXuUkEBGXYr/
         vPkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793753034; x=1794357834;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EyfJTg/htaOWoI7HDaUiAyqJ6hW+/dz/pp1CnZqfneQ=;
        b=axAQVaOj+x6PnWwDkj2VX5H2gnv529N/UGXzXPm8sE6VtmNLPseV2bkiySAOOC3K6D
         NOAcp31Fi8ekETyaXpXfbaVRXQbROML5mzfD7fSHt/sC+NiQ+24mp2n1JMByMJR1M6Vs
         HFS5phD6rs4YzSGCVJToFg9xIpV/tHVFo0BYf8/UxYJBC34NFjY85r5kKQLmvWwgdZas
         xhLuc2u+lmFz52dot8TO2Ei/jxovCiz2aZ6UTQWcd2VHRkitRMu7leL0i47QzJil2cyA
         C6/Z7Z202WKeBrl8a/apQc+Sp/QZwVDJtJcD0YTTxEN9arwYCQeqisMw79+rV1XC+zMF
         Z25A==
X-Gm-Message-State: APuU4Z/KtN1Rl5qazXBeCc7da9yMyHEz4ZWEXCqA2lRsiV49sJd2Sk7R
	iEPf0zoCKngdoln/49/Q3AoR1N6kjmzilRdAGSgzaz21MM/CZBWAsrZy0yGncJRVEHU=
X-Gm-Gg: AYBFou3WG3fN/zZ4me4EsDVk0DiTpE4VnFVMRJQLamdimGrm8JWMJxw/1sfbSgYs45I
	IZCYZvr8gxyaJl6dtXxg2H/TCZNckBkozpqN/NkdxgVUrOSwIA7ctRIhqzZSPvJhW9soYJtCpwI
	j18BMf8Pe0iUFm96FW5PyTJLAINlvu9WwPEBcPEWK+Oqn3Y9C1so6JX6jn5iD5mlKzNRArfTyPg
	BzPzie+h5CD3foN9UohqS/FUIZo6o8osfD3ST5p2mGC7DoPtBe34wwlW620eNtMkGepPgNkrUDe
	prW5NVjrhJC+rEt2elAfQQZkcTH+LG1JaVvpCs2TBT1Eh1YGJt+uspZFMWkqyDh9D8Tsiv4QY+M
	fGGXSJAQKQUQwnyySNMsx0m+O05fQaJoRiA+r/zUvd+7M5YCejGp0/LEcpcIqEljxZARcA8/hYY
	eenm2Z+lpyyAn/ssk2HTrAiZ1mNIGM1tDJ6dDfsUBbPE1GJecLHDbgTtwZCSD2eutAgP5R6kuQP
	eMhT9KkTHwGpqVPHsmWnVY3wJ082SeftxhwIlxZwLJLn7tV0Ak7SbVZtmagJ+URAm53rpgQr8l7
	fssiXW75riCCd2CaTzzXXQK4QK6+CG/8KbnhBNgLSPF5ZsiDnIUGaxx2eMDbb+Pn4UIAz2K8iA7
	KMaYS4X9iok0F3L9VvRtwzaMA2Iq1t+fpbJIPnuZzt0Qqug==
X-Received: by 2002:a05:6102:950:b0:7b3:8f0a:f76c with SMTP id ada2fe7eead31-7d072bb3726mr5566509137.13.1793753034167;
        Tue, 03 Nov 2026 16:43:54 -0800 (PST)
Received: from soleen.c.googlers.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d26fef4ed3sm527432137.11.2026.11.03.16.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 16:43:53 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 08/10] mm/shmem_luo: Allow preserving tmpfs files
 that are still linked
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-mm@kvack.org, Alexander Graf <graf@amazon.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Christian Brauner <brauner@kernel.org>, 
 David Hildenbrand <david@kernel.org>, Hugh Dickins <hughd@google.com>, 
 Jonathan Corbet <corbet@lwn.net>, "Liam R. Howlett" <liam@infradead.org>, 
 Lorenzo Stoakes <ljs@kernel.org>, Michal Hocko <mhocko@suse.com>, 
 Mike Rapoport <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
 Samiullah Khawaja <skhawaja@google.com>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@kernel.org>
In-Reply-To: <20261103010216.3447716-9-dmatlack@google.com>
References: <20261103010216.3447716-1-dmatlack@google.com>
 <20261103010216.3447716-9-dmatlack@google.com>
Date: Tue, 03 Nov 2026 19:43:45 -0500
Message-Id: <179375302574.727293.677909304544098007.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2473;
 i=pasha.tatashin@soleen.com; h=from:subject:message-id;
 bh=1h1grQaxg7q4T9eJCUz9ZsqoACadg1b5gQXNPrb1T4s=;
 b=owEBbQKS/ZANAwAKAbt3KEzbc3reAcsmYgBq6n/EU+OcPsgUfVgNKKD+WCk3F+OtwPL5xys0P
 a20L7buUNWJAjMEAAEKAB0WIQRBMaqT7LRvGvB/NmK7dyhM23N63gUCaup/xAAKCRC7dyhM23N6
 3sphEACiRjymhOf/11oc2wbD8SRoiRXnFKXUYIkVDNP2l3c3tTjP+YijRPjhr/brHhBpu6LOFQc
 qfP6dwNcaAcZx2LZPoXKS+0boalahbWnjrkPNCikh/U6wyunhVlh+urHjZkJwOwmQJ5pfkpLY//
 dy2NLWahrBsKcIQKycF4895PqmSLnx2ztARj+Q8Jr25/ug9GyeTlHFdXnqjMjvuoHAN7ZSVQnXp
 Mnc6QtURb7fjRoNwkBJyiC6zjGlDtqt6MKKQ/CplargM5cyEXQxT8qWPkxk2gglkSlNMfxY3gE3
 6gf0D4WejMbWxcRdueHqdZl+rdZ5nTKsXsqupCnANMS72X30/7lcpRSB/hRl1BpV/3jrhNSqcqA
 ze3csLEhuDcrp/lXRRVYLsDh6Is9PJ6tPDb9T1Knyi/VrMGkTSUC8u2tpROYgkC1/Zoe9jaLkW4
 moEhvwwEAxKDXQ148kswxGlnCaJvzyfWXjJtBEz4c6bSmfLPzjwTEnmC3Sa6qrPvyZwTgCp8snp
 iv3/fx/KILbSbVJG5LO13Pb17QNFYUEp3fo/kzhxB3xJRZ3i18F1v8T9pkbnx1v+CTMTd4+6nAe
 GZs9Ru4nEGOFHIKVBBNu+E0FUeUcaa6a3sBAtbEVawHXo2Ny69+lzr1hTwZzARstZy7A8PKfVmJ
 H2RTjBl+HEU2E5g==
X-Developer-Key: i=pasha.tatashin@soleen.com; a=openpgp;
 fpr=CAAAB722DD22A081F0D49F35633A6A993D43B569
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261103_164355_943392_38C9BDE1 
X-CRM114-Status: GOOD (  21.69  )
X-Spam-Score: -2.1 (--)
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
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> Allow preserving tmpfs files that are still linked. To preserve any
> file, require permission to write to it and the file to be opened for
> reading, and reject append-only files.
> 
> shmem_luo already accepts any shmem file without links, which includes
> unlinked tmpfs files and files created with O_TMPFILE. Accepting linked
> files means that userspace doesn't have to unlink files to preserve them
> and can keep using them by path until the live update.
> 
> The path of the file isn't preserved. Like other files from tmpfs
> mounts, a linked file is retrieved onto a tmpfs mount chosen by
> userspace, which can then link it at the path it wants.
> 
> While a file is preserved, its size is frozen, so truncating it,
> fallocate() and writes past its end fail with -EPERM. For a linked file,
> this affects everyone who opens the file by its path, so a caller that
> can only read the file, e.g. a world-readable file in /dev/shm, could
> use it to break the owner of the file. So require permission to write to
> the file to preserve it, for all files. Like FS_IOC_ENABLE_VERITY, don't
> require a file opened for writing, so that binaries that are being
> executed can still be preserved through read-only fds. Also don't
> require a writable mount, since preserving a file doesn't write to the
> filesystem. If the size of the file can't change anyway, because it is
> immutable or on a read-only superblock, also let its owner preserve it.
> Don't let others do that, since the size could change again once the
> file is made writable. Like FS_IOC_ENABLE_VERITY, reject append-only
> files, since their writers can only append to them, and freezing their
> size would stop all appends.
> 
> Also like FS_IOC_ENABLE_VERITY, require the file to be opened for
> reading. The retrieved file can be read, so otherwise a caller that can
> only write to a file could preserve it to read its contents.
> 
> Preserving a file also fills its holes, but don't require any permission
> for that. Anyone who can read a tmpfs file can already fill its holes by
> faulting them in through a read-only mapping, also on read-only mounts
> and for immutable files.
> 
> Document the frozen size and the permission requirements.
> 
> Signed-off-by: David Matlack <dmatlack@google.com>
> Link: https://patch.msgid.link/20261103010216.3447716-9-dmatlack@google.com

Acked-by: Pasha Tatashin <pasha.tatashin@soleen.com>

-- 
Pasha


