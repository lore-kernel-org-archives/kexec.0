Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7FCDC5B56A
	for <kexec@archiver.kernel.org>; Tue, 11 Aug 2026 16:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yqTXzLSqi2PHpBqXcfI0CNlUPAV+a1jDZqtX7tQ4YaA=; b=RUxMnsQuxuAXzpFuk0v/OtU8in
	tSS/pF0mCOup5eLPzy49S9C+pfNWStOW3fTdtAOlM7O7BCy92ErDm1Ze+iXEkbbBMbHjIVPYuIFD5
	h7+PqMiOHpyX7QcZjJaxhTcYMZle5RDjT0ImBczS8Xzz5zjPkfiIvMj52oGGv829Q98/FndjaYyag
	9qSqBozudAfrfOmxopCMShlFZI/Vk+dNoar0wpOKbK7kkvHYo5BD8hkgnrrASTOvREe+hU2PIpfMb
	X8JrWTchF/zhtJHY8AjaGHxnATEI4cmHIgWLI2b2bOBgoCOSqDzl0/CXpdR1boYw/YZupYWS3qd1R
	Dg/7bz3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtp92-0000000ESpo-3Per;
	Tue, 11 Aug 2026 16:16:04 +0000
Received: from mail-qv1-xf33.google.com ([2607:f8b0:4864:20::f33])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtp8z-0000000ESoj-4C7K
	for kexec@lists.infradead.org;
	Tue, 11 Aug 2026 16:16:03 +0000
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-8ee88fce572so118026d6.1
        for <kexec@lists.infradead.org>; Tue, 11 Aug 2026 09:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786464960; x=1787069760; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yqTXzLSqi2PHpBqXcfI0CNlUPAV+a1jDZqtX7tQ4YaA=;
        b=dl8nSR0B9Grl0dTaxIqMnc++jceuK8PTPSQ5zq/aDFQB3AoWj+oEv7TofetON3NFJ5
         rzNbrrcoghLLI0sYL71MlO3U91Iu/SEAFFd67CrfHJw2ufsKY6v1oBkV/d48VNZfgJXN
         YOT/+2Xjc4eCkZHLR7xjaogS0D6rIYRJxcEapss9/ayzyydvvH+mYNEuqfTXd88JuUtj
         isPm+2xDVDBjXwYbsYdf6XHD0jMEr1g0RweaSpWyWPMomhHt7hE4Rvm2OFu6RGyiYORj
         mXdR9QHEQyGKOo2AuEFDtgrFst+USGSf9ymN9gwYpRjNMwkNf19yW1NiaGuzPiNsvhwE
         3M1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786464960; x=1787069760;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yqTXzLSqi2PHpBqXcfI0CNlUPAV+a1jDZqtX7tQ4YaA=;
        b=gWOjVCoPCEWy/svFQV0ALOidndAf/KxLgmq6FTFTcr/9+NcyBQAk1CcbyBtzXzENy1
         B1LdIpAagCHg+4+D6dNiVgJAsg275CXMvYM9WR2BQGfFCy1IB3wPWC0mUwrQBaDhLeLC
         27U+XzWKYg30rziCq5dPoxy+A4ftvxfTV2eSVoVSQNXL6e32OFnUG+PLmYd/0NBlpdhK
         9lf40UOE9dGKLAsHmBa603eFQw0HkvzAMqq2p3iIMhyBp4aqR+mwSV9HOILGvda/NLsk
         vCK0t7YhVJqd4YSgggPsOsdULi2WW51PH38Dg2Ki3kHQ0G07SCu2DmjJv2Qb12HRLVmO
         CDNg==
X-Forwarded-Encrypted: i=1; AHgh+RoB28aRvM97Qi7nB7JjtIO+vlB320RxwI/1JFPTyVhTTwjl3CPxK2HC/cvYOm2z+23gJYM+vA==@lists.infradead.org
X-Gm-Message-State: AOJu0YxYF8FHQpq+cWKqunajCwBWEa44BnPSuRprHNF38UBo0gjttTFi
	k0S1GF4J4KtUoYTjqfVfSZylHAci1Y1DWXwp3n34bbZX2RX+m5kV4oHs
X-Gm-Gg: AR+sD10es8bzoR9CCRAIdKoZx905hH9lCiqC/QxH/1MHfvMIO3iL5I14c3AP+9GoDqy
	+PZ27pHQpaq6eZDPpeGrvkutuD02Asq601FOruM87C3g+Bx3plT5cSNUg4n0wI5Ak82EyVSAj4h
	w7b3pKgFoY0V8yYFFmPGoot4lVnx+s8u0SLZWcUtEH48yNcTPHSmFP8zRzoo6wnA0FYd8G8NgDE
	N9gg6lRiNX2eB/QyWy06ps5GIhm1O8ZdKM+/ja6AdlKGktmE809496kYn9lfqCp8CX/8hHd0vFE
	rHL/FxQGoHMmntmt8P5jidpwFVRd0NJaUjedMoR0alzwP7qnnvX7KGiLopBFfySkvfNuN62eOzc
	Ram3o1fNFuslct+UF7VhQ0mgsszHQ3IVOQliWbeymeJO+iWtoI2/SJOPq4eSbfCw0DiDsyJJ9g1
	wJ4F1C+3PSPB/BgP28qNJXUCuQrK/uAxO1eSPdto3sJ1j+xOhT9mM3LTUjMrFaCPJz0Uh7BTCN9
	dnCX6HaIhg1e63as2PJlvK1pJGGqYjMxXU=
X-Received: by 2002:a05:6214:5b85:b0:907:c025:e4 with SMTP id 6a1803df08f44-90a667db293mr50971636d6.13.1786464959922;
        Tue, 11 Aug 2026 09:15:59 -0700 (PDT)
Received: from CW-D0XG2Q16P7-L ([2600:4041:5d54:8900:9c8d:ddb9:b1a2:735f])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90a6c29a1f3sm2428656d6.17.2026.08.11.09.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 09:15:59 -0700 (PDT)
Date: Tue, 11 Aug 2026 12:10:49 -0400
From: Maxi Saparov <maxi.saparov@gmail.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Evangelos Petrongonas <epetron@amazon.de>,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, sdimitropoulos@coreweave.com,
	Maxi Saparov <masaparov@coreweave.com>, stable@vger.kernel.org
Subject: Re: [PATCH] kho: do not reserve scratch memory in the kdump kernel
Message-ID: <antJiVOAmzR5LNPe@CW-D0XG2Q16P7-L>
References: <20260803193938.8778-1-maxi.saparov@gmail.com>
 <anmKnlBmOssfqdbL@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anmKnlBmOssfqdbL@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260811_091602_047063_E62B13D8 
X-CRM114-Status: UNSURE (   9.30  )
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

Hi,

On Mon, Aug 10, 2026 at 11:23:58AM +0300, Mike Rapoport wrote:
> 
> Can we put this on top as a separate if, like
> 
> 	if (is_kdump_kernel()) {
> 		/* disable KHO */
> 		return;
> 	}
> 

Sure, I agree early return is nicer here. Sending V2.

Thanks,
Maxi

