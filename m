Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6218BC7EE25
	for <kexec@archiver.kernel.org>; Thu,  8 Jun 2023 05:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Z2bsZNgVE/LZkrlr9kOnKvp90ExK8mFQCD7M9fr2DOg=; b=ErwzQBiwGRL7WK
	trsB+TwP2bGt7UhR4E/hqztwUKpX7vAqsW+V0OirzQI+/0WFhyE4eDVYBcevh/saNFUJ3tvUKeMrF
	VzQvP0AG+GwT+Y4QkjnXdzvhlvQAXsNZcj2P4w01vXYr9Pg397GFzKuS+QrmLbghN8zjk7I7orpgZ
	ZiT2zkJXU6z9J9pRv4MV9rQQz1Q4RDvdBtIBU5IT0fZesoq12rK2JeuVJrAfOkmgbP5bVxOCCvkyT
	xQV6lXZ2B59obMTe17es2yJU9XgOSrK8H9LH4RxtZu/XW6h/Z1qqqsk0v5Ut0/vyjr6qqVA+Wv5MX
	OeK8JOl5TwmabA+Q8zSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q77qG-008794-2K;
	Thu, 08 Jun 2023 05:05:48 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1q77qE-00878e-2Q;
	Thu, 08 Jun 2023 05:05:46 +0000
Date: Wed, 7 Jun 2023 22:05:46 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: hch@infradead.org, djwong@kernel.org, sandeen@sandeen.net,
	song@kernel.org, rafael@kernel.org, gregkh@linuxfoundation.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, jikos@kernel.org,
	bvanassche@acm.org, ebiederm@xmission.com, mchehab@kernel.org,
	keescook@chromium.org, p.raghav@samsung.com, da.gomez@samsung.com,
	linux-fsdevel@vger.kernel.org, kernel@tuxforce.de,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] fs: add frozen sb state helpers
Message-ID: <ZIFhqk6VElD6qXBU@infradead.org>
References: <20230508011717.4034511-1-mcgrof@kernel.org>
 <20230508011717.4034511-3-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230508011717.4034511-3-mcgrof@kernel.org>
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

On Sun, May 07, 2023 at 06:17:13PM -0700, Luis Chamberlain wrote:
> Provide helpers so that we can check a superblock frozen state.
> This will make subsequent changes easier to read. This makes
> no functional changes.

I'll look at the further changes, but having frozen/unfrozen helpers
that sound binary while we have 4 shades of gray seems rather confusing
to me.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
