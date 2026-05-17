Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 741A4CD4F4A
	for <kexec@archiver.kernel.org>; Sun, 17 May 2026 18:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rMikKmjIRuhmCNsf7ga38/uSHQiRF0nG0AquMF025/Q=; b=ond3V0RK6RoS3RRze7+cor/qnK
	kCsimV9/YdVkBE8mUvVhtoujgeJBz4Zik49THYlyF7d/PL7sWKTeXCBNpNUVBc94hkmovCjmqSwkU
	ubL7+8i6ij0aSwU21Q/xkFFEnP07vmywRJxCuU3KwG2EUU+Oxlpa23JtHcEb29zstdFdKRwopNqd+
	WoSKXOGCHT0K1PT6zy6dxff+JwkMLhSSMVMvAcaj7Syblfdz6r4v/3xfIg+G4pVVKSPm6V/q2Iqrq
	Yln9mm41MhvHKKdIoUn4WGBtAVGkKNHsuCtmYkPtkBWO8XA3Mt/RG8DbnSjiLJK4I5ooOHkOClabp
	oLZxjJlw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOgav-0000000DGlY-3O0b;
	Sun, 17 May 2026 18:52:09 +0000
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOgas-0000000DGkm-2xzj
	for kexec@lists.infradead.org;
	Sun, 17 May 2026 18:52:07 +0000
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-51306c9f2a8so20247471cf.1
        for <kexec@lists.infradead.org>; Sun, 17 May 2026 11:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1779043925; x=1779648725; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rMikKmjIRuhmCNsf7ga38/uSHQiRF0nG0AquMF025/Q=;
        b=aJqUjVZViZ7U938KBaLKqnE28v54JH3HojEoeGS3sx0eZ6tnjeUwni6639GqTPT/Fp
         BWWeLss+1zvWz3jJY6P8tLpfRYFOzWZWD7NREEJmFNXt2gu0fu2vc559estZ6ZrvrVCR
         XzsHPBlP46GaiopCxHX4F1HWWPXO1qm14KCNhrVNKdfoFtD1kKj/FvQ1VkGifEPK50Ev
         n96AANsLgEBHI5f+Tyji+whYEeSZ2uVZB195cf2DpiFAVRR90Y06liwEMIJ0s6P2PW3d
         Y6SpxeyUmb0QHz3sfX/ou5BlmU0Tm8KTuKND87NPocbDt86QEA1XIAfG+1ISOSGgeyGW
         iCUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779043925; x=1779648725;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rMikKmjIRuhmCNsf7ga38/uSHQiRF0nG0AquMF025/Q=;
        b=PrQQrgZflT8tFqi66iZEZHprJFnQkCq7IAgllSCz62dP7HAy350kikTPV5JmxzKLs7
         I8Lyy47UuaiXXX5XcSaD8B0njBdkN9EoeVfFMpyUYdvS+Mjw635W3p4L+kEwK0pdZF4c
         dGjKA629aOOVl5juhrn2gMsHIbctpiHrvwjTtZlXpl+D8kjcrXBeuG3l5e17EKCxCZTS
         Jeu4wagxTS0UN4g9LW7MxNVYpDgoT8xYRp4uhNL8X50hiX2G1v8gVIp/5ctkRuS2u2qz
         sU2utKxUvMSBCHOVB6tVEAjcIRKln3I94dGZDNPMakNZylx1KX80fa0cbswfvLnRqslr
         RuSw==
X-Forwarded-Encrypted: i=1; AFNElJ/r7FXOYdDZuac4Lb2XehrMfg1bRG4fYlwZrpcmm+ZV1OLKg8HQDrhPFOupSqMuvfnSUSLU9w==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw1644BzJ1F5Jv6NBCdUTpVoG3jsUHLLGlKIeK/CLtIdjpZ9Eee
	c3q1u40/tUVbFNA/iTr2cWsgxJVfBFoXk8xRzmR51Pl0dYNNLCz5/8YyxOuixT167x4=
X-Gm-Gg: Acq92OFF48ogub3edNA8x5r8ivAMmxs7HhTxcIsnqt9nRTVAONnBB4Xj8CDyGeyw2MM
	GCkQ1efM0Uzj3et7NK7BtTtWZ1NDLuWz06YgUBeuneqXYHWyKc9j3TnZTlpITuLSqt5qSApYhuF
	u9yFKfl53AFQH8riM1qxSNKk1lUa/qgil4TaNQHEJaI0alvjGjyzcEtnOPCCvzWJPEWwsMSO1rn
	Fr3uKQ8DkQx4bS37MkJZA0JQp6RrfyYQ3OgBAxA+N+Gz5WC9mi/LmNWFD5LOhScAIFOZTaZMiwx
	rnO4Kmp8YkaO+3Kp44IPT3Qu6lKOylKBKDCyF2SdPDkqI/nZ622cGRXoAGG32IoPQZ06Rpu2RJ4
	w+KpPp9Bp/WmVrlhX+zZOj8BNpJzsmMfv+ImLSVpvHs6GHkLHWSNGWspiCAH6Hj2QGYXMTrcsjs
	FFAmwASbg3iqpPbtq8sYkudTshPo+F5pZ/sk5fizSWKQN7VuHJDqY=
X-Received: by 2002:a05:622a:6201:b0:50e:5819:d7e7 with SMTP id d75a77b69052e-51659ff8947mr173729421cf.3.1779043925075;
        Sun, 17 May 2026 11:52:05 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516456888f6sm114656631cf.3.2026.05.17.11.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 11:52:03 -0700 (PDT)
Date: Sun, 17 May 2026 18:52:02 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, 
	linux-kselftest@vger.kernel.org, shuah@kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org, 
	skhan@linuxfoundation.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	corbet@lwn.net, dmatlack@google.com, kexec@lists.infradead.org, 
	pratyush@kernel.org, skhawaja@google.com, graf@amazon.com
Subject: Re: [PATCH v2 05/10] liveupdate: defer session block allocation and
 PA setting
Message-ID: <agoL1Afx2cHUNmE9@plex>
References: <20260514222628.931312-1-pasha.tatashin@soleen.com>
 <20260514222628.931312-6-pasha.tatashin@soleen.com>
 <agn7XnuO7VU4eK52@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agn7XnuO7VU4eK52@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260517_115206_759021_C8054282 
X-CRM114-Status: GOOD (  16.28  )
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

On 05-17 20:31, Mike Rapoport wrote:
> On Thu, May 14, 2026 at 10:26:23PM +0000, Pasha Tatashin wrote:
> > Currently, luo_session_setup_outgoing() allocates the session block and
> > sets its physical address in the header immediately. With upcoming
> > dynamic block-based session management, this makes the first block
> > different from the rest. Move the allocation to where it is first needed.
> > 
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> 
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> 
> > ---
> > @@ -77,15 +77,16 @@
> >  
> >  /**
> >   * struct luo_session_header - Header struct for managing LUO sessions.
> > - * @count:      The number of sessions currently tracked in the @list.
> > - * @list:       The head of the linked list of `struct luo_session` instances.
> > - * @rwsem:      A read-write semaphore providing synchronized access to the
> > - *              session list and other fields in this structure.
> > - * @header_ser: The header data of serialization array.
> > - * @ser:        The serialized session data (an array of
> > - *              `struct luo_session_ser`).
> > - * @active:     Set to true when first initialized. If previous kernel did not
> > - *              send session data, active stays false for incoming.
> > + * @count:       The number of sessions currently tracked in the @list.
> > + * @list:        The head of the linked list of `struct luo_session` instances.
> > + * @rwsem:       A read-write semaphore providing synchronized access to the
> > + *               session list and other fields in this structure.
> > + * @header_ser:  The header data of serialization array.
> > + * @ser:         The serialized session data (an array of
> > + *               `struct luo_session_ser`).
> > + * @sessions_pa: Points to the location of sessions_pa within struct luo_ser.
> > + * @active:      Set to true when first initialized. If previous kernel did not
> > + *               send session data, active stays false for incoming.
> 
> Hmm, why addition of a single field changed the entire block? :/

Yes, I had to decide whether to shorten the field name or change the 
entire block. I opted for the latter. :-)

> 
> >   */
> >  struct luo_session_header {
> >  	long count;
> 
> -- 
> Sincerely yours,
> Mike.

