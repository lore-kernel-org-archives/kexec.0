Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC351C25B76
	for <kexec@archiver.kernel.org>; Wed,  5 Jun 2024 08:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zwPFfzex12dUveUIi90MFfvhR4lPtXdrkj+wPhjqRso=; b=oSFOAaGTAypNSQ
	kJvloq2dHnxbbFTcGkVdGa3Ki5Stc01R2sw7UEErReLtU8DSv7AeD+QQql2KzTHxeggdkE9tlUmEy
	zuRBgWsz5V5XOrljR5m52r+9O2mFmdLawB9LSNbfN4PK0CRbHLEsRx4IogxgSmxiSlGtS+T0LDfp/
	h5RX2Ixf/V33AeZh4cyc4mTujODOni/ODeGsDrBIdTdChQWc3kOrGcIUrzpffvWJyiMWKWaDW/bt+
	dgWb1mzsgxml8dO61KsHZU/4mUZdpnBG7Dj4BzbRnWlbDeUVq85nP64mX8rh4E5OEUbrzeVT+R+Yw
	Vct2U+w7UsjIn87eTQJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sElue-00000005BDK-1znH;
	Wed, 05 Jun 2024 08:22:28 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sElub-00000005BBp-0VZW
	for kexec@lists.infradead.org;
	Wed, 05 Jun 2024 08:22:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717575742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BN2s5RkmRwWRATVy8iKU5IoEWdjTC3uEaBsPoMrm1Tw=;
	b=Q0Ud0WsLgjsPrTS2PCD10LJd3dEs83/A7bYn0DpA/Az2sZ6E8RqlIud4T7v1y53FoW6iHi
	A7FFKXZLNenr3sD+uVeN2gtWdbgddaS/Jiycq6I7S8ve8pkw2DTooYCnRomsbfaAyiSiYu
	uqaY9CJFXWEYDCEWlA8luK85dJ7jOVM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-VB7HM_AlMjizRozuDTrOFQ-1; Wed, 05 Jun 2024 04:22:17 -0400
X-MC-Unique: VB7HM_AlMjizRozuDTrOFQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0112F101A520;
	Wed,  5 Jun 2024 08:22:17 +0000 (UTC)
Received: from localhost (unknown [10.72.116.93])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 10CF6202A438;
	Wed,  5 Jun 2024 08:22:15 +0000 (UTC)
Date: Wed, 5 Jun 2024 16:22:12 +0800
From: Baoquan He <bhe@redhat.com>
To: Coiby Xu <coxu@redhat.com>
Cc: kexec@lists.infradead.org, Ondrej Kozina <okozina@redhat.com>,
	Milan Broz <gmazyland@gmail.com>,
	Thomas Staudt <tstaudt@de.ibm.com>,
	Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
	Kairui Song <ryncsn@gmail.com>,
	Jan Pazdziora <jpazdziora@redhat.com>,
	Pingfan Liu <kernelfans@gmail.com>, Dave Young <dyoung@redhat.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Dave Hansen <dave.hansen@intel.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>, Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_byb" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH v4 2/7] crash_dump: make dm crypt keys persist for the
 kdump kernel
Message-ID: <ZmAgNIXXa32Bv/Of@MiWiFi-R3L-srv>
References: <20240523050451.788754-1-coxu@redhat.com>
 <20240523050451.788754-3-coxu@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240523050451.788754-3-coxu@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240605_012225_372478_39D96B7B 
X-CRM114-Status: GOOD (  16.03  )
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

On 05/23/24 at 01:04pm, Coiby Xu wrote:
.....
> diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
> new file mode 100644
> index 000000000000..78809189084a
> --- /dev/null
> +++ b/kernel/crash_dump_dm_crypt.c
> @@ -0,0 +1,113 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <keys/user-type.h>
> +#include <linux/crash_dump.h>
> +
> +#define KEY_NUM_MAX 128
> +#define KEY_SIZE_MAX 256
> +
> +// The key scription has the format: cryptsetup:UUID 11+36+1(NULL)=48
> +#define KEY_DESC_LEN 48
> +
> +static char *STATE_STR[] = {"fresh", "initialized", "recorded", "loaded"};
> +static enum STATE_ENUM {
> +	FRESH = 0,
> +	INITIALIZED,
> +	RECORDED,
> +	LOADED,
> +} state;
> +
> +static unsigned int key_count;
> +static size_t keys_header_size;

These two global variables seems not so necessary. Please see comment at
below.

> +
> +struct dm_crypt_key {
> +	unsigned int key_size;
> +	char key_desc[KEY_DESC_LEN];
> +	u8 data[KEY_SIZE_MAX];
> +};
> +
> +static struct keys_header {
> +	unsigned int key_count;
                     ~~~~~~~~
                     This is the max number a system have from init();
You can add one field member to record how many key slots have been
used.
> +	struct dm_crypt_key keys[] __counted_by(key_count);
> +} *keys_header;

Maybe we can rearrange the keys_header like below, the name may not be
very appropriate though.

static struct keys_header {
	unsigned int max_key_slots;
	unsigned int used_key_slots;
	struct dm_crypt_key keys[] __counted_by(key_count);
} *keys_header;

>

> +
> +static size_t get_keys_header_size(struct keys_header *keys_header,
> +				   size_t key_count)
> +{
> +	return struct_size(keys_header, keys, key_count);
> +}

I personally don't think get_keys_header_size is so necessary. If we
have to keep it, may be we can remove the global variable
keys_header_size, we can call get_keys_header_size() and use local
variable to record the value instead.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
