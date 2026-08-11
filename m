Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A12A3C5CFCF
	for <kexec@archiver.kernel.org>; Tue, 11 Aug 2026 11:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Krrkb4GTaAxnE8gRQpTXpOP7iACr+puNNwdjj+aGSmo=; b=cPjgZqhuaRpBYgYXDNWYlsj1Yd
	SeL9ViOoEaUw81qj+1mmSIaulejW0VDdUMryFjp2P2bp8xaHY07H2VRpmC1qEhA4cfxijEWCJBoCs
	28zGeK3iW50VeXiBFIPutNXoDn47zGBZVAK8rHO0HoEJ8+KC9IxwhU2E/m/2J/Dol0yVr/yQ6agpS
	ltlt2LnNEsdp6/ti+c6mxDnJ+G+VMO4q/OoZZHKFufthL0LT61CdqiopEzuLCu6ptJ9nU1w7ly4s0
	6Cq+y9wiN0e4hkJovIFDHS8NjLiLircXotyDU/+YegKPhpUwQGsCY5aZicle9cj6zKuDs5OX8HV/s
	kKvKKatA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtkpP-0000000DwqN-1VDS;
	Tue, 11 Aug 2026 11:39:31 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtkpN-0000000DwqE-3LvT
	for kexec@lists.infradead.org;
	Tue, 11 Aug 2026 11:39:29 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id ECBD8600AE;
	Tue, 11 Aug 2026 11:39:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CA841F000E9;
	Tue, 11 Aug 2026 11:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786448368;
	bh=Krrkb4GTaAxnE8gRQpTXpOP7iACr+puNNwdjj+aGSmo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=gwOieEKuQYtmfuvad1CGHIB0AyEIzLKSuQMhLAg880EX+Uyoy3GAYdsHZDhjlPsi4
	 FWmUwjweR8Qfpfev+YibwTHYfiJk5qA5KUDhfQdIrDoFroATZesePISGR51n71SiFo
	 aRFpYjV1NAjlBgmZ4MIzJYwuMAPP66ufPhxW26PDEoGIa5GVr6wWL7GvUsv0kqh1Lo
	 cxNf1dnCttcC1Hg09z4ASiidq4i+ZxUE7WVgnvG6rwcWAvuRI90Sr5lOb0FYBgnANp
	 d4g0G9MaldKmvNQKU8P6U2sWNUObdH8cd7V/4PwW3MZEkgtlEuY2oa12aernvLFTdB
	 7x8UjliRJIwqg==
From: Pratyush Yadav <pratyush@kernel.org>
To: Chenghao Duan <duanchenghao@kylinos.cn>
Cc: pasha.tatashin@soleen.com,  rppt@kernel.org,  pratyush@kernel.org,
  graf@amazon.com,  linux-kernel@vger.kernel.org,  linux-mm@kvack.org,
  kexec@lists.infradead.org,  jianghaoran@kylinos.cn
Subject: Re: [PATCH v1 1/2] kho: remove useless phys increment in inner loop
In-Reply-To: <20260807075128.542806-2-duanchenghao@kylinos.cn> (Chenghao
	Duan's message of "Fri, 7 Aug 2026 15:51:27 +0800")
References: <20260807075128.542806-1-duanchenghao@kylinos.cn>
	<20260807075128.542806-2-duanchenghao@kylinos.cn>
Date: Tue, 11 Aug 2026 13:39:25 +0200
Message-ID: <2vxzh5l051jm.fsf@kernel.org>
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

On Fri, Aug 07 2026, Chenghao Duan wrote:

> The statement phys += contig_pages * PAGE_SIZE at the end of the inner
> for-loop in kho_restore_vmalloc() is redundant code. The variable 'phys'
> is local to each loop iteration (re-assigned from chunk->phys[i] on every
> iteration) and is never referenced after this increment, so the statement
> has no functional impact. Remove it to avoid confusion during code review.
>
> Signed-off-by: Chenghao Duan <duanchenghao@kylinos.cn>

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

