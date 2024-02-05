Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E91FC4828D
	for <kexec@archiver.kernel.org>; Mon,  5 Feb 2024 12:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JXxAiS5Gf/cqJE/CEevj4751JPq9r1V2TiVxXziAQRA=; b=ILDLlCpCOFm7s8
	FClZhd9uZhQIdhH6fF4AWW88G+wKgmD/UGu+F/46G6QeDPdSvEyvRulG2IhCNXbunTRhgsO5tvXA/
	yGHXOWBTOEgNGdj7f8i1O28w+vLC13dc3s2n1sBj1C9lXvngCvWut6v8ye8KCTDS49tTo6YN65tom
	h6X9u45HI0NzmUIDbvyFDD9w0SS3wx0v7QnEGIKF5ZMlkXXe/p2nId12nHGmyV1+v0i3536QmxvYK
	H+cYAwu/5WJh0GYn0JnSBYbgSFVj8p/Opoe0yp56CPEzm7rPOtv0SfIzhDEJVQ+oF+GXLZPhO+zzR
	X3g2xTTxd8VQ9ncW5jjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWyZN-00000003KmA-3HrU;
	Mon, 05 Feb 2024 12:59:29 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWyZK-00000003KlK-1Uxv
	for kexec@lists.infradead.org;
	Mon, 05 Feb 2024 12:59:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707137963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FpGOJ29CMHAA5hRGumj5ser9f9DDAnohQf19mV7TPfc=;
	b=GZV3meMgHPKdfdPJr4MA6IjsSShuKxtX4+AI2Z8GAEgR6zZsSrGusD0Qvu413AiMT5av/G
	IFGa3S2LrS0RWslBcRJdqJpB1PeR6COZJaNQR3CP2h6IThiZBuGDPg+owOCSe9spRdUmHf
	fAdgoT44ZpMbApq4QwrMyHYqLMQV0CY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-Jgo5-skiN2yhuAa53_qihQ-1; Mon, 05 Feb 2024 07:59:21 -0500
X-MC-Unique: Jgo5-skiN2yhuAa53_qihQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 06554862DC0;
	Mon,  5 Feb 2024 12:59:21 +0000 (UTC)
Received: from localhost (unknown [10.72.116.13])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1F4342166B31;
	Mon,  5 Feb 2024 12:59:19 +0000 (UTC)
Date: Mon, 5 Feb 2024 20:59:16 +0800
From: Baoquan He <bhe@redhat.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "yang.zhang" <gaoshanliukou@163.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	"yang.zhang" <yang.zhang@hexintek.com>
Subject: Re: [PATCH] kexec: should use uchunk for user buffer increasing
Message-ID: <ZcDbpMByJ4VNwMZY@MiWiFi-R3L-srv>
References: <20240130101802.23850-1-gaoshanliukou@163.com>
 <Zb8+8qmn5SV4LKFd@MiWiFi-R3L-srv>
 <871q9r3xl6.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <871q9r3xl6.fsf@email.froward.int.ebiederm.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240205_045926_502367_B9E2E213 
X-CRM114-Status: GOOD (  29.52  )
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

On 02/05/24 at 06:27am, Eric W. Biederman wrote:
> Baoquan He <bhe@redhat.com> writes:
> 
> > On 01/30/24 at 06:18pm, yang.zhang wrote:
> >> From: "yang.zhang" <yang.zhang@hexintek.com>
> >> 
> >> Because of alignment requirement in kexec-tools, there is
> >> no problem for user buffer increasing when loading segments.
> >> But when coping, the step is uchunk, so we should use uchunk
> >> not mchunk.
> >
> > In theory, ubytes is <= mbytes. So uchunk is always <= mchunk. If ubytes
> > is exhausted, while there's still remaining mbytes, then uchunk is 0,
> > there's still mchunk stepping forward. If I understand it correctly,
> > this is a good catch. Not sure if Eric has comment on this to confirm.
> 
> As far as I can read the code the proposed change is a noop.
> 
> I agree it is more correct to not advance the pointers we read from,
> but since we never read from them after that point it does not
> matter.
> 
> >
> > static int kimage_load_normal_segment(struct kimage *image,
> >                                          struct kexec_segment *segment)
> > {
> > ......
> >
> >                 ptr += maddr & ~PAGE_MASK;
> >                 mchunk = min_t(size_t, mbytes,
> >                                 PAGE_SIZE - (maddr & ~PAGE_MASK));
> >                 uchunk = min(ubytes, mchunk);
> > ......}
> 
> If we are going to improve the code for clarity.  We probably
> want to do something like:
> 
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index d08fc7b5db97..1a8b8ce6bf15 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -800,22 +800,24 @@ static int kimage_load_normal_segment(struct kimage *image,
>                                 PAGE_SIZE - (maddr & ~PAGE_MASK));
>                 uchunk = min(ubytes, mchunk);
>  
> -               /* For file based kexec, source pages are in kernel memory */
> -               if (image->file_mode)
> -                       memcpy(ptr, kbuf, uchunk);
> -               else
> -                       result = copy_from_user(ptr, buf, uchunk);
> +               if (uchunk) {
> +                       /* For file based kexec, source pages are in kernel memory */
> +                       if (image->file_mode)
> +                               memcpy(ptr, kbuf, uchunk);
> +                       else
> +                               result = copy_from_user(ptr, buf, uchunk);
> +                       ubytes -= uchunk;
> +                       if (image->file_mode)
> +                               kbuf += uchunk;
> +                       else
> +                               buf += uchunk;
> +               }
>                 kunmap_local(ptr);
>                 if (result) {
>                         result = -EFAULT;
>                         goto out;
>                 }
> -               ubytes -= uchunk;
>                 maddr  += mchunk;
> -               if (image->file_mode)
> -                       kbuf += mchunk;
> -               else
> -                       buf += mchunk;
>                 mbytes -= mchunk;
>  
>                 cond_resched();
> 
> And make it exceedingly clear that all of the copying and the rest
> only happens before uchunk goes to zero.  Otherwise we are relying
> on a lot of operations becoming noops when uchunk goes to zero.

ACK.
This makes the code logic much clearer, thanks.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
