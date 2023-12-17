Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A84F0C3DA6E
	for <kexec@archiver.kernel.org>; Sun, 17 Dec 2023 11:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pgT28aAAnO0iqvtW/Uw+Gjc/yRkkOomGOahVMQhWtnI=; b=1KNL7Pgk9e/+uG
	PfXiXd4XoMIcjDyHL8mLXRQ3Vvt0ol+mPDcHErrgjFv3226A7QXMiUbOMpMetNxcBRUfBaJScg1qt
	X0xdQx4Lb3O4mYaQUok2BzffNO9//RXKDX1CRnhwf0uq5nR8TB3pite5Phjl1EQWFIxFQu7DIR8Ox
	dT9OrYpfIXU8319j/XLcUfl0fj6xZxOxtne5jZW0O9IrbAoksDLksyafdNi1r0FQbLCyXgUvxGzfW
	kMe7u1x8uBYaTlVqaDSI+Q2B1beVeZ2XAtxNGzqDWErL4r1YJ6RMslpC1Fav6iRpL68ryPTwDDa9D
	75R/4QXp0nffIOarF4vw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rEpkN-007iWc-0t;
	Sun, 17 Dec 2023 11:55:51 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rEpkG-007iW9-3B
	for kexec@lists.infradead.org;
	Sun, 17 Dec 2023 11:55:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702814140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lMhXOzCGjIkOyucikWchP2GXTVEI4ULzcQxVu60/41w=;
	b=B6yrCVLDiV124vOTXIPp1ITiTq2+HDojnnaxCXqQSfwA5pbYF3FUQu2nSsPl83v14T22zt
	9O9o77NwV4uRZ+VyxfzBAAqIp8m8RC2y+tLv3LUnH7xzl1Bw34keaWFKklPng2Ed2q0sNo
	LqgTGHYxrWpJVA0QWxluTXxHJ1M3dwE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-132-MKc1GYshNPKpSGAKpxKcsw-1; Sun,
 17 Dec 2023 06:55:37 -0500
X-MC-Unique: MKc1GYshNPKpSGAKpxKcsw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 62C291C05AA8;
	Sun, 17 Dec 2023 11:55:36 +0000 (UTC)
Received: from localhost (unknown [10.72.116.38])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4E706C15968;
	Sun, 17 Dec 2023 11:55:35 +0000 (UTC)
Date: Sun, 17 Dec 2023 19:55:32 +0800
From: Baoquan He <bhe@redhat.com>
To: Yuntao Wang <ytcoode@gmail.com>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, x86@kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
	Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH v5 0/3] Some bug fixes and cleanups related to kexec
Message-ID: <ZX7htAE5rQJpEBxu@MiWiFi-R3L-srv>
References: <20231217033528.303333-1-ytcoode@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231217033528.303333-1-ytcoode@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231217_035545_118008_83D8FBEB 
X-CRM114-Status: GOOD (  15.12  )
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

On 12/17/23 at 11:35am, Yuntao Wang wrote:
> This series includes some bug fixes and cleanups for kexec.
> 
> This v5 series introduces no changes to any patches. I just reorganize the
> patches and repost them.

LGTM, thx.

Acked-by: Baoquan He <bhe@redhat.com>

> 
> Yuntao Wang (3):
>   kexec: modify the meaning of the end parameter in
>     kimage_is_destination_range()
>   kexec_file: fix incorrect temp_start value in
>     locate_mem_hole_top_down()
>   x86/kexec: use pr_err() instead of pr_debug() when an error occurs
> 
>  arch/x86/kernel/kexec-bzimage64.c | 2 +-
>  kernel/kexec_core.c               | 8 ++++----
>  kernel/kexec_file.c               | 4 ++--
>  mm/highmem.c                      | 2 --
>  4 files changed, 7 insertions(+), 9 deletions(-)
> 
> -- 
> 2.43.0
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
