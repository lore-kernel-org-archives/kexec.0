Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C0FBEB64D7
	for <kexec@archiver.kernel.org>; Wed, 28 Jun 2023 07:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:To:From:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=nJjg67EbZsxLb8Ph8Ue/RvaeM3R7keg7hJncsNG2Vss=; b=L/ZeiDSfe6exKL
	JBgzB6h0mU2BB49b7W4/ul4bMPxztYEzd/fjLKYZcuCxfhu78iY/MOPa0I70u4GXBPVkU5LsiLlZl
	9QCFC3j1ihb8HKG2svb+Wlj3SS1KGQTKyv1WhIwDaG02nGCShMEtU8gnDJXnPQSnr8qKxK+Wd0ggh
	AazpLI03j618BkKKkikNhNMuxeieiqXN6OJ9D/ecY6pHNZYORRu6np2G9tt3QZJaiIGnw9ndQU/et
	v2aWGPDCgo7B7KVgtFSTuOcBPVzv77rJiwpMZaCnCKJRL4QI3Q46eBxF3F82G5Tg7Aja8DKhHHqsq
	7rzVwp4SK90COdP8rbJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qEPo6-00F54O-2b;
	Wed, 28 Jun 2023 07:41:42 +0000
Received: from mail.craftsplex.pl ([162.19.155.126])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qEPo2-00F52k-1a
	for kexec@lists.infradead.org;
	Wed, 28 Jun 2023 07:41:39 +0000
Received: by mail.craftsplex.pl (Postfix, from userid 1002)
	id 5C7A9237B8; Wed, 28 Jun 2023 07:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=craftsplex.pl;
	s=mail; t=1687938061;
	bh=PcMncQpBfIZCnTOfZJY5G1G+gaLn4c9QPfFvoXrE4rA=;
	h=Date:From:To:Subject:From;
	b=FIYFEWvPllvHT/DcnnghClJD2zkBBzLx/TwVsMb0J7nHz/tVZ98i4nPsdcwYocQu0
	 PQ8024E2eVpRj4A01qNvMHMXvqbAqKKGDtN4bxCmsVTv71d2uziy2HzrkhLsECWL9X
	 GRA58SCHsNuunMlmhabf1dbY3uq3Fx0PD72kilQpVHsonER172Xnd00xrxRyoizihq
	 0AUJWaWetOTiYxinZXTi2z4FKU7ps3KUJt4DxTx8MMFh+b1z+nLIizweyFKsdv14Bs
	 1KV2v0mHVBHQJo53zIaElvsJU0FfZbiTsIZXRg8FgT+fuQXkjzXTfLmnWHg8OOI/CI
	 1zICgU/i+TT2w==
Received: by mail.craftsplex.pl for <kexec@lists.infradead.org>; Wed, 28 Jun 2023 07:40:44 GMT
Message-ID: <20230628064500-0.1.71.14yff.0.acxltlogq3@craftsplex.pl>
Date: Wed, 28 Jun 2023 07:40:44 GMT
From: "Kamil Tralewski" <kamil.tralewski@craftsplex.pl>
To: <kexec@lists.infradead.org>
Subject: =?UTF-8?Q?S=C5=82owa_kluczowe_do_wypozycjonowania?=
X-Mailer: mail.craftsplex.pl
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230628_004138_774617_3F76AD2A 
X-CRM114-Status: UNSURE (   1.43  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

RHppZcWEIGRvYnJ5LAoKemFwb3puYcWCZW0gc2nEmSB6IFBhxYRzdHdhIG9mZXJ0xIUgaSB6IHBy
enlqZW1ub8WbY2nEhSBwcnp5em5hasSZLCDFvGUgcHJ6eWNpxIVnYSB1d2FnxJkgaSB6YWNoxJlj
YSBkbyBkYWxzenljaCByb3ptw7N3LiAKClBvbXnFm2xhxYJlbSwgxbxlIG1vxbxlIG3Ds2fFgmJ5
bSBtaWXEhyBzd8OzaiB3a8WCYWQgdyBQYcWEc3R3YSByb3p3w7NqIGkgcG9tw7NjIGRvdHJ6ZcSH
IHogdMSFIG9mZXJ0xIUgZG8gd2nEmWtzemVnbyBncm9uYSBvZGJpb3Jjw7N3LiBQb3p5Y2pvbnVq
xJkgc3Ryb255IHd3dywgZHppxJlraSBjemVtdSBnZW5lcnVqxIUgxZt3aWV0bnkgcnVjaCB3IHNp
ZWNpLgoKTW/FvGVteSBwb3Jvem1hd2lhxIcgdyBuYWpibGnFvHN6eW0gY3phc2llPwoKUG96ZHJh
d2lhbQpLYW1pbCBUcmFsZXdza2kKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3Jn
Cmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
