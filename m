Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B71CC4332F
	for <kexec@archiver.kernel.org>; Tue,  8 Nov 2022 23:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/hvDygNwoBqFQk3+IYHvKSuDtToNcyUCb3czZRUs1V8=; b=hQOCE9JBGDTHVq
	T4gWrWUskrpRYueKRfhpQTR0JHh8+U5tAK7xX3oh+xxYV8I4ibbzto0gZTVnY0OdNP/j0r1O4jTyt
	o4FMWN0nQ5K0CKBsVEAiWJ/t+ioto05dm1CXTkUH90Lt2Gb+R0LmqN9tH5/csOO1M1rqHFb7HfD2g
	LdE+QjpToJ5PHYLy3wAPUuvkUbOIHvxCCT/Qvi2VCYtt1lJuKLXEuSvH+Xh3g+sJe3MANHRV5edP+
	FXEbNzkIbqaMbfVNCFj0y1Xe/igxsStYvsYEMPQeyVEyiq1IFM+pGcfvQKqjr2K6vHQwHzZRg0A00
	V/zE2TVOR4BOdcGrn6GA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osXzJ-00966V-6G; Tue, 08 Nov 2022 23:26:37 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osXy1-0095Pm-Ju
	for kexec@lists.infradead.org; Tue, 08 Nov 2022 23:25:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1667949912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mi+8/yG2AkmYuv7ZYdDMOOQ0yi94luJeVwqutgIMn6w=;
	b=eQ7Cu07zArXHDJExN9RBQuC2BvttQMP2LQPAwrfCCj3qrS9gLRdAB4e3DLcAoMXuBhDFCc
	m7KGI4AdZZ804AlDKOjF+Ds/eVQSbErvHIn+c1qybHVLnvgMPRKjFNafMwIEpjlY32R389
	qfYMs/wWvGw+0iFu/idBPCRQWxJNRzc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-647-nMF4z_RKNwacwH8JffDQXg-1; Tue, 08 Nov 2022 18:25:09 -0500
X-MC-Unique: nMF4z_RKNwacwH8JffDQXg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2F300380673C;
	Tue,  8 Nov 2022 23:25:09 +0000 (UTC)
Received: from localhost (ovpn-12-86.pek2.redhat.com [10.72.12.86])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 767F4492B05;
	Tue,  8 Nov 2022 23:25:08 +0000 (UTC)
Date: Wed, 9 Nov 2022 07:25:05 +0800
From: Baoquan He <bhe@redhat.com>
To: Stephen Brennan <stephen.s.brennan@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH] vmcoreinfo: Warn if we exceed vmcoreinfo data size
Message-ID: <Y2rlUVGv6ua7tK/1@MiWiFi-R3L-srv>
References: <20221027205008.312534-1-stephen.s.brennan@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221027205008.312534-1-stephen.s.brennan@oracle.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221108_152517_764388_715D73BA 
X-CRM114-Status: GOOD (  18.49  )
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

On 10/27/22 at 01:50pm, Stephen Brennan wrote:
> Though vmcoreinfo is intended to be small, at just one page, useful
> information is still added to it, so we risk running out of space.
> Currently there is no runtime check to see whether the vmcoreinfo buffer
> has been exhausted. Add a warning for this case.
> 
> Currently, my static checking tool[1] indicates that a good upper bound
> for vmcoreinfo size is currently 3415 bytes, but the best time to add
> warnings is before the risk becomes too high.
> 
> [1] https://github.com/brenns10/kernel_stuff/blob/master/vmcoreinfosize/vmcoreinfosize.py
> 
> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> ---
>  kernel/crash_core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index a0eb4d5cf557..87ef6096823f 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -383,6 +383,9 @@ void vmcoreinfo_append_str(const char *fmt, ...)
>  	memcpy(&vmcoreinfo_data[vmcoreinfo_size], buf, r);
>  
>  	vmcoreinfo_size += r;
> +
> +	WARN_ONCE(vmcoreinfo_size == VMCOREINFO_BYTES,
> +		  "vmcoreinfo data exceeds allocated size, truncating");
>  }

Yeah, sounds like a good idea. Thanks.

Acked-by: Baoquan He <bhe@redhat.com>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
