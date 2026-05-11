Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19C6BCD37AC
	for <kexec@archiver.kernel.org>; Mon, 11 May 2026 10:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ICyQxUgGMqrp8jj/BKUa7saTtN29G40EWzoTRiGMcUY=; b=gIgcOTQCMqjC9T/Gyj8nWEVcc4
	8i6XntUYR6vMrFD2KmVLDIfFw6vowqVM+ZM4hzkCSCKvkcorXrEgmVA04leNt8dOjOF+5gLaxX6b8
	XUvHjEFCCEkPCkxNVrXMfIR6ZFH6X/jJvqMTu7W1ZZFi847VuoW5fYZXgPZdMG53Hhl7aoGvs+9NJ
	UqHkUAwNDpHoH4lRIcs7oNdZPpgqAuAn7cjrsKRri4ffBvvF3sKQeUAgzO+8MDKQ80UzsysfjxiQ1
	kN8KfuWNAcLbHhWPc1+NsVQro12BuU5usQusLe6/Z0ahmKieQstpIkDKPZxzeBc/RQYzo7+VHcFId
	RcrexWFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMO3T-0000000D84w-0GGa;
	Mon, 11 May 2026 10:40:07 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMO3S-0000000D84n-04qz
	for kexec@lists.infradead.org;
	Mon, 11 May 2026 10:40:06 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 425756001A;
	Mon, 11 May 2026 10:40:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB439C2BCB0;
	Mon, 11 May 2026 10:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778496005;
	bh=ievUGX6a15St0U6OOTUzpHkIKC8RMvm95wgsajkWkZw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=p+noZOsuC5sYQvrwcooZNNLzThUrmYOT8CpZ/xRK9u3c5z9AxF3wqp/WZ0TswLAwX
	 06bog+cLW7O4d9b6FbB7XDmBc9DdGpLNrSGI7nYlGsgKn2Lkt9gcv9idfPzVDcuFkj
	 nXhbDgFuojCh1woDo7TPd2UG5zDxmK8KJSSuLdR3ojeXjnTBdkTXSOL70Mhzgh0H5n
	 iRK3emwYOsz9kSkoOiVuBoeMdodE3Iq+6IxjZedxUWsKiwQfF3F+2GLNtOx7xecwq8
	 t9EBH7l4q1v68zon1gqWQBoEBEHtKhFWK9uQktrOhNDoP2YVZB17IpSijsZRyaqzOI
	 1fqhXM3cCpqkQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: George Guo <dongtai.guo@linux.dev>
Cc: pasha.tatashin@soleen.com,  rppt@kernel.org,  pratyush@kernel.org,
  graf@amazon.com,  jasonmiu@google.com,  ran.xiaokai@zte.com.cn,
  akpm@linux-foundation.org,  linux-kernel@vger.kernel.org,
  kexec@lists.infradead.org,  linux-mm@kvack.org,  George Guo
 <guodongtai@kylinos.cn>,  Kexin Liu <liukexin@kylinos.cn>
Subject: Re: [PATCH 1/1] kho: fix KHO_TREE_MAX_DEPTH for non-4KB page sizes
In-Reply-To: <20260509024415.33190-1-dongtai.guo@linux.dev> (George Guo's
	message of "Sat, 9 May 2026 10:44:15 +0800")
References: <20260509024415.33190-1-dongtai.guo@linux.dev>
Date: Mon, 11 May 2026 12:40:01 +0200
Message-ID: <2vxzcxz2dybi.fsf@kernel.org>
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

On Sat, May 09 2026, George Guo wrote:

> From: George Guo <guodongtai@kylinos.cn>
>
> KHO_TREE_MAX_DEPTH is calculated as:
>
>   DIV_ROUND_UP(KHO_ORDER_0_LOG2 - KHO_BITMAP_SIZE_LOG2,
>                KHO_TABLE_SIZE_LOG2) + 1
>
> For systems with 16KB pages (e.g. LoongArch), this gives a depth of 4,

As of now, we only support KHO on x86 and arm64. Support for other
architectures is not there. Are you working on supporting it for
LoongArch? What is your use case?

Without LoongArch supporting KHO, this remains a purely theoretical fix.

> with the top-level shift at bit 39.  The order-0 bit sits at bit 50
> (KHO_ORDER_0_LOG2 =3D 64 - PAGE_SHIFT =3D 50).  When inserting or reading
> a key, the index extracted at the top level is:
>
>   (1 << 50) >> 39 =3D 2048
>
> 2048 is exactly the table size (PAGE_SIZE / sizeof(phys_addr_t) =3D 2048
> for 16KB pages), so it wraps to 0, aliasing the order bit to index 0
> and losing it silently.
>
> On the second kernel, kho_radix_decode_key() sees a key without the
> order bit, calls fls64() on the wrong bit, computes a wrong order and
> thus a garbage physical address. phys_to_page() of that address faults
> in kho_preserved_memory_reserve(), causing a kernel panic early in boot.
>
> Fix by adding +1 to the DIV_ROUND_UP numerator so the formula accounts
> for the order bit itself, giving depth 5 for 16KB pages. The top-level
> shift becomes 50, and (1 << 50) >> 50 =3D 1, which is nonzero and
> unambiguous. For 4KB and 64KB page sizes the depth is unchanged.

Maybe I don't understand the math so well, but I can't see the problem.
Here's what I did in my calculator (the lines starting with the =3D are
the result of the previous statement):

First, define all the constants:

    PAGE_SHIFT =3D 14
    =3D 14

    KHO_ORDER_0_LOG2 =3D 64 =E2=88=92 PAGE_SHIFT
    =3D 50

    KHO_TABLE_SIZE_LOG2  =3D log(2; (1 << PAGE_SHIFT) / 8)
    =3D 11

    KHO_BITMAP_SIZE_LOG2 =3D PAGE_SHIFT + 3
    =3D 17

    KHO_TREE_MAX_DEPTH =3D ((KHO_ORDER_0_LOG2 =E2=88=92 KHO_BITMAP_SIZE_LOG=
2) / KHO_TABLE_SIZE_LOG2) + 1
    =3D 4

Then let's assume the highest possible physical address (52-bit
addressing) and order 0:

    phys =3D 0xffffffffff000
    =3D 4503599627366400

    order =3D 0
    =3D 0

This makes the key:

    key =3D (1 << (KHO_ORDER_0_LOG2 =E2=88=92 order)) | (phys >> (PAGE_SHIF=
T + order))
    =3D 1126174784749567

For higher orders the numerical value of the key will be smaller so this
is the highest possible key.

Then do what kho_radix_get_table_index() does to get the index on level
4:

    level =3D 4
    =3D 4

    s =3D ((level =E2=88=92 1) =C3=97 KHO_TABLE_SIZE_LOG2) + KHO_BITMAP_SIZ=
E_LOG2
    =3D 50

    idx =3D mod((key >> s); (1 << KHO_TABLE_SIZE_LOG2))
    =3D 1

If we do get a 5th level, the index would be:

    level =3D 5
    =3D 5

    s =3D ((level =E2=88=92 1) =C3=97 KHO_TABLE_SIZE_LOG2) + KHO_BITMAP_SIZ=
E_LOG2
    =3D 61

    idx =3D mod((key >> s); (1 << KHO_TABLE_SIZE_LOG2))
    =3D 0

So based on this, looks to me that the 5th level table won't ever go
above index 0 and the 4th level is enough to represent all possible
keys.

What am I missing?

Also, Jason, can you please help review this? You understand the math of
the radix tree the best I reckon.

>
> Fixes: 3f2ad90060f6 ("kho: adopt radix tree for preserved memory tracking=
")
>
> Tested-by: Kexin Liu <liukexin@kylinos.cn>
> Signed-off-by: George Guo <guodongtai@kylinos.cn>
> ---
>  include/linux/kho/abi/kexec_handover.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/kho/abi/kexec_handover.h b/include/linux/kho/a=
bi/kexec_handover.h
> index 7e847a2339b0..db9bda6dd310 100644
> --- a/include/linux/kho/abi/kexec_handover.h
> +++ b/include/linux/kho/abi/kexec_handover.h
> @@ -274,7 +274,7 @@ enum kho_radix_consts {
>  	 * and 1 bitmap level.
>  	 */
>  	KHO_TREE_MAX_DEPTH =3D
> -		DIV_ROUND_UP(KHO_ORDER_0_LOG2 - KHO_BITMAP_SIZE_LOG2,
> +		DIV_ROUND_UP(KHO_ORDER_0_LOG2 - KHO_BITMAP_SIZE_LOG2 + 1,
>  			     KHO_TABLE_SIZE_LOG2) + 1,
>  };

--=20
Regards,
Pratyush Yadav

