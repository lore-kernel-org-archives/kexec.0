Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63904C433FE
	for <kexec@archiver.kernel.org>; Wed, 30 Nov 2022 15:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=m7Vgi+FOleYF1IpY0sdmTKnCFDt9d+S3FyfDtY2wSTw=; b=ZTzen5skmDDEZc
	v0Wtxa350dHbJqncA6QOFQsuo08QVUnbR9kKHbEKxyhIh3FL+/mB2aNWO1lP2LMg6vA+KA2krr7CQ
	lGTRkrMhckGIZRIV6UNU8JRj2SnKOc9CwmcjvO6SdfqHnUYfrsaLbhtdEiu/Oq8F7gdYloT3PjRE2
	AjuNYGQ15a33LgMv5m+IfMzBdgoK/4zCdZ/by++uE3jX7RMyD/RIIHn+cZtdfRGStXsFy/+Y68DTK
	KlHc0WkJqD7pcVtSMTb/XsjeactM53Ry0oxQvn+iBTaxLEj/40ljeU/OMrWPvn2u5LqOjvTIMNKFv
	nTLR6LI/zN1oThG6BZoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0PPl-0009Pr-Jk; Wed, 30 Nov 2022 15:54:25 +0000
Received: from mga12.intel.com ([192.55.52.136])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0PPi-0009Ja-95
	for kexec@lists.infradead.org; Wed, 30 Nov 2022 15:54:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669823662; x=1701359662;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DepN27OpZlgbeuoWYTFKVyj3/uCClQNbsv2Ccqz0OMY=;
  b=RgTunAD5a8pg7Q+UP1a2KdnGTx0o1f5fS+zmnTn/Gbznpbr3583M7e42
   fe3344N21f9NyHtpkVBsStpS3Ne66cIoEIv//QaxIorugvadWl9twJqWN
   og6xs3/0lkdqs3IbouIjgXFQz0jfPEYrUlE5iQDAXdIbzf2VzSW7Ko+yn
   f7kQ8p44tW4WxGxLNCwe4AGEUeMPWeD23eav/YKfFvA4epbW7xtLdkhUG
   0A8O2uEvBwW/fvHXq5jOlUicDrWVrSx0/IjI7dR4OFNvvfNQUx4td+9HW
   nsmv7hwDm9EYEYxMukOiVk+4ehqmyeYvzmvRSmZCwgRlCDIJrU9TRZLO2
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="295126304"
X-IronPort-AV: E=Sophos;i="5.96,206,1665471600"; 
   d="scan'208";a="295126304"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 07:54:14 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="707693261"
X-IronPort-AV: E=Sophos;i="5.96,206,1665471600"; 
   d="scan'208";a="707693261"
Received: from schaud2-mobl1.amr.corp.intel.com (HELO [10.209.164.68]) ([10.209.164.68])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 07:54:12 -0800
Message-ID: <62a3dbbd-3144-d560-17de-cada6a34502b@linux.intel.com>
Date: Wed, 30 Nov 2022 09:54:11 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH v6 2/2] ASoC: SOF: Fix deadlock when shutdown a frozen
 userspace
Content-Language: en-US
To: Ricardo Ribalda <ribalda@chromium.org>,
 Chromeos Kdump <chromeos-kdump@google.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Eric Biederman <ebiederm@xmission.com>,
 Daniel Baluta <daniel.baluta@nxp.com>, Mark Brown <broonie@kernel.org>,
 Bard Liao <yung-chuan.liao@linux.intel.com>, Jaroslav Kysela
 <perex@perex.cz>, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Takashi Iwai <tiwai@suse.com>, Steven Rostedt <rostedt@goodmis.org>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 alsa-devel@alsa-project.org, kexec@lists.infradead.org,
 sound-open-firmware@alsa-project.org
References: <20221127-snd-freeze-v6-0-3e90553f64a5@chromium.org>
 <20221127-snd-freeze-v6-2-3e90553f64a5@chromium.org>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20221127-snd-freeze-v6-2-3e90553f64a5@chromium.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221130_075422_358769_6CF6399E 
X-CRM114-Status: GOOD (  11.28  )
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



On 11/30/22 09:47, Ricardo Ribalda wrote:
> During kexec(), the userspace is frozen. Therefore we cannot wait for it
> to complete.
> 
> Avoid running snd_sof_machine_unregister during shutdown.

That's not what you are doing below - you only unregister clients
conditionally.

I don't know if that's a stale commit message and can't reconcile it
either with the initial discussions in this thread where we were
referring to snd_card_disconnect(), etc?

Confused.

> @@ -484,7 +485,8 @@ int snd_sof_device_shutdown(struct device *dev)
>  	 * make sure clients and machine driver(s) are unregistered to force
>  	 * all userspace devices to be closed prior to the DSP shutdown sequence
>  	 */
> -	sof_unregister_clients(sdev);
> +	if (!kexec_with_frozen_processes())
> +		sof_unregister_clients(sdev);
>  
>  	snd_sof_machine_unregister(sdev, pdata);
>  
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
