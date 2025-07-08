Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E2A0C83F09
	for <kexec@archiver.kernel.org>; Tue,  8 Jul 2025 21:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vBiTekUx682gvD71NphePVxlggmBApXMLwPsFDmD7oc=; b=cwRdrFLqMVvj/i5z2CRUz0xAr1
	iIp3AWIhZLdxEBhBtIs4zG2nVQK+fa+d/EWPjqP3/0Pons3GmeHvra122sgCgdRLWz5RcrBK/4zI6
	l9hTa/uXaPCaEtp9raq6Ge8fUKw9XBXY2agamANuvrNJyJQfQgjq8S+TkEiPfyBtXvPQfj91GY++1
	U350aE4FbRU8F4xRRItKzAj7w43OMn516IY2+BlhbGCSzyOCzBhB/FbEN3Oeg/8fyedXvNXh/NY39
	fhY4LO711Dh6hqLcfW09wKHSh/JVXz8bh9sQEBQ22TYJaRgZdBhWEomhdVW/YvnPlANZOvUVmpp2d
	eI1aQeJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZFt8-00000006fY4-3g6c;
	Tue, 08 Jul 2025 21:30:06 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZFcQ-00000006cFD-37AJ
	for kexec@lists.infradead.org;
	Tue, 08 Jul 2025 21:12:52 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id E0C1FA542BA;
	Tue,  8 Jul 2025 21:12:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FE6FC4CEF1;
	Tue,  8 Jul 2025 21:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752009169;
	bh=K4/mhorGXlQlibx/zxFoJM84RWBgByZh+f2WBBkRw/A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lTYar3inYh2MSpFvvrCbv/Oodl2UGAfXQJMvwTFv3e297kUVCwY1B4Umbl5hURNmT
	 fECE3wvW6QLT+9o8LZ7Y4hkeuFx7khE2Tf2rqB3eC1oU4uz0bZqN+DGKjIXB8wbxEY
	 +tWR3zkDeRaIs9UMzvOsady6aLP/+PTjq83aJI0oqOvWz7Xs90ql//ls03I22pG05R
	 RGyy+KZX+hOsIRnt9tijTtqtH5PmVr6okt8A67hCiPq9H5pPDE8ocEBv+oODKW9VfB
	 f4XkwX6oqFOlNCxHVO4/al7fTRV8Fe/zBcDSU8JyCqsJeh5PpuW7AedZyTC9eFnKnl
	 HhhiM8b7YMVoA==
Date: Tue, 8 Jul 2025 17:12:46 -0400
From: Sasha Levin <sashal@kernel.org>
To: Willy Tarreau <w@1wt.eu>
Cc: Pavel Machek <pavel@ucw.cz>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	patches@lists.linux.dev, stable@vger.kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>,
	Nat Wittstock <nat@fardog.io>, Lucian Langa <lucilanga@7pot.org>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	rafael@kernel.org, len.brown@intel.com, linux-pm@vger.kernel.org,
	kexec@lists.infradead.org
Subject: Re: [PATCH AUTOSEL 6.15 6/8] PM: Restrict swap use to later in the
 suspend sequence
Message-ID: <aG2JzsVKuBkFcXj9@lappy>
References: <20250708000215.793090-1-sashal@kernel.org>
 <20250708000215.793090-6-sashal@kernel.org>
 <87ms9esclp.fsf@email.froward.int.ebiederm.org>
 <aG2AcbhWmFwaHT6C@lappy>
 <aG2BjYoCUYUaLGsJ@duo.ucw.cz>
 <20250708204607.GA5648@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250708204607.GA5648@1wt.eu>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250708_141250_852563_BF950160 
X-CRM114-Status: UNSURE (   9.71  )
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

On Tue, Jul 08, 2025 at 10:46:07PM +0200, Willy Tarreau wrote:
>On Tue, Jul 08, 2025 at 10:37:33PM +0200, Pavel Machek wrote:
>> On Tue 2025-07-08 16:32:49, Sasha Levin wrote:
>> > I've gone ahead and added you to the list of people who AUTOSEL will
>> > skip, so no need to worry about wasting your time here.
>>
>> Can you read?
>>
>> Your stupid robot is sending junk to the list. And you simply
>> blacklist people who complain? Resulting in more junk in autosel?
>
>No, he said autosel will now skip patches from you, not ignore your
>complaint. So eventually only those who are fine with autosel's job
>will have their patches selected and the other ones not. This will
>result in less patches there.

The only one on my blacklist here is Pavel.

We have a list of folks who have requested that either their own or the
subsystem they maintain would not be reviewed by AUTOSEL. I've added Eric's name
to that list as he has indicated he's not interested in receiving these
patches. It's not a blacklist (nor did I use the word blacklist).

https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tree/ignore_list

-- 
Thanks,
Sasha

