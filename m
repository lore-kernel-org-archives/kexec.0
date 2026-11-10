Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B339606A337
	for <kexec@archiver.kernel.org>; Tue, 10 Nov 2026 18:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Q1TsVaVG;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=TZtL+qi8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=nq8v7VJ5VqpFS97EP72RtDwjUZHtXRoVpvPyoM9R8Ys=; b=Q1TsVaVGHRUumjuV5UJBZ7SFjx
	4EpH6BvOJgTrjywt6/RH8ldXxmAeBA6pydG4Q39ubKG1X/7pWkNs7avblWYMhWgeuCHGXeB0Tmh34
	hrZQpW04CpUGkbvszrZXdjMDwR9gvWiUETP8RfIMC4bPNlWc/GjXOotLMpOSODOED5hMgd1TpaSlG
	mkXoT60mK8YcI3oe0Ufa+y6zJbIcQvMxhDNX6Q65m+2G58yGertQhNp83OpU+taDq+HzHBur7r6bj
	XEnlp3rjCi5n5x+sJPknzAPWCF9WS/nWomNrMQ76zE6TtJFaanno5iypS04o5euOYB2VnyZSR93ZD
	Fth0WXvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQqi7-00000004oKu-0mti;
	Tue, 10 Nov 2026 18:36:47 +0000
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQqi4-00000004oKN-1qct
	for kexec@lists.infradead.org;
	Tue, 10 Nov 2026 18:36:45 +0000
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-2e9f6a16afcso3355ad.1
        for <kexec@lists.infradead.org>; Tue, 10 Nov 2026 10:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794335803; x=1794940603; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nq8v7VJ5VqpFS97EP72RtDwjUZHtXRoVpvPyoM9R8Ys=;
        b=TZtL+qi8I2jiyT+aR3gvVZFi0Db5PY/YSMkxITd6f7DsPBoFK8qXksopWdRKKmk8g7
         IAkppZtRQ8zjDpFZ+vBlCYek6K9i6dK7znN9eWP4M2TYrN4k4CA2rEjF/zbowg9sri0d
         wPHOnaCGOqnnHM40tQBGZMFc4sTp0nHwI9mFN9OCcqjJVRwlOoPuF2VF0vwDt7UWAcu6
         wpQIN1O7v+EDVwodQsGNEhiY9t0P94u7O8l34ExhMz+Xl19XJgvPTp+2js3El5/1osaX
         tv3glqjHOdg6O08LIu6j4H/IgjqcegJvdCoedvVxcFzQL3gD6yQCCRO1hUxyHoLwBv4F
         lBLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794335803; x=1794940603;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nq8v7VJ5VqpFS97EP72RtDwjUZHtXRoVpvPyoM9R8Ys=;
        b=ISndqz7dhIkGzf4cLXtK6Iv+iXMDRoEJK+47UR7bcNIOPtsdY6lcr4wOpBteUVNElc
         9a8ownuSkLOUzyTrUMku8rQJ/WILvGAwxscvMCCLsRx/N7k7eFHGjTm6C7QQDZG/JtQO
         Fyltpbys7SEIe3EAIO4gqMYu6TcOBAtse2uPdlEjJ7FGf6B99p2naPMnlSOXMUzpOWZb
         6b7+av7ehW8ByQGkKW7WZvK7gJFlZ5qt+WROyxKDgXq8hsk7+188wOHZUkh8a33wMo/U
         1hVsJEd3mXkjAgM0OiD3MaOX9f/mFkxO/5kAe5Ihx4u1FSWdWHnqvnnYPfP6HuXG2Efb
         Ow/w==
X-Forwarded-Encrypted: i=1; AL+hErHGhDrWuV+eItMKhCm5KHoRmCz6FLJWQqSKGaZgCtow8QeOx66OxJn/OoDjjgm+Er4gsChvww==@lists.infradead.org
X-Gm-Message-State: APuU4Z92y+RZkQQxaL7c/ZtKj71S2wQUxFSMl0vETG4P4ptL75yS4dTK
	HgiRIIUJn08TX/GIUcDlIoFz6otY+0s6jGZ+bwpySdlUvEg61Gq1CxpK6nbPiAIZOvkHMbhcgHd
	NMGGjpA==
X-Gm-Gg: AYBFou2PbMwg5s1/cCoe88A4pKx5UzH4Wsqz7H+oH470B1MuLH9KHj8g/8V1qvhZihA
	rA+AUkiEOf91lbn8RVgKid6HvMSd7MvgGQz1HF9O2pg45hGhAqpf4AIfRr76D/FFgZZ7eQ0wvao
	QTDC+4Ejo+Y3eauYDbKLDaqrUHBq8Gnxuq/BaGi0ubQ7TO4Etbl8i/0Qn+6AQPj8H40BxhZSNt/
	NeyNN6UTVIwMrtek1jo8z/Yw6CoanlU5s+HpvmBaB4zQ6/l/m72sPQKM7s73/kMbHGtGgXgOvv4
	ccPkcP+m2A9Qx15ey7LX1xuDXhMaWlnGNak9fvztPYOnne0mGquinJUpLKlcWlFwlJOnUp4diMf
	FwxvDqDbqiP/bKPA8ysrwOfnK0GYFGHL2FwOuexUGyHJLC5428rFQ2xs0Lrp2EPfKgHkWayQ7k+
	0aD1L0Z5xKerXf1TAECYd7Z7eJzvNMbXSpCvNg0gqqpLu9MFbzOfkKMdXyBME3KAjGzdypr2M9E
	uiyp4oZWvDGHoQxaCquBRNOOLggqW74Qqz6QzKHCmB07c9+jvz6dJl98qFH4qwkELr+jhBp2Ngz
	EXiGar7ktD0MNcV4MdDssX/1HxOWnbg8mTJGjsRRyRkx8kHXNkI4RRIyp3m2IG5QqXJaYaUR3mt
	qiVOfwx3Fj8Y/g4ozk6rO5BgLMYfiTOdjcf1G9deAE2c=
X-Received: by 2002:a17:902:ef50:b0:2e5:9bdf:6b65 with SMTP id d9443c01a7336-2edd6b65b7fmr241375ad.0.1794335802929;
        Tue, 10 Nov 2026 10:36:42 -0800 (PST)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2edb6d7bf46sm12827355ad.31.2026.11.10.10.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 10:36:42 -0800 (PST)
Date: Tue, 10 Nov 2026 18:36:39 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 2/2] mm/memfd_luo: keep memfd frozen until finish
Message-ID: <avNkLp6z8MUdjgRc@google.com>
References: <20261110175855.2437084-1-pratyush@kernel.org>
 <20261110175855.2437084-3-pratyush@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261110175855.2437084-3-pratyush@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261110_103644_503392_79D82ABE 
X-CRM114-Status: GOOD (  11.10  )
X-Spam-Score: -17.6 (-----------------)
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
X-Spam-Status: No, score=-23.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 10, 2026 at 06:58:53PM +0100, Pratyush Yadav wrote:
>From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
>
>After a memfd is retrieved, it immediately goes back into "normal"
>operation. The file comes back unfrozen, and its pages can migrate, it
>can be truncated, and so on. If the memfd is depended on by something,
>like iommufd, that can open a window for folios to move around before
>the consumer can re-establish its references.
>
>Finish is the conceptual point when a retrieved file can start to behave
>as "normal". So take an extra reference on the folios and freeze the
>memfd on retrieve until finish.
>
>Suggested-by: Pasha Tatashin <pasha.tatashin@soleen.com>
>Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
>Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
>---
> mm/memfd_luo.c | 87 +++++++++++++++++++++++++++++++++++++++-----------
> 1 file changed, 68 insertions(+), 19 deletions(-)
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>

