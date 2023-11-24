Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2BA5C61D97
	for <kexec@archiver.kernel.org>; Fri, 24 Nov 2023 07:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=seMQu8kndNHvAy8FtDkzuMR5XCrICO090WJgP+FgjV8=; b=Hlbh1gYON83xT/
	Qvj38yPzqTbAe+uue9fOv0bERJnozt0rNfEgig4l+pSWdEi/cJ+03FBd0MQhj+DzsyMVecK5BgDdR
	uL4pInv/qym5fnFAY4MMzWwig0tJi3kmzJM98uMZ5LpIpfX+6z/lA8iM3tlQuE1qL2t0yq6RiG+H/
	llPQlkHUyBDokMlZw+9FZ113zYoeFU0J+FPygl4KNoEtRGZRt/1IKN87Fo0+1cTnIp0bmrJYxvtPZ
	2C6hLeAOzzV3MXhDPquWdJmv6kW54d7f6POlTi9EWY34OwED52LJO9+T7FFSJrUH7wDd/JEd3wkqh
	F/AzLAqLhbmEJCQFJEuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r6QQu-006MYf-0w;
	Fri, 24 Nov 2023 07:17:00 +0000
Received: from smtprelay0017.hostedemail.com ([216.40.44.17] helo=relay.hostedemail.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r6QQr-006MXO-1m;
	Fri, 24 Nov 2023 07:16:58 +0000
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 6CC5C409CB;
	Fri, 24 Nov 2023 07:16:50 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf01.hostedemail.com (Postfix) with ESMTPA id 8CAE160009;
	Fri, 24 Nov 2023 07:16:47 +0000 (UTC)
Message-ID: <971ed2ceaeeba882d2b4c39015ee5ae5db3f5e82.camel@perches.com>
Subject: Re: [PATCH v2 2/7] kexec_file: print out debugging message if
 required
From: Joe Perches <joe@perches.com>
To: Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc: kexec@lists.infradead.org, x86@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, linux-parisc@vger.kernel.org, 
	akpm@linux-foundation.org, nathan@kernel.org, yujie.liu@intel.com
Date: Thu, 23 Nov 2023 23:16:46 -0800
In-Reply-To: <20231124033642.520686-3-bhe@redhat.com>
References: <20231124033642.520686-1-bhe@redhat.com>
	 <20231124033642.520686-3-bhe@redhat.com>
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: 8CAE160009
X-Stat-Signature: r4oqtahenar8h64oxpqpoeo1n6zbhmda
X-Rspamd-Server: rspamout08
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19c0OHTlDrKhb/Xt6M9rvhAh1ufC3tVTnk=
X-HE-Tag: 1700810207-170549
X-HE-Meta: U2FsdGVkX1+zlhNkZ9x3SOlShl6+X96epMaKjfHehHKyBsMtcvgR7F6Ii1tgURKZMXTJ4v77gzWxOCKJjrZ32dyx27aEd7KJtn+JaKan9d1JoOg5vx5spjNriOlsrJsAsKTNWoXgbsaaF0Aw9htJa6iNVZZnaP/omO8ddnk/a1hUgTJ/UY7dIv6hTgWYnyt0dTxqhxdXpQIY0i9zYhv989Np0jXyZefmSBvNLtvm6dtRPbiigZYQ2nQLsoXdSGX2/vxVXndB66Niab3Fp1e04lrREsrM7se2cR96ydP7F6f9OXdC0ttkSA5n1SXD5cD7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231123_231657_665838_654E6F83 
X-CRM114-Status: UNSURE (   9.41  )
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

On Fri, 2023-11-24 at 11:36 +0800, Baoquan He wrote:
> Replace pr_debug() with the newly added kexec_dprintk() in kexec_file
> loading related codes.

trivia for pr_debug -> kexec_dprintk conversions for
the entire patch set:

> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
[]
> @@ -551,9 +551,12 @@ int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
>  		phdr->p_filesz = phdr->p_memsz = mend - mstart + 1;
>  		phdr->p_align = 0;
>  		ehdr->e_phnum++;
> -		pr_debug("Crash PT_LOAD ELF header. phdr=%p vaddr=0x%llx, paddr=0x%llx, sz=0x%llx e_phnum=%d p_offset=0x%llx\n",
> +#ifdef CONFIG_KEXEC_FILE
> +		kexec_dprintk("Crash PT_LOAD ELF header. phdr=%p vaddr=0x%llx, paddr=0x%llx, "
> +			"sz=0x%llx e_phnum=%d p_offset=0x%llx\n",
>  			phdr, phdr->p_vaddr, phdr->p_paddr, phdr->p_filesz,
>  			ehdr->e_phnum, phdr->p_offset);

It's good form to rewrap continuation lines to the open parenthesis

> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
[]
> @@ -389,11 +391,12 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
>  	if (ret)
>  		goto out;
>  
> +	kexec_dprintk("nr_segments = %lu\n", image->nr_segments);
>  	for (i = 0; i < image->nr_segments; i++) {
>  		struct kexec_segment *ksegment;
>  
>  		ksegment = &image->segment[i];
> -		pr_debug("Loading segment %d: buf=0x%p bufsz=0x%zx mem=0x%lx memsz=0x%zx\n",
> +		kexec_dprintk("segment[%d]: buf=0x%p bufsz=0x%zx mem=0x%lx memsz=0x%zx\n",
>  			 i, ksegment->buf, ksegment->bufsz, ksegment->mem,
>  			 ksegment->memsz);

here too etc...


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
