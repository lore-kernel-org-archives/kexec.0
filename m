Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4BBAC63703
	for <kexec@archiver.kernel.org>; Wed,  7 Dec 2022 15:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zHCLCBIVsAbAI2czYM6OVIaCAzEoPwm0Xf5O7U4RMuQ=; b=ZS1CmhOJr/Gem7
	9FfKqFUKpihB+BW4iqUwbwy3cbYaRIJZwD3JkleNGFdCbs+WWlkEAMMRr7cCHoJ4w7Ud0xgjLEFKk
	w7JXIFWLLOwzL6G1zw6ISO5VOGJA+yo6qq+cFWs/I5siliSNkn53kVDpgiqh6FYydOzScx77Ms2pb
	VdQiNvzlsBvh+wPCa6RHPfiQ0sUPvlqxUmbkVsEKwHHic6PRkdN/XMVYz7dpOou6XX29Sy2kQlonu
	bmtoBgljmWCYjErSJncAnMXO/7DyLt8DcKmluAab16Exa1A9K1C2C80TInNp2p42bB/RioIgnJHnv
	DfpQ2PTGvNJhoXJkGNlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2wmO-006FJI-H6; Wed, 07 Dec 2022 15:56:16 +0000
Received: from mail.skyhub.de ([5.9.137.197])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2wmL-006FEE-DQ
	for kexec@lists.infradead.org; Wed, 07 Dec 2022 15:56:14 +0000
Received: from zn.tnic (p200300ea9733e711329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e711:329c:23ff:fea6:a903])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D1E991EC0513;
	Wed,  7 Dec 2022 16:56:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
	t=1670428571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
	bh=JedNHJvTEEw3ngTfwq+GhcMA8oL9D/gBR+soBVALxbA=;
	b=GKj+moEuIiUJgoIjdqmbjvmbgbpbKy4esY6NqqiZ0Y+hVPmlLWCZdkwD9ik5rVUU7jkoCv
	jy4xPiZ/9Gj+76MXrkbgx7kXEmGXewJacn2aSUe7zH3ZiRgiPHFLdz0wpkl+lkCeR/fpfq
	dFF4+cq2L5WT0/xLo5JmQPUQsYCxkFY=
Date: Wed, 7 Dec 2022 16:56:11 +0100
From: Borislav Petkov <bp@alien8.de>
To: Baoquan He <bhe@redhat.com>
Cc: Eric DeVolder <eric.devolder@oracle.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, kexec@lists.infradead.org, ebiederm@xmission.com,
	dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
	mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com,
	nramas@linux.microsoft.com, thomas.lendacky@amd.com,
	robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
	sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
	boris.ostrovsky@oracle.com
Subject: Re: [PATCH v14 3/7] crash: add generic infrastructure for crash
 hotplug support
Message-ID: <Y5C3mzQLviL54IK6@zn.tnic>
References: <20221116214643.6384-1-eric.devolder@oracle.com>
 <20221116214643.6384-4-eric.devolder@oracle.com>
 <Y4A1/cSekXUTFriC@MiWiFi-R3L-srv>
 <Y5BkL8x01KWoF502@zn.tnic>
 <Y5CIvcZLuokwyGYT@MiWiFi-R3L-srv>
 <Y5CKNqtDm5VT+gsz@zn.tnic>
 <Y5Cb3KGDXijyBXfM@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y5Cb3KGDXijyBXfM@MiWiFi-R3L-srv>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221207_075613_625545_E00127E6 
X-CRM114-Status: GOOD (  10.57  )
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

On Wed, Dec 07, 2022 at 09:57:48PM +0800, Baoquan He wrote:
> I thought we usually need to introduce the kernel config option, then
> add code related to it, so that is a wrong idea.

It depends: sometimes it is prudent to add the code behind an ifdeffery
first but have it not being buildable so that you don't have to deal
with build breakages but rather concentrate on adding the facilities
first.

And you add the Kconfig item only in the end where everything is in
place and it should build properly then.

> It would be helpful to tell this somewhere in document.

Feel free. I mean, it is pretty obvious but if it helps, it wouldn't hurt.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
