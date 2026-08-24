Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 158BCC5DF9B
	for <kexec@archiver.kernel.org>; Mon, 24 Aug 2026 15:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KhObASzU+IfR0vAcTNmjdJh1v1AW8fzRga8XEXTHVUA=; b=g5gGnSpG5MM6jSsyLgzATS1M1/
	uhm11IgdC10MGjdVR5UgnDonKjYZD12YeNMG3sMkYPqAn/CWqTWT+GNYcr2lbCgf6JAs1PIPwhTA0
	LnRbafOUymlALDYqnXxK+LwsFSn/HbSLFxdQqihUJNi53aNnCyqf8Lcw4pLkiC244l5FenSt4ALpt
	8GP5hw67vjwD59p2/W8JCQHurOeKwCprm/umA7knUenZWJDFfDQsn+I/pvYHo9+U4nhvKzz4/wqGy
	ctmxZP8dBGArFioSRSMm0O4ljpLA1hSyrQEC8jCmrXK/FqJWEB7H+kFKWl81tXMB8YQbME/KQ4uPo
	VXnamXHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyWSY-0000000Gtxy-2D3Q;
	Mon, 24 Aug 2026 15:19:38 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyWSY-0000000Gtx1-0P2h
	for kexec@lists.infradead.org;
	Mon, 24 Aug 2026 15:19:38 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 801D543653;
	Mon, 24 Aug 2026 15:19:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99AAD1F00A3A;
	Mon, 24 Aug 2026 15:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787584777;
	bh=KhObASzU+IfR0vAcTNmjdJh1v1AW8fzRga8XEXTHVUA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LC36phpszc3Om6N/zbMxn3qMAaW69FAFVObEdERNIgzHvNnwi6kqgufIEU7/UIWsY
	 krth0vZ8KBkoVR2jhi20myZTjDkhMfwj0bh8fKkFO6Cq9jtg6P6nCbqcFUV5jB7MMH
	 Atx4872f1nd1YEddLkLsnZfeA38+HMzpmURbmib3a6OO3LnOhDaSE6pNJTv9+0hTPy
	 Bjrgk9LvrsETUGXLygWv5zpQuxjCVbMH3s6RiwLjTKFOe+Ay7EtwFS2q3XS1NpfRKm
	 8Z0HQsSlyzqvXZSW1e+1oD5IZQqNP9BmPLOW+iaXG9B3F2Jb6iX1rSTgDIYMg+P6Xp
	 8/2udBbC4RLrw==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.ams.internal (Postfix) with ESMTP id 2CABF1980064;
	Mon, 24 Aug 2026 11:19:33 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 24 Aug 2026 11:19:35 -0400
X-ME-Sender: <xms:BGGMatyGyn3hvJEAL0fFVjsBYh6gFUw65lsJrw_6381KetY-a1qxIg>
    <xme:BGGMalHPhb2XHbU2FL6zGJT2A6yE8C808HEMrw-XsTFRzBkkDK8YaH-6SScXzeiTF
    cj3wzC4PcJqjEIF5c2m5qGUfrfw6Yyhf-ybFPELzuLx8ScJvRHuino9>
X-ME-Received: <xmr:BGGMaiukLLHf90eQribcfkvQllhnvFKo9aofwwJhz8uPgwNUtUoji80uTlc>
X-ME-Proxy-Cause: dmFkZTGmehEwlTpaGnlMoJpjXQ7nDLGKNpzYXa2GqgT7N6wq+ruWxFOqugBXByk4sBfObp
    8DXKoBbmhM2FrtuaF9WZfWUm/XSEbXQJrXuwkZA4vndDzrBzxGCewc1r+D79yU3xB5jMSa
    B+LVxfNdjqdsuQZAIZKPCnVgEizP998OPUYROmwf7705WA1lsJP0FTniXw+j+FTLaPgO0N
    pd/+oAYahWf/yETAcvBK1S8P36SGEYc0d+vgfJCIyGHc08xJ91rRcqKCNPSEZn0qz0TbQ4
    K8qMxtX4Mw5iXxoWJmcxU6EWREGiIjkBV6LuhbNuw0VpdhCn2mkDjHa2YQj/22JhnN6oEm
    4gxVYethYAkikekOYpmmy2wE+3KgV9l0KZncUeQMPVLxTPopcHk7B/t0+PqwsnOycNBrd8
    vq6icxUXHj7Jja6KFHTxcBoUZDXTm8d53gqsszOR2pEv5+etleh6hqokwfs/29Ugy955AD
    ofBgQAbcPGVZP95X6cOumcWEZoV4/S7+8hr5oxlRtC2g5pwOGUXxs6/iwmqb4/tH9V25nL
    73WPOd3sIE52G6iY59hh2iDy+8Xk/ff8vm/m/EawJVtYutWKH2BHuPh7Vw9D8veAMwYHqW
    IEoiv74acRu1a4kH5h9pzMzAk3ntTtdu3nf9xvRv3t3no9eU5wynopTneZKw
X-ME-Proxy: <xmx:BGGMapXg6FcpXm7Cm04GaXfUrtCknQ9pxDcfaUReND3l7ZNV_Ah3sA>
    <xmx:BGGMai6vp9i2vWDcbOdl3gqXrclWdmYwbf4bGbwOm_kT_osDA1thtA>
    <xmx:BGGMatZTApO_0kD9vDLGKSJP-KmLtAz0lFDL5oYGcOjIy26EW-hXaA>
    <xmx:BGGMamBVp9A3SqBBtHKv3fZdBI1PIl_5cHBIM1ar4qVw-wYmajWJfA>
    <xmx:BGGMaupDZcb_xUq5ERgNzieAYNoVrTFRpliEkJTvATSIEQPawMJm24EX>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Aug 2026 11:19:32 -0400 (EDT)
Date: Mon, 24 Aug 2026 16:19:31 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Ard Biesheuvel <ardb@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Miaohe Lin <linmiaohe@huawei.com>, 
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	rmikey@meta.com, riel@surriel.com, kexec@lists.infradead.org, 
	kernel-team@meta.com
Subject: Re: [PATCH v2 6/6] efi: respect the poisoned pages coming from
 previous kernel
Message-ID: <aoxgwbsdy0H1OSBm@thinkstation>
References: <20260821-hwpoison-kho-v2-0-5743791e48e6@debian.org>
 <20260821-hwpoison-kho-v2-6-5743791e48e6@debian.org>
 <aog_uH5fTsJzXjjx@thinkstation>
 <aohIF6MmjiQpbz5j@gmail.com>
 <aohldTtzE2GJ76md@thinkstation>
 <aoh-3XJw82O8SmsA@gmail.com>
 <aowcYuXEeqdfHmn6@thinkstation>
 <aow_bfUQWZWh7Kxb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aow_bfUQWZWh7Kxb@gmail.com>
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

On Mon, Aug 24, 2026 at 06:03:05AM -0700, Breno Leitao wrote:
> Yea, this seems better in fact. Let me know if that matches what you
> had in mind.

Yes!

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

