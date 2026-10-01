Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CB82CA5FCF
	for <kexec@archiver.kernel.org>; Thu,  1 Oct 2026 00:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WjMDzPbxoDZc0HcBqdKOJdHnNAywAZ6wV/0yHIoux9E=; b=Ah7VO2vYkyLn3dIqhdMX8BLheG
	O9FpEIihEUVmKcYp72BXh73uIm/rLFdplmlGXEtFaRfso5wJElwFwBrUnaztP2wBHoIn6zv3VjBtQ
	+6IKWOnCjzFceTU3ijfvAYUrUnL9AM+NOq6dcEnfIxsCGCa5eSrUTW8aAw3hK/JXmi2V5Dmw7xY7d
	lEQ5yLIWvnlt8ZcqU2GDQOtIDlDhT4yBkesGJCj4jRX6F8+dCwO+hbnyRU07GZAgk3LA7wlXm2SYO
	7QWS48Gnbv+q+tACkJclXncKR4c7iOxc1YurdJUCYa3f1dCuw8/og0g6hrvnMnNo7u6Wk2G2dwDdr
	/t+cweNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xC57P-00000007XJC-0mHl;
	Thu, 01 Oct 2026 00:57:51 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xC57M-00000007XGh-1GLW
	for kexec@bombadil.infradead.org;
	Thu, 01 Oct 2026 00:57:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:Cc:To:From:Subject:
	Message-ID:References:Mime-Version:In-Reply-To:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WjMDzPbxoDZc0HcBqdKOJdHnNAywAZ6wV/0yHIoux9E=; b=VOqmLXrzf5cbcK4cXQsXbHgJED
	bi62z6YeE8ehlfroW5yryD0qlOnp89JSmgowvRcG9h+4twH5j0EjmTv7TRy9BQIYU0DWzKfG3lLKf
	nNt8xmiUHTxUvZfm514X4qrQ/nnvl1mu0wUXMgUj+PFX146cL6qvMTWsjVGj2HIbd38Bp0IqTX6Ss
	PRLs5QOtimv3tyMovyTadkWeeYRkMkibMWaARJ2gYQOID9nqFne1zl/lxAcu3XfWdoODSvWAXznBZ
	tVq8LJji10aVET35SAq/5LLTZSIyJQT8xeiLHCcEUdk8ww64SLbSgAX/glsJ0yXhRRLRKkcGpDAcS
	4dtStTgA==;
Received: from mail-pl1-x647.google.com ([2607:f8b0:4864:20::647])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1xC57J-00000004TJN-0d7c
	for kexec@lists.infradead.org;
	Thu, 01 Oct 2026 00:57:47 +0000
Received: by mail-pl1-x647.google.com with SMTP id d9443c01a7336-2e2f2bd5256so4553445ad.2
        for <kexec@lists.infradead.org>; Wed, 30 Sep 2026 17:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790816262; x=1791421062; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WjMDzPbxoDZc0HcBqdKOJdHnNAywAZ6wV/0yHIoux9E=;
        b=IBIr8/VXsG/gNfG2o9NCs6ocpNUOQbWpYJSf2cpglYXqUc6DESvj2sy9dVjtuJk5yM
         zkWjqI1Mbr2Pr4BqGax8riq/mZRLJ+UyEYNa8fYfKiyN0ZGmmYsvhBRGSPdGxHSs+Vy6
         hoyGEnLdmQrw0yFtSdkRqNK7fyp6gXG6otYosu1gUUT1je9l9Uy1ryru3wfyRDgcM1LK
         bTlBmeFBGXL/+dej6sFiVktY3fHsrZ78Pxsxx1L+8BGAn1DsbtHH5h+U2WbTnqy4Cfs/
         QFPiR0b8xPEAt05j9qVpsPYrlCDhDmqz3mjoSABImFPo5IVK1oxM8oc5mP8SXvNYahDy
         qxtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790816262; x=1791421062;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WjMDzPbxoDZc0HcBqdKOJdHnNAywAZ6wV/0yHIoux9E=;
        b=VZQkN39ktZugiKlIEXwfhMcj5/LWs3scdjbEHHW1kcX9SD34y0tRPmI8o5juzIM6yj
         COUKUwBLhf0++rxgucWpB2PN76cHTB8AIvvFJcCEWtnUG7GfsFiWX+Ueb871iCs+IxiF
         5oDr4Km9UGB6Ag5ml6Fy2N/VjdX+LmCqsCPAVe+YAXNLq2etIjvrQ18ISGQtdqaWJ0MB
         VRfFC9dEPvy9NVNu+qaDvjF0COhJtm6smxxfOPyGpWszNanePBqKs1x0S9OzwQcgXsVF
         573N+sjq0ryL9+V7DkB/uoOL7a/1wTGHlQHuQ3cDvlS6Y70P6Ctrt119Iy6cFPV575kH
         mkLg==
X-Forwarded-Encrypted: i=1; AKwUvBz9Z6bAMgebctvq/gDhAe4FaqbNUX/DIElyvYqhVTKQoM4Og604q2TCyekB9MKrVE7wPWvUeg==@lists.infradead.org
X-Gm-Message-State: AFq9FYLIiISBvjT5zFcaaBzUYPAQgmHFUfez0ScfaEO9toNe3uO4+ZVF
	it3KBVvVhVb8hI+sQzOcqjJn5XBatZkUWcM6hEGBJ01dy9Nk0FKKcpB+XypRSMlrv5XfHz6GhLP
	qiEaCD7CJ20qt4Q==
X-Received: from plcr5.prod.google.com ([2002:a17:903:145:b0:2e1:324e:b311])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:8cd:b0:2df:7e40:6f6c with SMTP id d9443c01a7336-2e2e49f818dmr25929285ad.46.1790816262111;
 Wed, 30 Sep 2026 17:57:42 -0700 (PDT)
Date: Thu,  1 Oct 2026 00:57:30 +0000
In-Reply-To: <20261001005734.1033516-1-skhawaja@google.com>
Mime-Version: 1.0
References: <20261001005734.1033516-1-skhawaja@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261001005734.1033516-3-skhawaja@google.com>
Subject: [RFC PATCH 2/6] mm/memfd_luo: Set Liveupdate level of a memfd file handler
From: Samiullah Khawaja <skhawaja@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, 
	Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>
Cc: Samiullah Khawaja <skhawaja@google.com>, David Matlack <dmatlack@google.com>, tarunsahu@google.com, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:KEXEC HANDOVER (KHO)" <kexec@lists.infradead.org>, 
	"open list:KEXEC HANDOVER (KHO)" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261001_015745_568329_AFD233E6 
X-CRM114-Status: GOOD (  11.89  )
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

Set level of the memfd file handler to LIVEUPDATE_LEVEL_MEM as it is a
memory provider.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 mm/memfd_luo.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/memfd_luo.c b/mm/memfd_luo.c
index 59de210bee5f..91ddd7ae64b3 100644
--- a/mm/memfd_luo.c
+++ b/mm/memfd_luo.c
@@ -604,6 +604,7 @@ static const struct liveupdate_file_ops memfd_luo_file_ops = {
 static struct liveupdate_file_handler memfd_luo_handler = {
 	.ops = &memfd_luo_file_ops,
 	.compatible = MEMFD_LUO_FH_COMPATIBLE,
+	.level = LIVEUPDATE_LEVEL_MEM,
 };
 
 static int __init memfd_luo_init(void)
-- 
2.56.0.rc1.315.gc6ed9934b7-goog


