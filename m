Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CC90C35274
	for <kexec@archiver.kernel.org>; Mon, 18 Dec 2023 18:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Message-Id:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kBpLN0pRjyTUM6FNqkLWOXpyFujdYhA0q3B0MkiXnhI=; b=msdvulyPaiC0o8
	us6CiO4O5pefvkYsHhmv1UTHfI6qNrYL4O2RpIChww/XU6qRvR1l47RCuFMwGnqHXSAOREnFR7/LT
	e4AAH4QzoYEn1r3XQn8lvaYZ4YvHgUSLRILsllpSzM2iLXzZrGrseI6Jfp5bF3r88sdxQFBy8a05r
	TQjYFT1Vd+yu5mirhSfUt/v0gvw46KAMjZw/sINFSYUZ0/3Kj4oAIwugXiP+LAs1X8oNbv2IW4rkM
	k9ctwUUEFCCwj9EGfIka4rfe9O1b/CgGiEvylCgiViQDc/pUxS4cbsqk8kMvo9EeRQUKJ4a7G+yJn
	mB7dg9LOcrktCg90YLwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFIII-00Bku3-2y;
	Mon, 18 Dec 2023 18:24:46 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFIIF-00BksT-0o
	for kexec@lists.infradead.org;
	Mon, 18 Dec 2023 18:24:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id D2EE360EDE;
	Mon, 18 Dec 2023 18:24:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BDB5C433C8;
	Mon, 18 Dec 2023 18:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1702923877;
	bh=657RT1T9y1phDXkS/PHN8nnyPlTK2iy7Gb6uK7ychM4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lcoClL5r5VFKM+Vwx2E8RTpZRVRehkx37EPGW7dnqKX0wceVFir7l7S4oxOh+3KWB
	 TdQ+jFzYNIdNRFQ8cX69IusNvbaA/9i/lw3vCOct1gj8RbHp6NRhgv8bUNlh+9aRdH
	 i7/a0+HnsVql6jO5M/f7JBSj1zX/vN7oCl6Iyz64=
Date: Mon, 18 Dec 2023 10:24:36 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Yuntao Wang <ytcoode@gmail.com>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, x86@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>, Eric
 Biederman <ebiederm@xmission.com>, Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v5 3/3] x86/kexec: use pr_err() instead of pr_debug()
 when an error occurs
Message-Id: <20231218102436.4378f51a36525ce770f6cd30@linux-foundation.org>
In-Reply-To: <20231217033528.303333-4-ytcoode@gmail.com>
References: <20231217033528.303333-1-ytcoode@gmail.com>
	<20231217033528.303333-4-ytcoode@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231218_102443_350479_9D5D4877 
X-CRM114-Status: GOOD (  13.25  )
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

On Sun, 17 Dec 2023 11:35:28 +0800 Yuntao Wang <ytcoode@gmail.com> wrote:

> When an error is detected, use pr_err() instead of pr_debug() to output
> log message.
> 
> In addition, remove the unnecessary return from set_page_address().
> 
> ...
>
> --- a/arch/x86/kernel/kexec-bzimage64.c
> +++ b/arch/x86/kernel/kexec-bzimage64.c
> @@ -424,7 +424,7 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
>  	 * command line. Make sure it does not overflow
>  	 */
>  	if (cmdline_len + MAX_ELFCOREHDR_STR_LEN > header->cmdline_size) {
> -		pr_debug("Appending elfcorehdr=<addr> to command line exceeds maximum allowed length\n");
> +		pr_err("Appending elfcorehdr=<addr> to command line exceeds maximum allowed length\n");
>  		return ERR_PTR(-EINVAL);
>  	}

https://lkml.kernel.org/r/20231213055747.61826-4-bhe@redhat.com has
already changed this to call kexec_dprintk().  I'll skip this patch.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
