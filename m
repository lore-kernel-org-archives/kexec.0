Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F9C606A320
	for <kexec@archiver.kernel.org>; Fri, 20 Nov 2026 09:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=yxe5oFyp;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=VrK+iNbS
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To
	:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=DSSS9+Kfoc3mBii8TnSdmAyAnW6IkpsziMrkIvRl8EY=; b=yxe5oFyp38TAC/UkC56J1YG6tl
	xvbwNGHm2/fNlOvNs0tnY9fx1KxyNmdTOEDd6lHxMcThATCuxTpNp5Uidg565EkUXlv2Na5IotNqb
	6f63aCv796oun98CnATz4eIfuTby4WA5P9B4g+MKw4zevHvSOMSJj9ZIFfZVig4UaGCihvriCLXu4
	wqClb+Beaszgo875dBS0abFfLV2ngoObJOk8GXG327YynDI3QegPHz6ficfGzYcdnJ1/uFmSHTp8n
	AqkGngPf/XXD2T/ht4FpUEUfqxyk9m9xIoUmJp+05v0S72lvSDkIEJDM+reeeJk/wp1Q65B3qwKl4
	h99YLi8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUKdp-0000000EQrA-17LQ;
	Fri, 20 Nov 2026 09:10:45 +0000
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUKdh-0000000EQqE-2oVN
	for kexec@lists.infradead.org;
	Fri, 20 Nov 2026 09:10:42 +0000
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-491971ac844so528295f8f.2
        for <kexec@lists.infradead.org>; Fri, 20 Nov 2026 01:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1795165836; x=1795770636; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DSSS9+Kfoc3mBii8TnSdmAyAnW6IkpsziMrkIvRl8EY=;
        b=VrK+iNbSVb/fxGsUiGRatdlrqFccYAQ/GpIl4NKU8YtojIcb6fSqS/SjhJupjq/73X
         KColNuonDXzTlTk0FWMf+Kl2m+eKBDhoVTaIjKAfKVgLT9ubLM1HVhR7ZpH38bLlkymt
         OObqOH9J4x6ge1CS2ZSzSIy7izO6aLbVedCctcli/DjtUWA8vnhkEExw2pGhpsniBnbU
         L4/uTdseIC1glRgHy0P9dnGNhI7jw5H6bo3jMMELSgkpl/24bVDpzm5wNSYXtX0DsTMt
         XnMxtKJ2x9LvjNrbKd6BJBhW2kP5laCwthkwrLFrrhhzSvjRPaWB2O0kNFOy4LmAs7l8
         rh0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795165836; x=1795770636;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DSSS9+Kfoc3mBii8TnSdmAyAnW6IkpsziMrkIvRl8EY=;
        b=zp7VM84c7Jno2rAyQ92Zg9EPdH5YKzTeV3nUPtuF3TZGR9VU5oe6+C8ip1+28FKhKg
         wFU1kM6Rciqt7VeHbnfPV/Gb9CocExZTRVPXuBDRGrvGTCFeZ5NwvifMoy4G4qWFAH+y
         r1LcoCAoiO1pX2GNIS/Q6aXNf/ysfARv9gAEfWeKY+kjB9tm6pr/dqhwsnq7t3FjS+k/
         baEGuhbQC1Ji9olmyrQpOeVW7ZyxtPNOeBr2LVXKf4tcjqtZRKEpoWMZ0bkmxUh2Xg5E
         sbf7UyVImyjfpe5H9PE+fzVmjRRI2Wc3htNx1kdJ9PHxl7J3FxwhrohoG9mQm1n2N+Ru
         xWAA==
X-Forwarded-Encrypted: i=1; AL+hErGBQT+sIUUwMNmhWON2AOWiPqq38JpxnTZdQ2j6x2cl0LBmlr2s+ui1JEL8rdONaaBR9Tl6PA==@lists.infradead.org
X-Gm-Message-State: APuU4Z/q285ZJttDe9tp8v5JLroeSbPwbU/IGFTtMxTeuceoGMAbGKB6
	EHy/umo125RP9zrHwBW5FksvsG2OnnA/LgeGTD33VWxInBUIzd8dUUvSuSc5NQyZYcE=
X-Gm-Gg: AYBFou3uzo/xrTLNVKeKoQ9EfY3dJ3Sf0p9kedmGJZsNAB9j66TzlEJHZsKfSSbAawJ
	uv56XpyUfjyrzbqf8Lvu+zHGQWhwKqD0GFPq+alRJ6QjOoKxUJTOIBOV/MTzvBPaE8wQ/M8b+WE
	zOlZwy0+x4rpOWrsVHG7/uCnVXidiwnTvaSi0e3dWPRm3E+LDemV8dOk+eXA1n3HMceVBJWj+q6
	DGRVGCxYoffmteYd/RvnPE9q0Tp58bnXaa2tn/KLbGVv/OdBBh//ovitpw9wbGVLcpvp4JqU8qj
	Bba8W9XzvSpUPr7/4sttsp8zFkXtnkR6cdSHSvF/N/+2A6mKWT5x+J8j6RFl3Glxms3IFzveUCB
	49nRfr1OM2jHqG5dCykqd5SxyXcCFNzdePqf+PJ3XN+CfRueI3/ZXEV/dHH7OZrMO7o6YY7C1m8
	ffxMNx3nFqri4NGQOK+bEH+qeBmJG5dN9OwgzfdpWehmikHEDzFhwxkZjGLsWJ0HjtCcy6phV2u
	oO2Q44ySWzPYwmSTszOeJ7bEpztxDWdN2JsiJx/3nMElcEcM4OyD3KMetKo8D5dxRodqsLOTvmg
	WYmSmOyjpgVbe4OxlfMr
X-Received: by 2002:a05:600c:4755:b0:4bb:7033:de79 with SMTP id 5b1f17b1804b1-4bb8881dd02mr49732185e9.35.1795165835650;
        Fri, 20 Nov 2026 01:10:35 -0800 (PST)
Received: from pathway ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853a9846sm114241355e9.11.2026.11.20.01.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 01:10:35 -0800 (PST)
Date: Fri, 20 Nov 2026 10:10:31 +0100
From: Petr Mladek <pmladek@suse.com>
To: Zack Rusin <zack.rusin@broadcom.com>
Subject: Re: [PATCH v4 2/4] x86/vmware: Add a bounded panic log sender
Message-ID: <awAOhyq48jRfcVWd@pathway>
References: <cover.1794980455.git.zack.rusin@broadcom.com>
 <7e985e2aea6507a0444addd816d4251f78d048f6.1794980455.git.zack.rusin@broadcom.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e985e2aea6507a0444addd816d4251f78d048f6.1794980455.git.zack.rusin@broadcom.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261120_011039_255329_DB0515EC 
X-CRM114-Status: GOOD (  26.90  )
X-Spam-Score: -2.1 (--)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Cc: linux-doc@vger.kernel.org, Kees Cook <kees@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Dave Young <ruirui.yang@linux.dev>, Stephen Brennan <stephen.s.brennan@oracle.com>, Bo Gan <bo.gan@broadcom.com>, "H. Peter Anvin" <hpa@zytor.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, Jonathan Corbet <corbet@lwn.net>, Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>, x86@kernel.org, Joel Granados <joel.granados@kernel.org>, Alexey Makhalov <alexey.makhalov@broadcom.com>, Ingo Molnar <mingo@redhat.com>, bcm-kernel-feedback-list@broadcom.com, Ajay Kaher <ajay.kaher@broadcom.com>, Bradley Morgan <brads@mainlining.org>, Baoquan He <baoquan.he@linux.dev>, John Ogness <john.ogness@linutronix.de>, virtualization@lists.linux.dev, Steven Rostedt <rostedt@goodmis.org>, Maaz Mombasawala <maaz.mombasawala@broadcom.com>, Borislav Petkov <bp@alien8.de>, Shuah Khan <skhan@linuxfoundation.org>, Michael Kelley <mhklinux@outlook.com>, Pratyush Yadav <pratyush@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ian Forbes <ian.forbes@broadcom.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, Thomas Gleixner <tglx@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed 2026-11-18 01:01:49, Zack Rusin wrote:
> A VMware guest may be unable to save its own logs after a crash. Copy
> the newest kernel log records to the host's vmware.log before kdump,
> so they remain available if the capture kernel fails.
> 
> Register the sender on the platform panic notifier list and send the
> log through the low-bandwidth register interface. Allocate a fixed
> 8 KiB buffer during early init; 4 KiB can lose useful stack-trace
> context. The callback allocates no memory and emits no printk
> messages. Limit the transfer to the buffer size and make at most three
> attempts, retrying only if a VM checkpoint interrupts the transfer.
> 
> Enable logging by default only in guests without memory encryption;
> encrypted guests should send their log to the host only when an
> administrator opts in. The copy is best-effort diagnostics; kdump does
> not depend on it succeeding.
> 
> Suggested-by: Michael Kelley <mhklinux@outlook.com>
> Link: https://lore.kernel.org/r/SN6PR02MB41574A11D309A0530C63E0FED4842@SN6PR02MB4157.namprd02.prod.outlook.com
> Link: https://lore.kernel.org/r/20260309235250.2611115-3-alexey.makhalov@broadcom.com
> Co-developed-by: Bo Gan <bo.gan@broadcom.com>
> Signed-off-by: Bo Gan <bo.gan@broadcom.com>
> Co-developed-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
> Signed-off-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
> Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>

I made just a quick review of the string manipulation and
kmsg_dump_get_buffer() API use. And it looks good to me:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Note that I am not familiar with the vmware hypercalls so that
I did not check this part.

Some nits below.

> --- a/arch/x86/kernel/cpu/vmware.c
> +++ b/arch/x86/kernel/cpu/vmware.c
> @@ -52,6 +57,23 @@
> +#define VMWARE_LOG_BUF_SIZE		SZ_8K
> +#define VMWARE_LOG_ATTEMPTS		3
> +#define VMWARE_LOG_PREFIX		"log "
> +#define VMWARE_LOG_PREFIX_LEN		(sizeof(VMWARE_LOG_PREFIX) - 1)

[...]

> +static int vmware_log_send_once(const struct vmware_rpc_channel *channel,
> +				const char *buffer, size_t length)
> +{
> +	u32 info;
> +
> +	vmware_hypercall5(VMWARE_CMD_MESSAGE | VMWARE_MSG_SENDSIZE, length,
> +			  (u32)channel->id << 16, channel->cookie_high,
> +			  channel->cookie_low, &info);
> +	if (!(info & VMWARE_MSG_STATUS_SUCCESS))
> +		return info & VMWARE_MSG_STATUS_CPT ? -EAGAIN : -EIO;
> +
> +	while (length) {
> +		size_t bytes = min_t(size_t, length, sizeof(u32));
> +		u32 word = 0;
> +
> +		memcpy(&word, buffer, bytes);
> +		vmware_hypercall5(VMWARE_CMD_MESSAGE | VMWARE_MSG_SENDPAYLOAD,
> +				  word, (u32)channel->id << 16,
> +				  channel->cookie_high, channel->cookie_low,
> +				  &info);
> +		if (!(info & VMWARE_MSG_STATUS_SUCCESS))
> +			return info & VMWARE_MSG_STATUS_CPT ? -EAGAIN : -EIO;
> +
> +		buffer += bytes;
> +		length -= bytes;
> +	}
> +
> +	return 0;
> +}

[...]

> +static int vmware_panic_log_notify(struct notifier_block *nb,
> +				   unsigned long action, void *data)
> +{
> +	struct kmsg_dump_iter iter;
> +	char *buffer = page_address(vmware_panic_page);
> +	size_t length = 0;

I would add:

	BUILD_BUG_ON(VMWARE_LOG_PREFIX_LEN > VMWARE_LOG_BUF_SIZE);

just to be on the safe side.

> +
> +	if (!READ_ONCE(vmware_record_panic_msg))
> +		return NOTIFY_DONE;
> +
> +	memcpy(buffer, VMWARE_LOG_PREFIX, VMWARE_LOG_PREFIX_LEN);

I would feel more comfortable when the trailing '\0' gets copied as
well, e.g.

	strscpy(buffer, VMWARE_LOG_PREFIX);

It is not strictly needed because the length is counted
explicitly, strlen() is not used. Also vmware_log_rpc() does
not send the trailing '\0'.

So, it is a rather a defensive programming. The buffer might be handled
another way in the future, e.g. printed by some debug code, tracing, ...

> +	kmsg_dump_rewind(&iter);
> +	(void)kmsg_dump_get_buffer(&iter, true,
> +				   buffer + VMWARE_LOG_PREFIX_LEN,
> +				   VMWARE_LOG_BUF_SIZE - VMWARE_LOG_PREFIX_LEN,
> +				   &length);
> +	(void)vmware_log_rpc(buffer, length + VMWARE_LOG_PREFIX_LEN);
> +
> +	return NOTIFY_DONE;
> +}

Best Regards,
Petr

