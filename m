Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B81C7C7EE25
	for <kexec@archiver.kernel.org>; Thu,  8 Jun 2023 20:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8NZeh4xwex3ttoUSa7C6jy+2YOSt7UgX5YIK1fQwp4s=; b=dkfTRLrEVnNqLf
	rQd8NWlx2g91AqevXxLjVxnfRiIVI1lGmMyL0IEo+VOT9ZtQL3wKPPa2C3n/JwRx4JDGnnDfV2Ah3
	RBvBZl+OINnt1u/s+dhJCJmdTwV6AVc7SOdsKRKGKqiau/1kwPK/32A1RCmrJxI+e70/UJBHO9sGV
	jShXMAQqKOkAgTsmk2KbJNvw4Yk1xJYZ1RCOOdmIAZoYX/3mFTHow9cYeGTmi3uaUZv1/FW96js6J
	0Oij5aRrVnJvofrJTbfjn2nDCoROmCMn4/qzoZ0CMSZr9bii/nzFnw9ANH5Z9WPyFmP/F2m2hM14T
	Ea05AuG+LV7esXeI1fEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q7MHX-00AYc6-2L;
	Thu, 08 Jun 2023 20:30:55 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1q7MHW-00AYbl-0q;
	Thu, 08 Jun 2023 20:30:54 +0000
Date: Thu, 8 Jun 2023 13:30:54 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Jan Kara <jack@suse.cz>, hch@infradead.org, sandeen@sandeen.net,
	song@kernel.org, rafael@kernel.org, gregkh@linuxfoundation.org,
	viro@zeniv.linux.org.uk, jikos@kernel.org, bvanassche@acm.org,
	ebiederm@xmission.com, mchehab@kernel.org, keescook@chromium.org,
	p.raghav@samsung.com, da.gomez@samsung.com,
	linux-fsdevel@vger.kernel.org, kernel@tuxforce.de,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] fs: distinguish between user initiated freeze and
 kernel initiated freeze
Message-ID: <ZII6fho7ULpY+Eav@bombadil.infradead.org>
References: <20230508011717.4034511-1-mcgrof@kernel.org>
 <20230508011717.4034511-4-mcgrof@kernel.org>
 <20230522234200.GC11598@frogsfrogsfrogs>
 <20230525141430.slms7f2xkmesezy5@quack3>
 <20230606171956.GG72267@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230606171956.GG72267@frogsfrogsfrogs>
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

On Tue, Jun 06, 2023 at 10:19:56AM -0700, Darrick J. Wong wrote:
> Luis hasn't responded to my question, so I stopped.

Sorry for the delay, by all means alternatives are hugely
welcomed. I just worked on it as it was back logged work and
not a high priority thing for me, so I try to get to it when I
can. Having someone with more immediate needs give it a stab
is hugely appreciated!

  Luis

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
