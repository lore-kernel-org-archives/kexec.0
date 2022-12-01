Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFCCCC43217
	for <kexec@archiver.kernel.org>; Thu,  1 Dec 2022 14:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BhmPKNxcSnUQuNdjmezvgZo7vBlebOPjhA5nlCgRV0k=; b=AO1a1uG9a1Oaxt
	SW2MjceMeh1/rtHfFyKxN/kG59PW3RrvxfyPzY0/jnFmrWMrGN/wnv8dLiBBDK4B4dUTdsCiwXHsa
	Rk1VxwIG4Px7fbnipgWlP9zDYhw8RssZorYVs9/D0MkqWtWaK2N2xZAHpeCYp4yNfcLh+64xAE3l/
	/iV5sUNJnMNIao7Zzb/OXxGFvSCuAbXbGTArveWmtGJ8C4mzBhepPPiwRahAlwuhezXaqeBUMnbSD
	LNHFZ5fDOK2cY7EhOld3lsorLKYzMY8jE1NDhEtuuhXT3G7Pz8vFQ+sRrtZOKX4ldLaRBWOYaCPNC
	RDgwYzSbyP3hRaoASTDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0kcl-007wVK-Az; Thu, 01 Dec 2022 14:33:15 +0000
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0ji8-007igV-VC
	for kexec@lists.infradead.org; Thu, 01 Dec 2022 13:34:46 +0000
Received: by mail-pl1-x629.google.com with SMTP id k7so1655186pll.6
        for <kexec@lists.infradead.org>; Thu, 01 Dec 2022 05:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tKguKo1XmUP31FlNvdaT70p0o/lwuxyZc7lK6ytX1QU=;
        b=exIoeOCrlPb+Uw2FGLRsALkrLYWj9cDaTvcr81Evjsi5DXIR/uPZJTWsXlu/PiLLI3
         HTBr5t4pzsWnn6M0lC4H5pNT0n3aLXEpcSRixu/mfsu8XeXoSArYBYlbqRz6mRys5h3T
         IyXf+jqyVq8u6L+O/LqO4biBjWXlb+7RKXSc0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tKguKo1XmUP31FlNvdaT70p0o/lwuxyZc7lK6ytX1QU=;
        b=lC4v44tXALFO6+pPmi4njVbeEg2vUYIHN9HmfIZmONl1OiA6XrdiKvCx5f38SRsAbs
         1hqSfBSeYN4BhbodK3gp1Lt+I3AXat7EFov6oGz5cHKZ3ltolW8Nlry0qLAxuMHJEqij
         eKDCOq2KYzyqL0aKDegM8CR650cIwCWZLDy/wRlj4GFk+yaVtfSMjHKBDEayHNCXTrhO
         O0mnuaRKmgvMSO2Sa/I2f/V1SufMOlmLIeHkyHpyCcwLQDTT3Mgd5T43imeo9YBl74du
         CODep7NJsZeb9tLOx4pqB+eEWdnRatDkG3ketdAlwaIvS1AQmUucfkixKS8iMYYLkAAT
         s6YA==
X-Gm-Message-State: ANoB5pnbZ8PwzXuoQoqrYXBLzJIU5ri6u+OBDDx6OH++cVc+M3hR7c7K
	Q0vTWh8znktsUYShpjrgAY24xmZYpF5EgAO1ubM=
X-Google-Smtp-Source: AA0mqf4TOfsMYAKLqeFeaCNNDezv63fBhwFWXLjQ5+9FSN7o9+u0Q/3pDg/yBgFHxNh1hreMossPbw==
X-Received: by 2002:a17:90a:c78c:b0:213:bbb4:13ce with SMTP id gn12-20020a17090ac78c00b00213bbb413cemr68840434pjb.246.1669901682335;
        Thu, 01 Dec 2022 05:34:42 -0800 (PST)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com. [209.85.215.180])
        by smtp.gmail.com with ESMTPSA id d28-20020aa797bc000000b00571bdf45888sm3212216pfq.154.2022.12.01.05.34.38
        for <kexec@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Dec 2022 05:34:40 -0800 (PST)
Received: by mail-pg1-f180.google.com with SMTP id 136so1698864pga.1
        for <kexec@lists.infradead.org>; Thu, 01 Dec 2022 05:34:38 -0800 (PST)
X-Received: by 2002:a92:ca89:0:b0:302:385e:eeb4 with SMTP id
 t9-20020a92ca89000000b00302385eeeb4mr24829482ilo.66.1669901667796; Thu, 01
 Dec 2022 05:34:27 -0800 (PST)
MIME-Version: 1.0
References: <20221127-snd-freeze-v8-0-3bc02d09f2ce@chromium.org>
 <20221127-snd-freeze-v8-3-3bc02d09f2ce@chromium.org> <716e5175-7a44-7ae8-b6bb-10d9807552e6@suse.com>
 <CANiDSCtwSb50sjn5tM7jJ6W2UpeKzpuzng+RdJuywiC3-j2zdg@mail.gmail.com> <d3730d1d-6f92-700a-06c4-0e0a35e270b0@suse.com>
In-Reply-To: <d3730d1d-6f92-700a-06c4-0e0a35e270b0@suse.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 1 Dec 2022 14:34:16 +0100
X-Gmail-Original-Message-ID: <CANiDSCtm7dCst_atiWk=ZcK_D3=VzvD0+kWXVQr4gEn--JjGkw@mail.gmail.com>
Message-ID: <CANiDSCtm7dCst_atiWk=ZcK_D3=VzvD0+kWXVQr4gEn--JjGkw@mail.gmail.com>
Subject: Re: [PATCH v8 3/3] ASoC: SOF: Fix deadlock when shutdown a frozen userspace
To: Oliver Neukum <oneukum@suse.com>
Cc: Juergen Gross <jgross@suse.com>, Mark Brown <broonie@kernel.org>, 
	Chromeos Kdump <chromeos-kdump@google.com>, Daniel Baluta <daniel.baluta@nxp.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Len Brown <len.brown@intel.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
	Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Eric Biederman <ebiederm@xmission.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Jaroslav Kysela <perex@perex.cz>, Joel Fernandes <joel@joelfernandes.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
	Pavel Machek <pavel@ucw.cz>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, 
	Kai Vehmanen <kai.vehmanen@linux.intel.com>, Steven Rostedt <rostedt@goodmis.org>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Ingo Molnar <mingo@redhat.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Dexuan Cui <decui@microsoft.com>, Takashi Iwai <tiwai@suse.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Bard Liao <yung-chuan.liao@linux.intel.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
	kexec@lists.infradead.org, alsa-devel@alsa-project.org, 
	stable@vger.kernel.org, sound-open-firmware@alsa-project.org, 
	linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, 
	xen-devel@lists.xenproject.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221201_053445_028358_C9789569 
X-CRM114-Status: GOOD (  31.66  )
X-Mailman-Approved-At: Thu, 01 Dec 2022 06:33:14 -0800
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

Hi Oliver

On Thu, 1 Dec 2022 at 14:22, 'Oliver Neukum' via Chromeos Kdump
<chromeos-kdump@google.com> wrote:
>
> On 01.12.22 14:03, Ricardo Ribalda wrote:
>
> Hi,
>
> > This patchset does not modify this behaviour. It simply fixes the
> > stall for kexec().
> >
> > The  patch that introduced the stall:
> > 83bfc7e793b5 ("ASoC: SOF: core: unregister clients and machine drivers
> > in .shutdown")
>
> That patch is problematic. I would go as far as saying that
> it needs to be reverted.
>

It fixes a real issue. We have not had any complaints until we tried
to kexec in the platform.
I wont recommend reverting it until we have an alternative implementation.

kexec is far less common than suspend/reboot.

> > was sent as a generalised version of:
> > https://github.com/thesofproject/linux/pull/3388
> >
> > AFAIK, we would need a similar patch for every single board.... which
> > I am not sure it is doable in a reasonable timeframe.
> >
> > On the meantime this seems like a decent compromises. Yes, a
> > miss-behaving userspace can still stall during suspend, but that was
> > not introduced in this patch.
>
> Well, I mean if you know what wrong then I'd say at least return to
> a sanely broken state.
>
> The whole approach is wrong. You need to be able to deal with user
> space talking to removed devices by returning an error and keeping
> the resources association with the open file allocated until
> user space calls close()

In general, the whole shutdown is broken for all the subsystems ;).
It is a complicated issue. Users handling fds, devices with DMAs in
the middle of an operation, dma fences....

Unfortunately I am not that familiar with the sound subsystem to make
a proper patch for this.

>
>         Regards
>                 Oliver
>
>
>
> --
> You received this message because you are subscribed to the Google Groups "Chromeos Kdump" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to chromeos-kdump+unsubscribe@google.com.
> To view this discussion on the web, visit https://groups.google.com/a/google.com/d/msgid/chromeos-kdump/d3730d1d-6f92-700a-06c4-0e0a35e270b0%40suse.com.



-- 
Ricardo Ribalda

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
