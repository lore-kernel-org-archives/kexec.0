Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6862E606A334
	for <kexec@archiver.kernel.org>; Tue, 10 Nov 2026 17:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=hgTIOH07;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DIrrzKib
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Fulrg35l8yGwvpvq8cPY9YnUHn/OJvxhodbRy0q5+gI=; b=hgTIOH07XcX/D8HSnFauRaPWqO
	4yQ6tkl7k/8w6Tr1mTzhRwy6PUhMYXg0jrMazmTXeifmRziWl0jLgkWuPCRaAOW4pikInaUBazhAi
	njrS0W1TCVi7fowZo1ZUH34YhtHmGvVfQOPDMGpPwwNOsjCVoIRl991OGaJC1kOhiXncsj+F10SFR
	/9+ekOySjDpXyh3txrdiuj61P43/0g4Xa5msycsNlchmR6hxKl6r0mbvMgKKcJoHhUaQvQvtBCo58
	Q6Y/XDkek+K3CnQHuMuuZO4bLIGp7C4sDRD4HqNTTqIf+nEETuJYYRyWV/Zfmvl35DhQ8ZGU9B0ic
	DSbZtawQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQptI-00000004i11-1WyW;
	Tue, 10 Nov 2026 17:44:16 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQptG-00000004i0h-36E4
	for kexec@lists.infradead.org;
	Tue, 10 Nov 2026 17:44:14 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 26AF543802;
	Tue, 10 Nov 2026 17:44:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B35D1F0089F;
	Tue, 10 Nov 2026 17:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794332654;
	bh=Fulrg35l8yGwvpvq8cPY9YnUHn/OJvxhodbRy0q5+gI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=DIrrzKibIe7LMcyHZ/CBt/f3kkB050KIX7QvR3SdZ/cydQJymBTzfBKZobEaAU9FS
	 AQPpwd69AgUgqddeKluymH1MgZworh5C2kzPXb6ipLMj/S8C8n11LY31oO8mmXtFk8
	 mh9nvu5cYFu2ZpOei+19puwSA8Lg7RWpYU/MqCIGxMwgs/XYzlxP5SYfd5ULfBsH0p
	 ctMi4gIX0c6ZTJPwKz/6fT4a9RnBFgdnOz0HtRmxlhqxOJwyPgWMmUf9I+6B4RF2o5
	 7R/d3E4EMW1XJeNCFKrx0V8ozF9R+YgZkiLrad7/FCRWMAbMLWn8ioq+EhBII0BH5n
	 oZ5+J1fIzQxHA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Mike Rapoport <rppt@kernel.org>,
  Andrew Morton <akpm@linux-foundation.org>,  Samiullah Khawaja
 <skhawaja@google.com>,  kexec@lists.infradead.org,
  linux-kernel@vger.kernel.org,  linux-mm@kvack.org
Subject: Re: [PATCH 2/2] mm/memfd_luo: keep memfd frozen until finish
In-Reply-To: <179373810485.663454.3013535045194073890.b4-review@b4> (Pasha
	Tatashin's message of "Tue, 03 Nov 2026 15:35:04 -0500")
References: <20261103181916.2462825-1-pratyush@kernel.org>
	<20261103181916.2462825-3-pratyush@kernel.org>
	<179373810485.663454.3013535045194073890.b4-review@b4>
Date: Tue, 10 Nov 2026 18:44:11 +0100
Message-ID: <2vxzo6bwh990.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 03 2026, Pasha Tatashin wrote:

>> After a memfd is retrieved, it immediately goes back into "normal"
>> operation. The file comes back unfrozen, and its pages can migrate, it
>> can be truncated, and so on. If the memfd is depended on by something,
>> like iommufd, that can open a window for folios to move around before
>> the consumer can re-establish its references.
>> 
>> Finish is the conceptual point when a retrieved file can start to behave
>> as "normal". So take an extra reference on the folios and freeze the
>> memfd on retrieve until finish.
>> 
>> Suggested-by: Pasha Tatashin <pasha.tatashin@soleen.com>
>> Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
>> Link: https://patch.msgid.link/20261103181916.2462825-3-pratyush@kernel.org
>>
>> diff --git a/mm/memfd_luo.c b/mm/memfd_luo.c
>> index 6b68220275eb..5abb9c0956af 100644
>> --- a/mm/memfd_luo.c
>> +++ b/mm/memfd_luo.c
>> @@ -55,6 +55,14 @@
>>   *   Only seals known to this LUO version (see ``MEMFD_LUO_ALL_SEALS``) may
>>   *   be present; preservation fails with ``-EOPNOTSUPP`` otherwise.
>>   *
>> + * Restrictions
>> + * ============
>> + *
>> + * While a memfd is preserved, and after it is retrieved until the session is
>> + * finished, its size can't be changed and holes can't be punched in it.
>> + * Operations that would do so (``ftruncate()``, ``fallocate()``, writes past
>> + * the end of the file) fail.
>> + *
>>   * Non-Preserved Properties
>>   * ========================
>>   *
>> @@ -383,33 +391,56 @@ static void memfd_luo_discard_folios(const struct memfd_luo_folio_ser *folios_se
>>  	}
>>  }
>>  
>> +/* Drop the references retrieve() holds on the folios added to the file. */
>> +static void
>> +memfd_luo_put_retrieved_folios(const struct memfd_luo_folio_ser *folios_ser,
>> +			       u64 nr_folios)
>> +{
>> +	for (u64 i = 0; i < nr_folios; i++) {
>> +		const struct memfd_luo_folio_ser *pfolio = &folios_ser[i];
>> +
>> +		if (pfolio->pfn)
>> +			folio_put(pfn_folio(pfolio->pfn));
>> +	}
>> +}
>> +
>>  static void memfd_luo_finish(struct liveupdate_file_op_args *args)
>>  {
>>  	struct memfd_luo_folio_ser *folios_ser;
>>  	struct memfd_luo_ser *ser;
>>  
>> -	/*
>> -	 * If retrieve was successful, nothing to do. If it failed, retrieve()
>> -	 * already cleaned up everything it could. So nothing to do there
>> -	 * either. Only need to clean up when retrieve was not called.
>> -	 */
>> -	if (args->retrieve_status)
>> +	/* If retrieve failed, it already cleaned up everything it could. */
>> +	if (args->retrieve_status < 0)
>>  		return;
>>  
>>  	ser = phys_to_virt(args->serialized_data);
>>  	if (!ser)
>>  		return;
>>  
>> -	if (ser->nr_folios) {
>> -		folios_ser = kho_restore_vmalloc(&ser->folios);
>> -		if (!folios_ser)
>> -			goto out;
>> +	if (args->retrieve_status > 0) {
>> +		/*
>> +		 * Retrieve was successful, release the folios and unfreeze the
>> +		 * file so it can be used normally.
>> +		 */
>> +		struct inode *inode = file_inode(args->file);
>> +
>> +		folios_ser = args->private_data;
>> +
>> +		inode_lock(inode);
>> +		memfd_luo_put_retrieved_folios(folios_ser, ser->nr_folios);
>> +		shmem_freeze(inode, false);
>> +		inode_unlock(inode);
>>  
>> -		memfd_luo_discard_folios(folios_ser, ser->nr_folios);
>>  		vfree(folios_ser);
>> +	} else if (args->retrieve_status == 0 && ser->nr_folios) {
>> +		/* Retrieve was not called, discard the preserved folios. */
>> +		folios_ser = kho_restore_vmalloc(&ser->folios);
>> +		if (folios_ser) {
>> +			memfd_luo_discard_folios(folios_ser, ser->nr_folios);
>> +			vfree(folios_ser);
>> +		}
>
> Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com> 
>
> Side note (pre-existing, not an issue with this patch):
>
> Initially, I wondered whether we should disallow auto-finishing an 
> unretrieved memfd, in case a preserved device still had this memory 
> mapped for DMA. However, if we reach this point, can_finish() has 
> already passed for every other FD in this session, which means any 
> possibly dependent FDs (e.g. iommufd/vfio) have already determined that 
> this FD was not needed to be retrieved for their states.

I think that is still a problem in a different path.
memfd_luo_retrieve_folios() frees all the folios on error. I think it
should hold them until finish(), which would give IOMMU or other
dependents a chance to block the finish.

But yeah, that would be a separate patch.

-- 
Regards,
Pratyush Yadav

