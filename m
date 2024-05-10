Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA7F7C25B10
	for <kexec@archiver.kernel.org>; Fri, 10 May 2024 11:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tmrzd5n3QqQEjRR9qeXxuE5TgR0btww07NCR9/La0/M=; b=z+OgKKHJ0qZ92b
	4gb9sUCm/RtVt91TxLGSCp8rfo44/nbpYwt6emjo1okxM2NNBZkcZ4cPE3yBdw1O4/KbixmTpSimn
	jU2g9QBFy3+Z+H0JUYAu0g0NiaRgPY8XSse52ex3GBH50j4rmwYvhfU4yz3jc/jIUXtwSLByfwGrI
	ouKhxtoZgwB6nsVQaO5drrgVQzh24meG6BEPx8JSMV9D4oN4Coe6HhmJJqCiUmvcogkZeF6IlLeVO
	4LWT/6rdbeEmNvFX0SBsw0E9NMevMQkZedSIFW1CHWmlPjRVcgKuZ4QM1eUnXgEBPZQhe+vSxs7ri
	wDf+9VG2f0F8v04u3JPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5OM6-000000052Io-3eok;
	Fri, 10 May 2024 11:24:02 +0000
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5OM3-000000052HF-2UMU
	for kexec@lists.infradead.org;
	Fri, 10 May 2024 11:24:01 +0000
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-a59a387fbc9so498071666b.1
        for <kexec@lists.infradead.org>; Fri, 10 May 2024 04:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1715340237; x=1715945037; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=47x/4Pk6TGycDhdZnlbzTMHVd0iRYhoMxpqaHz5aors=;
        b=o7w2eNL28hwzqbqiaJbTQvJlYvFLWb5zSTIQrIFKIx4i2ljdN7tXM0D0oTtgy/p3n6
         Vt99f1o+oC60ldvxmwydjXXWyBfGtuWw/VEXM+S0AHoXaYq2X8FDZyimp4mM1cXrdk0A
         Llny/RsJgQ53wmUrdc5KgYLH/u/3CyeqMSUS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715340237; x=1715945037;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=47x/4Pk6TGycDhdZnlbzTMHVd0iRYhoMxpqaHz5aors=;
        b=PPGzN3gnrspQhiCuvTEMZArueNwiq72ZLfGuoGkoreO1dJ+YqU3qcRJBlVkqmdu35l
         zPDoGd8pYiboL7tcWEmFEOZSn9VV50X1Lzauqu+XcDlxPenl9Wo0If4je0wro7EXH8M8
         1GKvrMhtr9YhO6K+78NSZoKQhxVDmq7NzEkq8fZ9zvZUyrWIzHhiUsqvfdcTqLLcvYOL
         8v8Ois8sPOBcyMnZZvnv2s9NQXbcGRL0OSWyTZhzH5ES8ykSF9EEobU2OUEK5iX+x7ZE
         LlrC3Cy138Erv0z8EbKBSCDl5chvl44A7jI6jvteTE/JWkz7N77fJfl+LnAQc/aS5js4
         u/Fg==
X-Forwarded-Encrypted: i=1; AJvYcCXocrvLqByoHnCS1hlLZR0InfqmJa8jj88jfR6f4HiJ90m3aCCvudwxUODtKsAdW6b4Mlp+ibniB+Q/IdCZUvCxxhbLbwILavlz
X-Gm-Message-State: AOJu0YzHAiS9hNSSL0/uzhqFl8KMvguUZy4nlDc0LW3Qe1z9e9LR3N/V
	BWDFLFhbB8lbhRPxdnuxt4vjY+7bsXAHhHOgzI3PDxmOTyKYC6kMY4TwPKt75HFdZMLYNT3RO5K
	6E3ty2j3GkXMfg/HPpXxX72lEQ9H33OoYhw8mWg==
X-Google-Smtp-Source: AGHT+IFz5qP18mAylhBbmtThupMzDKv7Hxf/YKoxmcI8024bWwzwHlVosWJHVpjswkQo1H6JZ+uOIVvInsfVrUzL8aQ=
X-Received: by 2002:a17:907:26c9:b0:a59:ba2b:5913 with SMTP id
 a640c23a62f3a-a5a2d66b525mr199596766b.62.1715340236873; Fri, 10 May 2024
 04:23:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240502212631.110175-1-thorsten.blum@toblux.com> <20240502212631.110175-3-thorsten.blum@toblux.com>
In-Reply-To: <20240502212631.110175-3-thorsten.blum@toblux.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 10 May 2024 13:23:45 +0200
Message-ID: <CAJfpegsVWa-fu=DePSC0J1WkfQxhaqs0RTxopMBHduwMANieyQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] overlayfs: Remove duplicate included header
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	David Howells <dhowells@redhat.com>, Jeff Layton <jlayton@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, 
	Dave Young <dyoung@redhat.com>, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	kexec@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240510_042359_665105_CE3F72FA 
X-CRM114-Status: UNSURE (   5.78  )
X-CRM114-Notice: Please train this message.
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

On Thu, 2 May 2024 at 23:27, Thorsten Blum <thorsten.blum@toblux.com> wrote:
>
> Remove duplicate included header file linux/posix_acl.h
>
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>

Applied, thanks.

Miklos

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
