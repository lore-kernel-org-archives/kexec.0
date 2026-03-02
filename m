Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DA13EB362A
	for <kexec@archiver.kernel.org>; Mon,  2 Mar 2026 18:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rZw46QiejIxPJc1G5DNZGnj4KsLWM6jIVrYLGkqOkHQ=; b=TbERSHCGgX97ceWQ0i0xYxCpPZ
	b4ZCNL8FF523dOr1Jl9oT156foBDq3IbvpuKo3OgHd9vqR4K81XTVbHXe5JZ53f4raQL1Gr0QmGaT
	DmFN0eDUtyrAtHfM1LogpyVwM4FYN/gEHPHO/HutC5OmAuK26RJa1eSFDZ6aGANYKpiSoc1M0LzMI
	x/4je/VQyoD7MnpCtZYs65wKcUmgOGMQtdJr7phIQS13UUl1ijdkToThg+Dv8Oi0MlHgvF7aSdeNr
	1PJUcwMCuOHlrvQubQ3bLKY/1cAeAQX+PZCSmeBR1pYR84oPfqJ25sspz4iqhVRkRUOTs6vF8FVha
	pttMb0Og==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vx7nM-0000000DfMp-1OBa;
	Mon, 02 Mar 2026 18:15:04 +0000
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vx7nJ-0000000DfLi-3240
	for kexec@lists.infradead.org;
	Mon, 02 Mar 2026 18:15:02 +0000
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-389e2950f54so12974501fa.0
        for <kexec@lists.infradead.org>; Mon, 02 Mar 2026 10:14:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772475297; cv=none;
        d=google.com; s=arc-20240605;
        b=j+zjiDh6eU3v3pl9/9GASRVpXtUWf10MRbYrX2hZfkbdaWTf/8XOn+x4DlCFzVSKNk
         MEYYp2msBOPLOzBJGvH4pFzk6mn/4HaIBGJyqBR3z5VzoopQCOMealnT+Vy6vC599415
         t4sDNGRWVKlkrO2VfAPGAwqAeyvqozBw7hqOtQbtpBB+Efh4rSKDlROhTIH+ZdebkBIU
         EAL1K1nDYne7N06Ww5bcwkPI9Tl23gAMNlj20GjZ0ZAmdSsr+XrWzsASuvXTs7Hqj9K4
         ogb5s3rRhfNPWGtmleTK4zqPT8ZXJG4UCQnQhfrGv9LR0QLvpXUTJq7BoOyYs+KTEq0O
         0mvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rZw46QiejIxPJc1G5DNZGnj4KsLWM6jIVrYLGkqOkHQ=;
        fh=OqvCR9r0fN0Wj+7Kf0a8iCuf6htdVMDvh3eGD/IcjmQ=;
        b=Lr834eiQjwGtpove7Us/t4ki8tsdFnlja18wKZej6MEREMuhkNb3S8zUNJ363ew8u2
         n149LO8Y7AAXHoynZ+GV1BTBalACzHnbchKYSxK0LFit25HVVv+WkfwSBbJqhUpEoQZX
         lqMvucEiFJPoH5TCuvuAXICk3RnH4pzIz4W6y2kg08r4nAvLYzVo8gl4A/KXWEidgr/n
         BbZxTpnfH6b0eU6oAZlgImj8EeaBNedLbI0ELKn5T6WBA4V/mwnhRAdX49pNiNQY2izA
         Q+v7KXvQUAh1nd5g0upCouvxCCX5Pk5OSut3vCevQbC6ybqcZtTS6bPeGLh78vNWDV9C
         64ag==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772475297; x=1773080097; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rZw46QiejIxPJc1G5DNZGnj4KsLWM6jIVrYLGkqOkHQ=;
        b=3GTdkOS9wMt6+0GIp39hzkDWiSRhtCJ3jZRKlj4XUIIuMP0SMyBV+4N0jMlKVcIZas
         VqSWrGz/Lf+sb2A+XRYrKbtYaty4VMtroiWGSlgJQbXgLtzrQuiCoyhJFpyhfpe5kmnc
         aidFaz13EZs6GEJoDEtIpJMwnKZTEbC3FKjcwFgyLesz9fhgP3Ua4BefDMHw8CPLeuHH
         P/MWgGeyjuSnJYLhn+QArLX/mpiBWc1P/TgkTUT1ovLRaF+0cv+t4UtnKNW5GhWIszHK
         FOtmDISz4UUh3USxGa17f9nzsHC9SuRxO7gDFyhYUw9+eOcRoBQ37oj4VlnTX83UBuNp
         AHzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772475297; x=1773080097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rZw46QiejIxPJc1G5DNZGnj4KsLWM6jIVrYLGkqOkHQ=;
        b=RFuzdkQm9ZSQUzMsnxKpU80hNZW9n/i7VQ9EjTqDKJmmcz9GemKLeSszsDV6/ShEdY
         I/3/S5oNPOC+rE6oTJhWElejwI5rgJLF/QMiUUaWjpCQ6Ci1xHXWR+9ayFo49nl7cg09
         IIiEvnKEE6jhgw85wq1wg/kTPxCBJcUZfxsea1l1zJFP7MldWUomt5iqpxTyvPYMf+i+
         qJMn7+CYzzphG8PLXi5liSVOhAb8SbUAshkoMQnm+bOk9g7nqMphm5YAAM1bZYR08oGi
         e45Hub5p6WQQHYN0YDGeXDU0mEdtyQ8RnlL7mu+ufYQ0fRa18jKw0iGiK2TWG+WfPk5Z
         MDSg==
X-Forwarded-Encrypted: i=1; AJvYcCVP16KUOI40my69a3/XGY/Md/wweF2XpDUjPYuS7hFNMQLmE+7WN7Z11PJHOA06r/DTA/0TQA==@lists.infradead.org
X-Gm-Message-State: AOJu0YxNsj1OtYDNX+YdTrUtEkPMv3KJvbaFzZi25W2+rurQF8wViLWw
	rtzcXR2VvCSsu+sx6SH0O0WmVgbSBA1j7mYzmruUVtkOWA9eZJpsGVE4fIUywp1cXiLd3pEjEES
	lH4JCqxuzbsVSVLuqvU1NGOuQIND8KGsMKHrB/0FE
X-Gm-Gg: ATEYQzzMsu2JMrIqJ2yr64KCzT1BPvVtF5w4VaPSnMhdNvckUSWuYJXmnNOllrlPQIP
	zt1NPle1BASF885v5mVmiOybB39DJlTCdPRGcz7S1/4BJMfdayN+rYw9McWB0O5NLXRLhdYp7+z
	DYt2TaeSV2c/uL9dHvej80K3/gNUVzGpMODRw24lABTmOxq8/D6I3CP/ADJRE/PYl1akgf4aAzR
	fWFyU03dhOhxhvpNOaH84JnnSa6TR9XLFpDirS4n9cwGE7j7nPU9PHR6FjAUZS/A8ZYXBqRQoEG
	s93kCss=
X-Received: by 2002:a2e:8094:0:b0:389:ed12:9731 with SMTP id
 38308e7fff4ca-389f1e29849mr81213251fa.16.1772475296490; Mon, 02 Mar 2026
 10:14:56 -0800 (PST)
MIME-Version: 1.0
References: <20260129212510.967611-4-dmatlack@google.com> <20260225224746.GA3714478@bhelgaas>
 <aZ-Dqi782aafiE_-@google.com> <20260226144057.GA5933@nvidia.com>
 <20260227090449.2a23d06d@shazbot.org> <20260301192236.GQ5933@nvidia.com>
In-Reply-To: <20260301192236.GQ5933@nvidia.com>
From: David Matlack <dmatlack@google.com>
Date: Mon, 2 Mar 2026 10:14:29 -0800
X-Gm-Features: AaiRm53G4DyTBgh8HthgkNXd7A4lLjemXkfCrH3k_RfrPJCtk91UZa8WxDGHRMs
Message-ID: <CALzav=eJ63gitLatAerrjEc+o3VXcRor3XwA7_o2PmKYnMwCuA@mail.gmail.com>
Subject: Re: [PATCH v2 03/22] PCI: Inherit bus numbers from previous kernel
 during Live Update
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <helgaas@kernel.org>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, Alex Mastro <amastro@fb.com>, 
	Alistair Popple <apopple@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Ankit Agrawal <ankita@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, 
	kexec@lists.infradead.org, kvm@vger.kernel.org, 
	Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, 
	=?UTF-8?Q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>, 
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Raghavendra Rao Ananta <rananta@google.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Tomita Moeko <tomitamoeko@gmail.com>, Vipin Sharma <vipinsh@google.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260302_101501_786416_7B96C30A 
X-CRM114-Status: GOOD (  16.96  )
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

On Sun, Mar 1, 2026 at 11:22=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Fri, Feb 27, 2026 at 09:04:49AM -0700, Alex Williamson wrote:
>
> > Not only fabric topology, but also routing.
>
> Yes
>
> > ACS overrides on the
> > command line would need to be enforced between the original and kexec
> > kernel such that IOMMU groups are deterministic.  Thanks,
>
> That's a good point, I think as a reasonable starting point we should
> require live update preserved devices to have singleton iommu_groups
> on both sides. That is easy to check and enforce, and it doesn't
> matter how the administrator makes that happen.

I can add that in the next version.

> You also can't change the ACS flags while traffic is flowing because
> that changes the fabric routing too. This should take care to enforce
> that restriction as well.

I'll look into this but will probably defer it to a future series. We
need several more pieces in place until we are ready to support
traffic to/from preserved devices during the Live Update.

