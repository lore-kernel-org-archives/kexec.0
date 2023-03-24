Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB22CC6FD1C
	for <kexec@archiver.kernel.org>; Fri, 24 Mar 2023 16:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IMgVk5zG01rHXSyLgHpnLu4apljkryXL6rRT/KyIuxw=; b=P4na0XLUi+nILY
	UuTL0vbnDjnhtGPdCDgF9hMgmAID51VN4rMOT3aYg7i2QlWZgtUXr98Vidl1Wq202X9MCaCgNBSx+
	cd1F0lZ217oXb56i8zdo09RhbXg9+1SKUhU6pplfq8Zlx+YcsIwdWzBWkYytdYsLnGXeAB9qfw0I3
	zfZOb/c/s2M10xb9UeKtvsgI0JUPLINajcBvqJWV/AZO5VnZX7omyvXzipS3RMorS/lLnMp9eP35N
	hgjXy77xagvQYf4vrFg+YhTb4lr9LLYt7+FoGUB9xJqJ+LORr8m56M+ieKQRwnQKBYh89alp9YMS9
	7ul0ArO4wwkS3hLzt87Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pfjqP-004wG0-2V;
	Fri, 24 Mar 2023 16:00:45 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pfjqN-004wF7-0J
	for kexec@lists.infradead.org;
	Fri, 24 Mar 2023 16:00:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1679673640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=07VOxlALNLKaWDkjoN/aehXC/dxN7MylPi136nBJvgk=;
	b=P6Upu06BWxCnsm7CkZGfXGy5T9M7B8FKgCJKAcRshGJnqysr7I4xsWc6cLHVDrlLkckZMf
	En9OOQfqHEs+T6wYqvgWyCwzEvlpFVTV7SvlCTWVps2WSun578v7r+oAKfY4PKzCu6EhFu
	c038ohvLE2rtvTXeoPyNc1TRUEG9I6o=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-640-f88pObpsOnOEHLOHZZAtqQ-1; Fri, 24 Mar 2023 12:00:34 -0400
X-MC-Unique: f88pObpsOnOEHLOHZZAtqQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6C75A1C09066;
	Fri, 24 Mar 2023 16:00:33 +0000 (UTC)
Received: from rotkaeppchen (unknown [10.39.195.31])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 85690202701E;
	Fri, 24 Mar 2023 16:00:32 +0000 (UTC)
Date: Fri, 24 Mar 2023 16:58:55 +0100
From: Philipp Rudo <prudo@redhat.com>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Eric Biederman <ebiederm@xmission.com>, linux-kernel@vger.kernel.org,
 kexec@lists.infradead.org, Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v3] kexec: Support purgatories with .text.hot sections
Message-ID: <20230324165855.23084947@rotkaeppchen>
In-Reply-To: <20230321-kexec_clang16-v3-0-5f016c8d0e87@chromium.org>
References: <20230321-kexec_clang16-v3-0-5f016c8d0e87@chromium.org>
Organization: Red Hat inc.
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230324_090043_235156_CDDC9554 
X-CRM114-Status: GOOD (  34.97  )
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

Hi Ricardo,

On Wed, 22 Mar 2023 20:09:21 +0100
Ricardo Ribalda <ribalda@chromium.org> wrote:

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

Great analysis!

> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
> kexec: Fix kexec_file_load for llvm16
> 
> When upreving llvm I realised that kexec stopped working on my test
> platform. This patch fixes it.
> 
> To: Eric Biederman <ebiederm@xmission.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Philipp Rudo <prudo@redhat.com>
> Cc: kexec@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> ---
> Changes in v3:
> - Fix initial value. Thanks Ross!
> - Link to v2: https://lore.kernel.org/r/20230321-kexec_clang16-v2-0-d10e5d517869@chromium.org
> 
> Changes in v2:
> - Fix if condition. Thanks Steven!.
> - Update Philipp email. Thanks Baoquan.
> - Link to v1: https://lore.kernel.org/r/20230321-kexec_clang16-v1-0-a768fc2c7c4d@chromium.org
> ---
>  kernel/kexec_file.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index f1a0e4e3fb5c..25a37d8f113a 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -901,10 +901,21 @@ static int kexec_purgatory_setup_sechdrs(struct purgatory_info *pi,
>  		}
>  
>  		offset = ALIGN(offset, align);
> +
> +		/*
> +		 * Check if the segment contains the entry point, if so,
> +		 * calculate the value of image->start based on it.
> +		 * If the compiler has produced more than one .text sections
> +		 * (Eg: .text.hot), they are generally after the main .text
> +		 * section, and they shall not be used to calculate
> +		 * image->start. So do not re-calculate image->start if it
> +		 * is not set to the initial value.
> +		 */
>  		if (sechdrs[i].sh_flags & SHF_EXECINSTR &&
>  		    pi->ehdr->e_entry >= sechdrs[i].sh_addr &&
>  		    pi->ehdr->e_entry < (sechdrs[i].sh_addr
> -					 + sechdrs[i].sh_size)) {
> +					 + sechdrs[i].sh_size) &&
> +		    kbuf->image->start == pi->ehdr->e_entry) {

I'm not entirely sure if this is the solution to go with. As you state
in the comment above this solution assumes that the .text section comes
before any other .text.* section. But this assumption isn't much
stronger than the assumption that there is only a single .text section,
which is used nowadays.

The best solution I can come up with right now is to introduce a linker
script for the purgatory that simply merges the .text sections into
one. Similar to what I did for s390 in
arch/s390/purgatory/purgatory.lds.S (although for a different reason).
But that would require every architecture to get one. An alternative
would be to find a way to get rid of the -r option on the LD_FLAGS,
which IIRC is the reason why both section overlap in the first place.

Thanks
Philipp

>  			kbuf->image->start -= sechdrs[i].sh_addr;
>  			kbuf->image->start += kbuf->mem + offset;
>  		}
> 
> ---
> base-commit: 17214b70a159c6547df9ae204a6275d983146f6b
> change-id: 20230321-kexec_clang16-4510c23d129c
> 
> Best regards,


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
