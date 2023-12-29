Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86E14C47073
	for <kexec@archiver.kernel.org>; Fri, 29 Dec 2023 20:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Message-Id:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=f7nxpTzI8blPHcM9nlvuYw3g29+mq/+++34YixT8iPQ=; b=uObG4hjTD9ekjq
	Sioo+mbQ4AuBwyjsfyY3Bu/Et08o5u5ejS8P8y15xFx3QKozqpzpdSvVu99orPG755oB0wHrKh+Jw
	gfABKjHQ4Q7YrhzcGnpnQChYnb8F2pNJ1eNfg8e4J41eGnY4G84xVjA0/ptPFtd30RN1YiPNywQEr
	dYMGWCBIdKOSfBg43yIWAVLEENemumSKKpmTR7gGrJI4BdCB95iIRK2tMP2GNhZeC2FD1fz4Wf2HY
	E1UMdVGGqP6tmOGq34jflVel1N60NEFkjqzo7G8UIy8cFwbg1inDNSvWzqyhKt6UfVUnOYbEj5xW5
	p/ukB4UigcQtPzQy0uPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rJJC7-001ROZ-0K;
	Fri, 29 Dec 2023 20:10:59 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rJJC3-001RNp-1m
	for kexec@lists.infradead.org;
	Fri, 29 Dec 2023 20:10:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id EF6AEB80EB6;
	Fri, 29 Dec 2023 20:10:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4392C433C7;
	Fri, 29 Dec 2023 20:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1703880653;
	bh=ksTPppqdxWZLxFaIlmOFBvh791nfVHs/hnZ5LHsvKgk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nzFmDpWGBy32NNB5e6/szEtdk8t6tD67Aywe9CKdPd/I0aZcic+y0wv4CshY+sCth
	 NnR3VXemkhBFYeoMM9SurCyiA/RpP8WzE2GVWfZDnNqIi3DIltKX60wWEfJ26UdCXk
	 9S+vKwaTFvNjiw9ZUU7MAkXTtVoQDWGW11yJ4siw=
Date: Fri, 29 Dec 2023 12:10:52 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Baoquan He <bhe@redhat.com>
Cc: Yuntao Wang <ytcoode@gmail.com>, bp@alien8.de,
 dave.hansen@linux.intel.com, dyoung@redhat.com, eric.devolder@oracle.com,
 hbathini@linux.ibm.com, hpa@zytor.com, kexec@lists.infradead.org,
 lijiang@redhat.com, linux-kernel@vger.kernel.org, mingo@redhat.com,
 seanjc@google.com, sourabhjain@linux.ibm.com, tglx@linutronix.de,
 tiwai@suse.de, vgoyal@redhat.com, x86@kernel.org
Subject: Re: [PATCH 3/3] crash_core: fix and simplify the logic of
 crash_exclude_mem_range()
Message-Id: <20231229121052.cac37914c7a051b829fcf933@linux-foundation.org>
In-Reply-To: <ZX0Z+IyaAX9lNSok@MiWiFi-R3L-srv>
References: <ZXxtfpXpuFXLd+ge@MiWiFi-R3L-srv>
	<20231216015410.188924-1-ytcoode@gmail.com>
	<ZX0Z+IyaAX9lNSok@MiWiFi-R3L-srv>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231229_121055_728210_FA158852 
X-CRM114-Status: GOOD (  21.91  )
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

On Sat, 16 Dec 2023 11:31:04 +0800 Baoquan He <bhe@redhat.com> wrote:

> > > Imagine we have a crashkernel region 256M reserved under 4G, say [2G, 2G+256M].
> > > Then after excluding the 256M from a region, it should stop. But now, this patch
> > > will make it continue scanning. Not sure if it's all in my mind.
> > 
> > Hi Baoquan,
> > 
> > Thank you for such a detailed reply. Now I finally understand why the code is
> > written this way.
> > 
> > However, if we can guarantee its correctness, wouldn't it be better to use the
> > generic region removing logic? At least it is more concise and clear, and other
> > people reading this code for the first time wouldn't get confused like me.
> > 
> > As for your concern about the while loop, I think it wouldn't affect performance
> > much because the total number of loops is small.
> 
> Well, see below kexec-tools commit, you wouldn't say that. And when you
> understand the code, you will feel a little uncomfortable about the
> sustaining useless scanning. At least, we should stop scanning after
> needed exluding is done.
> 
> Or, we may need add a generic region removing function so that it
> can be shared, e.g e820 memory region removing, memblock region removing.
> Otherwise, I can't see why a specific region excluding need a generic 
> region removing function.

So where do we now stand on this patchset?

Thanks.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
