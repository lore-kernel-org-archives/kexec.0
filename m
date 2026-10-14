Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D10FCC6B1A
	for <kexec@archiver.kernel.org>; Wed, 14 Oct 2026 09:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H5SgPo1HKKa1EEOsG2iecS6xN05Y0dz7KAy0sbsqSs8=; b=gbTisSof2MeExGzAjEL18+gcSf
	li9egJ9Ol17kyaUwwh7NPVOR66p9ukcTnxyxxS/iETi2ZCaujmOP/WqoKZ3MnmcB/PNAUhlk+s7Lo
	BiRF6cQH/4IgOZoUDG5eKh59mhixSDfe8HWc1szCtfcKCy7Z03O7XO2s/fss3zyz5YfcZx9eLdbGh
	ZBc38IzLaxG4jG9YWhgrOPs40bCjilY7ZvFm3z1Bx2QjQmxZkHJrUiEEaTtM2yUHFh3MvAEmFYcb4
	pvoivx248VaiMrEfyRfpWo8W2R6Nd5xBpjFR7nQe54weChYYsiHvCAqN6bJ5CuuF+MVTA/3ukKLiI
	4a9mUqkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGvW8-0000000F5px-0qn5;
	Wed, 14 Oct 2026 09:43:24 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGvW1-0000000F5pE-0rHR
	for kexec@lists.infradead.org;
	Wed, 14 Oct 2026 09:43:19 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 8E7BC60214;
	Wed, 14 Oct 2026 09:43:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3E471F008A4;
	Wed, 14 Oct 2026 09:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791970996;
	bh=H5SgPo1HKKa1EEOsG2iecS6xN05Y0dz7KAy0sbsqSs8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=TvHMT19cp3VI4WXyMxkIIIl/rLkbwnHjQpC0jxXIXIcVqdL9JKKmVSSbx0r6hV7NC
	 Vrdpvz6qL4kqmdUa6ndhhBm547HYFlNtakrQ3150VOtqtxUgg/At6OYcKjKBZk+DZv
	 vTHNv6FZ8qbfem4AYLoZguZfvTOcrfUV67OCW+gFpCPJKpbB99Tqo/D3vKkSz2WuNh
	 vOWrjJzt4ic8ZI5b/0emBeZqAp8Vv1jjPYP+7Cil/RqS1xO96u9SkfKZBXadyOL6aJ
	 clD/IfYffLkkLB6aXQpFPDbtUq6WSVhV9vCPzmBbfUcRE4h+1LFv2vb8qkbUou6csD
	 GdwrM3es/LR9w==
From: Pratyush Yadav <pratyush@kernel.org>
To: Haolong Wang <18766350203@163.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,  Mike Rapoport
 <rppt@kernel.org>,  Pratyush Yadav <pratyush@kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  kexec@lists.infradead.org,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] mm/memfd_luo: preserve the sealed exec-bit
 state; reject kernel-private shmem files
In-Reply-To: <20261014035228.473825-1-18766350203@163.com> (Haolong Wang's
	message of "Wed, 14 Oct 2026 11:52:25 +0800")
References: <20261014035228.473825-1-18766350203@163.com>
Date: Wed, 14 Oct 2026 11:43:13 +0200
Message-ID: <2vxzmrsgipn2.fsf@kernel.org>
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

Hi,

I refuse to review this series. It looks entirely LLM generated with no
quality controls at all. LLM generated content is fine, but you can't
just post low quality patches and expect humans to spend time reviewing
them.

The commit messages are unreadable LLM ramblings, the code is all over
the place and makes very little sense, you have made 3 versions in the
same day, your cover letter doesn't even explain your use case and why
you make this change, and so on.

Future postings with similar quality will also be ignored.

Please spend time to understand the kernel development process and spend
_your own_ time understanding your code and polishing it.

[...]

-- 
Regards,
Pratyush Yadav

