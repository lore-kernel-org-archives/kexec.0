Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 815C4CA0EE4
	for <kexec@archiver.kernel.org>; Wed, 20 Aug 2025 19:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5+uYWrcMCXTgY9LDw0CpEJNd4/G4LXFK4CU2Fhr0lbU=; b=F61JQlTleisI47wzS/tCNzoKdW
	Zx0nO8AUy2+Kp4omlnA8Os+5+zieKF/MRsooi4//YpMLfU2iudA3gGj3gSycqZGFKUtTNFWPRWDzl
	q0lyJUb4vjRS69zpSEhhcnbB/r2wrK7on8/oMDTHf0/AKH33tUzd7OPCAg2SkMzipsmrogI4kBxM7
	9+465Ig7HoMLKtoxw94o2uLXudaGaulUH/uJdqdHJ1v+7hNXdonR2z+INHS9LdsxlDiys8kDbZ2ix
	Zjit56UkiYkd1RgjnLZ0yTV1DxKMpr5LDfflGtzdnifMVL4WjDR371PATUozjtGV5cTOBR/cgHHnd
	LUE0wQjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoo32-0000000Ejcf-2KE3;
	Wed, 20 Aug 2025 19:00:36 +0000
Received: from mail-ej1-f41.google.com ([209.85.218.41])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uol1e-0000000EIZd-2IR8
	for kexec@lists.infradead.org;
	Wed, 20 Aug 2025 15:46:59 +0000
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-afcb78ead12so2085166b.1
        for <kexec@lists.infradead.org>; Wed, 20 Aug 2025 08:46:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755704817; x=1756309617;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5+uYWrcMCXTgY9LDw0CpEJNd4/G4LXFK4CU2Fhr0lbU=;
        b=gcI2ghgAamCbCqIHmDDCGFqWArLl40EIHGt8C4C8ckUn5SLRhFO/Y/u6qDdNH2FbfW
         dH1AiJcscZ/yA229asGw5PgFghUVfNtYk0edFLWNoFeeHLrxAP54BzEUxRduw9QSLJll
         tLb7gdnPhGLt27wHFAMYAbkh66yRJ7TI+r/9ZJG4bTmiB/B08OnprkN+tGJIZ1Ho0bP3
         PzsokKZv9rYvvbFSXZswbk87Ra2/wW5LOIvFJme1HWnKWTEbJJzNuPwtrnBiv/ArxYK2
         8ipG9JuxBmvmkPuUyc+KLp4d96YBzvgSD4UuFJzDvnQxBNsKmwXKtgSdzPohMxIEKuWA
         amSA==
X-Forwarded-Encrypted: i=1; AJvYcCXzK8Udx73Q9d3fne4Yes1BHjpAj3FhNoi5toJgx6RWtikoxos6ryzcbMgZkxmSNx/Xwr3UHA==@lists.infradead.org
X-Gm-Message-State: AOJu0YzFdGbEe4/fCxaXYeM9ik0LtZUXIMTewtN0WBbPDH6pizxCJeG1
	mYLAAGncWD2bE/GEw/8gQGI1PXHt37l8hqnhWrFY+1ZWWgALtw9sg+8P
X-Gm-Gg: ASbGncuw9sKiITlNm8sxz8rXRIVkjul4eIUVEfyYDTmyM1alNXYUBj1lf1MCsEitSjN
	mVT3bIA1eHie19fv2jry1OwnUP+gHCqd0LY56dfGUnxewTE5vvVh5b21luCkROK9cSKogrpI2dN
	DCa6Y7KuWmRdFqae3nHWFTMsj62LpcZ2bW/09rRvL/AE7loe8SantP7jU2iMc4tUH3M/mGCHBdQ
	qr6l4/5LHg6bEDuFRZnjjS22JmCYE6L1EAaV885wVz+/NHbxK6eYZHke5H2FFdScDdDYJT64i/f
	7LL51RPH6Y2yUUtZHS6hCNa1uY0xRiB5S7aaX9VeojFsVaCaZ0IXxcYZePjacDI7rU0nBZdoHpG
	/O2/Yj5vBLMwxs0fHn9+kV/U=
X-Google-Smtp-Source: AGHT+IGqDePInE+FdHH3PXlDYhmz7QfHMPnmOwbFEVlI4JdpGkqM0RyEB5qSwINorbSbzPMyVphfqA==
X-Received: by 2002:a17:907:6e89:b0:afa:1453:6630 with SMTP id a640c23a62f3a-afdf01a7a53mr314562666b.32.1755704816703;
        Wed, 20 Aug 2025 08:46:56 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:1::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afded2bad79sm199429866b.9.2025.08.20.08.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 08:46:56 -0700 (PDT)
Date: Wed, 20 Aug 2025 08:46:54 -0700
From: Breno Leitao <leitao@debian.org>
To: Jiri Bohac <jbohac@suse.cz>
Cc: Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, 
	Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, akpm@linux-foundation.org, 
	Philipp Rudo <prudo@redhat.com>, Donald Dutile <ddutile@redhat.com>, 
	Pingfan Liu <piliu@redhat.com>, Tao Liu <ltao@redhat.com>, linux-kernel@vger.kernel.org, 
	David Hildenbrand <dhildenb@redhat.com>, Michal Hocko <mhocko@suse.cz>
Subject: Re: [PATCH v5 0/5] kdump: crashkernel reservation from CMA
Message-ID: <airxp44zdyxskfwrhhveis7gd2vsz5m4f3ipidsghi2x55h64c@s37v5rkuoega>
References: <aEqnxxfLZMllMC8I@dwarf.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aEqnxxfLZMllMC8I@dwarf.suse.cz>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250820_084658_581763_DEAEA941 
X-CRM114-Status: GOOD (  10.15  )
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

Hello Jiri,

On Thu, Jun 12, 2025 at 12:11:19PM +0200, Jiri Bohac wrote:
> The fifth patch enables the functionality for x86 as a proof of
> concept. There are just three things every arch needs to do:
> - call reserve_crashkernel_cma()
> - include the CMA-reserved ranges in the physical memory map
> - exclude the CMA-reserved ranges from the memory available
>   through /proc/vmcore by excluding them from the vmcoreinfo
>   PT_LOAD ranges.

First, thank you for making this change; it’s very helpful.
I haven’t come across anything regarding arm64 support. Is this on
anyone’s to-do list?

--breno

