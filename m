Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 583E9C54FB3
	for <kexec@archiver.kernel.org>; Thu, 29 May 2025 07:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=syMy3AybDmsepOAGB746Telxh05y74Hp8pPs/HAKQr4=; b=LSHGpGjVXnuXBxO4oCHx3BFY6g
	KRE8CzTqOv1g4v3MjwAbqnTe0hm25262+OuBbVclBI42mPtAIF4gUrUtxKoLLU75GOZpQyxfFnW+u
	lYrPNh4WOsQy23HUbci4ItAdlK9F9XXPYu2OfBx5szS6AtzHlR9RYnaD/oVEXkdRr5AHZ5MQdt4So
	WiyP+Qsg39tbsfd16VXNDwzU5uEdFEpJZ9829i0rWbJlqFZOhqd5R6T+qeFO0wbdDTVaofJHtqy+C
	GOhcLGUjqfLscbFpVSHqRZz4uotwgyKsvBc6oGWF1utsgdiyL52dEXPtJLUWk6scpyBNVXleXcSiW
	+qkKLtMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKXyD-0000000FClt-03Rp;
	Thu, 29 May 2025 07:46:33 +0000
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKXyA-0000000FClV-0lVc
	for kexec@lists.infradead.org;
	Thu, 29 May 2025 07:46:31 +0000
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-43ede096d73so4693455e9.2
        for <kexec@lists.infradead.org>; Thu, 29 May 2025 00:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1748504788; x=1749109588; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=syMy3AybDmsepOAGB746Telxh05y74Hp8pPs/HAKQr4=;
        b=Iv4U1dJ+LIQozN5hNCfRkRY57wyDlByaWtxrnl3e3jklaxKlhd5PD5jL67agg2sUqO
         8o9cw9AvPSTpA/xnwPWoPBBZ8txdXsub7yqYTcLBvo/IC8WVpgmTepEeaUPuOAjn+u2+
         uMJrXSAUoCM/hmhncFTI3RMR4SHxzjdrprLV/S7BSxVRKi5cQTKHKvyw3OMgsqsYqgSI
         mfv1JJ3hpBgR2qCmyDM9dpvVib5D/KsGkifakoC3WWfwJc+nvX0YwwhvIfM18x+6vXiq
         xFPBJH2nM9+wykTFWRhIGmmNgwAO/2r7q7Xook3alub0RvySalEzt9ULdUZA86YEOjQp
         hhyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748504788; x=1749109588;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=syMy3AybDmsepOAGB746Telxh05y74Hp8pPs/HAKQr4=;
        b=o0KFVWey7qBB0L+g0VkfJ584ZLEtYScF/sZHdXgUlDK4vJ5ecL/VBzJfTaB9IqR/FX
         uIxLe4aupO1cOM6TjSEMkLwLgMgddVXSsPh2QWS6a3ScwelCLu8qNnaIVzehEN0nXXwp
         WVbCCdcMzdsgSPtW6tsh9FxEtDUPnpeNDIN+x1YMllQorGotTgf+BMGoVw8fwCS6gjQ9
         N2H0x4sy/ksAzqN0TLBSiF4kMkEKuQLps1TG9BPPIHFL4pgFjYJHvWb8aBXdDdQRZaBZ
         44ZxJYmjfnqdH8oo6fi84QIVb+6fxbQKeio+DC7qGIk+UN+llY5AlEreOqIJ2wOY5EFc
         /ERw==
X-Forwarded-Encrypted: i=1; AJvYcCVkIFxrFyLlaGCHYfOY0cfDe3HEo3deHm6FHzpdsd7vi34EM0aoBUIlkKUmC2FxjDkm+tC8Zw==@lists.infradead.org
X-Gm-Message-State: AOJu0YwAqbu60yJFabDos8DLXmLgVkCgN9ow7z/4EWO+2K9yBHUyprVX
	6tXjWCvjU0pHv9C10U0gQ7MtPS6rOIS1B1SDZFrMQEs6LZu3AWu2pIaLyGQPtS2fu4b31i5CyiH
	7ICjT
X-Gm-Gg: ASbGnctaiRPd9YqXObJk27ClRy5+EiNJMspojDUFnYJALNiu40OtXtSWWP9NIyJfTi3
	Av07sg23Y3MFEAQlDdrcupa4W8jjhJWQizYhvETF0Q4CdhFDSRpH2rWnmh79dhA50YYpWO2tHJg
	sl2aQBBnpK64Na+mWWhotiw0EPAnFj5bWBjfSTD39TIfZVY4YFhkJodOdjGpgi01fjYby2z0lhJ
	fVnW0jaYigKWjGwbqSXe8TjHJ9P9s2CpcfMru/Kp5GZeXCtibCuqWTBlXaOGsTNwx4D+BorUSEt
	86d+NJp53Wz9mDw6+N4VMcNKQGUNvluKBtUtZGlh9liGGf271V5j7vKirBnO7KRCdL1LbLHJGzQ
	=
X-Google-Smtp-Source: AGHT+IFyyyh3PVIeEkj330p9rwCtHJl3rwnG9K5GL0tioS2pW1P5yNw5ZKlXbUTgPkuZMaMRVqGYmQ==
X-Received: by 2002:a05:600c:4592:b0:43d:17f1:2640 with SMTP id 5b1f17b1804b1-44c92a549d2mr180964215e9.26.1748504787792;
        Thu, 29 May 2025 00:46:27 -0700 (PDT)
Received: from localhost (109-81-89-112.rct.o2.cz. [109.81.89.112])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a4f0097205sm1148358f8f.79.2025.05.29.00.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 00:46:27 -0700 (PDT)
Date: Thu, 29 May 2025 09:46:26 +0200
From: Michal Hocko <mhocko@suse.com>
To: David Hildenbrand <david@redhat.com>
Cc: Baoquan He <bhe@redhat.com>, Donald Dutile <ddutile@redhat.com>,
	Jiri Bohac <jbohac@suse.cz>, Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
	Philipp Rudo <prudo@redhat.com>, Pingfan Liu <piliu@redhat.com>,
	Tao Liu <ltao@redhat.com>, linux-kernel@vger.kernel.org,
	David Hildenbrand <dhildenb@redhat.com>
Subject: Re: [PATCH v2 0/5] kdump: crashkernel reservation from CMA
Message-ID: <aDgQ0lbt1h5v0lgE@tiehlicka>
References: <Z7dc9Cd8KX3b_brB@dwarf.suse.cz>
 <04904e86-5b5f-4aa1-a120-428dac119189@redhat.com>
 <427fec88-2a74-471e-aeb6-a108ca8c4336@redhat.com>
 <Z8Z/gnbtiXT9QAZr@MiWiFi-R3L-srv>
 <e9c5c247-85fb-43f1-9aa8-47d62321f37b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9c5c247-85fb-43f1-9aa8-47d62321f37b@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250529_004630_222059_0D055BA4 
X-CRM114-Status: GOOD (  13.55  )
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

On Wed 28-05-25 23:01:04, David Hildenbrand wrote:
[...]
> I think we just have to be careful to document it properly -- especially the
> shortcomings and that this feature might become a problem in the future.
> Movable user-space page tables getting placed on CMA memory would probably
> not be a problem if we don't care about ... user-space data either way.

I think makedumpfile could refuse to capture a dump if userspace memory
is requested to enforce this.

> The whole "Direct I/O takes max 1s" part is a bit shaky. Maybe it could be
> configurable how long to wait? 10s is certainly "safer".

Quite honestly we will never know and rather than making this
configurable I would go with reasonably large. Couple of seconds
certainly do not matter for the kdump situations but I would go as far
as minutes.

-- 
Michal Hocko
SUSE Labs

