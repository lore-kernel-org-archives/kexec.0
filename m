Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C78AD6CFA3
	for <kexec@archiver.kernel.org>; Thu, 22 Jan 2026 18:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cmMh+ovoeRUCCwfFygbXGZ6j9n5SptMlw+qIxplX4y4=; b=FTUMOl601uPS7UswdJ/hWWPJ8r
	/Z6Xdx+29mAUph9wql2l0FeLrrZNATGGCu1ldy0VABtPxf1qH8wQ9zmiPVYNHzlEoQQxJ4s66HdCc
	Wj082E9jJo3AlUCz92JveOZYDbwmnuLmzgYQZDtII6mZDhtv/MCp3iGiOLj7XDwboVUeKkrVJPY31
	DRiWehegHECq93EkZUzW/wNeZ03CLHGVefD2aTxbNUy80P1P9V4AZSBGpjwptRVhj9yOTXHtAEHjH
	UbDk+d6b4KSRkDEzeWlA/wY8dAPiUO3btqD1gJS9o6RHoQZGWlNyfz/kourD1naIeP40HWWvZ/5pQ
	GAbkPNeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vizQ7-00000007dO7-3Kz5;
	Thu, 22 Jan 2026 18:28:39 +0000
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vizQ5-00000007dNg-06qM
	for kexec@lists.infradead.org;
	Thu, 22 Jan 2026 18:28:38 +0000
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-6581234d208so2569574a12.3
        for <kexec@lists.infradead.org>; Thu, 22 Jan 2026 10:28:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769106515; cv=none;
        d=google.com; s=arc-20240605;
        b=AFvhhKqU73CosBH/oMITOnRlAEXjb2EvpmAZWC5Dl0kQgMITLEegLWnDAEVfH+3rgv
         ZtuBRZR/dQx3bDWWi068kjHgXJjDXBq1ZWYOustD0Uv/zCT/Eg0eBvh6WbtvPeO7SRqR
         tNqLu2iePqCnJfatG5IYGRF+s1xDTTn/uhPm3u41HMWJHTaVJSz71S/Fp+46KJeoB/OS
         bTmAuzB23lqT7N1ZSD2Ae6g3pTjssWkctibbL9+4xTgtM9JEYbKWDeQ+TP/Dlt//lV7C
         UEN8/8SFrA7bMYqLQO8yrLEO66oLubr35HYL1HavnM36BnuIeNseXYUAbTIeBU351Jae
         VbxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cmMh+ovoeRUCCwfFygbXGZ6j9n5SptMlw+qIxplX4y4=;
        fh=2SIKaf9MGrScJg0DlE1mQLTfSdMqA00v2v3VgaKIMYo=;
        b=jAAK/mBYii0EBvWT5Qcid37afY0rUd6XPnIQSGyGZQ6KnifpfNjbbRyFzwVx45d6kV
         MSYzPARnGEFb2VesOXMxWz/6NPegngYcZPp+tC8+IPPmJs8x8mXvnykB8ptm+jZpc/kq
         R2Kjqjk/BeKhcQLJOO6MTRgxvfNFf/QOLUn4miyeUCAE7ji1G01kNEQy9tlPB7w8ww4y
         fWFd+bAvoAoQxSc/kQC83uO/aGsbHmBzY31JgqCdCVwauKt0eftwTqoZ36G//MupMuEN
         cRjWTtr/vGzy9gFPcU+wlyR5zqn5AeXVHZiq4k09zvgTFspV2/v2od4eMdoZJc19hoCw
         IbNA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1769106515; x=1769711315; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cmMh+ovoeRUCCwfFygbXGZ6j9n5SptMlw+qIxplX4y4=;
        b=QP3D2xZ128EEpJtZbZB16Y+WuRffxsuU/LwoVpiH4BIQ+mN8qRl2mMU8gmAgfDui/T
         u0UQRErfUQBIUssJgTeQnQt4jHajJp7z0cyccd2oQ1rhneIAoHFyPXJHPfCZ6FpX+yFj
         2X7bF+YzkGRn1OBcaf+1OYoTF7qdKRthhPNqmtLKClghUxTgTy2VlqGB1bVhwU0HseGO
         yKzkCcbYUdq72Rs1JZ6iM7AP2baNuX7HsWlD9V6v+/uXD8WBQJzT+mFA6v7Z1cYx5f7f
         qrQV6y0W5PSQ1qheIYQBmNgxEB3V0cDuCPdhRUybVVDJSpN5CSwr5aAXksKR0f6SnfBF
         FDtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769106515; x=1769711315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cmMh+ovoeRUCCwfFygbXGZ6j9n5SptMlw+qIxplX4y4=;
        b=NqhTJ4KOagmAMW+EdS3S8/hf/ZLwteB/mLXxiJwBWVZuenWkPiFkeTKbFlhqKZBPqQ
         vCX2ttKWs+OL3OY1qQUNqASqEEk/+qTjcwQpq/4UydN5vDOEZ86hlB3JMXOCJIA+mKuw
         MlnjFl1QqGl1frOarpK9CZYg80yVDNCE9cvqe2JwRbZX7l5BpuMBuoRk+DEXyCAD7Z8c
         cdrI5zIb1Ua6zcCLnTEfhVd+iiCc9osv8XRkARj/DcpnavHRG/xUJlUpw43WRmK+1heH
         pv9BGBQqqifW3B120yeF+RPiBYPFF6mFfZJ4U1gDQ3XRUWsDhIkE6xlHzapYJ2TvjcWE
         PAvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKqbySoMH/g2ADSV7hya+n1YAysfhVGO3yDm7PD9yTV4/t4xHsI4gEdr5qQaVjkFhgT43Iew==@lists.infradead.org
X-Gm-Message-State: AOJu0YzRVjP8EjZlG4KX4d/62L911n0wAW60doR7f855EzDfmF6sPhsC
	M6WzMjVPKo/vbIi4Ynb3IAJwCEq8GPCVTf0xuJv3T3OhhsPybU7cq+OiXaV30oBIYEx1yoR5CFf
	AYeMgnq4QQBufNdcQHOvxbd70E1bjayeIl6iMLQ0e/A==
X-Gm-Gg: AZuq6aIOnp2056jcig0IK2u/mYd6sHZkHOW7dnkkmu3p3ZYgXwS34IONBM3j7fv7102
	DyReaxocMCdUB+m+4vvX0P4h40o4/kEo9xiS5Z0xUGZg88cbJu6kg5+65T02tqXHFEdrS7YdkLD
	huSV8vwA/pgOwGEDxRjlPe2lVvVeaEJBKP5xXOk8+F3UjUqMiXbmbqg9ehau/2f969/eYhay78M
	F0Cx73qXP14eUUK4wEbVgptA1ZnCvjm5n6x0xRm4BwnUlmL3Npw5IwdOfnCFBdR5mDzt+UxDWSz
	9tqOhMdGprCyz71fQl4g4bTRLw==
X-Received: by 2002:a17:907:25c2:b0:b87:1b23:cad3 with SMTP id
 a640c23a62f3a-b885ac40b17mr13522966b.9.1769106514941; Thu, 22 Jan 2026
 10:28:34 -0800 (PST)
MIME-Version: 1.0
References: <20260105165839.285270-1-rppt@kernel.org> <20260105165839.285270-2-rppt@kernel.org>
In-Reply-To: <20260105165839.285270-2-rppt@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 22 Jan 2026 13:27:58 -0500
X-Gm-Features: AZwV_Qh8LphdBgzf-rB2D4uKAJkXice2g_NEcJK-xBvMhkC97uW462CJuKpoRTs
Message-ID: <CA+CK2bDkVtwrCB9Jb=gSNC4CLgROJNHChjBPP3yYcad5y6AeUA@mail.gmail.com>
Subject: Re: [PATCH 1/6] kho/abi: luo: make generated documentation more coherent
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alexander Graf <graf@amazon.com>, 
	Jason Miu <jasonmiu@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260122_102837_081901_211120BC 
X-CRM114-Status: GOOD (  18.06  )
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

On Mon, Jan 5, 2026 at 11:58=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>
> LUO ABI description starts with "This header defines" which is fine in
> the header but reads weird in the generated html documentation.
>
> Update it to make the generated documentation coherent.
>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  include/linux/kho/abi/luo.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/kho/abi/luo.h b/include/linux/kho/abi/luo.h
> index bb099c92e469..beb86847b544 100644
> --- a/include/linux/kho/abi/luo.h
> +++ b/include/linux/kho/abi/luo.h
> @@ -8,10 +8,10 @@
>  /**
>   * DOC: Live Update Orchestrator ABI
>   *
> - * This header defines the stable Application Binary Interface used by t=
he
> - * Live Update Orchestrator to pass state from a pre-update kernel to a
> - * post-update kernel. The ABI is built upon the Kexec HandOver framewor=
k
> - * and uses a Flattened Device Tree to describe the preserved data.
> + * Live Update Orchestrator uses the stable Application Binary Interface
> + * defined below to pass state from a pre-update kernel to a post-update
> + * kernel. The ABI is built upon the Kexec HandOver framework and uses a
> + * Flattened Device Tree to describe the preserved data.
>   *
>   * This interface is a contract. Any modification to the FDT structure, =
node
>   * properties, compatible strings, or the layout of the `__packed` seria=
lization
> --
> 2.51.0
>
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

