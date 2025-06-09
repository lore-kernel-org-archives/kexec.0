Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5534DC61CE8
	for <kexec@archiver.kernel.org>; Mon,  9 Jun 2025 23:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BnfgY8Lio4OyWqKw4IAPziI6D8RP7lSOS1s9gQfTpbE=; b=VweFp5R9wsnshdptpJuTvkaSX4
	eSrAvXBTdCu1lR/VWa894ObzLBjrGaPjK7Zkto4IZc4mee54W99wtxGjE/KiM+zuMu3Evl1h88mP5
	gruwqtEIqAFLIJIZTtvNIGK705qm4HbKhzaYzekl1r83mPy+8Y9kD9WUMlWd5TdghLsQxhT/X8TDK
	sS169wZFhDaccdcUNiMHMY8Vox5Jhyb74j7O1RdwY+lPukYhWJmGX6K3DqsNQDCWOllfsZ3FYnxVC
	TsJjSQzi4l/C9rE+h0UFI+8P3BJVyUxFYYvwn0xv1abVcWAJXCp3Qk81UE5fdj0BCovBvaOMgR12x
	mIRap/Fw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOmMc-00000005TkY-3Jwa;
	Mon, 09 Jun 2025 23:57:14 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOmHt-00000005TPK-0Jaz
	for kexec@bombadil.infradead.org;
	Mon, 09 Jun 2025 23:52:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=BnfgY8Lio4OyWqKw4IAPziI6D8RP7lSOS1s9gQfTpbE=; b=dbU/rvgW/kD7K0fBwCQ0vUj67/
	mN4i5wIPRaAeTL76XkbK+RLEf56Kqg1/KihvzKmmjSQkWLxeJ/E0MCJ8hOiV5PhzSRiDj+IIC89la
	AX8P6aX00x05mzzO06ddFg142sQjVbGTvIcJKuCpQSxhVr3aHR3vVgMP7OwzlcFJiykmIGsrqOJbx
	slbbSrtZ0w4+q67e/f4MMtwOR8mrJcF/bzuZOlD5fryftM4IMfl0/hAkZytmk7wHzzspF77aRLUwR
	glSirzJd4SVz6lvqkoQ96GI5LL0Pz1BFiGfQhMkxsVQs+R/NQzLJhgPFHkJbGnGg9llAahLd53f4X
	BVisVr7w==;
Received: from nyc.source.kernel.org ([147.75.193.91])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOmHq-00000001hnQ-3DFj
	for kexec@lists.infradead.org;
	Mon, 09 Jun 2025 23:52:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 57148A5074D;
	Mon,  9 Jun 2025 23:52:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE900C4CEEB;
	Mon,  9 Jun 2025 23:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1749513135;
	bh=mEQDo6j5H8oPDQlg77ExKhoywTKS+C3u5qkNoQL4GOw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Vm0YQP52BaTmcI7ScfKdnqnVriGiQ0Tuq2wIsqkE1WHaVP9BS8jzZJ1hwlqptBDxA
	 ElAnZJT4po+DqwkuZLvzwe+QP6oV+GQ9fHMrFA1Sdagsa6yxXmUWdaCYaA9wyC9FSL
	 aJZGme5/MVAa14X4MQ8BeBM3N5EdavQzOJLRJCqs=
Date: Mon, 9 Jun 2025 16:52:14 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Alexander Graf <graf@amazon.com>
Cc: <kexec@lists.infradead.org>, <linux-kernel@vger.kernel.org>, Pasha
 Tatashin <pasha.tatashin@soleen.com>, <nh-open-source@amazon.com>, Baoquan
 He <bhe@redhat.com>, Zhongkun He <hezhongkun.hzk@bytedance.com>
Subject: Re: [PATCH v4] kexec: Enable CMA based contiguous allocation
Message-Id: <20250609165214.784b399237d37b3e6fd97f4c@linux-foundation.org>
In-Reply-To: <f609d5a0-99d5-4328-8a18-00f6a9e1a48c@amazon.com>
References: <20250521152934.48841-1-graf@amazon.com>
	<f609d5a0-99d5-4328-8a18-00f6a9e1a48c@amazon.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250610_005218_970536_3E6984CC 
X-CRM114-Status: UNSURE (   9.32  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Mon, 9 Jun 2025 09:03:10 +0200 Alexander Graf <graf@amazon.com> wrote:

> > Signed-off-by: Alexander Graf <graf@amazon.com>
> 
> 
> Ping? Not seeing this patch in Linus' master tree :)
> 

Sorry, I parked this because of messy cross-tree dependencies and by
the time I could bring it back, it was too late to get decent -next
testing.

And now arch/riscv/kernel/elf_kexec.c has disappeared.  So can you
please redo and resend?

