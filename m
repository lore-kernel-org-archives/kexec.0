Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CFB7CA5FA2
	for <kexec@archiver.kernel.org>; Mon, 28 Sep 2026 15:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:
	From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=L7d9v+dnfa33+IGduUY6om25xsOtSS5Ke8pK1c1zkhs=; b=uL0D5skAiQUnCDF9BrubshKjpB
	F+zy6cvnUyYxoYOlN0/A4ZVXxraiN+7aGmSq1LXqCcIKsv0UEQuy+osyIA5wSA+nyvaJJZVnGuC1Q
	MEx25RiD4haYPX2dY1DQ1c615sYegBkWlxqVQBziFbKdmXxZ2LnqvSrWFVAwCmwZK5MVo4A/amrV4
	LBDWHyZbeg0+3ZaPUXSLtBvDvtWww5blWOF8DyCJ7BYWbJGQxN+pYU6W92NN0dCa+DfBM68dAbLrd
	FsbGRgiizud+yDquuMzkh+L2ZJZAZNb7sW3DQoO4vi/DsZUYTQVKykmdwGFBdbe254s2CS4I+sm2K
	n6SvwtvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBDZ8-00000000wQ6-3uJo;
	Mon, 28 Sep 2026 15:46:54 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBDZ6-00000000wPr-3OKr
	for kexec@bombadil.infradead.org;
	Mon, 28 Sep 2026 15:46:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description;
	bh=L7d9v+dnfa33+IGduUY6om25xsOtSS5Ke8pK1c1zkhs=; b=pwENwZtNPk4ruRk69CVo8BYQJF
	uDeUIPrjiLDVz89HoKRHsTq61x1BABEmWd7tChC2w0Gh1tds2+Rk6ducjjA67ZM4MK0LwCulsm5aH
	jNKN19yWktnsNRrLU6rtVXV5TxrtfnX0oryL5v57vXQ1q8AT557XXYE9+O0fuH2SiTp5/AMatg5w7
	sEUJ8uxsLQiJdtX0Fcmr/iqg/xumdbgxdv6HgYqJPIlXDTCle3lDJJvDAgwW9zPuGVfGYwhEsK3LL
	90YoNdTv3cEUrAvAL9pw1eVIcWNfDrf2xnCigoNaLqGRYnLu6DV08dSBicO9v5jCBTnZ8wYJBfcS9
	3FBD3Xxg==;
Received: from mail-yx2-x10.google.com ([2607:f8b0:4864:41::10])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1xBDZ3-00000001dvJ-2xU0
	for kexec@lists.infradead.org;
	Mon, 28 Sep 2026 15:46:51 +0000
Received: by mail-yx2-x10.google.com with SMTP id 956f58d0204a3-66e4aa8d881so3162548d50.1
        for <kexec@lists.infradead.org>; Mon, 28 Sep 2026 08:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1790610407; x=1791215207; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L7d9v+dnfa33+IGduUY6om25xsOtSS5Ke8pK1c1zkhs=;
        b=BV3V170gmrG30j1wc5JmesWLvja4E9Jf8jkS0P5NPZ6TwxaQlf4ywas+NL+Lm9l/Zi
         eqEC3qqMq92d4RoP+YTWCdPJvds7GzjhSG9Q6b3iBS9BaQ8p3T5NzBNM5DTmzFryRvMQ
         +SebgMr5NePREFkqfr2ZdtN830WCL33ZB3coo8I88/3qmy1ijq4loG2pnFpwerLvYl82
         Ia4nChD/s7vFyQKUlPSDnikXVFJjZE4PxivMRRLNoT9tFWSjbtmW1sVB2La0ziOEb08m
         JVEdk6KiKYDJX+MAQwWqfo2HYL+fbc+EJ2wfmSSsos+wnxPRUfvg6EW35AYF/LUBk0on
         Ztpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790610407; x=1791215207;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L7d9v+dnfa33+IGduUY6om25xsOtSS5Ke8pK1c1zkhs=;
        b=qe06RNq7o0Uu/YQi9hw0pri06oqc1H58j0JwczF8b5R/khkQO3N7EHvq6LeLCG1NKA
         EIQ7cber4ASYsXP6jv+kk14M0sQ5qwjsyQQoUvLRWNvyjoDgBv0apf7noilJF6c6s/y2
         YJ8tDxgkYqEhKHaBG7Q0v93IoCK/csxlIve6YW9OGNj8Yg7sD9RlR+xo4ks3cmNTQl17
         9laGlYwE1jJt6LLaQqqFZqz4hAsDvmog8IbCZRmf9BrgmrjfJV6n5FPx5C/H32yHuVhv
         kZ3UnXdwKUy+mfEfjP35/LfhTGrAARBOsmYxVu5jGNSueM+HlWCdDBPtcgLUvwwYsBpH
         vQmg==
X-Gm-Message-State: AFq9FYIlK2JuMavPdx0vYKPHOWYwVnilEdMT65wWb83apJ6/lKKCNNLv
	hhgqfqVtT7ivzmXSOxJU5X263xeZ/5WTIw14mhy2/FUJ4VpZ8hTz2lbAWWZbPVIR3AFCWcLSqQd
	aiHU7NuM=
X-Gm-Gg: AYBFou31qNt5z0xiUo4uiQqpq6nAq0X7jze/V8SCfVBvzBHJYeVM+UDaH85QwIzS0Zl
	wMw7NHGaHH6etbjjvLK7yepwbUt5YwIxROZrba2TeKISqkk/NfdQanzYMML7m8AVDxqFJDLbFXb
	Bhbni/o1ezhDTpa7KMMZ+mXON1+t+Dp1joMdZdWpgjiTKEM5zWmmwOw8H09JvbT+jefP7C40wdQ
	3ebE+iLuT5NluP3iVaoYqJPZVen3la3suxidpNt6pwnJ6ArippyW9YvQhKGO+N/YFZfCd/H+xJ7
	G1D4Xjt0gXeQk8TJJ2kri8cSYPL4K6O+4sKXo8Q50k6/u6M5mlMvxaaBGuP5eUGKojKSIapDjwa
	gKIKVQbVxJnsM3xq+0UDCIccUaoP36jzwzQ5Mgbr4/SjYv07OmqikxysQI/x8GHTYgJG9TKb6qn
	PbMBRp0gn1dMjzE6zK6RFM+aoF2hk6F1CNZ265SCPXB5N8v/6KIDVWqmn0E27Q5eoWpqp3SvYHy
	nQqT+MKxhWb5Pl4+i8iSIGBdHvR1gVpF++y
X-Received: by 2002:a05:690e:4093:b0:675:3247:9b40 with SMTP id 956f58d0204a3-6753247a525mr2940923d50.65.1790610407271;
        Mon, 28 Sep 2026 08:46:47 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91430e281a8sm82875936d6.33.2026.09.28.08.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 08:46:46 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: kexec@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-pci@vger.kernel.org,
	David Matlack <dmatlack@google.com>
Subject: Re: [PATCH v9 00/13] PCI: liveupdate: PCI core support for Live Update
Date: Mon, 28 Sep 2026 15:46:43 +0000
Message-ID: <179061032462.173069.6066907606098407222.b4-ty@b4>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260918200640.887030-1-dmatlack@google.com>
References: <20260918200640.887030-1-dmatlack@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260928_164649_867044_9394B868 
X-CRM114-Status: GOOD (  11.77  )
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


On Fri, 18 Sep 2026 20:06:26 +0000, David Matlack wrote:
> This series can be found on GitHub:
> 
>   https://github.com/dmatlack/linux/tree/liveupdate/pci/base/v9
> 
> This series introduces support in the PCI core for Live Update, enabling
> drivers to preserve PCI devices across a kexec-based kernel update
> without interrupting the device. This functionality is critical for
> minimizing downtime in environments where PCI devices (e.g., those
> assigned to VMs via VFIO) must continue operating or maintain state
> across a host kernel upgrade.
> 
> [...]

Applied, thanks!

https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git/log/?h=lu-pci-preservation

[01/13] PCI: liveupdate: Set up FLB handler for the PCI core
        commit: b9affdf3de08c9e5fd8dca0c0bc9c54041362a10
[02/13] PCI: liveupdate: Track outgoing preserved PCI devices
        commit: b7163342c1d4090bdd3eace61580197b2372bd34
[03/13] PCI: liveupdate: Track incoming preserved PCI devices
        commit: 16c1ff9563333530f97888fca4e48548b22ce282
[04/13] PCI: liveupdate: Document driver binding responsibilities
        commit: c7c6bc42b3eebba0562d128b5a578bfbe6a56d31
[05/13] PCI: liveupdate: Auto-preserve upstream bridges across Live Update
        commit: 6f58dec26ea52b6451b3b427caa3326b407883a1
[06/13] PCI: liveupdate: Preserve bus numbers during Live Update
        commit: ec2f2f51120b9461db0e04a7fb1fcdd9747fd96f
[07/13] PCI: Refactor matching logic for pci_dev_acs_ops
        commit: 05d208bda0fd3ef41c3452d1c3f5b365c75b59ae
[08/13] PCI: Save and restore the ACS Control register
        commit: 9f2072fd93310487bf3f51bd61f73ed722be3cc0
[09/13] PCI: liveupdate: Adopt ACS controls in incoming preserved devices
        commit: 16709a37292e480a2d560242d88ba400e0793706
[10/13] PCI: liveupdate: Adopt ARI Forwarding Enable on preserved bridges
        commit: f20575f35fd9ae63f80bc672fc6b31e4de12d4f7
[11/13] PCI: liveupdate: Freeze preservation status during shutdown
        commit: f6590754926ecb0f9119f82a08ef073038ca3293
[12/13] PCI: liveupdate: Do not disable bus mastering on preserved devices during kexec
        commit: 25ff6ea537fa2c1258cb73d57f11d6af51ec7f8c
[13/13] Documentation: PCI: Add documentation for Live Update
        commit: 3b4d450a5bff74e36b4c9e864c0ba7d08288941d

Best regards,
-- 
Pasha Tatashin <pasha.tatashin@soleen.com>

