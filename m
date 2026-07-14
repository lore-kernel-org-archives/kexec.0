Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59571C43458
	for <kexec@archiver.kernel.org>; Tue, 14 Jul 2026 08:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bSy7t//dKQ2i+kuUE3bq0f2y0ezQTHUyULTrLuEwZkk=; b=Fq7X9UdLo/Z9Nep4h81j3JmaC2
	qYQBi0GJzbloSuNomJ6MmnXHZo5Rp4BE367N44gDlhbPuNrWahpdXp3jUIrw9F6PnQ/iOQ+Q3ZUjy
	FX/Ki4jSqWF5bW7jHHm19oIfODvDL/qNHN3tJbDgRuTVTf67orUdQnAJH83tp1+piG8ofwAth8MKp
	q7Qto4j84Vs0icaiFByvk11NQKsoufJuAqPc5/0Prn8Umj5UFzJB6c2bu9h8WY6F1vpLSjD6T7Hd8
	2avLwqpwiuBe+JBXHQLKWfceFcNj6cSbYin4RFBV4bYXH4tjFg60VoDmnkyftDt5biyTJIsCvKlnp
	0sUEeoBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjYy9-0000000BMyk-1qfo;
	Tue, 14 Jul 2026 08:58:25 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjYy8-0000000BMyb-2B5f
	for kexec@lists.infradead.org;
	Tue, 14 Jul 2026 08:58:24 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 9C7C560120;
	Tue, 14 Jul 2026 08:58:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E69A1F000E9;
	Tue, 14 Jul 2026 08:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784019503;
	bh=bSy7t//dKQ2i+kuUE3bq0f2y0ezQTHUyULTrLuEwZkk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=OYvGlleG5r6OfYwXX/3nol4yurb8g9zCX7zupQ88179K8UPlcgIXrOORgYapduMxN
	 7e/v6FbmYP7oMj4uW7ENIreEVLK7rPHsAjMcIYeop1s5ihqmz1TPGrrm5/znXn4M4z
	 B8BzCSuL8QUopCDcSkVh+oH9URRpyPTiy5uINe9Ry1YA4Dl/EWCiRgsYB1OAR/GQM3
	 W3VGPtAFJcsC0VY3+ktX3bzksiumJp9i4KJWjTiI2JDlPRpbRxUnVer5FOTxlb7Blj
	 ZjkQtvTPM5CVgOw7lxDlf4vgarerIpGrWGYdPgcMDcC/fwQuNFkdw0ViAVZIFphMmL
	 V/3VQsqijskIA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Hongfu Li <hongfu.li@linux.dev>
Cc: pasha.tatashin@soleen.com,  rppt@kernel.org,  pratyush@kernel.org,
  kexec@lists.infradead.org,  linux-kernel@vger.kernel.org,  Hongfu Li
 <lihongfu@kylinos.cn>
Subject: Re: [PATCH] liveupdate: Remove redundant INIT_LIST_HEAD in
 luo_session_alloc
In-Reply-To: <20260714074056.95335-1-hongfu.li@linux.dev> (Hongfu Li's message
	of "Tue, 14 Jul 2026 15:40:56 +0800")
References: <20260714074056.95335-1-hongfu.li@linux.dev>
Date: Tue, 14 Jul 2026 10:58:20 +0200
Message-ID: <2vxzfr1mj6c3.fsf@kernel.org>
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

On Tue, Jul 14 2026, Hongfu Li wrote:

> From: Hongfu Li <lihongfu@kylinos.cn>
>
> luo_session_alloc() calls INIT_LIST_HEAD(&session->file_set.files_list)
> followed immediately by luo_file_set_init(), which also performs
> INIT_LIST_HEAD() on the same list head. Remove the duplicate call.
>
> Signed-off-by: Hongfu Li <lihongfu@kylinos.cn>

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

