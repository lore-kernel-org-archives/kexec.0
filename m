Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 614E0C77B75
	for <kexec@archiver.kernel.org>; Tue, 18 Apr 2023 17:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BrwqQwd6iAFgbIHRZFxDG6E+EtNqZnb/JfMcUP3WUH4=; b=xeCeBKpGhhQyCX
	HqG1qyMg2sjyYL9oKCHjJ/jPeAvKrtdr4JsClASSlP1xlEnkglzuFSah2U5+hgCNcRH2CK/0hyvgX
	AGEaWFQVjQC2s1NuO7cNEKJpJubuhiZOK1+B/GmeVC9RntWBmi/nTPlMotH9w6icUfOkgcKVhdFPM
	NhXzydJslbAKF5t45+4fQGMZoAobMxBRTO24TaJFIqFYfFhfqPhHCG97oSav2sQdOxN/bj1jYe6g7
	uX+Dy5aQYU7eM81LITNEJZ76eaT5xEV+q7FuaDS66bsS5WDX273h9guiCc/E0eWT5EkanbIa7HGw6
	Zg5giX3gvGVw66mvk98Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1popV4-002zdd-1p;
	Tue, 18 Apr 2023 17:52:18 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1popV1-002zd8-2V
	for kexec@lists.infradead.org;
	Tue, 18 Apr 2023 17:52:17 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 55F3160AD5;
	Tue, 18 Apr 2023 17:52:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB764C433D2;
	Tue, 18 Apr 2023 17:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1681840334;
	bh=za1o6VU2W+1EIlPlbU3wstltJzV9dcg9Lopt3PW9kmM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SvOVsXMygNxTEp9k7Wj/s/hUUN8YX7V8VxpGwhKUSynCvUC7/ixbWVXJyvcwljW6E
	 w1rImy+t4HaXTEZs84/pNB9Dgu0MV1VCMg23uoNUKVk1IgmibJa2U2V2K6oCRd4bDE
	 1EfeV9Y8EwW5X2M3QR1Fq08uYWzSkk7eIQUhnMiMhx3CxwIQRZwSvYgSujN2xO+mAu
	 7wI1z1xFLLgMfeS0FSqFPSovvextNNQoiGmAv103OFTB+Ex4GU24HfM8p61qewXFIj
	 VjMojg6+fJsKQD60Ul9RDX3dGz+ZdNFLuL92YS7XHWGB2SAv+avwCimzhsBotl6HeN
	 fvRcJZkVw45yA==
Date: Tue, 18 Apr 2023 19:52:09 +0200
From: Simon Horman <horms@kernel.org>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: kexec@lists.infradead.org, devicetree@vger.kernel.org,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, nayna@linux.ibm.com,
	nasastry@in.ibm.com, mpe@ellerman.id.au,
	Rob Herring <robh+dt@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Nageswara R Sastry <rnsastry@linux.ibm.com>,
	Coiby Xu <coxu@redhat.com>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v9 4/4] tpm/kexec: Duplicate TPM measurement log in
 of-tree for kexec
Message-ID: <ZD7YybmnioAs0yKR@kernel.org>
References: <20230418134409.177485-1-stefanb@linux.ibm.com>
 <20230418134409.177485-5-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230418134409.177485-5-stefanb@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230418_105215_887780_A420973E 
X-CRM114-Status: GOOD (  28.59  )
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

On Tue, Apr 18, 2023 at 09:44:09AM -0400, Stefan Berger wrote:
> The memory area of the TPM measurement log is currently not properly
> duplicated for carrying it across kexec when an Open Firmware
> Devicetree is used. Therefore, the contents of the log get corrupted.
> Fix this for the kexec_file_load() syscall by allocating a buffer and
> copying the contents of the existing log into it. The new buffer is
> preserved across the kexec and a pointer to it is available when the new
> kernel is started. To achieve this, store the allocated buffer's address
> in the flattened device tree (fdt) under the name linux,tpm-kexec-buffer
> and search for this entry early in the kernel startup before the TPM
> subsystem starts up. Adjust the pointer in the of-tree stored under
> linux,sml-base to point to this buffer holding the preserved log. The TPM
> driver can then read the base address from this entry when making the log
> available. Invalidate the log by removing 'linux,sml-base' from the
> devicetree if anything goes wrong with updating the buffer.
> 
> Use subsys_initcall() to call the function to restore the buffer even if
> the TPM subsystem or driver are not used. This allows the buffer to be
> carried across the next kexec without involvement of the TPM subsystem
> and ensures a valid buffer pointed to by the of-tree.

Hi Stefan,

some minor feedback from my side.

> Use the subsys_initcall(), rather than an ealier initcall, since

nit via checkpatch.pl --codespell: s/ealier/earlier/

> page_is_ram() in get_kexec_buffer() only starts working at this stage.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Cc: Eric Biederman <ebiederm@xmission.com>
> Tested-by: Nageswara R Sastry <rnsastry@linux.ibm.com>
> Tested-by: Coiby Xu <coxu@redhat.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

...

> +void tpm_add_kexec_buffer(struct kimage *image)
> +{
> +	struct kexec_buf kbuf = { .image = image, .buf_align = 1,
> +				  .buf_min = 0, .buf_max = ULONG_MAX,
> +				  .top_down = true };
> +	struct device_node *np;
> +	void *buffer;
> +	u32 size;
> +	u64 base;
> +	int ret;
> +
> +	if (!IS_ENABLED(CONFIG_PPC64))
> +		return;
> +
> +	np = of_find_node_by_name(NULL, "vtpm");
> +	if (!np)
> +		return;
> +
> +	if (of_tpm_get_sml_parameters(np, &base, &size) < 0)
> +		return;
> +
> +	buffer = vmalloc(size);
> +	if (!buffer)
> +		return;
> +	memcpy(buffer, __va(base), size);
> +
> +	kbuf.buffer = buffer;
> +	kbuf.bufsz = size;
> +	kbuf.memsz = size;
> +	ret = kexec_add_buffer(&kbuf);
> +	if (ret) {
> +		pr_err("Error passing over kexec TPM measurement log buffer: %d\n",
> +		       ret);

Does buffer need to be freed here?

> +		return;
> +	}
> +
> +	image->tpm_buffer = buffer;
> +	image->tpm_buffer_addr = kbuf.mem;
> +	image->tpm_buffer_size = size;
> +}

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
