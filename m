Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0691EC636CD
	for <kexec@archiver.kernel.org>; Tue,  7 Feb 2023 15:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=keAqNpSooVOEnAWYVOAKcmFN+gg5CiPR471nJY2RIL4=; b=BVlVZo7smbjcpe
	rofSSyY/8WUJS8ohAzQfUxh9ppG9d6/gKQCBaTGbevVlQ05EQGow6pPHDmQCwDcC5NZ7gFk3LQbgY
	majneyCCjguMrIaAn+U8bVVD2og+TyNq55d2J57jdmCFViAnwULS4uPVZy4lrHs5LIi+LxsM/gFI9
	kz4ofMHVXhabapv+e/t8ytJiw2TndIeV2kABTSbdA8fO2EvBCxXtAae3+Uk8KMzIllWeSwVGSeS9U
	8bLtXDUNqOD5Ag7rE1Js+r911G0aulMKADsFx5w5QaZYzkB2DkZBiYlvPTRetLgxmq7HM7U+Araho
	W6FFySagqLFoEEognXbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pPPZj-00CcbD-Jz; Tue, 07 Feb 2023 15:08:03 +0000
Received: from zeeaster.vergenet.net ([206.189.110.174])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pPPZd-00Cca1-C0
	for kexec@lists.infradead.org; Tue, 07 Feb 2023 15:07:58 +0000
Received: from momiji.horms.nl (86-93-216-223.fixed.kpn.net [86.93.216.223])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by zeeaster.vergenet.net (Postfix) with ESMTPSA id 955982013E;
	Tue,  7 Feb 2023 15:07:49 +0000 (UTC)
Received: by momiji.horms.nl (Postfix, from userid 7100)
	id 23AA09404F6; Tue,  7 Feb 2023 16:07:49 +0100 (CET)
Date: Tue, 7 Feb 2023 16:07:49 +0100
From: Simon Horman <horms@kernel.org>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: kexec@lists.infradead.org, hbathini@linux.ibm.com
Subject: Re: [PATCH] ppc64: add --reuse-cmdline parameter support
Message-ID: <Y+JpRdQ81Mt57EPK@vergenet.net>
References: <20230201085331.1004355-1-sourabhjain@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230201085331.1004355-1-sourabhjain@linux.ibm.com>
Organisation: Horms Solutions BV
X-Virus-Scanned: clamav-milter 0.103.7 at zeeaster
X-Virus-Status: Clean
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230207_070757_600010_CA66218B 
X-CRM114-Status: GOOD (  10.35  )
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

On Wed, Feb 01, 2023 at 02:23:31PM +0530, Sourabh Jain wrote:
> An option to copy the command line arguments from running kernel
> to kexec'd kernel. This option works for both kexec and kdump.
> 
> In case --append=<args> or --command-line=<args> is provided along
> with --reuse-cmdline parameter then args listed against append and
> command-line parameter will be combined with command line argument
> from running kernel.
> 
> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
