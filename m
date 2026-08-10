Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E71D3C5B567
	for <kexec@archiver.kernel.org>; Mon, 10 Aug 2026 17:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jk4/iqf3QlrsL8m2XoV0Xf9bF4tI4hIm7T5gSdo0XHA=; b=rnvkuGlXTVt7ksESQpUImTYm4O
	aA2rWvr63JHkGIWNu+YJ2ExpggFkrzxqftWjcIC8V/yQGJTfN8HeQtT2EayWLZYUjrrFN2tiGzoEE
	kA4ZQVUpl/XG0WQN6Pf44OJp5wrbbrl2fVbSVBt0Onz8ySSOI2wEs3NGEaLUx/80r5oAQ5pRT4Gu5
	4LD8zv0tvv84v+jxP2HnoVPTet3IEsWRMpmbgN6cd9BJayZpg8CEgynemkXoNAAwD9ZyZaNHRiyI7
	Ye46+g3C7H1ebaFhANxVfe4via7i90dgCNPhQ6lRVLNfoSowUpVJpcyvO6xQzGGD4c6dB0UQBZhsd
	PVrsBW9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtTxr-0000000CXt5-2teg;
	Mon, 10 Aug 2026 17:39:07 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtTxq-0000000CXsp-1zDC
	for kexec@lists.infradead.org;
	Mon, 10 Aug 2026 17:39:06 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 0669C4402C;
	Mon, 10 Aug 2026 17:39:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F51B1F00A3A;
	Mon, 10 Aug 2026 17:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786383545;
	bh=jk4/iqf3QlrsL8m2XoV0Xf9bF4tI4hIm7T5gSdo0XHA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=XwJWbYMflVEGgLIja1EWAoDBtXPLApa/NkhtMQDGRnVjjt8ci9J1uJS4baCLClDhH
	 JhCTVMEaM4RnoWd5AE7v1RSt4+WHhsIMue+11gnSAPlkTWA3jsm/MztKnqM9HYEeYg
	 F3HSfe9YPb6L13yci31ejGgFbBoYJK2sLluFBiRbBIi3K1112oKRwXmMH8XCDjiNUL
	 O4zDHyOMnNvMLmr5Ff9Bj2+8yk4LsoiqXXgEIHKDsq6F5hm/JS2p/xGzzmlILvoWnP
	 Ji1fJM1uOHgWg47TYrlX+f49ixOfpnWV5UxPoLlXiAw19dKwWcQVnkKgo3rIGsRrsP
	 InFqbiVqMUrdg==
From: Pratyush Yadav <pratyush@kernel.org>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: George Guo <dongtai.guo@linux.dev>,  rppt@kernel.org,
  pasha.tatashin@soleen.com,  pratyush@kernel.org,  shuah@kernel.org,
  ardb@kernel.org,  guodongtai@kylinos.cn,  kernel@xen0n.name,
  graf@amazon.com,  loongarch@lists.linux.dev,
  linux-kernel@vger.kernel.org,  kexec@lists.infradead.org,
  linux-mm@kvack.org,  linux-kselftest@vger.kernel.org,
  linux-efi@vger.kernel.org,  Kexin Liu <liukexin@kylinos.cn>
Subject: Re: [PATCH v4 3/4] liveupdate: luo_session: include linux/mm.h for
 virt/phys translation
In-Reply-To: <CAAhV-H4pK10ONo=viJyUJBiiFb_7pbB9LaNkQWH=83r+7E0iTA@mail.gmail.com>
	(Huacai Chen's message of "Mon, 10 Aug 2026 22:37:25 +0800")
References: <20260807103714.33074-1-dongtai.guo@linux.dev>
	<20260807103714.33074-4-dongtai.guo@linux.dev>
	<CAAhV-H4pK10ONo=viJyUJBiiFb_7pbB9LaNkQWH=83r+7E0iTA@mail.gmail.com>
Date: Mon, 10 Aug 2026 19:39:01 +0200
Message-ID: <2vxzjypx6fka.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

On Mon, Aug 10 2026, Huacai Chen wrote:

> Hi, George,
>
> This should be the 2nd patch.

Agreed.

With that done,

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

>
> Huacai
>
> On Fri, Aug 7, 2026 at 6:39=E2=80=AFPM George Guo <dongtai.guo@linux.dev>=
 wrote:
>>
>> From: George Guo <guodongtai@kylinos.cn>
>>
>> luo_session.c calls virt_to_phys() and phys_to_virt(). On LoongArch with
>> CONFIG_KFENCE=3Dy, these macros (in arch/loongarch/include/asm/io.h) exp=
and
>> to offset_in_page() and page_address(), both declared in <linux/mm.h>.
>>
>> Since luo_session.c only includes <linux/io.h>, the translation unit fai=
ls
>> to build with CONFIG_KFENCE=3Dy:
>>
>>   asm/io.h: error: implicit declaration of function 'offset_in_page'
>>   asm/io.h: error: implicit declaration of function 'page_address'
>>
>> Add the missing include to fix these build errors.
>>
>> Co-developed-by: Kexin Liu <liukexin@kylinos.cn>
>> Signed-off-by: Kexin Liu <liukexin@kylinos.cn>
>> Signed-off-by: George Guo <guodongtai@kylinos.cn>
>> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>> ---
>>  kernel/liveupdate/luo_session.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_ses=
sion.c
>> index f38b5b18f3f8..31490ac7b63d 100644
>> --- a/kernel/liveupdate/luo_session.c
>> +++ b/kernel/liveupdate/luo_session.c
>> @@ -94,6 +94,7 @@
>>  #include <linux/kho/abi/luo.h>
>>  #include <linux/list.h>
>>  #include <linux/liveupdate.h>
>> +#include <linux/mm.h>
>>  #include <linux/mutex.h>
>>  #include <linux/rwsem.h>
>>  #include <linux/slab.h>
>> --
>> 2.53.0
>>
>>

--=20
Regards,
Pratyush Yadav

