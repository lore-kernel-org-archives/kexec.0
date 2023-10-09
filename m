Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C924E95A91
	for <kexec@archiver.kernel.org>; Mon,  9 Oct 2023 14:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ovtnywU9gsMol7AdF1Nl9TL8YBA94zJQHTNS8UTqvpA=; b=a881issCl2tdar
	vvqUsX3VcAYPat9K79/vy8EfSvSp1Wo5UgLsOuKc/+2GH2qEaLM79e5RZ8WYrD8iP7md4u7Em9KrP
	ksoJQAxIGjTDNXlZBbhGe/oURmO3/8KET80D8btr0/bcu5OzEc7YeUV2cDHICIYTbg5F855rbTsmy
	6THBuDpEfl98Fg4Lqb371VchtJM7D/VgNGE+MAy9sh9Ug4TB4H2kX2drDM+ZJnpS43sTn9v6uysnB
	2RDmeiUgHwTstmU36XfG0aFN24ZNkFMWgJSVPb18ixCu/nm3X3QMLNy/Y+muxbVMJLdrI9Zo2MiN0
	IEQYzgCxo/bpyBUXGLDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qpqoQ-00AsP4-0L;
	Mon, 09 Oct 2023 14:00:46 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qpqoN-00AsNQ-2m
	for kexec@lists.infradead.org;
	Mon, 09 Oct 2023 14:00:45 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 1CCCFCE111C;
	Mon,  9 Oct 2023 14:00:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33379C433C8;
	Mon,  9 Oct 2023 14:00:37 +0000 (UTC)
Date: Mon, 9 Oct 2023 10:01:55 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
 linux-kernel@vger.kernel.org, Ricardo Ribalda <ribalda@google.com>, Ross
 Zwisler <zwisler@google.com>, Rob Clark <robdclark@gmail.com>, Linus
 Torvalds <torvalds@linux-foundation.org>, kexec@lists.infradead.org
Subject: Re: [PATCH] kexec: Fix reboot race during device_shutdown()
Message-ID: <20231009100155.6d71490f@gandalf.local.home>
In-Reply-To: <CAEXW_YQ3YZExYb6FLg3fvWr9K+FGgNQx7xk3p-PngLG6rt8Ntw@mail.gmail.com>
References: <20230929021213.2364883-1-joel@joelfernandes.org>
	<87bkdl55qm.fsf@email.froward.int.ebiederm.org>
	<CAEXW_YQ=HGok600ARtCKBNDs1OHSc=UM4hWmBdQ=sXZvif0Z5g@mail.gmail.com>
	<CAEXW_YQ3YZExYb6FLg3fvWr9K+FGgNQx7xk3p-PngLG6rt8Ntw@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231009_070044_099037_BB19AFFD 
X-CRM114-Status: GOOD (  10.44  )
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

On Sat, 7 Oct 2023 21:30:42 -0400
Joel Fernandes <joel@joelfernandes.org> wrote:

> Just checking how we want to proceed, is the consensus that we should
> prevent kernel crashes without relying on userspace stopping all
> processes? Should we fix regular reboot syscall as well and not just
> kexec reboot?

If you can show that we can trigger the crash on normal reboot, then I
don't see why not. That is, if you have a program that does the reboot
(without the SIGSTOP/SIGKILL calls) and triggers this crash, I think that's
a legitimate reason to fix it on normal reboot too.

-- Steve

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
