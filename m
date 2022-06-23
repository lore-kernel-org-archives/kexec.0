Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9994FC433EF
	for <kexec@archiver.kernel.org>; Thu, 23 Jun 2022 13:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=T+0/RTBmmlDaria21HNma5JVnSXWEnFhMUmHD/fUCDQ=; b=krRu1cMiy2if/s
	IxS4LjJfy36TWWSZZKcQ6qI3JjZ4HctzZIOR+ElH1RHADJFYCJhEkS+i4kOLOzSC2nDZGZoMXOC6H
	7wNXUOrgH567wxUrbAkAfxBN7BsXKEHvOmgbqxS2AP1IYnEoZ93Rg941cgfGG7vZCQn5GURruDvm3
	qQs6GjrNHHXtTbbDPyViZpp9IyJzy7kB1SmOA10tNDmLOmfruO6k5YcZ4S6DeZdrIfoHlpTXPGTNa
	CnFbc0kpxltCxO55XVooPD3hZzrpJO8otN8+Pr415qgiQxe2I8qovNR+XHyxKQr3UE+SpAUxEQVhz
	dhP0uXJtnwE1g18ufFqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o4MzZ-00FNgr-62; Thu, 23 Jun 2022 13:35:29 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o4MzW-00FNgJ-Bm
	for kexec@lists.infradead.org; Thu, 23 Jun 2022 13:35:27 +0000
Date: Thu, 23 Jun 2022 15:35:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1655991325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XIfS0wAgMAPHur5F2be+uJqVhpZpyJ5Kv6RCfMNIA5Y=;
	b=RLnb/2S7c5GR0UcxJAp3h60TVmoTk1srsw7+OQ7Mbsh7YSgcTJKZ49HwFYSpl8pR/aLahp
	Q1Uln3TsxKnRj+cJcXe28JLZz95eZSL2gbaE7rDqlbQVFYfn4ZkIIikRp5GT4EJcy+05tD
	ki63ivVZCVzv9zJjl1RPG7v1WBofxzwDLkagvo4Z1SF2qFhVC5N38U+8AG7phV5uGStbed
	BYenYgFimrJOHwQn4tsQUNq1CaWXfgo4CkgjMLWyQIcVICALLtko+d2vOpm/5pAM9SlNlV
	VvX09gHdPhqO8SXq2bBaGSaFnY1qg1NHJcZ2YWbxjkx3F+HImzf2LqeuvwY4sA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1655991325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XIfS0wAgMAPHur5F2be+uJqVhpZpyJ5Kv6RCfMNIA5Y=;
	b=hO4ECR8hE6DwZxhwnYOBCV7FqgzraeYR171ibypr2FWi0oQeO1sXGHQUDzPXY+cEpF27wc
	UmYzi4JcHBqhXnCg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	linux-rt-users@vger.kernel.org,
	Eric Biederman <ebiederm@xmission.com>,
	Arnd Bergmann <arnd@arndb.de>, Petr Mladek <pmladek@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juri Lelli <jlelli@redhat.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Subject: Re: [PATCH v2] panic, kexec: Make __crash_kexec() NMI safe
Message-ID: <YrRsGzXTpms+FOeI@linutronix.de>
References: <20220620111520.1039685-1-vschneid@redhat.com>
 <YrQzB7sPD8BNxSFq@linutronix.de>
 <xhsmhy1xn622a.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <xhsmhy1xn622a.mognet@vschneid.remote.csb>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220623_063526_583692_561EE969 
X-CRM114-Status: UNSURE (   7.50  )
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

On 2022-06-23 12:39:57 [+0100], Valentin Schneider wrote:
> > RT-wise it would be needed for each release.
> 
> So git tells me the Fixes: commit dates from v4.2; from [1] and [2] I get
> that both current longterm stable and stable-rt trees go as far back as
> v4.9, so I'm guessing if that gets picked up for the stable trees then it
> should make its way into the stable -rt trees?

correct, if it goes -stable. Just pointing it out. But the
mutex_unlock() looks like it might also be relevant for non-RT kernels.

Sebastian

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
