Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE12EC43458
	for <kexec@archiver.kernel.org>; Mon, 29 Jun 2026 11:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uLo3uScFY8qXXclpLP+pID3s3N1avq1NED8H+2VbuUk=; b=oMNCh1SrdEYk+h9GjN13w9+ald
	a5ol39oxmfNDWJU/Wio2nQrYwlxAUz2QdA2+t3vYLjMh6f6DYOlDXBJj6gBaXCM5k62SXadcCAkBk
	bdmq9WEkHeuo7JNPs5RyyBwC+5Ld9Gxremvbr/h/x24mIMtercaIYe7JcX6FLmPqPyB0piu1NOeov
	v0oKcU2LBTjArkohOrOUh3RXi3GVrk9NE9GqrFGQo/6tJ3GtOVN355B3oPaX466SQ9RQqsQHrjfmL
	wrq6dA3P8bbitmBghEPxWM0gDaYdmueXtEq3NyZ05RR0xkOUZLUFdbJ+zo2cKaItc1zyUYiNUSIPQ
	g8Ja/5ww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1we9vc-0000000EOks-3Idb;
	Mon, 29 Jun 2026 11:13:28 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1we9vc-0000000EOkT-01DG;
	Mon, 29 Jun 2026 11:13:28 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 7ACFB40A98;
	Mon, 29 Jun 2026 11:13:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C36CC1F00A3A;
	Mon, 29 Jun 2026 11:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782731607;
	bh=uLo3uScFY8qXXclpLP+pID3s3N1avq1NED8H+2VbuUk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=iLQsTaI1MCOTXeeyqRet2iV2gC9t6oIsFOufNdwLP1HEYZAq+8EMcpWdneHLjc3JF
	 eP4EeAbwxRD3u3Szfm4MvZ2JvnOkw+bPzhUyc+ppnxNcSwCpT/Ukii6MET4ZqkSEE/
	 q3c1r07QUvx3uMGdPPxvgF2r6x9cjm1Huyq/n2gkDtXuKGpyt/Fj6O1EGVf5TIQqwz
	 /rJ3n0tpqAj1rp0r4ANTs2BsYufqLSHLtaQa5Rg6tnEDfdb9CAf6GPYmuGMGVjUi56
	 BM//ePvpqvEVv3YDFTBXsXoNQqOjWsnkZPMaxpcxdHxL5KpkV1ZfnVleiI4kHDlvGs
	 Ay04T7GQU+icg==
From: Pratyush Yadav <pratyush@kernel.org>
To: Tao Liu <ltao@redhat.com>
Cc: pjw@kernel.org,  palmer@dabbelt.com,  aou@eecs.berkeley.edu,
  alex@ghiti.fr,  linux-riscv@lists.infradead.org,
  linux-kernel@vger.kernel.org,  kexec@lists.infradead.org,  bhe@redhat.com
Subject: Re: [PATCH v2] riscv: Fix a NULL pointer reference in
 machine_kexec_prepare
In-Reply-To: <20260627222602.23594-2-ltao@redhat.com> (Tao Liu's message of
	"Sun, 28 Jun 2026 10:26:03 +1200")
References: <20260627222602.23594-2-ltao@redhat.com>
Date: Mon, 29 Jun 2026 13:13:24 +0200
Message-ID: <2vxzcxx9k3aj.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

On Sun, Jun 28 2026, Tao Liu wrote:

> A NULL pointer reference issue is noticed in riscv's machine_kexec_prepare,
> where image->segment[i].buf might be NULL and copied unchecked.
>
> The NULL buf comes from security/integrity/ima/ima_kexec.c:
> ima_add_kexec_buffer(), where kbuf is added by kexec_add_buffer(),
> but kbuf.buffer is NULL.
>
> Fix this by simply adding a check before copy.
>
> Acked-by: Baoquan He <bhe@redhat.com>
> Signed-off-by: Tao Liu <ltao@redhat.com>

Acked-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

