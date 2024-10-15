Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 784D4D216A3
	for <kexec@archiver.kernel.org>; Tue, 15 Oct 2024 13:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ydOyTWtfBFBeHZZZy2ljeqV3STE9YL9bLt3lqj3gMkQ=; b=jpw1fMxpNhEoCw
	ddOY3XMqUjcSczAyitWbp/9xLqPYNtUUhKiHWYiAlEgWGRAHeRMt0IW6yPby3t0fNGSv9lWQ5kX0e
	PgZkooTXu/FrlV2/wKS/ZRz2SS/IJNwmlzOwLCi3gHgq7VV8G5DzYXTFYshRFQC+Nssi2ntMqaP1T
	oju6H9+2D8TGor7UxQVNumaqMVaYe2OSShljegSNGkAkI0ZrZ06i1y7ymSwrRSgSN/JbL4NYIRzhx
	QphOGdUrhyF/cbu4kcnst9Yv2zx+6RprbHwWTZIp8Zx4/X/iSNGYfXGwSLa2X2IwNlCmpViX904g1
	y+4xbn+8PR79JJ8s7P+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t0haW-00000008Lg2-2KPf;
	Tue, 15 Oct 2024 13:27:48 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0hZ8-00000008LV0-0DeS
	for kexec@bombadil.infradead.org;
	Tue, 15 Oct 2024 13:26:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+rlyZbbmuXKpzki+hm0O/GKWF2xV1b5/9C3CwWaeRfg=; b=VGZnZQZFjv/mBPoNzSDEh9qHjK
	H6rO2bB+dVrmShIsh4YKCwRa8ZqyBfP4uSLfZgxTnLX3MhhFyNF1hMpgIaYcmxvarKss9AqVUiOoT
	DywHOYsp+wuRlfXrThamghoS+bZrwyoPJJGfaMweCLtwbgBpBbF+2Zx4Fy0PhtW807/7RH5vsgsoo
	ToK3emKzVCC0As7L9ydihvbeSaqKqRaMkfaiXo1lqToTgPBRg3a9jaSG+El3JGY5oZVNO4MXCV14d
	JVgare5EvEhpRe+Xjl/i8smOVJayZN2GLlxcHCwJzFL0l2Weu4IyvTzxT0lIPNOTnhBphe07z/zCN
	0OqeKS7g==;
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0hZ4-00000006ZeF-2WhM
	for kexec@lists.infradead.org;
	Tue, 15 Oct 2024 13:26:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id D67FCA4191C;
	Tue, 15 Oct 2024 13:26:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC786C4CEC6;
	Tue, 15 Oct 2024 13:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728998774;
	bh=1s6PuggFG+x9InYwshnxVpcwJbt9KQq7Ef+sMZ3tcME=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TrhVlDFY1AMgCLzdY26FwT3rIVDTLAr1oxC3t5pJcmr3YjJR7sadYeukfLMiTyj5L
	 w6VqgZ0NC5BzewXxJq0qiSzVGQprETEx5vO6hbh/YS0Mw2xV5+0amDSr34tnLbsArU
	 4D5iFy6wExeZ0ESYMlh+ssng+6hjyoyni/t1P1doxlkkDBkp6c1Abxnd8oJLCSwKk4
	 ojOjcO1z6DbEfV+haqkYr9Ib1h52NIsvo6qGHF2wPsEzT02uT32shpseVkt4hb4Vt5
	 cJYp3FReaNqAHuN3rXjSpsHmxRCExNd3phNNmSLnuH4ig1d9Izman1p3KX35oBdD0g
	 mWiXh8/Qd/Prw==
Date: Tue, 15 Oct 2024 14:26:10 +0100
From: Simon Horman <horms@kernel.org>
To: Pingfan Liu <piliu@redhat.com>
Cc: Eric Biederman <ebiederm@xmission.com>, Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>, Ard Biesheuvel <ardb@kernel.org>,
	Jan Hendrik Farr <kernel@jfarr.cc>, Philipp Rudo <prudo@redhat.com>,
	Lennart Poettering <mzxreary@0pointer.de>,
	kexec@lists.infradead.org
Subject: Re: [PATCH 2/3] kexec: Introduce UKI image parser
Message-ID: <20241015132610.GA2162@kernel.org>
References: <20241008115408.21944-1-piliu@redhat.com>
 <20241008115408.21944-3-piliu@redhat.com>
 <20241011084406.GB66815@kernel.org>
 <CAF+s44QMLaQLmm6cst+o2Ssgi2v-SBXcw3hE1kKTFnL7DmoLFg@mail.gmail.com>
 <CAF+s44QRNpBrRuJsuVwvZduHTLhEFTtUz3fU5=4YNAn8sbBccw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAF+s44QRNpBrRuJsuVwvZduHTLhEFTtUz3fU5=4YNAn8sbBccw@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241015_142618_823998_1564A628 
X-CRM114-Status: UNSURE (   9.18  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Mon, Oct 14, 2024 at 10:43:34AM +0800, Pingfan Liu wrote:
> Hello everyone,
> 
> I have created V2 and make a PR: https://github.com/horms/kexec-tools/pull/9
> 
> Due to utilizing the workflow in github to have some basic checks
> automatically , I migrated it to github instead of mailing-list.
> 
> Please share your opinions.

I appreciate you making use of GitHub,
but please post patch submissions using the email workflow.

Thanks!

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
