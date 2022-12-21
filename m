Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45A9DC4332F
	for <kexec@archiver.kernel.org>; Wed, 21 Dec 2022 20:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=X3J2WitD/NDAdZQSGiJHNk1qQXSP5srN4qArsJ247hQ=; b=NXRCSGMKKKsyNU
	OUC8N4iVsTFQmYC6vd8a4Onlat34oh328YM5Cn1+4NeNYQ710AtAXPNXjiZDgCS617WR3HvfjW1nI
	9x1cwyEiglOyU2N4YajXxIjYwzMwYBSxSolgDv5SalIOHDX7JGD5FROKOLZoHchXNKAgyX90ZE2Z9
	+fx2uXCaCO19Y1PGjFrouTEFGvYzgHE3+fDVJkznLXDrTemp3A7meHjlex+Sdo5PRAN/Ub4ZhMgJ/
	NK7MU2shHRyOWfit5BvtIGXjf9NdUzHG+ns+o8xjof+UqsyXNU5vhFewm+i4K44BwD++oRlb1c/qn
	mqOzrWYWn1geixwEnKmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p85Xw-001u9p-3E; Wed, 21 Dec 2022 20:18:36 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p85PF-001kzG-OK
	for kexec@lists.infradead.org; Wed, 21 Dec 2022 20:09:39 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id B6EEF61900;
	Wed, 21 Dec 2022 20:09:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEF4AC433EF;
	Wed, 21 Dec 2022 20:09:34 +0000 (UTC)
Date: Wed, 21 Dec 2022 15:09:32 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Ricardo Ribalda <ribalda@chromium.org>
Subject: Re: [PATCH v5 0/3] kexec: Add new parameter to limit the access to
 kexec
Message-ID: <20221221150932.02cecdd3@gandalf.local.home>
In-Reply-To: <20221114-disable-kexec-reset-v5-0-1bd37caf3c75@chromium.org>
References: <20221114-disable-kexec-reset-v5-0-1bd37caf3c75@chromium.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221221_120937_869537_0D632588 
X-CRM114-Status: GOOD (  12.58  )
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
Cc: linux-doc@vger.kernel.org, Sergey Senozhatsky <senozhatsky@chromium.org>, Philipp Rudo <prudo@redhat.com>, Jonathan Corbet <corbet@lwn.net>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, Ross Zwisler <zwisler@kernel.org>, "Joel Fernandes
 \(Google\)" <joel@joelfernandes.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Wed, 21 Dec 2022 20:45:56 +0100
Ricardo Ribalda <ribalda@chromium.org> wrote:

> Add two parameter to specify how many times a kexec kernel can be loaded.
> 
> These parameter allow hardening the system.
> 
> While we are at it, fix a documentation issue and refactor some code.
> 
> To: Jonathan Corbet <corbet@lwn.net>
> To: Eric Biederman <ebiederm@xmission.com>
> Cc: linux-doc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: kexec@lists.infradead.org
> Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
> Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ross Zwisler <zwisler@kernel.org>
> To: Philipp Rudo <prudo@redhat.com>
> To: Guilherme G. Piccoli <gpiccoli@igalia.com>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
