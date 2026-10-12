Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09702CA9ED1
	for <kexec@archiver.kernel.org>; Mon, 12 Oct 2026 11:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D154kYB9MzaI1freNWTwQ5WdzpknuyZ+bDtXw28zmF8=; b=0LY29d7bKjf98hFu4faktuNlVm
	PLxAf3BF7PBR2ftkOArAVNvJ3KJEfpjB5VgptrkxaAwP7ZHvkEQ+GMLLS/rrUqz2VmFo8OqUd5izb
	gnMDI7gWxbTyhINEQ+bd+pK3PuhP0jzmCGBHAr7/dqN9P2mcc6ny2uFO70LDASH06KGwaVbMmUQfh
	4FPuzzb3ONnXiQd0tybhyR76z9AR7bO0LaLK196kP5hMkZgSVJ47NLRTFq0e5aFySw5LGtfzaOCGg
	UkY0qFcS3SmZ2ZuKzrXkdssm/C8qIxRsvySR9ZyYRYuamUxuNSNb/IEnINybXiaAkciBK4g3quzwq
	CFC1tH/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGDpI-0000000AJ1Y-3caT;
	Mon, 12 Oct 2026 11:04:16 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGDpG-0000000AJ15-0MJT
	for kexec@lists.infradead.org;
	Mon, 12 Oct 2026 11:04:15 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A5BF1655;
	Mon, 12 Oct 2026 04:04:08 -0700 (PDT)
Received: from [10.57.12.163] (unknown [10.57.12.163])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0ECCF3F882;
	Mon, 12 Oct 2026 04:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1791803051; bh=Uoger/6i+U9R/3R8Mxjg0FsI30PjlNy00uruFl2bnhw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oG9FLrOLY8KTiQ9oAF6jOpwHmMrnhcwd59ravjOZFd2iijqO6S2wzS8qd7dVww1p5
	 oRQfMSvT/00lzftmGojNbzpu4nOZtHb27cBs3PHntwCrs4RTfXrcD3eEA44sNMsSLd
	 REYGoD+8Qqm2n0Wuh0h8UtKv6BGHaFFI91oixOQs=
Message-ID: <34106881-8ca0-4c9f-a4d2-0ff0b35460dc@arm.com>
Date: Mon, 12 Oct 2026 12:04:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PM: QoS: Add a sysfs CPU latency request with a
 boot-time value
To: Roman Kagan <rkagan@amazon.de>
Cc: linux-pm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Pasha Tatashin <pasha.tatashin@soleen.com>,
 Mike Rapoport <rppt@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>, Jonathan Corbet <corbet@lwn.net>,
 Christian Loehle <christian.loehle@arm.com>,
 Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org,
 nh-open-source@amazon.com, "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>, Len Brown <lenb@kernel.org>
References: <20261010-b4-cpuidle-shallow-v2-1-adede7dd9077@amazon.de>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20261010-b4-cpuidle-shallow-v2-1-adede7dd9077@amazon.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261012_040414_264608_36CAA624 
X-CRM114-Status: GOOD (  10.39  )
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



On 10/10/26 14:29, Roman Kagan wrote:
> The idle states offered by a platform trade wakeup latency for energy
> savings, and there are situations where the trade is not worth making:
> while a latency-sensitive workload is running, or during a live update
> via kexec, where everything from the outgoing kernel stopping the
> workload to the incoming kernel resuming it is downtime, and deep idle
> states may lengthen it.
> 
[snip]

For your scenario, when doing kexec to the new kernel, the normal
disable procedure for idle states for each CPU doesn't work?
You would like to keep this information also in the booting
system (via bootcmd) so the CPUs are still not allowed to go deeper
idle during boot, is that right?
Isn't it FW responsibility?

BTW, I'm not a fun of one global knob for all CPUs. I would
favor extending the usage of the new sysfs and make it per-CPU.
That would allow more scenarios used by user-space daemons at
runtime and not to create yet another sysfs interface.

Regards,
Lukasz

