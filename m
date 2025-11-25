Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4823D0EE0D
	for <kexec@archiver.kernel.org>; Tue, 25 Nov 2025 17:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wv0L7gS1/Y1WEhOgOqkMWwGiENxIx4+qLt/EjXBK6tY=; b=fVwR9IZZCtTl7HmqoXz355HaaV
	QlTUOlGBYq28baVShjmQ3V+MnGRJanylluhAmjbo/WET7FbCDecQ89BXLFRYuCwumtWSwP291VKvu
	d1gDUtd+ljbW9nVTqS7VKoILd+AIZklkU31U3UEia2pscGZ7CNxGDHptH9B9tSOmatSR9CGSrQ2O6
	M1wYE9K4bIKwxe5hg9xZ2YkrLOSIMrUUNtAGH1G7oH325AdPncbxnNoEOThyb5ez3yY1dPkQ4UUJJ
	kVTRSarJULUc30fnIsoqfpYK9JtnZEeWnD70VCBnTUw+C3OC6PWUvtQhqmHLnnICueJPMWmeaodwN
	Qb6Xkp3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNxG0-0000000Di8e-2UT9;
	Tue, 25 Nov 2025 17:55:16 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNxFz-0000000Di8V-2ciO
	for kexec@lists.infradead.org;
	Tue, 25 Nov 2025 17:55:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id BD1A3601E2;
	Tue, 25 Nov 2025 17:55:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30E0DC116B1;
	Tue, 25 Nov 2025 17:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1764093314;
	bh=epd08UzdMlvmzqtj+HCY9DpuXClNxvJWcZbzRWQ7yAE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jewHqN6Q8JXpkrnO8xyEZ+THGP+SCskynQdPSBGorR64+rzOhymUYJF2Nnflkb09L
	 j4ZZ06SBTvDITg6FkFftLX0gVpDGQFBe2AZCLGI54GSYXYsYNiai9ioh1taHDTwwLs
	 ciKmZp1ML+SBY75bu4ZrIfPhWOIL9x0vhyvsDa+o=
Date: Tue, 25 Nov 2025 09:55:13 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Baoquan He <bhe@redhat.com>
Cc: Pingfan Liu <piliu@redhat.com>, kexec@lists.infradead.org,
 linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, Roberto
 Sassu <roberto.sassu@huawei.com>, Alexander Graf <graf@amazon.com>, Steven
 Chen <chenste@linux.microsoft.com>, stable@vger.kernel.org
Subject: Re: [PATCHv2 1/2] kernel/kexec: Change the prototype of
 kimage_map_segment()
Message-Id: <20251125095513.d71dcf5aca95db49008cbc25@linux-foundation.org>
In-Reply-To: <aSU2jy/ujJILHH9n@MiWiFi-R3L-srv>
References: <20251106065904.10772-1-piliu@redhat.com>
	<20251124141620.eaef984836fe2edc7acf9179@linux-foundation.org>
	<aSU2jy/ujJILHH9n@MiWiFi-R3L-srv>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Tue, 25 Nov 2025 12:54:39 +0800 Baoquan He <bhe@redhat.com> wrote:

> On 11/24/25 at 02:16pm, Andrew Morton wrote:
> > On Thu,  6 Nov 2025 14:59:03 +0800 Pingfan Liu <piliu@redhat.com> wrote:
> > 
> > > The kexec segment index will be required to extract the corresponding
> > > information for that segment in kimage_map_segment(). Additionally,
> > > kexec_segment already holds the kexec relocation destination address and
> > > size. Therefore, the prototype of kimage_map_segment() can be changed.
> > 
> > Could we please have some reviewer input on thee two patches?
> 
> I have some concerns about the one place of tiny code change, and the
> root cause missing in log. And Mimi sent mail to me asking why this bug
> can'e be seen on her laptop, I told her this bug can only be triggered
> on system where CMA area exists. I think these need be addressed in v3.

Great, thanks, I'll drop this version.

