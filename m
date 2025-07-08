Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75201C8303C
	for <kexec@archiver.kernel.org>; Tue,  8 Jul 2025 21:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dE21b34H64m1Rx5Bjk/kqJGCqXfxO2jKo8Req6Ph21o=; b=VK9dLGDkyfGpbLoGjqHFCePjRX
	a5/Qk961e/2BnMEkmfSkYZtTkKijYzzHY4coSoHIbE+0r8IgF4M6JpQqbuCD+Dd8QKD98ZwR3NNEW
	BmffjdpMkyHMwonjYTpwIDFRoMf1iCLYkc1hv+TpQa7DHHpmJL2dlMewFa4ztoAOv7w5QK7llToFt
	aB5x0hDVFmVMurGAKoRAHbkYFYxBjnZM7zYywztONGTSqm8V1gnu6BmHZCiaBxGNHsIqiLXjhHKy5
	yz6bHWXeRGOMA3qk2zAvjcJETfGkBU4CapikUlTgTHjfKO/ELIEbKXmvs4CbaCIUKkpjgNVmSUdqV
	p8ohuMVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZFm9-00000006eCm-2wLG;
	Tue, 08 Jul 2025 21:22:53 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZEzo-00000006Wer-39Po
	for kexec@lists.infradead.org;
	Tue, 08 Jul 2025 20:32:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id B32D15C570A;
	Tue,  8 Jul 2025 20:32:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23896C4CEED;
	Tue,  8 Jul 2025 20:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752006775;
	bh=v6IjWxZZvdKzFozdZoIQf7kco0spsknEBjNgMIsauWM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n3oYQMAJbbtIRjSqTkO2jJFyn19sEQMBMiez2bhii/DjTk9DNmJ8QEIWDBp5gILUn
	 RIuKSomvRIsESpQ8ktgMTK/Z+y/UsYPBI9jmn5vgGMJrPrmUDHjGnj4jbM1kAJJvEk
	 Uh8R8AamuVT3jmDDovVkwZqDzk1tzmks4kwJDlfOXKubD/mZvneiMOt6FJz/r7E1qf
	 hkEgLj3zWdxdnnYDE1LpKxayPBMLMOaNbV1RqIHEAbN2aXGfT9qMWBo5nJCAWIlhvD
	 PG+ehluhiZ5K9BNdyboVdP2PNr7DKDb8oAaXonAaT1omgpXDxs11DOY10q2WcIl75b
	 9PLKYDNjC7pnQ==
Date: Tue, 8 Jul 2025 16:32:49 -0400
From: Sasha Levin <sashal@kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: patches@lists.linux.dev, stable@vger.kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>,
	Nat Wittstock <nat@fardog.io>, Lucian Langa <lucilanga@7pot.org>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	rafael@kernel.org, pavel@ucw.cz, len.brown@intel.com,
	linux-pm@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH AUTOSEL 6.15 6/8] PM: Restrict swap use to later in the
 suspend sequence
Message-ID: <aG2AcbhWmFwaHT6C@lappy>
References: <20250708000215.793090-1-sashal@kernel.org>
 <20250708000215.793090-6-sashal@kernel.org>
 <87ms9esclp.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <87ms9esclp.fsf@email.froward.int.ebiederm.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250708_133256_863750_832ECA25 
X-CRM114-Status: UNSURE (   8.15  )
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

On Tue, Jul 08, 2025 at 02:32:02PM -0500, Eric W. Biederman wrote:
>
>Wow!
>
>Sasha I think an impersonator has gotten into your account, and
>is just making nonsense up.

https://lore.kernel.org/all/aDXQaq-bq5BMMlce@lappy/

>At best all of this appears to be an effort to get someone else to
>do necessary thinking for you.  As my time for kernel work is very
>limited I expect I will auto-nack any such future attempts to outsource
>someone else's thinking on me.

I've gone ahead and added you to the list of people who AUTOSEL will
skip, so no need to worry about wasting your time here.

-- 
Thanks,
Sasha

