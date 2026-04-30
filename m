Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88D4AFF887E
	for <kexec@archiver.kernel.org>; Thu, 30 Apr 2026 02:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:
	From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7g+bHBHqB0mC7gBrJ+4fexgFehpSU6Fe+/D5WQCZElw=; b=J5YDorh+OWKfZlW3AGTsumgHmH
	px5YrZOZvt/JHgxsXuFTuf/QHUz4E8Q1ptP8oCdNuY0MpO8z2EAXQXi3cISD9XN7/MtSz7mc/T+HE
	pyGHoPJXN0+iEYyipl9/qvbjDFdv/YDPHYp+wefXysLdA6/kC2GkIqGLMa0hWhzLIV8YH1Xr4D6Le
	RiqKaPyR8cGX2D5H7GXtTnfTKhRUdeS/pS03zX7xZ/XLBd2/siUdWiF5I2bOhCTb3BIfZHnxd4EDJ
	LcAyJb0Xj04tPp2IAs4zsIimfGi+gDPHELQhwvmychDb3dKLogqn5G781P6k6Pl1gb+9BUrvfb+Ae
	XPrf66NQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIGlP-00000004PlG-1nLM;
	Thu, 30 Apr 2026 02:04:27 +0000
Received: from mail-qt1-x831.google.com ([2607:f8b0:4864:20::831])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIGlM-00000004Pkk-13nx
	for kexec@lists.infradead.org;
	Thu, 30 Apr 2026 02:04:25 +0000
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-50fb4a7d704so2945711cf.1
        for <kexec@lists.infradead.org>; Wed, 29 Apr 2026 19:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1777514661; x=1778119461; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7g+bHBHqB0mC7gBrJ+4fexgFehpSU6Fe+/D5WQCZElw=;
        b=D+IPOWCpQab+hF9MHz84O76G62yAClsJ9JzcVvjuIe1zUtNEp9FvKTxh++kvvvu1dI
         MnD+SXWHOyl1t9EkG+Ez3JHrGK2bemHKpbMQ/b4Rc0sgFoxiMBjAHGCXQs6cOmFq9vbl
         vLOld3svLwFESs/DFG2pl8bURkhERTynxeXTrmDgtweb0DdTIWATlIo6pMHbd5eqxgv0
         3nBOuUMMCdFcrOzb3RgxI7fSB4xlLBKL9Ckemqngm1JL/Ku8/i+SGRgvvG46FbHMqyex
         MgLVcGxdfH1p/JMXkD4s9H4EG6jzu52sns8pWpY7zCQFdy/awrPWVnEMl0aQUv+u7A6W
         /7bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777514661; x=1778119461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7g+bHBHqB0mC7gBrJ+4fexgFehpSU6Fe+/D5WQCZElw=;
        b=hB/ScayV1aMRi5IOLj7pmRym0hcfvjWDnHc+dOFg235XcBBmS1A2W0r/1p+2MqpkJL
         KddPD2nchVV9YKHp6eJvX6LCIuKx2sfJssSiVeSM+l1ouwHEBWFBf7KfD5nrlFRYO9zw
         UvNsPvb1+bHVnOJHsJlMVrTA8jBr78iWioCeWBD6YREqoggFdt8ulpBuiRkvW4t2s2Gm
         19qSozila8ESDhVFkBeUiyo4VIybhFPFm/4ZYUHoVC2TYePCUs61U0Rc0a/vHbt3qJYj
         pwttCuKrAkkxyD55Rju1WLxdEpRYF959wLF5tK0haNxOInX6KNnRC6DsibBnI6KuGjsh
         OjDg==
X-Gm-Message-State: AOJu0Yx43GNOb61iGP6mUbNMuhEAV3WYP4DuXvIyR8o4jzcOpfM5HfMo
	Nvo8g5BuL9xR/hMVUwKATc2KxVfC+DxK3L8nDVhWpX1ZWWQCyF4LG8kO8OH1f2bwpufWH5DX1TH
	wEiN6jqM=
X-Gm-Gg: AeBDietLhWTrfbJP5c7GG04IMOZGUskK0JBs3iA3DsivT2M6ilREXwgzp/IDyBE9J9o
	7fAgMiIXt24dWi+U2hgMN0lR/CwY//RZejqXd73lGGVWyvYes9QNbKolf51GdwVuXZa84NnBKZz
	FeS/Y22Q/2iv+oKAs0ebxwvidaOmAWdNvpkNtWrEFHxZS9Su4HbAWJyVEINvEZw7NAisgB8s/RA
	ENpzDa7iUtfquJfu/en8GsggHQo96NEfkL7in/j9s6cV7IOOCKEPrWt8B+t603ynxE2moZsWs+I
	C9hHHk0DbJwIlph8rZE/NJ/ZaYvVzK57T6PmisMTcYi2sMBxVJfUV0w4V4gipQGNCyHJ/h8zIAU
	sa9EJjqjfkoEPkL7phKeTZ8NXDdJt5+MCHHGG564vJC4Gk7g3XV3faBF/pfCL6IWppAkH3jo50h
	5V5VaxjVzTM+W4S9C0xGrfvwwqr99kmNhScNKmx3sJ2zYs64GzG6Xbtrv5oXT/7w==
X-Received: by 2002:a05:622a:1346:b0:50d:a6a0:8f04 with SMTP id d75a77b69052e-5102ae75716mr12941981cf.42.1777514661232;
        Wed, 29 Apr 2026 19:04:21 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5101ae3c0aesm32391031cf.18.2026.04.29.19.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 19:04:20 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: kexec@lists.infradead.org,
	luca.boccassi@gmail.com
Subject: Re: [PATCH v11 0/4] liveupdate: bug fix for session name and new ioctl to read it
Date: Thu, 30 Apr 2026 01:58:22 +0000
Message-ID: <177751358329.261376.10499682102827674381.b4-ty@soleen.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260429212221.814107-1-luca.boccassi@gmail.com>
References: <20260429212221.814107-1-luca.boccassi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260429_190424_298847_F9E30583 
X-CRM114-Status: UNSURE (   9.09  )
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


On Wed, 29 Apr 2026 22:21:13 +0100, luca.boccassi@gmail.com wrote:
> From: Luca Boccassi <luca.boccassi@gmail.com>
> 
> A series of patches matured while implementing LUO support in userspace
> in systemd.
> 
> - reject session names that are either empty strings or too long
> - add new ioctl to retrieve session name from FD, so that userspace
>   can query it without string parsing in procfs
> 
> [...]

Applied, thanks!

[1/4] liveupdate: reject LIVEUPDATE_IOCTL_CREATE_SESSION with invalid name length
      commit: a0a79b4272161f587923cfe8484c3812196a457e
[2/4] selftests/liveupdate: add test cases for LIVEUPDATE_IOCTL_CREATE_SESSION calls with invalid length
      commit: 5a42660ffc155baa4f5c574d052885ce59f33387
[3/4] liveupdate: add LIVEUPDATE_SESSION_GET_NAME ioctl
      commit: d6b3d47bdaf89f29682d9044d21ad1451384f7e4
[4/4] selftests/liveupdate: add test cases for LIVEUPDATE_SESSION_GET_NAME
      commit: 7ac15eb18f91fe0796c3556f372c6b3ac752dcee

Best regards,
-- 
Pasha Tatashin <pasha.tatashin@soleen.com>

