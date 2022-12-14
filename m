Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FBACC4332F
	for <kexec@archiver.kernel.org>; Wed, 14 Dec 2022 00:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OLlknC66HKy1yQVYs2Kdv8svr5PbJfi8R09NoGwt20M=; b=RoSM444XXBHeTY
	Dgo0H2au/Nj1bjvkd+FsTchrsDfkttoy7PdSQg2lq70Mi0MSmwSFgq00IZTA1T1DE9reKzlg12vPw
	ecIzPenLuFAWTE7/ZF6EUvVv8wZ7Y7F9LsmV61Qo9ElWlyVOFv2GOOhJrfWIPOaj64NaYh10A/aCG
	w6yy553DoOmfb7aBpIiCXaKLzAIlY/oI7CQ3BdXwa5BVR4xB0KWWLRv5w7z/3BHCtCrIiVnVtzMzW
	RuXdlqrRqVES0Ohu+oeb4fLZY7uO+Hsvai1tWE/112uuhhaaA6c0FKKO6i+kZays/A9WGEjT+ev0G
	6cPSR/yzEV8NA/UWQwqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p5FIf-008LyN-5X; Wed, 14 Dec 2022 00:07:05 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p5FIc-008LwR-5D
	for kexec@lists.infradead.org; Wed, 14 Dec 2022 00:07:03 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id E3C99B81619;
	Wed, 14 Dec 2022 00:06:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F884C433EF;
	Wed, 14 Dec 2022 00:06:58 +0000 (UTC)
Date: Tue, 13 Dec 2022 19:06:56 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 06/11] tracing: Improve panic/die notifiers
Message-ID: <20221213190656.3c229b73@gandalf.local.home>
In-Reply-To: <f29935e3-e3b6-2d4e-7fc1-267e1ef0925b@igalia.com>
References: <20220819221731.480795-1-gpiccoli@igalia.com>
	<20220819221731.480795-7-gpiccoli@igalia.com>
	<20221020172908.25c6e3a5@gandalf.local.home>
	<f29935e3-e3b6-2d4e-7fc1-267e1ef0925b@igalia.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221213_160702_398937_C0DFD1CE 
X-CRM114-Status: GOOD (  12.31  )
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

On Tue, 13 Dec 2022 20:51:07 -0300
"Guilherme G. Piccoli" <gpiccoli@igalia.com> wrote:

> > Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> > 
> > -- Steve  
> 
> Hi Steve, since you were so kind in the other patch...decided to ping in
> this one as well heheh

Heh, yeah, I forgot about this one too.

> 
> So, do you think it's possible to pick it for 6.2? No dependency here,
> it's a standalone patch.

I can pull it in.

> 
> Thanks again and sorry for the annoyance!

No, sorry for missing these.

-- Steve

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
