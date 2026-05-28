Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20F4DCD4F54
	for <kexec@archiver.kernel.org>; Thu, 28 May 2026 15:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=p+m7PVKaXI1aH5GvoQay43qZF0QetiKnHaFlSk944tM=; b=FhVq/pTVHdpfL5/ikpjrhmS8UC
	UuPz3HGXassI0FKHYjR+0DVNfTuBrFytOjbklEN4weMffG4+N6F9rIt2gT71pbEgLj+LvVKCFeFDL
	Qt8hv58i6Wlw5due7xsqPCrfEEPgHGJP6Ueh6d3lfICuLowvbcPbHJpTIaORXPbgoMimzfpf6+s0t
	F3jI8pEN+IJMgrCSplg7AqPV8PUQ2p6lD44v8Osvqqgwr3jY2cTdq3ErqSVIucsC+U733K5RjLn1T
	W05pUecM25DozFAuxl5emvZQnCSrKkq5iYie9dkX8aPVnfM8ylSd3GXw3Gyfc3lVFqx3Z82hKnvWz
	yAGJsIBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wScLC-00000005tvz-3DRe;
	Thu, 28 May 2026 15:08:10 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wScLC-00000005tvs-0D0M
	for kexec@lists.infradead.org;
	Thu, 28 May 2026 15:08:10 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 54D7E6020A;
	Thu, 28 May 2026 15:08:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BB471F000E9;
	Thu, 28 May 2026 15:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779980889;
	bh=p+m7PVKaXI1aH5GvoQay43qZF0QetiKnHaFlSk944tM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GstNKpFJn1BqMn29fmUnfaTEeEKBSwtxZLRMmYGXQIIe/iiAvmyTQ5W0vzYGtfV/c
	 lNeROYsbux3poXkKRbI3sTDTWukWkEpIJktoJPH3pozN7pu6Au6jl8ZY5DLue6OQ/3
	 /7h+poVvHEHTtTAKGMesvcEtrlVGjfGBHLdQmq1oaw13lf9+/29IRzuPbZsMg41zAz
	 +Hvqpa6D+ml4XLqTjNrBDbG++CBK3bzgMYTwJaVIpuaE+OgPKRzpYF24YcqyN3qtb8
	 CfVoubZN8+rAsi9TVrxzsAkVCshz99GWbpTCyhXh5zj2IgxvHG/x83wbOnOT6OXjAZ
	 NxOjNAEOeYILg==
From: Mike Rapoport <rppt@kernel.org>
To: kexec@lists.infradead.org,
	luca.boccassi@gmail.com
Cc: Mike Rapoport <rppt@kernel.org>,
	linux-mm@kvack.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] liveupdate: document current compatibility status
Date: Thu, 28 May 2026 18:08:02 +0300
Message-ID: <177998087846.707577.12006390274464324360.b4-ty@b4>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260527153725.1770394-1-luca.boccassi@gmail.com>
References: <20260527153725.1770394-1-luca.boccassi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

From: Mike Rapoport (Microsoft) <rppt@kernel.org>

On Wed, 27 May 2026 16:37:12 +0100, luca.boccassi@gmail.com wrote:
> We currently do not guarantee compatibility due to ongoing
> development, so mention this explicitly in the user-facing
> documentation.

Applied to next branch of liveupdate/linux.git tree, thanks!

[1/1] liveupdate: document current compatibility status
      commit: d72c0a7b321cfe3a3cb510c599fd5e9cf3df24fc

tree: https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux
branch: next

--
Sincerely yours,
Mike.


