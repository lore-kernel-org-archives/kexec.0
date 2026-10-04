Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50D1BCA5FCE
	for <kexec@archiver.kernel.org>; Sun,  4 Oct 2026 15:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gjPynkeSS8mj+Hdi4I2aqG3Yn3kZVr1yRJIIH48r5Y8=; b=b/MK8uACoRSZABvC1aeM26hXmq
	NLp7KGJvlCca4pYGm8iu4wgJBfaYmDzbOExyuGV+zCuEIqZJWJ7bZvfrCGiaXqQjFEZ+zUOQb1N8j
	5DTVn5kucVQvT9fq+uCvFTOVCCuHVAFjKW22coWIuuzZhE04GGtkUJig56/vWjAa575RtzziH7R6s
	RvyTLt+p6cBJfBFCOEIgbwn1EMgzsQ7MqPySUWNgAsMJwQhDSWS8gYP9d9OvUN5Rbh3OWncUNEYEt
	qZc5nzwOSe+WUiBha1httOX2jb4k2Df9ko6Tb9RU0vI43wlj3d/S6XxGIpwma8uiPNsTkF/EfufCT
	fOEjJpkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xDNpu-0000000EyYn-2Z1N;
	Sun, 04 Oct 2026 15:09:10 +0000
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xDNpq-0000000EyYO-3k22
	for kexec@lists.infradead.org;
	Sun, 04 Oct 2026 15:09:08 +0000
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1DB4A3F1C4
	for <kexec@lists.infradead.org>; Sun,  4 Oct 2026 15:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1791126544;
	bh=gjPynkeSS8mj+Hdi4I2aqG3Yn3kZVr1yRJIIH48r5Y8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=LpoIUQLTpJa75xfXo1Yy4Ab2Q0bqyQRbms1ghZXdeOXBnPr8i1Qu5CRVM+2//H8Zq
	 wIQhbJdr9ZBbDsE+ysoYGzIgE84pQJouWZH1OUtJbBsbtkiZNWv2y4yiQ0VzA8WMc4
	 H8eHMKxeiwwhKuD+fCVFDNqjK3JWxSw3NHB38J4Fsoiko8DnefUjJUEoLd+VGLWl2J
	 GSqIOixwO1L3PwXohEo3UjAMSIFbQ9r3ZjRcx2V9etfNe1i34Q8FwqYDJ2VNOiQpOF
	 pY6v1A0kiPwCd+UWcFcsSpNukpR5FB/WjGHQXfj3ltQHZDpScgtymlb42SyVjq0fxu
	 KB82o/Yz0hFQIEobb0bMiCGjHTcfiUeNfpq61uuSq8LMf33MwzUBhnLFYbFa8RUHYb
	 6B+utuby+DeRxwp2Dh8ZSrSjAc+Fg87feH1fKyIvc3FuVYCYOQC0a4uVpleKI4b1qw
	 wpRxsryILsERTFqxON+9PmVEYcfby+naORmNENZPD8vY9P3+7M3vQ+A6feA6y9BgUJ
	 TpRqMgQjkUX86agA7Cp3rzhYPVatl0fN/wh5LViLllONNFymTOVucjI1ySp26veoZE
	 WOcig20t2D+tOjIVnu364lt6XGTr/4h6TIafRPj9h6ndQzDLlHeME9KlzZPFzOErf3
	 WdqoH0Wqdaan0Y2+ogDR3Iqs=
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a171b68dfeso1304305e9.2
        for <kexec@lists.infradead.org>; Sun, 04 Oct 2026 08:09:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791126543; x=1791731343;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gjPynkeSS8mj+Hdi4I2aqG3Yn3kZVr1yRJIIH48r5Y8=;
        b=duuwM1tJC9aIXDUtbRK/AW4si4yGNm3Q1i722yfCnInATaB0WWEFrYyd0uIz/L2yEI
         PPplCBOwUt+swZYL3eYYkj7VZthDmG3Sc06MrXteC7clVpwkZ5yA1at7dkg3AKKF8vkn
         MgNYKehSqgOSE9G6f1jAtLW6XxNSJybbHX7xId15oBxv1NMsRHWOxkysiurPOa1z2ZJm
         TSNzxWbAQKuuDo0B7vd2nQ+Af/Su+lS63dmoALbKYaWRFh//ypV8r2qiGWD62nweNAy+
         8wqeeRuyMoLTQ7nAm3tHVZxWxewAKuoIqFsofAe+6GMuHO9HXdKBLie01t+jq//zea/Y
         25Kw==
X-Forwarded-Encrypted: i=1; AKwUvBwfTyJ9ZyFFBij5xO8Uuiq3dd0/pdjTjBnBCDKVYQV4ZF7QJf7eKP8XxDci5/qU2GgogAJvzQ==@lists.infradead.org
X-Gm-Message-State: AFuF++lL+WVnAFw0AIzSLfjkG3CxRuQFbxAlYcjbzqh6ppYLAMNmFa4O
	4XusklD+J3LizrdrVEJ9YHEY+nObWXAy3ryp8o+uW8U7lZitJamTns4/f2oyhhlHQ3WNt++fTQA
	BF8qLouuXx+GnomU1Ld2tFMwcyBb8IM7LwBnADeaflWNs0x/CZYbdAUYUdIowe5GJXoqNrHHPrQ
	KzcA==
X-Gm-Gg: AYBFou0ETrBbdyOmprpi1RqungUarz6fnqjWGVM86uv4E1w5AtKQEiPeTepnpkBOYSw
	+X92dCj4bekQjvrrQw0Mf2DQq2HoAscr2PFNHU407F0syqvsFMEum+2DJOAd0AOmWfeNUAXm3Kb
	Tb5Oq0VMxhGxz4Tlb5uycpB2a7Pzjfe1KFWIx4r0K8de5X16HCytecv5Ce/o42wa3gGEgWe2jaO
	boHNV6JZ+728fnu5rS5tBvt0m5QJr+G7Q1s2zEChwpW950i8ehIQY7Y/F6WKZYNkLQodn0ntGwS
	nTjWyr8SazC5GDc+b6hTwf6+ybd7YhzlGrdP2Nxt+MJQPk9CzjAYbA7kXYM64BmqMiKrmRUzhq1
	hwiYDeMk=
X-Received: by 2002:a05:600c:4453:b0:4a0:2423:946 with SMTP id 5b1f17b1804b1-4a1680f109emr87154385e9.15.1791126543675;
        Sun, 04 Oct 2026 08:09:03 -0700 (PDT)
X-Received: by 2002:a05:600c:4453:b0:4a0:2423:946 with SMTP id 5b1f17b1804b1-4a1680f109emr87154015e9.15.1791126543248;
        Sun, 04 Oct 2026 08:09:03 -0700 (PDT)
Received: from px13 ([2a06:5902:822:4600:8c2f:7cc8:bd95:9422])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a027727cecsm272425775e9.9.2026.10.04.08.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 08:09:02 -0700 (PDT)
Date: Sun, 4 Oct 2026 16:09:00 +0100
From: Chris Bainbridge <chris.bainbridge@canonical.com>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Jason Miu <jasonmiu@google.com>, 
	Alexander Graf <graf@amazon.com>, Ran Xiaokai <ran.xiaokai@zte.com.cn>, 
	regressions@lists.linux.dev, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	linux-mm@kvack.org, =?utf-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>
Subject: Re: [BUG] KHO handover hangs when memmap reserves PMEM
Message-ID: <asJc1GIBbCJ26akS@px13>
References: <asE0R_f2r2TL-3Sy@px13>
 <2vxzcxtplh4i.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2vxzcxtplh4i.fsf@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261004_080907_345710_2B550C1B 
X-CRM114-Status: GOOD (  12.65  )
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

On Sun, Oct 04, 2026 at 03:39:25PM +0200, Pratyush Yadav wrote:
> 
> Just to confirm, the first kernel boots without memmap= right?

Yes.

> I think the main problem is that the radix tree pages can be anywhere in
> memory. So on the first kernel, they can land in an area that the second
> kernel's memmap= reserves. So kho_memory_init() might end up using
> memory that memmap= reserved. I'm not sure why exactly the next kernel
> doesn't produce any output, but IIRC memmap= memory is not mapped to the
> direct map, so accessing those pages likely causes a page fault.

That's correct, kho_memory_init() page faults. It happens before the
serial console is available, so there is no output.

