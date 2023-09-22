Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B559CE7D0B8
	for <kexec@archiver.kernel.org>; Fri, 22 Sep 2023 00:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Message-Id:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zirg1Fuht9xkE46JSuQ7YTJDUal9GaC/fSEaxIUOCl8=; b=dJLF7QCJNVA9YH
	v4xHvYZxvFU7FS47qYjLOYf8Tz7hHHWntfDwIeA7Ko9EDs9JnFmGklCdbnSqONfbgbU1iHInyd841
	Lfyq93415vMkgmNUHU1WY6VMhojGm9TWtGncUrcNfCBL6znNm8fPKRH0WoeA/mUmmqHiZJpMWNzf7
	QpS0aVuWt2mw0wAy2seQBylrtJ5An8UyJNGutw/LdEnXWH0Yo9OQL9gcx6P1Hd4cQfGzBabHqhnIi
	M4z8Ac7D/Ur2/INTfcGFzcD8VURCzvCursP+nJtOlvg5mlcoLsyq6GNX75Js6Lt5+My1jLyDqF+8O
	yHAoC6SQ2QkjnuJOyqUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qjTwZ-007Spt-0L;
	Fri, 22 Sep 2023 00:22:51 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qjTwW-007Sof-0c
	for kexec@lists.infradead.org;
	Fri, 22 Sep 2023 00:22:49 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by sin.source.kernel.org (Postfix) with ESMTPS id 18D61CE1A26;
	Fri, 22 Sep 2023 00:22:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEF1EC433C8;
	Fri, 22 Sep 2023 00:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1695342164;
	bh=5Y1dSArHCMohqCCw0o+1oDIRhU1jcUN2P68mhAF6WFk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FeJ3OJitd872v1C/2Uyd7XFKUmhWDaw0zhm25WIny4fOvHZpqhhmO5v43lXKFE5+x
	 TIIrvH9ch66DY6PZDUcWLBovkJR7K7H0exdUOk9/44MV820WpWDBdvXQGu22PftktX
	 3TSb5VzLlMZZZfRx+M39E3Hmvxe8+siE/7QSS5Tc=
Date: Thu, 21 Sep 2023 17:22:43 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Eric DeVolder <eric.devolder@oracle.com>
Cc: linux-kernel@vger.kernel.org, bhe@redhat.com, vgoyal@redhat.com,
 dyoung@redhat.com, ebiederm@xmission.com, kexec@lists.infradead.org,
 sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
 boris.ostrovsky@oracle.com
Subject: Re: [PATCH] kexec: change locking mechanism to a mutex
Message-Id: <20230921172243.d86a649d7afc835ff2caac26@linux-foundation.org>
In-Reply-To: <20230921215938.2192-1-eric.devolder@oracle.com>
References: <20230921215938.2192-1-eric.devolder@oracle.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230921_172248_403447_CB58C6BB 
X-CRM114-Status: GOOD (  11.33  )
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

On Thu, 21 Sep 2023 17:59:38 -0400 Eric DeVolder <eric.devolder@oracle.com> wrote:

> Scaled up testing has revealed that the kexec_trylock()
> implementation leads to failures within the crash hotplug
> infrastructure due to the inability to acquire the lock,
> specifically the message:
> 
> ...
>
> Convert the atomic lock to a mutex.
> 

Do you think this problem is serious enough to warrant a backport into
-stable kernels?  

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
