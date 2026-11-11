Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D178606A33A
	for <kexec@archiver.kernel.org>; Wed, 11 Nov 2026 21:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Fz7h0Jqt;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=UWJVP6IM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=ZoJPYJRE+a3rUDuNJFthWOEClKW7JBQ6lGyHIzbta9E=; b=Fz7h0JqtSjLQ6R
	+Uc2ZAU42auGej9/NDCAf7cNCbRRnz1UxDFFqhqZWvb9wl40yBCza0HDFeYntwix724LTRJGQ29P9
	6B9Exog8no+7L+H11twGVg1ZckdnfoYIAvifl+ce+lxQ163tu7p9DXhTwo0/36daQ2NQ+2ocLjZoM
	DBwXVUSHfBGRXwO7I6v435FMkfmVAjNNZq84usgPZGLINBTVz9m6OgIHXQGQd83mV1ZSWfcWJwThk
	87r/s3/bGGc04N3mzoMgF0i0c3TnuOWlcQ8+nKMae7Wkdie6IFEur7ZI08j9HkfANb6+t6uvzzb7c
	MkeUtM+kXMTRqKQ/bXHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRFrY-00000007omZ-1TIT;
	Wed, 11 Nov 2026 21:28:12 +0000
Received: from mail-vk1-xa31.google.com ([2607:f8b0:4864:20::a31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRFrW-00000007olx-2CEO
	for kexec@lists.infradead.org;
	Wed, 11 Nov 2026 21:28:11 +0000
Received: by mail-vk1-xa31.google.com with SMTP id 71dfb90a1353d-5ec690faf85so1180632e0c.0
        for <kexec@lists.infradead.org>; Wed, 11 Nov 2026 13:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1794432489; x=1795037289; darn=lists.infradead.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZoJPYJRE+a3rUDuNJFthWOEClKW7JBQ6lGyHIzbta9E=;
        b=UWJVP6IMglYxMy46YQIb3az0pcbQZ5zI5chn3EinQahGMAk3rPS3MUuiXKgWeGgaTl
         uBQjM/4tfmOxPYo5ZOefKGSYvMKDSwmHHT56BtyWkaPsat+tTv4sI/rejxpGtFwwQBqT
         mdaouldQA5a7CrDKeVSQF3/EBpOh+FGBqMRG+LBC0Eaz81QmEuCpRmeJ4zcGBcjxpYtz
         TfdJoeoLpvvaLsMoxH1CybugZBjeRpQLHJRhJ4fs9ZaJXXLouuyMYiRTWabl2JS84RA/
         /uEa6CIfd1zNYHCc9DLk/JKQfDAk3dLaJ5TW7872wX/qlM6qmmFZjk2fw3ghS8l9Rfwp
         tJ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794432489; x=1795037289;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZoJPYJRE+a3rUDuNJFthWOEClKW7JBQ6lGyHIzbta9E=;
        b=cNs/7Xm/ZqWSk5Y4caWa3JmzPkzuhvXQw48gWsfpw9qGC5Jw7bocFMdj83g03SOJSI
         2Tkb2gjGJa/QmH+MJyJ3OKnZCRIiyPqYeRtsXMDy258Cw+fAUs4PDNpjgJE63lqCpV57
         ixbN8OzVHqA/DCx4AC3I6ctPmxyo6LA/Cum3lJzMgRdHhEOnXza247lPe1tzNpDSHNJS
         cBULFaLk3JH6AXE3lkkHpUAyBviyJ1TkEbT+hXYsjwzkDX5XeyaqP0VEhlGoxvCiyXjI
         RWBOjtIIOqpIR9zTSCvKgo+HTwXI92qm/NRqOOg0fwStAg/wCbunB6oEPZSSxwHiY9/P
         ESJQ==
X-Forwarded-Encrypted: i=1; AL+hErEEadXYd5XRmGJ6FmAPmeN9iKIcG+jzCTf13LyK+hd5Qv1O5KWp77Voo/P4VMUF/f0KGWHKmQ==@lists.infradead.org
X-Gm-Message-State: APuU4Z9kHS35FO2S0Oo8YgyWfv2pT3H9QfWIQ3LY3Z71vIeKqecIalYD
	02Mb/lCTWiJiVcSDAsdYs2jUGKL4kgCa4n+nK42dhoDQ4S7/Hib7Ygp3EDM/nU9LGRctUyGa16a
	xzSO9
X-Gm-Gg: AYBFou29WJm8SHdP+udBZqdEH9H6nkmDVvLSaIJVgMDt+a1rhBY8FGRePtM9yhTaF0w
	wG0lK5erOWpdLt2TXxWWStGqEU5p8ffgksciPN9cj/xgUBIAE9jt6J617e9zFbPlSYyV33A4VmY
	vZcg8eK2DnG+G4FQtxF+gmPVdQ9bJOjntVdRfaVq9zUdJlA+WJ5WWBD5cItkIlTwHqp15S/pZGf
	XD0hlbA0Ey3e9kAjqtJwoAHbXQPi+NL1x12eenb3d9f3EZIw62TeiI/Tx+BgIXURpNIck1Q2ie7
	GPr4L7V6TFQcknVhlfMOI9H3Rhv7GgGHn9xF+0eirZN5B9g6r+GB/D60tjaystp5N18eRGS4jmi
	ZePvgEnh75CJPCdAs/BJR25zyxQZf+8mBBqYPEIxpRRPgR0FqN/3dQLiF0+Bd6GKKJOb9uauCtX
	qTLRqHZ75zwJp62Qnk3wxSghPID4Q76YP4z4YPgzFBOm1HGir5PMLNhMItp1xFHFguH7v62B2FL
	sYpbDZ4PD3MzDgRp3KQCSeA9od2Cv+laqda+61PYgt8r1sY3SuJ3ssQfQuLIGpvCWI/8K3SQ/hW
	kRi2w6MzYIDVZEsWXgaqPjzYTOetJTXCxiudMSlVjI7EMqI5E26lKyWCW8xtdmyqsTEFbksTrlZ
	I67a4vEiZKNn1eanOKltuJGzQxL1Yn1+e55MsQczqnyW/SyQ=
X-Received: by 2002:a05:6122:d29:b0:5ec:e7e:27d6 with SMTP id 71dfb90a1353d-5ee1c3f4dc3mr1648884e0c.4.1794432489164;
        Wed, 11 Nov 2026 13:28:09 -0800 (PST)
Received: from soleen.c.googlers.com (64.167.245.35.bc.googleusercontent.com. [35.245.167.64])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee0c45a110sm5203554e0c.2.2026.11.11.13.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 13:28:08 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] kho: Prevent reuse of preserved pages after a
 reservation failure
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Chris Down <chris@chrisdown.name>
Cc: rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, 
 graf@amazon.com, kexec@lists.infradead.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, kernel-team@meta.com
In-Reply-To: <avQUquBK6cO6tUUI@chrisdown.name>
References: <avQUquBK6cO6tUUI@chrisdown.name>
Date: Wed, 11 Nov 2026 16:28:03 -0500
Message-Id: <179443248353.2329176.13720873996862751451.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=543;
 i=pasha.tatashin@soleen.com; h=from:subject:message-id;
 bh=elFU4wPAMaBwFrT4m33njt5Q2auHHtG7NC96QfM6Q7E=;
 b=owEBbQKS/ZANAwAKAbt3KEzbc3reAcsmYgBq9N3nz3mQqqZrDWc72K1rOdBUMPnBo7ID+Ai0B
 BiIhG8vS0SJAjMEAAEKAB0WIQRBMaqT7LRvGvB/NmK7dyhM23N63gUCavTd5wAKCRC7dyhM23N6
 3hSgEACblS54tgUdblcItbWjWQY1CPYiO7TGqqZhhdrLqVtXFac+KaDZHty5ilwOQXbXz3faZP6
 tSkSdpg4RSpnv9BxJ0pgW/oV/uWlh0ldV1rXZo55QTXgkfYapVrbiYNWmoiEkrvT3XUOwfUXjAk
 y4kMM3Lm+6imri2z2cC9ZwODXrzlCak5wtL6z9S/AwC/EfB2Qr5z0H8irPqr+ixQckAkOM6as62
 HHCCumwW77zcIs0HjI584FuSyvGGnYt1WQLtEMuIoco6wk5Th8XTnHNBWplpX8hk68PTQZ3uddJ
 OHUEnGOGB3+0cOjr/sF6hbtB94cP/StjzirPi6UHoOlkXaJce+SG5a3qmCA3VyVjEJgkcopWCL1
 /9QRwBV1NNdNxGUDdxv2WQK5jM9lsz5P7QaZN16XY5gveQW7rWNBF5MiDpLmZRxO4dsFjqb5T0k
 62ivZnDTjzdJHRWUNby3GJKXKz4u2CKBivaHxBzPS+bD8k3RV4s7fATfYOsXyCJdaLkiu7X/C9a
 a36oBuvgU1+tAdW6LkbWVkUVwDzRoevrZH16WKRBySusP2btDD/wwoCql/HTBtTB714M4SKqfuG
 SAm0mxL++DCkiyW05CAijA4BWVFgswkITvUwI8pbEhX09pN2OB2PdueWiuuK01EoDtKz5yQBNyI
 /5AJgaT3+KKUnjQ==
X-Developer-Key: i=pasha.tatashin@soleen.com; a=openpgp;
 fpr=CAAAB722DD22A081F0D49F35633A6A993D43B569
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261111_132810_579501_2454E3A5 
X-CRM114-Status: UNSURE (   7.66  )
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
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 10 Nov 2026 23:09:30 -0800, Chris Down <chris@chrisdown.name> wrote:
> kho_preserved_memory_reserve() reserves each range of preserved memory
> in memblock and marks it noinit, but ignores both return values. Either
> can fail when memblock has to grow its reserved array and can't find
> room, which at this point in boot it may only take from KHO bootmem.
> The boot then goes on as if the range were reserved, and two things
> can follow:
> 
> [...]

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

-- 
Pasha


