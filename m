Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D1D9C3DA4A
	for <kexec@archiver.kernel.org>; Thu, 22 Aug 2024 11:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UwHnl8JDTGwIaqAt1EnX4rcR6Ot4/xuSgVTeFugeGwE=; b=Nc2uQAX0s0rRik
	iRkr12dak/pMPU48OrxpKXL7eUuBYa/T9Ia2ALBUfi/o6BtYjQFT87mDE42H3PCkcLKHI3ot7TiXM
	pny93UNjdqFcf6MzsIyGRK1VfIWxuvfS7aZiGHnpN4asv17UoeVA4r62jK1ozq1VlHTQkrt9/3BwM
	DAChJmbIpjDkNybTMun7KIPI1m61FfqWrvU2tgPHpz/wRNm/EThkdC+x0EpHFbGZRUmWQ761/7eWR
	Vcv2ijB0kaRmjiv/eS0A50/pDWHu4Z2xx76HEIxiIcq1wlFTI/k9VVkz5pFarIZIrK9PvU6Vxbycr
	RK1dWWAwJj1zJK1VUQmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sh6GA-0000000Ccyi-30s0;
	Thu, 22 Aug 2024 11:45:46 +0000
Received: from gardel.0pointer.net ([85.214.157.71])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sh6G6-0000000Ccy2-3nbo
	for kexec@lists.infradead.org;
	Thu, 22 Aug 2024 11:45:44 +0000
Received: from gardel-login.0pointer.net (gardel-mail [85.214.157.71])
	by gardel.0pointer.net (Postfix) with ESMTP id 422E9E80263;
	Thu, 22 Aug 2024 13:45:40 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
	id 9E79516008A; Thu, 22 Aug 2024 13:45:38 +0200 (CEST)
Date: Thu, 22 Aug 2024 13:45:37 +0200
From: Lennart Poettering <mzxreary@0pointer.de>
To: Jan Hendrik Farr <kernel@jfarr.cc>
Cc: Pingfan Liu <piliu@redhat.com>, Ard Biesheuvel <ardb@kernel.org>,
	Philipp Rudo <prudo@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>, Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	kexec@lists.infradead.org, linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFCv2 0/9] UEFI emulator for kexec
Message-ID: <Zsck4U9xmzz5w5tl@gardel-login>
References: <20240819145417.23367-1-piliu@redhat.com>
 <ZsX5QNie3pzocSfT@gardel-login>
 <CAF+s44S2Ph1_nFcZYy3j0Jr4yuHayb5zdNu1YXg8ce_Lf3TOgQ@mail.gmail.com>
 <Zsb1isJ2cYRp2jpj@gardel-login>
 <CAF+s44TauSXk-gDgRHn=6CsQrAv8Q-QyGXkDJO+_sTh_yKde5w@mail.gmail.com>
 <gnym722ge3bgzz765u7plh65kq2tk7odw7hs4nq5ufxdp5xauf@bgb32wlzcchc>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <gnym722ge3bgzz765u7plh65kq2tk7odw7hs4nq5ufxdp5xauf@bgb32wlzcchc>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240822_044543_315126_E4844845 
X-CRM114-Status: UNSURE (   7.80  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Do, 22.08.24 13:42, Jan Hendrik Farr (kernel@jfarr.cc) wrote:

> I have two questions:
>
> 1: Does the systemd-stub only perform measurements before exiting boot
> services or also afterwards?

Nope. we pass control to the kernel's own stub, and that calls EBS(),
not systemd-stub. Hence, no, we are just measuring a things before
EBS(), not after.

Lennart

--
Lennart Poettering, Berlin

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
