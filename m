Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71444C77B7C
	for <kexec@archiver.kernel.org>; Mon,  8 May 2023 01:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ijh3nOoPjvZ0rRvjhRjjsBGHfFW+np8ZYSuaYAU+ICY=; b=sz36zi9ZCp67Fh
	utWU/9iVehj4QL1ZCQlxXgcTVQmURqirRN/S/K7LYIShnoAyWQCQOJaxyg0ZAqen5jZZPupXCXCon
	4wYiavTmAhoOX8MXCf+TgdAo8MAI8rQXvXU+kVdv5cxKRd2G8GcAwiY9g8s9Eg4TW2Q2GSZoHO7/N
	gWbahsNvNJjjc1A08xmOiWC4abG2DjxMjV/ogCc3kcAzoBPIiXooYDXvpCqrwaXopPnaHrkLOHY2B
	Z3HckfYiQ/eO0ienGa/W5RHVTmF5OOo58KcAAvUgWokWowd0LyXt2ueqJg0glf26Zn3qx+vWuKQdQ
	B12ZmtSGAFb9GruJS+Bw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pvpYi-00GwTV-2E;
	Mon, 08 May 2023 01:21:00 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1pvpYi-00GwTG-0k;
	Mon, 08 May 2023 01:21:00 +0000
Date: Sun, 7 May 2023 18:21:00 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: hch@infradead.org, djwong@kernel.org, sandeen@sandeen.net,
	song@kernel.org, rafael@kernel.org, gregkh@linuxfoundation.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, jikos@kernel.org,
	bvanassche@acm.org, ebiederm@xmission.com
Cc: mchehab@kernel.org, keescook@chromium.org, p.raghav@samsung.com,
	da.gomez@samsung.com, linux-fsdevel@vger.kernel.org,
	kernel@tuxforce.de, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] vfs: provide automatic kernel freeze / resume
Message-ID: <ZFhOfEVAzNu9BPpw@bombadil.infradead.org>
References: <20230508011717.4034511-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230508011717.4034511-1-mcgrof@kernel.org>
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

I forgot to mention if you wanna test on a git tree:

https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git/log/?h=20230507-fs-freeze

  Luis

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
