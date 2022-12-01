Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68721C43217
	for <kexec@archiver.kernel.org>; Thu,  1 Dec 2022 14:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Subject:Cc:To:From:Message-ID:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uzWxs7nXtG/L/z2iV4LTlgZwcGat5VbovzZUVkjAhUE=; b=2qhzX/2bxtgnRj
	AqGAJ34xqAVTXOOoUiOu8SyDQTsxC/hAU881m4bZpiD8ij74Pygts75WzRUYN8dvRtK1nagu4B6GN
	alUK7MFDb1rdCqkT574NaL7BZSRbnATCsnoGffSnoAoQ2wf9cQ1XwYjbqsM1OAsUPOzKZlyXJasKg
	N1EVqebkiOlonoyuBOYIJ6mkVCoHSNf95lDF+2tBeFTR9xpnozZcXHi4+TpFF2ghz+SxsOFKIXjU9
	CP+hD7DLk2+fs+BQvOeGVUyY3WSwQRFjPeQO5dMtuEdneXUcmqJRdtyRDY/w5R5bFXsVQB36GLmH/
	1EFh4eZzVr58lcBVNIng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0kdH-007wiQ-VN; Thu, 01 Dec 2022 14:33:47 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0jlu-007jlR-Eb
	for kexec@lists.infradead.org; Thu, 01 Dec 2022 13:38:40 +0000
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B988B21BD8;
	Thu,  1 Dec 2022 13:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1669901914; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EpPEbhYU/ZSzBergbxPG18rF6z3xaGTMJpY/KD4hdN0=;
	b=NqfMGu7TOFopplQnGWvsL3EJ6f6cvD2+3UqnIH9MgHg26FPG3wmd98hqR7V6xsdZ0c8Vke
	owU1O7TeMPowfni/Y4/f0++Diu8+bvrgj83AyE4Hl4Mhktx4gC0hH22a1j6phJ4cxlwt0g
	M51CMPmyt3PVadDP6oU7dmktdW+cvjE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1669901914;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EpPEbhYU/ZSzBergbxPG18rF6z3xaGTMJpY/KD4hdN0=;
	b=nw7rEaNxj44kK7pb8ca9iO9xzjrguRhX54wAGxllFfQlwK4FxfX2KJCahutRLs8Vm8Lynh
	/90IUhYauTmvsgBQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id F010C1320E;
	Thu,  1 Dec 2022 13:38:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap1.suse-dmz.suse.de with ESMTPSA
	id xfi6OVmuiGPRFwAAGKfGzw
	(envelope-from <tiwai@suse.de>); Thu, 01 Dec 2022 13:38:33 +0000
Date: Thu, 01 Dec 2022 14:38:33 +0100
Message-ID: <87v8mvmeg6.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Oliver Neukum <oneukum@suse.com>
Cc: Ricardo Ribalda <ribalda@chromium.org>,
	Juergen Gross <jgross@suse.com>,
	Mark Brown <broonie@kernel.org>,
	Chromeos Kdump <chromeos-kdump@google.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Len Brown <len.brown@intel.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Eric Biederman <ebiederm@xmission.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Joel Fernandes <joel@joelfernandes.org>,
	Liam Girdwood
 <lgirdwood@gmail.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Pavel Machek <pavel@ucw.cz>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	"K. Y. Srinivasan"
 <kys@microsoft.com>,
	Ingo Molnar <mingo@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dexuan Cui <decui@microsoft.com>,
	Takashi Iwai <tiwai@suse.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org,
	kexec@lists.infradead.org,
	alsa-devel@alsa-project.org,
	stable@vger.kernel.org,
	sound-open-firmware@alsa-project.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-hyperv@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org,
	xen-devel@lists.xenproject.org
Subject: Re: [PATCH v8 3/3] ASoC: SOF: Fix deadlock when shutdown a frozen userspace
In-Reply-To: <d3730d1d-6f92-700a-06c4-0e0a35e270b0@suse.com>
References: <20221127-snd-freeze-v8-0-3bc02d09f2ce@chromium.org>
	<20221127-snd-freeze-v8-3-3bc02d09f2ce@chromium.org>
	<716e5175-7a44-7ae8-b6bb-10d9807552e6@suse.com>
	<CANiDSCtwSb50sjn5tM7jJ6W2UpeKzpuzng+RdJuywiC3-j2zdg@mail.gmail.com>
	<d3730d1d-6f92-700a-06c4-0e0a35e270b0@suse.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221201_053838_680242_82481526 
X-CRM114-Status: GOOD (  31.54  )
X-Mailman-Approved-At: Thu, 01 Dec 2022 06:33:46 -0800
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

On Thu, 01 Dec 2022 14:22:12 +0100,
Oliver Neukum wrote:
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

... or fixed.

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

As I already mentioned in another thread, if the user-space action has
to be cut off, we just need to call snd_card_disconnect() instead
without sync.  A quick hack would be like below (totally untested and
might be wrong, though).

In anyway, Ricardo, please stop spinning too frequently; v8 in a few 
days is way too much, and now the recipient list became unmanageable.
Let's give people some time to review and consider a better solution
at first.


thanks,

Takashi

-- 8< --
--- a/sound/soc/sof/core.c
+++ b/sound/soc/sof/core.c
@@ -475,7 +475,7 @@ EXPORT_SYMBOL(snd_sof_device_remove);
 int snd_sof_device_shutdown(struct device *dev)
 {
 	struct snd_sof_dev *sdev = dev_get_drvdata(dev);
-	struct snd_sof_pdata *pdata = sdev->pdata;
+	struct snd_soc_component *component;
 
 	if (IS_ENABLED(CONFIG_SND_SOC_SOF_PROBE_WORK_QUEUE))
 		cancel_work_sync(&sdev->probe_work);
@@ -484,9 +484,9 @@ int snd_sof_device_shutdown(struct device *dev)
 	 * make sure clients and machine driver(s) are unregistered to force
 	 * all userspace devices to be closed prior to the DSP shutdown sequence
 	 */
-	sof_unregister_clients(sdev);
-
-	snd_sof_machine_unregister(sdev, pdata);
+	component = snd_soc_lookup_component(sdev->dev, NULL);
+	if (component && component->card && component->card->snd_card)
+		snd_card_disconnect(component->card->snd_card);
 
 	if (sdev->fw_state == SOF_FW_BOOT_COMPLETE)
 		return snd_sof_shutdown(sdev);





_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
