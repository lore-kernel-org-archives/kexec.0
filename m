Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81733C282EC
	for <kexec@archiver.kernel.org>; Tue, 11 Mar 2025 12:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aISzCXBUSpl9Jdl7q1Wak8jR4Cx9Bei2SZjKv/F88EM=; b=sSutQqVIoTlI/xxo3MrKEdgYb9
	y2mpjdibYSFCjvefiMmi/DX9pzNNRGddPduKeBf0D97yM4yyKkuf1YGV6Jhk4esOY7LksxK7GI6+y
	w7ki7pK9jUaefHV3tHFvUN5J5wF+j2IGUVys8cQNn+fxObJuatfRpda1mumpN/mRnsFR1TcHj1S1D
	Q2jITA9+4CLDHj5dRHP4/jgSjpbZ3Gz7l1H1+qBCfS8EXfCX5a5Ba9fIqSFvGzTEEY+t2D6ukhA3y
	xZ+tsIZkseeuyAFvUoQrZxe3oUmBN54MGAH3o6qMmpfAjyElvqQ+nF2DIlgZA0nkuu7oTZJal7dZX
	RYIBTsnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1trz3e-00000005jme-0PDu;
	Tue, 11 Mar 2025 12:50:06 +0000
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tryu6-00000005gdt-2puJ
	for kexec@lists.infradead.org;
	Tue, 11 Mar 2025 12:40:16 +0000
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3911748893aso3278343f8f.3
        for <kexec@lists.infradead.org>; Tue, 11 Mar 2025 05:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741696813; x=1742301613; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aISzCXBUSpl9Jdl7q1Wak8jR4Cx9Bei2SZjKv/F88EM=;
        b=dcTh8h3wYluGikUTW/gko8mh212Z881KSbzc04nP2xvfE/+mZU9jYzG3ta9e22Lv2c
         gS7MRIHy8wxNlm1dRzyOVXcKEFCLWZwzsSp3IRvfYFVuTCqlAVl6RYDrUd0Nst2six79
         ck6/M2ci2BnqI7Bt5WcozRceEDGjgtlnlDRYaWl8jAbcOfHzI26kHBXSNlhYCXPUOFOa
         mF12UtdDO+eCMDG9tY6DuPKxa+vIo2RDvyogE68ZFYTyGiVfvYSKGtu8LgfwAuYCvTof
         lNYvolu+Z8EvYwZnYCNk6EFzIitoGub3ZGRtxgJHB1rySXmTI4U8aD2W6Sh/mlxO2oIi
         gw0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741696813; x=1742301613;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aISzCXBUSpl9Jdl7q1Wak8jR4Cx9Bei2SZjKv/F88EM=;
        b=ewLq6DzRq0ptYn4GY8OBE/r+3Zl0myXXWvFA6f+lSwyricShN9FKbDir7Jht/myq6p
         Qdep3v7sRVYQHqAXWK6KACh2LWn5Yz/Fs2uUlv5ytJNjxNZ1qhQmKQZMlmTUlZxPQLGI
         m4wYovSemMjjy1BkdymfDjtPpWCv+jEv9gMfmPLx/2VyihjI22dCG75/YS3Zro5zGQPS
         EJCdJEsjJEE/pzntL0Ypal1lZySyh4ggSq3H4IHBHLnbKv+JtkD8dXunbRTta8i22hsp
         TAMuqSQ0MMAZH1cyXpB+19qlokzC7D6KWW9FeSN/57p+vkKOnEIS+f2SN8NwJvhlBno+
         ygOA==
X-Forwarded-Encrypted: i=1; AJvYcCVJ493PBw2FrZnNCDnLeM9CTweaAQAyY/5VBMUvTs4sOcLbwa+OnhpLgJKAbYYCV43sx55kKw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx/RvqgZ/Ba1Ece8xKfzn3KEdo+tLFyr1i1YB8uobDwJNks3gDc
	/Aj7lH4oiYze7cgjxDcCuLKn67wiETpzjLJfeFPv1/4blIE7Sk8qCGCaReiT+2A=
X-Gm-Gg: ASbGnctHFCLk0d/YKBqeoN5bVMQ3+lVBbSg8KgN+jnzf/YaqFIwkdiEQfBSfLRJigci
	KERGnyiFzuKHgg1cp+vhcOTgWTgDA7YocaON0h3NLGGzo5ocQ79/Oegn2gONsStt4F9hDQRTfjL
	K41coBNihZh0aYtWfsek+p3QEDMTc+inLlf8/MJKQzNYncTmNDip7HUtW96TJH9O5l840PINZeL
	lDIID3pCWSJAkfbvIVJWZgSAioX8yo3YijIqjcjtXOTxd3ixfGvfRRqZwxpU6D3SwptKGpIsHmo
	6pjPuc6E1nLfX3dNRqf8mpysyOsyKmM8B1ewyzc14CiUGRM=
X-Google-Smtp-Source: AGHT+IH+hqLaIb0ak3/PDp2FI+P/Br6EuYDT0bw+M1n8JTY5wRGCazId9C1SCJxp8KfNPqmCL4R8NQ==
X-Received: by 2002:a05:6000:186b:b0:391:231b:8e0d with SMTP id ffacd0b85a97d-39132dc5632mr17143565f8f.39.1741696813238;
        Tue, 11 Mar 2025 05:40:13 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c1031e3sm17759906f8f.82.2025.03.11.05.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 05:40:12 -0700 (PDT)
Date: Tue, 11 Mar 2025 13:40:10 +0100
From: Petr Mladek <pmladek@suse.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Eric Biederman <ebiederm@xmission.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Todd E Brandt <todd.e.brandt@linux.intel.com>,
	Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH 0/5] printk: renaming some suspend/resume functions and
 one fix for unblanking
Message-ID: <Z9AvKmM4Li57-E2E@pathway.suse.cz>
References: <20250226-printk-renaming-v1-0-0b878577f2e6@suse.com>
 <Z9AShs1dEO0jrgjL@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9AShs1dEO0jrgjL@pathway.suse.cz>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250311_054014_713682_81D74CC4 
X-CRM114-Status: GOOD (  21.69  )
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

On Tue 2025-03-11 11:38:00, Petr Mladek wrote:
> On Wed 2025-02-26 16:59:00, Marcos Paulo de Souza wrote:
> > Hello, I've being working on some patches that help to clarify the suspend/resume
> > of printk machinery. The last patch on this patchset address one issue regarding
> > suspended consoles and blanking.
> > 
> > This is a part one patchset that I would like to see merged before I send more patches
> > that will rework the suspend flag (a global suspend flag istead of per console) and
> > the removal of CON_ENABLED flag later on (I've created a function that will forcibly)
> > register the console instead of using this flag.
> > 
> > Please review!
> > 
> > Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> 
> Looks good to me. I could fix the typos when pushing.
> 
> Well, there is one more thing. It seems that the simple graphic logger
> was merged for 6.14-rc1. And the console_stop()/console_start() API
> is used also in drivers/gpu/drm/clients/drm_log.c.
> 
> It is actually the code which motivated this rename, as already
> pointed out by John, see
> https://lore.kernel.org/lkml/ZyoNZfLT6tlVAWjO@pathway.suse.cz/
> 
> Well, I am going to update these two locations when pushing this
> as well. Let's just get this change done.

And I did as mentioned above.

JFYI, the patcheset has been committed into printk/linux.git,
branch for-6.15-console-suspend-api-cleanup.

Best Regards,
Petr

