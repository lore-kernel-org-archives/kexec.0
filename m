Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD81FCEE351
	for <kexec@archiver.kernel.org>; Tue, 18 Nov 2025 20:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sBWoQMYYG9hFsTtDFMPgr7dIw8C1zg8c5nc9F57mrj0=; b=sU7cd2CSyLPVwUccJJ2KyD5QoM
	EOQinqYdPkt3eXPQs+B+mSBxlKCSFEYDd/0uymXsH37t2OBiApmeSZwDmXHSnJM6C4YrU26HTuaIF
	Cu476j5raIBwmFj9tspY+Tq3f02qPqsv3ikvuJeddE2+eIDXRuu6vwLYrra5TcIzdqvDRqEvGNys8
	jnk7bp3ZXnAqPfgveApmSu7Fq16jtMAj2X48yK9VtHwK3zoEFcVZSIAIET2TyH9LXAuI14lI8EyGz
	ijZWHgFCFypOi36EzV+giLJi8lyANVwDcJOMYYDFRgTUxDHxLikYffkqVhWU6MAYiOeMIx2JFYgc4
	hl+iQDrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLSN7-00000001556-2LQN;
	Tue, 18 Nov 2025 20:32:17 +0000
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLSN3-0000000153z-0mNP
	for kexec@lists.infradead.org;
	Tue, 18 Nov 2025 20:32:15 +0000
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-644f90587e5so2753115a12.0
        for <kexec@lists.infradead.org>; Tue, 18 Nov 2025 12:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763497931; x=1764102731; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sBWoQMYYG9hFsTtDFMPgr7dIw8C1zg8c5nc9F57mrj0=;
        b=MPPxv05cIPtc8TRSOUZXqpT+iLf6F+xVPFLL/PMvKG/MrwYluOtkhpoAAws9Ete0FW
         UeYpngrj/jpc3joenynJMR52SIHkqttM133v37NX2Ti0WgMgo8J3H3pM9iV2cSBMPrX2
         SS3QFg4HQU+7rBUY40NohyV9G39PlgQs4DCYTD/sjyL1VsNSy5rhG9SILxq0Ki9BLfT8
         kBzDetBhEbpqmbGzwE6wLV39HUiWmMDTdyEPJZy8OgEZb+SP4MqOz3vZy4BKH7uPJsX1
         1q+70bY9oJYD8MxDwJhyWHemY3hYTdv8TFix5JCNanPwxWm8IBN7n34h2lB1vz4SMSoY
         7qTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763497931; x=1764102731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sBWoQMYYG9hFsTtDFMPgr7dIw8C1zg8c5nc9F57mrj0=;
        b=TiEfPK5I8wmgQb0fgnpcTCgRQ/qoab6pGiL0Zk8ZpYJrT3pQ+gQ/SKcSVmhcNWfzN2
         5oci4x2FjqiRMMG/pS9FG1Suq8ksxvkuxR+yFfuIo33qR6OavzVScbqhqtD14s8zfh2I
         nFeKu5C8UQrrlgViCY/Pfgic2gdyP6NB/K5O8LPGH6aQDw+xTrrC7Sjglub4wZZczDUA
         Njo8lpN3/dUsnoeRvZlSGlevr1+JC+QNkoDlxNroZLpWBM9S4YEEEuNayfcFQk8d/b8K
         S1esj8HcrUzS+ySS0oimiT4+r/CJikcxc7kfmbLn2EPBBc+MR+qFqlUTBclpCRJyofJb
         8jyg==
X-Forwarded-Encrypted: i=1; AJvYcCXddCtnyeUeRW52LZpeZspLxe09jKkF6gDH7ZTmXRMAxFTOmImgGTQLvPvxBYSm22occB9Qjw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw9O3aUkAEx94ea1QrCQXNjGsTpEVcFq/YLX+/YI2qiuK3uxsyK
	0fYrUcVTWcRRoQpr6SZNJOpsL6FHAuHgoPCdpAhRVKXc4g6CyKqxTLAq9uMUn4mKkYz+D4FPbZk
	z2tH2iSWNoqBQVYQSYQGss524tu5T3uITbHBXitNaAg==
X-Gm-Gg: ASbGnct6HNWi5chO5FG6ZOOshj9KvyTOuAFO/4iZhWKZ3NjNuHETTM5KmbVfMttVWSX
	imiEjPPFftFdCvjS+zvkq1Pb6fCwIjbShqBCVoTDCaItEhebBum6efgHcvu4e6JgThbozZAlDeY
	khuKBlqO09BPeh/UsK2Bkmr298Hi3EEGEqDBPCWwrmisPAVTFHGW+ZgB2RoMdcuZHA+ZRpZw5vQ
	hbsR3eIoiS2zlWy5s0UNIRlyVUK+8Tdk1mt/4Ig+AH/1FyPW/Y9vMTHYQ230jh3qew/O2BH9U2J
	x00=
X-Google-Smtp-Source: AGHT+IHP8X5K/LKC2JInbcbobi0WNd9xLFIh2mdNfhA8rQ0GEk5lHr6mWbEU3+ejjBwErY9sX3j4PxTJ2ml3UKwmUcI=
X-Received: by 2002:a05:6402:1d48:b0:640:f8a7:aa3f with SMTP id
 4fb4d7f45d1cf-64350eaa0e8mr15815608a12.25.1763497931265; Tue, 18 Nov 2025
 12:32:11 -0800 (PST)
MIME-Version: 1.0
References: <20251118181046.23321-1-pratyush@kernel.org>
In-Reply-To: <20251118181046.23321-1-pratyush@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 18 Nov 2025 15:31:34 -0500
X-Gm-Features: AWmQ_bn8okgSW3sxizgThiqSsWpq9bQwatuGC_QPhuxTvRB32K8-7pbUIwkWJm4
Message-ID: <CA+CK2bBcgn9j_jPSxXGQgfezx=UFogs-mz0qm2GQwybkFvnpTQ@mail.gmail.com>
Subject: Re: [PATCH] test_kho: always print restore status
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alexander Graf <graf@amazon.com>, 
	Mike Rapoport <rppt@kernel.org>, kexec@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251118_123214_650218_709530CB 
X-CRM114-Status: UNSURE (   7.40  )
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

On Tue, Nov 18, 2025 at 1:10=E2=80=AFPM Pratyush Yadav <pratyush@kernel.org=
> wrote:
>
> Currently the KHO test only prints a message on success, and remains
> silent on failure. This makes it difficult to notice a failing test. A
> failing test is usually more interesting than a successful one.
>
> Always print the test status after attempting restore.
>
> Signed-off-by: Pratyush Yadav <pratyush@kernel.org>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

