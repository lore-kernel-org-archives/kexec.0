Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACA20C25B08
	for <kexec@archiver.kernel.org>; Wed, 17 Aug 2022 14:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=C3/GA5GLQ217ULpEpvSeY9LsP6DB/WQGq9N78TvEn5I=; b=aHR6iqJF52K/2I
	uBY/IHa6Ii4efJhIH9mLqduKnqNd2k32yHXDWZ9m0n9rH3Vfn0cVEJUid/TeL1cDXkEBN85TYsLFV
	avt49OMgEhRLn4d5Aet6NT5hwGOnRRitpVx13WLha+qBoSHaGU3Fmcmhf5jN83o3sIYN5MdPUDkdo
	ZFE+CsRBvO4fGFVZ9eWFd9AhvpePXfa0n+qPb+kNTCqOmdEvGid8jh6Dya+ESY7yeYflGFxqHBg2/
	n6i1aaC/HbD4GyL7KcWxLhofmRrObSKOy0sD015V9lhxspfeUWn358FWDL/lIcXGdlJMPNQcPOLF3
	pyZMKVs198ErVLK/x6fg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oOJrK-002l3C-F8; Wed, 17 Aug 2022 14:17:26 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oO1YL-005uq2-QJ
	for kexec@lists.infradead.org; Tue, 16 Aug 2022 18:44:39 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id A0A37B81AAC;
	Tue, 16 Aug 2022 18:44:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41CBBC433C1;
	Tue, 16 Aug 2022 18:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1660675472;
	bh=f6wdS3YqMu7Nfy60sXIS+fqX0XpIfZfKiWOhkqio+7k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NH9dXdzBkblq/hjsx43QJvGalLoipTkKVChJltRWzTAMfuLIP8rsIoL03VSxcooPP
	 EJ9k7A3uy2M1Og9+kritwzPbCpvVjggMek7Qkc5CiBBzmIwtJw6Zjyvc0GLkCweKe2
	 CORjNQnbnysZgszI8567TVKB6QpHqHvvQMG2a0xG1IiagK0R6geOadt9tjbQnkuXS9
	 EYwmtGUptSH4s6hA1FIM2ssPhvQjNMgvM1VpuziZliG7AUPO7bmtww2UmrfKZhx+iJ
	 xijf/72fNXfWpi/pvPkn4rT7VPpIMxb2xv+gy1WIxzgg91ukIaw0BsLR/nJzIIyy2Z
	 oVRZ2CG3TSJXw==
Message-ID: <9f114876-d402-6e74-c1db-4e4983c2d695@kernel.org>
Date: Tue, 16 Aug 2022 13:44:26 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 10/13] EDAC/altera: Skip the panic notifier if kdump is
 loaded
Content-Language: en-US
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>, akpm@linux-foundation.org,
 bhe@redhat.com, pmladek@suse.com, kexec@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, x86@kernel.org, kernel-dev@igalia.com,
 kernel@gpiccoli.net, halves@canonical.com, fabiomirmar@gmail.com,
 alejandro.j.jimenez@oracle.com, andriy.shevchenko@linux.intel.com,
 arnd@arndb.de, bp@alien8.de, corbet@lwn.net, d.hatayama@jp.fujitsu.com,
 dave.hansen@linux.intel.com, dyoung@redhat.com, feng.tang@intel.com,
 gregkh@linuxfoundation.org, mikelley@microsoft.com,
 hidehiro.kawai.ez@hitachi.com, jgross@suse.com, john.ogness@linutronix.de,
 keescook@chromium.org, luto@kernel.org, mhiramat@kernel.org,
 mingo@redhat.com, paulmck@kernel.org, peterz@infradead.org,
 rostedt@goodmis.org, senozhatsky@chromium.org, stern@rowland.harvard.edu,
 tglx@linutronix.de, vgoyal@redhat.com, vkuznets@redhat.com, will@kernel.org,
 linux-edac@vger.kernel.org, Tony Luck <tony.luck@intel.com>
References: <20220719195325.402745-1-gpiccoli@igalia.com>
 <20220719195325.402745-11-gpiccoli@igalia.com>
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20220719195325.402745-11-gpiccoli@igalia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220816_114438_048783_13986635 
X-CRM114-Status: GOOD (  13.46  )
X-Mailman-Approved-At: Wed, 17 Aug 2022 07:17:23 -0700
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org



On 7/19/22 14:53, Guilherme G. Piccoli wrote:
> The altera_edac panic notifier performs some data collection with
> regards errors detected; such code relies in the regmap layer to
> perform reads/writes, so the code is abstracted and there is some
> risk level to execute that, since the panic path runs in atomic
> context, with interrupts/preemption and secondary CPUs disabled.
> 
> Users want the information collected in this panic notifier though,
> so in order to balance the risk/benefit, let's skip the altera panic
> notifier if kdump is loaded. While at it, remove a useless header
> and encompass a macro inside the sole ifdef block it is used.
> 
> Cc: Dinh Nguyen <dinguyen@kernel.org>
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> 
> ---
> 
> V2:
> - new patch, based on the discussion in [0].
> [0] https://lore.kernel.org/lkml/62a63fc2-346f-f375-043a-fa21385279df@igalia.com/
> 

Acked-by: Dinh Nguyen <dinguyen@kernel.org>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
