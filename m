Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BCC606A31C
	for <kexec@archiver.kernel.org>; Mon, 16 Nov 2026 22:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=2hmP4wJJ;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=ktVYOIh5
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=k7+WvZ0aOuqDrQLrk4s8LJ2lZixNWnQh+kPTnMGEgEw=; b=2hmP4wJJr7kO4b
	VBWZb/bcfjTT5DwAzBwSjGKSDT2hPktR3lPFf5+dHug9bCKcgaVwxbwBh74Sh4qiig5mYAwhWmlqs
	ZTdvuQWDW9bc8EYPvw83A/L/4pS/hg8/x/jbUm/6nIh81VGUXqHtsWe9Lr2JMgpgp8pWXTFCfdS/p
	rTWptS4RmcvPhaP82+x93QfePvXaQxTXvwktYYdTqmRkI79szZO525+nxMDD4jBL7oqwlKEJYT7YA
	Zv6Z1RKJFXrU55u+OBtxTtkMIXvYjXlidgpVM6pWOwZZC1b0sALIbud/vQaop1XekZBbere9pNu42
	u0RLq1L6woBDFYYNJYPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xT5SO-000000044uO-2g7D;
	Mon, 16 Nov 2026 22:45:48 +0000
Received: from mail-vk1-xa31.google.com ([2607:f8b0:4864:20::a31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xT5SM-000000044ti-0UE2
	for kexec@lists.infradead.org;
	Mon, 16 Nov 2026 22:45:47 +0000
Received: by mail-vk1-xa31.google.com with SMTP id 71dfb90a1353d-5ecde8e8e5bso1194769e0c.2
        for <kexec@lists.infradead.org>; Mon, 16 Nov 2026 14:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1794869145; x=1795473945; darn=lists.infradead.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=k7+WvZ0aOuqDrQLrk4s8LJ2lZixNWnQh+kPTnMGEgEw=;
        b=ktVYOIh5V5xEiVIQ9ExxDLL5J7KzQjwwEtVE19TzExkYHKhz5j8Xru++6RUhQCBDPJ
         fsbg0xfSYbnIIgw5wIJ4Dj09nU1nfvU5M5T3+92fkd9gxn59cQ+zFEMH8l0WKd0dATk4
         2ZnyTiPJ5IoAlOy0YcmI2iTN4U8wymut8ZFGQiR2pp8OAsc2uEOTS7bAJ5xS2Fu2zq4r
         HrrAZloSJypeCu4O9ObEpyq03JcQ+MG/WZ4kAdfJIevZVKzloY7WrpKS0orMVPpBPKr+
         gK6ugT8xxuA5rbbo++/Knao43sEGe8Jux9H3cpQsyHpgsTj9A1rAeYuGVlpKs+odR7+U
         XbhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794869145; x=1795473945;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k7+WvZ0aOuqDrQLrk4s8LJ2lZixNWnQh+kPTnMGEgEw=;
        b=jMzVaLjSWiUCssctLBrHoQ4GW/XYMuf4J/0kVL6OEQqTNXApIsWFKyv1KLs4qxx4+t
         VcxQjaJeSpdC8Sd9NaG+foWZgxaHMSLk7gKMH/KxqOKaUEIalRVHPf9yWfOJ4IbW+B+v
         ld7Dcl56+GpvZzQ4XStfdIJiYM92Nz+NcNSRL1/xNoCbB+mrrBR57hGbatwBn39W8Gpz
         fVQaJGSZ4eCHXt3CjJCqO+fbNWOzqp0dyAtnrXABXe4LBTPHne6kCWjZBXPnNPio8gCe
         /Hq7YLqhrpmYN8XqGQplnSpQRSo2GXz1urYamsQplhzhPDpdmPdQBzGoDxuj21F77AhG
         Vugg==
X-Forwarded-Encrypted: i=1; AL+hErGwYLltQVGyGvbUTNyCEYYIoV48mzpd2I9nmFAM8FnqQapIF+boBXNNywzJXr0zn5p4u7iUOA==@lists.infradead.org
X-Gm-Message-State: APuU4Z/IX4HCRrES0GDktFny4UTRSb1EeMngz9r+2IKyqHk+tnsIoUl+
	CsYuZ5eHYiCpUFczWq+8IyAo8FmMxbzlHNLeEhYPBDw9zAJOEiC1lVRvF1BktOriZRQ=
X-Gm-Gg: AYBFou1WJQmuvWUoYnH/94N/jfiFAABun1GWne7paiGO5s2K+lozcTTbKjmwxzouo02
	uXUthtysJIsqiXrLiB+Nd6YptJYZL24qfRBCfuJiFDsys0OfWmsDXIfoldgUJiQMf5zi0RCxOhe
	aeK4VKHgm3MLoXz3ona1xV1JzFzrhVECv7uCh0ivaVnchIZfr+8vKU7hMhSEvkvEZJRzxH0/YL0
	A8I1M+l0zgM8o3PL0pK4AanipJvd/p5SGkDlrSH81c2I86ON+yOe+/ncTgISXTXe6CiuMZ+N/Ut
	jISiFUVF1qutJutftYfsYa2e+VwD6aluzgqQmZzjziG7RErgRRSzRly4pGgb9+W8/9R8XxfsyOR
	AffzgcWmAIAXDgs0dJDDu9YABZs8ChmozGp0tv4yZw5Q50U7xjepD8zAkacyf5ZXO3BBu4zWiFA
	8ompOSfH11Q7QJUfdDjfBoIP/DcoOtIolA5NsrLENvefR3/n1I9eoOK2vWrueVVDsc2iGMALMrl
	tIIuApcQdI2vmZJzhywRgz1jmaAAtUCW49IxUYE/FcJYqTNhWxnFBDN36TRJ/3iI3NT065Ixe+3
	ZCscf2eVTB14f0a3PWN7zVH8TGzP1yRfcY1cMb/ZNkCgiOS51JOpU38BPT21fmljUrbEfbypL9W
	J5x01Ki3yWlnN4K346O8TPjPIm0Z46vwus88NpPnY3lqY7xw=
X-Received: by 2002:a05:6122:1d45:b0:5ec:e128:2c19 with SMTP id 71dfb90a1353d-5ee34afd185mr4178359e0c.23.1794869144703;
        Mon, 16 Nov 2026 14:45:44 -0800 (PST)
Received: from soleen.c.googlers.com (57.233.150.34.bc.googleusercontent.com. [34.150.233.57])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee34e3137csm7011494e0c.3.2026.11.16.14.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 14:45:44 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [RFC PATCH 0/5] KHO map
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Alexander Graf <graf@amazon.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Tarun Sahu <tarunsahu@google.com>, David Matlack <dmatlack@google.com>, 
 Samiullah Khawaja <skhawaja@google.com>, kexec@lists.infradead.org, 
 linux-mm@kvack.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
In-Reply-To: <20261116134013.1636689-1-pratyush@kernel.org>
References: <20261116134013.1636689-1-pratyush@kernel.org>
Date: Mon, 16 Nov 2026 17:45:38 -0500
Message-Id: <179486913878.127049.11178890384802388709.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2994;
 i=pasha.tatashin@soleen.com; h=from:subject:message-id;
 bh=B4tBNQ1Z7VdtzwiInC3mDSvjqCs8TTj8AJu8ec5+Ftw=;
 b=kA0DAAoBu3coTNtzet4ByyZiAGr7h5ajw+EgnwLf4K1QE3Ey3wBrMuunsyLKn4FwzG4JaTR09
 IkCMwQAAQoAHRYhBEExqpPstG8a8H82Yrt3KEzbc3reBQJq+4eWAAoJELt3KEzbc3reexgP/iNJ
 9wngObtxeMjseUrGIZO+homrx001i5s30BEDOoxaOnc0JLX0k6wLSKqgU7aGykiWFCsycGxxB9b
 c29M5wS9gxdM/pcu2Xw5N70dBLhpdn9+haQci07V/zrd5lMrfphNFYZwqjlWwbiALzVcssvLiOD
 6UbaXW4F2dIngPseFhAnnXLKgfrn9J2HpO11t86+d5RTjj+UTj4pu7l8ZmzffBTZJS6uGXWkLGQ
 E7FhU0knsnp/EwrkIFEdlfVxywUvoFyZT2KmtpAFNboSsJrJmJR1W/gr2ReuSMOPwZb+36pn307
 qlchMHGrpkxxKYg8XoyuNXO4eOYHIPQiVkDGDYNoKrUYJPsuuuyn5RpSDBSpBDFbr8ZK+sPZWPu
 TZnI5Aexi2UPJFvXfvNhWNCaeUOUQMSWrbfoTaYNF534mDaCAKajs3cssYoD04PdOruWTDEOt+8
 oL3aJMyFRagxw4GQT9JZB3SLi4tQ/i1ym1rDfzxbdrAVVIbB7noxj+h+2U6Rj7W6bJUS2gnIc8k
 H3OrBYHeSS6ccJcuolC8taHqSp6qIY057JLomhydU/L2vC98fy5zipt4VeLuYl1Ty5BUAbmly34
 UZJSzl95wNhO1dpC/V5Uazz1WvnPgP/MCzzQDw/eXmunJU6ptZeKCrcSEjxNavBkmfIr08kd8Bm
 P9lPZ
X-Developer-Key: i=pasha.tatashin@soleen.com; a=openpgp;
 fpr=CAAAB722DD22A081F0D49F35633A6A993D43B569
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261116_144546_190135_CD0233CC 
X-CRM114-Status: GOOD (  26.20  )
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
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
> 
> Hi,
> 
> This series introduces the KHO map. It is a sparse map from integer keys
> to u64 values. It is implemented as a radix tree of fixed depth.
> Currently the tree depth is 6, so it can support keys up to 54 bits
> wide.
> 
> The main user of the map is memfd. Currently memfd uses a vmalloc buffer
> that has a pair of {index,pfn} to track the folios in the file. That
> uses 16 bytes per page. The KHO map uses only 8 bytes per page with some
> overhead. So for a 1 GiB memfd, it uses roughly half the memory.
> 
> In addition, it is a more versatile data structure. For example, it
> allows for adding or removing pages from a memfd after preserve more
> efficiently than the vmalloc array.
> 
> Post-LPC 2026, the plan is for KHO to maintain backwards compatibility
> as much as possible. So this data structure allows the serialization
> format to be more flexible to future changes. It can also be used by the
> upcoming HugeTLB and guest_memfd preservation.
> 
> I have talked about this as "KHO xarray" before, but I think using
> "xarray" is just going to confuse everyone since it isn't really a
> xarray, and the API works a fair bit differently. So I renamed it to
> "KHO map".
> 
> This series isn't complete yet, but it is in fairly good shape so I want
> to share it to get some early feedback.
> 
> Things that are missing and planned in the future:
> 
> - Multi-index entry support: currently, while the map is very efficient
>   with 4k folios, it is horribly inefficient with 2M folios. Each folio
>   in the memfd takes up a full page to track. Multi-index entry support
>   can fix this by tracking entries that cover a whole page in the
>   previous level, similar to page tables.

Let's fix it, see below.

> 
> - LUO versioning support: LUO versioning headers are still in
>   discussion. This data structure should use them for future
>   extensibility. I am mainly waiting for things to settle down there.

I would not worry about this. If versioning lands first, this series can 
be updated then; if this series lands first, Tarun will update his 
series.

> 
> - Dynamic depth support: Currently the depth is static, so it can only
>   support keys up to 54 bits wide. Adding support for multiple depth

Let's allow keys to cover the full 64-bit space from day 1, and make 
values 63-bit (like XArray), using bit 0 to distinguish a child node 
pointer from a leaf value.

By making it generic from the beginning, we won't need to worry about 
ABI churn for these features later. Instead of caller-chosen depth, the 
tree should grow (and shrink?) dynamically bottom-up based on the widest 
key.

Plus, with bit 0 tagging leaf values, 2M entries can be stored directly 
at L1 and 1G at L2 (on 4K pages). Even for huge memfds, the pgoff space 
is much smaller than 64 bits, so in practice the tree stays tiny in 
depth.

-- 
Pasha


