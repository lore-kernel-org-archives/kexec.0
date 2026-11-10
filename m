Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66665606A336
	for <kexec@archiver.kernel.org>; Tue, 10 Nov 2026 10:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=pEbfRP8y;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z9CqSpZm
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=PxMVpvVdH3mBqU1X9RlmYL+KR8tc+2Aa2fjil7ehTSo=; b=pEbfRP8yCclWcudmC2kj2qdLGQ
	miEzAIu1PHSXVFLn+QSM7givZMMQjmsLYI4M5J77hlOA7cLm9EW/ndIbHg8Ls1NoDlI+u+czTXoC9
	I0ppO39HH/5J8wdJ1EH5ooWbW6853lzkPdUBC1o/qhh0bRUUftgTo11stBuHYf8hSJ7OwF0wG4bDM
	cjDTJ8LAHZ0idi9aIB/WlEHqTcRMsVaT+uoS1BATs6Yj+l4i8eFgBAB4L3I6oSELphfTVrpl/zxhZ
	vDe64JCuNcAXR3ZHNOvt44U6UHUMXCcOm+nCAf+LySvKXSLok0wJ2vu2xyzBExfL4/WPs98gJDtcj
	V/K3QW+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQjYs-00000003Y1P-06X4;
	Tue, 10 Nov 2026 10:58:46 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQjYq-00000003Y14-424p
	for kexec@lists.infradead.org;
	Tue, 10 Nov 2026 10:58:45 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 64DA861DFF;
	Tue, 10 Nov 2026 10:58:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BF2C1F008A2;
	Tue, 10 Nov 2026 10:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794308324;
	bh=PxMVpvVdH3mBqU1X9RlmYL+KR8tc+2Aa2fjil7ehTSo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Z9CqSpZmLUAfMDiTcMb9pvlENM5N1dmo4Gi9b/EpqpKK/FiYZnr98uG33coDp5lvp
	 dSasyhfRJFSqXktVB79Y9dQ7k1KWlWOFk4ePz/l6QQO9G34OKYRuLlvVFfa6u7Dibu
	 mx4884r8eHBkEmOuXcrmBmG5AWr6usISPx7o1zSOS8OenlBCUSg2tX7yo1I6HfcXD4
	 ZjfGJjZdFlPQkRe8lPZO7Z91OqfNyugn2FoxjXPx6q4hp4f274sp/Dxj5+zuW++5pR
	 ENvJVZCZ9B8z7hYN4GU/z1sxS2aeJYIfFZ18C4Q7g/DdANFylvUr0xYn6FwwI6nPLA
	 Ip/EryUMVdeWQ==
Date: Tue, 10 Nov 2026 10:58:41 +0000
From: Simon Horman <horms@kernel.org>
To: zhangzikang1992@126.com
Cc: kexec@lists.infradead.org, zhangzikang <zhangzikang@kylinos.cn>
Subject: Re: [PATCH] kexec: fix stack buffer overflow in update_purgatory()
Message-ID: <20261110105841.GA1320297@horms.kernel.org>
References: <20261030030917.103293-1-zhangzikang1992@126.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261030030917.103293-1-zhangzikang1992@126.com>
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 30, 2026 at 11:09:18AM +0800, zhangzikang1992@126.com wrote:
> From: zhangzikang <zhangzikang@kylinos.cn>
> 
> Problem:
> A stack buffer overflow exists in "update_purgatory()". The local array "sha256_region region[SHA256_REGIONS]" (size 16) is written during iteration over "info->nr_segments" without boundary checking for the write index "j".
> 
> "Add_degment_phys-virt()" only issues a warning when "nr_degments" exceeds "KEXEC_MAX_SGMENTS" (=16) and continues to append segments. Therefore, "update_purgation()" may be called, causing "nr_degments" to be much larger than "SHA256-REGIONS", resulting in "region [j]" being written outside of the 16 item stack array. This type of out of bounds write will damage the Canary stack and adjacent stack frames.
> 
> Impact:
> Stack buffer overflow causing process crash (resulting in denial of service through Canary termination); The potential for controllable stack destruction depends on the content of the image.
> 
> Fix:
> Before writing to "region[j]" in "update_purgatory()", add a bounds check on "j" to ensure that writing stops immediately when "j" reaches "SHA256_REGIONS", preventing out-of-bounds writes from corrupting adjacent global variables.
> 
> Signed-off-by: zhangzikang <zhangzikang@kylinos.cn>
> ---
>  kexec/kexec.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/kexec/kexec.c b/kexec/kexec.c
> index c9e4bcb..732058e 100644
> --- a/kexec/kexec.c
> +++ b/kexec/kexec.c
> @@ -728,6 +728,11 @@ static void update_purgatory(struct kexec_info *info)
>  			sha256_update(&ctx, null_buf, bytes);
>  			nullsz -= bytes;
>  		}
> +		if (j >= SHA256_REGIONS) {
> +			fprintf(stderr, "Warning: SHA256 region limit reached. "
> +				"Skipping remaining segments from checksum region list\n");
> +			break;
> +		}
>  		region[j].start = (unsigned long) info->segment[i].mem;
>  		region[j].len   = info->segment[i].memsz;
>  		j++;

Hi Zikang,

Thanks for your patch. I agree this is a bug.
And that your patch avoids kexec-tools crashing

However, I think by skipping regions as your patch proposes we move the
burden of failing what is an invalid operation to the load call, which will
fail because the Kernel enforces a 16 segment limit. And, moreover, it's
probably not best to create a mismatch between the calculated digest and
the populated regions, which appears to be possible with your patch.

What I would suggest is this:

1. Add a segment limit check to add_segment_phys_virt,
   logging an error and returning -1 if the check fails.

2. As a failsafe mechanism, add a check to update_purgatory,
   but place it as early in the loop as possible, and
   call die() rather than just logging an error and continuing.

