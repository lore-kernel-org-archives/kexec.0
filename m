Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FAECC43219
	for <kexec@archiver.kernel.org>; Wed, 23 Nov 2022 09:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=C+zS4vh4eK5c/Bkq8+pxWJM4fxrEcgHbxGMFNGZKXEo=; b=jelFOYKTEG7L4o
	NrnnHAI608n4i8fr6acSWQjY0oCmNpK+nt935VZRRqgn4NHzOTTpKICVc8MhKUweZ2qk2d2UvpU8H
	meZiUZ4nlHS8a4brIGqHMfZhNjwIALrF2tDUx5A/1g6QP2tZ8xJ+/cBRD6hwTbfndNWYhqUxhbYvo
	p5u7vIfBWMJzgKYDjHAztyww2sDdt2Dei89kTpOTexTlVYenJCa7LVcErYgaWYheBjrpE3ztt9bxG
	vfT7X+swuoBgw9Ju6tdjdYKqjxo38w3FnJ9imV6cEC4FfXna+7ZtdwB6naCd9xQ8vZzsOBaFIogxM
	O+/iE416lKO6yFdOBwpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxmM2-00G4NI-M9; Wed, 23 Nov 2022 09:47:42 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxmLx-00G4IV-Kk
	for kexec@lists.infradead.org; Wed, 23 Nov 2022 09:47:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1669196855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/JvhkIMHaE9tMvv7uV8gHbGibKRYLhWKCV1r10ib1SI=;
	b=fqBQddySV02L8gCdtprR+oDa3zHxiOdXg3g7TRA7Sm+w4ER0zi7xl31AeyM2t1ZtGxDZcX
	0cPfXgfTIN9V9p0MH5yssj6BoB7RUgUm7mr0m5muX/a8gzLBZNu81T26Ab69I+KayxD5CQ
	qCOfQs53zf1Y+PLVOp/AEwaRaSkN7PM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-186-wcLG9FRXPSiJz2FVZjmd8Q-1; Wed, 23 Nov 2022 04:47:31 -0500
X-MC-Unique: wcLG9FRXPSiJz2FVZjmd8Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E70B73C0E460;
	Wed, 23 Nov 2022 09:47:28 +0000 (UTC)
Received: from localhost (ovpn-13-118.pek2.redhat.com [10.72.13.118])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 054CB2166B31;
	Wed, 23 Nov 2022 09:47:27 +0000 (UTC)
Date: Wed, 23 Nov 2022 17:47:20 +0800
From: Baoquan He <bhe@redhat.com>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Eric Biederman <ebiederm@xmission.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	Ross Zwisler <zwisler@kernel.org>, linux-doc@vger.kernel.org,
	"Joel Fernandes (Google)" <joel@joelfernandes.org>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v1 1/2] Documentation: sysctl: Correct kexec_load_disabled
Message-ID: <Y33sKLOwqjCc7Qwe@MiWiFi-R3L-srv>
References: <20221114-disable-kexec-reset-v1-0-fb51d20cf871@chromium.org>
 <20221114-disable-kexec-reset-v1-1-fb51d20cf871@chromium.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221114-disable-kexec-reset-v1-1-fb51d20cf871@chromium.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221123_014737_914520_F27C3D04 
X-CRM114-Status: GOOD (  14.41  )
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

On 11/14/22 at 02:18pm, Ricardo Ribalda wrote:
> kexec_load_disabled affects both ``kexec_load`` and ``kexec_file_load``
> syscalls. Make it explicit.
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> 
> diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
> index 98d1b198b2b4..97394bd9d065 100644
> --- a/Documentation/admin-guide/sysctl/kernel.rst
> +++ b/Documentation/admin-guide/sysctl/kernel.rst
> @@ -450,9 +450,10 @@ this allows system administrators to override the
>  kexec_load_disabled
>  ===================
>  
> -A toggle indicating if the ``kexec_load`` syscall has been disabled.
> -This value defaults to 0 (false: ``kexec_load`` enabled), but can be
> -set to 1 (true: ``kexec_load`` disabled).
> +A toggle indicating if the syscalls ``kexec_load`` and
> +``kexec_file_load`` have been disabled.
> +This value defaults to 0 (false: ``kexec_*load`` enabled), but can be
> +set to 1 (true: ``kexec_*load`` disabled).
>  Once true, kexec can no longer be used, and the toggle cannot be set
>  back to false.
>  This allows a kexec image to be loaded before disabling the syscall,

LGTM,

Acked-by: Baoquan He <bhe@redhat.com>

> 
> -- 
> b4 0.11.0-dev-d93f8
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
