Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 211E5CC6B3C
	for <kexec@archiver.kernel.org>; Thu, 15 Oct 2026 09:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:To:Subject:From
	:Message-ID:Cc:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CGdG8TwFl5jlPeq0ZWNrkAMVJaC9oniv4YtTj6Q++SA=; b=i7UP7+bYJh1pPjsXTYC/hskTYc
	238NCMKTLcNzpgI69iZundQPwHfGZIdM+4Et25MkQpjHorlkXOi+z9aaodEWjwz6yozQ9x5EABaUs
	tpTZkjLEqb6kROTnxauBdLd3vDXLaxuPa2hx8p/djwl+9tTHY9yau9cWK3cqivOPHWrMEGrFJxn0r
	j0x0bnB+W/UGCj5wcf9KPrfF1+au6nqatGpxAHqPdhIU3cnm/NlMYaejHxIX3kBLm+MNnJ49azky9
	cjcYFHAQiPDiohhyJlfMUZDCaMA/+faPDd/2C7BbGqSvzxjYGQ+WOtubjY+AtqBfaDTw/Vp3yvbnc
	8u/WR9Mw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHI2R-0000000HJU9-1CIT;
	Thu, 15 Oct 2026 09:46:15 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHI2P-0000000HJQJ-11qM
	for kexec@lists.infradead.org;
	Thu, 15 Oct 2026 09:46:13 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 0178244226;
	Thu, 15 Oct 2026 09:46:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C6EE1F000C5;
	Thu, 15 Oct 2026 09:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792057572;
	bh=CGdG8TwFl5jlPeq0ZWNrkAMVJaC9oniv4YtTj6Q++SA=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=ZO3Y9c5TYPasjCBbX3ApFT1y+gx3rbGIng/IjizqyFYQMdltCUGPnG5h1mKEN9Q+R
	 R1B/1xFbIFAPPZXKimYBw8Z2LJ5Mpr50bcS6/xyv2RAMST9qrMXyFROmp3DdhWdBci
	 2xZa4iOwMCACe02JjK4QCu7/TQQLntOw/6o+BA9kPBX0v/jFVsPzvwhpCvyL//Dt9a
	 IpIF4TzuVFrSGwd9fkIwB2jQMeLydXwJkI5HkPN7VF057+VK+PRWY5ymDz2q3MxLQf
	 rMr7CUCXpkgWNh+jQFvIeYXqXyAhZhIx+KRpO+r2goz/NycXXT6ZeOyG3gTlKPQbUs
	 Es8bGqDJAu5gA==
Message-ID: <sashiko-outbox-172593@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 5/7] liveupdate: Allow file handlers to mark retrieve
 failures as retryable
To: "Pasha Tatashin" <pasha.tatashin@soleen.com>, rppt@kernel.org, shuah@kernel.org, akpm@linux-foundation.org, vipinsh@google.com, dmatlack@google.com, kexec@lists.infradead.org, pratyush@kernel.org, graf@amazon.com
In-Reply-To: <20261015093816.2438942-6-pasha.tatashin@soleen.com>
References: <20261015093816.2438942-1-pasha.tatashin@soleen.com>
 <20261015093816.2438942-6-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 09:46:11 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

> When luo_retrieve_file() invokes a handler's .retrieve() callback and it
> returns an error, LUO currently records the error in
> luo_file->retrieve_status and blocks any subsequent retrieve attempts.
> This is necessary when the handler has already partially consumed or
> freed the preserved KHO state.
>=20
> However, with user arguments passed to .retrieve(), a handler may fail
> early while validating caller-supplied parameters (such as a missing
> argument, an invalid or read-only target file descriptor, or a non-empty
> target file) before touching any preserved KHO state. In such cases,
> userspace should be able to fix the argument and retry
> LIVEUPDATE_SESSION_RETRIEVE_FD, and if the file is never retrieved,
> .finish() must still run to release the preserved KHO state.
>=20
> Add a retryable output flag to struct liveupdate_file_op_args. When a
> handler sets args->retryable =3D true on error, luo_retrieve_file() leaves
> luo_file->retrieve_status at 0 so the retrieve operation can be retried
> and .finish() will still clean up the unconsumed preserved state if the
> session is finished without retrieving the file.
>=20
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015093816.2438=
942-1-pasha.tatashin@soleen.com?part=3D5


