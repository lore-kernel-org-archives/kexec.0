Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50491C5CFDB
	for <kexec@archiver.kernel.org>; Fri, 14 Aug 2026 14:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Wbh+GzwLRDj8K6sa4FaLievOQOmn4W4a+vnrgcHiZ+8=; b=XaAX/DMN4aOkVJIk1XWt5whB1i
	lyR8Zl886g7ken1xQOZCZpKceOcwGkI4B8kO8djD2QFTCj30C1y54Dm9f4iBidKiEBtX7BPVONSTc
	5BsGX2OwM9Ps1gBK4lSkYFBPJYUYSK8PgGaU/yyx6wcHH+JA/LCfp9WrrMVNBZCZvN+ytGkaE4/z3
	NPc7tSe5LWSJz+EVBCpF4+AsG8bxCDy8RKm3VFJdj3j+NVI1NEb0a0N8l19YEFegh6GMcuxnBh3fB
	UMe1U58UujiMjKY/y5gF3dPFJRbnRveQxlnXyfZ5nTlpELFHsE/1KHLHYaVVgFHddKDzXmXYJBxof
	1GzVgHow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuscK-00000002lRc-1iSI;
	Fri, 14 Aug 2026 14:10:40 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuscI-00000002lRW-2y4P
	for kexec@lists.infradead.org;
	Fri, 14 Aug 2026 14:10:38 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id ADA8960A59;
	Fri, 14 Aug 2026 14:10:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEA7F1F000E9;
	Fri, 14 Aug 2026 14:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786716637;
	bh=Wbh+GzwLRDj8K6sa4FaLievOQOmn4W4a+vnrgcHiZ+8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=ZhG/QnnswWAQ8Kb14R80WrGND45IGsu7pq9K3Zs6upUv1ewBLaIalY9bF9lHRwqs1
	 o3il654JMBsdt82inwc+47Wf1d2YGzsDSlqpOSn3EkbRtBuTaJQT63DVPzJpocAAVy
	 JeNpgzRDLx4N+jiN3aczRZ1KeLlcQSqVXlVQeR35syUYLRhCuFrEbYQ47JjNjzrmKR
	 snmY0MCaUo4Hj5AGg0dGEAlAftnDOW5rddY13lMgxP0DPXjgMdnUCpzldC6fY8H6L9
	 rKTDqdOoXu9FDVnpkwsdFcJoF1/uZiJXImnygWHkiX0xChVIY+/8NACnIT9B2U3DPJ
	 SLyf4jkJ6GmoA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Chenghao Duan <duanchenghao@kylinos.cn>
Cc: pasha.tatashin@soleen.com,  rppt@kernel.org,  pratyush@kernel.org,
  graf@amazon.com,  linux-kernel@vger.kernel.org,  linux-mm@kvack.org,
  kexec@lists.infradead.org,  jianghaoran@kylinos.cn
Subject: Re: [PATCH] liveupdate: use scoped_guard for mutex in session
 operations
In-Reply-To: <20260814095506.631274-1-duanchenghao@kylinos.cn> (Chenghao
	Duan's message of "Fri, 14 Aug 2026 17:55:06 +0800")
References: <20260814095506.631274-1-duanchenghao@kylinos.cn>
Date: Fri, 14 Aug 2026 16:10:34 +0200
Message-ID: <2vxzzeyo23ol.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

On Fri, Aug 14 2026, Chenghao Duan wrote:

> Replace manually paired mutex_lock/unlock with scoped_guard to align
> with the coding style of the rest of the codebase and simplify locking
> paths.

No. This is done explicitly because we don't want to mix gotos with the
automatic cleanup-style locking. I don't think we should change this.

[...]

-- 
Regards,
Pratyush Yadav

