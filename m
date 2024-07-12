Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 393CEC3DA45
	for <kexec@archiver.kernel.org>; Fri, 12 Jul 2024 03:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BPIxk8wvHbPy7bz3FBiHhgsk9h6FtTaap6KeUOfGsHs=; b=wvc4LjXT+461Wk
	Ak9ogoaAp9U+kCZOvxUhfh3IwxeG/1/Y1UoXRjBm4A0qsAj0r0fmG6D6z5ryi8x/ldJ31kC+wyeAC
	Ee3I9ccaVpHHWyBqMmyISIwC3SEJw/TwQVP8qJ/o5slfshabnPZQhud68N8qaTKDqJYqPbDTPbumm
	w6sDy6S8/nuPoJ/ym+/Yqo/4nKROD9pPTnj9WpE5R4Ly8lQEwl/0eDEy/9Sm//yDrQkyC0sN84Cab
	ib/aY7yaCbiQ+ebFQhTaQzvhi/8rJREAWW1t8e+Qss1/YCpv2GgRAdHJpI+dKUwImQXU/jDsZzyeH
	b3Jr1qBJ98zrHVGtvMsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sS74h-0000000GHlh-3og3;
	Fri, 12 Jul 2024 03:35:59 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sS74e-0000000GHlA-2Sa6
	for kexec@lists.infradead.org;
	Fri, 12 Jul 2024 03:35:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720755354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XRr3QUNCpj/Aou9SrxNeZFSuT8KL7rq81lYCD8rqbec=;
	b=BtA47MBfsSFgKIpS3r8QS1RNEsxMx322aOOlBKgJK6L7TjN9X0CbmSXhccTDMsglNhAILh
	Wca85VflrjQH63UD6IOJQay/dJUo2v8YezkmNzyJImTf+dNZKu9vL4SLFg7RanlJVFD0os
	K7LuSe/dlPeiZXDoAa1auAsynW54ESM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-61-WIx0JwRjMCGLVoXRXgf46w-1; Thu,
 11 Jul 2024 23:35:49 -0400
X-MC-Unique: WIx0JwRjMCGLVoXRXgf46w-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 51A2C1956080;
	Fri, 12 Jul 2024 03:35:47 +0000 (UTC)
Received: from localhost (unknown [10.72.116.101])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 394113000181;
	Fri, 12 Jul 2024 03:35:44 +0000 (UTC)
Date: Fri, 12 Jul 2024 11:35:40 +0800
From: Baoquan He <bhe@redhat.com>
To: Petr Tesarik <petr.tesarik@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, Petr Tesarik <petr@tesarici.cz>,
	Petr Tesarik <ptesarik@suse.com>
Subject: Re: [PATCH] sysfs/cpu: Make crash_hotplug attribute world-readable
Message-ID: <ZpCkjN1iLsZTu4Ug@MiWiFi-R3L-srv>
References: <20240711103409.319673-1-petr.tesarik@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240711103409.319673-1-petr.tesarik@suse.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240711_203556_733358_C93E5A21 
X-CRM114-Status: GOOD (  16.85  )
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

On 07/11/24 at 12:34pm, Petr Tesarik wrote:
> From: Petr Tesarik <ptesarik@suse.com>
> 
> There is no reason to restrict access to this attribute, as it merely
> reports whether crash elfcorehdr is automatically updated on CPU hot
> plug/unplug and/or online/offline events.
> 
> Note that since commit 79365026f8694 ("crash: add a new kexec flag for
> hotplug support"), this maps to the same flag which is world-accessible
> through /sys/devices/system/memory/crash_hotplug.
> 
> Signed-off-by: Petr Tesarik <ptesarik@suse.com>
> ---
>  drivers/base/cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
> index c61ecb0c2ae2..73d69791d0d3 100644
> --- a/drivers/base/cpu.c
> +++ b/drivers/base/cpu.c
> @@ -308,7 +308,7 @@ static ssize_t crash_hotplug_show(struct device *dev,
>  {
>  	return sysfs_emit(buf, "%d\n", crash_check_hotplug_support());
>  }
> -static DEVICE_ATTR_ADMIN_RO(crash_hotplug);
> +static DEVICE_ATTR_RO(crash_hotplug);

Agree. I guess this was copied from codes related to 
crash_notes/crash_notes_size. While crash_notes/crash_notes_size are in
/sys/devices/system/cpu/cpuX/ which is next level. 

Acked-by: Baoquan He <bhe@redhat.com>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
