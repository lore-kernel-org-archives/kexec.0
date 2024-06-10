Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B924C27C53
	for <kexec@archiver.kernel.org>; Mon, 10 Jun 2024 01:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2x33fdJ8m9rNAsxaVZmQuzEoxiRKU8OegisX1YRdi+w=; b=je8JHAkJa9IQje
	Yplvks2hetZdw28WE7gl7bentAi5r02e63mzpT2dJW32raTWodSAs9C+WzOQfKJ+f/gBCzYrZK+uD
	h080LXolruYGtQA74YvBLe1BdVl0Og81v+cCRMnTnXdKW7QWwFGkrV6Uq5w9AHK6e1wzTTJXAjOo4
	WfYHBgML9f+ilHFiuRiWY1cI43JazjvTC4N26WEZmssuBlSj70RCqXs/BbhQaqP10msGxqI7iv2PQ
	nxivbu77Pw+UZRbmCg3cFg7cFsvBfp0jwNRr6JkodnOkYfHOT98xxrtiD6HEVWZgUssvXc40gWJyx
	5cizzzY7JcUt06/0nu6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGTgw-00000003YJL-0PBW;
	Mon, 10 Jun 2024 01:19:22 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGTgp-00000003YIW-3DLY
	for kexec@lists.infradead.org;
	Mon, 10 Jun 2024 01:19:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717982352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8uqVpGiW41LdDIPZDGk2krTR1nMbUR1Dbs/h7+D4MIY=;
	b=UYQFDrNGqZ2BTpqxuoo86K4fyz8h7TSdRslHJBUhPxBTdky6K82rCSgTDQ/BdEsrppk5IV
	QWo1nq/5R1nt2YBKqsdttrhzrPgM3IoGcwUFHnnx0sDvtRuw7Zxkl6rfyabUYL4sSeIisB
	KhhhIaNFG5F65uYXNeu2Nl5lL3n7FiE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-389-OYqCyoXeOyS0ZDmtYLfsgg-1; Sun,
 09 Jun 2024 21:19:04 -0400
X-MC-Unique: OYqCyoXeOyS0ZDmtYLfsgg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F0954195608B;
	Mon, 10 Jun 2024 01:19:01 +0000 (UTC)
Received: from localhost (unknown [10.72.113.124])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C3D5630000C3;
	Mon, 10 Jun 2024 01:18:58 +0000 (UTC)
Date: Mon, 10 Jun 2024 09:18:53 +0800
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
Message-ID: <ZmZUfWKovZLkXpJn@MiWiFi-R3L-srv>
References: <20240523050451.788754-1-coxu@redhat.com>
 <20240523050451.788754-3-coxu@redhat.com>
 <ZmAgNIXXa32Bv/Of@MiWiFi-R3L-srv>
 <5gj3rxxf7tgolj72mxwnbjirxrlx3pezvqcegyiuenwr55njoo@6dg2toxu6vah>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5gj3rxxf7tgolj72mxwnbjirxrlx3pezvqcegyiuenwr55njoo@6dg2toxu6vah>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240609_181915_909851_88A98987 
X-CRM114-Status: GOOD (  28.57  )
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

On 06/07/24 at 08:27pm, Coiby Xu wrote:
> On Wed, Jun 05, 2024 at 04:22:12PM +0800, Baoquan He wrote:
> > On 05/23/24 at 01:04pm, Coiby Xu wrote:
> > .....
> > > diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
> > > new file mode 100644
> > > index 000000000000..78809189084a
> > > --- /dev/null
> > > +++ b/kernel/crash_dump_dm_crypt.c
> > > @@ -0,0 +1,113 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> [...]
> > > +
> > > +static unsigned int key_count;
> > > +static size_t keys_header_size;
> > 
> > These two global variables seems not so necessary. Please see comment at
> > below.
> 
> Thanks for the comment! But I think it's better to keep these two static
> variables for reasons as will be explained later.
> 
> > 
> > > +
> > > +struct dm_crypt_key {
> > > +	unsigned int key_size;
> > > +	char key_desc[KEY_DESC_LEN];
> > > +	u8 data[KEY_SIZE_MAX];
> > > +};
> > > +
> > > +static struct keys_header {
> > > +	unsigned int key_count;
> >                     ~~~~~~~~
> >                     This is the max number a system have from init();
> > You can add one field member to record how many key slots have been
> > used.
> > > +	struct dm_crypt_key keys[] __counted_by(key_count);
> > > +} *keys_header;
> > 
> > Maybe we can rearrange the keys_header like below, the name may not be
> > very appropriate though.
> > 
> > static struct keys_header {
> > 	unsigned int max_key_slots;
> > 	unsigned int used_key_slots;
> > 	struct dm_crypt_key keys[] __counted_by(key_count);
> > } *keys_header;
> 
> Thanks for the suggestion! Since 1) KEY_NUM_MAX already defines the
> maximum number of dm crypt keys 2) we only need to let the kdump kernel
> now how many keys are saved, so I simply use total_keys instead of
> key_count in struct keys_header in v5,
> 
> static struct keys_header {
> 	unsigned int total_keys;
> 	struct dm_crypt_key keys[] __counted_by(total_keys);
> } *keys_header;
> 
> Hopefully this renaming will improve code readability.

If you add key_count into keys_header, then kdump kernel will know how
many keys are really saved and need be retrieved. What's your concern
when you have to put key_count outside and take it as a global variable?

> 
> > 
> > > 
> > 
> > > +
> > > +static size_t get_keys_header_size(struct keys_header *keys_header,
> > > +				   size_t key_count)
> > > +{
> > > +	return struct_size(keys_header, keys, key_count);
> > > +}
> > 
> > I personally don't think get_keys_header_size is so necessary. If we
> > have to keep it, may be we can remove the global variable
> > keys_header_size, we can call get_keys_header_size() and use local
> > variable to record the value instead.
> 
> Thanks for the suggestion! But the kdump kernel also need to call
> get_keys_header_size in later patches.

If so, you can remove keys_header_size now. You can define local
variable to take the newly calculated value. keys_header_size seems not
so necesary.

By the way, you don't need to rush to post v5. When people review
patches, agreement need be reached after discussion. Then next version
can be posted.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
