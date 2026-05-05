Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0658ACD342C
	for <kexec@archiver.kernel.org>; Tue,  5 May 2026 00:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mJ2Sv+3oMbNngKzUZrpFVSbPEqlLqAid/lINt850Zv4=; b=dOypxQP8VdT7+7XU8hmHaireAT
	V6VPSmAvkcXWmzvT4zRHsp8AjFKNdeYQTPoHq4fjhOiCtBWixosdyMNd1GzibwkopXfO8R76hQd4Y
	hI2EQfKb43qmhLgxdE0GyjVlWwBle3qJXhiWSM+wIqfIOLtRNHbK9jlPXX87d5jlny6ZnMU7xtBHq
	Xkb/zZvIXk1mpIYhc1rtyT/U9aPz5b7ON0w5Cd3xNDC1775df654FjyBZD15PtQxGvJ/H8BJFuYZG
	Jvjtcx+m5QCypFb05YmZ++C5Jb9mjZCKp3sP7EFWZWZ1fdTP/9B/FgrEpKtQ6CV8QK1RDT2zLVktC
	VWNYVIOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wK3fr-0000000EipG-15j0;
	Tue, 05 May 2026 00:30:07 +0000
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wK3fp-0000000EioU-2hJK
	for kexec@lists.infradead.org;
	Tue, 05 May 2026 00:30:06 +0000
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso23465ad.0
        for <kexec@lists.infradead.org>; Mon, 04 May 2026 17:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777941004; x=1778545804; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mJ2Sv+3oMbNngKzUZrpFVSbPEqlLqAid/lINt850Zv4=;
        b=h2uV1Bt0K4em2l73HMMVOm2zd/njSLfVoo8T79WUJQ2lrmvqM2EW7lu3z7Q4QcX/QS
         AVpFHh6bmbNxktjLQboQRF57z2nfK3sqx9Hd9ACRuPNmA6wZvXP2QBVJvHfnggBd+Pv2
         0tqjzL94RlkzqTLDxQZqI8Uqfv3WlFwvpRvVL8gXmx7GTlViZdVEqgPKHBCLGXFecXtf
         gYSBJ2jKKEgUaisMuX46qK6nBikGVJYOlNIUrRfo/MRZLIV+Hz3bCU35d9n0ay5AP48v
         PikO+ARB/tVbpv7NIBgskUuEQjZh6KvqfiBzXG49REY8aFv3bOl4/N0YhXM4qvxsDbFO
         aRYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777941004; x=1778545804;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mJ2Sv+3oMbNngKzUZrpFVSbPEqlLqAid/lINt850Zv4=;
        b=fyVbzSk3WRI/MbBbnf+mMJkIYyU0pezbH39scoNC6IxHFw+TBo1w64vLkApwPL5aew
         vnbmLzZGxXdlTFLXsP7Mck7pZuBbyfIPksd8BKzb296NU4WBFL/wWZa2+poAcZzvrHrh
         vKnS5+A++KQARW/OiyuEUckhtVuSwFuETCjc2UTZYH6quIlefmQPSicBkaA1M9aXtAgt
         lsaMVM2+kFKUbujPt43aYkQwQKIBVK93lulAyrwh5j4aycRCR5wPYrRrnwJK+i3pnlLV
         sr3FjpjgyJDOjMAdg0vZd+LEvpWrojdcjvbtCCtGr2R/ECBsF87DdgFOu1VYDKar6hk4
         6egw==
X-Forwarded-Encrypted: i=1; AFNElJ/LF6GCfUfezuFlQoA5qFGkAdUxbt7KeuXKLnjbfvYOU5mCXFypxrGy6caP93na+KNQZenk4g==@lists.infradead.org
X-Gm-Message-State: AOJu0Yykqc8D6yP748nKb0srAjlmH58eFEL/enxxzPd99MkmA6xjlOA5
	O96lzeYmZFrT1Ttay71cdzJ8sOtz3M5PwlB8byBOwxal5MfRuLc8igza3zEA45Gpng==
X-Gm-Gg: AeBDieudBZ9hZzUyfjWGsl3vhK5ZT7m52kkJ6J0rhS3yz7lysSjdDX5agt8YPryvPHq
	BJCmAo3xei6QIRlD9ZiwRWoL2qykG4rVionqA20mk8MzsvwoftXmLH1kFGzVuUhSoSlUsJ316hi
	JRr2J3+c/FaeCQd6CJr6j7P+93BnFQL+Hx/AlMNvKMUO7TnAyE8bi/jYJr/MvPalgyFJoJNdTZJ
	LIjTCPrrpfH2IDUqKTpdkAKkoBvZS5fEKuDd+D7Q1pnimSrfLLJyntXqWP7t5hl8KBj7GX27fQF
	M7/zqjXSLjq56ce4ratIdK0TtektLAsF83fyOyhFFuh/0oyyRvfd/+gYZlOhXG7QGTi4ay0kOfi
	53RvvDQGlS5mmIrxlT4khhzDOc8paBgkH0LmFu+Ad+uvDi5Y1HzUZFShwL0qweRA65N1t2ZbO40
	AX0SCyWeXZWUUrRFO850skUVpKh2ohG01TaAuIlEWSejy7VaZlJzqlHftRSIEE4x0LQxBjgvU3x
	lgLT9nRpUIzB5KdTr8/SA==
X-Received: by 2002:a17:903:46c5:b0:2b7:b03d:9dce with SMTP id d9443c01a7336-2ba4f9cf2d3mr1830885ad.18.1777941003113;
        Mon, 04 May 2026 17:30:03 -0700 (PDT)
Received: from google.com (195.236.83.34.bc.googleusercontent.com. [34.83.236.195])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae110acsm107750285ad.42.2026.05.04.17.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 17:30:02 -0700 (PDT)
Date: Tue, 5 May 2026 00:29:58 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>, 
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, 
	Alexander Graf <graf@amazon.com>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev, kexec@lists.infradead.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>
Subject: Re: [RFC PATCH 0/4] dma-mapping: Add preservation of direct
 allocations
Message-ID: <afk5m8xwYqNstzPw@google.com>
References: <20260505002320.2210067-1-skhawaja@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260505002320.2210067-1-skhawaja@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260504_173005_695299_8FEF8213 
X-CRM114-Status: UNSURE (   8.72  )
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

On Tue, May 05, 2026 at 12:23:16AM +0000, Samiullah Khawaja wrote:
>This is an RFC to discuss the preservation of DMA allocations for
>devices that are using direct allocation mode. Note preservation here
>means preservation of physical memory only using KHO. IOVAs and IOMMU
>mappings are out of scope.
>

Sorry, please ignore this separate cover letter email. It was sent by
mistake and has wrong prerequisite-patch-id.

