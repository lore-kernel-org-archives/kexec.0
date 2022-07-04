Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05B99C433EF
	for <kexec@archiver.kernel.org>; Mon,  4 Jul 2022 02:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qOSWuZogpNmFHzt/CMPxRi/GP3Ol/J5bGdKofgs5yyk=; b=DG3zqFiwqipzVl
	Js56WhKSE81Jb1zkzc7LwnBd+HcQDglBEX0OXMQ7LdZvTJIFM1njhs49AMdL+MvKPibtgx7uLJW+i
	boeoUEpfE5A+oxA3l4rXkxfRgRV32H0gakUN/JV8lvwA8hSHCs8iqZcuZpefCqtULma+I5KMyowBm
	AwlUm40Bp0OCzunYViLCrVFI2AmKw9g9BraB5RBG5BqOd4G10By/YvV1CGH+uCfKQpLbjBOIZOspk
	k5BBnSR9AbkZxrKZ7achvZ9KsS8U0ODKPoxSk92vkjaKPr72zOwcctFA6BTaolgl5clh9isE7L0P9
	Tc62x8g44vQksOTwuUtA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8CE8-003rH3-JT; Mon, 04 Jul 2022 02:54:20 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8CE5-003rBO-9C
	for kexec@lists.infradead.org; Mon, 04 Jul 2022 02:54:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1656903255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1P+Z0NPfnwQi7DbmZ8kWxij8Re3KK3gRyK0ayDPLp8E=;
	b=PfZJPrkoghe6EHCBavINgGRIxJY2Nwi7pe9PSvg68tJSPdbsjPMY8JfqeTB1W++5BiidIv
	mHYMA0FwY95oBGW4fe7VqbKhvEyyDULE0KgNpyQYRs5QJJges4obWmJnCd+R5wlqjyvTR9
	X3OW2M76lDTZgHuepbL4hqTvZnJUh3w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-375-3Y-jYpWXPkaCqKBkgi_BZA-1; Sun, 03 Jul 2022 22:54:10 -0400
X-MC-Unique: 3Y-jYpWXPkaCqKBkgi_BZA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9B27A185A7B2;
	Mon,  4 Jul 2022 02:54:09 +0000 (UTC)
Received: from localhost (ovpn-13-121.pek2.redhat.com [10.72.13.121])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C36A1400DFD0;
	Mon,  4 Jul 2022 02:54:08 +0000 (UTC)
Date: Mon, 4 Jul 2022 10:54:05 +0800
From: Baoquan He <bhe@redhat.com>
To: Jianglei Nie <niejianglei2021@163.com>
Cc: vgoyal@redhat.com, dyoung@redhat.com, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] proc/vmcore: fix potential memory leak in vmcore_init()
Message-ID: <YsJWTT71QAfTef5N@MiWiFi-R3L-srv>
References: <20220629165216.2161430-1-niejianglei2021@163.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220629165216.2161430-1-niejianglei2021@163.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220703_195417_431300_33C5D019 
X-CRM114-Status: GOOD (  21.86  )
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

On 06/30/22 at 12:52am, Jianglei Nie wrote:
> elfcorehdr_alloc() allocates a memory chunk for elfcorehdr_addr with
> kzalloc(). If is_vmcore_usable() returns false, elfcorehdr_addr is a
> predefined value. If parse_crash_elf_headers() occurs some error and
> returns a negetive value, the elfcorehdr_addr should be released with
> elfcorehdr_free().
> 
> We can fix by calling elfcorehdr_free() when parse_crash_elf_headers()
> fails.
> 
> Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
> ---
>  fs/proc/vmcore.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
> index 4eaeb645e759..7e028cd1e59d 100644
> --- a/fs/proc/vmcore.c
> +++ b/fs/proc/vmcore.c
> @@ -1568,6 +1568,7 @@ static int __init vmcore_init(void)
>  		return rc;
>  	rc = parse_crash_elf_headers();
>  	if (rc) {
> +		elfcorehdr_free(elfcorehdr_addr);
>  		pr_warn("Kdump: vmcore not initialized\n");
>  		return rc;

Guess it's found by code inspecting since if vmcore_init() failed, kdump
kernel won't do anyting meaningful and reboot, then nobody notice or
care about this leak.

If so, is this better?

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 7e028cd1e59d..ea2f44d77786 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -1568,16 +1568,16 @@ static int __init vmcore_init(void)
 		return rc;
 	rc = parse_crash_elf_headers();
 	if (rc) {
-		elfcorehdr_free(elfcorehdr_addr);
 		pr_warn("Kdump: vmcore not initialized\n");
-		return rc;
+		goto fail;
 	}
-	elfcorehdr_free(elfcorehdr_addr);
 	elfcorehdr_addr = ELFCORE_ADDR_ERR;
 
 	proc_vmcore = proc_create("vmcore", S_IRUSR, NULL, &vmcore_proc_ops);
 	if (proc_vmcore)
 		proc_vmcore->size = vmcore_size;
+fail:
+	elfcorehdr_free(elfcorehdr_addr);
 	return 0;
 }
 fs_initcall(vmcore_init);

>  	}
> -- 
> 2.25.1
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
