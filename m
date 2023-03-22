Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04FE8C6FD1F
	for <kexec@archiver.kernel.org>; Wed, 22 Mar 2023 20:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lkKoay5Ki4wf2/JI6bgBBPCSxgID35OKhXCQt35DSpA=; b=tN6dvPE9GyTZ/i
	lPR44PzuPrj1rNqrHPSUcGXmmOozmCStdTP93jhDP6LcYHAwDVpFnQ2ryuAgexRMQ7dhjkLeD19Uk
	MkzCRYn/RXhrHk8qBEMkYNk57gYZi2DCcwxi9iPH2kgX7Lu5ynqrfSLNfvEyaOloBGjO1/ROYUfF8
	mxZs/09U+EHZStuq/LGq1iT2Ohs3Ayc4oKCyGGGrGqqCBHydblNcqj3ERHXl7w6WzE1FsEPU72uSm
	w0tF7YumSTsaoI4LIQv6IIp3LM7Aq9zyGe15MQ79PlIHYeIRqRrXxjuD7gV42E+ZDdBNtn3+X95VZ
	2++4EiveB1jyxxig4C4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pf4pg-00HJRb-2A;
	Wed, 22 Mar 2023 20:13:16 +0000
Received: from mail-il1-x12e.google.com ([2607:f8b0:4864:20::12e])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pf4pe-00HJQK-1W
	for kexec@lists.infradead.org;
	Wed, 22 Mar 2023 20:13:15 +0000
Received: by mail-il1-x12e.google.com with SMTP id h5so10492319ile.13
        for <kexec@lists.infradead.org>; Wed, 22 Mar 2023 13:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679515989;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VSVpoYaq65+xbA9FzmSJjInslmYXWqbzAWERClhv01I=;
        b=Nx3qTbZ20GsX7TOXQaiYemwOz4I72BqU0yeZUan+IOoQxcUzCYXiR6m9hNuyet44c0
         69W3Pn+weLlnax/iMnT9t2K2zy3cNaQd2bK7297jNu6VjCS4Gwdm834G9FfkjusFTz3L
         Og+U6A5VPgvSDLdANAEIH6eXjuS6yPaTvRyv3McBLC5tqM6md1lygdDv5Maj6imD49aR
         8ST6dw7ZGzUWgIMPaN/9tUqhoBcmlNbfrD3Pufkz+f8pB8WaiKZVakO/3pcJS7xmQISF
         2XdBlHmqesWw7t6HIZWxzw3yYbq6HtPIKgryuazt2g88qsmQrv60OUebkiStUz2VrU+f
         129A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679515989;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VSVpoYaq65+xbA9FzmSJjInslmYXWqbzAWERClhv01I=;
        b=fLwBxIZpJVSRevgbm6NgAilTlGTXwPefYuc4lTmuPMyyMNjKZYNjOw5TKrsxNtZ+QR
         cajC8j9zjH2zMoWNve0TGUnZjuIu6KfItsVSlBOJxn82vPcC3xfcIQBahNTwHLDrM8e/
         jwI2EjnL6jXOuZGUMBKicYB6hZV+0u+QHD1G8D0TLwSktgHuZF0xb1RbfhrPm1NBeBTl
         +T0Eh9MlNzut50K6NTT1X4U0Du+H/DUyFbsDUxzVzg1vzxvgKPY0QZgl2gTb5gkVFuRs
         LBoyCbVz8Dw6v57ME3Wum5Yu82EvEBoU/Yn97DoB1FRT7Z1YTdRqJreEIc3+v4QZcVla
         IvTw==
X-Gm-Message-State: AO0yUKUGDYkA+k3Bj4W9M9Q9lEc8MfwLR3ItqEgH4YYNjnIzVUyYDJyW
	s9wfdL5sHWFCNbwUrPd+tP51tQ==
X-Google-Smtp-Source: AK7set+6/bABqcZ7Ui8WBR/o5uSEMuupYads18CiEFawlKIO6/axtKxX5dOWAApzt981uGzOj3EbFg==
X-Received: by 2002:a92:d0c5:0:b0:325:a6cd:4730 with SMTP id y5-20020a92d0c5000000b00325a6cd4730mr5350858ila.29.1679515988574;
        Wed, 22 Mar 2023 13:13:08 -0700 (PDT)
Received: from google.com ([2620:15c:183:200:7419:4945:3325:dd1e])
        by smtp.gmail.com with ESMTPSA id v9-20020a056638250900b0040584b8a32fsm996985jat.126.2023.03.22.13.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 13:13:08 -0700 (PDT)
Date: Wed, 22 Mar 2023 14:13:03 -0600
From: Ross Zwisler <zwisler@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ricardo Ribalda <ribalda@chromium.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Philipp Rudo <prudo@linux.vnet.ibm.com>,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH] kexec: Support purgatories with .text.hot sections
Message-ID: <20230322201303.GA2979303@google.com>
References: <20230321-kexec_clang16-v1-0-a768fc2c7c4d@chromium.org>
 <ZBsSBr87al9ccG96@home.goodmis.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZBsSBr87al9ccG96@home.goodmis.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230322_131314_530632_D923984D 
X-CRM114-Status: GOOD (  30.11  )
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

On Wed, Mar 22, 2023 at 10:34:46AM -0400, Steven Rostedt wrote:
> On Tue, Mar 21, 2023 at 12:49:08PM +0100, Ricardo Ribalda wrote:
> > Clang16 links the purgatory text in two sections:
> > 
> >   [ 1] .text             PROGBITS         0000000000000000  00000040
> >        00000000000011a1  0000000000000000  AX       0     0     16
> >   [ 2] .rela.text        RELA             0000000000000000  00003498
> >        0000000000000648  0000000000000018   I      24     1     8
> >   ...
> >   [17] .text.hot.        PROGBITS         0000000000000000  00003220
> >        000000000000020b  0000000000000000  AX       0     0     1
> >   [18] .rela.text.hot.   RELA             0000000000000000  00004428
> >        0000000000000078  0000000000000018   I      24    17     8
> > 
> > And both of them have their range [sh_addr ... sh_addr+sh_size] on the
> > area pointed by `e_entry`.
> > 
> > This causes that image->start is calculated twice, once for .text and
> > another time for .text.hot. The second calculation leaves image->start
> > in a random location.
> > 
> > Because of this, the system crashes inmediatly after:
> > 
> > kexec_core: Starting new kernel
> > 
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > To: Eric Biederman <ebiederm@xmission.com>
> > Cc: Philipp Rudo <prudo@linux.vnet.ibm.com>
> > Cc: kexec@lists.infradead.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  kernel/kexec_file.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> > index f1a0e4e3fb5c..b1a25d97d5e2 100644
> > --- a/kernel/kexec_file.c
> > +++ b/kernel/kexec_file.c
> > @@ -904,7 +904,8 @@ static int kexec_purgatory_setup_sechdrs(struct purgatory_info *pi,
> >  		if (sechdrs[i].sh_flags & SHF_EXECINSTR &&
> >  		    pi->ehdr->e_entry >= sechdrs[i].sh_addr &&
> >  		    pi->ehdr->e_entry < (sechdrs[i].sh_addr
> > -					 + sechdrs[i].sh_size)) {
> > +					 + sechdrs[i].sh_size) &&
> > +		    kbuf->image->start != pi->ehdr->e_shnum) {

I think we should also be comparing against the initial value (set ~20 lines
above) of pi->ehdr->e_entry, not pi->ehdr->e_shnum.

This patch works correctly for me:

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index f7a4fd4d243f4..967826a42cdd7 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -913,7 +913,8 @@ static int kexec_purgatory_setup_sechdrs(struct purgatory_info *pi,
                if (sechdrs[i].sh_flags & SHF_EXECINSTR &&
                    pi->ehdr->e_entry >= sechdrs[i].sh_addr &&
                    pi->ehdr->e_entry < (sechdrs[i].sh_addr
-                                        + sechdrs[i].sh_size)) {
+                                        + sechdrs[i].sh_size) &&
+                   kbuf->image->start == pi->ehdr->e_entry) {
                        kbuf->image->start -= sechdrs[i].sh_addr;
                        kbuf->image->start += kbuf->mem + offset;
                }

Great find.  With those 2 quick changes, you can add:

Reviewed-by: Ross Zwisler <zwisler@google.com>

> Shouldn't this be: kbuf->image->start == pi->ehdr->e_shnum) {
> 
> ?
> 
> As you want to only do this update when it's not equal to the initial value.
> If this did work, then you may want to make sure that was the initial value.
> 
> Also, please add a comment about why you are doing this check.
> 
> Thanks!
> 
> -- Steve
> 
> >  			kbuf->image->start -= sechdrs[i].sh_addr;
> >  			kbuf->image->start += kbuf->mem + offset;
> >  		}
> > 
> > ---
> > base-commit: 17214b70a159c6547df9ae204a6275d983146f6b
> > change-id: 20230321-kexec_clang16-4510c23d129c
> > 
> > Best regards,
> > -- 
> > Ricardo Ribalda <ribalda@chromium.org>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
