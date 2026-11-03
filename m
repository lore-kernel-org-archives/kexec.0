Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D16B606A31B
	for <kexec@archiver.kernel.org>; Tue,  3 Nov 2026 20:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=25m8eUWW;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=DvlXA5un
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=+aadLIA3GPIeeFSZgpfHdaGRi1nlOlSeRKXWPRo2sBI=; b=25m8eUWWb7Mkk+
	TP2i2JHk1xJGxc8D7gxBEUFF0ja1BEHn5H3cN/OEJ0fNPu8GJGFm4JKsoGTKE3VIRvO1NCjtjG2GS
	f+foxnvgZAHKQzCtjDyfPxEUbwqKtdOCJbKO4UQ60jJL5FcsDz21aeH6cJNZjbQ+TvfVEi4QX0o6v
	o3x0vpwf2lhYjqRnJ7BB0nb0csgIvu8kQ0UqoTgXwF9o7IYV9uJQPKA4RgytwY+P874MqJGOQO4OZ
	xT819H0qHP9Zn15CdvsMkAPu6xiQEgmQx3ExGdZjrdwZR1DEJYv8RYzOjqI+FPgSRGkkuqEOGnQeh
	+RfswmZqOau+Cn1Y003A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOLDt-00000003dPU-2wal;
	Tue, 03 Nov 2026 20:35:13 +0000
Received: from mail-ua1-x92e.google.com ([2607:f8b0:4864:20::92e])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOLDq-00000003dOQ-3vdS
	for kexec@lists.infradead.org;
	Tue, 03 Nov 2026 20:35:12 +0000
Received: by mail-ua1-x92e.google.com with SMTP id a1e0cc1a2514c-988bb309c2bso6099241.1
        for <kexec@lists.infradead.org>; Tue, 03 Nov 2026 12:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1793738109; x=1794342909; darn=lists.infradead.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+aadLIA3GPIeeFSZgpfHdaGRi1nlOlSeRKXWPRo2sBI=;
        b=DvlXA5unCUhc7rYZ9QuAGTYyDEWk7xv7D52hkpEAEPLKCO2c9p7PF4uQu3RNkQnkjo
         dpMRD8GhXdJeiZIzUKn7hJyvL70OEiErd/uPg9A/C9r2zbEgGxiUQgWOcSdnAaA92sDE
         vCMyA+F6mC11ojg35+WP0YCMzuruMBScwRoIFAOfhHRrT+qqN5NKoaNodT24/29TrX3S
         i26PQB2R1HP1TIopcpPYgcEAzKo9ZiO8Mepal2LK+on1/IQgVbipMu/46lSiBg9f6DiK
         iPa4/zwZfe0STqaINvYW30zzryUH5s3FxJXsVk7pqfULl8pqCObXWBpDpKjBbewwmwUe
         EDxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793738109; x=1794342909;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+aadLIA3GPIeeFSZgpfHdaGRi1nlOlSeRKXWPRo2sBI=;
        b=GvI5kgbxZdlnc8th2R8R2J+Ec+7M1ElBATkPQC3vWaVFY4nxwXUsLGSxDDraAxxWza
         1CYXza/hC4jZ9NUsIdz2KXA9Ap0F4OqygkFiTgeOD4eQaF8uEyXCU2dQklh+kGf9VSrk
         7TwE/Ssj8IxQFq/21oup/0UmxMtxFPEuEZ1XJYQQAJQJxiKEp968QIXF+XBPD0dOXN0N
         +YrzDyoWeHKFSPiuJlozm1LAxKaxXhgsZkih47GE4gw1GebPE6ko51nHxvJJIYhfr9FL
         KkHOS+mOplQ+t7y4jIssmPVLjQi6qSmYRKAkBnXCgGca5giYeYuDsNhdx91MRYbvVrSx
         GztA==
X-Forwarded-Encrypted: i=1; AKwUvBw/8+ZtfdEfZUGej2GEu2GM1MWC21QK3PzcfXhd3qiyrwyTf2A8/1JwB3kSTkBXRAtDPyItVw==@lists.infradead.org
X-Gm-Message-State: APuU4Z/G/I21tZbTqVEraHnle6JxLFYOY0xHpyzhtb8OJsnlYtoU20Fc
	f/CJQlBNuQDn+k84rjHZ+gRNt5s7glwhFCxxmIH38ysZyKW1Z+Dq9Q2NGKHF6xI3dIE=
X-Gm-Gg: AYBFou1P7QPUtoiGCgSlNGrsgMsO/ibjAJMT7CUPn2ZMP2dQhgy4kztWeIMrESy3i2s
	xrbknryPZb/UEGZ2mFrjP8d2o1XGwQXLSRKFwEbymsQCtd7dGSYGfD82dgGKs6IGNkwHs2VbLBs
	bR2Pas1APrYxwLqlEZQW8NrBGiYaSEGl7/aZFSqhcdfIWFGFmFHY5iSdrUlW2wuqcN76jduNS35
	DC6JOSwjJogMWumaD+4yXabVI3Mq4cgizljnA/Wm0pjca1k1TeOJrhXAjFiM6vWFMAGb3Xz30o6
	OJdBkUZCJMHJflJueORzX0bSm4sw60kH+76+vSo5B+A9H/OJnH8Q7VI8UyV71GznyTfkFC+4ndO
	rhIbMSsSaIqPR9lG0mQLog8UpKhjePq8RgHXHabp8KqiDgJVF8ZZptSQWWRblSJnaYoHoa+P3ii
	c+rnku6u/qPVVaC22hFctdhakgXwjkRVmzSVqcvA0ovyX0g77Y/W0Y2mgWDLBPHZHg/KyfNYRcO
	4SyRzAXebLkJcdG+6Ywu3so8968+ziMJoTqdyY/I7OttwlWNzrlQyC8frm22KIpy/OUZFswD4SO
	7ru4Up3ZD0ihSKhVIdCyTXa1Z4jfeWm6+K7ngXmFOIdYDER2KQeA0d4gkcn39BxZOAyayUwSHtF
	7jhxJ+/A63+nm5uffbkQzeYnz8ckEohR0F02hZm4xu3zEbPY=
X-Received: by 2002:a05:6102:fa0:b0:7b4:879c:bb76 with SMTP id ada2fe7eead31-7d072c45613mr6088445137.21.1793738109309;
        Tue, 03 Nov 2026 12:35:09 -0800 (PST)
Received: from soleen.c.googlers.com (64.167.245.35.bc.googleusercontent.com. [35.245.167.64])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-998d91d212bsm155984241.6.2026.11.03.12.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 12:35:08 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 2/2] mm/memfd_luo: keep memfd frozen until finish
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 Samiullah Khawaja <skhawaja@google.com>, kexec@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <20261103181916.2462825-3-pratyush@kernel.org>
References: <20261103181916.2462825-1-pratyush@kernel.org>
 <20261103181916.2462825-3-pratyush@kernel.org>
Date: Tue, 03 Nov 2026 15:35:04 -0500
Message-Id: <179373810485.663454.3013535045194073890.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4103;
 i=pasha.tatashin@soleen.com; h=from:subject:message-id;
 bh=Q9ypSzsjws//mPEdnfoKVj2XLrGaTXlODYwHP6URKeI=;
 b=owEBbQKS/ZANAwAKAbt3KEzbc3reAcsmYgBq6kV7gzwYxzNrt8ME5QZOVfBKCFWD7TcrD+6Y8
 XNUBOCAUIGJAjMEAAEKAB0WIQRBMaqT7LRvGvB/NmK7dyhM23N63gUCaupFewAKCRC7dyhM23N6
 3oOmD/45tsbGyvIfML7jhFB8SNoj9u0KhnedpAIpQwPtIW7BQkCU/VWLhvj6VtL0up9s07eAQb3
 X0G2UQD0u0r+KV3PffnvpmK3T7y+i2Q4vnJYb8UEeMuQBN4itfu+yFwFCxasz4skubWeoBcapZB
 JVHeuQL9rCZC+I8HL0SICEZCArUMYqWQ4gs5YLMwgb0+SI8TNTqIKuhgp+EL6mapJC2G7mp1l/d
 i80dMJBv4h0R+5nxX9TIKWZkDopl4CeHS6rNovT7htVgNiktIOAo/LvBiJ/Guag9NLwF+bdUk0K
 sKTTiGKm5Jcg5fkNhHrfwNdp+XAIb5Qx3OIGXfDy+4tH+as2CXTDIbR+cyXF7xVv0HCmxQL9hEE
 TEUdFej1A/CubkfpkVWuXldkQk1MngOiRcJ7saqYSjsNmJoN1FCYjLJHWMKCBlWbMeAlvgIbcf6
 P6lwko+CGQi1QvrDhK3v5TgKCkkdUJUsclABW64ciR/95j5dexoupov6Fmt4+kG+ZucpANvb5L+
 oZCOAUXQ2sqSRJHRv6qPK6ODHQ0GZIMoHBRqRA7Sq72ngSVaFqlTeAiNxfXN3q6LrT6pVnlaU9W
 v0+6Nd4cqgxNCJhp6rMst1eW+1nD+B71CoraCgtW4DCy79RDJIS6HmAdQjJTCRCJUKatPy0GwcM
 khpcHll+P8oHIEg==
X-Developer-Key: i=pasha.tatashin@soleen.com; a=openpgp;
 fpr=CAAAB722DD22A081F0D49F35633A6A993D43B569
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261103_123511_137164_E5655BAE 
X-CRM114-Status: GOOD (  28.10  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> After a memfd is retrieved, it immediately goes back into "normal"
> operation. The file comes back unfrozen, and its pages can migrate, it
> can be truncated, and so on. If the memfd is depended on by something,
> like iommufd, that can open a window for folios to move around before
> the consumer can re-establish its references.
> 
> Finish is the conceptual point when a retrieved file can start to behave
> as "normal". So take an extra reference on the folios and freeze the
> memfd on retrieve until finish.
> 
> Suggested-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
> Link: https://patch.msgid.link/20261103181916.2462825-3-pratyush@kernel.org
>
> diff --git a/mm/memfd_luo.c b/mm/memfd_luo.c
> index 6b68220275eb..5abb9c0956af 100644
> --- a/mm/memfd_luo.c
> +++ b/mm/memfd_luo.c
> @@ -55,6 +55,14 @@
>   *   Only seals known to this LUO version (see ``MEMFD_LUO_ALL_SEALS``) may
>   *   be present; preservation fails with ``-EOPNOTSUPP`` otherwise.
>   *
> + * Restrictions
> + * ============
> + *
> + * While a memfd is preserved, and after it is retrieved until the session is
> + * finished, its size can't be changed and holes can't be punched in it.
> + * Operations that would do so (``ftruncate()``, ``fallocate()``, writes past
> + * the end of the file) fail.
> + *
>   * Non-Preserved Properties
>   * ========================
>   *
> @@ -383,33 +391,56 @@ static void memfd_luo_discard_folios(const struct memfd_luo_folio_ser *folios_se
>  	}
>  }
>  
> +/* Drop the references retrieve() holds on the folios added to the file. */
> +static void
> +memfd_luo_put_retrieved_folios(const struct memfd_luo_folio_ser *folios_ser,
> +			       u64 nr_folios)
> +{
> +	for (u64 i = 0; i < nr_folios; i++) {
> +		const struct memfd_luo_folio_ser *pfolio = &folios_ser[i];
> +
> +		if (pfolio->pfn)
> +			folio_put(pfn_folio(pfolio->pfn));
> +	}
> +}
> +
>  static void memfd_luo_finish(struct liveupdate_file_op_args *args)
>  {
>  	struct memfd_luo_folio_ser *folios_ser;
>  	struct memfd_luo_ser *ser;
>  
> -	/*
> -	 * If retrieve was successful, nothing to do. If it failed, retrieve()
> -	 * already cleaned up everything it could. So nothing to do there
> -	 * either. Only need to clean up when retrieve was not called.
> -	 */
> -	if (args->retrieve_status)
> +	/* If retrieve failed, it already cleaned up everything it could. */
> +	if (args->retrieve_status < 0)
>  		return;
>  
>  	ser = phys_to_virt(args->serialized_data);
>  	if (!ser)
>  		return;
>  
> -	if (ser->nr_folios) {
> -		folios_ser = kho_restore_vmalloc(&ser->folios);
> -		if (!folios_ser)
> -			goto out;
> +	if (args->retrieve_status > 0) {
> +		/*
> +		 * Retrieve was successful, release the folios and unfreeze the
> +		 * file so it can be used normally.
> +		 */
> +		struct inode *inode = file_inode(args->file);
> +
> +		folios_ser = args->private_data;
> +
> +		inode_lock(inode);
> +		memfd_luo_put_retrieved_folios(folios_ser, ser->nr_folios);
> +		shmem_freeze(inode, false);
> +		inode_unlock(inode);
>  
> -		memfd_luo_discard_folios(folios_ser, ser->nr_folios);
>  		vfree(folios_ser);
> +	} else if (args->retrieve_status == 0 && ser->nr_folios) {
> +		/* Retrieve was not called, discard the preserved folios. */
> +		folios_ser = kho_restore_vmalloc(&ser->folios);
> +		if (folios_ser) {
> +			memfd_luo_discard_folios(folios_ser, ser->nr_folios);
> +			vfree(folios_ser);
> +		}

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com> 

Side note (pre-existing, not an issue with this patch):

Initially, I wondered whether we should disallow auto-finishing an 
unretrieved memfd, in case a preserved device still had this memory 
mapped for DMA. However, if we reach this point, can_finish() has 
already passed for every other FD in this session, which means any 
possibly dependent FDs (e.g. iommufd/vfio) have already determined that 
this FD was not needed to be retrieved for their states.

-- 
Pasha


