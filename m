Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 322A1CA5FE6
	for <kexec@archiver.kernel.org>; Sun,  4 Oct 2026 17:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dW2d3LGbBGSadjanQBD6Rhc29aMig4rkrP/cDF4hCPM=; b=4tB3isFLx77UNEw0gQRLN4cXw3
	p5qAf5Fka15OcO4SCyu0x3l9P8MVGUybXdBDVaSsBlQT8fUhWRiYKfQLVZWoRnVU1JGRN6LsT2WMQ
	pcecPJxyPQOjrLtHBj1V3R/PGHXtDhss11uSJqwax1GvQk8aLFazs5SepW3TIEX7Kp0gVcNClWG3A
	fldwxqoP7xA6cLDMcmjfREe0K1IBYSORrTZmQ1D86s1uAWuq3+Qf+xjRbPwlBKpalpUIGsc2/Diqc
	f1Uf78H71l944itEQyCj5Usx/eM7RSLKa/e/cdPh8AebhTHlRkjJbVDyvXKfbuxjfnGH1ypC8kSLi
	2dOwdAVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xDQP4-0000000F8uR-0Sb8;
	Sun, 04 Oct 2026 17:53:38 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xDQP3-0000000F8uL-2dbk
	for kexec@lists.infradead.org;
	Sun, 04 Oct 2026 17:53:37 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 5EA50601F7;
	Sun,  4 Oct 2026 17:53:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1167B1F000FF;
	Sun,  4 Oct 2026 17:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791136416;
	bh=dW2d3LGbBGSadjanQBD6Rhc29aMig4rkrP/cDF4hCPM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=QoiadJJTHbytHLLUgcMMJDU2oFapVhRXRlzl12k8kd8u1xmwsp91V3Vv5KdQJ8/8n
	 SRnfB2A4IIMfYR5JpyY29iU+f88a4kaHKDpHr3HlX+Y/2Kdh/cEUvZFKyDjeQp+9sR
	 fdXwZkKRN5on7IdkIwshDYEf/pgjqQW6kScfNW/Yk3BT4/s0+KDfaEPd8WKRNmZTkn
	 K3NccYEeufnFJV7FH2iw27/6wrnSQPDhBnGg9gmyv2S6+421Jkv8hqxUWvc+lTzBjn
	 w8rCq9In5zLZUrPSnFVq5PLTJPIxBMhg3QqnjJDetBIE2lvyL1LhuWZr5G5+6XRRhl
	 JkK1N+yfcGN7A==
From: Pratyush Yadav <pratyush@kernel.org>
To: Chris Bainbridge <chris.bainbridge@canonical.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Mike Rapoport <rppt@kernel.org>,
  Pasha Tatashin <pasha.tatashin@soleen.com>,  Jason Miu
 <jasonmiu@google.com>,  Alexander Graf <graf@amazon.com>,  Ran Xiaokai
 <ran.xiaokai@zte.com.cn>,  regressions@lists.linux.dev,
  linux-kernel@vger.kernel.org,  kexec@lists.infradead.org,
  linux-mm@kvack.org,  =?utf-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?=
 <mclapinski@google.com>
Subject: Re: [BUG] KHO handover hangs when memmap reserves PMEM
In-Reply-To: <asJc1GIBbCJ26akS@px13> (Chris Bainbridge's message of "Sun, 4
	Oct 2026 16:09:00 +0100")
References: <asE0R_f2r2TL-3Sy@px13> <2vxzcxtplh4i.fsf@kernel.org>
	<asJc1GIBbCJ26akS@px13>
Date: Sun, 04 Oct 2026 19:53:32 +0200
Message-ID: <2vxzzewtjqsj.fsf@kernel.org>
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

On Sun, Oct 04 2026, Chris Bainbridge wrote:

> On Sun, Oct 04, 2026 at 03:39:25PM +0200, Pratyush Yadav wrote:
>> 
>> Just to confirm, the first kernel boots without memmap= right?
>
> Yes.
>
>> I think the main problem is that the radix tree pages can be anywhere in
>> memory. So on the first kernel, they can land in an area that the second
>> kernel's memmap= reserves. So kho_memory_init() might end up using
>> memory that memmap= reserved. I'm not sure why exactly the next kernel
>> doesn't produce any output, but IIRC memmap= memory is not mapped to the
>> direct map, so accessing those pages likely causes a page fault.
>
> That's correct, kho_memory_init() page faults. It happens before the
> serial console is available, so there is no output.

Yeah, then I think you need an extra kexec with KHO off to enable
memmap=. Or I guess hot-unplug the memory you'd like to memmap= early on
first boot, which should make sure no radix tree pages land there.

Apart from that, I don't have any good ideas to properly solve this
problem.

-- 
Regards,
Pratyush Yadav

