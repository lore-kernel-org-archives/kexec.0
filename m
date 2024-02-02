Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34BFAC47258
	for <kexec@archiver.kernel.org>; Fri,  2 Feb 2024 08:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=M4iWCfXM9l39t7TgUp0ezFA17NgOPgSP4vL1yQ9yhDU=; b=KA1B8ZRhG0saL6
	z+YypS5XL1a6/0YF4cAfAjqzXu5K+bQ2WjYkpJMndykbiUKvj6aAWhXJTMMd4oUpqKsGlKE77Krsk
	I9zhizUN4DdBca3ROmVh7fjmdqjdjDX42o1/1E7fxHWRjDjo+5YOXzi6euP7f/oNrHrN9RYq8vhL8
	aOLiY0nInxI4j8G6pjLsGn68ZVmcgaM4A31eqVhBpTDM1zZ6NoAz8ZtdRIiNXR++vUtP5B55Wqui7
	k/zDkdib8D2AOSmxY61XUF16kQ3VjOc1lmBXRpeYaXPUZ0IKLtNNPP5X5P/9x9erPd6r6hocAvy+l
	nazygwab4mieBF0Y+4NQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVpMc-0000000ArLE-3Psh;
	Fri, 02 Feb 2024 08:57:34 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVpMZ-0000000ArJR-3MtA
	for kexec@lists.infradead.org;
	Fri, 02 Feb 2024 08:57:33 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 3B0316142A;
	Fri,  2 Feb 2024 08:57:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36180C433C7;
	Fri,  2 Feb 2024 08:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706864250;
	bh=zkU6RU0S3S9ovyugcOOkgSf9RaxY56HF6JpYXNVL1k8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dpeptGlxkIrbVK442R2naW8AMLZ9uGmpxyFtNPouCAPrKJMrhDB/TE6CyS507EDeK
	 rGln5dlk0YB7g/LydUJCUBgPZwNceZWRIIivt6bvUK0PbSIFbJzYQS1Y4VALmspeWt
	 yGKLVbMs1QGRFUnIA1u7xrF1g1YnsWo3SbldxViYzCH4nFfz0ES1cYNMcwIX53iA5p
	 vLOE89jNz3LZZ/kL39x2iVO5y21d+WSaItkOFbLCpt1oEegroFXt+Gd8jzvJllexqa
	 4q3lYlxgAjSQw5iRRtpcALGCQtB7/DejTbm68K+92AJ97ExWk541vZOinj1A2y4+tc
	 STWL5SMydTBHA==
Date: Fri, 2 Feb 2024 09:57:27 +0100
From: Simon Horman <horms@kernel.org>
To: Baoquan He <bhe@redhat.com>
Cc: Coiby Xu <coxu@redhat.com>, Michel Lind <salimma@fedoraproject.org>,
	Sergei Trofimovich <slyich@gmail.com>, kexec@lists.infradead.org,
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH] kexec-tools: purgatory: fix build on `binutils-2.42`
Message-ID: <20240202085727.GJ530335@kernel.org>
References: <20240131100508.2013016-1-slyich@gmail.com>
 <ZbopWV9qrxMME2hU@MiWiFi-R3L-srv>
 <ok66kbhzu2xczopdsjhjuedt2h3snt3omjc3jlzbs3ujo6ra75@bu3mvwtuveck>
 <ZbxspulHDxpmHs0W@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZbxspulHDxpmHs0W@MiWiFi-R3L-srv>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240202_005731_913051_E68B0DA2 
X-CRM114-Status: GOOD (  13.42  )
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

On Fri, Feb 02, 2024 at 12:16:38PM +0800, Baoquan He wrote:
> On 02/02/24 at 11:01am, Coiby Xu wrote:
> > Hi,
> > 
> > FYI, before this patch, Michel already sent "[PATCH] Fix building on x86_64
> > with binutils 2.41" to address the same issue. Currently I almost know
> > nothing about
> > assembly but Michel's patch seems to be more complete because two more
> > files are touched.
> 
> Thanks for telling, I didn't notice that one. I didn't know these
> either, leave them to Sergei and Michel to decide what is the
> appropriate solution.

Hi,

I did go ahead and apply Michael's patch.
Let's follow-up with incremental changes if necessary.

...

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
