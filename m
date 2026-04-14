Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 490FFF9D0CD
	for <kexec@archiver.kernel.org>; Tue, 14 Apr 2026 13:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WJyMBBDw3QxsO3eB2s7y7REn56kC8A82/2aFbWMGYbQ=; b=qujDJN6sG0NrRZP3VCvFZtCmZ9
	FndbDRDlDPYM8YD1JcHxYLoSixSL0gTEVpr4dBEJQqDXzvjGwzqpkIDj8ji1ZWZZLmxQq0NwNMu6S
	5v6MY6eBDH8v/0KQPDOcDDCEwhWL2RY/PMudkVB+gwosgSvxvL7WGdA8kMmKKEdYKXMos9E7p9zla
	Vmf+/0Pabwzay2mBTyO2ozrBI0dSrq8PnkS0klWIs5yuUkC0SJE8WMipDtommTnRKgXEhyeZheUwZ
	8zCcVHS0dkS2t9XQRMhjwtwRg53Nsbr44qDvsLYZ8jef+g0rcoCUv/coYyjbeaY7zZfwo0BVtAHdJ
	OQNq7ZQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCdSR-0000000HLU5-3D8L;
	Tue, 14 Apr 2026 13:05:35 +0000
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCdSP-0000000HLTT-22B1
	for kexec@lists.infradead.org;
	Tue, 14 Apr 2026 13:05:34 +0000
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-b9d9971d059so491489266b.2
        for <kexec@lists.infradead.org>; Tue, 14 Apr 2026 06:05:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776171931; cv=none;
        d=google.com; s=arc-20240605;
        b=YGwsTCuWc9PaIzMuzuySUKHg8dxGl2avQdJcRyBpV0VnAjYy0t4PMbgnKwBEux6k8X
         aFDX1HlM9APdq5B/XbVUifG0FpdW6W9fcqeaW/EKG88z391m4Amg2+j0TRCRpdPG0ZSY
         /jtkDzj+7kYwmo6AzaEftyzahnCOjif1dRd8chWnJTbxiTfN1eHLTmEPYAiMoCU5Spsh
         iQ36S1u+6z2UoZzAg5KbgaEa0oRIZXnLLX/RqbIn4ZueIoLD87iPwtsBTgMLm9vgDZNv
         JF1q2Y7zQyaSBP4pDohtnLDY6drHYMfSlDT+y8NhT+p3sNPS5mrWUgRmqGs3xuwwpYeo
         h9lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WJyMBBDw3QxsO3eB2s7y7REn56kC8A82/2aFbWMGYbQ=;
        fh=T6SwgX0Anr7e11y3qegX0RlQj7r9wFg2P1yV47snibI=;
        b=YmIJsKjQxwL9z4VyEFpHRN/ZJDch7P8iqKwyteeVz4USjIQrfBZA71BR/ZkbNFO3i6
         +ZkIG/tHfruMWD/L89mUXAl+S6jmuF9Nm8uJZULeRI5VfPmEXxGkcciiiUVnup3Lp6LG
         YooYWECV+2PluqDM4XQzSbrZ1GmQqOPWwCZigVVy653yueBjZyxXmN47G9kejlE71gwe
         AM5TQCW9XRYZcWVBZAbrzSKCIUvrEfmq6O//KH1UkYtOcWDzFtHptvzVy6sP+B7S4ksB
         3pID+mJUkIZTZJuyVzDoOo6ZQYmk4LZEunbhDEoOzfzYyJq7wPfEfY5CSd2xVk08aEAi
         iOEg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1776171931; x=1776776731; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WJyMBBDw3QxsO3eB2s7y7REn56kC8A82/2aFbWMGYbQ=;
        b=hLq5S4erE0nyOR+J/cRwb+7MbuV+hoa32lGf0OsoFTFpRcXzVhxwrWl+P44YSF1g9O
         PO9S/73Uur/2HdEX+MunvL0v2CDJ/b4yMqU+7GwT4DJpoK230n44f+O/EFbSf9skfEl7
         4HPMPthwsjo7fBQvicL3/KphL11K7h0CTvtrB7krlT53WXjOE8uHliG9uuGeOsW76iTw
         I3a0FRZqmmjKsfjGInjSNpNKqlgUYHmPnijZAGhdX7/yiUH023/opK6pxhpcBCXytVkF
         xoIuxSb8eppf4yOapD/kq2+FVMfr3bV1++GckncKDnYvWo8PZ9uDZkZ6vd4p23mgMLJF
         z4hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776171931; x=1776776731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WJyMBBDw3QxsO3eB2s7y7REn56kC8A82/2aFbWMGYbQ=;
        b=MKjr/UZeHWThC+4IRe6OY/DJ+o5h5ENRzVJ/6WNX7MKEbXcfG8P3RXCJMCr1sWpcil
         Iew+DlykUMhGRAc5q7V++6R7vJSZ9WOpH/i0Hp/7ENBBTYkEMDnaqS8OdKVJNL8q95Sa
         OCDRrEccbyeDMSCJytEfrsbXyHSHAvIQRCH+bpxOKWSu6xfJgkFe+P/99gotX4ypVmE0
         Rlg1rh2kf7Zrven1/zRwMAyEEU9bJ9G/gzbJfEDb/y25SulrpvuQj8JC4sBeXhWn7Rjl
         iIS9hgWyQx2o8TxFBFX0dLExbYd9zb+V2OsZSGnI5bmEzD3Ve8QAASkN4QoOImD2hqyl
         WYPg==
X-Forwarded-Encrypted: i=1; AFNElJ9N6RGeB+hd/PHZEDoaP7CmyMI7nl5LuZNwncnzXcl+WgVRW9i0puaWYIsZuK9iKNGRpqkObw==@lists.infradead.org
X-Gm-Message-State: AOJu0YyKgEf9PBxMoa6Nsx+RfMoOEJTHsZNn7sy2zTGIvDLHLHDu/CLt
	5lVTFIRZG/Ftv7235SrU7xSYIswQovzEq/Us0bW6DR+dtiLZfJ9RLxbRs1tfMWQEvo4C4SdETjh
	95sLOaMaHV8f6XCq3edBPKvTIIH+PbN/ozWbEtqTZ8g==
X-Gm-Gg: AeBDietUCC2dL0Sd5UT+x0ZIPR3LwCvhyQpuzC8Q3XQWagDSfZ30F3ukBB0ovQVfwFj
	ZdorILLREeCsdVrx04sDv5Ly7ceiKx2UbbmKukIJb+oFC+lyHUf6DQxFrowcaWcECpQobdyWue8
	qbjPfr3rV6NOWYWIs2t537zQ5k24b0Sz3Iv27idnT2E/aUaRQk6EV7fgFeioo3izPjpRE5xh4eX
	AogNVRIcFZmgJsWzOMv48jXIfOr+kPHazQP98yFa54x3rmC3b2eLHASuLNaqAwPLOBli5dIOBgp
	oIi8N9ChvlLo6MwMhCKvUlF6oOsEd5jRW05eKg==
X-Received: by 2002:a17:907:94d3:b0:b9b:207c:f7b7 with SMTP id
 a640c23a62f3a-b9d7267af85mr950887466b.3.1776171931398; Tue, 14 Apr 2026
 06:05:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260414121752.1912847-1-pratyush@kernel.org> <20260414121752.1912847-4-pratyush@kernel.org>
In-Reply-To: <20260414121752.1912847-4-pratyush@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 14 Apr 2026 09:04:53 -0400
X-Gm-Features: AQROBzBIJmRCcFUKFu6XCUoUK5JAm0Xcfc0lfBbPIbj0avBkGkF-wVt1ru4Jrgs
Message-ID: <CA+CK2bDL9Pc1AyKE1DBc=FTBwCV5-p3A+-O_WrgB0CYOhF=GYQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] MAINTAINERS: drop include/linux/liveupdate from LIVE UPDATE
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, 
	Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, 
	"David Hildenbrand (Arm)" <david@kernel.org>, kexec@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260414_060533_542629_4E1C3B03 
X-CRM114-Status: GOOD (  13.90  )
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

On Tue, Apr 14, 2026 at 8:18=E2=80=AFAM Pratyush Yadav <pratyush@kernel.org=
> wrote:
>
> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
>
> The directory does not exist any more.
>
> Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c1e2cefb4493..bb588928533f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14811,7 +14811,6 @@ F:      Documentation/mm/memfd_preservation.rst
>  F:     Documentation/userspace-api/liveupdate.rst
>  F:     include/linux/kho/abi/
>  F:     include/linux/liveupdate.h
> -F:     include/linux/liveupdate/
>  F:     include/uapi/linux/liveupdate.h
>  F:     kernel/liveupdate/
>  F:     lib/tests/liveupdate.c
> --
> 2.54.0.rc0.605.g598a273b03-goog
>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

