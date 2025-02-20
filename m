Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9151DC021B2
	for <kexec@archiver.kernel.org>; Thu, 20 Feb 2025 15:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qv+ri0zG5ZPwUpAfRcaaODEZ1zTIuMqQ81MpUonQdf0=; b=sN5AFafRuHBEqUHzvJ4PMJ8vHR
	NLKQJA6VwQ7m5HIbAt7pRSZTxg/kLuYcDc0C1QZHglVxjicfONXqGurMxSnYeDV76JdziobwgABef
	NIQeOd7fDCaRiwAy3tfGQe9dh20euGW0UF8BS9rn73GNyfRxxT0K/VXT24d9o6LyTPC86VB0jScvN
	dslclAN/OiZiUuHBjDYB+ashlUhXrrcD2zGPt7U31hvnNwm7+nfOU1VgMefZ0QbN0hUxqmMwzlOGW
	veq0VmeQ1apX2sA8qVJNAwJTUM+yWhmVAV3uUTRa3/id2k/cmwniNXqpSrTXRRQgt55qd8MXLFaB3
	F9pq3aDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tl86F-00000001TBh-2jEu;
	Thu, 20 Feb 2025 15:04:27 +0000
Received: from lamorak.hansenpartnership.com ([198.37.111.173])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tl86C-00000001T91-3Y4F
	for kexec@lists.infradead.org;
	Thu, 20 Feb 2025 15:04:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1740063859;
	bh=A7/Yz6iPqpOl1AQaKSL6cMZJ1TR+XUEScQ1/Yddl1p4=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=eZGl9HgqGOv4cwfgOfl62WrZM/Qo+Ayk0yF3FP92tKsygSY2mlvkHL4gVdne7euNH
	 nmMjnr6NyzLVU07/LaxslNBd5txn1PBIkl+nxey3JB40SCq9SrQDdc+ENkO39uIfDK
	 HQIBqLwlPCQ1y+NFvNlVtTs7Gypk9f4m9K2koKis=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	by lamorak.hansenpartnership.com (Postfix) with ESMTPSA id E67991C2581;
	Thu, 20 Feb 2025 10:04:18 -0500 (EST)
Message-ID: <58e70121aaee33679ac295847197c1e5511b2a81.camel@HansenPartnership.com>
Subject: Re: [PATCH v8 1/7] ima: define and call ima_alloc_kexec_file_buf
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Mimi Zohar <zohar@linux.ibm.com>, steven chen
 <chenste@linux.microsoft.com>,  stefanb@linux.ibm.com,
 roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com, 
 eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com, 
 code@tyhicks.com, bauermann@kolabnow.com, linux-integrity@vger.kernel.org, 
 kexec@lists.infradead.org, linux-security-module@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Cc: madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
 bhe@redhat.com,  vgoyal@redhat.com, dyoung@redhat.com
Date: Thu, 20 Feb 2025 10:04:18 -0500
In-Reply-To: <8023fa50a84817cc911a117db9bd3757c34fddfb.camel@linux.ibm.com>
References: <20250218225502.747963-1-chenste@linux.microsoft.com>
	 <20250218225502.747963-2-chenste@linux.microsoft.com>
	 <8023fa50a84817cc911a117db9bd3757c34fddfb.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250220_070424_947036_12AA0892 
X-CRM114-Status: GOOD (  10.74  )
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

On Thu, 2025-02-20 at 09:53 -0500, Mimi Zohar wrote:
> On Tue, 2025-02-18 at 14:54 -0800, steven chen wrote:
[...
> > Author: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> 
> Steven, thank you again for picking up this patch set.
> 
> As previously explained, there is no tag named "Author" in
> https://www.kernel.org/doc/Documentation/process/submitting-patches.rst
> .  To give credit to the original author use "Co-developed-by".

Just on this, only use the co-developed-by if you actually *modified*
the patch.  If you're just transmitting the patch unmodified you can
give original author credit by including a 

From: original author <email>

Followed by a blank line at the beginning of the email.  That makes the
git author field contan whatever the From: line says.  You still need a
signoff from yourself in the original patch because you transmitted it.

Some people also consider minor modifications to be insufficient to
disturb the original copyright ownership and simply document what they
did in square brackets under their signoff, like this:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b5d1e6ee761a109400e97ac6a1b91c57d0f6a43a

Regards,

James


