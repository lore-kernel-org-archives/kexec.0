Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCD46CD342C
	for <kexec@archiver.kernel.org>; Wed,  6 May 2026 08:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ybmXJ9gRB7+ZZZcAuy4LDFz5/ZJXx3Lh5ejxxG3yS28=; b=0lxu62f4/TdD+mcTGNStEr3IaX
	3uo7UzDaouZG8dXlH/MLnOiaVrK1+ScVlrBlIc57AymtdfDLFUjQwoUZSA6Iu8xQPPjR85AOegYOq
	vzXWeVHPZq/i7lC4uplxZneWr2ftrfJCoTl1TpDPtoTq7PfbR3M23X2U7Gi2m5yXvhlqwSCTjxIDE
	4d3FGXsJt973IwqaXwDc+BFE823+V3Z9x3X1CTOj0iQPqoc6uTr0qhdwh6307Hzf87SJPfcxD15AD
	48T8GV27ZGjsesO86aT7Eoog4Zq4fjbOtcgOjpjMeRLNBVUH70XrQMyDPya86H1mZ146eqMnfg1Es
	KMlERE2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKXv5-00000000DT2-2CYC;
	Wed, 06 May 2026 08:47:51 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKXv4-00000000DSp-1mrC
	for kexec@lists.infradead.org;
	Wed, 06 May 2026 08:47:50 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 82C2F60132;
	Wed,  6 May 2026 08:47:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D025CC2BCB8;
	Wed,  6 May 2026 08:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778057269;
	bh=7IY2kmj0Uq/Ygn9gMXVOL2Kvoevz8GXb2KpMAGJV8SQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=LzLZEk0JJGjgAgySvJuH0Yri/edZBEZvNCyBm7MuZEA3krQ0l8r09mVWTy41OoxT6
	 DOvbOYJQYKOLXszAcAyT1WRtBTzEIYN+spqpyGvl0QduCL1Iw4L/S76YG729tevuGB
	 F50mCGX0pFYkkOnA2FQbwTrXwQNog1uKUxTUBfmYZuNeYBnFbdoVrqWMVLGdmO9Zsx
	 K6VdwglVNXF6xnXGKlDRWZPrnTPsQvUtn6nLvfe1wRcirflapOqMfGaBpkZP9F9lz2
	 wTJaOWQc8/hoy6yIOZzCom/bJGL9TquxIivme4Ze6nkxWJiCNWi3QK7YBEIqnxII2d
	 O9zI9G74dG38Q==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: rppt@kernel.org,  sourabhjain@linux.ibm.com,  jbouron@amazon.com,
  akpm@linux-foundation.org,  bhe@redhat.com,
  linux-kernel@vger.kernel.org,  dan.carpenter@linaro.org,
  liaoyuanhong@vivo.com,  rafael.j.wysocki@intel.com,  piliu@redhat.com,
  kexec@lists.infradead.org,  pratyush@kernel.org,  graf@amazon.com,
  mario.limonciello@amd.com
Subject: Re: [PATCH v1 2/3] liveupdate: block outgoing session mutations
 during serialization
In-Reply-To: <20260506043200.2025677-7-pasha.tatashin@soleen.com> (Pasha
	Tatashin's message of "Wed, 6 May 2026 00:32:03 -0400")
References: <20260506043200.2025677-5-pasha.tatashin@soleen.com>
	<20260506043200.2025677-7-pasha.tatashin@soleen.com>
Date: Wed, 06 May 2026 10:47:45 +0200
Message-ID: <2vxzy0hwzzym.fsf@kernel.org>
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

On Wed, May 06 2026, Pasha Tatashin wrote:

> Introduce a 'rebooting' flag in the session header to ensure that once
> serialization has started, no new outgoing session mutations (creations
> or file preservations) can occur.

Would it be a better idea to hold the session header lock and locks of
each session? This would prevent anyone else from getting access to any
of the sessions, and we don't have to worry about all the weird cases
when one might add a file to a serialized session or something similar.

Once liveupdate_reboot() returns success, there is no going back anyway
so I don't think it matters much that some tasks will be left waiting.

>
> Fixes: 0153094d03df ("liveupdate: luo_session: add sessions support")
> Reported-by: Oskar Gerlicz Kowalczuk <oskar@gerlicz.space>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
[...]

-- 
Regards,
Pratyush Yadav

