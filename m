Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E258C00528
	for <kexec@archiver.kernel.org>; Thu,  3 Aug 2023 08:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:From:Subject:
	Cc:Message-Id:Date:Mime-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1rfSDUvFtxbNnDeMSW862r1kgyGyY6w7lrz+KP4lqeg=; b=agxlA/aP2QF0D+
	+ACj3B51ZDC5IIdpkxA6TY8K91JTLNgkYMbf24ji44TsLg6z0g887YKYZXukpkj/RlyDQfyUAwMr9
	6x0PC9EIggJHg7gvs8YCJwq48OQ3BqIWKMu0mhzKZICN4va/cFt6ZQ48x4y4Wa9DLIDFolT+34PqY
	iRpta6f+orxjVJvcdF0aXlDGoH5xMyQuU6kPy2LGNKyewR+eH0ShK1LEryaBZZAzmRjMhjbo5omhU
	tQ+9QN7Zk7tdPfI48776zhAdPVOJ8Egxf2PShmzY7upnktM43+cwFhkcxV11BVXxZaSCzjEvWrZVB
	gfeO+Q1imszdlqSBlH1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qRU93-0075at-2t;
	Thu, 03 Aug 2023 08:57:21 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qRU91-0075aG-1A
	for kexec@lists.infradead.org;
	Thu, 03 Aug 2023 08:57:20 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id A1C7261CCD;
	Thu,  3 Aug 2023 08:57:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C709C433C7;
	Thu,  3 Aug 2023 08:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691053038;
	bh=8zuKLEw8Pz3rRWw3o+O48AfxI5v0Rox/L6Yf6SEhJbM=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=mQUlpj8NyJkcTbWb/e3JtGfGNp/whhYZaAlIp81ozB/CB+KMVBojN0zaspUbT+SA/
	 V5ZoRTRqvukVWaLAMaslXEYcmazwTby72HeTYvjODoNHaeMKJQOGhWaM/61ucCsU1A
	 hgQ3n3t6B49NGVC9ixf/Q347/MBw5D7XfZzjhs/t7lVJDWjKYYa7mabupy0ZxwBlfv
	 zUD7HZMG2jQ8GjZyWctdf9vAc3deDTOe2En0WiANI+VOd6zRxPTki3T7zXZQ1imP4o
	 HWkYFqwsrHyIzJhiqjubf2PruNzC0cax5cDWZyBDct+EDkNSiOgzcP6TSh38el2hti
	 4OckI/QN5EV1w==
Mime-Version: 1.0
Date: Thu, 03 Aug 2023 11:57:11 +0300
Message-Id: <CUIS9Q2RKN2Q.4V9YYAYHE2BD@suppilovahvero>
Cc: <code@tyhicks.com>, <nramas@linux.microsoft.com>, <paul@paul-moore.com>
Subject: Re: [PATCH 1/6] tpm: implement TPM2 function to get update counter
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Mimi Zohar" <zohar@linux.ibm.com>, "Tushar Sugandhi"
 <tusharsu@linux.microsoft.com>, <noodles@fb.com>, <bauermann@kolabnow.com>,
 <ebiederm@xmission.com>, <bhe@redhat.com>, <vgoyal@redhat.com>,
 <dyoung@redhat.com>, <peterhuewe@gmx.de>, <jgg@ziepe.ca>,
 <kexec@lists.infradead.org>, <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.14.0
References: <20230801181917.8535-1-tusharsu@linux.microsoft.com>
 <20230801181917.8535-2-tusharsu@linux.microsoft.com>
 <CUHFWAAKMKJN.2EA3ZHLOOPPGB@suppilovahvero>
 <1d592ca1-1f6c-9eef-ce71-b07a837372b0@linux.microsoft.com>
 <CUHRAC79EW66.1VQRXS97GB0UO@suppilovahvero>
 <8c4257fb07a8c9fd26b70ce716665a9535e6af54.camel@linux.ibm.com>
In-Reply-To: <8c4257fb07a8c9fd26b70ce716665a9535e6af54.camel@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230803_015719_443344_E6943C5D 
X-CRM114-Status: GOOD (  15.33  )
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

On Thu Aug 3, 2023 at 4:22 AM EEST, Mimi Zohar wrote:
> On Wed, 2023-08-02 at 06:58 +0300, Jarkko Sakkinen wrote:
> > 
> > From long description I see zero motivation to ack this change, except
> > some heresay about IMA requiring it. Why does IMA need update_cnt and
> > why this is not documented to the long description?
>
> The motivation is to detect whether the IMA measurement list has been
> truncated, for whatever reason.  A new IMA record should be defined
> containing the "pcrCounter" value.  (I have not had a chance to review
> this patch set.)
>
> This new record would be a pre-req for both Tushar's "ima: measure
> events between kexec load and execute" patch set and Sush's proposal to
> trim the measurement list.  (I haven't looked at it yet either.)

Please describe the story in a bit more understandable form. In the
commit messages it is not good to have some redundancy in patch sets.

BR, Jarkko

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
