Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34D23CA5FE2
	for <kexec@archiver.kernel.org>; Mon,  5 Oct 2026 04:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Message-ID:Date:References:In-Reply-To
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KCfCPAeQ2dsseQwbHe228EObJTEGbDN83Xg76shbAkU=; b=OsavCGwL67vlcF4KzfAJwnA0wl
	e9uU3uHDvPZs4phFrzT+tYZcn9aogaT0tJ9FloHsk+KfkLc3OYLdDS71yJUVpktE+ghuCrP/r9NZo
	MCpe4qbzGxVFKHxh9djcgrINnXtDK6V2TWQJZ8tex9Y0ZYlrLmlsih+Vfr78DOjDio6Fqt0rb0Of9
	k4ynN6ntu7nFOs+c35U9dWctp+ZPNQXldpBR/2zcqewOsICLkHCPpldDgySmyGDNCo9TTzMVQzZyD
	u7avnIYlULZrNCNhlmV3AcnwBtojRjmMCTgaNOeQCG+0npJyub5lcE9D8PSV6qfeCvp95bfLEuDV3
	sVhXC+bg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xDZxo-0000000Fdpg-1KHv;
	Mon, 05 Oct 2026 04:06:08 +0000
Received: from sender-op-o15.zoho.eu ([136.143.169.15])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xDZxl-0000000FdpE-2CMR;
	Mon, 05 Oct 2026 04:06:07 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1791173148; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=SwmUQkGBNrCNT8h7YxNxVq1RdmSI27hn/XMwSeMr8Au0APQa7PWgX7u8B7Q+sV/dspD/kT/Eo0ZJawvCoKkKXvPN6usue5+BGDQq9Rz+ZXveSWwNKpoo+yvutqG0tVWdZaPgOz+oDyUSZWQ4rTvBPUhsGeoxMmhEpA9mhu68jEk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1791173148; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=KCfCPAeQ2dsseQwbHe228EObJTEGbDN83Xg76shbAkU=; 
	b=YT8jGJ9W8GSyrJlyCO84nfgw/6y5hzNO/tBwdAq/0ICaUnBmZ6QDo/nn5ihcvljS0wePcev1IqY00xse4a7KMxshJcFxThMEXNzbn3eqRTzceoDTHI5uCZ4mk+rOWFt1XA1vN9GPsVj8hGF1K0X4DXkQxI3b1VE+1j+m6jJ0dq4=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iav.lv;
	spf=pass  smtp.mailfrom=iav@iav.lv;
	dmarc=pass header.from=<iav@iav.lv>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791173148;
	s=zoho; d=iav.lv; i=iav@iav.lv;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:Date:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=KCfCPAeQ2dsseQwbHe228EObJTEGbDN83Xg76shbAkU=;
	b=bqbiKfi8xG3NedUxaGgDpRaZjBSIkAhXc1byN5HWAr+MGrRYJhbhCc38+tjxqtgI
	5KJRrZefr3f4CKJq7IlrA8v6uyUV4LnV40ZUcE+LJdp/dPME/LuecdXyN/+jKH+c7hL
	nIXCOKMaObwYVL6rybImgnJhNmQx/Ui11/pAAgKo=
Received: by smtp.zoho.eu with SMTPS id 1791173145981475.33248736530936;
	Mon, 5 Oct 2026 06:05:45 +0200 (CEST)
From: Igor Velkov <iav@iav.lv>
To: Thomas Gleixner <tglx@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, Radu Rendec <radu@rendec.net>,
 Marc Zyngier <maz@kernel.org>, Eliav Farber <farbere@amazon.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Baoquan He <baoquan.he@linux.dev>,
 Heiko Stuebner <heiko@sntech.de>, kexec@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Igor Velkov <iav@iav.lv>
Subject: Re: [PATCH RFC] genirq/kexec: Do not take the bus lock of an interrupt chip on the crash path
In-Reply-To: <20261005014155.BD56B1F000FF@smtp.kernel.org>
References: <20261005-kexec-irq-bus-lock-v1-1-09f6b5323460@iav.lv>
 <20261005014155.BD56B1F000FF@smtp.kernel.org>
Date: Mon, 05 Oct 2026 07:04:02 +0300
Message-ID: <1791173042898471846.39598@iav.lv>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261004_210605_734840_FD5695C1 
X-CRM114-Status: UNSURE (   6.01  )
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

On Mon, 05 Oct 2026 01:41:55 +0000, sashiko-bot@kernel.org wrote:
> If an irqchip implements irq_bus_sync_unlock but omits irq_bus_lock, this
> condition evaluates to true and irq_set_irqchip_state() is called.
[...]
> Should this check also ensure !chip->irq_bus_sync_unlock?

Yes. The next version will test both callbacks, as irq_supports_nmi()
does. No chip in tip/irq/core sets only one of them, as far as I can
grep, so nothing changes for current users.

Igor

