Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E80FE6F086
	for <kexec@archiver.kernel.org>; Tue, 23 Dec 2025 18:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+2RXmFBnuoUZNP9t3XSeZExCz/tGXq4+QrVc7VKG6+Y=; b=ot6wJwW9rk3ot2JDYTpokhhWab
	c3txrDQZl4aP+0n8sSCCrXr6wMen+rIVkqN0xOGCuDZcwkPq+RGqatRXUUHwFiyk8SJrJYYqDO2A2
	b6lJC+p9YtvJYF1ZHdbarM86VQKwcdC2co/z8ma8iwXLMyGa/q9BRiedrpITdBzoocnw1EM+j6iLg
	SFpskH3UtRpPl2AjalKMSMN+EhW918aa+3M0Il3B0k7xSiAr7SezIaM4mpZtUo4ev9VwXsO2wLky4
	rg4yOXQqZ74kfCFXRFmyw9Tlddg/6VyEOMlu1q5EwygysowBcMISzSDb7sMjqowvWD+5Gree9SM/o
	Qux0Stgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vY6wz-0000000FwSv-3bo8;
	Tue, 23 Dec 2025 18:17:37 +0000
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vY6wx-0000000FwSJ-3UB0
	for kexec@lists.infradead.org;
	Tue, 23 Dec 2025 18:17:37 +0000
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-64b7318f1b0so6210310a12.2
        for <kexec@lists.infradead.org>; Tue, 23 Dec 2025 10:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1766513854; x=1767118654; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+2RXmFBnuoUZNP9t3XSeZExCz/tGXq4+QrVc7VKG6+Y=;
        b=jGfgap6oODFmfxx4NaXP4md5WP8eQKvN27yPVKN1vH3b35ZDxuNRTx61/27zUJMVVz
         2o1Czyh5TbOPZF/ftp+ZGpQr2DuA7JUcETIMeGUkvDPkEkJISj+vDCbpu++rspA1JyMO
         wLpXcB9nvMph9YFFr3UUv49J/qeboOotL7atj6J7CB0Fdyrs9d8uuNBXp5155NYpvey5
         wNiDBEcLSsCfmzFOBVd7WIEIu3dcssdfXmThhOE3cvu2dCXBFOjulme9oBz4VZVClcVX
         Ee07jxpd05K4bLeJVst6o4MZPJpuM+U+rnHWpjsXcX6INVGHNU17ddG6B2GRaztYr58X
         hrGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766513854; x=1767118654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+2RXmFBnuoUZNP9t3XSeZExCz/tGXq4+QrVc7VKG6+Y=;
        b=IcF7dzNzu+WYqRxMMEoQ+Jj/8nolV90ESToUoDC1sFToOmgrN/Oh+hBxkJmCb/543i
         slI27ioLpyVINnuvxblZ2Swq+rIZ6QVr9foi8wsjMLfaatUFTJBfuM0WCUnd4YTBon1+
         h9MWko0j0Qr3UY68HKHKl1zR3gAkZ0olVyij2hrVhNV1ISFmkSpAMsNuhzO8WmnTNLZV
         RZ+dm9Fha4kS6HXoDe8oZINQQwJV6ie6sqv6Sru97kW+5zK5N4AqGSCpdi0lCCmSmuGI
         P0JoTlkFTDd6s9o9geQCxzdmXzyXkgSwKQCuxs5sHhgItEc3b1J8slbZLvXLMD3BworX
         0ofw==
X-Forwarded-Encrypted: i=1; AJvYcCV5hxDPBGuNOANfX+lEQ122UMUuw0R/Z4peFblOlytf9aoXjUwyNm/W0dIvIxLJi23DqTRqJA==@lists.infradead.org
X-Gm-Message-State: AOJu0YwqB+IwVPMEEbffLCMAIJAuU03eaSxrPrQ57OWwugd55wN0HfWz
	ljnMP70dPoRtrOppN0DY4TeTKNG97R2avejFOU7i9lDlVV+8U4zvEs8Dn2PXVQMNihtkrnpBxgm
	vE1j+vqNiMvJhAhExu+ljJDB8fuYj8eglYfTNPmM/Zg==
X-Gm-Gg: AY/fxX46JlhxQFOBNZDcPXjRjWjF37APaMfPstwyxKbKa2jx0cMQyNPKgUMF/t61YD7
	Oiw+9gKo3QqqqH8LzJFkjay1gk2GCfQ8zrQoHWjLo2MUHQo9mirHnCFFhudw1Dju7N68JdUrO2m
	YSGd/DObRkUb7Wxv0DYVu5bpBV6WDvLHIWSB/WbfltEF5CbSFhPefoIddFQAa8psXQtRnFX8eur
	uKruRsvYIDJp3dfJzpu0Kfmwo8FQssOPUS5Ox5204SWcz+iqTpwI/d1OgswB7PBSNAZ0tMJVlzC
	NN2F1Dlm3F1xQTNzBQi/gVkQPbARGRTi8ytI
X-Google-Smtp-Source: AGHT+IG7R8OufzxbkFMNpnBpqEEtRO/h0PChaYqg3fbSuA3NHtdOdOdeSWlvgqHDikQUpiHUXPkzTwN9tQJ5alYq+AI=
X-Received: by 2002:a05:6402:5112:b0:64b:ea6b:a884 with SMTP id
 4fb4d7f45d1cf-64bea6baac4mr14256712a12.17.1766513853843; Tue, 23 Dec 2025
 10:17:33 -0800 (PST)
MIME-Version: 1.0
References: <20251206230222.853493-1-pratyush@kernel.org> <20251206230222.853493-9-pratyush@kernel.org>
In-Reply-To: <20251206230222.853493-9-pratyush@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 23 Dec 2025 13:16:57 -0500
X-Gm-Features: AQt7F2o9lKh-MiYjTN0jydTh4lXfEZrS5Ed5W1ywUvAOmrIraj_P1WZBiW42-WU
Message-ID: <CA+CK2bBeJwACBiKsuXLcbzC4m0zLhu0yNg2HDGR=AQGeEVCJjg@mail.gmail.com>
Subject: Re: [RFC PATCH 08/10] mm: hugetlb: disable CMA if liveupdate is enabled
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jonathan Corbet <corbet@lwn.net>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, Alexander Graf <graf@amazon.com>, David Matlack <dmatlack@google.com>, 
	David Rientjes <rientjes@google.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Vipin Sharma <vipinsh@google.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251223_101735_901119_21F4C9CF 
X-CRM114-Status: UNSURE (   7.89  )
X-CRM114-Notice: Please train this message.
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

On Sat, Dec 6, 2025 at 6:03=E2=80=AFPM Pratyush Yadav <pratyush@kernel.org>=
 wrote:
>
> Hugetlb live update support does not yet work with CMA. Print a warning
> and disable CMA if the config for live updating hugetlb is enabled, and
> liveupdate is enabled at runtime.

Could you please elaborate this commit to explain why it is not
supported, and what it would take to support CMA.

Thanks,
Pasha

