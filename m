Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D02606D83D
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 18:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=U0KaU+FT;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=T3kUBi31
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=9KIi3oyLyMDdsznEK7o9dw+bnJIKiQjdBXnibwTcAOc=; b=U0KaU+FTm44Bkl
	LTsDLiZjeZAEBxLlsxX+r4amCaOx5estNNARvvvT5dWIFPib4S2+JyUqrzjICMhX/NX9MFmEVOVPM
	PKSBdrIrJX9xvcSgg4v/CwpVVUOsRML6FfF7v+I3a1B8K+3NR/jZsNgJXt6LLoukR6HDpodfLOgIq
	SHzDwGJw9YKnIzsonFBuWoZMBY6ymevKnxibxKIv10q08ybi49DTuKF4eJhRJ3p3S0czUt993YWHI
	VFj5KewWEemKdSqjuEDKMbEkVQqLIQE8A78cWbLHbzP8kvmOC1NPfvCHkzuvI+labtKCOS8wEGMcg
	7VNTh5ZP0FiKW2wmhKZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOgAk-00000006UC8-35SV;
	Wed, 04 Nov 2026 18:57:22 +0000
Received: from mail-ua1-f47.google.com ([209.85.222.47])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOgAY-00000006Tma-3B2v
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 18:57:17 +0000
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-9907a58f14dso307009241.2
        for <kexec@lists.infradead.org>; Wed, 04 Nov 2026 10:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1793818629; x=1794423429; darn=lists.infradead.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9KIi3oyLyMDdsznEK7o9dw+bnJIKiQjdBXnibwTcAOc=;
        b=T3kUBi31dAnnkFLYD7z01ADjDIoEpkEVkvbKU8h/HQkqFBuZru/x0sDvUIMHoHZ3Pk
         5o7W3SUlFKoPHYQGbHxB3b4x+5oA5RRYRYC+E0Z9BJ/Lg6IEkrUvEEVt+Y7Aj/ylIFmH
         YOTEW0U1xkE4Zagc81ckmbSiQwqS5S52lYfTHIf/RUQxKTz0riDcNfmvJ/kOUrc6VUeo
         q/Z/s8mHT8n4JjyHK8PAXCr1OPUSGEqQ/bo6GqWgEX5YSQvdSnr76lNaD0XFX43C/mSu
         LAUfN6negdxW5NhJzLJqTl8qDqsO5nI6cryPhyh86YJrc2VigfmnxdEIl5foKZktVNcg
         Zpmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793818629; x=1794423429;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9KIi3oyLyMDdsznEK7o9dw+bnJIKiQjdBXnibwTcAOc=;
        b=dqkAj2NGwdKcngUPI4z1kSe+EN2w2V5ixNAPHnFGfCCcOKX45IFr6DNwvnAycrk5HQ
         fYjHArYY9p6PApzZRgz/lkaHXaVumvlsUxDooHnvD/9Wp3QuAPpZyAgQMzkoWzq8QdTZ
         5/HEbguPMtAWc5+Ta02xWDios3DXRuX/IBt5UhCX9CKGkKHt8Bs7kh/RZeiVEHOnP2rK
         ystjReT+PTKWtcO7V2BxVFsiBHNURvMyhD6Z5sJWdDODBPmO6EjL6iNcksoOWKqjiEk9
         m1KiREmwJE+KVzDDXfcbUWRUttkNSz+QXmdR71AxWA2j4WCuFFzsJHaJQNfdaRWC0E1O
         j70w==
X-Forwarded-Encrypted: i=1; AKwUvBxgniyMj+bx7LcQdPG9c0faT9M9n+eyR8qU0XzmtvnsFTjoH3Xx0Q41AUSD4Dp1MEmKgNpYzw==@lists.infradead.org
X-Gm-Message-State: APuU4Z/LxqMNZ/RLAO/kQR719T0PsNQPkC2VCb2E0Ktj3TzgDjGXmCYd
	RlwTL6pAsXHcBnmNiYK2Q/br0Cyd3/vJ62KII5OUcdiox2JbSCgf8FrRQtryRpwcQZc=
X-Gm-Gg: AYBFou2qa+GcUK1DncOJy13wPYFAZLwkNKmTw7sNh2q+0de5aLWR/UvKlYo81S/Dr1o
	rFI21yaRoDSvJKDmv3uqoPzJYcx3+DGA1bg+rkiR0icXBc/5oOwY1slQboPxSM0gBhyc/zkYIL9
	/o7TCLW0w6CQ9gr+b52TVkl+kcrs5Vz9xSCmFhjbp57Yoj7l7I6FLdh+Sbm4RRgUsr+dVg3DkXy
	IbTVO6V2P17VXJ19Vb/HdfBwyEilpE+aBqWzquGVyK8he90uNQLrsmaSdbHB/aLbfABI4bnTBPV
	C7txHOgzqkd5bpyF3oN42ys4aSFg6gRaXsacP3SFKht7HNJoRYybkOr+0VjVJUloVNQX8XOUTF2
	QWvz+4BP2pnPR+VokjV7Wnbl076T58qu7rrRn5J5lMhYFVDLz62USocoocx1PljXIPEMRFJyq3v
	nnU/kAXCBcMvjmhP9XUmAzkNpoyOjZxO5wcSgPiJitAGvJ4NMkKcQX57Sf5icOA43AkI1QN7o1n
	OQz9fU37kjIx9lluwCKzyLcN2Tz9onedFx7xoXuwHWiynzzd6x1w5DEsriQO+eemjjf8d0MrmxJ
	ZXzPWmFjOQf0C/JCFT/XTee+vuKrYwLXowiyJnaFC5rZ9baQpTbiB4CqG03vGCY+3xQotEE0UtS
	YdVd0CVomn23geQySH6M6CIPrsfTd4Dh0P4NLupnIwrOv
X-Received: by 2002:a05:6102:50a5:b0:7c8:4efe:5243 with SMTP id ada2fe7eead31-7d072c0ccc7mr6799566137.14.1793818628571;
        Wed, 04 Nov 2026 10:57:08 -0800 (PST)
Received: from soleen.c.googlers.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-999f3006224sm736210241.9.2026.11.04.10.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:57:08 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 2/3] kho: skip zero-sized lowmem and global bootmem
 areas
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Chen Pei <cp0613@linux.alibaba.com>, George Guo <guodongtai@kylinos.cn>, 
 Kexin Liu <liukexin@kylinos.cn>, Sourabh Jain <sourabhjain@linux.ibm.com>, 
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <20261104-kho-bootmem-sizing-v2-2-b0d1a834780f@kernel.org>
References: <20261104-kho-bootmem-sizing-v2-0-b0d1a834780f@kernel.org>
 <20261104-kho-bootmem-sizing-v2-2-b0d1a834780f@kernel.org>
Date: Wed, 04 Nov 2026 13:57:03 -0500
Message-Id: <179381862329.2089669.1920221634983746197.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=659;
 i=pasha.tatashin@soleen.com; h=from:subject:message-id;
 bh=tKyyhUM8sc5ijUZp4wf8V84jsKcj0GIXLoP8Jnk85qM=;
 b=owEBbQKS/ZANAwAKAbt3KEzbc3reAcsmYgBq64AC4+9Eu03z8RndZYwobpMiNfkTgoWl1nhsO
 iersuVtwoCJAjMEAAEKAB0WIQRBMaqT7LRvGvB/NmK7dyhM23N63gUCauuAAgAKCRC7dyhM23N6
 3n+cD/9jpTwQSZe5gdGUGgfWk1XEfJgiRBBToUCD7hLIUPN0f/0cdUwMSaewgWjnIEdWwmUI3cX
 AQ2dyOIItN7AdmFr/dPD833nnnX/GdMvITYVd0Xp9A+ElDgvYS2cRlizoNWpRZVgIW49L/KZ22x
 Fvxr8Vctlg82aQ1rWm4Bpc14mlvduoD8+N8LVGG4wFoun/qTG4YvaV0LWvtGBLHZmFYLecwnDGJ
 IZJ/Uz5AS7D/VdLvWF4RF+7eJl4JMt6gTQEbdeVfcZWZCX+p6vOkkyX24Iy110qrrdvVFaufjpr
 XseoEn/cLnxiIg5Yzgun4qT+CpoEn/W8JjvwznOw06geQzUafuFQP8yHbMSdgWfOiB6HkfPfoCP
 QIALgM4Q8u7r3PcQpJd1VnQTXuWMPCV8vEzj9tiw1TJvhkujDlbDoe1JCPlwBAQJibSRhqvfqec
 l1dQMbzMd2oC0wRKBz0NKMkxxZdbYTt1tKClUM1hLhwEyqqi1yzARs6jOnIr1X7Ey5qOPYZ5ouj
 KFoj7dpUPeJgE6Gk7vA7t4+VOXxl0yO09J+ST0GTgEGrSmaHibGONMY4E3yWtcEgJTz7a+koxFn
 J8DSpcUQhLmuEq640zd8Nre2wC3ZFqAsZH556R6i1tFo/QoV0ka++Vany7L1zJajvRx9pUeiLPm
 cZDHnRFI9/6kMmg==
X-Developer-Key: i=pasha.tatashin@soleen.com; a=openpgp;
 fpr=CAAAB722DD22A081F0D49F35633A6A993D43B569
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_105712_770251_928F93BD 
X-CRM114-Status: UNSURE (   8.48  )
X-CRM114-Notice: Please train this message.
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

On Wed, 04 Nov 2026 18:50:10 +0200, Mike Rapoport (Microsoft) <rppt@kernel.org> wrote:
> The lowmem and the global bootmem areas can have zero size, for example
> when none or all of the memory is below ARCH_LOW_ADDRESS_LIMIT, or when
> either of those areas is explicitly set to zero with kho_bootmem=.
> 
> For a zero-sized allocation memblock returns an address without reserving
> anything, and that empty area is recorded in kho_bootmem. If there is no
> memory below ARCH_LOW_ADDRESS_LIMIT, allocation of the empty lowmem area
> fails and KHO gets disabled.
> 
> [...]

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

-- 
Pasha


