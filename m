Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37FB606A32E
	for <kexec@archiver.kernel.org>; Thu, 12 Nov 2026 15:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=IrjeCLst;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=ZDTLKG+v
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=8yYqy1tuA0FyJjrVSCVgV+Doj8Jl7Ml/5bTTP3YOpXU=; b=IrjeCLstpzEMOe
	kWz0FyIa56v+HaCC1OapuB0DJ5PNlG5pzxLjKv+fVuHIhWD8L3at3GHaJVCZ2DVCXnHYoltTRGZeH
	kwGiHkHrkwIBL+WJ+ByMy6JpmRSjBqZ3ZIKT45tMDYpBq6rvyGPZ5fWVXMhwmN5KD/BW1aDIb7FN6
	aj57zTniz5ceHx1ilrdVc9zIua2vHK1YOdJGeN0Jn76n99oi4LPtAhBNb5Mg/NlRSa8M1dkqi52qD
	p3xxacA2vdZqpyzeNtL5VSg1UATpjUA9TdkM54pdZIC3w8JN8Zm+1y1A6+FUITjljKpXa6Y+4gU7b
	tHLPUizO/R4yHSif1JCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRWI5-0000000AMqj-2Dgn;
	Thu, 12 Nov 2026 15:00:41 +0000
Received: from mail-vk1-xa2a.google.com ([2607:f8b0:4864:20::a2a])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRWI1-0000000AMpl-2cby
	for kexec@lists.infradead.org;
	Thu, 12 Nov 2026 15:00:40 +0000
Received: by mail-vk1-xa2a.google.com with SMTP id 71dfb90a1353d-5eadef147ffso2264544e0c.3
        for <kexec@lists.infradead.org>; Thu, 12 Nov 2026 07:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1794495636; x=1795100436; darn=lists.infradead.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8yYqy1tuA0FyJjrVSCVgV+Doj8Jl7Ml/5bTTP3YOpXU=;
        b=ZDTLKG+vXHw8yhmFJsP2CyUXr5sKbyObAv+hD/LyFe33k0NnZLAX2pTS0ErYL4eWMR
         I+IQDbnqLzGTCNFMXToYFJcLAEu85q2CuYrNDmvgz8dKSbxvGjYw8UP0iqseoSMPY10b
         23RCSyYR4WSK+Qp7F7vIjQpLnqO7ZK3J6298ntMurLUXWgQWhGeGNWdXzLJ+zIFJOK7K
         agaKhNoP5Mkcvn6HlvVacq1k8P7WKf1sGz3J2KCQ6+nm1lbOPRljxj/DQqFnh8JwGesn
         AWJ5nuEStdJ0R7quQUue13Fj5L+kSq39HoMpPq4NujQFh5tLsu9TEL3ScmUproZzXJvg
         g19A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794495636; x=1795100436;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8yYqy1tuA0FyJjrVSCVgV+Doj8Jl7Ml/5bTTP3YOpXU=;
        b=zT979fHgtredc3OOC04SPeJOFadBPRnxnu1Rg6Hd5pKR7pyV61rkzq7EuUBjzuNOtz
         VtomGUrB5V4olMP9DcNQyRXVxFpVvZNrGwdajJgyOBFILyIx7E29AsG/3MLIurdi+L1W
         DNQQ4zQQCzIS8MIuBDeJ9Nkr5L2WdoeXQlOK04w+kon76Exj7JORKpCLM9yY93m0Xz2E
         HCe0H+unPN7aEy2GEQ/m2a6ays8C0cjpS1TGvDrJ78rxH3y6h10SHXbtwDDcPJS7fe8z
         rYBshH4evGI59DrvJWf4rNeoSYlTT05UdvbfvIy4qQWjFwDWMgFSTzx3zoGuWZY7+uAC
         S6ZQ==
X-Forwarded-Encrypted: i=1; AL+hErEBtqKsqpHeKBbejliGtg60dAuHZBIpBvx2o5HGqlWo4gH4kXHH6xkPkft4pz1nyiSi3AV92Q==@lists.infradead.org
X-Gm-Message-State: APuU4Z9VjUf8vdHdNU8+wKlFNJZ3UJf8uwmhBiq5TODcjPf0kcm+7n3Q
	LGsKFxziORTHWH39Lc31NMKKXOILs5dcDxckWUpF2pkcgIx0MLWUGkcfk/O5kxECpcU=
X-Gm-Gg: AYBFou1Z1nBrWLvt5jfdnMKjQ9TWZgns32fHOknRPFmjgCeUNte5xY47nWkOf0r/cYX
	DxUjW/97R6h1j6+jDTKV+Uj5ksy9fpfWevbs8ouCX0+pW33R5DlDg2hwn9sBqY2Yz+PSP+bidkX
	OxpTJRSdu4Fl0Zungy9aySLv4GpoHudAMOTMr+7/89MEcYbCksvipFYysZ6hJITki/N5pu7KRVo
	esWzl5cFSIThBD5zcdEk++TPMx+6H30LAENp7Vb5ac8EORNocK2c13578dfml5YhlC9YIv+5+AH
	zJbAOnSn6BHxYX0mTxdgBM22a6YCTQDv0PWfJAn8ytQNzRk7mLjB+WKsck2LR0Swwgi3GcWglpV
	CU87SNRvOweTEMuWPTIOpCkSFhKbTwQBoBlt4/DX0q7vwGS2ZaZKHgrYnDiRIoxfTW8PEPLijP4
	GeZtIADq4DVx3/fP9gW75rzuwUPursY6MkMsNZCgNDvpj4fwHzZUtMnIRDkbvfeNOvhCXyEw7dl
	/1tSKqL554GrWzzycixawp8dqg+k2XUeqP86gLlpO54NYRYZHNySuxz6ApBQ89AtYiklfWV9Jq4
	revPDkuTWht7WX4ZDqH1V0zdIuZeVu/+bMWXwhHKJ6kKnOjdfvmfHo4inIwMufq1w6cWVIEcRD2
	OkqgIDJVqftbg3dbE+6Anxtd/bJacVuY=
X-Received: by 2002:a05:6122:1782:b0:5c9:a7af:8178 with SMTP id 71dfb90a1353d-5ee1c2b2435mr2759606e0c.2.1794495636101;
        Thu, 12 Nov 2026 07:00:36 -0800 (PST)
Received: from localhost (64.167.245.35.bc.googleusercontent.com. [35.245.167.64])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee3243e30fsm81430e0c.9.2026.11.12.07.00.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 07:00:35 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 Nov 2026 10:00:34 -0500
Message-Id: <DMTBM1N2LO8K.2LXV0IVP9ZSI@soleen.com>
Cc: "Alexander Graf" <graf@amazon.com>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Chen Pei" <cp0613@linux.alibaba.com>, "George
 Guo" <guodongtai@kylinos.cn>, "Kexin Liu" <liukexin@kylinos.cn>, "Randy
 Dunlap" <rdunlap@infradead.org>, "Shuah Khan" <skhan@linuxfoundation.org>,
 "Sourabh Jain" <sourabhjain@linux.ibm.com>, <kexec@lists.infradead.org>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-mm@kvack.org>
Subject: Re: [PATCH v3 5/5] kho: docs: update description of bootmem regions
From: "Pasha Tatashin" <pasha.tatashin@soleen.com>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>, "Jonathan Corbet"
 <corbet@lwn.net>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Pratyush
 Yadav" <pratyush@kernel.org>
X-Mailer: aerc 0.22.0-39-g5d7784875be2
References: <20261112-kho-bootmem-sizing-v3-0-f0c8d00295d5@kernel.org>
 <20261112-kho-bootmem-sizing-v3-5-f0c8d00295d5@kernel.org>
In-Reply-To: <20261112-kho-bootmem-sizing-v3-5-f0c8d00295d5@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261112_070037_685208_BEDD05BE 
X-CRM114-Status: GOOD (  25.59  )
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu Nov 12, 2026 at 5:38 AM EST, Mike Rapoport (Microsoft) wrote:
> The description of the boot memory regions does not mention the low
> memory region and claims there is always a region per node plus a global
> region, while the low memory and the global regions are not allocated
> when they would be empty.
>
> List all types of the boot memory regions and describe when they are not
> allocated.
>
> While on it, fix grammar and split the description of the regions size
> and of the CMA usage into separate paragraphs.
>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  Documentation/core-api/kho/index.rst | 31 ++++++++++++++++++++----------=
-
>  1 file changed, 20 insertions(+), 11 deletions(-)
>
> diff --git a/Documentation/core-api/kho/index.rst b/Documentation/core-ap=
i/kho/index.rst
> index e78a2bbe2be1d..ce2bf9cf66514 100644
> --- a/Documentation/core-api/kho/index.rst
> +++ b/Documentation/core-api/kho/index.rst
> @@ -52,17 +52,26 @@ allocations before during boot up to the initializati=
on of the page allocator.
> =20
>  We guarantee that we always have such regions through the boot memory re=
gions:
>  On first boot KHO allocates several physically contiguous memory regions=
. Since
> -after kexec these regions will be used by early memory allocations, ther=
e is a
> -boot memory region per NUMA node plus a boot memory region to satisfy
> -allocations requests that do not require particular NUMA node assignment=
. By
> -default, size of the boot memory region is calculated based on amount of=
 memory
> -allocated during boot. The ``kho_bootmem`` kernel command line option ma=
y be
> -used to explicitly define size of the boot memory regions. The boot memo=
ry
> -regions are declared as CMA when page allocator is initialized so that t=
heir
> -memory can be used during system lifetime. CMA gives us the guarantee th=
at no
> -handover pages land in that region, because handover pages must be at a =
static
> -physical memory location and CMA enforces that only movable pages can be=
 located
> -inside.
> +after kexec these regions will be used by early memory allocations, ther=
e are
> +several types of such regions to ensure that all boot-time allocations w=
ork:
> +
> +* a low memory region for allocations below ``ARCH_LOW_ADDRESS_LIMIT``
> +* a region per NUMA node
> +* a global region for allocations that do not require a particular NUMA =
node
> +
> +Regions that would be empty are not allocated. For example, there is no =
low
> +memory region when ``ARCH_LOW_ADDRESS_LIMIT`` covers all memory, and the=
re is
> +no global region when ``CONFIG_NUMA`` is disabled.
> +
> +By default, the size of the boot memory regions is calculated based on t=
he
> +amount of memory allocated during boot. The ``kho_bootmem`` kernel comma=
nd line
> +option may be used to explicitly define the size of the boot memory regi=
ons.
> +
> +The boot memory regions are declared as CMA when the page allocator is
> +initialized so that their memory can be used during system lifetime. CMA=
 gives
> +us the guarantee that no handover pages land in that region, because han=
dover
> +pages must be at a static physical memory location and CMA enforces that=
 only
> +movable pages can be located inside.
> =20
>  After KHO kexec, we ignore the ``kho_bootmem`` kernel command line optio=
n and
>  instead reuse the exact same region that was originally allocated. This =
allows

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>=20

--=20
Pasha


