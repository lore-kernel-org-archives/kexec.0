Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33092D3E799
	for <kexec@archiver.kernel.org>; Wed,  6 Nov 2024 09:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0PqaZhm9x84AasyTIftnZU1br2db7oJD78+3/P0dYdk=; b=DzYVESs7mqylOQ
	lXYRugi6cbvQ5VweHADEJHGeZwupq2VQiiq+2WS5HJZ4Gsu/aiAasRRGo04+7IilM0o2Vw5vEhEmT
	BoWN+M11RF1bt7NcMTvhzmnj26ybt+kuAJZ54he33XegN2pVc7yZoTexghMvwtbBqYdfW1pXMXJlo
	lFEZHuqSg2MdZLKcbrVb85G2+66OoFqp35bPU4KZVeuCAwmlJ8m3160vYT/A8ndMDpZmJgQRYllnK
	lv3vATy46CTCgl0qmhHYFbnklQIxRO8Mqrsw94UerMV1p9b9OPmxEWSnJvm4umB0xJtJKhAC7luQo
	e+DosK6ucvzgrcs7PcrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8cmZ-00000002e7A-27nZ;
	Wed, 06 Nov 2024 09:56:59 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8cKz-00000002XIf-08Ic
	for kexec@lists.infradead.org;
	Wed, 06 Nov 2024 09:28:31 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 4589AA42B64;
	Wed,  6 Nov 2024 09:26:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3875AC4CECD;
	Wed,  6 Nov 2024 09:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730885307;
	bh=6ps9DzRoDbpf6rERyf6DKhNiCsXUtjgjTBPKUI6vsgk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=al+2jqoB488/qDFcf+q8H+Xjwj6wajZf9xLIWQfDYd78huzCkUovNskO8KI4h5HkH
	 iYjjh15+QrmRJyvyunWaI7JJ8tib8PKWj45L3SDZ7Qf3AAlQeCnt4R6QXchDdlCqQV
	 y7/lbgsmA9LszpUL+4NOgyKTQHTLhThr0KBWnZwtRGORkHkaJxwe6UoPejwpywFk/Y
	 HLPBrtWBGprcdoWTB96vDPDLMyfccxTqkTyMT6TNaNLzKqp27X2xHJKDXcxF3UlbBL
	 /ksyDowRD90IHKNXVUhRL20sVAlxPtKM/0sUpbsmenEZDqSYlt5Pp+GTxgUaB8fpRx
	 2a6D3nuomG2KQ==
Date: Wed, 6 Nov 2024 09:28:25 +0000
From: Simon Horman <horms@kernel.org>
To: Pingfan Liu <piliu@redhat.com>
Cc: kexec@lists.infradead.org
Subject: Re: [PATCH] Fix fd leakage in uki_image_probe()
Message-ID: <20241106092825.GH4507@kernel.org>
References: <20241104130745.18224-1-piliu@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241104130745.18224-1-piliu@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241106_012829_808676_2F4AE038 
X-CRM114-Status: UNSURE (   9.40  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Mon, Nov 04, 2024 at 09:07:44PM +0800, Pingfan Liu wrote:
> There is a fd leakage in the fail path when writing to initrd fd in
> uki_image_probe(). Fix it by this patch.
> 
> Signed-off-by: Pingfan Liu <piliu@redhat.com>
> Cc: Simon Horman <horms@kernel.org>
> To: kexec@lists.infradead.org

Thanks, applied.

...

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
