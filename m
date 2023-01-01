Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A196C4167B
	for <kexec@archiver.kernel.org>; Sun,  1 Jan 2023 20:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=E5sfeoCcuV7dWmA2Faq6woPnHKZ+11jEuClHBlyPkdI=; b=D8V8QBDl5uqsA8
	YMqSm5RFCBaroy5rxJcDMYosWzOX9JEWex9g9zirj4ttSuvOZme6w1roQKQWBdDWEAEqGnTfhzsCM
	7OCfpAB2fVd9ZfoT0/Jq5SE+WVCI+aHhZR7ZZDp48m/lea/tRgjAzaRRHhXDkNHkjgZzO676pjRfc
	AEAD3xlorzcD9ENsWByPwHdBIpDtPJn75jjcicmxvz6VlYA5IzSw1FEVCW26dy1gBsbJiIFMUwxwk
	2AEx5Y0l6LvjSej/S95rmUtCzGP0aJFt5AdJRbD7eE1mdEb0gRkUwXzJDUT56e3/GuMoIQsM1mKGJ
	7Z7g7NAeKMStWBjekOhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pC4nt-004ce1-Ds; Sun, 01 Jan 2023 20:19:37 +0000
Received: from bee.tesarici.cz ([77.93.223.253])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pC4dU-004UbC-5p
	for kexec@lists.infradead.org; Sun, 01 Jan 2023 20:08:50 +0000
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 8CC8012AAA3;
	Sun,  1 Jan 2023 21:08:35 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
	t=1672603715; bh=ksrrnhlf2F6/nQN1F2t1aD2efNdtMH5VDXg092+/TCc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lWWKEpvE1IQz3M64Y3wHssh+1OdQ5limQrpmCVteqTfDqdDITMriuzbgWVp3jkE9F
	 NvYcCTPq4ENCixrxWwz3WDajJlIt0xiJ8FJbN45V0BvFT1VFVcy1qKybJ0YQGiHK13
	 +sndgdSQOYKPQ/Qf76gM3I/IxxJX6w6hOswvOv7Xvjyfz+acWnfwlPB/TA8o+Kb78a
	 1wTnWX1VNAioPK6ij1/p6fE2vUWKulo2cjsIsICOp1PoQ6Cev/mFZQOPO5/HzoYoQg
	 mC6WOw1BZPk0if3z6EvaL/JO7FwywxO79gb+vDIQyDez/ysaL2mv2BA4iHaLQ0cEsk
	 xBxxOfo54lF9w==
Date: Sun, 1 Jan 2023 21:08:33 +0100
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Ricardo Ribalda <ribalda@chromium.org>
Subject: Re: [PATCH v5 3/3] kexec: Introduce sysctl parameters
 kexec_load_limit_*
Message-ID: <20230101210833.6878b6a4@meshulam.tesarici.cz>
In-Reply-To: <20221114-disable-kexec-reset-v5-3-1bd37caf3c75@chromium.org>
References: <20221114-disable-kexec-reset-v5-0-1bd37caf3c75@chromium.org>
	<20221114-disable-kexec-reset-v5-3-1bd37caf3c75@chromium.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-suse-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230101_120848_842782_645BBB56 
X-CRM114-Status: GOOD (  22.20  )
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
Cc: linux-doc@vger.kernel.org, Sergey Senozhatsky <senozhatsky@chromium.org>, Philipp Rudo <prudo@redhat.com>, Jonathan Corbet <corbet@lwn.net>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Eric Biederman <ebiederm@xmission.com>, Ross Zwisler <zwisler@kernel.org>, "Joel Fernandes \(Google\)" <joel@joelfernandes.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hi Ricardo,

On Wed, 21 Dec 2022 20:45:59 +0100
Ricardo Ribalda <ribalda@chromium.org> wrote:

> Add two parameters to specify how many times a kexec kernel can be loaded.
> 
> The sysadmin can set different limits for kexec panic and kexec reboot
> kernels.
> 
> The value can be modified at runtime via sysctl, but only with a value
> smaller than the current one (except -1).
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  Documentation/admin-guide/sysctl/kernel.rst | 18 ++++++
>  include/linux/kexec.h                       |  2 +-
>  kernel/kexec.c                              |  4 +-
>  kernel/kexec_core.c                         | 87 ++++++++++++++++++++++++++++-
>  kernel/kexec_file.c                         | 11 ++--
>  5 files changed, 114 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
> index 97394bd9d065..a3922dffbd47 100644
> --- a/Documentation/admin-guide/sysctl/kernel.rst
> +++ b/Documentation/admin-guide/sysctl/kernel.rst
> @@ -461,6 +461,24 @@ allowing a system to set up (and later use) an image without it being
>  altered.
>  Generally used together with the `modules_disabled`_ sysctl.
>  
> +kexec_load_limit_panic
> +======================
> +
> +This parameter specifies a limit to the number of times the syscalls
> +``kexec_load`` and ``kexec_file_load`` can be called with a crash
> +image. It can only be set with a more restrictive value than the
> +current one.
> +
> +=  =============================================================
> +-1 Unlimited calls to kexec. This is the default setting.
> +N  Number of calls left.
> +=  =============================================================
> +
> +kexec_load_limit_reboot
> +======================
> +
> +Similar functionality as ``kexec_load_limit_panic``, but for a crash
> +image.

Is this description correct? IIUC the ``kexec_load_limit_panic`` is for
the crash image, and ``kexec_load_limit_reboot`` is for the normal
image, but the sentence above says again: "for a crash image."

Petr T

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
