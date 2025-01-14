Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2674E77188
	for <kexec@archiver.kernel.org>; Tue, 14 Jan 2025 13:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=flEd8z2hdXUk/KymUNdSJ4lzjp1l0nO7/efuuvNahLE=; b=m6g5guIEzu4r0kiy3rfBsMwr4f
	bxXutwNT88b/EOrtMm3xpHsMG6UxnPTaA6EjScqkCHLE04oL+LnOf8zymCNz6DYMd4xCRbyZ+GRAE
	zlC/gPeWcn4vvAXNen2qCSCJUvyJ5IpSdFdoHBcNlczabKFHTtKc6hDlDa4e+KssZu5FzCO71YGUM
	P+4fnm0S4sOtv7QHvLo3ldJRHMuYhrO5Yeas00hpTxZWTr3S8NqUF6CH+iez52j3/CCdK7XNRLh1D
	ZM4NOBYETMGpa5teO21XNJHkjJAZahUsueQwUHye3KCZRnAFWVPekcW64E1TrkgVZjSHz0RNTxYWx
	HAzkD1mg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tXgpL-00000008V5y-2lHq;
	Tue, 14 Jan 2025 13:19:27 +0000
Received: from out-184.mta1.migadu.com ([2001:41d0:203:375::b8])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tXgpI-00000008V2z-3plk
	for kexec@lists.infradead.org;
	Tue, 14 Jan 2025 13:19:26 +0000
Date: Tue, 14 Jan 2025 14:19:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=r-ricci.it; s=key1;
	t=1736860762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=flEd8z2hdXUk/KymUNdSJ4lzjp1l0nO7/efuuvNahLE=;
	b=GG4uwl0rwAgNdmsDR1mVIO6bFTRdvrm0k6C/ix7j7Nms85OlahEJ0SMakXx2tAAIEVaOic
	vE/yuZlFDDqBxq/zVnfmI1aUqcOdTmT65xGHe/T5B//evRkKZ6q9dccdqsMWTFolOIq8uA
	9m8clwtdLeoQrmio1kHWbC5hZTTf5SvLyH3u9eMv4xLon0WZKoPlbcqqsr7FWn5yNXlfNu
	s+PYP+w4KadFrVTQqlI1D4f572mGYD6rXt0baFZz+TnzwKDvHou9KLD//rYTmgkp4I2Y1h
	JBP8U7UwJfGLsW/KPckHN/kUf+KRbjPgeDmBL0PnfT6i/mZY3t0o7WLB/FFUTQ==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roberto Ricci <io@r-ricci.it>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: ebiederm@xmission.com, rafael@kernel.org, pavel@ucw.cz,
	ytcoode@gmail.com, kexec@lists.infradead.org,
	linux-pm@vger.kernel.org, regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION] Kernel booted via kexec fails to resume from
 hibernation
Message-ID: <Z4ZkU81xJwEUiCbV@desktop0a>
References: <Z4WFjBVHpndct7br@desktop0a>
 <20250113151749.b687c35e9f4c6d596449f433@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113151749.b687c35e9f4c6d596449f433@linux-foundation.org>
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250114_051925_097328_D18C347F 
X-CRM114-Status: UNSURE (   5.55  )
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

On 2025-01-13 Mon 15:17:49 -0800, Andrew Morton wrote:
> Thanks.  Are you able to confirm that reverting 18d565ea95fe fixes things?

Actually no, reverting 18d565ea95fe553f442c5bbc5050415bab3c3fa4
("kexec_file: fix incorrect temp_start value in locate_mem_hole_top_down()")
on top of v6.13-rc7 does not fix the issue.
So this might not be the real culprit.
But I verified that 18d565ea95fe553f442c5bbc5050415bab3c3fa4 is affected
while 18d565ea95fe553f442c5bbc5050415bab3c3fa4~1 is not.

