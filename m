Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A839C3ABB2
	for <kexec@archiver.kernel.org>; Fri, 30 May 2025 08:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+KfoeGtydTUpyMLEw3lr9UQ8n4o3PGMI0cTKplyap2g=; b=KckwYG8fn2rFngl0Mv3oIn4I6y
	nucZ/8g5T/rNnWqDn8dKn7sfBwFe7haFWrye5CZa3DlDm6BVJIAv/iAXm/gESrXAxoZqd2tltYht0
	WoxxfE8B/wXyktvRpVM4Vtg7NxDZZcCDm9XFpHqgJTJ7cqPZWkabBc9yBc+LCUFhsv3tFlwKv4Veg
	AYz8hZ4RIrAJdgFdEj/yurULUUxRoCGOhJIBg/dGwzC5enbbIWNXtMvi1EH8a5MCJICAXULxKoCBN
	nO1cDJZWstmtd7N6HKy3e8WoO8vtuccYceNBLN7dW/mRBE0o7beJY/XuNlayZD7tP+yxZp4TrGMWM
	WOURUCwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKvBM-000000000ph-3VkN;
	Fri, 30 May 2025 08:33:40 +0000
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKv63-000000000Hh-0Irm
	for kexec@lists.infradead.org;
	Fri, 30 May 2025 08:28:12 +0000
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-442eb5d143eso16680365e9.0
        for <kexec@lists.infradead.org>; Fri, 30 May 2025 01:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1748593689; x=1749198489; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+KfoeGtydTUpyMLEw3lr9UQ8n4o3PGMI0cTKplyap2g=;
        b=UezWMgA6FkKJb+tyFWh7zNyNSJ21whyk9VkgHCEewbGQ6MmACwHZhjVA1QOW8cB7vF
         SFwB0gVazQRKaLOrWOweqXczJVT5TCgD80FR/CwT+7gdrZmxvduJhyq7IP3DqzFCXzfQ
         DfUnF/izZ8IdXTHtQxe5bA5yuiA6npFeBnn+VjX4EXDm6Ub0LeNdAFq9MWaY3vccj2uT
         RORZQIHZoe+VxcIX/oy+Wkj+AlIAlaqzQn41cIT3e99B82oYQtxtb3O9R91mikT2i/41
         LMKsDMnrB/brRP/T3uxJHhD1vGhGZvhFnHv/0rmPhtWoZb8Aazl1KlxyFEGVPzTz9MR6
         E27A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748593689; x=1749198489;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+KfoeGtydTUpyMLEw3lr9UQ8n4o3PGMI0cTKplyap2g=;
        b=kygOB7CG2zPFGjCDQTIxLDGwx3B/H5Xg8vYfrOubldaacMdFm7phGBbpq5hKitOdSP
         u6kUj8bK8E24qjC9qYkbTV9J2bAwfEB8X7D7YnXEN8GnKolPAGy0hqKk0IFt2Ib6/b/s
         6HUAsbsE6Tcc03ryYxCzuOrvvch8pZq90TBNphlYwjOoMBwgodOYfFbBK7d560WChEvH
         H4jj13ds+fk7jY7YHxVQ0sT1/69V/iOoLSJ5rp7rIefdt+EwaHFYe1gaDqq8sWr3JAFA
         gDXEaEJyyG9yBZ2AhG6Wa04mwyONYy1DJnSAQ68uL8fo1xcT5f9G8Jhg+5rnjGRJ+kmN
         qNEw==
X-Forwarded-Encrypted: i=1; AJvYcCXlelQ86TAWmc0l30PDsxG7Sb5r9tovVHR9U97jouIvM+gIpB9MnqgutOyd3wgJ88uFO/A3Qw==@lists.infradead.org
X-Gm-Message-State: AOJu0YzLF76gDYy7zoYb+pziYxxdNYH4/l1/ImlYeY9jR7d4Xi3Gh4VO
	ccy0frIBXL6+nCHFI0MzrwkBVa/9t95Uy6tkGV0tCOfeDU2XrogjRBMFjkAq8pD/gtI=
X-Gm-Gg: ASbGncuWIsbLSyhg8xzRR31B7iAfIuB/b7dyNtmyjoo5z0+hhXtyfV4l4ODbZNC8CE6
	mPZQGFaRjgNQmeVLBzZnSa9EPnoe/pd+cZ0Ppvz7K01u/AzTCrpx+4OYdzaXu+COWAk7CHs4MI9
	5Bsjg6HH8R5D3u3m4x7nwez0dJIXVaCv8/DNJxCUzgbSmsPrgY5d5DFEfTqxZmC2e33YH/x0A32
	FRDtqKWxr4LPIfxvxa6qPkPFbrklywYRBayCrzLCmMHn+D9GymscqPZ0TKvbK53RJ8+IBgkjcq7
	ek96eJ7yqnBde7Nohg/yjKzZT5L3UCyIneEgPtQGAJhePVShmqwAh8pvTkMdvkbbp5B5NZdwUIQ
	=
X-Google-Smtp-Source: AGHT+IH/hoDLzGQW3Ae82uMnYvImx0K/Ml7TX7h0dog4n2USqtNGdiSnfxDJz88krhbw1SEsk2vu0A==
X-Received: by 2002:a05:6000:1a8f:b0:3a4:ee3f:e9a6 with SMTP id ffacd0b85a97d-3a4f7ab1641mr1698397f8f.54.1748593688757;
        Fri, 30 May 2025 01:28:08 -0700 (PDT)
Received: from localhost (109-81-89-112.rct.o2.cz. [109.81.89.112])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a4efe6d0dbsm4093471f8f.40.2025.05.30.01.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 01:28:08 -0700 (PDT)
Date: Fri, 30 May 2025 10:28:07 +0200
From: Michal Hocko <mhocko@suse.com>
To: David Hildenbrand <david@redhat.com>
Cc: Baoquan He <bhe@redhat.com>, Donald Dutile <ddutile@redhat.com>,
	Jiri Bohac <jbohac@suse.cz>, Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
	Philipp Rudo <prudo@redhat.com>, Pingfan Liu <piliu@redhat.com>,
	Tao Liu <ltao@redhat.com>, linux-kernel@vger.kernel.org,
	David Hildenbrand <dhildenb@redhat.com>
Subject: Re: [PATCH v2 0/5] kdump: crashkernel reservation from CMA
Message-ID: <aDlsF5tAcUxo4VgT@tiehlicka>
References: <Z7dc9Cd8KX3b_brB@dwarf.suse.cz>
 <04904e86-5b5f-4aa1-a120-428dac119189@redhat.com>
 <427fec88-2a74-471e-aeb6-a108ca8c4336@redhat.com>
 <Z8Z/gnbtiXT9QAZr@MiWiFi-R3L-srv>
 <e9c5c247-85fb-43f1-9aa8-47d62321f37b@redhat.com>
 <aDgQ0lbt1h5v0lgE@tiehlicka>
 <a1a5af90-bc8a-448a-81fa-485624d592f3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1a5af90-bc8a-448a-81fa-485624d592f3@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250530_012811_126442_2ECBD3BF 
X-CRM114-Status: GOOD (  26.75  )
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

On Fri 30-05-25 10:06:52, David Hildenbrand wrote:
> On 29.05.25 09:46, Michal Hocko wrote:
> > On Wed 28-05-25 23:01:04, David Hildenbrand wrote:
> > [...]
> > > I think we just have to be careful to document it properly -- especially the
> > > shortcomings and that this feature might become a problem in the future.
> > > Movable user-space page tables getting placed on CMA memory would probably
> > > not be a problem if we don't care about ... user-space data either way.
> > 
> > I think makedumpfile could refuse to capture a dump if userspace memory
> > is requested to enforce this.
> 
> Yeah, it will be tricky once we support placing other memory on CMA regions.
> E.g., there was the discussion of making some slab allocations movable.
> 
> But probably, in such a configuration, we would later simply refuse to
> active CMA kdump.

Or we can make the kdump CMA region more special and only allow
GFP_HIGHUSER_MOVABLE allocations from that. Anyaway I think we should
deal with this once we get there.
 
> > > The whole "Direct I/O takes max 1s" part is a bit shaky. Maybe it could be
> > > configurable how long to wait? 10s is certainly "safer".
> > 
> > Quite honestly we will never know and rather than making this
> > configurable I would go with reasonably large. Couple of seconds
> > certainly do not matter for the kdump situations but I would go as far
> > as minutes.
> 
> I recall that somebody raised that kdump downtime might be problematic
> (might affect service downtime?).
> 
> So I would just add a kconfig option with a default of 10s.

kconfig option usually doesn't really work for distro kernels. I am
personally not really keen on having a tuning knob because there is a
risk of cargo cult based tuning we have seen in other areas. That might
make it hard to remove the knob later on. Fundamentally we should have 2
situations though. Either we know that the HW is sane and then we
shouldn't really need any sleep or the HW might misbehave and then we
need to wait _some_ time. If our initial guess is incorrect then we can
always increase it and we would learn about that through bug reports.

All that being said I would go with an additional parameter to the
kdump cma setup - e.g. cma_sane_dma that would skip waiting and use 10s
otherwise. That would make the optimized behavior opt in, we do not need
to support all sorts of timeouts and also learn if this is not
sufficient.

Makes sense?
-- 
Michal Hocko
SUSE Labs

