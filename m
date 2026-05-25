Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74F46CD5BC9
	for <kexec@archiver.kernel.org>; Mon, 25 May 2026 16:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z/uYM7Uc7JRbhfGHHhf03rXJodyqFN96ymQHCiubqvk=; b=RMmSiPacubFbzZyeMzu5oOI9mf
	w+8RMIHx9fCZ82vwNRbXZYMrMquN8zlZg6IdbTnakC8U5wPSHLwItj2RCmKoVn8tjAfZa6tOh1xmI
	JEUz+cUH2fFXC05s7LoL8H1AKUMdAPGhygh+qka35vKhpVF2GWvRlZm1b7CREsnB/hMpbtYIGeM+9
	PmT40xEGBmZSzkALGX2D8b3TQRyA2qt2AvxL38JzRPzAvpQlmV3SxTa25J8i0SEZs6onLQBPAxUqy
	yKN2W8NgW2a9NGChYFTb1EdvZZNR9H8RnSkvj0XxMk8HKVJa/cQ2pY55K+3C6fQ3v4CnXhHSYoMOO
	pEFEI5DA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRY6M-000000000ht-0oz8;
	Mon, 25 May 2026 16:24:26 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRY6K-000000000hb-1Fla
	for kexec@lists.infradead.org;
	Mon, 25 May 2026 16:24:24 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 547876008A;
	Mon, 25 May 2026 16:24:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A0731F000E9;
	Mon, 25 May 2026 16:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779726263;
	bh=z/uYM7Uc7JRbhfGHHhf03rXJodyqFN96ymQHCiubqvk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=e6XDvUQsx2eTcRuCA1irVbXIxaLJohA8c4vcRWz1eC76UVWyXAyC7fbfnNjlrutj7
	 gju+RUO0DX6Wdxv2wd45akCscpQbUFeYuR/iT89vvfZ8OYMZp/G9bWDrglUvOussLH
	 UVEDKAAa8qgS3ng+sx5vcKgs8AWPvPfN8D+YCccc+GtIlf9jAwvUPx7Z6yE5ogsqAd
	 /gtJeqsN/8BUsHFqXyiqFi8IpZKZvDotnuqL9hrRO4+DCbp6o6fGmQn8b+JjzqXuNv
	 c+qkFRmCkpe9v5zFgQAEGcKqIrs1VjFpUsZ1iO/1m/wxCVgRrBbzEwcdrw/eyWiHib
	 /0Uo9hBFqHCfA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kselftest@vger.kernel.org,  rppt@kernel.org,  shuah@kernel.org,
  akpm@linux-foundation.org,  linux-mm@kvack.org,
  skhan@linuxfoundation.org,  linux-doc@vger.kernel.org,
  linux-kernel@vger.kernel.org,  corbet@lwn.net,  dmatlack@google.com,
  kexec@lists.infradead.org,  pratyush@kernel.org,  skhawaja@google.com,
  graf@amazon.com
Subject: Re: [PATCH v2 01/10] liveupdate: centralize state management into
 struct luo_ser
In-Reply-To: <20260514222628.931312-2-pasha.tatashin@soleen.com> (Pasha
	Tatashin's message of "Thu, 14 May 2026 22:26:19 +0000")
References: <20260514222628.931312-1-pasha.tatashin@soleen.com>
	<20260514222628.931312-2-pasha.tatashin@soleen.com>
Date: Mon, 25 May 2026 18:24:19 +0200
Message-ID: <2vxz7bor78zw.fsf@kernel.org>
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

On Thu, May 14 2026, Pasha Tatashin wrote:

> Transition the LUO to ABI v2, which centralizes state management into a
> single struct luo_ser header.
>
> Previously, LUO state was spread across multiple FDT properties and
> subnodes. ABI v2 simplifies this by placing all core state, including
> the liveupdate number and physical addresses for sessions and FLB
> headers into a centralized struct luo_ser.

Makes a lot of sense I think.

But nit: this brings about a semantic difference: now sessions and FLB
serialization format is no longer independent of LUO. I think that makes
sense but can you please spell that out in the commit message.

>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  include/linux/kho/abi/luo.h      | 91 +++++++++++---------------------
>  kernel/liveupdate/luo_core.c     | 59 ++++++++++++++-------
>  kernel/liveupdate/luo_flb.c      | 65 ++++-------------------
>  kernel/liveupdate/luo_internal.h |  8 +--
>  kernel/liveupdate/luo_session.c  | 57 +++-----------------
>  5 files changed, 93 insertions(+), 187 deletions(-)
>
> diff --git a/include/linux/kho/abi/luo.h b/include/linux/kho/abi/luo.h
> index 46750a0ddf88..1b2f865a771a 100644
> --- a/include/linux/kho/abi/luo.h
> +++ b/include/linux/kho/abi/luo.h
> @@ -30,52 +30,25 @@
>   *   .. code-block:: none
>   *
>   *     / {
> - *         compatible = "luo-v1";
> - *         liveupdate-number = <...>;
> - *
> - *         luo-session {
> - *             compatible = "luo-session-v1";
> - *             luo-session-header = <phys_addr_of_session_header_ser>;
> - *         };
> - *
> - *         luo-flb {
> - *             compatible = "luo-flb-v1";
> - *             luo-flb-header = <phys_addr_of_flb_header_ser>;
> - *         };
> + *         compatible = "luo-v2";
> + *         luo-abi-header = <phys_addr_of_luo_ser>;

While you are at it, perhaps also get rid of the LUO FDT entirely? With
this change it only holds the compatible and a pointer to a blob. Might
as well move the compatible string to the blob and use it directly. Do
you see any benefits of sticking with the FDT here? We have already
removed it from memfd for example (and AFAIK the upcoming PCI and VFIO
patches also do not use it).

>   *     };
>   *
>   * Main LUO Node (/):
>   *
> - *   - compatible: "luo-v1"
> + *   - compatible: "luo-v2"
>   *     Identifies the overall LUO ABI version.
> - *   - liveupdate-number: u64
> - *     A counter tracking the number of successful live updates performed.
> @@ -109,13 +82,26 @@
>  
>  /*
>   * The LUO FDT hooks all LUO state for sessions, fds, etc.
> - * In the root it also carries "liveupdate-number" 64-bit property that
> - * corresponds to the number of live-updates performed on this machine.
>   */
>  #define LUO_FDT_SIZE		PAGE_SIZE
>  #define LUO_FDT_KHO_ENTRY_NAME	"LUO"
> -#define LUO_FDT_COMPATIBLE	"luo-v1"
> -#define LUO_FDT_LIVEUPDATE_NUM	"liveupdate-number"
> +#define LUO_FDT_COMPATIBLE	"luo-v2"
> +#define LUO_FDT_ABI_HEADER	"luo-abi-header"

Nit: If we do go with FDT, I suppose "luo-ser-pa" (or "luo-ser"?) would
be more descriptive?

> +
> +/**
> + * struct luo_ser - Centralized LUO ABI header.
> diff --git a/kernel/liveupdate/luo_flb.c b/kernel/liveupdate/luo_flb.c
> index 8f5c5dd01cd0..7ccc59981297 100644
> --- a/kernel/liveupdate/luo_flb.c
> +++ b/kernel/liveupdate/luo_flb.c
> @@ -159,8 +159,8 @@ static void luo_flb_file_unpreserve_one(struct liveupdate_flb *flb)
>  
>  static int luo_flb_retrieve_one(struct liveupdate_flb *flb)
>  {
> -	struct luo_flb_private *private = luo_flb_get_private(flb);
>  	struct luo_flb_header *fh = &luo_flb_global.incoming;
> +	struct luo_flb_private *private = luo_flb_get_private(flb);

Nit: this doesn't seem to do anything. Is this a stray change?

>  	struct liveupdate_flb_op_args args = {0};
>  	bool found = false;
>  	int err;

> -int __init luo_flb_setup_incoming(void *fdt_in)
> +void __init luo_flb_setup_incoming(u64 flbs_pa)
>  {
>  	struct luo_flb_header_ser *header_ser;
> -	int err, header_size, offset;
> -	const void *ptr;
> -	u64 header_ser_pa;
> -
> -	offset = fdt_subnode_offset(fdt_in, 0, LUO_FDT_FLB_NODE_NAME);
> -	if (offset < 0) {
> -		pr_err("Unable to get FLB node [%s]\n", LUO_FDT_FLB_NODE_NAME);
>  
> -		return -ENOENT;
> +	if (flbs_pa) {
> +		header_ser = phys_to_virt(flbs_pa);
> +		luo_flb_global.incoming.header_ser = header_ser;
> +		luo_flb_global.incoming.ser = (void *)(header_ser + 1);
> +		luo_flb_global.incoming.active = true;

Nit: Not getting FLB data resulted in a error print. I suppose we should
keep that here as well.

>  	}
> -
> -	err = fdt_node_check_compatible(fdt_in, offset,
> -					LUO_FDT_FLB_COMPATIBLE);
> -	if (err) {
> -		pr_err("FLB node is incompatible with '%s' [%d]\n",
> -		       LUO_FDT_FLB_COMPATIBLE, err);
> -
> -		return -EINVAL;
> -	}
> -
> -	header_size = 0;
> -	ptr = fdt_getprop(fdt_in, offset, LUO_FDT_FLB_HEADER, &header_size);
> -	if (!ptr || header_size != sizeof(u64)) {
> -		pr_err("Unable to get FLB header property '%s' [%d]\n",
> -		       LUO_FDT_FLB_HEADER, header_size);
> -
> -		return -EINVAL;
> -	}
> -
> -	header_ser_pa = get_unaligned((u64 *)ptr);
> -	header_ser = phys_to_virt(header_ser_pa);
> -
> -	luo_flb_global.incoming.header_ser = header_ser;
> -	luo_flb_global.incoming.ser = (void *)(header_ser + 1);
> -	luo_flb_global.incoming.active = true;
> -
> -	return 0;
>  }
>  
>  /**

> -int __init luo_session_setup_incoming(void *fdt_in)
> +int __init luo_session_setup_incoming(u64 sessions_pa)
>  {
>  	struct luo_session_header_ser *header_ser;
> -	int err, header_size, offset;
> -	u64 header_ser_pa;
> -	const void *ptr;
> -
> -	offset = fdt_subnode_offset(fdt_in, 0, LUO_FDT_SESSION_NODE_NAME);
> -	if (offset < 0) {
> -		pr_err("Unable to get session node: [%s]\n",
> -		       LUO_FDT_SESSION_NODE_NAME);
> -		return -EINVAL;
> -	}
>  
> -	err = fdt_node_check_compatible(fdt_in, offset,
> -					LUO_FDT_SESSION_COMPATIBLE);
> -	if (err) {
> -		pr_err("Session node incompatible [%s]\n",
> -		       LUO_FDT_SESSION_COMPATIBLE);
> -		return -EINVAL;
> -	}
> -
> -	header_size = 0;
> -	ptr = fdt_getprop(fdt_in, offset, LUO_FDT_SESSION_HEADER, &header_size);
> -	if (!ptr || header_size != sizeof(u64)) {
> -		pr_err("Unable to get session header '%s' [%d]\n",
> -		       LUO_FDT_SESSION_HEADER, header_size);
> -		return -EINVAL;
> +	if (sessions_pa) {

Nit: same thing about the error print here.

> +		header_ser = phys_to_virt(sessions_pa);
> +		luo_session_global.incoming.header_ser = header_ser;
> +		luo_session_global.incoming.ser = (void *)(header_ser + 1);
> +		luo_session_global.incoming.active = true;
>  	}
>  
> -	header_ser_pa = get_unaligned((u64 *)ptr);
> -	header_ser = phys_to_virt(header_ser_pa);
> -
> -	luo_session_global.incoming.header_ser = header_ser;
> -	luo_session_global.incoming.ser = (void *)(header_ser + 1);
> -	luo_session_global.incoming.active = true;
> -
>  	return 0;
>  }

-- 
Regards,
Pratyush Yadav

