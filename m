Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 062BCC48286
	for <kexec@archiver.kernel.org>; Sun,  4 Feb 2024 07:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=T/jMm/Hsb8GNyd6BAct7YklzUhsNiYdNg4uYwx3wiPA=; b=OClCx2SnimDHcN
	TCIxkVSb02B1ml+DYSVfVfBrqXwcL6hoOgnOf6OHWJcsAs+v2bj0kZVmZjHcmbiZjsdwwzAlxRlXW
	p+GYOHta12ccioIaCFNVTKpL6CexL8ttz+xSbC0EK3KjY3pkwGUZAy9dATKOkUNqmpM1XzIaoDzv7
	xfWYDwAKMttZO2B4y639SWDbgfJafn/wR22GVmhG3csFVdZSg43sk6AlCtRUhCyTtzPG2MXfyhlAL
	LK9xrz7R7yeb8KKeIcWHi9c4sRwWcuNtyod7u4g0f+bOtI99t/Jswyb373sNpaqbfY5V1rjDfmBe0
	1SeiK22JnCQHflm5Xymw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWX5M-00000000Kwm-3TJT;
	Sun, 04 Feb 2024 07:38:40 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWX5K-00000000KwP-0iCz
	for kexec@lists.infradead.org;
	Sun, 04 Feb 2024 07:38:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707032316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DW8SolzwMeCv8mPxutq7dUzGbNRfIdT1DwumifZIq0c=;
	b=TwlI4SNsWgLC5N/LApwesjcNul4WwIc5o6J7GYrFjcpCQoHIJywKc8MbxKOAriWOL2c4lK
	SEeK05wSnlMce4y3pa+FO3DkpnB1iU1aG1r1JncPE/dyK2O5BfJJd9i6wbIIKEkmatJbGQ
	wmj+i7whWcDlO6X+fxqU8DdPM5kZECQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-mn4BQlZTO5ShtAF3obfNEw-1; Sun, 04 Feb 2024 02:38:32 -0500
X-MC-Unique: mn4BQlZTO5ShtAF3obfNEw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2D97885A588;
	Sun,  4 Feb 2024 07:38:32 +0000 (UTC)
Received: from localhost (unknown [10.72.116.13])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 376AA1121306;
	Sun,  4 Feb 2024 07:38:30 +0000 (UTC)
Date: Sun, 4 Feb 2024 15:38:26 +0800
From: Baoquan He <bhe@redhat.com>
To: "yang.zhang" <gaoshanliukou@163.com>
Cc: ebiederm@xmission.com, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	"yang.zhang" <yang.zhang@hexintek.com>
Subject: Re: [PATCH] kexec: should use uchunk for user buffer increasing
Message-ID: <Zb8+8qmn5SV4LKFd@MiWiFi-R3L-srv>
References: <20240130101802.23850-1-gaoshanliukou@163.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240130101802.23850-1-gaoshanliukou@163.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240203_233838_314885_ECA2936D 
X-CRM114-Status: GOOD (  17.65  )
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

On 01/30/24 at 06:18pm, yang.zhang wrote:
> From: "yang.zhang" <yang.zhang@hexintek.com>
> 
> Because of alignment requirement in kexec-tools, there is
> no problem for user buffer increasing when loading segments.
> But when coping, the step is uchunk, so we should use uchunk
> not mchunk.

In theory, ubytes is <= mbytes. So uchunk is always <= mchunk. If ubytes
is exhausted, while there's still remaining mbytes, then uchunk is 0,
there's still mchunk stepping forward. If I understand it correctly,
this is a good catch. Not sure if Eric has comment on this to confirm.

static int kimage_load_normal_segment(struct kimage *image,
                                         struct kexec_segment *segment)
{
......

                ptr += maddr & ~PAGE_MASK;
                mchunk = min_t(size_t, mbytes,
                                PAGE_SIZE - (maddr & ~PAGE_MASK));
                uchunk = min(ubytes, mchunk);
......}

> 
> Signed-off-by: yang.zhang <yang.zhang@hexintek.com>
> ---
>  kernel/kexec_core.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index d08fc7b5db97..2b8354313c85 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -813,9 +813,9 @@ static int kimage_load_normal_segment(struct kimage *image,
>  		ubytes -= uchunk;
>  		maddr  += mchunk;
>  		if (image->file_mode)
> -			kbuf += mchunk;
> +			kbuf += uchunk;
>  		else
> -			buf += mchunk;
> +			buf += uchunk;
>  		mbytes -= mchunk;
>  
>  		cond_resched();
> @@ -881,9 +881,9 @@ static int kimage_load_crash_segment(struct kimage *image,
>  		ubytes -= uchunk;
>  		maddr  += mchunk;
>  		if (image->file_mode)
> -			kbuf += mchunk;
> +			kbuf += uchunk;
>  		else
> -			buf += mchunk;
> +			buf += uchunk;
>  		mbytes -= mchunk;
>  
>  		cond_resched();
> -- 
> 2.34.1
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
