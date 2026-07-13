Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70ED8C43458
	for <kexec@archiver.kernel.org>; Mon, 13 Jul 2026 12:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uYOLvNQwyjuDQz0kxSpG+czfIhSiXVB9VKd60+XoBlI=; b=j1+f+aNA9GIFmF8a8yThkpzh3R
	f98cnbVnhaBzWqbW0EKP483/Lka4CYQlX03WUsmzTJJpfVeGphAozxRk/DItMwNFvg4Go8jDsGGfx
	TC7lVx9sRtM88znJi8hf/qN9l/eylnbsknNI/qyxQ1LVmMqENNd/EFuZBT8oiUGCeR731QlxIeAYc
	Tupv8lV26PhKqlO6dIo755bfvzDEfageovlXO928Xrv/8Vqr3xEbnfnIoQnHlQOaKVHDgCSyh/jBc
	8B+rLbP2z8fUV9marAl7hBYRUTPyndFskpCQtu/ntljsSVuPABG4j5eNITXK+3i1LH5+JaHOsa12t
	XG7CiU/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjFyC-00000009Dcp-1WoZ;
	Mon, 13 Jul 2026 12:41:12 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjFyB-00000009Dcg-2dLz
	for kexec@lists.infradead.org;
	Mon, 13 Jul 2026 12:41:11 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id CA4206004E;
	Mon, 13 Jul 2026 12:41:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C09651F000E9;
	Mon, 13 Jul 2026 12:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783946469;
	bh=uYOLvNQwyjuDQz0kxSpG+czfIhSiXVB9VKd60+XoBlI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=f9VlSb/yKVCNAwNbwptRjNCr7yjYG9vIFALhSWW1ywfFZx2rPQ3CoxpzH6zMcyZbY
	 zZ4qZE7YcbamEoHIl9rc49AvWS7jnr8eWvJmAXrHX4aeZ4EkUVTXu9mehpnYAf9ONi
	 N95zeraAnr8n2tKQ6G0PsPQBiocrUKjVo0JV//ZfoUrxgPjWWcSL6sijn+T30lsbYR
	 3VgKWIFxxhs5p214IZzhhRQ9e0FhJ0sfP3ljJk4k7HJcgYVoOOmIVs7OA7C2FGCX1H
	 57ppH2CzmvYsRJJD+xp19lCDeOgzx+1Iy1aJvqy1sPKr5SGwKPcCCxpO+U552PhcaH
	 9iZFrldTpYogQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Baoquan He
 <baoquan.he@linux.dev>,  Pasha Tatashin <pasha.tatashin@soleen.com>,
  Pratyush Yadav <pratyush@kernel.org>,  Dave Young
 <ruirui.yang@linux.dev>,  Coiby Xu <coxu@redhat.com>,
  kexec@lists.infradead.org,  linux-kernel@vger.kernel.org,  Guangshuo Li
 <lgs201920130244@gmail.com>
Subject: Re: [PATCH v2] crash_dump: release keyring reference at the correct
 time
In-Reply-To: <178392639372.255896.15219634537212682820.b4-ty@b4> (Mike
	Rapoport's message of "Mon, 13 Jul 2026 10:06:33 +0300")
References: <20260704112509.3717884-1-lgs201920130244@gmail.com>
	<178392639372.255896.15219634537212682820.b4-ty@b4>
Date: Mon, 13 Jul 2026 14:41:06 +0200
Message-ID: <2vxz7bmzkqot.fsf@kernel.org>
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

Hi Mike,

On Mon, Jul 13 2026, Mike Rapoport wrote:

> On Sat, 04 Jul 2026 19:25:09 +0800, Guangshuo Li wrote:
>> crash_dump: release keyring reference at the correct time
>
> Applied to kexec-fixes branch of liveupdate/linux.git tree, thanks!
>
> [1/1] crash_dump: release keyring reference at the correct time
>       commit: ada2e5a44e99113e08ad9b7b71396c6c572204da
>
> tree: https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux
> branch: kexec-fixes

For me kexec-fixes points to v7.2-rc1 still. Did you forget to push?

-- 
Regards,
Pratyush Yadav

