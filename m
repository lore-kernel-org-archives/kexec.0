Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8D1BCD6E4A
	for <kexec@archiver.kernel.org>; Wed,  3 Jun 2026 13:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Cg+TcWYKH4zzSMQZZLp5kN+E2gVzcXQLNcYelVPRezE=; b=WTjzZ9NTnYZ4VMQPI5RMKWlx+A
	mTOC8SylsSqYZBnNKVSkzWFl1NGdAGSHI6p+8nvNqAxWDX2yZReKrV2BA46BeJYVfb2CpZcfqHD48
	fkSaNrW/7GsGPgcYdXWUEAZXpEYqweAMWNcSzFZ1DniybtsG4Rizshiyey/cFIoBJXrvVt993/HuS
	YDWZAA95Zp3Y299ldgbijlfqPm6adQ639qOZtjkfKlP7ccE5wtvMdJaR6rmi5vrxzxU4/UJ62vKm1
	avKAh6jJlO2epfIUhURyHcViNpUkVM0ImISpNHc7zIWDablkMTJaRl4olOUmp04VzhRYYfuM7j61F
	c+jbZ22A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUlhZ-0000000FB7V-1dbH;
	Wed, 03 Jun 2026 13:32:09 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUlhY-0000000FB7N-1U0U
	for kexec@lists.infradead.org;
	Wed, 03 Jun 2026 13:32:08 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 40A8D60238;
	Wed,  3 Jun 2026 13:32:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A48181F00898;
	Wed,  3 Jun 2026 13:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780493527;
	bh=Cg+TcWYKH4zzSMQZZLp5kN+E2gVzcXQLNcYelVPRezE=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=JU2sXsiR/R+jB1usuGwYZ9BkGQPozH+ZvF/mkoXgnW9AWwiWthn17AkDWglmUgy6D
	 sKvP7SS3IghC9HxhVcaGk/dG9dfxglfPxiv48m5CkmN9l/WwewFQD2K0VNLdLuw4f/
	 cYLpukaqAyfBFTsUtgzZVJ9av54lTUEupI9P1/1oGScoc7gGnBOkHlyeYbeyPSFw6J
	 Xm/3tUTPs3oOsLRD0bZ0+4sycFGE98Ix2++7hnQRW5twZkUPI+weT3yZdEvmO4FgRS
	 gGo5UrJwPmDfNAmEYMzodASNKLFmXxOJSA5frYYJ3GeH7FlGD4G0XJCk0v1vF1Spyk
	 wQSkGFQnd0TKA==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v6 04/13] liveupdate: register luo_ser as KHO subtree
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kselftest@vger.kernel.org, rppt@kernel.org, shuah@kernel.org, 
 akpm@linux-foundation.org, linux-mm@kvack.org, skhan@linuxfoundation.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, corbet@lwn.net, 
 dmatlack@google.com, kexec@lists.infradead.org, pratyush@kernel.org, 
 skhawaja@google.com, graf@amazon.com
In-Reply-To: <20260603032905.344462-5-pasha.tatashin@soleen.com>
References: <20260603032905.344462-1-pasha.tatashin@soleen.com>
 <20260603032905.344462-5-pasha.tatashin@soleen.com>
Date: Wed, 03 Jun 2026 16:31:59 +0300
Message-Id: <178049351951.475072.17505666427466268204.b4-review@b4>
X-Mailer: b4 0.15.2
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

On Wed, 03 Jun 2026 03:28:55 +0000, Pasha Tatashin <pasha.tatashin@soleen.com> wrote:
> Entirely remove the LUO FDT wrapper since the FDT only carries the
> compatible string and the pointer to the centralized struct luo_ser.
> Instead, register the struct luo_ser via the KHO raw subtree
> API, placing the compatibility string inside the structure itself.

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

-- 
Sincerely yours,
Mike.


