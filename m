Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56EDAC88E52
	for <kexec@archiver.kernel.org>; Mon, 26 Jan 2026 12:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0yWEB3MC/IwOdZRTqjXn596FY/5KcgKt/UNJOXmLQQk=; b=vAxjZnao5hHpkuBz3NI6rT9MiK
	t6JEXGoU5dfWGgEXlSfEEfyzz6yFTILk/mGruPC+CgHJgSapEJd1plGn8vjs7aIM3NOSYD83nkODg
	+08+JM5WAsFSFXQeu1rx5Our5j58/xCxI4EvYaQx3SlqcJJT8Ism7EKJx1nJJJc0D/dIQ+Zy5CP84
	Djf1KHNuGOSy1HaNkf3q1AqXjMy4OGULrbbZeKh/l7+msGZqb/L5LCPPV3bWXDsGL7K3sw65klqIF
	6zr644JNmiK8rfxdLe2f6Kb7wIWziDSRnSZBq4jw6s3SHoYsFnSo8RX6Ex9JR7Ubv8853AdSW1jpO
	ZNUSZrCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkM08-0000000CZZS-1K8B;
	Mon, 26 Jan 2026 12:47:28 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkM06-0000000CZZD-1wbR
	for kexec@lists.infradead.org;
	Mon, 26 Jan 2026 12:47:26 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 8761160051;
	Mon, 26 Jan 2026 12:47:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32E1AC116C6;
	Mon, 26 Jan 2026 12:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769431645;
	bh=6wAT8ti4QCa4aLuMEWb3Z0RxEKoJVGK3uZ0wJAMvvnQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=KfvbgkvCznk1tlJ4lZzsg2eEdrMAvgO7UG8TYLAUCLREEOBLo49BuFec7Tqa2OdsC
	 AUY10n5LHMRvMmsZ4eZnNHSzvfjn79Wt2sm/OPIGlvBUsZj41efLMT1PJFH8bVRKnq
	 cZGM0WpMCyMM+9RYv2LoPzNGLAjatqnehL8W4mX3pbDKRv/JKwP3GxFZnJ5Fz+LDs4
	 lKGF1QioOvg/9OfZjRUvozT4QixNbDT3ic07rT9uDqg2LyaxehJnhoUleUepQLw1N+
	 ph9v8qTWtLAd6IDK8XQZdfD12svL9ITDrwsSknk9Z4p5YI0bNOJGKbdXmB0ps9n3kp
	 iUusOazWScZ1Q==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Alexander Graf <graf@amazon.com>,
  Pasha Tatashin <pasha.tatashin@soleen.com>,  Hugh Dickins
 <hughd@google.com>,  Baolin Wang <baolin.wang@linux.alibaba.com>,  Andrew
 Morton <akpm@linux-foundation.org>,  Jason Gunthorpe <jgg@nvidia.com>,
  Samiullah Khawaja <skhawaja@google.com>,  kexec@lists.infradead.org,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm: memfd_luo: preserve file seals
In-Reply-To: <aXYGkb-QtYNaWYw4@kernel.org> (Mike Rapoport's message of "Sun,
	25 Jan 2026 14:03:29 +0200")
References: <20260123095854.535058-1-pratyush@kernel.org>
	<20260123095854.535058-3-pratyush@kernel.org>
	<aXYGkb-QtYNaWYw4@kernel.org>
Date: Mon, 26 Jan 2026 13:47:21 +0100
Message-ID: <2vxzqzrca6cm.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hi Mike,

On Sun, Jan 25 2026, Mike Rapoport wrote:

> On Fri, Jan 23, 2026 at 10:58:51AM +0100, Pratyush Yadav wrote:
>> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
>> 
>> File seals are used on memfd for making shared memory communication with
>> untrusted peers safer and simpler. Seals provide a guarantee that
>> certain operations won't be allowed on the file such as writes or
>> truncations. Maintaining these guarantees across a live update will help
>> keeping such use cases secure.
>> 
>> These guarantees will also be needed for IOMMUFD preservation with LUO.
>> Normally when IOMMUFD maps a memfd, it pins all its pages to make sure
>> any truncation operations on the memfd don't lead to IOMMUFD using freed
>> memory. This doesn't work with LUO since the preserved memfd might have
>> completely different pages after a live update, and mapping them back to
>> the IOMMUFD will cause all sorts of problems. Using and preserving the
>> seals allows IOMMUFD preservation logic to trust the memfd.
>> 
>> Preserve the seals by introducing a new 8-bit-wide bitfield. There are
>> currently only 6 possible seals but 2 extra bits are used to provide
>> room for future expansion. Since the seals are UAPI, it is safe to use
>> them directly in the ABI.
>> 
>> Back the 8-bit field with a u64, leaving 56 unused bits. This is done to
>> keep the struct nice and aligned. The unused bits can be used to add new
>> flags later, potentially without even needing to bump the version
>> number.
>> 
>> Since the serialization structure is changed, bump the version number to
>> "memfd-v2".
>> 
>> Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
>> ---
>>  include/linux/kho/abi/memfd.h |  9 ++++++++-
>>  mm/memfd_luo.c                | 23 +++++++++++++++++++++--
>>  2 files changed, 29 insertions(+), 3 deletions(-)
>> 
>> diff --git a/include/linux/kho/abi/memfd.h b/include/linux/kho/abi/memfd.h
>> index 68cb6303b846..bd549c81f1d2 100644
>> --- a/include/linux/kho/abi/memfd.h
>> +++ b/include/linux/kho/abi/memfd.h
>> @@ -60,6 +60,11 @@ struct memfd_luo_folio_ser {
>>   * struct memfd_luo_ser - Main serialization structure for a memfd.
>>   * @pos:       The file's current position (f_pos).
>>   * @size:      The total size of the file in bytes (i_size).
>> + * @seals:     The seals present on the memfd. The seals are UAPI so it is safe
>> + *             to directly use them in the ABI. Note: currently there are 6
>> + *             seals possible but this field is 8 bits to leave room for future
>> + *             expansion.
>> + * @__reserved: Reserved bits. May be used later to add more flags.
>>   * @nr_folios: Number of folios in the folios array.
>>   * @folios:    KHO vmalloc descriptor pointing to the array of
>>   *             struct memfd_luo_folio_ser.
>> @@ -67,11 +72,13 @@ struct memfd_luo_folio_ser {
>>  struct memfd_luo_ser {
>>  	u64 pos;
>>  	u64 size;
>> +	u64 seals:8;
>
> Kernel uABI defines seals as unsigned int, I think we can spare u32 for
> them and reserve a u32 flags for other memfd flags (MFD_CLOEXEC,
> MFD_HUGETLB etc).

Sure, will do.

>
>> +	u64 __reserved:56;
>>  	u64 nr_folios;
>>  	struct kho_vmalloc folios;
>>  } __packed;
>>  
>>  /* The compatibility string for memfd file handler */
>> -#define MEMFD_LUO_FH_COMPATIBLE	"memfd-v1"
>> +#define MEMFD_LUO_FH_COMPATIBLE	"memfd-v2"
>>  
>>  #endif /* _LINUX_KHO_ABI_MEMFD_H */
>> diff --git a/mm/memfd_luo.c b/mm/memfd_luo.c
>> index a34fccc23b6a..eb68e0b5457f 100644
>> --- a/mm/memfd_luo.c
>> +++ b/mm/memfd_luo.c
>> @@ -79,6 +79,8 @@
>>  #include <linux/shmem_fs.h>
>>  #include <linux/vmalloc.h>
>>  #include <linux/memfd.h>
>> +#include <uapi/linux/memfd.h>
>> +
>>  #include "internal.h"
>>  
>>  static int memfd_luo_preserve_folios(struct file *file,
>> @@ -222,7 +224,7 @@ static int memfd_luo_preserve(struct liveupdate_file_op_args *args)
>>  	struct memfd_luo_folio_ser *folios_ser;
>>  	struct memfd_luo_ser *ser;
>>  	u64 nr_folios;
>> -	int err = 0;
>> +	int err = 0, seals;
>>  
>>  	inode_lock(inode);
>>  	shmem_freeze(inode, true);
>> @@ -234,8 +236,15 @@ static int memfd_luo_preserve(struct liveupdate_file_op_args *args)
>>  		goto err_unlock;
>>  	}
>>  
>> +	seals = memfd_get_seals(args->file);
>> +	if (seals < 0) {
>> +		err = seals;
>> +		goto err_free_ser;
>> +	}
>> +
>>  	ser->pos = args->file->f_pos;
>>  	ser->size = i_size_read(inode);
>> +	ser->seals = seals;
>>  
>>  	err = memfd_luo_preserve_folios(args->file, &ser->folios,
>>  					&folios_ser, &nr_folios);
>> @@ -444,13 +453,23 @@ static int memfd_luo_retrieve(struct liveupdate_file_op_args *args)
>>  	if (!ser)
>>  		return -EINVAL;
>>  
>> -	file = memfd_alloc_file("", 0);
>> +	/*
>> +	 * The seals are preserved. Allow sealing here so they can be added
>> +	 * later.
>> +	 */
>> +	file = memfd_alloc_file("", MFD_ALLOW_SEALING);
>
> I think we should select flags passed to memfd_alloc_file() based on
> ser->seals (and later based on ser->seals and ser->flags).

Not sure what you mean.

I think the only seal we can set via memfd_alloc_file() flags is
MFD_NOEXEC_SEAL, which is really a F_SEAL_EXEC and plus a change of the
inode's mode. And now that I think of it, that is a valid use case that
we might as well support. But I think that should be done by preserving
the mode of the inode directly, and then copying the seals back. The
main reason for that is that the mode can be changed after the memfd is
created too.

Other than that, all other seals are set by fcntl (via
memfd_add_seals()), so I don't see what else we can pass to
memfd_alloc_file().

>
>>  	if (IS_ERR(file)) {
>>  		pr_err("failed to setup file: %pe\n", file);
>>  		err = PTR_ERR(file);
>>  		goto free_ser;
>>  	}
>>  
>> +	err = memfd_add_seals(file, ser->seals);
>
> I'm not sure using MFD_ALLOW_SEALING is enough if there was F_SEAL_EXEC in
> seals.

Why not? memfd_add_seals() can handle F_SEAL_EXEC as far as I can tell.

>
>> +	if (err) {
>> +		pr_err("failed to add seals: %pe\n", ERR_PTR(err));
>> +		goto put_file;
>> +	}
>> +
>>  	vfs_setpos(file, ser->pos, MAX_LFS_FILESIZE);
>>  	file->f_inode->i_size = ser->size;
>>  
>> -- 
>> 2.52.0.457.g6b5491de43-goog
>> 

-- 
Regards,
Pratyush Yadav

