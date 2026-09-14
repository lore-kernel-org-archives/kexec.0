Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8495BC88E50
	for <kexec@archiver.kernel.org>; Mon, 14 Sep 2026 05:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HwgDrDnEblWNsNQxUseFgLL3m5bnPaTZRpQzIjhhgW4=; b=izuT5B63Xmrk91EEyGglcxsX/P
	ADBG733n6+vHvXHJdY/gYEz0bPnU5FcBHKNNpg/dkLfNwbQA3MNQn4FTq4jb6XKAPXIoZC8g0ffE3
	jcHGMcJOMJ8U4Q5Dq8s+Of6N/dP1oqwGywLsToKqOTkdGiQiISTrRZNt81OogNX10Nq4b5DqTtVtp
	c0wFWOog+Y2bMrgjZ4JDrARPLiO+Spx+3xgkmU9T6PMo04SE0nIb1N3fUenSgCi1/Oamrq5MHzQwz
	cTVhOiYyhuY0KKSqpyWdg1CBTMHxmnAv4O+KX2sYDsmZzwedUE5TUlVvDki68T0FgMkbLQwHUkCJz
	Nb9bdubw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x5zip-00000002Oe0-1AF8;
	Mon, 14 Sep 2026 05:59:19 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x5zio-00000002Odq-2KEr
	for kexec@lists.infradead.org;
	Mon, 14 Sep 2026 05:59:18 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 0053343474;
	Mon, 14 Sep 2026 05:59:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C78291F000FF;
	Mon, 14 Sep 2026 05:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789365557;
	bh=HwgDrDnEblWNsNQxUseFgLL3m5bnPaTZRpQzIjhhgW4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=DYOs2YZuT0+Mxf3rfQU2AC8D9wUnr9Dv5XkagKJFBm6H/vdGfb4pyryeRsY6wvk/L
	 BMAYEEjQWMOqNvf7kxPafTXsBN4hLTchDtouZI2R5DGxCaZuVdMT5QRR1jU04OGmtK
	 Tj22GgN05jvO77EO4Sz/oxdR+qdjNmxEclHBpLYM7l77sZ3SszCWkeIBeioToE4/iT
	 Q2U0c8MUdjsqSUXkHuZjnoUzLxEf44WnRW1gbpNqlnTjlnmqLk4D/AoJtaIb/Na0bK
	 xg/b7GTDy7XqYcZU86lwN6FEmC07Cx+RDajeIp0Wlj4s+pjuAfqlS1yf7d8KKq3HJh
	 MU/AD5w0odFKQ==
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>, 
 Samiullah Khawaja <skhawaja@google.com>
Cc: David Matlack <dmatlack@google.com>, tarunsahu@google.com, 
 open list <linux-kernel@vger.kernel.org>, 
 "open list:KEXEC HANDOVER (KHO)" <kexec@lists.infradead.org>, 
 "open list:KEXEC HANDOVER (KHO)" <linux-mm@kvack.org>
In-Reply-To: <20260910173659.1945246-1-skhawaja@google.com>
References: <20260910173659.1945246-1-skhawaja@google.com>
Subject: Re: [PATCH v2 0/1] liveupdate: Add documentation for file
 dependencies
Message-Id: <178936555084.3691424.8106623729087785082.b4-ty@b4>
Date: Mon, 14 Sep 2026 08:59:10 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
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

On Thu, 10 Sep 2026 17:36:58 +0000, Samiullah Khawaja wrote:
> liveupdate: Add documentation for file dependencies
> 
> I sent out v3 of liveupdate_get_file_incoming() and
> liveupdate_get_token_outgoing() series to add documentation for
> dependencies.
> 
> https://lore.kernel.org/all/20260820191854.1642931-1-skhawaja@google.com/
> 
> [...]

Applied to luo-internal-api branch of liveupdate/linux.git tree, thanks!

[1/1] liveupdate: luo_file: Add documentation for dependencies
      commit: 38dd32f08d19beb441f202e61d9dfede3b7f055b

tree: https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux
branch: luo-internal-api

--
Sincerely yours,
Mike.



