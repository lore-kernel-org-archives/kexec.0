Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB8E606A31C
	for <kexec@archiver.kernel.org>; Sun,  8 Nov 2026 16:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=3lvEsy/k;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=i555It6a
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=vUMpCh0+ME16WhcfFd1W/qBu+AGK/hHn1T2S4rTNv3g=; b=3lvEsy/k3NTZVN
	wl67cETUNfVsC5T1YMAj3yKpgw6k8qxmNveEf2TeG0g0zmwR/wnOt2KIKmrdHwuNJSxSoMDZYJifv
	AOZcQ+7210+0csvtLDgvl5PsVJfmPTHkZnmRp+bcRlDVg0HfqajdvJ8q11dMFKDMwdn0/aTWum1Zo
	DXMu2VYl9sOYUciZskdap804FbJtKGsb8jqa5yhTyQT7E68H33c8vw0GEY/bs37yuPEj8ZSMjuwfS
	IrocXyECxPTx+nR/7qB7DlifrOVaymr10UAYyIjDJCHpw1Cu7mLKvbX1lSCDOBPPHbFBCbXa9w3mR
	LW19xXroM2xlCRlYUoYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQ5ri-0000000GOjz-3jUs;
	Sun, 08 Nov 2026 16:35:34 +0000
Received: from mail-ua1-x92d.google.com ([2607:f8b0:4864:20::92d])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQ5rg-0000000GOjg-09ld
	for kexec@lists.infradead.org;
	Sun, 08 Nov 2026 16:35:33 +0000
Received: by mail-ua1-x92d.google.com with SMTP id a1e0cc1a2514c-990fbae94f5so70752241.3
        for <kexec@lists.infradead.org>; Sun, 08 Nov 2026 08:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1794155731; x=1794760531; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vUMpCh0+ME16WhcfFd1W/qBu+AGK/hHn1T2S4rTNv3g=;
        b=i555It6a0k6zQu2sY9PqeP7HlGWyUF6pe1zabf3ZwKgihqu6nflMzMXvWh2WnrVw7X
         rEoy/MadF4Xk7ktSLtacOWoGIR+c2Eb6/eRksulNR464yDDzlL7kmBSjMW1k+5BrMkfb
         8y5t3rtJ3/fG3i9blJqdRbs7jViyqyNhzi1Utq6vdTWV2Z8dYrBs9ekF3+lLB6iYED0q
         mU6Cxt6x2xQ8swleBsd0BuVTN3RRGJvzLCO4YttDJssRyOD2LaIFDZVOmkZ1ugUJxax8
         Bc0GGyKLMLU2svhm21am9eNAwxwwiQEXNFM3JPrbrfVJIx8KaNU4Y7OyHkdykCdsGFw6
         ZAfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794155731; x=1794760531;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vUMpCh0+ME16WhcfFd1W/qBu+AGK/hHn1T2S4rTNv3g=;
        b=k4dlGHIBgjQTRHoK+7odpIQdNJDf46xU6xu3owoB8usjxmUDnjWB4OPKOSbwkhy0q/
         +IMBmfepGTV8so2mvBrVhvSP8m+i2X+EwA5YLSIEZsGGbszepD7mRYbAIGsdeGPx9vqU
         EuCJ+LpmWtbIHZe7a+ljSHWY3QlKRf4Y12wPmL/51in2/arorLdX+jv58Zi/qXQV1MbP
         O/XcmdztBA5z9y5d1+SyCS9/HNyRYYw7ABgsR5pSv1IViqtxngpmwx79PF0ZO2rOR21Q
         qpsaOeiAo+k3MwEl271RqEbb8+D++uMb2y6jj5obtsKnz8eypK81GIi7Lz1n6LNjPXct
         RFTg==
X-Forwarded-Encrypted: i=1; AL+hErGcglRRBNOY0O7+IlDrcH2hWTalSXmrkH9uldrkzDPJud6kxnWH1+cjlwlTaP5R9cpm+lNlqQ==@lists.infradead.org
X-Gm-Message-State: APuU4Z89CUNUoGqhfog4emQcGcEr5Ei5l7t/RNSdTx4zmF6Uj4k5sOit
	lGOkyEanH8giS0itbTB1gqTZu1Dbm5KwjFMswiIvINCsi0br3UOlWMMaoOWZeTaxGFbj3aSN+9g
	g641t
X-Gm-Gg: AYBFou0TbISqrsnPhneqjmkrTjwWfjhWmSjY/Gr7tR6tIABOwwXdfn7YH7y41Ox27zx
	3rQ4v9sWWEAUl5ejJBhsYjqndB5QTPUrRPlWLLrTU7wuiqlvGxIYz8VWKZPSNs0dH4hASffNIiW
	K3hh/+J/Tx3nr4gkD4xI281xvX1eMFxi/MaatWOfiZsBZ5gajRf9l3FiFUMVWA/oKs7AnLQD3qs
	/siOfPitM+aPzliLjN2N7KR6HbcPzoGox1lmvMAIXzB6zMPvZj8bnYOa7FKP9V98LDBWwcFM8Y/
	Cz2fosAw/GG2HfATJCxuZT0kHXdFgSP1788h3Y+GPZaM22gMumuWlRtPs4p4nzQAuShZgCvvWUw
	Ay1o99uzzLQyzYBkabNW9/oJ9CgFTENkXp47g+gLfCH87/5Z2AhzIFUtueblzq6O0vmHXLHevAm
	fGUf0C0uRmLpU1xfRoxxY/jHpMZt/K3HjWs2wzDkmas94fWIRYXSz2vF5NJQXRijsBjhCLtrWLA
	PXKWvjFcbnnhN3K3u/RwzGeWdKWg3PAD0VNXsh/MhCunyX3S1AXx0eWi26aqYKQzcRSjCkX8eiI
	4IZol5GPO9I2ge1shCiHRehNYLdrzOjyB3SxEX9rM3QzEIzoAoervC0KTB19LeDsBn+tHiomKh+
	AtCYURXaJ4bcG330ql+44ubGGDAiMgfA08VwdFMmldb/JNRQ=
X-Received: by 2002:a05:6102:6b0a:b0:7cf:61e8:c508 with SMTP id ada2fe7eead31-7d2db0bcd81mr562845137.21.1794155730709;
        Sun, 08 Nov 2026 08:35:30 -0800 (PST)
Received: from soleen.c.googlers.com (64.167.245.35.bc.googleusercontent.com. [35.245.167.64])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d2db5ef806sm2095957137.6.2026.11.08.08.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 08:35:29 -0800 (PST)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, 
 Alexander Graf <graf@amazon.com>, Greg Thelen <gthelen@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Evangelos Petrongonas <epetron@amazon.de>, kexec@lists.infradead.org, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261023054518.3258350-1-gthelen@google.com>
References: <20261023054518.3258350-1-gthelen@google.com>
Subject: Re: [PATCH] kho: check fdt_phys in is_kho_boot()
Message-Id: <179415569586.625723.12004410702455553565.b4-ty@b4>
Date: Sun, 08 Nov 2026 11:34:55 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=332;
 i=pasha.tatashin@soleen.com; h=from:subject:message-id;
 bh=pntAOEp28rvpPJmjiHSWGEkBLb5e9psS4E+7JdTPPpo=;
 b=owEBbQKS/ZANAwAKAbt3KEzbc3reAcsmYgBq8KTRkK+pdagJG3uuwOjoIOYQWkYDjK1Z7kQiA
 uyff3mUlEaJAjMEAAEKAB0WIQRBMaqT7LRvGvB/NmK7dyhM23N63gUCavCk0QAKCRC7dyhM23N6
 3nAQD/46TScYr5fNbB1l95VJdBlbmbfFCXWVTm4C/4Pc22h6gzpojjQSQyRcS68ZsbRODtMydmF
 QWzNl02NZS7CDiZYXl7kz7ZP0+fIETuQP8kHfwdJB+r6agGnF2lx82uuL6283oNWzVCwJ1RFlyx
 Rx8WsaGF2wmD6e2HW2OxhPevs7tjbytuUautMqdt9bZ2YurWVTcojCDhITzB6RpBW/2ZFMYbToS
 ubEQgkPjY2L4wqvywV5bvWsDwWjwmbHI6wgY5wPghqVm1KztgAnfDm2dRsPGhvftXGw4vta2JI5
 7AZWqYy8eZTamFmqjlYczr+NG/A4yPm5tKrpe5xnWzIjho0uyOcxOvio1eIZYfQqzIL9UPkEN0y
 m9LnNz5ROzzuYN8uU4ag18A9TDcoMCtLAfzrHk10Xc+G+MkTtKgcqMqSfE99OiYAo5ZWCg9Y7K8
 EQDHDOEljbZgrcE9yZQrfFUcVikND22cEbFAUFx8hqV6mW0qmpkq2PjMyc6iKx/qMPNf1jleIMA
 iph/Eq7sMIqOEojUUO4c6gM98NnbjIEdDIfIXp2zD27fxFURTpSC0admJ06ae8+M+NSzczMCpSj
 bu6i9WZkMBq1lfjIViJunX22yYZ39dyz53PEJGsNz7hRNPEz94UUaROONBl6D/6+JUSpGKjH/Yu
 OSNWBBtibvZWKyw==
X-Developer-Key: i=pasha.tatashin@soleen.com; a=openpgp;
 fpr=CAAAB722DD22A081F0D49F35633A6A993D43B569
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261108_083532_104530_AFAF17E2 
X-CRM114-Status: UNSURE (   4.21  )
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
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 22 Oct 2026 22:45:18 -0700, Greg Thelen wrote:
> kho: check fdt_phys in is_kho_boot()

Applied, thanks!

https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git/log/?h=fixes

[1/1] kho: check fdt_phys in is_kho_boot()
      commit: 58c5852ca96c58cdfdb9646870b217fc54d06a97

Best regards,
-- 
Pasha



