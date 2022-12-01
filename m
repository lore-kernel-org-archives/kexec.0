Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D4BCC43217
	for <kexec@archiver.kernel.org>; Thu,  1 Dec 2022 09:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:
	In-Reply-To:Subject:cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Cqqt8Ws5D7Sgq3BIaayufwUaTu+R8gs6gqWZZNw0xgA=; b=DDc8ybP6mbCl2G
	8wpBvIsMwz6r623HjF+sytjnkJOkKabBJ4JpslEOSt1TF0v6HuH/q93zmE0ApSx3HFdif0c6EvxBm
	iTQdEuBAowvpB4lMWqfBEwhCnz0oPO4tlCKUMDozw79CVZRxkZHXk/tXmbgn7v856gOLpjhF8VuDx
	+zLQz6DFrQfZ2bSHxn0M6rPD4dgMsScOv1bP59jACQdue9aX6jsyosFK70Sr/UmZXUNCGqg5IzlCL
	3k0DHqC3QY/qvLw2d/n7plu/aV11YrFjAeC7Z8OX3izZSChq/Hyj5uVTgUfBALt7FL4/aJ32MABdq
	8sAw/ujDZ8wcZLlcEYhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0fUk-0069cI-1y; Thu, 01 Dec 2022 09:04:38 +0000
Received: from mga03.intel.com ([134.134.136.65])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0fUG-0069GR-Gg
	for kexec@lists.infradead.org; Thu, 01 Dec 2022 09:04:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669885448; x=1701421448;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=v7Pv5GvsnRCoGfNqd6OZfahTWZAr3UlME0JbK+tDt9s=;
  b=lQyHAVvkbfCxJpTvD7yN86OMX7ngTWjo8ZrRrmzJEwObL9XS57bIxUVU
   xHXIifun9Ks5NqK7toPsFVVhqHd8XpjkDRxQB2p+qTpxPVowpglviyTAV
   aGgIYgOTfh7GxATH8SDG9f10Roi6Ry3MD7mMuGgc2Q5kxhjWbdpAfGB3g
   KoXMeOkRMUxG8De1KsN0sku/6u6VfQU4rhsXS/JuaKqXLjHAASDBGSbyJ
   I2IZUtVmnw3pKuU4GRzox9US0Mn7Fcq1BrOhexYD/CCvmPC7ITMrOyc+l
   BHyL/MyymwyQsR5dCHjOXUPzx6Zkaup+FzEsK4RoCeq08jF4yNLnsHYS9
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="317492468"
X-IronPort-AV: E=Sophos;i="5.96,209,1665471600"; 
   d="scan'208";a="317492468"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 01:04:04 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="750716088"
X-IronPort-AV: E=Sophos;i="5.96,209,1665471600"; 
   d="scan'208";a="750716088"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 01:03:59 -0800
Date: Thu, 1 Dec 2022 11:03:46 +0200 (EET)
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@eliteleevi.tm.intel.com
To: Ricardo Ribalda <ribalda@chromium.org>
cc: Steven Rostedt <rostedt@goodmis.org>, 
    Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
    Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, 
    Jaroslav Kysela <perex@perex.cz>, 
    Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
    Chromeos Kdump <chromeos-kdump@google.com>, 
    Mark Brown <broonie@kernel.org>, 
    Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, 
    Eric Biederman <ebiederm@xmission.com>, 
    Bard Liao <yung-chuan.liao@linux.intel.com>, 
    Daniel Baluta <daniel.baluta@nxp.com>, Liam Girdwood <lgirdwood@gmail.com>, 
    Takashi Iwai <tiwai@suse.com>, Alsa-devel <alsa-devel@alsa-project.org>, 
    sound-open-firmware@alsa-project.org, kexec@lists.infradead.org, 
    stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/2] ASoC: SOF: Fix deadlock when shutdown a frozen
 userspace
In-Reply-To: <20221127-snd-freeze-v7-2-127c582f1ca4@chromium.org>
Message-ID: <alpine.DEB.2.22.394.2212011053540.3532114@eliteleevi.tm.intel.com>
References: <20221127-snd-freeze-v7-0-127c582f1ca4@chromium.org> <20221127-snd-freeze-v7-2-127c582f1ca4@chromium.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221201_010408_724518_51CCB0A6 
X-CRM114-Status: GOOD (  13.31  )
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

Hi,

On Wed, 30 Nov 2022, Ricardo Ribalda wrote:

> During kexec(), the userspace might frozen. Therefore we cannot wait
> for it to complete.
[...]
> --- a/sound/soc/sof/core.c
> +++ b/sound/soc/sof/core.c
> @@ -9,6 +9,7 @@
>  //
>  
>  #include <linux/firmware.h>
> +#include <linux/kexec.h>
>  #include <linux/module.h>
>  #include <sound/soc.h>
>  #include <sound/sof.h>
> @@ -484,7 +485,8 @@ int snd_sof_device_shutdown(struct device *dev)
>  	 * make sure clients and machine driver(s) are unregistered to force
>  	 * all userspace devices to be closed prior to the DSP shutdown sequence
>  	 */
> -	sof_unregister_clients(sdev);
> +	if (!kexec_with_frozen_processes())
> +		sof_unregister_clients(sdev);
>  
>  	snd_sof_machine_unregister(sdev, pdata);

I think the case you hit was specifically snd_card_disconnect_sync() that 
gets called via snd_sof_machine_unregister(), right, so you'd have to skip 
both sof_unregister_clients() and the machine_unregister().

Skipping ok might be an ok solution here. There's clearly a problem and we 
cannot just drop these calls in the general case (when we are going to 
S5), but in the specific case of kexec, this is probably safe. And I agree 
one way or another this needs to be fixed. Pierre and others what do you 
think?

Br, Kai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
