Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040DC606A32D
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 13:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=EGWa82nl;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mIrbZaDl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=EZAUQMhN3rMe7FCapRNk/7rrtwkPUHUoi09OPENdnHg=; b=EGWa82nlxNOeZ4gxVLu14nsDHc
	lsWUlsn4TDcAD6sgmdHqM3CFWcXTvEjGQ8hgsbHgzPhesKzOtLSAoJmU4ZGxnh3+fCZ+INbOgbUbQ
	sJWbFk+alCfSra3QE7GW7L970197RMHcqkhbiSCGyu9aQvFo/4ZZSy5v3/+7AW17VmbOBnaxPiyIk
	ZRDXxbBoZv5t59n+jD5lDojzyka4vmQNsXp1S+DLmHIOXgOOlHY2NAZpQ8Xe4nQxQOsV5sL2KI0sj
	ipI1uaif0NqD6jrQqsX/nhShNf1BVkOdEJxFAfUoJywR4oWPx64tOF6gwBkI3hw+BQde2TtWS31Y7
	6e7YWNdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xObEP-00000005V9w-2vP8;
	Wed, 04 Nov 2026 13:40:49 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xObEO-00000005V9q-4Bep
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 13:40:49 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 87C9F41A33;
	Wed,  4 Nov 2026 13:40:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 263761F000C1;
	Wed,  4 Nov 2026 13:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793799648;
	bh=EZAUQMhN3rMe7FCapRNk/7rrtwkPUHUoi09OPENdnHg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mIrbZaDlsoXr337Dd1aQvpZtyvWkUbui9aNsdGO39rnOez9/LC9vHEkL6oLEMmOjM
	 5ZS/EHVquAEEDjPxCrKhN3kshP7TS3JrO7w5Z0n0AQEv2MP6imfd5lntHJRp9EEZzU
	 AO1b/xidJ4xZJiAUB8EK5i2yqdQFoIbjV2rlSzG1AWl8xYdHcII+CrKkb2amyd2Tgn
	 siqgy24+C2iDDSdGuvES7WbPh2sAvX4J3wa6ToVDiYzL70KuyKjQ1uvZiShbArseLU
	 OZvXeGJ81KpgtvCcDjm84M+yrDFCeHPphdgMb/Wl3mb7UkVZo1aN5xTbwtXqV3KT5q
	 Uk3jtazUmpszg==
Date: Wed, 4 Nov 2026 15:40:42 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v10 00/13] PCI: liveupdate: PCI core support for Live
 Update
Message-ID: <aus12iOdLyiIiywZ@kernel.org>
References: <20261013162529.1928093-1-dmatlack@google.com>
 <179373348545.623992.16522569527665218421.b4-ty@b4>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179373348545.623992.16522569527665218421.b4-ty@b4>
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 03, 2026 at 02:21:10PM -0500, Pasha Tatashin wrote:
> On Tue, 13 Oct 2026 16:25:16 +0000, David Matlack wrote:
> > This series can be found on GitHub:
> > 
> >   https://github.com/dmatlack/linux/tree/liveupdate/pci/base/v10
> > 
> > This series introduces support in the PCI core for Live Update, enabling
> > drivers to preserve PCI devices across a kexec-based kernel update
> > without interrupting the device. This functionality is critical for
> > minimizing downtime in environments where PCI devices (e.g., those
> > assigned to VMs via VFIO) must continue operating or maintain state
> > across a host kernel upgrade.
> > 
> > [...]
> 
> Applied, thanks!
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git/log/?h=lu-pci-preservation
 
And luckily we have a few weeks chase Bjorn and Alex for Acks ;-)
 
> Best regards,
> -- 
> Pasha
> 

-- 
Sincerely yours,
Mike.

