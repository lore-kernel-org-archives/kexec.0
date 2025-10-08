Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70618CAC5BB
	for <kexec@archiver.kernel.org>; Wed,  8 Oct 2025 10:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gXfZj39gOdPe4cV9/pLXEx0hRGUl/o9LSz6BtiMyxTo=; b=TsD+u4VJU2JhTff71xNz6761im
	F65o32ZLPQU44y698HZ891/gb5YaOBqO72QZRDkm692TfEZp3aXTXEFpM/23CYthYF3W1n2vI5Tu+
	cL80I4hqBaweSlM0OFEUeIH7t5IySwCMS4H7eofcVXhWb2Z40RBcDpB+ZPYPR02FrXtupmr19b3+o
	QwSXhKveHYWoAh/+tjnRU6n5I2QXhB3T8OlqCT0qTLmG6kQ+dyDOEzivr0fAxhyT7kHVW6cPrlQh7
	N8JUFljmwbhCCgXkzhV/g1cN8REeizTgTb/B2J3TXPFi4bfgqb94+GFwcFBYFB1E9wwzgcCUaeQ0j
	wCXoBbMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6Rch-00000003ewb-0Azz;
	Wed, 08 Oct 2025 10:42:19 +0000
Received: from mail-ed1-f53.google.com ([209.85.208.53])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6Rcc-00000003ewG-1JRK
	for kexec@lists.infradead.org;
	Wed, 08 Oct 2025 10:42:15 +0000
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-639102bba31so12133800a12.2
        for <kexec@lists.infradead.org>; Wed, 08 Oct 2025 03:42:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759920132; x=1760524932;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gXfZj39gOdPe4cV9/pLXEx0hRGUl/o9LSz6BtiMyxTo=;
        b=VypXrhMOIwN0WF20pcg4pnMTE+7THF6NZ7/RdNfIHqoG+PD4elP4WLcJ7Y9+HH/BF7
         HSzNE2WzQKvYJuaUKIQ+mCcvwXszlSKdbA3fNk37yig+aBRUCOcS49Zu4dW70bixtV5X
         Yn2t3/PLN5q6ATlqhg6sxKZItZ/Uv2HHE+c6sGkq3vcGHdOUnqmL7T0Y/4x95eUc50YK
         WUzEowBrz6dmKT7vhbZbh18S8IdsS+N5oicmzLEYCeDSmPJmrlQ/cgmHpdf/ZYjcDlOH
         Ynbp6W3Vxc+HxZG5rjFTk7Fi1KwVsIANAxnqeLrCWRDrJU2bDrN7jsBU4cEpd9vW5MhU
         50zg==
X-Forwarded-Encrypted: i=1; AJvYcCW5RcuOq+NBKfKwRaE+P6eQzSYpp5YRcqeJceKPkYCz5pfYBjRDFxK9AM2czo+N/qVBc3L2aw==@lists.infradead.org
X-Gm-Message-State: AOJu0YxkokFaVaIvBoJwIzruqBIkQxNboNxj5FIJ1YdLTRDEin+CgqUq
	AzaqbV3WP+tNCnenUffAsAe+Mmj8FnS9PvJMv4XOptHshL84J5snZGSG
X-Gm-Gg: ASbGncsoxmQWa1hZFbjB1Oy+eZu9ZdS1fcCVzDSFgtrFJTgRh/icEbI2QNAMuZCysRR
	7wMy7zGqGDvzXrvjHbaDwZrhCMRrgWESzRp1lAAn2qJE3UKQF+UR6H/o4fo20G0bljUncxrW04f
	MFaZHNGrsFyII6aCkf8lDLHn8XtGy0G2PXgZorcE11i7n+n0S6BOv9wa1sXfMQ5szncrVjQkm1H
	tm7kIZO8LtUmIZjoWY3kk+UMaV3hA4Co0+T+xxxdFZB04/V32tKmCXjp0u+qHjzxUjATrruAVYe
	3dlAhnTLc6Uye3HodFKleVeOD5hfzLSu4E7tVvPXHmQoYGedL4GscxveaDMdoSsbfvkMLzC04Hc
	Sko/fpOabfenxiMCN0DrZKc0VVJo5s5KN3Z0BEg==
X-Google-Smtp-Source: AGHT+IECD7wKvTZ6+MU6CjYIhyoFNKuj3KFaek4NzDOSYMfoAgnsoXljdX2X/uCFDDf8Ajmh077qIA==
X-Received: by 2002:a05:6402:50d1:b0:634:a32f:abbc with SMTP id 4fb4d7f45d1cf-639d5c53171mr2450513a12.25.1759920131891;
        Wed, 08 Oct 2025 03:42:11 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-639773d4d8esm8697663a12.30.2025.10.08.03.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 03:42:11 -0700 (PDT)
Date: Wed, 8 Oct 2025 03:42:08 -0700
From: Breno Leitao <leitao@debian.org>
To: Baoquan He <bhe@redhat.com>
Cc: David Hildenbrand <dhildenb@redhat.com>, kas@kernel.org, 
	Jiri Bohac <jbohac@suse.cz>, riel@surriel.com, vbabka@suse.cz, nphamcs@gmail.com, 
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, 
	akpm@linux-foundation.org, Philipp Rudo <prudo@redhat.com>, 
	Donald Dutile <ddutile@redhat.com>, Pingfan Liu <piliu@redhat.com>, Tao Liu <ltao@redhat.com>, 
	linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.cz>
Subject: Re: [PATCH v5 0/5] kdump: crashkernel reservation from CMA
Message-ID: <ctrpw2ppozwtsj7544jx45kpexmaackpzzyeyhkqsjrf7cz2tc@7fmuzvy7uwec>
References: <aEqnxxfLZMllMC8I@dwarf.suse.cz>
 <vojlxf5pelxlr6omsfsccd4e4cdzn5qyxpgiqajorkgmgd7ruh@e5wwhkmvntpb>
 <26ae6b04-3beb-47e9-9639-b081003dc9bb@redhat.com>
 <f7x2flir2c5zpkusgiyk7qnrdqo4dek3iksyldw6w22r55s4vy@4b47lrcv3fag>
 <2e35b6dd-56dd-47e6-8dac-54f446f763f0@redhat.com>
 <aOSO/e68pZ7FGKm1@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOSO/e68pZ7FGKm1@MiWiFi-R3L-srv>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251008_034214_358651_C184353D 
X-CRM114-Status: GOOD (  10.64  )
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

On Tue, Oct 07, 2025 at 11:55:36AM +0800, Baoquan He wrote:
> On 10/06/25 at 06:45pm, David Hildenbrand wrote:
>
> Have you encountered a real problem about the dumping, or you are just
> worried about it?

I haven't encountered any issues so far, and I already have a set of
machines running with this configuration.

I'm planning to roll out this feature to a larger group of servers, so
I'm currently performing due diligence.

Thanks!
--breno

