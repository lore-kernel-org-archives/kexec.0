Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D003BC00528
	for <kexec@archiver.kernel.org>; Tue,  1 Aug 2023 19:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:From:Subject:
	Cc:Message-Id:Date:Mime-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xmvSgKrbLMN2X/xsotXoGpxPGvEm72YlGbGl32HDbUk=; b=0DOqRJlgjPoW2m
	KhHpwwKTJ2kJvxXyOFMvly20F8DXG8Npzv0JnkCXRVITDMD6npnvwGrtWqWQFGvT4m/U7oKfQ/cJr
	eOtK50ihM1PuFMHD2P9U1k6VC+GDFEodmzVI3QeZ7sCuIClY5fu6bPIymtqcKRBAtGhfPWWv1yr7i
	3sfI8cGiUp+gTejBc4cAni9bHe8f+rn/WWwahNS0LiwE04teX3ieJehgi0ESemV5atIwBZ/G1r2NR
	NkIRV0yk2zSysls+sd651buQYAeFKwQqeMNfSoUXIfL8h/6bk0BuhjcZVjPxShD4+R+OP9N/QHf9V
	YeGbHhnmf1tuHBz9YQgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qQudz-00366y-2f;
	Tue, 01 Aug 2023 19:02:55 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qQudw-003666-36
	for kexec@lists.infradead.org;
	Tue, 01 Aug 2023 19:02:54 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id E4C51616A9;
	Tue,  1 Aug 2023 19:02:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71600C433B7;
	Tue,  1 Aug 2023 19:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690916571;
	bh=QELR0/VAgEvzHkL6pJaiqVMd5NFnPPFbeIgCxZeiFqk=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=LekJib2hmEP7rOzsvbZ3XD57rkAM99mf29ceW+HF3IaV+WYLEB8vkd7AJOhnbttHi
	 f6230wbVhTFqow4q+qWBm/P2uJVkMOwCyJWHWbLYzN+WUVCgPrMLSm+5ef38uo/6d3
	 CCeUmsrweBtNJgsvEf+lTNmGJkpxKMyxsBpsjf222rIHHdF7Adu29RziPef9nFX6g2
	 XxOl2myyB59y9IkvoWCEzMB7vEmPwacQhAOq7GaDWtfo9C9GuosERC6S43dv+oOSBP
	 psb80SRaUN4LP8zMtBxLnxL75G9QHadHgVBDcfCduyw839l3s6aUnboe/bMBnwO5nc
	 ZpkwYaslLuPvA==
Mime-Version: 1.0
Date: Tue, 01 Aug 2023 22:02:45 +0300
Message-Id: <CUHFWAAKMKJN.2EA3ZHLOOPPGB@suppilovahvero>
Cc: <code@tyhicks.com>, <nramas@linux.microsoft.com>, <paul@paul-moore.com>
Subject: Re: [PATCH 1/6] tpm: implement TPM2 function to get update counter
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Tushar Sugandhi" <tusharsu@linux.microsoft.com>, <zohar@linux.ibm.com>,
 <noodles@fb.com>, <bauermann@kolabnow.com>, <ebiederm@xmission.com>,
 <bhe@redhat.com>, <vgoyal@redhat.com>, <dyoung@redhat.com>,
 <peterhuewe@gmx.de>, <jgg@ziepe.ca>, <kexec@lists.infradead.org>,
 <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.14.0
References: <20230801181917.8535-1-tusharsu@linux.microsoft.com>
 <20230801181917.8535-2-tusharsu@linux.microsoft.com>
In-Reply-To: <20230801181917.8535-2-tusharsu@linux.microsoft.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230801_120253_084178_590C4190 
X-CRM114-Status: GOOD (  27.21  )
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

The short summary is cryptic to say the least.

"update counter" does not map it to have anything to do with PCRs.

Why not "tpm: Read pcrUpdateCounter field from TPM2_PCR_Read"?

On Tue Aug 1, 2023 at 9:19 PM EEST, Tushar Sugandhi wrote:
> The TPM2_PCR_Read command returns TPM2_PCR_Read Response struct[1].  It
> contains pcrUpdateCounter member which contains the current value of TPM
> PCR update counter.  The update counter provides the number of times the
> PCRs are updated, which is essential for tracking changes and verifying
> system integrity.  Thus, subsystems (like IMA) should measure
> pcrUpdateCounter value.  Although tpm2_pcr_read_out struct is returned
> by tpm2_pcr_read(), it is not used by it's caller function tpm_pcr_read().
> Further, TPM2_PCR_Read Response struct and pcrUpdateCounter is not
> available in tpm1_pcr_read().
>
> PcrUpdateCounter is only needed in a specific case (IMA for measurements).
> Changing tpm_pcr_read() and tpm2_pcr_read() function signature to return
> tpm2_pcr_read_out struct would be a more disruptive change, since these
> functions are used elsewhere too.  Creating separate functions to get
> pcrUpdateCounter when needed would be a cleaner approach.
>
> Add a function, 'tpm2_pcr_get_update_counter()' to retrieve
> the update counter for a given PCR index and algorithm ID on a TPM2 chip.
>
> This function complements existing TPM functionalities such as reading
> and extending PCRs, and enhances the ability to monitor PCR status
> in the Linux Kernel. 
>
> [1] https://trustedcomputinggroup.org/wp-content/uploads/TCG_TPM2_r1p59_Part3_Commands_pub.pdf
> Section 22.4.2, Page 206.
>
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> ---
>  drivers/char/tpm/tpm.h      |  3 +++
>  drivers/char/tpm/tpm2-cmd.c | 48 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 51 insertions(+)
>
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index 830014a26609..60489f21d3bd 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -288,6 +288,9 @@ static inline void tpm_add_ppi(struct tpm_chip *chip)
>  int tpm2_get_timeouts(struct tpm_chip *chip);
>  int tpm2_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
>  		  struct tpm_digest *digest, u16 *digest_size_ptr);
> +int tpm2_pcr_get_update_counter(struct tpm_chip *chip,
> +				u32 pcr_idx, u16 alg_id,
> +				u32 *update_counter);

tpm_pcr_read_update_cnt()

>  int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
>  		    struct tpm_digest *digests);
>  int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max);
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index 93545be190a5..55f4e102289a 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -216,6 +216,54 @@ int tpm2_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
>  	return rc;
>  }
>  
> +/**
> + * tpm2_pcr_get_update_counter() - gets an update counter value for a PCR bank
> + * @chip: TPM chip to use
> + * @pcr_idx: PCR index used to retrieve the update counter
> + * @alg_id:	alg id used to retrieve the update counter
> + * @update_counter: output update counter value
> + *
> + * Return: Same as with tpm_transmit_cmd.
> + */
> +int tpm2_pcr_get_update_counter(struct tpm_chip *chip,
> +				u32 pcr_idx, u16 alg_id, u32 *update_counter)
> +{
> +	int rc;
> +	struct tpm_buf buf;
> +	struct tpm2_pcr_read_out *read_out;
> +	u8 pcr_select[TPM2_PCR_SELECT_MIN] = {0};
> +
> +	if (pcr_idx >= TPM2_PLATFORM_PCR)
> +		return -EINVAL;
> +
> +	if (!update_counter)
> +		return -EINVAL;
> +
> +	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_PCR_READ);
> +	if (rc)
> +		return rc;
> +
> +	pcr_select[pcr_idx >> 3] = 1 << (pcr_idx & 0x7);
> +
> +	tpm_buf_append_u32(&buf, 1);
> +	tpm_buf_append_u16(&buf, alg_id);
> +	tpm_buf_append_u8(&buf, TPM2_PCR_SELECT_MIN);
> +	tpm_buf_append(&buf, (const unsigned char *)pcr_select,
> +		       sizeof(pcr_select));
> +
> +	rc = tpm_transmit_cmd(chip, &buf, 0, "attempting to read a pcr value");
> +	if (rc)
> +		goto out;
> +
> +	read_out = (struct tpm2_pcr_read_out *)&buf.data[TPM_HEADER_SIZE];
> +
> +	*update_counter = be32_to_cpu(read_out->update_cnt);
> +
> +out:
> +	tpm_buf_destroy(&buf);
> +	return rc;
> +}
> +
>  struct tpm2_null_auth_area {
>  	__be32  handle;
>  	__be16  nonce_size;
> -- 
> 2.25.1

BR, Jarkko

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
