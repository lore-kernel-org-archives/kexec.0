Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D26DCD4F50
	for <kexec@archiver.kernel.org>; Sun, 17 May 2026 18:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yO9O8pu4RjDyHVPuvzyCd3iEZISD+KMOY00JM/YV72g=; b=kD26+0g/ysU/1K0ZeiH5Umc75a
	eTewdaS/14akN7RmVtHwTLfG9m5QBgoZl9QCXpd3fSiI50a9JeR495Ssfy8l8cRjydvag0/J1WYrI
	jEqWw0t2n6qOkFwsZBG3Ovgy8ZtmpCtu5lEzgUSCIKtxhNHzL32tbSr+SVTTY6dVhqCgbbNu2isvJ
	x1wysZdRRWb3t36TgeW9G/X22ch9IredT5p6jBdr0lb4C40jlzjJYr+tzN2bSUf+i6fJlWG597QIw
	WJgTsfjeySsJ7++nUzwONnUVmAXkGGmoE/KxkkzEGjTQ7wb/oakhKeoJcpodoEP9u8SFgx9Y9kusa
	ryLPmiTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOgQ4-0000000DFXm-2C8Z;
	Sun, 17 May 2026 18:40:56 +0000
Received: from mail-qv1-xf2d.google.com ([2607:f8b0:4864:20::f2d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOgQ2-0000000DFX4-26jH
	for kexec@lists.infradead.org;
	Sun, 17 May 2026 18:40:55 +0000
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-8bb09239328so15457666d6.3
        for <kexec@lists.infradead.org>; Sun, 17 May 2026 11:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1779043253; x=1779648053; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yO9O8pu4RjDyHVPuvzyCd3iEZISD+KMOY00JM/YV72g=;
        b=jIKdrxf5t15mTCCYAXnxHn59FW4JhSe9Ty5c1P/TROSMDEvWvO1LyHFzDtZiihRbnG
         PzRdStKf4DqQCJ9CnwFiabzclco/rUL5s2B6OYi+oNF+ikdIzTHa+UfRYUehoc/T4KeM
         gTHuCJGSRkrcS+5AwvTvvD/s9vszVOPNL+x5EIccQ4h7CWMr9pkg+bU0XjAAYibRwWoL
         7EVyu9lPKRdfK85I1gWeUYgdEYIlUKRB0CIMu9UgfyDeWtSZlAjSE2M1rnTgOwL+gsUh
         UZiIokWhKbAfZtkdDjuRQVU5NBGs/tyD4tdGWwF31HYgjp2EbPdsWHxtemHfZQyTBVg/
         kcOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779043253; x=1779648053;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yO9O8pu4RjDyHVPuvzyCd3iEZISD+KMOY00JM/YV72g=;
        b=JqjqmFg0LdUbH2vFjXrw/gOaRcfGWC9+wIb3jLTeotcCYXK2XLIliSRaZUz9E4PlxN
         QJDoWJspTsPAuqDg9JNnz/MwcN9dHzin0Hs7+HynYmSLjyhy7MzdkGHWqRupr1uls33k
         Y5dm474iWPXAnFzQ2bhDKYdo8BHVzf2zPj0aBHaCrBxlz0PIoY6UPNEtFLiIRhC8yEKX
         z796xeFcHWFCVQuNgvZpIowQUafsFOMb+gUVS5uJQvbBvSsGX05DYuqhUV5XCuhucCS9
         0/Q8fIiA4fY8guqu/JZNClQt/aASpalIULVkjFkFq/clOsZklMusg5DstRB72VhcrS+C
         Iwuw==
X-Forwarded-Encrypted: i=1; AFNElJ/L035Iag0/0dQmvXuOAvmVHbmdnW/96O4vrqe08XsRE6WvBiX6Jd03WvMpi4D7fpRbIHkBOw==@lists.infradead.org
X-Gm-Message-State: AOJu0YwL6m2wIpul2PbUmYK9SM+emJhWOi/etMz1D2NKqT1qxyFb9MKo
	eVUryCYMQXsemj0BLaHZQYX346J6bMqcGsxCqRkGLAHWjIc4DDQdjr9JbotatSXLYnnmimQi7Zp
	JHNXfM34=
X-Gm-Gg: Acq92OHo2ciQ+oUDy7ojC64ZnBCPH2UsriRhAbDBRXh7KiiM0eyNoC//pGVF0u3M7hm
	dvBjPl/OR3ZYWvlbf4iE9mBln+Jj0I1qeRcWRgUVWCPwc6P6innH+SoXrXelioWxO4+7YR8T9+n
	15MDLcPeequsz3YjhTuJrPS8tpNq6cGzOaxo3bY6rI9pCmp3v1DHvLrIYfgZXRnceBv6RHZoml8
	nEtEY1z/IZBk5sIYTuh8yCJDR7awOn+MCfhbYrQadPZROApbkEr1isk8ATghxHXvb7nmZ7hurk9
	XLX/v1no3tP+34r7J90nu+rpUczxoJ7CsQ0AmjItbBL/csnOvwKoQ+nF5VFIpLPZ0K4GpSu0PNC
	pvuOzNWAhtO+AVXcOrR3EeTTocmfO+wljbNCEwpdR13c+D1eb143jogO+kzheHR9f1/IQE8rHMc
	SqLTYUqp5n2axympqLlXVqdn2ord0Tk+5hq12o1UB1y5h/9FAD0H4=
X-Received: by 2002:a05:6214:23cc:b0:89a:f0b:60e9 with SMTP id 6a1803df08f44-8ca1ecce8bbmr127423436d6.13.1779043253347;
        Sun, 17 May 2026 11:40:53 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ca3619c7d9sm29192256d6.36.2026.05.17.11.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 11:40:52 -0700 (PDT)
Date: Sun, 17 May 2026 18:40:50 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, 
	linux-kselftest@vger.kernel.org, shuah@kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org, 
	skhan@linuxfoundation.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	corbet@lwn.net, dmatlack@google.com, kexec@lists.infradead.org, 
	pratyush@kernel.org, skhawaja@google.com, graf@amazon.com
Subject: Re: [PATCH v2 04/10] liveupdate: add support for linked-block
 serialization
Message-ID: <agoK7TRpT1LErW8H@plex>
References: <20260514222628.931312-1-pasha.tatashin@soleen.com>
 <20260514222628.931312-5-pasha.tatashin@soleen.com>
 <agn6QeIamoeMkesv@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agn6QeIamoeMkesv@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260517_114054_552018_E5B6B1F8 
X-CRM114-Status: GOOD (  17.78  )
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

On 05-17 20:26, Mike Rapoport wrote:
> On Thu, May 14, 2026 at 10:26:22PM +0000, Pasha Tatashin wrote:
> > Introduce a linked-block serialization mechanism for LUO state.
> > 
> > Previously, LUO used contiguous memory blocks for serializing sessions
> > and files, which imposed limits on the total number of items that could
> > be preserved across a live update.
> > 
> > This commit adds the infrastructure for a more flexible, block-based
> > approach where serialized data is stored in a chain of linked blocks.
> > This is a preparatory step to allow an unlimited number of
> > luo_sessions and luo_files to be preserved.
> 
> Shouldn't it be a part of KHO?

It can be. However, at the moment, it is only used by LUO, so I kept it 
there. Sami is also planning to use it for IOMMU; if so, he will adopt 
the interface for his usage as well, and move it to a separate KHO 
library.

>  
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > ---
> >  Documentation/core-api/liveupdate.rst |   8 +
> >  include/linux/kho/abi/luo.h           |  22 ++
> >  kernel/liveupdate/Makefile            |   1 +
> >  kernel/liveupdate/luo_block.c         | 388 ++++++++++++++++++++++++++
> >  kernel/liveupdate/luo_internal.h      |  57 ++++
> >  5 files changed, 476 insertions(+)
> >  create mode 100644 kernel/liveupdate/luo_block.c
> 
> -- 
> Sincerely yours,
> Mike.

