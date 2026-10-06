Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5407CA5FED
	for <kexec@archiver.kernel.org>; Tue,  6 Oct 2026 18:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7VPKoVET0WZyi57RaxQihc41cTq7wyN7m0LKNzGgdxA=; b=U1ZwO3OdxlX4AXBaHu0ikLsCP9
	xyUs7DDFFLjT/ZkWCFh9uN7/bFCbUYKFPEqIxbybtTFxW33jN82fFM+SAWU0jbY24m6GJdf71tYUZ
	BfIKldjtd9dNNZb217h4fYrVaXaIUMjgX68bdteg+3d93BeBcOkhUd6Tr/NeSwYq6iBJ7C960sFxX
	o4rV1pxF/CPXaAgK+5Snp8ke7rvxYLjktQ2a87c3pX40LJ5MkU8Y2tUNAZFMXUliPKldMUyLS7aBz
	Tn21KYw+F8/PeZnSEo8ejiRCc9gOnyebZnzLNj6tdRTQSa4/5BcUesWzaAEhC9utcditwRIV63g+i
	7HMe98qw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xE9Uu-00000001Eve-3epv;
	Tue, 06 Oct 2026 18:02:40 +0000
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xE9Ul-00000001EuX-0tzy
	for kexec@lists.infradead.org;
	Tue, 06 Oct 2026 18:02:38 +0000
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id BBF353F788
	for <kexec@lists.infradead.org>; Tue,  6 Oct 2026 18:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1791309745;
	bh=7VPKoVET0WZyi57RaxQihc41cTq7wyN7m0LKNzGgdxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=iXCQQb7eMUz6yrDWGGHjys9Hk8X8xESHiDdK6/Kw1dF0MeM+QNScH5KwV3Jiru7uF
	 Gx3XEEURkz68rqkJCfMU1u3x1Su+wX0EDsw8ifCOQsNsa9VrZukipeU6EbpAM33eUd
	 qnhBTHGGTwlKTqDva5gkhNAkYXEdKyHLP4BbTmeJo4xOImkJhWuSY3exE7Fr9biCUh
	 7+r+kaLSsAcg6vTymSB7zs1R3Ss636pEAaDQMCAzBn8HLz46MjGk9n0mgAZx0sE1Kn
	 q+0nQ6Whk8vMUozrz6XRNfAWeVPcVQH8L0lbWjbdmD/ea9KIUaDs9BSvoiWP0c0h7m
	 B/R2HL7ZZMV8Tez/1Ir+ul61vzohbnvEgHf9i2D5U4FEpd3M8K1Esncvoiid/2E0fg
	 z/ICOAD8F7rGui87lERnWMc+KiV5MQGvYwoxpW5BbJKt83cfA5DmKkNE6WHmfc5bpp
	 DIADmnf2lu8n8sIfIeV46b2gryI1Jdr9QwHDKEOQRsMe0CSddmP5AdP1CFfKqfFLI8
	 eX/Xq9fqh3ItsxIiUovEj5BmNs2Yf0Ve8RAlkKPKE2V2pZs/QY904cEBjyjTlV1J0W
	 ETrvoryJpNi0GRL5jnjwsAwtQZga0m0BRszqa3yLo0yjYun4oD3axrKZ4O8eVbLx5d
	 WHABfP7ahaGTatWHcyCxsSO0=
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a019d53f46so25545705e9.3
        for <kexec@lists.infradead.org>; Tue, 06 Oct 2026 11:02:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791309745; x=1791914545;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7VPKoVET0WZyi57RaxQihc41cTq7wyN7m0LKNzGgdxA=;
        b=ca/mKC9fnQWPsktQpqVlbPPWY9tQrMh/yPRzRVYJXrXGHe9TKkmGTNd7WKNWiVUZY8
         jdq18NTzhwqlPGt9+COdEQ1+gOp3Et7EhUZz42BOAEFcy431bCrWl0Y2oDZQi5cRRb1+
         Klu36x/VlYtjH9GzpQEiNEqOvi/ZFwYD0KbkLghK18yWJHWvDGazsC104p5x/NlDi4pi
         e9FzzWXPsifmPoziURIMmd9FIbvcPWW/kdIMUWNDTrwn9CMlBbdTgoYWE9MAXO+Qope/
         qVbY2L/HXU2ZN4pE5giSPaw21jtb/KQYc1tsjLb2rTa1bTHDDq+k8yrK8Mqy8RrIoLae
         nTrQ==
X-Forwarded-Encrypted: i=1; AKwUvBxVXE1cE+OrNuioOxwyQgyaUS2dHWL5QQK6ICgyaATDWp+2jzG81NlvA6YQBk3+2Ozx5H+cZQ==@lists.infradead.org
X-Gm-Message-State: AFuF++nJ1lA5EDhjvqbYDrmSrCAG43PmyqSFi0X8GHBkO2+1YiAa/IZn
	f//yN0KVAu04qzkCNE10IurRoI1vKjuXZHc1j9yE82n0dNJXCimuFhJG4sXWIlkNi4B/pLtkNlR
	vrK2/8CGxDfgF2Wbot2E1SANjDz3cq2GwV5I3zcOXGjWT4JZieZAQYtN87//yUhRbvfbct1EgmH
	8ucA==
X-Gm-Gg: AYBFou0i21R1cHGrGu/JRwmJgZsahr+v3hs0889Nzypd9Vli83dPk5h5mSjejyiJfbS
	rnF2zi2E4ESf5y9gEk3kMOXEWGW86RguozmfxwbRZhmAuXX7g5UKbFmXdBmHLpEcyf4mSr1G8j5
	moNTJlVTcYcgIp1tVMa8ZvfgaM0bZneUQOIN2aMB22kU5TSVyN9d5DIyv1WJff+80SlHp+y+0Jd
	fUMirP0g6MJbA9bhhvOd8qS9mYxTzOWjradtP2wm8pkqxbTj6+GiFQyH7DXCIbBjN5yHbJ9CRE9
	7e02dzu/tMxpmhOvJ7PwvbiJZmcB8uI8zKhye6wU4qt71Hbm01HJGp8C96uBHblgoKFk+tsgJmy
	rmAJ9CYc=
X-Received: by 2002:a05:600c:1c16:b0:4a1:7832:dfd6 with SMTP id 5b1f17b1804b1-4a17b5340c8mr40388915e9.5.1791309745302;
        Tue, 06 Oct 2026 11:02:25 -0700 (PDT)
X-Received: by 2002:a05:600c:1c16:b0:4a1:7832:dfd6 with SMTP id 5b1f17b1804b1-4a17b5340c8mr40388535e9.5.1791309744934;
        Tue, 06 Oct 2026 11:02:24 -0700 (PDT)
Received: from px13 ([2a06:5902:822:4600:6f35:9ac4:c6c9:f701])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a17f493761sm5540315e9.2.2026.10.06.11.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 11:02:24 -0700 (PDT)
Date: Tue, 6 Oct 2026 19:02:22 +0100
From: Chris Bainbridge <chris.bainbridge@canonical.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Jason Miu <jasonmiu@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Alexander Graf <graf@amazon.com>, Ran Xiaokai <ran.xiaokai@zte.com.cn>, 
	regressions@lists.linux.dev, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	linux-mm@kvack.org
Subject: Re: [BUG] KHO handover hangs when memmap reserves PMEM
Message-ID: <asU2AD6DxGSD0ek4@px13>
References: <asE0R_f2r2TL-3Sy@px13>
 <asTTo3AFzQoqZLoP@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <asTTo3AFzQoqZLoP@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261006_110231_669193_2A06CA40 
X-CRM114-Status: GOOD (  17.26  )
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

On Tue, Oct 06, 2026 at 12:55:31PM +0200, Mike Rapoport wrote:
> On Sat, Oct 03, 2026 at 06:02:27PM +0100, Chris Bainbridge wrote:
> > Hello,
> > 
> > I am reporting a regression in KHO handover.
> > 
> > In the most recent Ubuntu 26.10 beta mini-ISO releases (2026-09-18 onwards),
> > the first kernel reserves RAM for the downloaded ISO with a memmap directive
> > such as memmap=<size>!4G, then kexecs a second kernel. On affected kernels, the
> > first kernel reaches "kexec_core: Starting new kernel", but the second kernel
> > produces no further output and QEMU spins at 100% CPU. On unaffected kernels,
> > the second kernel starts and finds /dev/pmem0 with the expected "Persistent
> > Memory (legacy)" range in /proc/iomem.
> 
> TO make sure I understand this correctly, you enable KHO in the builds of
> the installer kernel and then the installer command line explicitly enables
> KHO.

Yes.

> Is there anything you actually preserve with KHO when kexec'ing the second
> kernel?

No. kho=off is a valid workaround for the mini ISO. I only reported it
as a regression here because this was working until the bisected commit
was merged. If this is intended behaviour then it is not a problem.

