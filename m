Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71BAAD0E6E0
	for <kexec@archiver.kernel.org>; Mon, 21 Oct 2024 10:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6OMF0iC9LlEz5x0sZpLzrLLD6cmsuFGwnPzsErSnUUs=; b=eqKATTaO5nZ6xj
	yz3kyJIdoMu3pDhDFsOSak+1lzyhOJOvwuSe/V4I3YHCP7HKTzkhZB+tHajUrPwSHRL8hD4B6c6xj
	c7n+ynRZJTWg6qBSEUQa+gzSjQTkFYUdIUEN6YcQkUdu9wpjWbNp5iijBCjjTMS5drauhlll8oUcK
	uW7kcCbJJ0Hljk7zD0NnWTlYe0OC9+lqwGmluXr9I8eMcyTTbuB50Fn9w7Rlk/6TFtpxempOPk4TU
	jse/cMd/v09BwvNS/+rU88i6jngXtWGH5JXX0kocV8iParnH8B+4xNnLzGcC6WdPKW1JmkmQEafhl
	tGpaI0DhPxo3TiTcyGFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t2pU0-00000006rPW-2FlU;
	Mon, 21 Oct 2024 10:17:52 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t2pT3-00000006rHn-2WF3
	for kexec@lists.infradead.org;
	Mon, 21 Oct 2024 10:16:55 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 075CDA41B96;
	Mon, 21 Oct 2024 10:16:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EBA2C4CEC3;
	Mon, 21 Oct 2024 10:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729505811;
	bh=wL/ItbdVLDv3RrjQnK+grvmCHEsAHwFRGNYp2dPQ1WY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZrmbbmXO0jv25ZkpHPD1hHaEqz1DjcjU04TQYSR9iOe9FAiV5jBKUZ3Z9mnJQSKEB
	 f/GFwzWAlOmoQCziffv7qJm9v/g33oQOP7dKFTbImCxgrgwHN8yMbN1wUMxOwGNWmm
	 E8pq3T23RbkmHTptOqClwWg0hsqtaxLd7CzdzFRbhKW6SPgpCTwV/x6D/sb3dKStIy
	 PKoEKHsIJgYDzVYsd8gqGYD4KwfVWoPBuZ190mQjS5BBZJWsl19pRJFes+gFVBlURZ
	 AFszcLaheEAdqe3xfYnahTdwgtFj3Bl1KyCrtQR2aTWIyGEla87z2N6tRWhmJ+UI2o
	 T2MvFIQu7FQVA==
Date: Mon, 21 Oct 2024 11:16:46 +0100
From: Simon Horman <horms@kernel.org>
To: Pingfan Liu <piliu@redhat.com>
Cc: Eric Biederman <ebiederm@xmission.com>, Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>, Ard Biesheuvel <ardb@kernel.org>,
	Jan Hendrik Farr <kernel@jfarr.cc>, Philipp Rudo <prudo@redhat.com>,
	Lennart Poettering <mzxreary@0pointer.de>,
	kexec@lists.infradead.org
Subject: Re: [PATCHv2 2/3] kexec: Introduce UKI image parser
Message-ID: <20241021101646.GA402847@kernel.org>
References: <20241016113418.22568-1-piliu@redhat.com>
 <20241016113418.22568-3-piliu@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241016113418.22568-3-piliu@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241021_031653_965350_CA0F9EDA 
X-CRM114-Status: GOOD (  19.64  )
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

On Wed, Oct 16, 2024 at 07:34:14PM +0800, Pingfan Liu wrote:
> A UKI image is a PE file that consists of several sections, typically
> including: .text, .data, .linux, .initrd, .cmdline, and others.
> 
> The kernel image is stored in the .linux section, which is one of the
> formats currently recognized by kexec-tools. Therefore, the UKI parser
> can be used to strip away the UKI layer, allowing the other parser to
> continue the procession of the kernel image.
> 
> Signed-off-by: Pingfan Liu <piliu@redhat.com>

...

> diff --git a/kexec/kexec-uki.c b/kexec/kexec-uki.c

...

> +int uki_image_probe(const char *file_buf, off_t buf_sz)
> +{
> +	struct pe_hdr *pe_hdr;
> +	struct pe32plus_opt_hdr *opt_hdr;
> +	struct section_header *sect_hdr;
> +	int pe_hdr_offset, section_nr, linux_sz = -1;
> +	char *pe_part_buf, *linux_src;
> +	char *initrd_fname = NULL;
> +	int initrd_fd = -1;
> +
> +	pe_hdr_offset = get_pehdr_offset(file_buf);
> +	pe_part_buf = (char *)file_buf + pe_hdr_offset;
> +	pe_hdr = (struct pe_hdr *)pe_part_buf;
> +	if (pe_hdr->opt_hdr_size == 0) {
> +		printf("ERR: optional header is missing\n");
> +		return -1;
> +	}
> +	section_nr = pe_hdr->sections;
> +	opt_hdr = (struct pe32plus_opt_hdr *)(pe_part_buf + sizeof(struct pe_hdr));
> +	sect_hdr = (struct section_header *)((char *)opt_hdr + pe_hdr->opt_hdr_size);
> +
> +	for (int i = 0; i < section_nr; i++) {
> +		if (!strcmp(sect_hdr->name, UKI_LINUX_SECTION)) {
> +			/* data_addr is relative to the whole file */
> +			linux_src = (char *)file_buf + sect_hdr->data_addr;
> +			linux_sz = sect_hdr->raw_data_size;
> +
> +		} else if (!strcmp(sect_hdr->name, UKI_INITRD_SECTION)) {
> +			if (!(initrd_fname = strdup(FILENAME_UKI_INITRD))) {
> +				dbgprintf("%s: Can't duplicate strings\n", __func__);
> +				goto next;
> +			}
> +
> +			if ((initrd_fd = mkstemp(initrd_fname)) < 0) {
> +				dbgprintf("%s: Can't open file %s\n", __func__,	initrd_fname);
> +				goto next;
> +			}
> +
> +			if (write(initrd_fd, (char *)file_buf + sect_hdr->data_addr,
> +					sect_hdr->raw_data_size) != sect_hdr->raw_data_size) {
> +				dbgprintf("%s: Can't write the compressed file %s\n",
> +						__func__, initrd_fname);
> +				goto next;

I plan to apply this series, but initrd_fd appears to be leaked here.
Could you send a follow-up patch to address that? Perhaps like this:

			err = write(...);
			close(initrd_fd)
			if (err != sect_hdr->raw_data_size) {
				...
			} else {
				...
			}

Thanks!

> +			} else {
> +				implicit_initrd_fd = open(initrd_fname, O_RDONLY);
> +				close(initrd_fd);
> +			}
> +		}
> +next:
> +		sect_hdr++;
> +	}

...

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
