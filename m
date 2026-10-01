Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 828D8CA5FC4
	for <kexec@archiver.kernel.org>; Thu,  1 Oct 2026 00:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O/jlCmxwp3o8421DzN1IIl9qClV/YI1XzKtXgp14OcM=; b=W6OnVcY2dxJtFwSosGQNraJhse
	tB6mwCLS8tsnU0wZIvDKKolQMKSyvuSjzwgoIzKll1zMlP1gsYMSJv1dG2jYPhT6Wmsp/oGjS6BCN
	Mighs0k1JWiLIK6sz5f9YX5umm2+ciLBOK+B6VHq3JvQOJN+Nh6hBSud65OZNibCLn+chvktr2mWj
	YE+COGS+Xm+lbBmpvVzDwSRxZdJjLraWIuwB04lQStxtXJ2lwjhYATDXnToVJo1vyeGezLQbxXEq+
	e48YBrHVzaEnCyXABJDqoKQdUDI0gnc00wI4Selc+fx/EWpvP9DNlpfU5NmBzJ/DbYVIZXQP6RrOn
	VDQLFDjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xC57R-00000007XLp-1pX6;
	Thu, 01 Oct 2026 00:57:53 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xC57P-00000007XIz-3N5W
	for kexec@bombadil.infradead.org;
	Thu, 01 Oct 2026 00:57:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:Cc:To:From:Subject:
	Message-ID:References:Mime-Version:In-Reply-To:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=O/jlCmxwp3o8421DzN1IIl9qClV/YI1XzKtXgp14OcM=; b=J90IF6TglrsFNI7rWLPbL7HD5X
	lqUXyvEbADGEB9mgqRJOoWsY3B2vVcUtYpPT0FlRMDzHpsYA/W/rDt+hgpyyuuhGW987ecCv3LZU/
	0ntqKQUtOBIxAwkCb4gQm1i4gj550k5rAQRohFdExCWGlZuyK11sdTyemekPAak9hELtMv5KaOkdI
	Yi2/hStVWWjZ6wJQ+Mh1eC6nuXVX5G/FCCQ8gx6P6iusFsrEm9FT0g23ZzqS4K5uq0IvBSzj0VEx9
	UeauTiDWrA5kbUxQxuA0HMI7qbcmcqZUD74tHtz4GOelQmlsfkS5Ie1vLWxKenwVSfoMd33+KM7+c
	TiZD2bxw==;
Received: from mail-pl1-x646.google.com ([2607:f8b0:4864:20::646])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1xC57M-00000004TJh-2Fpf
	for kexec@lists.infradead.org;
	Thu, 01 Oct 2026 00:57:50 +0000
Received: by mail-pl1-x646.google.com with SMTP id d9443c01a7336-2e2e7d08ab7so8588645ad.1
        for <kexec@lists.infradead.org>; Wed, 30 Sep 2026 17:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790816266; x=1791421066; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O/jlCmxwp3o8421DzN1IIl9qClV/YI1XzKtXgp14OcM=;
        b=M0Bclx+J20JPpnoP9HceNsHw/dhg8HdvMlukMuSPUgCKLc3FpXxty7RElTwhrL9VRF
         RAg9aaEvoTKsu6EpmfSlRuEdJ48kdnXc+kjcVM6hKq6MR/y+Xcuj/y+z8t82DX2EvsRT
         B6e12tlW5jpfgi1FoBDWhTvnfBwAB4dc4Gm8/4jKZc2Yh48x0kApLj1F9qfcVzoj/up2
         VbskUk1lcan2oP2r6eL/+LrnOWYChFyGqNxZk+yqOmgli2R9Yix/sLCfLVTtbUkglCkT
         /vO3I7mTsl+ouEjJ4IcNhbAErA8d136pu7xWztLl9xnRKjjyrIiWfFgrtQ29TWHJvCg+
         jaFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790816266; x=1791421066;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O/jlCmxwp3o8421DzN1IIl9qClV/YI1XzKtXgp14OcM=;
        b=sDb4ypWbBeAnu2W1/0DSwAfO2sBfzIIS3FK1lR4Ao8Vf6H5R3rAP4a5r27Jhm00GVm
         +rb2KC2dBYxKzcH9jJTpyrwtPK6bOO19thCE1/5gxSURY4mdT12JGGk5MDhIiIyQ0ind
         VqokNqXmvEghyATfSoveYerjKJZhoph5vlhECiXlx4fBhvj1SEWiUdZRVbgXX2BsrBGJ
         lT773HAxVM3fN8Gzk52Ffdxq2vNSRgwN+ZV+mgQU/rcGGIBOXTVNzOEmZhIObWrjs9jH
         IbBfN+6CwFXwYF5s396gqYERDPrU+CaCfTJbS0iQ3Ps/W9+VqSmsvOobnqs93Qw7lREL
         W93w==
X-Forwarded-Encrypted: i=1; AKwUvBwsZVKeQGr566SCI6wY+SIL6py/y3vJZgZ6qqrHqkXTCew97bL3B+3XtJAvZBMNdJmLmSPE0Q==@lists.infradead.org
X-Gm-Message-State: AFq9FYI97k1hklqnSp4EdO7YUKUMEWLmPxfYIQsSRB5SrYlDCXL0G2DB
	s3NauK33XRKirmVTNitwNW5RuQiZfEcNJb/dNEPB8Gn1STEXZVzGdhacqxOcPZZCpEeCJXRqJew
	j0NNqxntqOP+OOA==
X-Received: from plar13.prod.google.com ([2002:a17:902:c7cd:b0:2e2:d259:863])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f603:b0:2df:8e69:1d5a with SMTP id d9443c01a7336-2e2e49fe3b2mr22721995ad.21.1790816262839;
 Wed, 30 Sep 2026 17:57:42 -0700 (PDT)
Date: Thu,  1 Oct 2026 00:57:31 +0000
In-Reply-To: <20261001005734.1033516-1-skhawaja@google.com>
Mime-Version: 1.0
References: <20261001005734.1033516-1-skhawaja@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261001005734.1033516-4-skhawaja@google.com>
Subject: [RFC PATCH 3/6] iommufd: Set liveupdate file handler level
From: Samiullah Khawaja <skhawaja@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, 
	Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>
Cc: Samiullah Khawaja <skhawaja@google.com>, David Matlack <dmatlack@google.com>, tarunsahu@google.com, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:KEXEC HANDOVER (KHO)" <kexec@lists.infradead.org>, 
	"open list:KEXEC HANDOVER (KHO)" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261001_015749_139204_4C7F2E31 
X-CRM114-Status: GOOD (  10.85  )
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

Set level of iommufd preservation file handler to
LIVEUPDATE_LEVEL_MAPPER.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/iommu/iommufd/liveupdate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/iommufd/liveupdate.c b/drivers/iommu/iommufd/liveupdate.c
index 423369e3a8af..2f2ae1a52be4 100644
--- a/drivers/iommu/iommufd/liveupdate.c
+++ b/drivers/iommu/iommufd/liveupdate.c
@@ -351,6 +351,7 @@ static struct liveupdate_file_ops iommufd_ser_file_ops = {
 static struct liveupdate_file_handler iommufd_ser_handler = {
 	.compatible = IOMMUFD_LUO_COMPATIBLE,
 	.ops = &iommufd_ser_file_ops,
+	.level = LIVEUPDATE_LEVEL_MAPPER,
 };
 
 int iommufd_liveupdate_register(void)
-- 
2.56.0.rc1.315.gc6ed9934b7-goog


