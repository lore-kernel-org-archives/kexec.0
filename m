Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55DA8C433FE
	for <kexec@archiver.kernel.org>; Mon,  3 Oct 2022 18:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Message-Id:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tgY2QoSJIDooTyFeDt9ovKE2/pGIBa2Nzr9M1gzfnJs=; b=nFU7nSMpapDf5X
	Zl50ZTRvxRvQW1AuJhqGx3wNRJNeH4abXR97EtaUe3lPgf+O/KAhDbO9md+/Z1+jPyzVoMMcGq8zJ
	Xvbdv/NepLxCiDf7w6rPEHy7nt0IA0PywX17lVdsNSNI2eKtMOUsBdCgdI1fa4BUPX1pYeZXkPMOR
	ETJ6E8idpbXjXJCTHG0bjWo5qm7u0iKdVOV7HMfryohICYzK36GHlPrQmMV/3j3kJ6o2Aw+fADMpz
	mQdIcFIM5FD0tDjTdOZo6jmDv3he3Ir2eAQnEbCQj0ZEz/YaVOn9Wo8gZhQP55vcUL+fllWgtwpn9
	woLJCvqtiDPm49EevwCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ofQO3-007Ebz-W0; Mon, 03 Oct 2022 18:41:56 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ofQO1-007Ebc-Qq
	for kexec@lists.infradead.org; Mon, 03 Oct 2022 18:41:55 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 5F294611A7;
	Mon,  3 Oct 2022 18:41:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A977C433C1;
	Mon,  3 Oct 2022 18:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1664822511;
	bh=iv49xGC0NzD9ClJKm6B6FSdwct9N2gigG6wLOtM0xFs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NvhqHntCIoiXJSQQJC5xZWYxMKTkT3tECa6/bOJlGQ6JGwGaO++IAoyHbTEP04IUA
	 eR0U90lYJDSNz0xUbUO42ptYz9Qk5RkZaE4oqPARqeygEHyGAFVLa6XaCRL2Psn+ZG
	 OH/PEq5vVlcaGQO/qS5WzsvXzaYo9l/PPSFqctZs=
Date: Mon, 3 Oct 2022 11:41:50 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Valentin Schneider <vschneid@redhat.com>
Cc: Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org,
 linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org, Eric
 Biederman <ebiederm@xmission.com>, Arnd Bergmann <arnd@arndb.de>, Petr
 Mladek <pmladek@suse.com>, Miaohe Lin <linmiaohe@huawei.com>, Thomas
 Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Juri Lelli <jlelli@redhat.com>,
 "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Subject: Re: [PATCH v4 0/2] kexec, panic: Making crash_kexec() NMI safe
Message-Id: <20221003114150.d4b34df6f56e8ebfec897688@linux-foundation.org>
In-Reply-To: <xhsmho7ut2gcs.mognet@vschneid.remote.csb>
References: <20220630223258.4144112-1-vschneid@redhat.com>
	<Yszgzwnk2Y+4ki58@MiWiFi-R3L-srv>
	<xhsmh35f68tz4.mognet@vschneid.remote.csb>
	<20220713103933.e7510daa1c1f6ccde32f4d42@linux-foundation.org>
	<xhsmho7ut2gcs.mognet@vschneid.remote.csb>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221003_114153_963494_C1147F65 
X-CRM114-Status: GOOD (  10.73  )
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

On Mon, 03 Oct 2022 14:20:51 +0100 Valentin Schneider <vschneid@redhat.com> wrote:

> > I'll stash it away for consideration after -rc1.
> 
> I've seen them in linux-next for a while, am I right in assuming they'll be
> part of a 6.1 PR?

yup.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
