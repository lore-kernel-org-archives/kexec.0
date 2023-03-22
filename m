Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF3D6C6FD1C
	for <kexec@archiver.kernel.org>; Wed, 22 Mar 2023 14:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GsPHvRv+9h73kGt38I6/ZMKdbtLZCLi5GUEOGSBLt1g=; b=oi/CKUzreXckDn
	m9hNc0avrsuFOWr0FsAd4eT58jOlyTGfZWZlxqIaAlG7XQj+09iQn88PfJU268uGot8TKYqxXV8tI
	jEL4SzTxS0t2FkJQMZ5YWS+iO2XWqiEucodIP90agLeK4YhZ+OqsawJQAN2S/k2+XZ3O1pxCeijSB
	qvV9GeOxh7vMaPlEUTTJE2uupOmoHvH0dKNNBvnfplh/rH24PgGX5LDOyEnpoP/1LfZpg1ClBvTPu
	xBJHW9y6yvIRTA/xSdAdUNo+GhfUTRW7EiaN5gFDG0u0Dmr3Y3gvlBhLNVbcHz9FSEj0+JA086bgk
	GwexZKIRCJ/w2Ez7b8NA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pezYP-00GJzV-3A;
	Wed, 22 Mar 2023 14:35:06 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pezYM-00GJwI-0c
	for kexec@lists.infradead.org;
	Wed, 22 Mar 2023 14:35:04 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 891EFB81CF4;
	Wed, 22 Mar 2023 14:34:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A71DC433EF;
	Wed, 22 Mar 2023 14:34:51 +0000 (UTC)
Date: Wed, 22 Mar 2023 10:34:46 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Eric Biederman <ebiederm@xmission.com>,
	Philipp Rudo <prudo@linux.vnet.ibm.com>,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH] kexec: Support purgatories with .text.hot sections
Message-ID: <ZBsSBr87al9ccG96@home.goodmis.org>
References: <20230321-kexec_clang16-v1-0-a768fc2c7c4d@chromium.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230321-kexec_clang16-v1-0-a768fc2c7c4d@chromium.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230322_073502_381081_0E27D754 
X-CRM114-Status: GOOD (  24.23  )
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

On Tue, Mar 21, 2023 at 12:49:08PM +0100, Ricardo Ribalda wrote:
> Clang16 links the purgatory text in two sections:
> 
>   [ 1] .text             PROGBITS         0000000000000000  00000040
>        00000000000011a1  0000000000000000  AX       0     0     16
>   [ 2] .rela.text        RELA             0000000000000000  00003498
>        0000000000000648  0000000000000018   I      24     1     8
>   ...
>   [17] .text.hot.        PROGBITS         0000000000000000  00003220
>        000000000000020b  0000000000000000  AX       0     0     1
>   [18] .rela.text.hot.   RELA             0000000000000000  00004428
>        0000000000000078  0000000000000018   I      24    17     8
> 
> And both of them have their range [sh_addr ... sh_addr+sh_size] on the
> area pointed by `e_entry`.
> 
> This causes that image->start is calculated twice, once for .text and
> another time for .text.hot. The second calculation leaves image->start
> in a random location.
> 
> Because of this, the system crashes inmediatly after:
> 
> kexec_core: Starting new kernel
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> To: Eric Biederman <ebiederm@xmission.com>
> Cc: Philipp Rudo <prudo@linux.vnet.ibm.com>
> Cc: kexec@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  kernel/kexec_file.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index f1a0e4e3fb5c..b1a25d97d5e2 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -904,7 +904,8 @@ static int kexec_purgatory_setup_sechdrs(struct purgatory_info *pi,
>  		if (sechdrs[i].sh_flags & SHF_EXECINSTR &&
>  		    pi->ehdr->e_entry >= sechdrs[i].sh_addr &&
>  		    pi->ehdr->e_entry < (sechdrs[i].sh_addr
> -					 + sechdrs[i].sh_size)) {
> +					 + sechdrs[i].sh_size) &&
> +		    kbuf->image->start != pi->ehdr->e_shnum) {

Shouldn't this be: kbuf->image->start == pi->ehdr->e_shnum) {

?

As you want to only do this update when it's not equal to the initial value.
If this did work, then you may want to make sure that was the initial value.

Also, please add a comment about why you are doing this check.

Thanks!

-- Steve

>  			kbuf->image->start -= sechdrs[i].sh_addr;
>  			kbuf->image->start += kbuf->mem + offset;
>  		}
> 
> ---
> base-commit: 17214b70a159c6547df9ae204a6275d983146f6b
> change-id: 20230321-kexec_clang16-4510c23d129c
> 
> Best regards,
> -- 
> Ricardo Ribalda <ribalda@chromium.org>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
