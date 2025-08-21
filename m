Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F675CA0EFA
	for <kexec@archiver.kernel.org>; Thu, 21 Aug 2025 10:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TLTaYQKz+L6mS60IaQHO0FlbZom6v0EylZjn5fadR0E=; b=iRIDSFbVVEmbYNSIGIiJCFcDG6
	HS7nt25c4ADl21KRe6oAMgSl8kG+U1divF6sP7mYmYx93vC6fWkcfGSvIf1EGMRkrgEkulI3Apsr0
	wOyHMRPDbekUB+8VY37xxkGP46XKwsMKXYrbN0Bn7y2XzSQSKo04+7Vd+f3T2hgLBFLxYaLuR7bKv
	cHiwlvhTIATR7jypPdhZnkXEZMp8RkTR6QfZ+ptm1T7KWLcIkO0CfuucIfu8coe8MG78ZQz6vqcRP
	16Ztjdc9lI2paj+GZoBgjuukCQaGJy6/zuXMYK15AAI1UCmf8WmxC5AJ6AAqE80Q2K5p9toY3XiBs
	qtWKyS1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1up2aE-0000000GccN-30V4;
	Thu, 21 Aug 2025 10:31:50 +0000
Received: from mail-ed1-f44.google.com ([209.85.208.44])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1up0lp-0000000GGov-2SLp
	for kexec@lists.infradead.org;
	Thu, 21 Aug 2025 08:35:42 +0000
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6188b70abdfso923384a12.2
        for <kexec@lists.infradead.org>; Thu, 21 Aug 2025 01:35:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755765340; x=1756370140;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TLTaYQKz+L6mS60IaQHO0FlbZom6v0EylZjn5fadR0E=;
        b=Pz1V+2ZWGc2988fDAkvuIpdWtlGbVebPKH0Y96Pq+CojwQLC8UFbOiRxnrzDsa1k8e
         c7gpVgsqdVaqfnWkxjCiO+Q7FXyb6hv0vJWz+YBJfInjf3tbpKqyCqCFeMjVHgvmCo5F
         QynN4Vax0QrfoocGvFZswGIZOIT9ofzLA66eXfx9mmW0kLUkfeAf8ZYplfk/7V073aUZ
         k/sX21U0UH9VEXpKgmRsE9zGaTGUkKGi4ibk1aOvqX0acvCJxBOXSqmI21VsKvA1Wxir
         X8JyU2zjydgZJaVkVDrFHnMksOBZtin5DMuvlgxhJoh9V7xyVrZPAEcWET8wuSNPyfQY
         Znmw==
X-Forwarded-Encrypted: i=1; AJvYcCXwDGHa9kuPtiymSBau1V3cg5AodmONOSnFGeXUSxrfT/gBSo2rrkkWM7TLdznp/j2ReB2D1A==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx0QsIpLFdjliyW1t3KY/0qBgvALV15UC9Si0OrhWre02UKU8NH
	xCmLhHakc3YHfLDOSZEWUF8PUTiLKMS+Yse5WiMX81pyr4Iuk8U7CR+hevKG3rX8
X-Gm-Gg: ASbGncst3LTZ+fWEhs3/OjCjSmmT/Yfr/KdyqZyeqqs+yoEDApbz3C2Bl0i8xKu4enn
	bvU6CqHYe0s8jwmiQETudRgHcCRJs/0IpGNMzIc6SfKmto+nIDWfwukpT+mjdrEBG2xjChtnA+s
	evPNy5FE2tEBfWH4kiple70C/Jatp7s5slNiAOZGeCDtQIujpYzFsYLe/RCeUN0gXKM7zqVH9Op
	j3+BLJselTGXtQNCwTJNeJWAU0U+d0Q/lqok4+BfF1sAUuVqNrCcpd5vWcp+hYkitawdsFq88Ka
	fY9kDjMWsoLDfoPiRC1330WUG4wml+b299zdePvfI+c13GDhzzqjmc4vMLfn3On8tRKUeoXAJmA
	C302k1g4lZ7WndlphDMQeucM=
X-Google-Smtp-Source: AGHT+IEkJdR4ZytuF3ou0QnN9dqwsgDB4fi3WpC1cU6D2DxADi2r+x6LKDLki93uSdw4v8TOHeihdg==
X-Received: by 2002:a05:6402:354a:b0:618:20c1:7e43 with SMTP id 4fb4d7f45d1cf-61bf8736398mr1310328a12.29.1755765339676;
        Thu, 21 Aug 2025 01:35:39 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:8::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61bfb41b760sm727145a12.16.2025.08.21.01.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 01:35:38 -0700 (PDT)
Date: Thu, 21 Aug 2025 01:35:35 -0700
From: Breno Leitao <leitao@debian.org>
To: Jiri Bohac <jbohac@suse.cz>
Cc: Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, 
	Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, akpm@linux-foundation.org, 
	Philipp Rudo <prudo@redhat.com>, Donald Dutile <ddutile@redhat.com>, 
	Pingfan Liu <piliu@redhat.com>, Tao Liu <ltao@redhat.com>, linux-kernel@vger.kernel.org, 
	David Hildenbrand <dhildenb@redhat.com>, Michal Hocko <mhocko@suse.cz>
Subject: Re: [PATCH v5 0/5] kdump: crashkernel reservation from CMA
Message-ID: <lofhq3bgtl2bcbrbkgctyyg2gl7ef2naqdrplyb37jyde2xoeh@twcwhwthnzxd>
References: <aEqnxxfLZMllMC8I@dwarf.suse.cz>
 <airxp44zdyxskfwrhhveis7gd2vsz5m4f3ipidsghi2x55h64c@s37v5rkuoega>
 <aKX1vbE5jWVUr298@dwarf.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aKX1vbE5jWVUr298@dwarf.suse.cz>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250821_013541_631512_0852521E 
X-CRM114-Status: GOOD (  16.11  )
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

On Wed, Aug 20, 2025 at 06:20:13PM +0200, Jiri Bohac wrote:
> On Wed, Aug 20, 2025 at 08:46:54AM -0700, Breno Leitao wrote:
> > First, thank you for making this change; it’s very helpful.
> > I haven’t come across anything regarding arm64 support. Is this on
> > anyone’s to-do list?
> 
> Yes, I plan to implement this at least for ppc64, arm64 and s390x,
> hopefully in time for 6.18.

Thanks!

I have another question. I assume it’s not possible to allocate only the
CMA crashkernel area for the kdump kernel, since we need to keep the
loaded kernel in the crashkernel area while the system is running.
Therefore, specifying crashkernel=X (without ',cma') is necessary.

At the same time, since the crashdump environment will use CMA, the
crashkernel area itself doesn’t need to be very large, as the CMA space
will be allocated later.

With that in mind, how do I find what is the recommended size for the
crashkernel area, assuming the CMA area will be more than sufficient at
runtime?

Does it need ot be much higher than the size of kdump kernel and initrd?

Thanks
--breno

