Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82DE2D609DB
	for <kexec@archiver.kernel.org>; Tue, 16 Dec 2025 19:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=skL4VHIzFPfylzSaDU8ALvEyf+Mnup7qkqodMoOAfr8=; b=G7Fp1g5VrDeZqf7FmuZjVjuhLN
	I8oaFAPEdYtOxPRgjSFYUeparEctEWxRJqmomUouW/lzQXC2u/NqF72sfSl67yvH6/wZ28w/RIFJt
	1yxX6pDVCCE+Vc8FsGV+QVmGahTE38us7Z/FWFYG3Erzt0ys4rBlTq42FSNphIgq9eFSgYQ7B11q4
	vpbPug9cX9PGdzZNzMcIFdyBSkAy+HOx9SMi1T4Ady7JE8oiDuC5g47D7wYvYLiyQOuAv/TEAU3m8
	Ma2mGN4P41zW/iHteTbaktgX6N5gIjUkkFcO/mzu+k4MtoRMUM2/MLCbqwvsCGGmEWosE+qXJjfAS
	xPXF+jSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVaSU-00000005jsK-3gtU;
	Tue, 16 Dec 2025 19:11:42 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVaST-00000005js9-3edi
	for kexec@lists.infradead.org;
	Tue, 16 Dec 2025 19:11:41 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id AD35560137;
	Tue, 16 Dec 2025 19:11:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36CB1C4CEF1;
	Tue, 16 Dec 2025 19:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1765912300;
	bh=3EfwQTvQ9hgppKvFI90kmFfFXDj1wdTizQaXlXrRod8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oMlXv+BfzQ9UVwGw21x9uHE/w7D0ym4ijKiQc226SZECPl1nxIFajYAatERgrdF9F
	 wIn31Yqd/QJqZW7WBnFcrz/dsavvCaBmwi/hsLcNLpPsjhNaPvt4siOw7RtQhZI/hX
	 5HkinaOLiG4YwVC8Y9XjcPAmR06SAg1KAautkKY0=
Date: Tue, 16 Dec 2025 11:11:39 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Qiang Ma <maqianga@uniontech.com>
Cc: bhe@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kexec: Replace the goto out_unlock with out
Message-Id: <20251216111139.9a96dcbde829bf5d667ff50e@linux-foundation.org>
In-Reply-To: <20251216075518.1626114-1-maqianga@uniontech.com>
References: <20251216075518.1626114-1-maqianga@uniontech.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Tue, 16 Dec 2025 15:55:18 +0800 Qiang Ma <maqianga@uniontech.com> wrote:

> The image is initialized to NULL. Then, after calling kimage_alloc_init,
> we can directly goto 'out' because at this time, the kimage_free will
> determine whether image is a NULL pointer.
> 
> This will prepare for the subsequent patch to reset the variable in
> kimage_free.

There doesn't seem to be a benefit to applying this patch unless the
"subsequent patch" is also applied.  So wouldn't a two-patch series be
more appropriate?

