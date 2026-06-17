Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B61ACD98E2
	for <kexec@archiver.kernel.org>; Wed, 17 Jun 2026 19:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j+uzwrFGJAcNQVQMCnTHy2evwlubyHfh6u8CWpZkX/U=; b=ont1T8AxA+JOsurfd9yZHedtFI
	DTtLFv/vCilDmFmUnOvXUWOE4AqAXPxHqfV9nqjEEheTrrH4fdfjl+2xAxNZZQ5humE8AUn761ruX
	3OyJ9bwTdzYcOmnMM1TSnW8asQA/3VqKxfmDJNvgMjaMj/7E8lAKI5GVm8UYIKb0eBRwEOLP5ko5H
	NYRihB12yS2cqooL4SD+lMWCg4MJWAfVqwCgUvVzVrI12OCg6mxPRbVGzi3e5f6ZEA6PH0u5ndvj9
	8h9DsoVozXbEu/rmLwvD7iy3i0IiQadrzJS+FKHa+43cBOjgYPUCTY766yJzyqQQcwRC1fSP3Eh6s
	PDdlpMbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZvco-00000000ErJ-3fSQ;
	Wed, 17 Jun 2026 19:08:34 +0000
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZvcm-00000000Eql-3YJr
	for kexec@lists.infradead.org;
	Wed, 17 Jun 2026 19:08:33 +0000
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-2c6b7bd4e8dso8875ad.0
        for <kexec@lists.infradead.org>; Wed, 17 Jun 2026 12:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781723311; x=1782328111; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=j+uzwrFGJAcNQVQMCnTHy2evwlubyHfh6u8CWpZkX/U=;
        b=P+lsX+oIOrp3/VULnomgJ8Bh7gqC/AE6vDfPzT5XazJarFzo0j6Hv3ALKoD7o5QscU
         T1DJOiOtLAMGuAi5Ncq5ezfWtCoQLj4PadeFhubN2Tq76p/adubtxUQAoc0aohPCI5Ir
         oYFPORW1kh3vncxX/vhXepJxEVKE0UWGPI7ccaTkJCNn52lFb1RR2SpGkS0GgfFdGuFu
         5GCpX9nLvdhPKnOGhGtvpa0Vv51lLudhgFWL48CGRVDFYDH8X4xUYNxCZpMUJeY4H1J2
         4+kDMfDB9k2StwaMNA1QG59djBO/cmqPnRLQJXJ+zYA+6MT3niZCR4YMc/cRypGRXc+i
         nAAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781723311; x=1782328111;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j+uzwrFGJAcNQVQMCnTHy2evwlubyHfh6u8CWpZkX/U=;
        b=TA4hxTvM+VCnf/qthmRTR7Y07+pB933dUMavYAQS+g/xrPTHowowA/9Nrq4605FOaE
         3PLDX3TluuhExWE3YGaTofZlnZWM5Ce81MqXsxUkW5JoqZ+DP8WjADdDw5EwUgHlKLp5
         lXxlIyUjRKpsuddL6WRE07+Jd/g3RIkFNHBp4BVIUa+2P11Es+YzVVF3HdeIxS3wkg2C
         yBhNdnpLabBgN6HB6JWdsuXNMm//yMViwYEo9LFg1eQfzJHibSwznXVNGR8IUggD1mz1
         OKSm2gL1Pwa5fmk3vGUISKcackCh9JSeFGuJA7YY0/BwMPCWQMIIF+OXwjBzrZzZJEU1
         u+Fg==
X-Forwarded-Encrypted: i=1; AFNElJ+6JbBlT19m/U1vjQrAatzXWH+kc56sKVwT9SHpb97JvW4agpacAxc0vys5AW6wa20GYSkXwA==@lists.infradead.org
X-Gm-Message-State: AOJu0YwOUb4WlG47DrM5nnXEWoZFkQDjlz2dc0IpoS4qJWZImJnK8wzo
	utklQorQoVrBHaExe/rKIVYeyldxH+RTx780x/16nKDMnySMCNxZdPGH4/RyMgy0oQ==
X-Gm-Gg: AfdE7clxHZ02aq8IkJFJWVsWU2Dd+fqZ0P8VJH1iokaJbj19v76/unhA34fB5VDimG5
	+h/kuMe57W1WqhJ/mke5YSJ9cQqRkEC+e+Qt18zaXAtzXzJA1Yqdlottziv2qmplNOgiMAtMhf9
	9ccZplDQJLGOnjKX9M3YB3hIe7vExu0H4yC5/JpLQ9vbHWN8ckJ2i3ZYgFQ7f6o8SgU8jRI0bGx
	KsZXYZ33GZdfbzXBKZqOCrBl69oeGcm3AJ73YuTJW9KdIActxuvDKFsx59hdBGGtbm2cSNiyT8L
	bnktXeK+LDVy0Ur3tpcOrO7PsyP8pMUAudeaseBdaroF7VqJA+7RrQHb1JbeHW3i1JZG09pcL2G
	s4ytcGKuSx0GcTNiH5q8KXKpT7m6eRfCrKaXQZhIHrM6E9OG4iO+VQuIRT7bX4mHx0GWYORUsEN
	T4JLWd/bvoN77GkQfAmQi9v1lSkDgKiPvEFOAYdchfVAnnrOM=
X-Received: by 2002:a17:903:350c:b0:2bd:6dad:3dfb with SMTP id d9443c01a7336-2c6e2435553mr295865ad.25.1781723310281;
        Wed, 17 Jun 2026 12:08:30 -0700 (PDT)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c866325d156sm15559385a12.13.2026.06.17.12.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 12:08:29 -0700 (PDT)
Date: Wed, 17 Jun 2026 12:08:25 -0700
From: Vipin Sharma <vipinsh@google.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: pasha.tatashin@soleen.com, pratyush@kernel.org, tarunsahu@google.com, 
	skhawaja@google.com, shuah@kernel.org, dmatlack@google.com, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 0/2] Make liveupdate selftests library
Message-ID: <20260617190754.GC2704872.vipinsh@google.com>
References: <20260612214512.464146-1-vipinsh@google.com>
 <ajLtfkuMP4DEGlqe@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajLtfkuMP4DEGlqe@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260617_120832_886363_3D6B9270 
X-CRM114-Status: GOOD (  16.79  )
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

On Wed, Jun 17, 2026 at 09:54:54PM +0300, Mike Rapoport wrote:
> Hi Vipin,
> 
> On Fri, Jun 12, 2026 at 02:45:10PM -0700, Vipin Sharma wrote:
> > Hello,
> > 
> > This is v3 series of refactoring liveupdate selftests as a library. It
> > exposes common liveupdate ioctls as a library which can be used by other
> > selftests like VFIO and IOMMU.
> 
> Let's revisit this after -rc1 is out.
> I don't think there would a need to change anything, it's just the matter
> of applying the patches to the right base :)

Sounds good, thank you!
>  
> > Currently, there are no users of this change but it is being used in
> > VFIO and iommu liveupdate series.
> 
> -- 
> Sincerely yours,
> Mike.

