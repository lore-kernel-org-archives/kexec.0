Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B821CD3C53D
	for <kexec@archiver.kernel.org>; Fri, 18 Oct 2024 01:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nU2bBwIWFkFHDk0oUkzxaQAKPLDUoD7aewJOJMiQ5Gw=; b=c+mwNSitD54qaMl+vvOftS6JZB
	I/7kc1IsZrw7JXddI49CZVn6aYn539kLkXY7E8LIh+UUh3E+g0aNOS2li8gucAszs0C5c2mfdLZM5
	bmwLupf1OEqxqFlku0eLU4jAgPIcCMzdHHgNPWcSHXzsw0pPI8eh6aJKkRKggRlgqjOx3buHr8XBY
	Dt0y+bnfbCG9j/GbPVp5V7m+zfFmGnu73wifO5qkRMFjewbHnBxhbyCWGj8Mjb4ZZgM8iWSW3mHK1
	Tb3wh9BiikhB/UshklWWl43dRYya+d80efPggJcat5slmsJnIXX3sfW2qD1P87IJdZaSzVbb3S1O2
	TLSsG41A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1bSM-0000000GXdK-0c6u;
	Fri, 18 Oct 2024 01:07:06 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1bSJ-0000000GXcw-0Fsr
	for kexec@lists.infradead.org;
	Fri, 18 Oct 2024 01:07:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729213621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=im/8jDN85o8dpsjNllcDJZk4PVI/oCZ54YgWyke0Cv8=;
	b=F/La9Og6FnYKYhMGoepXUR7ZaWePZUf40+1Ke/HrISuDImhBVlKZ1WBaW6x+hofA0mn49D
	kbOrulesHGI/OBnH81SIohVkGpVwR5GJ+NzN1up/HVrvUb/XkgV/+gu2+I9cD3k/bn9K+O
	TyEpABj5bt79y4xPeOnwZj/OKDeJ1n4=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-6HlTE9WpMIOc8kycYSg8ig-1; Thu, 17 Oct 2024 21:05:23 -0400
X-MC-Unique: 6HlTE9WpMIOc8kycYSg8ig-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-6c8f99fef10so1800766a12.3
        for <kexec@lists.infradead.org>; Thu, 17 Oct 2024 18:05:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729213522; x=1729818322;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=im/8jDN85o8dpsjNllcDJZk4PVI/oCZ54YgWyke0Cv8=;
        b=ZabNS1RaiC5UmDRa1OCXTshGJgeqz5NVAs9V4Vf4R5QoSZOugBbL92SJMSkOmgvovm
         CMlS4UGbmR2smIfx7U+Q/mtLZePSVa34c9rFWdoDCDbby3oOTpHlslx2Thj+J+aPGayb
         KE4bWBtmSZVwq+FPxSTDiRUShnNh4zFVcLfAOqCknEMLzN3XImDiTVxM8740gm36/BPK
         G5chots4BGXXxy0JS3wUZ6RIhrIx1Rm88OqwwpbPbHZjTfKpvAWvLHIDx2jpFXFAEDZ1
         FwLt0lAFLWT/LuiQiOZtXbOKDExZwYO1njy5Qb5lwpuFk2c22lpoH5h+wPwDMZd4+kDl
         ggsQ==
X-Gm-Message-State: AOJu0YzDfiTCdcSkNt3wov1n792FofP6UTLxgn8QPa8J1nu6RlTdCnvB
	ztgIRIR2RUrSQ2AoV06KBRvtq/7+9zBJzoIJnF4ZM2hv7a2AUoU6g57eZ5ZaPLp/sBxszsFdQpQ
	8MccGb0q4jjOFAWxpsQpEX8XcdDct4Hti35KxWNT6lqmKf+Cl9WI1YOxdQQ==
X-Received: by 2002:a17:903:27c4:b0:20c:ad30:6b97 with SMTP id d9443c01a7336-20e5a90621dmr9397855ad.38.1729213522193;
        Thu, 17 Oct 2024 18:05:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDlBlNRTAwPlOe5LtFgMxaSDqQm867MYlk0mBbHAqo4GOqATrNJ9lNsl2cgC6uZOG0DEq5kA==
X-Received: by 2002:a17:903:27c4:b0:20c:ad30:6b97 with SMTP id d9443c01a7336-20e5a90621dmr9397575ad.38.1729213521804;
        Thu, 17 Oct 2024 18:05:21 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e5a753378sm2444375ad.98.2024.10.17.18.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 18:05:21 -0700 (PDT)
Date: Fri, 18 Oct 2024 09:02:41 +0800
From: Coiby Xu <coxu@redhat.com>
To: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org, Ondrej Kozina <okozina@redhat.com>, 
	Milan Broz <gmazyland@gmail.com>, Thomas Staudt <tstaudt@de.ibm.com>, 
	Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, Kairui Song <ryncsn@gmail.com>, 
	Jan Pazdziora <jpazdziora@redhat.com>, Pingfan Liu <kernelfans@gmail.com>, 
	Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Dave Hansen <dave.hansen@intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Vivek Goyal <vgoyal@redhat.com>, Kees Cook <keescook@chromium.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_byb" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH v4 2/7] crash_dump: make dm crypt keys persist for the
 kdump kernel
Message-ID: <wxsunpjqmro2ouupfvhkoc744jvfdx3g3fmg5zec6ouuibsnt5@ncdx66ndiaz2>
References: <20240523050451.788754-1-coxu@redhat.com>
 <20240523050451.788754-3-coxu@redhat.com>
 <ZmAgNIXXa32Bv/Of@MiWiFi-R3L-srv>
 <5gj3rxxf7tgolj72mxwnbjirxrlx3pezvqcegyiuenwr55njoo@6dg2toxu6vah>
 <ZmZUfWKovZLkXpJn@MiWiFi-R3L-srv>
MIME-Version: 1.0
In-Reply-To: <ZmZUfWKovZLkXpJn@MiWiFi-R3L-srv>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241017_180703_183851_7BA2FE16 
X-CRM114-Status: GOOD (  30.16  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Mon, Jun 10, 2024 at 09:18:53AM +0800, Baoquan He wrote:
>On 06/07/24 at 08:27pm, Coiby Xu wrote:
>> On Wed, Jun 05, 2024 at 04:22:12PM +0800, Baoquan He wrote:
>> > On 05/23/24 at 01:04pm, Coiby Xu wrote:
>> > .....
>> > > diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
>> > > new file mode 100644
>> > > index 000000000000..78809189084a
>> > > --- /dev/null
>> > > +++ b/kernel/crash_dump_dm_crypt.c
>> > > @@ -0,0 +1,113 @@
>> > > +// SPDX-License-Identifier: GPL-2.0-only
>> [...]
>> > > +
>> > > +static unsigned int key_count;
>> > > +static size_t keys_header_size;
>> >
>> > These two global variables seems not so necessary. Please see comment at
>> > below.
>>
>> Thanks for the comment! But I think it's better to keep these two static
>> variables for reasons as will be explained later.
>>
>> >
>> > > +
>> > > +struct dm_crypt_key {
>> > > +	unsigned int key_size;
>> > > +	char key_desc[KEY_DESC_LEN];
>> > > +	u8 data[KEY_SIZE_MAX];
>> > > +};
>> > > +
>> > > +static struct keys_header {
>> > > +	unsigned int key_count;
>> >                     ~~~~~~~~
>> >                     This is the max number a system have from init();
>> > You can add one field member to record how many key slots have been
>> > used.
>> > > +	struct dm_crypt_key keys[] __counted_by(key_count);
>> > > +} *keys_header;
>> >
>> > Maybe we can rearrange the keys_header like below, the name may not be
>> > very appropriate though.
>> >
>> > static struct keys_header {
>> > 	unsigned int max_key_slots;
>> > 	unsigned int used_key_slots;
>> > 	struct dm_crypt_key keys[] __counted_by(key_count);
>> > } *keys_header;
>>
>> Thanks for the suggestion! Since 1) KEY_NUM_MAX already defines the
>> maximum number of dm crypt keys 2) we only need to let the kdump kernel
>> now how many keys are saved, so I simply use total_keys instead of
>> key_count in struct keys_header in v5,
>>
>> static struct keys_header {
>> 	unsigned int total_keys;
>> 	struct dm_crypt_key keys[] __counted_by(total_keys);
>> } *keys_header;
>>
>> Hopefully this renaming will improve code readability.
>
>If you add key_count into keys_header, then kdump kernel will know how
>many keys are really saved and need be retrieved. What's your concern
>when you have to put key_count outside and take it as a global variable?

Yes, the kdump kernel can know how many keys by reading keys_header. But
1st kernel needs to know how many keys are recorded so far as user space
is expected to tell the kernel which keys are needed one by one and the
key_count will be increased witch each new key.

>
>>
>> >
>> > >
>> >
>> > > +
>> > > +static size_t get_keys_header_size(struct keys_header *keys_header,
>> > > +				   size_t key_count)
>> > > +{
>> > > +	return struct_size(keys_header, keys, key_count);
>> > > +}
>> >
>> > I personally don't think get_keys_header_size is so necessary. If we
>> > have to keep it, may be we can remove the global variable
>> > keys_header_size, we can call get_keys_header_size() and use local
>> > variable to record the value instead.
>>
>> Thanks for the suggestion! But the kdump kernel also need to call
>> get_keys_header_size in later patches.
>
>If so, you can remove keys_header_size now. You can define local
>variable to take the newly calculated value. keys_header_size seems not
>so necesary.

Sure, new version will have the global variable keys_header_size
removed which can make the code a bit easier to reason about, thanks!

>
>By the way, you don't need to rush to post v5. When people review
>patches, agreement need be reached after discussion. Then next version
>can be posted.

Thanks for the suggestion! I'll wait for the consensus to be truly
reached next time.

And sorry, it takes longer time than I have expected to evaluate all the
feedback. In retrospective, maybe it's better to respond to each
feedback in a parallel manner than pondering over all the feedback
first.

-- 
Best regards,
Coiby


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
