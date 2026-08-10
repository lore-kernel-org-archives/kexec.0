Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF797C5B567
	for <kexec@archiver.kernel.org>; Mon, 10 Aug 2026 17:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MP2+23zFvL9Yev7WTv4ThtH3GwLxgP0jNN2O9q9lsco=; b=P4NvFjAmvSXQfwhi4hs9FA3VBD
	RpCfNKt/SrJztxvz7VWeoutSfJOE+CfMCIJDwrOwFhC3v1bXcx5dVIPC1RyuhvmWtXunzMd1wbzgW
	320ulUlPIp+sBKDun94z3USfFbrrvk8g75Av/tz+/s31jz2ldM6SLjdxERfYwii+6mM36mkA4K76Q
	wIa34UoAxSjvgJTT6OpUXkUfDgbCORDOq+NIShRlPUW8yrnWDMMiPIX7WOAmC00bJGTQplq12FGJG
	n+FaZBQbk3wVKBloZZTBOoiKo+6sAyMYM0pEGmF5L4/w7PiguB4YweD+BBxN/VBYYhPWhAa7/BseO
	Ptr9PmTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtU3U-0000000CYa6-2AZx;
	Mon, 10 Aug 2026 17:44:56 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtU3T-0000000CYa0-0Jtj
	for kexec@lists.infradead.org;
	Mon, 10 Aug 2026 17:44:55 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 850D2600C8;
	Mon, 10 Aug 2026 17:44:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76D551F000E9;
	Mon, 10 Aug 2026 17:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786383894;
	bh=MP2+23zFvL9Yev7WTv4ThtH3GwLxgP0jNN2O9q9lsco=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=TDhG6LdU+xmaROsqFck3hBtm6iNfonUwi9trFk34RupcKybOSt6P84/qzbjudd9Wu
	 evlBRW4nJ4HD0cll3MkA8vYdh0GN1X0UBLa8kl7uNslZW5quVAfTSogtkkhWJqAYuj
	 j7BA3bAWZpBSUxiQmPhfKrlPUpF8ouMqV6yQJoBzflBNPbfXGT9B47IkJtk2usAEJb
	 5JCsFPUcg5MjoJAiS2uk3tAlrNLp3Vdpc70GQjFvauDt/Wta74NeZghnfO0ZnasdzM
	 QKHvsZnV5iWN4njlQb4AEJEqQEycrrAzS7XJi2Nk1PiIGxYlteW+dasD4OpI51JJA1
	 lga2SFv2CjFQA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Huacai Chen <chenhuacai@kernel.org>,  George Guo
 <dongtai.guo@linux.dev>,  rppt@kernel.org,  pasha.tatashin@soleen.com,
  shuah@kernel.org,  ardb@kernel.org,  guodongtai@kylinos.cn,
  kernel@xen0n.name,  graf@amazon.com,  loongarch@lists.linux.dev,
  linux-kernel@vger.kernel.org,  kexec@lists.infradead.org,
  linux-mm@kvack.org,  linux-kselftest@vger.kernel.org,
  linux-efi@vger.kernel.org,  Kexin Liu <liukexin@kylinos.cn>
Subject: Re: [PATCH v4 3/4] liveupdate: luo_session: include linux/mm.h for
 virt/phys translation
In-Reply-To: <2vxzjypx6fka.fsf@kernel.org> (Pratyush Yadav's message of "Mon,
	10 Aug 2026 19:39:01 +0200")
References: <20260807103714.33074-1-dongtai.guo@linux.dev>
	<20260807103714.33074-4-dongtai.guo@linux.dev>
	<CAAhV-H4pK10ONo=viJyUJBiiFb_7pbB9LaNkQWH=83r+7E0iTA@mail.gmail.com>
	<2vxzjypx6fka.fsf@kernel.org>
Date: Mon, 10 Aug 2026 19:44:49 +0200
Message-ID: <2vxzfr0l6fam.fsf@kernel.org>
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

On Mon, Aug 10 2026, Pratyush Yadav wrote:

> On Mon, Aug 10 2026, Huacai Chen wrote:
>
>> Hi, George,
>>
>> This should be the 2nd patch.
>
> Agreed.
>
> With that done,
>
> Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

Actually, I take this back. Sashiko has found some problems. See below.

>
>>
>> Huacai
>>
>> On Fri, Aug 7, 2026 at 6:39=E2=80=AFPM George Guo <dongtai.guo@linux.dev=
> wrote:
>>>
>>> From: George Guo <guodongtai@kylinos.cn>
>>>
>>> luo_session.c calls virt_to_phys() and phys_to_virt(). On LoongArch with
>>> CONFIG_KFENCE=3Dy, these macros (in arch/loongarch/include/asm/io.h) ex=
pand
>>> to offset_in_page() and page_address(), both declared in <linux/mm.h>.

https://sashiko.dev/#/patchset/20260807103714.33074-5-dongtai.guo@linux.dev

    Is this description accurate? Looking at luo_session.c, it does not act=
ually
    call virt_to_phys().
    The implicit declaration error appears to originate from arch_kfence_in=
it_pool()
    in arch/loongarch/include/asm/kfence.h, which is implicitly included via
    <linux/slab.h>.
    arch/loongarch/include/asm/kfence.h:arch_kfence_init_pool() {
        ...
                    virt_to_phys((void *)kfence_pool), PAGE_KERNEL);
        ...
    }
    Could the fix be applied to the architecture header instead, to prevent=
 any
    other kernel C file on LoongArch with CONFIG_KFENCE=3Dy from suffering =
the same
    build failure if it includes <linux/slab.h> before <linux/mm.h>?

I at least don't see any virt_to_phys() or phys_to_virt() in
luo_session.c. So you need to go and take another look at what the real
problem is and what the fix should be.

>>>
>>> Since luo_session.c only includes <linux/io.h>, the translation unit fa=
ils
>>> to build with CONFIG_KFENCE=3Dy:
>>>
>>>   asm/io.h: error: implicit declaration of function 'offset_in_page'
>>>   asm/io.h: error: implicit declaration of function 'page_address'
>>>
>>> Add the missing include to fix these build errors.
>>>
>>> Co-developed-by: Kexin Liu <liukexin@kylinos.cn>
>>> Signed-off-by: Kexin Liu <liukexin@kylinos.cn>
>>> Signed-off-by: George Guo <guodongtai@kylinos.cn>
>>> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>>> ---
>>>  kernel/liveupdate/luo_session.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_se=
ssion.c
>>> index f38b5b18f3f8..31490ac7b63d 100644
>>> --- a/kernel/liveupdate/luo_session.c
>>> +++ b/kernel/liveupdate/luo_session.c
>>> @@ -94,6 +94,7 @@
>>>  #include <linux/kho/abi/luo.h>
>>>  #include <linux/list.h>
>>>  #include <linux/liveupdate.h>
>>> +#include <linux/mm.h>
>>>  #include <linux/mutex.h>
>>>  #include <linux/rwsem.h>
>>>  #include <linux/slab.h>
>>> --
>>> 2.53.0
>>>
>>>

--=20
Regards,
Pratyush Yadav

