Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36CE2CCD183
	for <kexec@archiver.kernel.org>; Mon, 13 Oct 2025 12:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=d8yyluaPsU64JiH8nx3doSlxtTxHqP7AkC2CtB26lS8=; b=dLoSRZ7IvuhexJJl7OhFt/k1f0
	+KcmOH3jnIK7KxMeLDNMY+Y/pfURs09xMkoVSgzuFqpnsjYMCBQgSVhaDqjGINuXfRkJqwTvovHbK
	azeMV4TVCLVRySioZuN79/bHDmtsL58zNDZdBItIeb+5sKq12XedJzGhu4qvgjfLFgbNiO5Wc+qxN
	hdwv6iMV4eogFoOo3Ce7XGzeRFH0bZ3zEH+uJbc4Z+az/EfMAKFgBTX2LbeBN14RGoy7LJrSgsg6Y
	o/nxaO2a43r3RtkexO9n6c8lJqXcghGN5ra6vmTGOhJofTSADwLrdsMi32eElhUc+4kwXnXeaP2s2
	PzHaryUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8HYr-0000000D77w-1ogl;
	Mon, 13 Oct 2025 12:21:57 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8HYp-0000000D76Q-13ir
	for kexec@lists.infradead.org;
	Mon, 13 Oct 2025 12:21:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 64DB946648;
	Mon, 13 Oct 2025 12:21:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8079FC4CEFE;
	Mon, 13 Oct 2025 12:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760358114;
	bh=8ayZzsM7Tg8a4hHEL+CcWLmAF179tgFq9958rKBp3So=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Ck/fTjQAuQ+K19R4lL88ECj/0Dyc4YPuuLzIxdGII9aY0b0oAfOapTL9ra3jPMwB0
	 5GutdlxKErtiv++SiF3f3P37du5dp0CmWfuZ01iSPpWGD6WHfnnKohye80p4l7LPgS
	 vKcpab6vl7FI3vR2UpDz0/3qSUxanHBybWUAfMMWCGgONnyOeT46qbB8HIvFO7Oj5A
	 TVRSniPUmM8nAZXEki4z7Uc5CiBf39hBlWyrTOpvIAzuswgWFKLhtPIy+VB26FhawF
	 TgtEiCVUsK8bacETgqDgUBAzCvXU7ex/NNuvkQbAd03pu7R08H1NWr65CrXRTKFC5s
	 LXcgciLEfD/9g==
From: Pratyush Yadav <pratyush@kernel.org>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: graf@amazon.com,  rppt@kernel.org,  changyuanl@google.com,
  pasha.tatashin@soleen.com,  kexec@lists.infradead.org,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org,  Abaci Robot
 <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] liveupdate: kho: remove unneeded semicolon
In-Reply-To: <20251013021836.944898-1-jiapeng.chong@linux.alibaba.com>
	(Jiapeng Chong's message of "Mon, 13 Oct 2025 10:18:36 +0800")
References: <20251013021836.944898-1-jiapeng.chong@linux.alibaba.com>
Date: Mon, 13 Oct 2025 14:21:50 +0200
Message-ID: <mafs05xcjm1pd.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251013_052155_331452_7EE6D2D0 
X-CRM114-Status: GOOD (  13.76  )
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

On Mon, Oct 13 2025, Jiapeng Chong wrote:

> No functional modification involved.
>
> ./kernel/liveupdate/kexec_handover.c:1155:2-3: Unneeded semicolon.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=26158
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Looks like it comes from Pasha's series
https://lore.kernel.org/lkml/20251007033100.836886-4-pasha.tatashin@soleen.com/

I think this fix can be folded into the patch since it isn't merged yet.

> ---
>  kernel/liveupdate/kexec_handover.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index 5da21f1510cc..c87d00c40c82 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -1152,7 +1152,7 @@ static int __kho_finalize(void)
>  		err |= fdt_begin_node(root, fdt->name);
>  		err |= fdt_property(root, PROP_SUB_FDT, &phys, sizeof(phys));
>  		err |= fdt_end_node(root);
> -	};
> +	}
>  	mutex_unlock(&kho_out.fdts_lock);
>  
>  	err |= fdt_end_node(root);

-- 
Regards,
Pratyush Yadav

