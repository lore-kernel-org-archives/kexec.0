Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 485F4C433EF
	for <kexec@archiver.kernel.org>; Wed, 13 Jul 2022 17:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Message-Id:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3IBH/UhSPBHfXtOe3nhTPUq2mgChUKL0cofP8Vm5ztM=; b=slBTO1oSvXcgA8
	xDYJdcIvokJwtabKv4st4PXILtg2kSV1OUoB3eyiZJx8iScJMrCIbZqE2U8oy/fHKhOcNzYhfKX/q
	YA2k9Y/GMgbqTh+SqT7xfSKQy/5TwXxnfSypzd00OU5DAztqsI3mv9OzXU+SqWyUHNkBsOQWAJ2yW
	rRFlNB9RJ/f5j0y7XLy3a9RwuyNk872az7undvTMB6sIhX3h7sOEH7Y+GaBADhWIPTsFzhTPqIi6v
	mjDmwbbG9ZXP1LkxhHsppZaIM1Ep9ZJfZVobg2IOOqkwgt/+xzsD87Kr8c9OkGw1Q1JmKel6oGBwH
	YSF1o3rGmezkqV1Kx1TQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBgKp-0064F8-Bi; Wed, 13 Jul 2022 17:39:39 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBgKm-0064DR-NJ
	for kexec@lists.infradead.org; Wed, 13 Jul 2022 17:39:38 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 14A5961B3C;
	Wed, 13 Jul 2022 17:39:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9F8DC34114;
	Wed, 13 Jul 2022 17:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1657733975;
	bh=hY34Ty6LLrpmsHEDeDeWG++UYJntFK70v8fR9W52Hm8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uWVyM7OVw4ZwRHp7DHN5Pc2YfWEfQ2/e794Jk2qvJyKZ74r6b0udb8VBtpPiCuPK6
	 EYJeQxuAMIrng8IXnhOdN2MkENapqZJr1oAVu6nxQ8lYWetlteOhG2MVfgb3fvJXXz
	 ckUbsR5I1Pv8K4OdA78tgWO3UCRLbXGYNdYC/DJU=
Date: Wed, 13 Jul 2022 10:39:33 -0700
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
Message-Id: <20220713103933.e7510daa1c1f6ccde32f4d42@linux-foundation.org>
In-Reply-To: <xhsmh35f68tz4.mognet@vschneid.remote.csb>
References: <20220630223258.4144112-1-vschneid@redhat.com>
	<Yszgzwnk2Y+4ki58@MiWiFi-R3L-srv>
	<xhsmh35f68tz4.mognet@vschneid.remote.csb>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220713_103936_826195_1EA93AB0 
X-CRM114-Status: GOOD (  17.67  )
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

On Tue, 12 Jul 2022 12:13:03 +0100 Valentin Schneider <vschneid@redhat.com> wrote:

> On 12/07/22 10:47, Baoquan He wrote:
> > Hi,
> >
> > On 06/30/22 at 11:32pm, Valentin Schneider wrote:
> >> Hi folks,
> >>
> >> Here's ~v3~ v4 where we now completely get rid of kexec_mutex.
> >>
> >> o Patch 1 makes sure all kexec_mutex acquisitions are trylocks. This prevents
> >>   having to add any while(atomic_cmpxchg()) loops which I'd really hate to see
> >>   here. If that can't be done then I think we're better off with the combined
> >>   mutex+atomic var approach.
> >> o Patch 2 does the mutex -> atomic var switch.
> >
> > This series looks good, has it been taken into any tree?
> >
> 
> I don't think so, briefly poked around git and haven't seen it anywhere.

I'll stash it away for consideration after -rc1.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
