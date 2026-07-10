Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7159AC43458
	for <kexec@archiver.kernel.org>; Fri, 10 Jul 2026 08:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=neUUMderc8pK3/GUtT7QKblcYRV+0mOiXacxP6rJpzQ=; b=qullUppSqAjCQ6miHlHhFObq6m
	U2TmbnZMRnHR5sqHXuxCcHWCRknA1HB1Z5qoLFhb/10m/H7YvS3skO330Y3C8h13CkrZoNkps7l1q
	mQGiT8zKIVV+NMpclvuwyL2bwKJTZNm3e8fs3kx9pNYBscjhG7gCGzszJc7BNUsk07AmOHAt+wYKF
	2VU+dpBuFmabOK4RDJlTX5y48uxbhM9LAT9yL320CNX7O8m5+rFaDrjnEZNkBXHjDqUQ9gvpn4y8l
	u/E5jONvBmc8W6xINWcCO0jci4NBweVwJuk7dFrkxHfV0fzh3kwBGR7u0TczjRJYJGeS3YGVHQWoc
	PfyVhZLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wi6HO-00000004QJ8-1olL;
	Fri, 10 Jul 2026 08:08:14 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wi6HN-00000004QIr-3ziS
	for kexec@lists.infradead.org;
	Fri, 10 Jul 2026 08:08:13 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 5D5CD43614;
	Fri, 10 Jul 2026 08:08:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15DAE1F000E9;
	Fri, 10 Jul 2026 08:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783670893;
	bh=neUUMderc8pK3/GUtT7QKblcYRV+0mOiXacxP6rJpzQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=EhTkA77ocVxsAwxNyvNg6nf7rP4PKUWF8V2L6ucOfkTTEsnQ2ehMAbqkm45XNNyam
	 GCO8ZuLKZp7lQ18Xsn7iax43NCh7dzlRm5HdVzz6vV82TidJYJ1ALkn7yWZFqx1RFo
	 41oGuo1zr1oa+sub9rVE199yzEDdfuAgvULv15L17btyB8PiILyNu8S8mcjUfxvI60
	 R+6vEfbtrsmA6xQidW1Z+VbaS/CrDE8wbg7SbrY/piKRC1GDWGpEVp/MXhSDBaCX/S
	 ZZZXs/TO3YWAhCRANnBkGViJE+JNoz+ETrW6i2+4qEbqX0d2pZcUfy9wnB0DYA8v5l
	 MHDqsFoAUJCDQ==
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, Mike Rapoport <rppt@kernel.org>
Cc: Jordan Richards <jordanrichards@google.com>, 
 Shuah Khan <shuah@kernel.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Willy Tarreau <w@1wt.eu>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kexec@lists.infradead.org
In-Reply-To: <20260626-luo-vmtest-v0-v4-1-e7d3111cd5b3@kernel.org>
References: <20260626-luo-vmtest-v0-v4-1-e7d3111cd5b3@kernel.org>
Subject: Re: [PATCH v4] selftests/liveupdate: add end to end test
 infrastructure and scripts
Message-Id: <178367088448.4074012.5903750066567618189.b4-ty@b4>
Date: Fri, 10 Jul 2026 11:08:04 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
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

On Fri, 26 Jun 2026 12:15:36 +0300, Mike Rapoport wrote:
> selftests/liveupdate: add end to end test infrastructure and scripts

Applied to misc branch of liveupdate/linux.git tree, thanks!

[1/1] selftests/liveupdate: add end to end test infrastructure and scripts
      commit: 89dd1421c554515e0f562ec67d976e6309f2710b

tree: https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux
branch: misc

--
Sincerely yours,
Mike.



