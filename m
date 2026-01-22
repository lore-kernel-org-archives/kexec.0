Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 068E5D6CFA3
	for <kexec@archiver.kernel.org>; Thu, 22 Jan 2026 18:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Sfl+s++fPRdzTiKMIVj4s7ehxijfWuV5r3RCr1G2vIk=; b=twH5EJPWljItCRtMOAZQ1/ZHxJ
	a0IDVKEYUJkLKDIOXmathpK4HR6YEsGLwcQznGFvitIkSgT7QS7h7q0i6+Oqr28tARpPmoRwoWM9+
	+AR2Bsfysyx2gfgVzHqaXI6t6guhCBvSet7/eAkX2FhpPhuePpmkpvA1/bKNZZQ8GLHS6EzVBROsF
	mg7kQIodZIrjx0irPOQjlYPcWDh9UbFRLzgNozM3+j9SnK6vYNzKYgm1rxP590wer+RZWHxAX7Kbm
	lx7NIPmM5ipL1KnbIECh3K0xb99ABwfSBvMw0Gj9z18LpyHz72Q/zAITgk+/yS6LjteauIHDFGyTh
	yxBi1+ew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vizMx-00000007d8d-2mAb;
	Thu, 22 Jan 2026 18:25:23 +0000
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vizMv-00000007d7T-1aoe
	for kexec@lists.infradead.org;
	Thu, 22 Jan 2026 18:25:22 +0000
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-64bea6c5819so1883390a12.3
        for <kexec@lists.infradead.org>; Thu, 22 Jan 2026 10:25:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769106319; cv=none;
        d=google.com; s=arc-20240605;
        b=VvoSPdwBt0r/FGKz/qb2wXzKKs2AdZSW+2DypOJIhRV2llJ0uUBqyfmbpcJt8AnNf4
         m8N/nJIm6xLQhO+LmERoZ3PxLaGzUlK3xYH5BYxLDOJHE3hozSWVPQXl8K3fv4uXl/sC
         1gA3BsmWjcsc+eAdmq0bfC2s4DW8sOIimv1prVgI9lQ/GEwq16hbObtzCGGxmY9V49r2
         iajzILzk3Ssyt6lxSOQeID5TXw0F29YtAK2t1e80nuJ/8LNpbBAX9e6qJ8nNYntaXPwI
         HXglPW7h/XngtX6F373RadMSXJ29/k5U9R0xMIVjBwpzthuViksAlbis9j5fHV3urDjJ
         Y9DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Sfl+s++fPRdzTiKMIVj4s7ehxijfWuV5r3RCr1G2vIk=;
        fh=m+Axi8th0ZMtJHq6runol52zGbAWXlmrmpx/7BZXYKc=;
        b=NHtdEBsfgbvpDkdviQ41PTZkDLis1pVpf4ilBe/y6AN6Si/Lc6O5jHWNlKT19x/ltk
         ec5ADVxrfjbx5jgP/QWXUpBHCTZP3ngtgOutXnjKFUcg5ygM+vZ6BEJAMNpUTh20jSyn
         AEuPA12N0DSSNf5PZ0mIGWwq1BWtuhVTqDLWqlnLw9tLPRBeQfFgBooHCN6nBF2kH002
         S0JICe1DhBGyT8YU315i1Vti7Rw7KaDdw1fHz3Q+aMNWMCYUE2jRNnnAOTtEkn5jrxFP
         1rbZe7GpDObb5CzT0jpqrIDEv24Qo9GITwDXcP1g9hDcOYUAK+zsJuRnB6qKUFKJLWSG
         /GVg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1769106319; x=1769711119; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sfl+s++fPRdzTiKMIVj4s7ehxijfWuV5r3RCr1G2vIk=;
        b=GkzjUVF1FmGLRtDkTR59+rhYkvBOpKkPTHinGpMsARObjCu7sa9Oy1daa8f0GC85QW
         vLQ81d4323PhbecnS6JFhJdNNWmbenRTP00ziHChM787U6ePC7PE4j3/3Scmg8CMSso8
         mEghtJDZmfWihmWpnPEKJAKLmDAKFn0ulcS8PxFi6vSXgUcMDUYc283rrVhRHsWyFvUo
         lHFr1CVzL1IvrJMoyxOF6GZ+np4KS5v5Z3iqxXqvr/WlgFjfhNMb5yavzWtC9E18grcH
         FtXSo9m2/9bRNnI/U1krCoX3TH2gv8lCm492m9hTyYd/YYeg5WqxIOto1ugknQgxrMdL
         9olg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769106319; x=1769711119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Sfl+s++fPRdzTiKMIVj4s7ehxijfWuV5r3RCr1G2vIk=;
        b=dbNevM+TdgmPMsSGGWTQA3ibampI+vR/kaHNKeQ2GIdI+QYUhRn2jacR9MQVySl7On
         zBGyhpFIG9pO25o2nnAUm2uDiX9HJluAUoK/Tg+badFZvrKc5+ZRIlBBIeH0w+O6wUMI
         11FFF0idTsk6RPJsbFFurO0AZepsKkFQJteRTdnP1S3O+96x7LF+SRq+J9J7ci2ddCm/
         zbeiBCS1XQr+XDUUro1cw1PQM3CvizgKB6bZszG8FE7bw/1dCRI9NJcmmPaZA/lZwLFH
         YjHGbpCy9PestT0S1u/unoWgijkWudw9K4VFrhKRIlwoIFkr5RwbouKC8PZOWR5+2/U2
         fGbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXx2uxji9kvE3Ix8gEn9U5fOUp2DYFrc8QVbqJgVQYBQO9ErxNdJ5jg/aUXnjKNx66b2QU6Bw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw7bk5yrEL6AWPRy84T2ptn4jlW0PBd78hk6n/ixLTifaw2YgnM
	3+nyo/LkqXCFEnf4cSR2L76J8pK8dRHaNMDrc+rVAtZEE6PEzoo8kai6KzKBLhncAlc7GOMZTVK
	znEEIcbMv5xxHTrs8OvqND1tB2eyLmYSLQCArcDjNtw==
X-Gm-Gg: AZuq6aJ5ksfqVTuC3cTyVUwIji61uLA/jD5dcjJpKiypz1Rap5EnWUBUcF7cy5uMLAo
	q9slx0XhAZ0wjLjghy97Q2zlCp8XATBBV7/CUkn6iGk3zO/mD18ApgxWerDNAOZAgMRiwn0Pyp0
	QvFrROhKOSz+L9fq9J11h+begIUfwHUPzdzTodWYcjW4QFrmUtol47cWbHYgOd92T3OtI+sSv7V
	eEsQEzdc8GxfBzlMbmj+opPk93oiaUb5+tf4knoD6Rd8QWuRzJf68adowW2a+nzQ+90VJpOsmKG
	WUHw21b/cyZbN5qEZCwGcjJSJA==
X-Received: by 2002:a05:6402:5202:b0:653:ae75:8d71 with SMTP id
 4fb4d7f45d1cf-658487626b5mr327872a12.8.1769106319440; Thu, 22 Jan 2026
 10:25:19 -0800 (PST)
MIME-Version: 1.0
References: <20260105165839.285270-1-rppt@kernel.org> <20260105165839.285270-6-rppt@kernel.org>
 <2vxzy0lscks4.fsf@kernel.org> <aW_Mqp6HcqLwQImS@kernel.org> <2vxz5x8wcdv3.fsf@kernel.org>
In-Reply-To: <2vxz5x8wcdv3.fsf@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 22 Jan 2026 13:24:43 -0500
X-Gm-Features: AZwV_Qi2mnNh0d8uhfT7gi820V4jZHl3-8Ga9SArfokbd4YKFntrUQRwEGR-uHA
Message-ID: <CA+CK2bB18ymLKh8YAyg8O44j5-7ttAfKC-Og-XMg5KQ=O_Xhwg@mail.gmail.com>
Subject: Re: [PATCH 5/6] kho: Relocate vmalloc preservation structure to KHO
 ABI header
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Alexander Graf <graf@amazon.com>, Jason Miu <jasonmiu@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260122_102521_448923_87C1E84C 
X-CRM114-Status: GOOD (  21.59  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Tue, Jan 20, 2026 at 1:56=E2=80=AFPM Pratyush Yadav <pratyush@kernel.org=
> wrote:
>
> On Tue, Jan 20 2026, Mike Rapoport wrote:
>
> > On Tue, Jan 20, 2026 at 04:26:51PM +0000, Pratyush Yadav wrote:
> >> On Mon, Jan 05 2026, Mike Rapoport wrote:
> >>
> >> > From: Jason Miu <jasonmiu@google.com>
> >> >
> >> > The `struct kho_vmalloc` defines the in-memory layout for preserving
> >> > vmalloc regions across kexec. This layout is a contract between kern=
els
> >> > and part of the KHO ABI.
> >> >
> >> > To reflect this relationship, the related structs and helper macros =
are
> >> > relocated to the ABI header, `include/linux/kho/abi/kexec_handover.h=
`.
> >> > This move places the structure's definition under the protection of =
the
> >> > KHO_FDT_COMPATIBLE version string.
> >> >
> >> > The structure and its components are now also documented within the
> >> > ABI header to describe the contract and prevent ABI breaks.
> >> >
> >> > Signed-off-by: Jason Miu <jasonmiu@google.com>
> >> > Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> >> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> >> [...]
> >> > +/* Helper macro to define a union for a serializable pointer. */
> >> > +#define DECLARE_KHOSER_PTR(name, type)    \
> >> > +  union {                        \
> >> > +          u64 phys;              \
> >> > +          type ptr;              \
> >> > +  } name
> >> > +
> >> > +/* Stores the physical address of a serializable pointer. */
> >> > +#define KHOSER_STORE_PTR(dest, val)               \
> >> > +  ({                                        \
> >> > +          typeof(val) v =3D val;              \
> >> > +          typecheck(typeof((dest).ptr), v); \
> >> > +          (dest).phys =3D virt_to_phys(v);    \
> >> > +  })
> >> > +
> >> > +/* Loads the stored physical address back to a pointer. */
> >> > +#define KHOSER_LOAD_PTR(src)                                       =
       \
> >> > +  ({                                                               =
    \
> >> > +          typeof(src) s =3D src;                                   =
      \
> >> > +          (typeof((s).ptr))((s).phys ? phys_to_virt((s).phys) : NUL=
L); \
> >> > +  })
> >>
> >> Nit: not a fan of exposing code internals to the ABI header. But witho=
ut
> >> this the definition of kho_vmalloc_hdr won't make any sense to someone
> >> reading the doc without looking at the code. Dunno if we can do anythi=
ng
> >> better though...
> >
> > These might be actually useful for other KHO users.

In my view, khoser definition belongs in the kernel implementation
rather than the cross-kernel ABI. The ABI describes the preserved data
format and should be independent of C types. However, this is a minor
complaint compared to the overall effort of moving the preserved
format into the ABI and making KHO stateless. For that reason, let's
merge it.

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

