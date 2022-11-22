Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40C8AC433FE
	for <kexec@archiver.kernel.org>; Tue, 22 Nov 2022 13:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=K5psJqE4H7X36L5IfPFI8/mxkaFR3/avimUXtDPFVGw=; b=vkK9VZZ1MUdGW8
	HS1GsB54oUeAnbMEuItHl/He/v5N0utAxJ5QkWhOS9Cs6ufMAmO5EbyoL97SpwyLm9lrV+dTB6MdW
	njb6vRn7lH8FPhRSLSKzOQqH50fZ0VFphLWY022N96D7vm/EhwCLY/yXqZSM25OqEC13LJ0UKvhL8
	B3IEBzE2rsfmCwUQQnTCAB/qPhVQaFamL6oG+r4+jpmQNmRdL3rFd0K6Yb/PSYNXH/efWdCFeGH8o
	OuGwI/A2eSWoYMKmvgp33/ttVZ2AARh4EFTL7m78Ek6W4or+XIj1ErEHzN2SQs1lQsFsdXPlhloEf
	btnV0qaFgy4lcmABPyMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxTRE-009fxi-74; Tue, 22 Nov 2022 13:35:48 +0000
Received: from fanzine2.igalia.com ([213.97.179.56])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxTRA-009fx4-Qz
	for kexec@lists.infradead.org; Tue, 22 Nov 2022 13:35:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=rSYIGGtjZljFBal86Avbxge1dAX05jgxf9qrktsTsB8=; b=MX800+aYXTdyYof4USzixvuPvg
	9FbkPgWEf4yn5YKSZ6YZvZYMUIrJ83siHY3JDQnjBib+dAZOvIjPcv4rwFWWZmC8nuU/CNyqTv37J
	LI9uahtiyTlFT5sg3l2Jt6DAPlbV/eGuCYZHMx1mJgP8y9VUP0QV5AhKWiiwBT3/TtAdOZxoHUjGo
	wBjoV4n84SXGRfQJ1FQgM2titKAX9RMXtyQrLP2E1UPM76R5ywtg8b8JzSylFz4KM6CKbhsW2RDhw
	2Wuo/c750D1OMJECUK35f1MTpZl3Tuqe5CqaKSXYSU2Si3ILxqlcvyZFxEYL6RqkDNw1VeQ19rA9/
	QwSDYHeg==;
Received: from [177.102.6.147] (helo=[192.168.1.60])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1oxTR5-006yBT-L8; Tue, 22 Nov 2022 14:35:39 +0100
Message-ID: <831175d7-1b30-de61-d6c5-cbb91e4fdcfb@igalia.com>
Date: Tue, 22 Nov 2022 10:35:34 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH V3 11/11] panic: Fixes the panic_print NMI backtrace
 setting
Content-Language: en-US
To: akpm@linux-foundation.org, bhe@redhat.com, pmladek@suse.com,
 feng.tang@intel.com
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org, x86@kernel.org,
 kernel-dev@igalia.com, kernel@gpiccoli.net
References: <20220819221731.480795-1-gpiccoli@igalia.com>
 <20220819221731.480795-12-gpiccoli@igalia.com>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20220819221731.480795-12-gpiccoli@igalia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221122_053544_904083_A6D41439 
X-CRM114-Status: GOOD (  21.57  )
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

On 19/08/2022 19:17, Guilherme G. Piccoli wrote:
> Commit 8d470a45d1a6 ("panic: add option to dump all CPUs backtraces in panic_print")
> introduced a setting for the "panic_print" kernel parameter to allow
> users to request a NMI backtrace on panic. Problem is that the panic_print
> handling happens after the secondary CPUs are already disabled, hence
> this option ended-up being kind of a no-op - kernel skips the NMI trace
> in idling CPUs, which is the case of offline CPUs.
> 
> Fix it by checking the NMI backtrace bit in the panic_print prior to
> the CPU disabling function.
> 
> Fixes: 8d470a45d1a6 ("panic: add option to dump all CPUs backtraces in panic_print")
> Cc: Feng Tang <feng.tang@intel.com>
> Cc: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> 
> ---
> 
> V3:
> - No changes.
> 
> V2:
> - new patch, there was no V1 of this one.
> 
> Hi folks, thanks upfront for reviews. This is a new patch, fixing an issue
> I found in my tests, so I shoved it into this fixes series.
> 
> Notice that while at it, I got rid of the "crash_kexec_post_notifiers"
> local copy in panic(). This was introduced by commit b26e27ddfd2a
> ("kexec: use core_param for crash_kexec_post_notifiers boot option"),
> but it is not clear from comments or commit message why this local copy
> is required.
> 
> My understanding is that it's a mechanism to prevent some concurrency,
> in case some other CPU modify this variable while panic() is running.
> I find it very unlikely, hence I removed it - but if people consider
> this copy needed, I can respin this patch and keep it, even providing a
> comment about that, in order to be explict about its need.
> 
> Let me know your thoughts! Cheers,
> 
> Guilherme
> 
> 

Hi folks, bi-monthly ping - apologies for the noise heh

Is there anything suggested so we can get this fix merged in 6.2? Any
suggestions / reviews are much appreciated.

Tnx in advance,


Guilherme

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
