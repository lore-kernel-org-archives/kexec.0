Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96E51C4332F
	for <kexec@archiver.kernel.org>; Tue, 22 Nov 2022 13:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JRP7Bge2Ua4s8DQZafLMGAB4smt3TiDJAghhIH8t8VY=; b=eECe+OudGQEewk
	X5/7ZBTsViy5KCk2V6T0ULALNoHD9YNdv5EjZfdOYMGJfIvUw4X2I4FrHUlN6j1gYAaGlLnySuQqC
	BrT/klyVvOU+htZeCrR3LFayOHVgpaif5OKKzvEUHj2aVGVpWugKjyGiZ3Y7nnfnlPnZc+IfgAEUz
	HllSh5LwlYXTw35AnuYY7sngR1zBIBMwOeEC++Xt1UJo9aQZK4z/KFqAYhaZnPprFmdeWFSqLglfP
	FvCGkZYkuAfiVxgv/hp+of+e+oWTnYcBWm5cX+Oku6LwWYMxlP4ykdqcFDaGPpanFk7LHdda/v+m8
	oYKm6RTsrJZvCrotSmMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxTBW-009b2k-Da; Tue, 22 Nov 2022 13:19:34 +0000
Received: from fanzine2.igalia.com ([213.97.179.56])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxTBT-009ay2-Mm
	for kexec@lists.infradead.org; Tue, 22 Nov 2022 13:19:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=R807ln6AiqSe+3HbtFqvP+BN4yO/wv214XfFb1EqQbE=; b=Cp5ZsrWKUviJGN4iZ8ebliVHg8
	XrD6kI035Ghf8BzClosXhfrvpUT0ccJIjXAhcibCXTJJVHOmcjEudO8HrNxwxDY4LcOHn7GYCCtfk
	BC3tGylzbaNaAdZElIA5USHN/F2smve6g5ln8xoWhExRWWSnECmaNJNn+ElT/FOs/j98JrYfJoQ4i
	p9IDt8Vn7K7Ufj9PJMpWBR7alvG8NSJF0gLKedddixCXJ1DyxBrmrkjA3oP1kGou//EySNS1qoBRL
	qY1gtI7dbROFyTMfUVdD3j0ezj2gdIGyfpX9V4eRXtNgYm2yljfNkOazXccZrYxBNMqguPjyfQJH9
	nrm/6fsg==;
Received: from [177.102.6.147] (helo=[192.168.1.60])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1oxTBH-006xGt-Ne; Tue, 22 Nov 2022 14:19:19 +0100
Message-ID: <c6b543d2-8569-7f7a-56fb-2f5899b6504c@igalia.com>
Date: Tue, 22 Nov 2022 10:19:15 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH V3 02/11] notifier: Add panic notifiers info and purge
 trailing whitespaces
Content-Language: en-US
To: akpm@linux-foundation.org
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 pmladek@suse.com, bhe@redhat.com, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, x86@kernel.org, kernel-dev@igalia.com,
 kernel@gpiccoli.net
References: <20220819221731.480795-1-gpiccoli@igalia.com>
 <20220819221731.480795-3-gpiccoli@igalia.com>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20220819221731.480795-3-gpiccoli@igalia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221122_051931_768775_F82E40C0 
X-CRM114-Status: UNSURE (   9.75  )
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

On 19/08/2022 19:17, Guilherme G. Piccoli wrote:
> Although many notifiers are mentioned in the comments, the panic
> notifiers infrastructure is not. Also, the file contains some
> trailing whitespaces. Fix both issues here.
> 
> Cc: Arjan van de Ven <arjan@linux.intel.com>
> Cc: Cong Wang <xiyou.wangcong@gmail.com>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Valentin Schneider <valentin.schneider@arm.com>
> Cc: Xiaoming Ni <nixiaoming@huawei.com>
> Reviewed-by: Baoquan He <bhe@redhat.com>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> 
> ---
> 
> V3:
> - Added Baoquan review tag - thanks!
> 
> V2:
> - No changes.
> 
> 

Hi Andrew, do you think it makes sense to merge this one for v6.2/next?
I don't see anything else required here, lemme know otherwise.

Thanks,


Guilherme


P.S. Trimmed a bit the huge CC list, but kept all MLs.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
