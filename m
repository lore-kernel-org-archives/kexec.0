Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07964CCA47F
	for <kexec@archiver.kernel.org>; Fri, 17 Jun 2022 16:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6/Emz7eQPQdudzfOAva7MHVd2CtG2yFPxTXWQaljpyk=; b=E+uvZ4nhB6dggZ
	NLmFUNi5o3U3XIDcs4VCxlkBlHfHu6y0fc/i+in6XWsq3MNa/8icwiXi5Ol+JzQYOwPh3BoZ4iQ2d
	Tn/RB9o1jsLcrrBAe/XU4n3VZZkdgqay0QSZoiex5/Htt8qxiu7eFvzkQEDNRUeueLxp2g2Vsex+j
	HGVFDgCNIc69LbVndkBYoM0SSBJnSu5S+HalzSmgkGiKG5XfrS22OGbjM5n21V8dEnFUwvmieH/Hp
	bD2PuURMfX9QxOzy0Hvx5htEP8Ob35vrEf4ZdjXFS9ibt/kFGBIKyycA0poVL9MuvQ0jEcNKL7Ak2
	3cO+Yas1bX6BXQbEAp0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o2FE2-008KYV-MG; Fri, 17 Jun 2022 16:53:38 +0000
Received: from galois.linutronix.de ([193.142.43.55])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o2FE0-008KXU-4A
	for kexec@lists.infradead.org; Fri, 17 Jun 2022 16:53:37 +0000
Date: Fri, 17 Jun 2022 18:53:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1655484813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=giQdDv8p0YqkjTRJ/+bMp26gGyp0dRqL/fs20UthWLo=;
	b=4knjidennpLmK5EdIueesjrOBlk4jXwtLAq2P1eAl3AnTdC4GnjfBV9eRR1iSNUMeUR4Ak
	bKIizBa9cpTZqhp7nR7WOcrDB+WWinuuQm3fxNNel9yqsS7k3iPEHuAzBufuPF7pfov0jk
	9Fw4FfkoB9OPVVx72yP/P1j8kSFdTCJOQ5/SsQlREeeyxvcN1zcBL3FXNZzR3gn5NDwAvb
	D0f+pd8SqS676/BDvxRSjs4RWRI7cLO8e2176dTK5twaivPWi7t1JKxdxiJdalQaNnaMVU
	6+GNyby9/yb5LbgFUlYsg7bsCy+UIwNX1j7jZTXXmjdPfwddHq7q/0mhqNv0pw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1655484813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=giQdDv8p0YqkjTRJ/+bMp26gGyp0dRqL/fs20UthWLo=;
	b=oT4dJHHBw+WW1QEdjaKsyt0kh2/dZWwsWY0fYKfKddIp8nq/B3rppmyWB50dBdyBbxlxzA
	EWkZU775Hz0oykAg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	linux-rt-users@vger.kernel.org,
	Eric Biederman <ebiederm@xmission.com>,
	Arnd Bergmann <arnd@arndb.de>, Petr Mladek <pmladek@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juri Lelli <jlelli@redhat.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Subject: Re: [PATCH] panic, kexec: Don't mutex_trylock() in __crash_kexec()
Message-ID: <YqyxjDz4fB3LuRgJ@linutronix.de>
References: <20220616123709.347053-1-vschneid@redhat.com>
 <YqyZ/Uf14qkYtMDX@linutronix.de>
 <xhsmha6ab6zm3.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <xhsmha6ab6zm3.mognet@vschneid.remote.csb>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220617_095336_346158_A84E2B62 
X-CRM114-Status: UNSURE (   7.25  )
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

On 2022-06-17 17:09:24 [+0100], Valentin Schneider wrote:
> Those were pretty much my thoughts. I *think* panic() can be re-entrant on
> the same CPU if the first entry was from NMI, but that still requires being
> able to schedule a thread that panics which isn't a given after getting
> that panic NMI. So for now actually doing the kexec in NMI (or IRQ) context
> seems to be the less hazardous route. 

most likely. Just get rid of the mutex and we should be good to go ;)

Sebastian

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
