Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A06CFEE4F4
	for <kexec@archiver.kernel.org>; Sat, 28 Feb 2026 19:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gDXrvPJhhkf3OIXvUvwqzWV6atSv3O7HGkFpNhm2n+Y=; b=aa2jqRvrx9JTWD51LjtvHcchQl
	PbPg3TAQtRw+d9zHJj8XCkFW5HfbJKmkJNNmTDwuiot06uxC1mP8pj2l3RTr2C523qdIzs+qFHMmQ
	JLsnbn7vl7fzzHWd4M1DzLX7VrCFPZp5le/+hQfokWEjzVdIBr/IGSQKJoczui9A+EXWpSCrP3x29
	7w8aGv/YOI+Fdi31QDmjtcltBD2pH6otVfQ6NNOCYqlv7TQwbgqlDpedLtQltPoq3z5Ign0WIWAb/
	MVBMsxzknv2SVIUYEdXK4E33u9fy7jfWhjPDLEugvIM6kA2jB7L4tcdnEFQZiY+nBoPxwe99lXArr
	7mhQ3ekg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwPaX-0000000AAuJ-1pq2;
	Sat, 28 Feb 2026 19:02:53 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwPaV-0000000AAto-2fNP
	for kexec@lists.infradead.org;
	Sat, 28 Feb 2026 19:02:51 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 7AA0560008;
	Sat, 28 Feb 2026 19:02:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02076C116D0;
	Sat, 28 Feb 2026 19:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1772305370;
	bh=gRWAWtCACv9lhxvNhJCLlbbiSPVjya6cne6BkfsMPJ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=U5AB7oxNsshAEwc7C7G+VGYGzAChV7yAr67vSQcwyRIp545X/NX0QMKq5HQ+CN90V
	 R+K/2KaMW0CQ5qXP6znj+kikdZdfh/I0LVJgZQmSSjXsrKgPsgeTfA26mQ9IuTWNon
	 fJTqUrdboWyFp77rs3VSjRI3m7jVmn1Wos1P7s88=
Date: Sat, 28 Feb 2026 11:02:49 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Dave Young
 <dyoung@redhat.com>, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crash_dump: Remove redundant less-than-zero check
Message-Id: <20260228110249.8a4d13b872e7cf3ca75e11d0@linux-foundation.org>
In-Reply-To: <20260228085136.861971-2-thorsten.blum@linux.dev>
References: <20260228085136.861971-2-thorsten.blum@linux.dev>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Sat, 28 Feb 2026 09:51:36 +0100 Thorsten Blum <thorsten.blum@linux.dev> wrote:

> 'key_count' is an 'unsigned int' and cannot be less than zero. Remove
> the redundant condition.
> 

umm. OK.

> --- a/kernel/crash_dump_dm_crypt.c
> +++ b/kernel/crash_dump_dm_crypt.c
> @@ -115,7 +115,7 @@ static int restore_dm_crypt_keys_to_thread_keyring(void)
>  
>  	addr = dm_crypt_keys_addr;
>  	dm_crypt_keys_read((char *)&key_count, sizeof(key_count), &addr);
> -	if (key_count < 0 || key_count > KEY_NUM_MAX) {
> +	if (key_count > KEY_NUM_MAX) {
>  		kexec_dprintk("Failed to read the number of dm-crypt keys\n");
>  		return -1;
>  	}

iirc Linus has said "this is OK".  The compiler will eliminate it and
the code still works if the type is later changed to signed.


