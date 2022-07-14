Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74055C43334
	for <kexec@archiver.kernel.org>; Thu, 14 Jul 2022 11:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5VD+6pS1wGtEFIKymKK/B+HZdZBrTUXKdK7MkLj0JaQ=; b=FPGe1qlyJeb0Pg
	OdE1O7GH2Ma1SvOea1ihFFUVys5yCrwCzkq8/pTK0IPfbzGzmH2lwOq7heW14AP7fgCF17XVodJ5H
	EIHzhmwht3/FgjqvIoOq9z/JEw1EWrvgCAjlQ6QOx1L42oaroqWtrtW9j+UnMLMiT8SCv/yCk5si4
	oDo+2Hkv7BtFKYtxVCo3FIOBT4a//444uFeJJDSETrhds5WdZuIoKrYO5gitpPechUQP3U/c3//+t
	6POi2fTNzvTNuXmCzmNde/euZ4XL4Xi2BFJ8wHOt69xE37k1neqPYud3KUEo/BBTXCdMwoVQBno8w
	3ZLeB6V86ClRAuj/TAgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBx4p-00Dn5t-QQ; Thu, 14 Jul 2022 11:32:15 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBx4n-00Dn1s-2Q
	for kexec@lists.infradead.org; Thu, 14 Jul 2022 11:32:14 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id DFB561FAD3;
	Thu, 14 Jul 2022 11:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1657798327; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EmuMePcQGuxM9heOQ2mK6cbP7+zHaIyLwtcEh4MAP1c=;
	b=AvC/B+2wk1WeXNFjl+3PLdV1OI8nMhJ87DzKbddyCNSSeFF7hcUtKUqqkDsb8GeOWlp+CJ
	BJNaz95C6xbnDPgE8dUcHEZiyoidqPAGZt4rE0xjLZKd4O9pHfq/5SfvTqQWIWBc35Cxua
	aJfk1y918cYCN+n1ok77HjixPWb74Wg=
Received: from suse.cz (pathway.suse.cz [10.100.12.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by relay2.suse.de (Postfix) with ESMTPS id 6168E2C141;
	Thu, 14 Jul 2022 11:32:07 +0000 (UTC)
Date: Thu, 14 Jul 2022 13:32:07 +0200
From: Petr Mladek <pmladek@suse.com>
To: Valentin Schneider <vschneid@redhat.com>
Cc: kexec@lists.infradead.org, linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eric Biederman <ebiederm@xmission.com>,
	Arnd Bergmann <arnd@arndb.de>, Miaohe Lin <linmiaohe@huawei.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Juri Lelli <jlelli@redhat.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Subject: Re: [PATCH v4 0/2] kexec, panic: Making crash_kexec() NMI safe
Message-ID: <20220714113207.GD2737@pathway.suse.cz>
References: <20220630223258.4144112-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220630223258.4144112-1-vschneid@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220714_043213_282809_AF203060 
X-CRM114-Status: UNSURE (   7.63  )
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

On Thu 2022-06-30 23:32:56, Valentin Schneider wrote:
> Valentin Schneider (2):
>   kexec: Turn all kexec_mutex acquisitions into trylocks
>   panic, kexec: Make __crash_kexec() NMI safe

This version looks good to me. For both patches:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
