Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B295EE49A4
	for <kexec@archiver.kernel.org>; Mon, 11 Sep 2023 00:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Z4s2y7VBG7XRogYK8N47z/aZpAtdNvi4Qmyvck2/pDY=; b=vSmEmoahPknHcz
	fADqIkSOfg/wVEqNMaEudAG3ShfC0DIZ9H10+tRGUDCjgmZTdoyfH1rh8O6FUhV43+r4FNr0q/1bu
	DJNTx6ARV01ka9xZyZipRsIeLprRuelK2tyDC4Qj9NGdCsiFMOkpv9wkNZkbsJk+G9UDspbmR1Gmj
	U7rzplgUp43yXG5uVYM3snXIc0UU4Ldk5JQoh2UqCa8RPoVndUXCcRCLkj3icY1zIbONDXaiVpP6Q
	XlHmwx2OSN2v58e7a6NfMx4Yc01Yz/Ond7RSZjyk3E21wDk3OXu7Jgz4DLi11QhY5k+wNRWT/1Zet
	SCgo7U88/fuMJRK+vL8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qfUkf-00H1Vl-2u;
	Mon, 11 Sep 2023 00:26:05 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qfUkc-00H1VP-2F
	for kexec@lists.infradead.org;
	Mon, 11 Sep 2023 00:26:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694391959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tPpLdpG4maiTSM6PN9I1fTjgodUcBS/7pIjObaruFGQ=;
	b=Ou6fTTzTfLCzZLzVdbPDwfAyn1zJCRiNvRdn4jOsfbT2CvLRXGoMCT7f0aNmrOeoUI0wah
	dJpHXKdu4OHYwmiWOPPv7JM+kXdhp+fISHtBBkLfTgEumRNF/lVfGXOVNnB3u0HoG4BioN
	IQDejEzkB23F2iITTsoSUu559Kob9jk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-645-X6kJb_mwOrivKjodFQX0cg-1; Sun, 10 Sep 2023 20:25:55 -0400
X-MC-Unique: X6kJb_mwOrivKjodFQX0cg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9DCC929A9CAB;
	Mon, 11 Sep 2023 00:25:54 +0000 (UTC)
Received: from localhost (unknown [10.72.112.35])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 5301521D4F3D;
	Mon, 11 Sep 2023 00:25:53 +0000 (UTC)
Date: Mon, 11 Sep 2023 08:25:50 +0800
From: Baoquan He <bhe@redhat.com>
To: Philipp Stanner <pstanner@redhat.com>
Cc: Kees Cook <keescook@chromium.org>, Andy Shevchenko <andy@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Christian Brauner <brauner@kernel.org>,
	David Disseldorp <ddiss@suse.de>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Siddh Raman Pant <code@siddh.me>,
	Nick Alcock <nick.alcock@oracle.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Zack Rusin <zackr@vmware.com>,
	VMware Graphics Reviewers <linux-graphics-maintainer@vmware.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, linux-hardening@vger.kernel.org,
	David Airlie <airlied@redhat.com>
Subject: Re: [PATCH v2 2/5] kernel: kexec: copy user-array safely
Message-ID: <ZP5ejovfsyEjTeg9@MiWiFi-R3L-srv>
References: <cover.1694202430.git.pstanner@redhat.com>
 <31313a8a1dd1baf9dd3c21fbe8dd46b9e111f20c.1694202430.git.pstanner@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <31313a8a1dd1baf9dd3c21fbe8dd46b9e111f20c.1694202430.git.pstanner@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230910_172602_829942_72D478F7 
X-CRM114-Status: GOOD (  17.67  )
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

On 09/08/23 at 09:59pm, Philipp Stanner wrote:
> Currently, there is no overflow-check with memdup_user().
> 
> Use the new function memdup_array_user() instead of memdup_user() for
> duplicating the user-space array safely.
> 
> Suggested-by: David Airlie <airlied@redhat.com>
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> ---
>  kernel/kexec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/kexec.c b/kernel/kexec.c
> index 107f355eac10..8f35a5a42af8 100644
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -247,7 +247,7 @@ SYSCALL_DEFINE4(kexec_load, unsigned long, entry, unsigned long, nr_segments,
>  		((flags & KEXEC_ARCH_MASK) != KEXEC_ARCH_DEFAULT))
>  		return -EINVAL;
>  
> -	ksegments = memdup_user(segments, nr_segments * sizeof(ksegments[0]));
> +	ksegments = memdup_array_user(segments, nr_segments, sizeof(ksegments[0]));

LGTM,

Acked-by: Baoquan He <bhe@redhat.com>

>  	if (IS_ERR(ksegments))
>  		return PTR_ERR(ksegments);
>  
> -- 
> 2.41.0
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
