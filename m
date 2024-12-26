Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32378E77188
	for <kexec@archiver.kernel.org>; Thu, 26 Dec 2024 11:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:
	To:From:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=lwV7aSIhmL1J4zqGd6QcK0kku1jHwWFZZp7wr11vEIE=; b=nL37VqmA8kE260
	ONpTL8tapChysFnlSQ/FxWuTrVFu1gQLTVuUrOsyMqw/KCTuAfOub75aK7hamXbjWfgQ9Lk5F5vOQ
	RmO76JEVilrkx1ox1fWEsE0r6rSwM5VUiDMSd0gDGJRQf1jKCxFBePA3d6FQtxkc7LQ+9Qy9Q3rMN
	vdvoJqj9Gj7gFMjcOOsX1/qHC12LLU6ll5eTsAwc7ddFaJEe9rN0kWLv/nNOz424Uon+MsXICU5V0
	Fw5i0+1mkcJO3PZ4Y2TOm+npaOT7mLLCkrVTEtujo9B/pFse4CKHH4CDMEKq039kASMV8s/b0KLmI
	79YOphYQFjfbAubMr0fA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tQlrz-0000000Ffw7-341k;
	Thu, 26 Dec 2024 11:17:35 +0000
Received: from 217-110-162-10.ptr.prolan.de ([217.110.162.10] helo=smarthost-3.prolan-cloud.de)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tQlrv-0000000Ffvd-3DEf
	for kexec@lists.infradead.org;
	Thu, 26 Dec 2024 11:17:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tautiimagheraus.ro;
	s=default; t=1735201319;
	bh=lwV7aSIhmL1J4zqGd6QcK0kku1jHwWFZZp7wr11vEIE=;
	h=Reply-To:From:To:Subject:Date:From;
	b=UluUC7XUNV1YdSBo3T8NlohumBR9cWWD2Hi/d+jKvO0o+8HN7hGWkuAQsLUYGa+eQ
	 Wwd50L+1+2VY2eCMxIxd9urH7Z05ezgTwkJgOUEQG1PZmRiQhyiDhZUPv93HdIrR/6
	 vOVfrflOt+Mtmrh3M89XtsXFTYqf9Tr7FDrLFbPWry+FOtzXcd6Ebr0PZ+VK0Ufc0L
	 0R+5YxC0QQlsPM2bb628Lzn5DyF7MWmna2brEny2gGloSEWCR5BgCLXRKJJcL9+qsK
	 GFHh7oJJaUOnfp1qJluzo7FRsrbgf468w/hqPzUrr97eKdCKIWvEns2HyIfBN6tLk9
	 SKz1Jo225dIMw==
From: Kazi <proiecte@tautiimagheraus.ro>
To: kexec@lists.infradead.org
Subject: Business request
Date: 26 Dec 2024 09:21:57 +0100
Message-ID: <20241226092157.D4CB04B5531B50FB@tautiimagheraus.ro>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241226_031732_254955_DCD44413 
X-CRM114-Status: UNSURE (   1.09  )
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
Reply-To: admin@bceao-tg.org
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Compliment of the Seasons

It is with great sincerity and concerns that I address this email to you.=
=20
I have contacted you in the past regarding this project partnership but you=
 didn't reply the email.=20
Did you get the chance to see the email?

Looking forward to your positive response.=20=20

Best Regards,=20
Kazi

