Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09A4DF532D4
	for <kexec@archiver.kernel.org>; Tue, 24 Mar 2026 06:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Mifv6lV/1vhl2tnAgC+pUhj48DLTv7wevR0+F6OEtI0=; b=cgrUJbtg82aMd1Y3R4lHmBZBUP
	LGhB+uiy3UYMA0SFXV7aQryHKkvcD+vz4QSskSF0+49Ifn3IpW0mCVQJi7KiBTYsgvUtg50932o4U
	5vzkA4GJZGKq1dkkIZ8XmzZHQXB8+V9hJHlgRpTMvjZ6gcqr9LjT1wi9Dgiqjq1mp5zzFeiHo1amt
	iQLmt7cZjeL/Fxyi/bASl4TTtajZOpbsq5bJg9Q5iGbEOc7XcTSsn2tOhRUocnMLAVL6J6H0O2U9Z
	RVqz8wkQ5nKvUKROoeowAqkiQMQJU2/RSD71lapcXTe9dJQk+Dak94Md1g/NjaORj18dPobH7rmee
	3Sdp+QHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4vMa-00000000lKa-3j8V;
	Tue, 24 Mar 2026 06:35:40 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4vMa-00000000lKR-0Hs4
	for kexec@bombadil.infradead.org;
	Tue, 24 Mar 2026 06:35:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=Mifv6lV/1vhl2tnAgC+pUhj48DLTv7wevR0+F6OEtI0=; b=UpGMUF8RU21KmqtmvC6Ad8ogN6
	NtYwsBtWviL7sFip2qZpbA7qOr8oSzfBlnF1qIC0Ix7FGOHlh78JNAff2N8cBgGsL+gQ9vVDdDtHb
	Vtf1yoBFcgCTwGo6VCM1gxApJYHwBRWddkEH4qJSWTEKmNe57inDL4ld4WTl795fQaXWgrNv8YVS1
	1x2/tecVjJxOknfCqoob5slpmVashV2CoSZr6EOb1eE1cnnEMJWj/mX+n7eVYGJaR5jMeE0CdRHox
	DTOhzIvZHaWW4KhYs1nsms9fun6Z7+TezHE16RLWmL8qFMsuKv8prwb76z+jXxJe5LB68CBbaVX4O
	a7fiZHRA==;
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4vMP-00000003J7v-39AY
	for kexec@lists.infradead.org;
	Tue, 24 Mar 2026 06:35:35 +0000
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-43a03cb1df9so961037f8f.1
        for <kexec@lists.infradead.org>; Mon, 23 Mar 2026 23:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774334125; x=1774938925; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mifv6lV/1vhl2tnAgC+pUhj48DLTv7wevR0+F6OEtI0=;
        b=Y/R/ZjAKuKpdTkpMeyc3ckcWpyhAZfPzYlJT2snOsFv4UUiS8/kFepNB9xwZF+Hyrh
         L9tnslBTS437ip+IxhXv3pP4/JCsQ8IMyrRnWZcxEjVRYuKho5mZyQUqpJdEMSH9Yoe5
         olnYvKPX+rYPbGzGqCd8mcIHDBYzgR9eV6McgTVx7xW0C4VrAhJuMvaOKDjx2w6nh/YG
         yx96Foi6N/d2fup8sfqC2xy3XJ7W10aIydSuXw7e5lALtTeb5DxAcVO1eSYfGe4BZLT8
         8HvtvrMISbK+QX/Ggy0o1EuYu7RvL+5sn8C63alyGbDS3y41FOQEVO4opxiK8XdTCkZi
         66wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774334125; x=1774938925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Mifv6lV/1vhl2tnAgC+pUhj48DLTv7wevR0+F6OEtI0=;
        b=cbVNrHA5c8xHS4E82PiWvuN9P65ddBfxC5u0ljXLe+IirqSN6GfvWUs1vppTuNwLj7
         E1pIPQeEjsc/TrBmbMIvOjUELhsbtJEZGQHjzNFMFapkzd4Lx6aFamiyou/6kEGFmAQO
         IAoPaMP0Pl6FSdOvSDtb9DkRvhQnSyD1NTgwFLXHbIlPqth5YSNDyg27H5L4GFpBRC5s
         ivxmP00qMxeBtgn6tjteMu3i3rAPvVhvHAFDtm2F4gcrydQGM8lUOl7PO1zVArxhPi7i
         wH1iBKdRc+1My0mD/IBso6XgameNHRNjip8Fg0g+YKaK6bXjRoMw1dflsLCCVrN2qZ/3
         bRQg==
X-Forwarded-Encrypted: i=1; AJvYcCUaDnq/xroGT4arczg2pFN+HLjMG9102YwYUXRIlceB+P56qcdDh4xGi2f1cNlObxlWuQfedw==@lists.infradead.org
X-Gm-Message-State: AOJu0YwMd19508N2YEtywEu21mg5fQYZ221JWLHne6IQnLHLMTKGTYsw
	BwNXJTMxMf39l6IKh8sRxz/LOyExFWUs0QSnGTu1x80152viDHn+Hr86eTLwjA==
X-Gm-Gg: ATEYQzzPX4J461QQrKFtjdXP/z87qZ4FTqJTwrJNvTfHK0hWiCRZQ2njuW8iRyxDcrl
	usfnOz350HHGcqrdTnnYQ2OBu5iFQr8sa8iwwZ0qMdXOfDDZ7bFrCi24QdgLqPEglOZRMoXbUDd
	rUDj7h/mK3w6AT6GYb3M2PwPHXSOR+CcCkvwUk5kNCM0ZJy71QK2fAmwJAbYbGgdfic+8m9PytK
	2djtLJlo4JGFntqMs9swUrVlxvay8vE6b2hUdH2YnKdH4DNkZkYsjJuW0DTXGvqPuaiI4uj1n4z
	Pm/6bL1P+g2pwaScD9lIrN5WNGvBWF+tJ7/oUf3wptre3DhfjbHE7GkBEEdXsXj5sNluvVx0Qh8
	kV1VLv8UQvX/muGACA/Pc6NrMRyjeSV752v2HQwWHEyJVjSNNqSlU0CFHxtz2urSe2kNTGuoLI5
	3dwO2s6uiUIQpkEkCY4p4=
X-Received: by 2002:a05:6000:1aca:b0:439:be78:e1e9 with SMTP id ffacd0b85a97d-43b6423fabamr24225594f8f.14.1774334124571;
        Mon, 23 Mar 2026 23:35:24 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-43b6470380asm34457509f8f.24.2026.03.23.23.35.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2026 23:35:23 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: ruanjinjie@huawei.com
Cc: devicetree@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	loongarch@lists.linux.dev,
	x86@kernel.org
Subject: Re: [PATCH v9 0/5] arm64/riscv: Add support for crashkernel CMA reservation
Date: Tue, 24 Mar 2026 09:35:18 +0300
Message-ID: <20260324063519.3258161-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260323072745.2481719-1-ruanjinjie@huawei.com>
References: <20260323072745.2481719-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260324_063533_145419_A101C1BF 
X-CRM114-Status: UNSURE (   5.26  )
X-CRM114-Notice: Please train this message.
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

Please, remove me from CC list in future versions of this patchset

-- 
Askar Safin

