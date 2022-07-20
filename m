Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C817FC19F2B
	for <kexec@archiver.kernel.org>; Mon,  1 Aug 2022 15:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=p+LqwSGY4UEXNrEAfcrKqZMy505zo5cPdqgByPbT2IM=; b=U/zKQ4EezUyCTo
	/TRwCBsZSUAxKjTa0XteXThqK63C2WLaRB2Ub9FbSj1LMrqVtPvoWJAJolMLao3u0eB5IgDTurOju
	Hb91/7WPeqA63L3tdiWV57t+bAqFO34DfyC1T3QnDGeeaLh+sjB5B134CIgAfeT3XFier19C1s/fA
	0wSlhWS+sjZFida2V6BsVkdKZijaBf5nu/fyJjPUb1pfUfl4tpJ37+Z6wU6C52Aax7lCG/aDsOGwW
	hegvVKS2O4LA8s0I8b7S86sk+Fi1rWpprBHSg+cE4h/U10kLdwa4abLz2AWitPNIDxU1O7etAKE07
	HwOkVIxXEs6x0vBiOgpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oIXaN-007XxX-Pl; Mon, 01 Aug 2022 15:44:03 +0000
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEIgC-00CpcZ-Ey
	for kexec@lists.infradead.org; Wed, 20 Jul 2022 23:00:33 +0000
Received: by mail-pj1-x102f.google.com with SMTP id gq7so2919501pjb.1
        for <kexec@lists.infradead.org>; Wed, 20 Jul 2022 16:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O60CXwG50CMNbFlPYhSbwiVpECXcVQR97MrNWudYYbU=;
        b=GV87zx+h1LsYC4vg5VgjnB9AbrOjX45i+veof+k4QSYkZQ54zna7rGlFeOH4O/Dx5u
         z32IGlZuePn4MH5P8UWLmLjFd1EmmjYN/+DWNoTMO1N3xjx7JwR59cN+qeQRNBnO7LKu
         IYZVMZFPCneCJ5lua2KLUs5BT//OUWtxsAgN51D6jfGjhFyN24iIzFoUUi4zYB7uwE3z
         B9GmsZUveR8gWujcMGePBGnnw4oU/rapQuenZ8yPATDmDwQxRoAnAd7Qc/We7bvqp5HS
         695RMT5n0WYh1A6MVbKKIcrv4wRyKEBDHHZi5y5Tm8rXNUOiPb+zL08D3wU/GXas45Rt
         sBzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O60CXwG50CMNbFlPYhSbwiVpECXcVQR97MrNWudYYbU=;
        b=7BMLvmZNNuOUaAAnd2Thu8IIG9dSEvBx4uL2nmaHuo4xmcYO8TvKZGJN5c85Oov+5Y
         odgqMTP3L8/yXUXU7/kHWsWhK1CvFRF0WjTMUPLat8M6vNZxAI0VgR4OZaB+Tvp62B2P
         kvkLgvc2TJWLymf+TK3+pgwfUBKVSTqLRqCHnMXQQYkODjUzN+z/CKx0tCNqIyFDuIel
         Wn9dzsXmSQSzYVsn+uE2hKyOFJiWcDkICDSR0fcmKVyVVV0HsG6Lks7IeULdxOX1jPUV
         2bm8W0IYpMukN2gF3AE62sUgykc+yri0UHSYsbnZkQFn7/SKf/+HiKLmn9NG6famj+ub
         8czw==
X-Gm-Message-State: AJIora8oUh3cMU6QcX2KE30+ANUDL6YiSCfwaExQZsIuo20dQ1GCG5dZ
	ksf11Op40OaJq0ZNtefFeoc=
X-Google-Smtp-Source: AGRyM1s87lbItSmnHSuhbYCOPsPC7+W+QdNmf7JWp1I8Kuwuy8PBsh19YZaIFJjUB1rZOtW9Pej3cg==
X-Received: by 2002:a17:902:aa0b:b0:16b:c4a6:1dc9 with SMTP id be11-20020a170902aa0b00b0016bc4a61dc9mr41133063plb.83.1658358013694;
        Wed, 20 Jul 2022 16:00:13 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id z2-20020aa79f82000000b005252ab25363sm149366pfr.206.2022.07.20.16.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 16:00:13 -0700 (PDT)
From: Florian Fainelli <f.fainelli@gmail.com>
To: bcm-kernel-feedback-list@broadcom.com,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	akpm@linux-foundation.org,
	bhe@redhat.com,
	pmladek@suse.com,
	kexec@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	x86@kernel.org,
	kernel-dev@igalia.com,
	kernel@gpiccoli.net,
	halves@canonical.com,
	fabiomirmar@gmail.com,
	alejandro.j.jimenez@oracle.com,
	andriy.shevchenko@linux.intel.com,
	arnd@arndb.de,
	bp@alien8.de,
	corbet@lwn.net,
	d.hatayama@jp.fujitsu.com,
	dave.hansen@linux.intel.com,
	dyoung@redhat.com,
	feng.tang@intel.com,
	gregkh@linuxfoundation.org,
	mikelley@microsoft.com,
	hidehiro.kawai.ez@hitachi.com,
	jgross@suse.com,
	john.ogness@linutronix.de,
	keescook@chromium.org,
	luto@kernel.org,
	mhiramat@kernel.org,
	mingo@redhat.com,
	paulmck@kernel.org,
	peterz@infradead.org,
	rostedt@goodmis.org,
	senozhatsky@chromium.org,
	stern@rowland.harvard.edu,
	tglx@linutronix.de,
	vgoyal@redhat.com,
	vkuznets@redhat.com,
	will@kernel.org,
	Brian Norris <computersforpeace@gmail.com>,
	Doug Berger <opendmb@gmail.com>,
	Justin Chen <justinpopo6@gmail.com>,
	Lee Jones <lee.jones@linaro.org>,
	Markus Mayer <mmayer@broadcom.com>
Subject: Re: [PATCH v2 04/13] soc: bcm: brcmstb: Document panic notifier action and remove useless header
Date: Wed, 20 Jul 2022 16:00:09 -0700
Message-Id: <20220720230009.2478166-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220719195325.402745-5-gpiccoli@igalia.com>
References: <20220719195325.402745-1-gpiccoli@igalia.com> <20220719195325.402745-5-gpiccoli@igalia.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220720_160032_518574_0B86301C 
X-CRM114-Status: GOOD (  13.11  )
X-Mailman-Approved-At: Mon, 01 Aug 2022 08:44:02 -0700
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

On Tue, 19 Jul 2022 16:53:17 -0300, "Guilherme G. Piccoli" <gpiccoli@igalia.com> wrote:
> The panic notifier of this driver is very simple code-wise, just a
> memory write to a special position with some numeric code. But this
> is not clear from the semantic point-of-view, and there is no public
> documentation about that either.
> 
> After discussing this in the mailing-lists [0] and having Florian
> explained it very well, document that in the code for the future
> generations asking the same questions. Also, while at it, remove
> a useless header.
> 
> [0] https://lore.kernel.org/lkml/781cafb0-8d06-8b56-907a-5175c2da196a@gmail.com
> 
> Cc: Brian Norris <computersforpeace@gmail.com>
> Cc: Doug Berger <opendmb@gmail.com>
> Cc: Justin Chen <justinpopo6@gmail.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Markus Mayer <mmayer@broadcom.com>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> 
> ---

Applied to https://github.com/Broadcom/stblinux/commits/drivers/next, thanks!
--
Florian

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
