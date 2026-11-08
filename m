Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562AB606A331
	for <kexec@archiver.kernel.org>; Sun,  8 Nov 2026 15:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=OKU1EF2S;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=LEaIdcp4
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=5H2H8MP8L+/rXp31cDc9VnUcbqmvBKhHx7W0RFsHYLE=; b=OKU1EF2SLfcA+V
	dMCokgInuipTME1L5i3Z+0LcvlxMpORAkHw8tFj1bBeZWMcv12xkjKeowtEOgD4KXfGJfJJXHAp2a
	3Vq4RIutJx5TvkuoydQiN1TjxdeTxDcHxitBpPnscbePjYct/2LI7RFudk0mYU3BmeHByEP22ywOT
	Uba5bwl4J0vJbcwJQ8KPv4Gb23NArvmxAgkj1CJ7bhZab8yc4kChbljnql+U8RQXYhqCp4lTqZ0Dw
	1GL2Fx5gCmuubhFO2Iy16cFExah1ZkHBEjTL8TErRhkKVKUev/43gvSxKIK4KTJTIqyxU2Qj58XCr
	ub9iaZDyqNBkvskpY2FQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQ4ko-0000000GItE-21U5;
	Sun, 08 Nov 2026 15:24:22 +0000
Received: from mail-vk1-xa34.google.com ([2607:f8b0:4864:20::a34])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQ4km-0000000GIsG-2K4i
	for kexec@lists.infradead.org;
	Sun, 08 Nov 2026 15:24:21 +0000
Received: by mail-vk1-xa34.google.com with SMTP id 71dfb90a1353d-5eac7220e9cso42065e0c.3
        for <kexec@lists.infradead.org>; Sun, 08 Nov 2026 07:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1794151459; x=1794756259; darn=lists.infradead.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5H2H8MP8L+/rXp31cDc9VnUcbqmvBKhHx7W0RFsHYLE=;
        b=LEaIdcp4bC2WWXgWGoZEdVuQ0hpTuVLPyaLvgk6lpCQ1I7aV3YOeuepLbu5oreQuhY
         RpV9BLn1oWo+oqC7l9wKCwf2fpO+7k5Knnqk89ZbHzq+Ph6/Eb7rusAcw8T6kYdAu0LI
         SzX2+fhPbTQmTOB8pW2aP/nistLv9EMdpHpeiamOpaZPnOFTHoJAqmc46mjIm5E4Z1s+
         7TiN7NpXYNxxrdSnrUdndb8pjw3PblEL7Oh28AQ8efOBPjM9JUdYnCxrCYbbVJOKVmEh
         vUhd1L27u1ssv+0iAKdbQhPtvhLkSB86HsnPf8GyZMbtFH0n1UWsMUCBynylku+qvT3j
         tCVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794151459; x=1794756259;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5H2H8MP8L+/rXp31cDc9VnUcbqmvBKhHx7W0RFsHYLE=;
        b=o9/wc2MnI3cvMhit+rDL48m+6KxrBZT82QHO58ZiumPzd5AizgTUC7vIczD+I26ot2
         mNRKbPhf5nTS72l87meT1K7Ue0f8mOu3ie0XCepuz1Y2YH15xqf+2OMWypwdUT4l5A/4
         7KwIMsxiQfT8hXap7zLKcplbUYCCJNq6FF3w9deibT883Bl09H1Ely8kOT/PRdGFfUrc
         hisPotAYzX/ugesmpjj94Er3Tw8cZ/Bbhj3PWj2Tj1YbJbAGGRZt9imDBUnVZvPijqVO
         VaKUXMISSvC//NUqrR9YZx1IQvAAlMpesTaNFKoSinF44L2I0XG1m7G3Orp3PYU5XgNn
         0/MA==
X-Forwarded-Encrypted: i=1; AL+hErHgcGm8emmqtADkIavJ53N5I7B3F7jnYYB0viDhl/mDLMxzAAkZREblHEwgpgh74D5Ln/xj3A==@lists.infradead.org
X-Gm-Message-State: APuU4Z+nBwVM3HsU36dqlr52MVBw29rdVIcEvQ46Mt/WXrAenYMqzTMw
	8hLKCsJj1ffwyz8XPUNP0JawczM95TecgKisYkdvuR+9aboHL+gUrkNABO9UbK7Une4=
X-Gm-Gg: AYBFou3EiIWnFrGgECro6PjOdMJ9E36h0viwXAz2ZoYpKBmId29n4VirTAN627j49KT
	h7Gi1uBFshbM7jHikmUgT3miXJPveEFyJLSzmGsQaYNotd2z94OZIh81sKfZnocCJtj4SCNPIB5
	VPgRwxsAGeQ7lrjF/drQkzFXda0cDXfwepOmAPEJGyWXb5nK9zdVsodJTrtxVkNWY5JQ87qAPAv
	3kGRZgKwqXxcBecM7MGUyeezHxPNGYzKQxkzJsZglNCmjyssx57zkViCv2Q4fR9sUES9mg1pMOr
	zQHSAJ2wcroqDHWdwWaHSHnX5ftjXRu84vOD+QECCqvqCltvi2YrCYiWj7vYq+rShE5vEOY7xvU
	KGRzrZHsegMVhiWUwgtd7PbsqHTY4Co+GfJCXgFdjJCeEkRNa9SDSyPn4XtdKGHQ/QaYVl5lz8R
	/XOS+YomG2CC+iTZia/bXfWY8B3l27+Tv4B7QYLNWbBUnefnpAyVeD5WxDPpWfwX+AGlKWo+r7U
	Dq9CBh5NR5s5gMt6T0OFBS5PphWRwwFRNZN29b+oep1f6wia4F+aRnz6LglFg/Lt0kUT9hDxpQx
	LGCcGJoYro0EI4ANxUC4iSv6xahFCZmjGKI2g7TosRwK/4Ntipomg/AYT6kGYvAOnj246dpFwKh
	c09VgJiBMaSwSHTvG8ZbstEHUTjo4aV6aEF/j9V6eUg1jUUO2
X-Received: by 2002:a05:6123:4a:b0:5ec:c162:d58c with SMTP id 71dfb90a1353d-5ece7232e04mr468275e0c.9.1794151459109;
        Sun, 08 Nov 2026 07:24:19 -0800 (PST)
Received: from soleen.c.googlers.com (64.167.245.35.bc.googleusercontent.com. [35.245.167.64])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ece60c1adfsm2166205e0c.8.2026.11.08.07.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 07:24:18 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 1/4] riscv: Call early_ioremap_setup() before
 parsing the DTB
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Chen Pei <cp0613@linux.alibaba.com>
Cc: pjw@kernel.org, palmer@dabbelt.com, alex@ghiti.fr, rppt@kernel.org, 
 pasha.tatashin@soleen.com, pratyush@kernel.org, graf@amazon.com, 
 shuah@kernel.org, guoren@kernel.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 linux-kselftest@vger.kernel.org, kexec@lists.infradead.org
In-Reply-To: <20261106071459.2003-2-cp0613@linux.alibaba.com>
References: <20261106071459.2003-1-cp0613@linux.alibaba.com>
 <20261106071459.2003-2-cp0613@linux.alibaba.com>
Date: Sun, 08 Nov 2026 10:24:13 -0500
Message-Id: <179415145357.358073.15510298244264317494.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=612;
 i=pasha.tatashin@soleen.com; h=from:subject:message-id;
 bh=3Y64H37LmlHFT1VEQVtmy1MOdzH3F3b2j267UF4uRWE=;
 b=owEBbQKS/ZANAwAKAbt3KEzbc3reAcsmYgBq8JQgz9JeNn8fjKYo6x7VzlFWQWT/Lp3pbpLNs
 SP93uPVKjCJAjMEAAEKAB0WIQRBMaqT7LRvGvB/NmK7dyhM23N63gUCavCUIAAKCRC7dyhM23N6
 3uGHD/9Puz8wWfsenmFRRLxdqDDp4alEi2QGtibd3g1gVeZ7Erpg749NWd29hLL+Nps+tMLws+e
 ee5EPvfyBmjdqv2aB9jwLRhFRBVCu+uecsYEpi5pIvZnhLUYS7pLfzWQESHepH0t1Uo1zbs2ThQ
 w2QeZ6ys+x3aRZh5P4T57xtD9ZKTMO/lx5nL0zQ7y10Lc59MkvZiuIpgegVGt+afWmMp51e1LMU
 zZTNA54QUipvJplO8tdXHzC2R9tnDyCkspRxxi+iIQ52w3TaF2LY0HGMYNKjv/GWdQGcaMoORg9
 HPw3OPmHgI8x2rX0qbSZR6VLp8KqKd8jnlSzWcI1w2NMxzwF5tswwwvmxHxRXWBigTxL/ZI91qg
 FBK/MLdWhxbZ2ikerG6+mpnyJh8ifXFLI2QXmbVvjiKZTghn9/oq313tuHBfPlBxHLT07rp1gwh
 EYQ/h5X/PzAQOWJTT7h6f6LvoJANqrnrTIh/YVT3FGSGfOs82HjJtsmvkPAbaY6bCM1fgcy5Iu6
 o0CHn9bw6TOupWQqjrVgowolhg9vSeQNBv0rpoRTA/lmGKBzSTNtRYZeZfeQCViJ9VL0X/OlK9C
 l+fImT0gCxVTujJCKLC3TbO2Nb9dqnsI0iSqK/Ftgm/7Pt3MXpy48agJgU4famUxHxEvG0dTa/r
 P3vcc/gP4HWC/tg==
X-Developer-Key: i=pasha.tatashin@soleen.com; a=openpgp;
 fpr=CAAAB722DD22A081F0D49F35633A6A993D43B569
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261108_072420_638058_62DB610C 
X-CRM114-Status: UNSURE (   6.58  )
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

On Fri, 06 Nov 2026 15:14:56 +0800, Chen Pei <cp0613@linux.alibaba.com> wrote:
> parse_dtb() can reach early_memremap(), whose return value is composed
> from the slot table that early_ioremap_setup() fills in - and on RISC-V
> that setup ran after the scan, so the mapping came back NULL. The DT
> based kexec handover parsing is the first caller to hit this:
> kho_populate() cannot map the handover FDT and the handover is dropped.
> 
> Run early_ioremap_setup() before parse_dtb(), as arm64 and x86 already
> do.
> 
> [...]

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

-- 
Pasha


