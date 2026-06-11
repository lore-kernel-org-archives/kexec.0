Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D694ECD98CE
	for <kexec@archiver.kernel.org>; Thu, 11 Jun 2026 12:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=99lgOtQk9dn8QOKtu4wIHYIKNC0sTZDEpb60VABMMiE=; b=eHIkkSNe2pi53eqpbL0CW69oCv
	ylv5l3csZ7Mor8+sAkeHN3zw+IRfaWqpd31SjSK8QPBj4hC9eRQe4owfmvCNwzus8u4ho9LozN9XJ
	j0F2QU4wi82mhAfsvBU1mYazcHkYmzKyeQyBBnEipT2yXyx3cZ8JMoPxiC09K2s5Qd1dlXidGFUt9
	2sPkN4R0ncP7tWZIxMJJ2egnH4PpMC4ihessReoadMAEmoklboivD3jfDC5UvIkxj2+2yGR715jgQ
	qFpzW+fJgs5XbCnWIObqaKQ/lSH+FpjpBvzcRqT3h4zwXoVPnE/vKy157jovaRVDRNSq5L6q7hSx5
	JLdjfcHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXebD-00000009PVu-1y5m;
	Thu, 11 Jun 2026 12:33:31 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXebC-00000009PVm-40r7
	for kexec@lists.infradead.org;
	Thu, 11 Jun 2026 12:33:30 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id A8B2241E5D;
	Thu, 11 Jun 2026 12:33:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6228C1F00893;
	Thu, 11 Jun 2026 12:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781181209;
	bh=99lgOtQk9dn8QOKtu4wIHYIKNC0sTZDEpb60VABMMiE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=ZBKuld9JpdV5XNNa7vjqneWDH72r5famEeOY5FIX+k80RgQ/iRS0mBzeuwd2YFKQV
	 odZG4Ozu0c9EmKHF3E195355OxzXVwUJ3Zak3cEaxtGEu/k4qhiomtw8h216d2ixNx
	 XvT7syzLBk38YcKNYGrrLXNxW5Kdtct0Vdj8s1GdG0ZmfkNqU6uweH0jiBuojDFvoQ
	 3kAEuZNmoBhtm+TgFM0rcnx/7DXXtumq2fbcjTZwUFPhfzN+ErPkyavYQLRpwyYJbC
	 J44yaGNA4VTNqABl66oxWZYtZQxJAi+E8wVIlk3tyN6cSC1AK4lGfjBMyQeCIqsSg5
	 RQHu6hIaVMafA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Tarun Sahu <tarunsahu@google.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,  Mike Rapoport
 <rppt@kernel.org>,  Pratyush Yadav <pratyush@kernel.org>,
  linux-kernel@vger.kernel.org,  vipinsh@google.com,
  kexec@lists.infradead.org
Subject: Re: [PATCH v2] liveupdate: Document that retrieve failure is permanent
In-Reply-To: <faec5df2a3e90240cde5897bae2250cd7d44aeac.1781170056.git.tarunsahu@google.com>
	(Tarun Sahu's message of "Thu, 11 Jun 2026 09:30:40 +0000")
References: <faec5df2a3e90240cde5897bae2250cd7d44aeac.1781170056.git.tarunsahu@google.com>
Date: Thu, 11 Jun 2026 14:33:27 +0200
Message-ID: <2vxzqzmdqmso.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

On Thu, Jun 11 2026, Tarun Sahu wrote:

> Signed-off-by: Tarun Sahu <tarunsahu@google.com>

Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>

Thanks for the fix!

[...]

-- 
Regards,
Pratyush Yadav

