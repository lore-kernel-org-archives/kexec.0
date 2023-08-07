Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 529EFC04A6A
	for <kexec@archiver.kernel.org>; Mon,  7 Aug 2023 13:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=H28yWUQegNniq4TI5zzbbk4P/ihxta7Euyf4QInHzN0=; b=x5SOxsAPJ1xjWx
	zCAEQNQD82ISmGoxYr7LzOvVfztFk6iqudVzYuQBgxoSut5CGSEI3ZaOwTs/V7lwcSbZCW6BKK3ik
	jmEv/WUHUCeTdYIHU++k5V0qrm9+w6sjywOLpPQA5UQcFLps7Lfs0mg56wH2T7gg/cwDlh0xOl17Z
	WSjseUYi9OOZc5OW3F/MfoVNiGFqiLx4t/jNKVDQ/QttZzIxxm1OMIQ4iri4agc2vq7lOQiuIOcWM
	QTyrLT73MXfaCFhdbXfdZp407PWgjkh/V5E3bPp6O8Aw0EJQ3/kQ1zDzbW8U+oiSVhXvSaiLLuDhO
	CH+xQ1pJF1wFJH0IX2XA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qT0BI-00HKga-0d;
	Mon, 07 Aug 2023 13:21:56 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qT0BF-00HKfM-0p
	for kexec@lists.infradead.org;
	Mon, 07 Aug 2023 13:21:54 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id AEB5361964;
	Mon,  7 Aug 2023 13:21:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDA5BC433C7;
	Mon,  7 Aug 2023 13:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691414512;
	bh=w5apbNtl/ckA5nE3KXpCZnCvrTcVa3BIEy4fnuhZW5w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lffuK8c3PnfGupYjQ/xYv0LE6S6ZlZY0cInsvX98U/X/bJnjEj9VAJT24aMlwZyFQ
	 z1gnmzi7FgXbOeoC2bc2M5imLNMNCFc6PDVQKAiIe0TojvhqySVAES5IYJkBSn5JZA
	 cPOH2zvkUtDySS+r4SHQlKUlrPjyUwt2caYQgrkqC2Qm1PBu0YfseZVC6EWPVYvIc0
	 C8ZzP6v2YJseU51JIT8ApJpDRtt1/hBPofesyoGGlSykvAdmfTWBYpQ49XZ7bj7e0P
	 A8xxjzYXBL99o4ZQshct0yLChACdmoQ8dUxEQ04a5++Zsy13zSLcSXWnSaj+1t3QdZ
	 TUCrjYmV0ar3Q==
Date: Mon, 7 Aug 2023 15:21:48 +0200
From: Simon Horman <horms@kernel.org>
To: Pingfan Liu <piliu@redhat.com>
Cc: kexec@lists.infradead.org, Dave Young <dyoung@redhat.com>,
	ardb@kernel.org, jeremy.linton@arm.com
Subject: Re: [PATCHv7 1/5] kexec/arm64: Simplify the code for zImage
Message-ID: <ZNDv7L3lWXZxrmWT@vergenet.net>
References: <20230803024152.11663-1-piliu@redhat.com>
 <20230803024152.11663-2-piliu@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230803024152.11663-2-piliu@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230807_062153_333675_7AB967B2 
X-CRM114-Status: GOOD (  12.99  )
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

On Thu, Aug 03, 2023 at 10:41:48AM +0800, Pingfan Liu wrote:
> Inside zimage_probe(), it uncompresses the kernel and performs some
> check, similar to image_probe(). Taking a close look, the uncompressing
> has already executed before the image probe is called. What is missing
> here is to provide a fd, pointing to an uncompressed kernel image.
> 
> This patch creates a memfd based on the result produced by
> slurp_decompress_file(), and finally simplify the logical of the probe
> for aarch64.
> 
> The credit goes to the Dave Young, who contributes the original code.
> 
> Signed-off-by: Pingfan Liu <piliu@redhat.com>
> Co-authored-by: Dave Young <dyoung@redhat.com>

Dave, could I get a Signed-off-by line from you?
Likewise for patch 2/5.

I think simply replying to the relevant emails should be sufficient.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
