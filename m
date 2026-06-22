Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4715BCDB46F
	for <kexec@archiver.kernel.org>; Mon, 22 Jun 2026 21:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Roz9Dy+zlT5uAEdwHyLVUBs67f/dm3PIYYU2IrNde9g=; b=Mo9JF8lKqEKWL7pqpDMenUICgb
	IczUIW9mbRGmdk1v69XW5bhGbjmS2+iowanm5CDh/H23Fi/UuS0XbHSEUTIw0B+4Aq57TvwY3DbJC
	WSJkz7hziKN1uJyn4MRpjFoktDcMPbkn4aYSOGx8ZZZ671Dx1QZg2siIRJ957ZcM95ft9KHXlLGoF
	7pADhhcwJZwhvmVh6oqqevW95F8Vd3kJyNxROaeD4uo+VnG99uvfhmAyMPH1cI0/BamcunHiBzLsc
	CH/tA7PZ1OyL/2yf73OgJF7biEYB6Jy+p2bUGWTiLhDquRl7y+Wbr/6ePFuSyo1rtSB5ecei9/aFv
	vT6v/YLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbmON-00000005PlX-0KhF;
	Mon, 22 Jun 2026 21:41:19 +0000
Received: from esa3.hc555-34.eu.iphmx.com ([207.54.77.50])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbmOJ-00000005Pl2-2ISn
	for kexec@lists.infradead.org;
	Mon, 22 Jun 2026 21:41:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1782164477; x=1813700477;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Roz9Dy+zlT5uAEdwHyLVUBs67f/dm3PIYYU2IrNde9g=;
  b=IZXRsoXIL8lGrj7uLqEpzVCtwkLI1doY3wJcC08J6Qbe2p7NIHPULhYs
   ALoPQOCg3mXe1EyKMELPDE2q8UTJqh3dQF54bRxht/ugulun6tsy2Kqm+
   wRKwyfcuOjqHdUaXCNhQC/HYL4KEl5EUX44JrLHsN6y5FvbryX2AuQfgV
   mzpnz2oAsrlaRdG8O4f7g9B5mRAsN0SobB/0fddP80oCTfKbytySRNtst
   WZVAh4hT/EK8XywpE5m0qfTVdRCfB+MqBQZuKZlvnHVTzfoEj62/p4Vxy
   vDWfHSTg/9lkd+gjzHWWpp8WRgZHY5NO5BMVYXsxsqSLfrK7HIfekb6cn
   Q==;
X-CSE-ConnectionGUID: nvxBwTvOTv2XgUJTzNFrXA==
X-CSE-MsgGUID: mrXhC/NNQi6uo/AgzGoq5w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces03_data.me-corp.lan) ([146.255.191.134])
  by esa3.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 00:41:15 +0300
X-CSE-ConnectionGUID: eF1eZxj/SYuH7rpsS1U86A==
X-CSE-MsgGUID: DJSYVZNZRRi4+lVVcIZOmw==
Received: from unknown (HELO epgd034.me-corp.lan) ([10.154.54.2])
  by ces03_data.me-corp.lan with SMTP; 23 Jun 2026 00:46:12 +0300
Received: by epgd034.me-corp.lan (sSMTP sendmail emulation); Tue, 23 Jun 2026 00:41:12 +0300
From: Pnina Feder <pnina.feder@mobileye.com>
To: pnina.feder@mobileye.com
Cc: horms@kernel.org,
	kexec@lists.infradead.org
Subject: Re: [PATCH] vmcore-tasks: lightweight task and backtrace extractor for vmcore files
Date: Tue, 23 Jun 2026 00:41:09 +0300
Message-ID: <20260622214109.3774253-1-pnina.feder@mobileye.com>
In-Reply-To: <20260622205550.1087163-1-pnina.feder@mobileye.com>
References: <20260622205550.1087163-1-pnina.feder@mobileye.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260622_144116_092909_B44732CB 
X-CRM114-Status: UNSURE (   6.03  )
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

This patch depends on the following linux-kernel patch series
which exports the new vmcoreinfo fields consumed here:

Link: https://lore.kernel.org/all/20260622211430.4008899-1-pnina.feder@mobileye.com/

