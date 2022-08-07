Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50F14C00140
	for <kexec@archiver.kernel.org>; Mon, 15 Aug 2022 17:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YTQ59VDHsgH+bJxGKnU8YRiUybTfTzDWR1AxTnsXawo=; b=crtuJFzJoGun6H
	rORWPhKC6vwXt25C2c8+lvrfUS50CrolxPQ/YjG0piv9DEBEuX7PkUE143kzYQWvNeu1duiXKONrM
	+Je4X1DuaQ4d26fROy9HOp1qtP5RZiEDvO21jC+3/Ngt4qdi6AMRpb15yg8c/AeYksUWMz4l1BdgD
	2bPbrVHKCzNNRWfRIHFsLKQREIzARGbMX2UffdlFPchsjIhfU6H4S0yNNaB9Q3SroeKMd/kO4jN9T
	/SrrPMHftuou9kYJIJ8jOFIryxCGeff8NcZqWyRX6TFBcRi3mrcQIGFzBIvl5wGOPLoSrbMYnhlxX
	aPHS0z7f5YSs2JKY7T2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oNdhH-0028lQ-1b; Mon, 15 Aug 2022 17:16:15 +0000
Received: from fanzine.igalia.com ([178.60.130.6] helo=fanzine2.igalia.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oKiMp-00FIfQ-Qk
	for kexec@lists.infradead.org; Sun, 07 Aug 2022 15:39:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=FfOmDqrueH5zbkn3yATMhpqMWWEe+35EmBPi72/LV0I=; b=qAULYagpbd2RoWJByTE0dULDjL
	r7Tu7V5xMI6abRrlBB1Hdw79O2+Gi1+SniR1hAmkwGAZLtm63NGffvzeN9UTGCm5bw4JRv7N3/vug
	hf4eGxeOAY49HIsm/Vot9pTpSQF7Q8xM6I2Rt5rEoIcAvOGE8ciejoIAfsZ/B2IsWvr82U8P7Hk4Q
	C13RHqD5sFxOCSCBo5zBx6YZ1ZD36P7qDjBwFgNMsZ2OSQ7nnkn9tW6FLa5TptfpHKGEa0NR0w1Z+
	k8DeFu3wlxquxk0Jsn7hIHZjWq2TmYaGFvCrd1/xXk1jUKgyliHRhTH6USSKsazGe0o59QY0IFDhP
	FxNVrtnQ==;
Received: from [187.56.70.103] (helo=[192.168.1.60])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1oKiMm-0011kP-W9; Sun, 07 Aug 2022 17:39:01 +0200
Message-ID: <5e9d4906-3601-f07d-a886-7a723c6867c8@igalia.com>
Date: Sun, 7 Aug 2022 12:38:33 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 03/13] firmware: google: Test spinlock on panic path to
 avoid lockups
Content-Language: en-US
To: kexec@lists.infradead.org, linux-efi@vger.kernel.org,
 Evan Green <evgreen@chromium.org>
Cc: pmladek@suse.com, bhe@redhat.com, akpm@linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
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
 Ard Biesheuvel <ardb@kernel.org>, Julius Werner <jwerner@chromium.org>,
 David Gow <davidgow@google.com>
References: <20220719195325.402745-1-gpiccoli@igalia.com>
 <20220719195325.402745-4-gpiccoli@igalia.com>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20220719195325.402745-4-gpiccoli@igalia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220807_083903_900594_C1FA9E01 
X-CRM114-Status: GOOD (  12.33  )
X-Mailman-Approved-At: Mon, 15 Aug 2022 10:10:48 -0700
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

On 19/07/2022 16:53, Guilherme G. Piccoli wrote:
> Currently the gsmi driver registers a panic notifier as well as
> reboot and die notifiers. The callbacks registered are called in
> atomic and very limited context - for instance, panic disables
> preemption and local IRQs, also all secondary CPUs (not executing
> the panic path) are shutdown.
> 
> With that said, taking a spinlock in this scenario is a dangerous
> invitation for lockup scenarios. So, fix that by checking if the
> spinlock is free to acquire in the panic notifier callback - if not,
> bail-out and avoid a potential hang.
> 
> Fixes: 74c5b31c6618 ("driver: Google EFI SMI")
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: David Gow <davidgow@google.com>
> Cc: Evan Green <evgreen@chromium.org>
> Cc: Julius Werner <jwerner@chromium.org>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> 
> ---
> 
> V2:
> - do not use spin_trylock anymore, to avoid messing with
> non-panic paths; now we just check the spinlock state in
> the panic notifier before taking it. Thanks Evan for the
> review/idea!
> 
>  drivers/firmware/google/gsmi.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> [...]

Hi Evan, do you think this one is good now, based on your previous review?

Appreciate any feedback!
Cheers,


Guilherme

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
