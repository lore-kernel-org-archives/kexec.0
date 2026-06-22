Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F0E9CD98F2
	for <kexec@archiver.kernel.org>; Mon, 22 Jun 2026 19:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vvX1C/OSlAZ4NbIXg1M5pg/eogym3q/SnHXCNuno5cg=; b=mxcbsWdLVLKqsuGrmIFoQ8DI3n
	bqMXJRf7ZhOIHgUJiyuu8uZUbPS+mY3f/3dv1sewsLp+ccSjdMcHm+TMArQB9AVDp1S5oUXfW+Mnl
	AYfhmZTwQExQsEaUSxJzd1o1REzLPb0vSK6qZUzQY2IMo5psknhCSG03ll+L2qT/15K8Z54DNHcf8
	XD1TlqKK4fEtIoLPgokyQ0TuWdAWsl/avTbSda9nNIGbdK4Plm+4Y+/w6QntzfPtte4wzaL5vVUML
	dDjyRdJWSdRCWr+upCCzDtp0SLdDBbMdzRpXbucsog3Jf0vQuBaY9zv9JfF/qw4mCv6rEzPU/geu4
	NFSBwfpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbk74-00000005L3P-3FP8;
	Mon, 22 Jun 2026 19:15:18 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbk72-00000005L3I-4B0o
	for kexec@lists.infradead.org;
	Mon, 22 Jun 2026 19:15:17 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id C7EEC601F3;
	Mon, 22 Jun 2026 19:15:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 852091F000E9;
	Mon, 22 Jun 2026 19:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782155715;
	bh=vvX1C/OSlAZ4NbIXg1M5pg/eogym3q/SnHXCNuno5cg=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=A1xmOIELCsX8BFlR2se3/5yxn6ahLKhwmMcjPPJtYU5jTsFg6RQRoM7WPHqA0z9qp
	 COtLtQ7QNTGGR/s45seF67ojsLV2su3Dx/8COd4MS2p4hmMbHKadmtJHIH0iL9k7C0
	 inv6vnbHRV0riIHGix/lvawM5A++Pc4JK6RUAr8ePy6SsJN0O8bo9YEUBHrhM1mfRf
	 2e+CqTpy7OLzIkgOkvszQlaODWESvuMJ8hSKTBTKUULvsMVKyYhmprrYQPPmQ7zGvD
	 rdiu94c034Jam9//UUq2qYcw9zFsP7qW1syGpTe/IbhEeQaGB/aDgmMebg0O14q37J
	 2ZGmIRO7PaZ4Q==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [RESEND PATCH v3 1/2] kho: add KHOSER_COPY_TYPE(UN)SAFE for
 phys copy
From: Mike Rapoport <rppt@kernel.org>
To: Tarun Sahu <tarunsahu@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Alexander Graf <graf@amazon.com>, Pratyush Yadav <pratyush@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org, 
 kexec@lists.infradead.org, linux-mm@kvack.org
In-Reply-To: <20260622111215.4157974-2-tarunsahu@google.com>
References: <20260622111215.4157974-1-tarunsahu@google.com>
 <20260622111215.4157974-2-tarunsahu@google.com>
Date: Mon, 22 Jun 2026 22:15:08 +0300
Message-Id: <178215570871.91679.11260349768439750235.b4-review@b4>
X-Mailer: b4 0.15.2
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

On Mon, 22 Jun 2026 11:12:14 +0000, Tarun Sahu <tarunsahu@google.com> wrote:
> diff --git a/include/linux/kho/abi/kexec_handover.h b/include/linux/kho/abi/kexec_handover.h
> index 5e2eb8519bda..618408fbe9c9 100644
> --- a/include/linux/kho/abi/kexec_handover.h
> +++ b/include/linux/kho/abi/kexec_handover.h
> @@ -139,6 +139,18 @@
>  		(typeof((s).ptr))((s).phys ? phys_to_virt((s).phys) : NULL); \
>  	})
>  
> +/* Copies one serializable pointer to another of same type. */
> +#define KHOSER_COPY_TYPESAFE(dest, src) \

Maybe name if KHOSER_COPY_PTR?

> +	({ \
> +		typecheck(typeof((dest).ptr), (src).ptr); \

And if we could replace the typecheck with some other magic to allow
void * we won't need the unsafe version.

-- 
Sincerely yours,
Mike.


