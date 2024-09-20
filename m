Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BE24CF58E4
	for <kexec@archiver.kernel.org>; Fri, 20 Sep 2024 07:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Date:Message-Id:Subject:Mime-Version
	:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=3ANJjc2wn0ubW7G5k+YC8LU9drk0xk0xTWj7kfFccNE=; b=BaKFfoJd16dDF0
	7wr9F4NpRuhykPpBhXhXbKDWmtiiVEg5IaO7Yd+Re0Ib6fGPTm5uy2ZrFp0ZOdiXdxbhFeb6g/gkb
	GIhSPH7skmtvfd8z3jea6W7Sme1qyCGi45ugl4ejj+pVWElAzjyV4PblV8/uObWtQmDeHCpLloRcy
	T3TD4I0oELyzXue0asMIiBvCLh+m8m4VraTGwXo9dWjuqLuM4MLxszmDkwTrkv47jJoB8PPEijIv9
	hRl1fTayISwesoJdgMpXHaogtY7bviLtOMgNYhKmZ2W8j7s9BnmKQoLRE8LQRev4i5bWE4wF95Euf
	h5UOHXO74HpN7wbmAypQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1srY98-0000000Bd8q-0cpN;
	Fri, 20 Sep 2024 07:33:42 +0000
Received: from dediextern.your-server.de ([85.10.215.232])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1srY7i-0000000Bcze-3xSl
	for kexec@lists.infradead.org;
	Fri, 20 Sep 2024 07:32:16 +0000
Received: from sslproxy04.your-server.de ([78.46.152.42])
	by dediextern.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <martin.friedrich@hetzner-cloud.de>)
	id 1srY7b-000Kui-IE
	for kexec@lists.infradead.org; Fri, 20 Sep 2024 09:32:07 +0200
Received: from [2a01:4f8:0:a0a7::1002] (helo=smtpclient.apple)
	by sslproxy04.your-server.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <martin.friedrich@hetzner-cloud.de>)
	id 1srY7b-000PtD-2f
	for kexec@lists.infradead.org;
	Fri, 20 Sep 2024 09:32:07 +0200
From: Martin Friedrich <martin.friedrich@hetzner-cloud.de>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: makedumpfile fail to strip pages
Message-Id: <164F5E03-EB17-451A-810F-58962BBC53B2@hetzner-cloud.de>
Date: Fri, 20 Sep 2024 09:31:56 +0200
To: kexec@lists.infradead.org
X-Mailer: Apple Mail (2.3818.100.11.1.3)
X-Authenticated-Sender: martin.friedrich@hetzner-cloud.de
X-Virus-Scanned: Clear (ClamAV 0.103.10/27403/Thu Sep 19 10:44:20 2024)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240920_003215_001568_F1909EB3 
X-CRM114-Status: UNSURE (   6.57  )
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

Hello,

I try to identify the root-cause of an issue with kdump & makedumpfile which results in dumps to have a size of the system memory.
Kdump-tools/makedumpfile has been configured to strip most pages with the flags: " -c -d 31" and transfer the dump to an ssh target.

I'm unable to replicate the issue by crashing kernel using sysrq-triggers. As long the system crashed by sysrq-trigger, the dump has the correct size and completes successfully. 
But as soon a system crashes for other reasons, dumps get huge and fail to transfer to the ssh target due to their size.

Our servers (x64/aarch64) are running Ubuntu 22.04 with a self built kernel 6.6.32 (config attached) and makedumpfile (backported 1.7.5-3 to Ubuntu 22.04).

Am I missing something within the kernel config which could cause this behavior?


Thanks
-- Martin
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
