Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 487BDC02180
	for <kexec@archiver.kernel.org>; Mon, 13 Jan 2025 23:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uSRsy2zojdeJoGH8qI46htTFYdrMi52B406s38tqdXQ=; b=O1Aoko7fK2UMp/y4SSA447DbBo
	6Cdg0iBQqdMP4Ngkt+IkA4luRNrq3hxljYPmS5uu69cH3N5WSqeVNWzcegQuMW++MgnaUv5SKpUqk
	Eid5HbDpLITpLlA/O5kqwMoQ5ftGEjrpiSIeGXFw+/qVUZiBMYs2Ce/RqZRuYOGU4f9im9g/YAYma
	PrXvKjk+oyYdcsZVdt0Si7r8Iktun0mpJcVlsztYle9DG7Yua91Xze/HZNdAMg6jovRRfr6dzTIq4
	ONuGbT8B+az/Q70qfXBeiD06lJqV94tV2WHjHREUJ8NCN9m6SsK6Bmh2rddlv6T+6QJOY4bkvC3WL
	dVOjVKSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tXTgx-00000006vlv-2uhW;
	Mon, 13 Jan 2025 23:17:55 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tXTgt-00000006vkT-2WPf
	for kexec@lists.infradead.org;
	Mon, 13 Jan 2025 23:17:53 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id DF1A85C2953;
	Mon, 13 Jan 2025 23:17:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28477C4CED6;
	Mon, 13 Jan 2025 23:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1736810270;
	bh=lpPz3KIoYsNKggLSdbQpd1eZ1ajQzwS8JiFc/wdHVME=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WqXOsmoJUtXRUxxGx8ODSj+hKxpQo2BOAmJ5NddyCHsC7C/Hd3rkL2e0QGjizcktc
	 ThuxGqeJL/U4DDbJBHf/qIMaHf2pLngjV8lbWXWn0ugWWuEa+xhdQHXgREhhnzATDy
	 fi0I8lOigirxtjca/jrj+I3OKutr2cMZA31ctIno=
Date: Mon, 13 Jan 2025 15:17:49 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Roberto Ricci <io@r-ricci.it>
Cc: ebiederm@xmission.com, rafael@kernel.org, pavel@ucw.cz,
 ytcoode@gmail.com, kexec@lists.infradead.org, linux-pm@vger.kernel.org,
 regressions@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION] Kernel booted via kexec fails to resume from
 hibernation
Message-Id: <20250113151749.b687c35e9f4c6d596449f433@linux-foundation.org>
In-Reply-To: <Z4WFjBVHpndct7br@desktop0a>
References: <Z4WFjBVHpndct7br@desktop0a>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250113_151752_617208_7C668850 
X-CRM114-Status: GOOD (  11.30  )
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

On Mon, 13 Jan 2025 22:28:44 +0100 Roberto Ricci <io@r-ricci.it> wrote:

> After rebooting the system via kexec, hibernating and rebooting the machine, this oops occurs:
> 
> ...
>
> # kexec -l /boot/vmlinuz-6.13.0-rc7 --initrd=/boot/initramfs-6.13.0-rc7 --reuse-cmdline
> # reboot
> # printf reboot >/sys/power/disk
> # printf disk >/sys/power/state
> ```
> 
> If kexec is not used, hibernation works fine.
> 
> This started happening since the 6.8 series; 6.7 works fine.
> I performed a bisection and it pointed to
> 18d565ea95fe ("kexec_file: fix incorrect temp_start value in locate_mem_hole_top_down()").
> 
> #regzbot introduced: 18d565ea95fe553f442c5bbc5050415bab3c3fa4
> 
> I will send the kernel config and dmesg in replies to this email.

Thanks.  Are you able to confirm that reverting 18d565ea95fe fixes things?

