Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D89FC4167B
	for <kexec@archiver.kernel.org>; Fri,  9 Dec 2022 16:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:
	In-Reply-To:Subject:cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SsIZmpQEZfC9QzeGP0dAIAFFjcfkZ7yNQcOe+FownK8=; b=oa4TNGPk0hvwsS
	lJ04m3fU/SpP9w9Z/wmObNJhRi1mIFBkZbMJ/qOeV1+GEL/WJ/WdO0GTOogu5UHKxneQV3QJleXo9
	CJktnLX72zDGZgv5pSUHzgdHkvUcItwEcPXLoDsVBn79ymyW5ZG4tfFqqm74QrdPkDPujEwoj99UN
	BBBPty9pAos4k9+wCLO0aGqMn7cFh77mxZuKBhR3bc/bwvTJiBHsBgPzzDK31H9xSiwxDCMWYbbay
	IDxvQjfFOL0zcKAbtIkVbSv8UeNyw3t7yNj/S0hyvcn1Sovw+SLfwPsM7+v1XefjUnrqKKYkkCAKE
	e6urGfP0s/buOjRuC0gg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p3fnd-009EtU-19; Fri, 09 Dec 2022 16:00:33 +0000
Received: from mga02.intel.com ([134.134.136.20])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p3bx8-007Esb-1x
	for kexec@lists.infradead.org; Fri, 09 Dec 2022 11:54:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670586846; x=1702122846;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=i6l99AsOk7Ek/fC/JJlzKRTZl8kQmivMJCaJu9pD6WY=;
  b=hQTzn2LyIPSe8KQnHl02l/jFceoN4kzfOTCrMVq1HebJPcUb9VUlEMqJ
   1sBSEFYnMalabsiOAjZvrAYhVUED9chmCjNmRj2Qn0rz+3HiREHer3gSm
   bjlbqy71R/FCYmXOSj3d73q9NyUr38n9HW7WrKJZplsHYhlKkHwDnSjJt
   YsQRUS8ADABGwWRaZ1wAjRmiJxd+txvD51pL3BiE0csr0D+lPIy2tZfQB
   LLlnpPnbhbr+Y1Z/F1fqsymtKSE10wEIvUA1yJwUCBoE3G31N9RcEdLx3
   VBxRfaLBrfNFbEEglmzVebqbRZeiSlYlrqslilzzQiP3hFAqTa1Gm1fGZ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10555"; a="305085953"
X-IronPort-AV: E=Sophos;i="5.96,230,1665471600"; 
   d="scan'208";a="305085953"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2022 03:53:59 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10555"; a="736191278"
X-IronPort-AV: E=Sophos;i="5.96,230,1665471600"; 
   d="scan'208";a="736191278"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2022 03:53:50 -0800
Date: Fri, 9 Dec 2022 13:53:31 +0200 (EET)
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@eliteleevi.tm.intel.com
To: Ricardo Ribalda <ribalda@chromium.org>
cc: Oliver Neukum <oneukum@suse.com>, Juergen Gross <jgross@suse.com>, 
    Mark Brown <broonie@kernel.org>, 
    Chromeos Kdump <chromeos-kdump@google.com>, 
    Daniel Baluta <daniel.baluta@nxp.com>, 
    Christophe Leroy <christophe.leroy@csgroup.eu>, 
    Len Brown <len.brown@intel.com>, Ard Biesheuvel <ardb@kernel.org>, 
    Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, 
    "Rafael J. Wysocki" <rafael@kernel.org>, 
    Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
    Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
    Eric Biederman <ebiederm@xmission.com>, 
    Dave Hansen <dave.hansen@linux.intel.com>, 
    Jaroslav Kysela <perex@perex.cz>, Joel Fernandes <joel@joelfernandes.org>, 
    Liam Girdwood <lgirdwood@gmail.com>, 
    Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
    Pavel Machek <pavel@ucw.cz>, 
    Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, 
    Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
    Steven Rostedt <rostedt@goodmis.org>, 
    "K. Y. Srinivasan" <kys@microsoft.com>, Ingo Molnar <mingo@redhat.com>, 
    Bjorn Helgaas <bhelgaas@google.com>, Dexuan Cui <decui@microsoft.com>, 
    Takashi Iwai <tiwai@suse.com>, "H. Peter Anvin" <hpa@zytor.com>, 
    Bard Liao <yung-chuan.liao@linux.intel.com>, 
    Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
    Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
    x86@kernel.org, kexec@lists.infradead.org, 
    Alsa-devel <alsa-devel@alsa-project.org>, stable@vger.kernel.org, 
    sound-open-firmware@alsa-project.org, linuxppc-dev@lists.ozlabs.org, 
    linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org, 
    linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
    linux-efi@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: Re: [PATCH v8 3/3] ASoC: SOF: Fix deadlock when shutdown a frozen
 userspace
In-Reply-To: <CANiDSCtm7dCst_atiWk=ZcK_D3=VzvD0+kWXVQr4gEn--JjGkw@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2212091349310.3532114@eliteleevi.tm.intel.com>
References: <20221127-snd-freeze-v8-0-3bc02d09f2ce@chromium.org> <20221127-snd-freeze-v8-3-3bc02d09f2ce@chromium.org> <716e5175-7a44-7ae8-b6bb-10d9807552e6@suse.com> <CANiDSCtwSb50sjn5tM7jJ6W2UpeKzpuzng+RdJuywiC3-j2zdg@mail.gmail.com>
 <d3730d1d-6f92-700a-06c4-0e0a35e270b0@suse.com> <CANiDSCtm7dCst_atiWk=ZcK_D3=VzvD0+kWXVQr4gEn--JjGkw@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221209_035406_178746_E2697B53 
X-CRM114-Status: GOOD (  19.31  )
X-Mailman-Approved-At: Fri, 09 Dec 2022 08:00:32 -0800
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

On Thu, 1 Dec 2022, Ricardo Ribalda wrote:

> On Thu, 1 Dec 2022 at 14:22, 'Oliver Neukum' via Chromeos Kdump <chromeos-kdump@google.com> wrote:
> >
> > On 01.12.22 14:03, Ricardo Ribalda wrote:
> > > This patchset does not modify this behaviour. It simply fixes the
> > > stall for kexec().
> > >
> > > The  patch that introduced the stall:
> > > 83bfc7e793b5 ("ASoC: SOF: core: unregister clients and machine drivers
> > > in .shutdown")
> >
> > That patch is problematic. I would go as far as saying that
> > it needs to be reverted.
> 
> It fixes a real issue. We have not had any complaints until we tried
> to kexec in the platform.
> I wont recommend reverting it until we have an alternative implementation.
> 
> kexec is far less common than suspend/reboot.

I've posted an alternative to ALSA list that reverts the problematic
patch and fixes the problem (the patch was originally addressing)
in a different way:

https://mailman.alsa-project.org/pipermail/alsa-devel/2022-December/209776.html

No changes outside sound/soc/ are needed with this approach.

Br, Kai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
