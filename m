Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66EF2C02180
	for <kexec@archiver.kernel.org>; Wed, 15 Jan 2025 12:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XSA5fxZb1Zqp8xGb+AoSG7h9EPnLoDgiYKVD066+ghk=; b=W6qDBr5Ocba52zoDWuxGFlhEUJ
	TUjcOxDsAa6TFP2mRmNSk60nXC7t1DuNVyJFLw6OLNdhD/XWfAwVx8r0DcKBl6OzzB2F8eW2CCdjB
	whrA4CDnY/2xNDPI5oVPcsIeUKVV9Ui1BfcJOWIyP3BdronM6fh4DT8+GHX/Fqnuu8I0W2w/wRatN
	T3hchduqA8v4nOYLME0HzVndg4OOmynh8ZHEo8RuuDqrUZ6jw3XGvRdNMTkIDnbMSjYOHBe/OI5pB
	9cM0UywEF55Twwy8eaPTaFrKF9/QyZ5PvMuSJx1ONAqweomL7imPIemb6aQCZgXtqmnYGa5ztJ387
	nf/PEWbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tY25l-0000000Bmm0-1HEZ;
	Wed, 15 Jan 2025 12:01:49 +0000
Received: from out-175.mta0.migadu.com ([91.218.175.175])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tY24u-0000000BmhK-0DYa
	for kexec@lists.infradead.org;
	Wed, 15 Jan 2025 12:00:57 +0000
Date: Wed, 15 Jan 2025 13:00:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=r-ricci.it; s=key1;
	t=1736942450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XSA5fxZb1Zqp8xGb+AoSG7h9EPnLoDgiYKVD066+ghk=;
	b=cL2KtTEGF8cCgbVf9/IXVqeIDUuKYS3WSL6t4mtky6ztvJolDkxN0g4J4CN+uM+x03p08Q
	8G0y9sKcOf7/Wn74d0tFANZOtIjMq3zbEi6Ihp4E90+KjyxnzF2IY0d2775pAAf0lpqYeG
	X34r6ag2vqM9egoICBJ+WtqhEX6IclrWlRCb7ZrpCdudK60iKsMm4g2kBVl1WC1hD6qL/j
	ioWq7/QDR0hShTchppAb+yWf8iMa4E6ESubD5Iq6m67C/eaZrtbC2HLFN/UXwjoThhtaKp
	SHRCpAAB0tB80B+uPcmyZ1oPQkXPl6oAzc2SSW6ZOH/O+YDfNu/2/VeT2nNurQ==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roberto Ricci <io@r-ricci.it>
To: Baoquan He <bhe@redhat.com>
Cc: ebiederm@xmission.com, rafael@kernel.org, pavel@ucw.cz,
	ytcoode@gmail.com, kexec@lists.infradead.org,
	linux-pm@vger.kernel.org, akpm@linux-foundation.org,
	regressions@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION] Kernel booted via kexec fails to resume from
 hibernation
Message-ID: <Z4ejbdJr87V3IwV8@desktop0a>
References: <Z4WFjBVHpndct7br@desktop0a>
 <Z4Zjmva-pLbLjtQv@desktop0a>
 <Z4czuvi2BiNlDWPP@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4czuvi2BiNlDWPP@MiWiFi-R3L-srv>
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250115_040056_654915_C3367813 
X-CRM114-Status: GOOD (  19.96  )
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

On 2025-01-15 Wed 12:04:10 +0800, Baoquan He wrote:
> On 01/14/25 at 02:16pm, Roberto Ricci wrote:
> > On 2025-01-13 Mon 22:28:48 +0100, Roberto Ricci wrote:
> > > I can reproduce this with kernel 6.13-rc7 in a qemu x86_64 virtual machine
> > > running Void Linux, with the following commands:
> > > 
> > > ```
> > > # kexec -l /boot/vmlinuz-6.13.0-rc7 --initrd=/boot/initramfs-6.13.0-rc7 --reuse-cmdline
> > > # reboot
> > > # printf reboot >/sys/power/disk
> > > # printf disk >/sys/power/state
> > > ```
> > 
> > Looks like it's the kernel performing the kexec which causes the issue,
> > not the target one. E.g.: kexec-ing 6.7 from 6.13-rc7 makes resume from
> > hibernation fail; but if I kexec 6.13-rc7 from 6.7, then it works fine.
> 
> I tried the latest mainline kernel with your above command execution
> series, I didn't see the problem you reported. Can you try kexec from
> 6.7 to 6.7 or something like that and try to bisect a specific criminal
> commit?

As I mentioned in my initial report, only versions >= 6.8 are affected.
Anyway, I actually was kexec-ing the same kernel which was already booted
when I did the bisection which pointed to 18d565ea95fe.

> As for below commit, it seems not a suspect.
> 18d565ea95fe ("kexec_file: fix incorrect temp_start value in locate_mem_hole_top_down()")
> 
> If possible, can you revert below two commits altogether to have a try?
> I am not sure if they caused the problem.
> 
> 18d565ea95fe kexec_file: fix incorrect temp_start value in locate_mem_hole_top_down()
> 816d334afa85 kexec: modify the meaning of the end parameter in kimage_is_destination_range()

Reverting these two commits does not fix things on v6.13-rc7.

But I have found that reverting 18d565ea95fe fixes the issue for kernels
up to 6.11. Since 6.12 this is not enough. So I'm doing another bisection.
I will report results maybe later today.

