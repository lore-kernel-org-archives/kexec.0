Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE982CD6E60
	for <kexec@archiver.kernel.org>; Tue,  2 Jun 2026 17:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NmTjsdtcsEWPtZ1rK4J/ssqszpbeEyMBBb9pIGb/JA8=; b=WHnnATr0s7Fx7kpnfyLey+qNMc
	wX6OVOPXXztHTiKeVt6EfMcoyA9i106aGAMTzSV4QiHu2nzJFzDkXRGhIAPkrOexzcAWIEpQCtm/k
	fMcJZgwg/dau3porfFwVT4V3SN79UcC+M/3pLBjVxJhLwTKvZhX6AJG2ypKyQ7D5MdROB/52afRKs
	J/yDMWj5OTTJPNQqNJuWL3uoYacsu+6r14UuFKJI0Ubeety/m6/T28WcMEsxXX39WcY3rfS67g7DI
	5NjGOELnP+DheqkySr5/zdpm+kSEA/1pLZ05gX/gv3093YJxQ80/7LBQ/ZhvLPmntZYmm3569ig/D
	zAncjZNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUSaz-0000000DXw4-0rmz;
	Tue, 02 Jun 2026 17:08:05 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUSax-0000000DXvi-377t
	for kexec@lists.infradead.org;
	Tue, 02 Jun 2026 17:08:03 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 210E760098;
	Tue,  2 Jun 2026 17:08:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 791A11F00893;
	Tue,  2 Jun 2026 17:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780420082;
	bh=NmTjsdtcsEWPtZ1rK4J/ssqszpbeEyMBBb9pIGb/JA8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=NNDMgpuFP58qv/uVLIlfI9sarPKbDaMhNRa4+PTfF0jz2aBQ4vxq6RfKqtJMHoIhE
	 qLChX5g0Ye1ZQtg96r/5oiv/9NKx+46rj/aVYt2qb969aBXxarsT1YEgPLk61nJ4nZ
	 qEHsaiY1UnfX/5r+OJti+YOj2QJi8D/XaDg/tIL5Cq9ZCunJHgKp8wNDdl1MrEuo3y
	 P92T+5NR2DwtdKI7yMSIV/efPMaBWt0vCAFbFk+TzAplxfMEZKEvM18K3jtouq5tys
	 aoPh7teJRj4ofGeNoIeRu0iOoSAAySOpqVW7AzckZVbyPFhEIhZjFVxK3fB5XVa0Ig
	 pAIgKoE41STXQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kselftest@vger.kernel.org,  rppt@kernel.org,  shuah@kernel.org,
  akpm@linux-foundation.org,  linux-mm@kvack.org,
  skhan@linuxfoundation.org,  linux-doc@vger.kernel.org,
  linux-kernel@vger.kernel.org,  corbet@lwn.net,  dmatlack@google.com,
  kexec@lists.infradead.org,  pratyush@kernel.org,  skhawaja@google.com,
  graf@amazon.com
Subject: Re: [PATCH v5 10/13] liveupdate: Remove limit on the number of
 files per session
In-Reply-To: <20260602031717.197696-11-pasha.tatashin@soleen.com> (Pasha
	Tatashin's message of "Tue, 2 Jun 2026 03:17:14 +0000")
References: <20260602031717.197696-1-pasha.tatashin@soleen.com>
	<20260602031717.197696-11-pasha.tatashin@soleen.com>
Date: Tue, 02 Jun 2026 19:07:59 +0200
Message-ID: <2vxzo6hsdg5s.fsf@kernel.org>
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

On Tue, Jun 02 2026, Pasha Tatashin wrote:

> To remove the fixed limit on the number of preserved files per session,
> transition the file metadata serialization from a single contiguous
> memory block to a chain of linked blocks.
>
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

