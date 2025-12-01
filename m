Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3183BD116F1
	for <kexec@archiver.kernel.org>; Mon,  1 Dec 2025 10:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tiRNEO/XNBxkNs9MPPdlx3M52d9PmW2KoL7nHem/Ym0=; b=k+4x/3MKbR/9Le6hjyEKBuU6FR
	YSubfxhw54jvsY7TaHpFCfr3vgdhjpV/Hhz1uu5Dc+sDmHWff+lwdaoOL+95Thi7v2qRN8b72dQGm
	P48kLmbEE+KUhCOSPdEb2EJ26rLt8O8Yuo6bA7aiUI40bCXf04mVV0DdIAmcmwet8mhAw9zLJD2Mp
	vzVI+JXmruzTCkhcJDd/saIgwSsL6+cHNJ7IeF8Ifuf2zxaGilVdvEsR2AFuxQApBM8G5HodbIFtD
	KOh/kdt5LuR59iHuta5scktRz1sG/XbhBZe0coyydiZPi6CDa1cEeCq+A/W8YvXYqj6ds3ZoyTPtC
	aHcPZVVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQ1Zx-00000003NsZ-2Xbk;
	Mon, 01 Dec 2025 10:56:25 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQ1Zv-00000003Ns2-3eu9;
	Mon, 01 Dec 2025 10:56:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=tiRNEO/XNBxkNs9MPPdlx3M52d9PmW2KoL7nHem/Ym0=;
	t=1764586583; x=1765796183; b=qIAG4EFdedY7iaz7vwq3fEVPPqoO6nw0O4SAM0cKJqqoiPf
	UkxdkA4yIsHjfFBYiTJOrTRqrkwho7rzKKrv/fNzchvd9TKWjHwpQYVzCoB6U+RjqrMbKCFI287LT
	ekzbXDgGo2U/XH0Kg6nFb5SV0m2Qam9e3ZelbTU/l92Of33ECy3PylZtrnpqnxoYOK1dLTY0XygAN
	ijYOdJE6siUGdM81v/rKh1sb21n8J4J0R3u7Qwk5TH55e77EnK8/xjYouyGhjOlI/mU/wV8KwcKtM
	tEUbVPQDeEiv469ktbwTrC3yHsH2UE/te2Wi429oaJ8AF8GHSnJxTzDWHeqbtnJg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vQ1Zf-0000000D35i-0PYH;
	Mon, 01 Dec 2025 11:56:07 +0100
Message-ID: <86d982368a85ab9dde17e52b45e77f5f76efea08.camel@sipsolutions.net>
Subject: Re: [PATCH v4 11/12] arch/um: don't initialize kasan if it's
 disabled
From: Johannes Berg <johannes@sipsolutions.net>
To: Baoquan He <bhe@redhat.com>, linux-mm@kvack.org
Cc: ryabinin.a.a@gmail.com, andreyknvl@gmail.com, glider@google.com, 
	dvyukov@google.com, vincenzo.frascino@arm.com, akpm@linux-foundation.org, 
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, elver@google.com, sj@kernel.org, 
	lorenzo.stoakes@oracle.com, snovitoll@gmail.com,
 christophe.leroy@csgroup.eu, 	linux-um@lists.infradead.org
Date: Mon, 01 Dec 2025 11:56:05 +0100
In-Reply-To: <20251128033320.1349620-12-bhe@redhat.com>
References: <20251128033320.1349620-1-bhe@redhat.com>
	 <20251128033320.1349620-12-bhe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251201_025623_912876_90B7CFAF 
X-CRM114-Status: UNSURE (   6.36  )
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

On Fri, 2025-11-28 at 11:33 +0800, Baoquan He wrote:
> And also do the kasan_arg_disabled chekcing before kasan_flag_enabled
                                     ^^^^^^^^

typo

> enabling to make sure kernel parameter kasan=3Don|off has been parsed.

But I'm not sure how to understand that sentence.

And I have no idea what to do with this patch, with it being random CC
of the middle of the series.

johannes

