Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52F84E77188
	for <kexec@archiver.kernel.org>; Mon, 23 Dec 2024 01:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7GtGrTPjZSAjzaFLtGonWMd0lc7BI8U83xboD+moXcA=; b=1FgsiYYhACtey5FSihx4DaXWqu
	97mkXxvW1z0mxGdvKxh1PKb3DeyIy8TXWAG8sKT3NyTJxJch/jnyJPkeEE9738SXsTH6Sa1wNu9pU
	4PL34wAP1CA+8XKMnSgUg39z3/LGWkfWbMMwW67vOAtfXJkjFojOUYK/jwQrdZ4cqiZClOcj8vfzh
	vXAZ9Ezv9mQvsxRj19BrVm8l40OwHxkOPIwv6yqjdr0luauxtxzknT+IDq9etFIsXJ1nQZ7riJ2Hg
	Bv6Hkeo9yItdiA8VIYOv//t0/aXSzciZ4um4yJFoAZWn2n5aPdxeH71rkd5j/M3O4Lzbx6OLIyvCx
	r+YVFCkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tPX2W-0000000942j-343x;
	Mon, 23 Dec 2024 01:15:20 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tPX2T-0000000942L-47tR
	for kexec@lists.infradead.org;
	Mon, 23 Dec 2024 01:15:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734916516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7GtGrTPjZSAjzaFLtGonWMd0lc7BI8U83xboD+moXcA=;
	b=Qv0ALMnb87PKVspTEJSBnBWUl8n6Xi8AYfsPxbHMMAMR2U5loBiT7ZpFbK7N0MXzkYEjTC
	QuMMqSsagbPpiO1HUeFOfqnvwhCcngIeBSgM0A5u8eKnaDgexKhttRbFbrThzbpQnzjlnM
	JBNrDrbB8pYM8aSLMv3IQZ/IqkGNvX0=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-Npdg5ZhPOK6E6GJzJfjFWQ-1; Sun, 22 Dec 2024 20:15:15 -0500
X-MC-Unique: Npdg5ZhPOK6E6GJzJfjFWQ-1
X-Mimecast-MFC-AGG-ID: Npdg5ZhPOK6E6GJzJfjFWQ
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2163d9a730aso31631185ad.1
        for <kexec@lists.infradead.org>; Sun, 22 Dec 2024 17:15:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734916514; x=1735521314;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7GtGrTPjZSAjzaFLtGonWMd0lc7BI8U83xboD+moXcA=;
        b=kiNjdiQPWR97NtzlJKPvZyrMP7I6uDjcUzjwVSpYqCxu63lSX3zlXcQSPD7jILatHp
         2DOCOl9KAmAq0dYA9GOwoD0M0Vtv7WadHTAYUIDdHpzBoZtlquQBlcfthRIXMgjljRyH
         ak9lMTwd109FbU9r8gSmW3cbbBsQmQ1iww+kXHgSOKbAEE+0gYepZoBLfeOM+Dn1JR2G
         C9pwQu1zJjPaQ8JHfRvg9kUcb7x1W+QJJHFRwY9T34NzEam3fwai749NLt8Xm5pWDtB9
         dbirqcgJQjxX1Qd1n+Tb/7vGglWn7yYI1vIsK4c47aIFrvh9Xj3o4NGJCPPBJIV1zNnz
         tRdg==
X-Gm-Message-State: AOJu0YzfV4+i0qK+G6P7u2YkadfxGuJSCMGji1+Uws7ET2EDH7MvMNKz
	T9HYDE4qU1q2uwINKr3NIE4WVyKKClinHTuieBopZBLzxdALbL0hW+K76q/ffU7ZJORY6vIi08f
	lHo4N2D3AOORp5z8Y7j0QwfWbHnAlhR7iD6fZoT4cUnQLa3jyYwHdsdZiDg==
X-Gm-Gg: ASbGncsObi6TE40oMvCA+z3n276M0KSXmcQ2aaXIWNryZ/GQde/hPkYTh6mhPRBGgLy
	+wgUeE8MqcFamXdg6j92aWttud7RpBKmolBntVBcr0Pxda4JRVBYT6HOSLM2SaI/6DIzxLiAb4j
	t3MlX65II9DjYgdufUt2gf/855F9H5GCB73W9gqfgNy39YFMKgJlzK0eJ+dIYQaclHxw5A0bEVW
	dIEE7azL+YBzx0DrFpt8d4RVflwt/eNOwXFe7PWAU3tJ81P
X-Received: by 2002:a17:902:c94b:b0:215:ae61:27ca with SMTP id d9443c01a7336-219e6d6b172mr171467615ad.26.1734916514212;
        Sun, 22 Dec 2024 17:15:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFocO6jig5LTrbgs3S+saJG3scABAfxvAhM+xo8TvafP29KiOHQcqp7+zxDBRXZZoeI4x+aBg==
X-Received: by 2002:a17:902:c94b:b0:215:ae61:27ca with SMTP id d9443c01a7336-219e6d6b172mr171467285ad.26.1734916513909;
        Sun, 22 Dec 2024 17:15:13 -0800 (PST)
Received: from localhost ([180.109.216.30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc964e92sm62299365ad.18.2024.12.22.17.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Dec 2024 17:15:13 -0800 (PST)
Date: Mon, 23 Dec 2024 09:05:41 +0800
From: Coiby Xu <coxu@redhat.com>
To: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org, Ondrej Kozina <okozina@redhat.com>, 
	Milan Broz <gmazyland@gmail.com>, Thomas Staudt <tstaudt@de.ibm.com>, 
	Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, Kairui Song <ryncsn@gmail.com>, 
	Jan Pazdziora <jpazdziora@redhat.com>, Pingfan Liu <kernelfans@gmail.com>, 
	Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Dave Hansen <dave.hansen@intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Greg KH <gregkh@linuxfoundation.org>, Vivek Goyal <vgoyal@redhat.com>, 
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_byb" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH v6 3/7] crash_dump: store dm crypt keys in kdump reserved
 memory
Message-ID: <lzulibhdxvlhqdsszxcrejjcdbzwb4643nlqtd2hh6nbjb5mz4@ky2jhelzy4md>
References: <20241029055223.210039-1-coxu@redhat.com>
 <20241029055223.210039-4-coxu@redhat.com>
 <Z1mMc+/dCk+mSahu@MiWiFi-R3L-srv>
MIME-Version: 1.0
In-Reply-To: <Z1mMc+/dCk+mSahu@MiWiFi-R3L-srv>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7tvA7JPwuJLM2JPu-XUn_9_InqgaMnJqq4Py2xr1cr0_1734916514
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241222_171518_190473_5EBAA7B2 
X-CRM114-Status: GOOD (  13.34  )
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

On Wed, Dec 11, 2024 at 08:58:27PM +0800, Baoquan He wrote:
>On 10/29/24 at 01:52pm, Coiby Xu wrote:
>......
>> +int crash_load_dm_crypt_keys(struct kimage *image)
>> +{
>> +	struct kexec_buf kbuf = {
>> +		.image = image,
>> +		.buf_min = 0,
>> +		.buf_max = ULONG_MAX,
>> +		.top_down = false,
>> +		.random = true,
>> +	};
>> +	int r;
>> +
>> +
>> +	if (key_count <= 0) {
>> +		kexec_dprintk("No dm-crypt keys\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	image->dm_crypt_keys_addr = 0;
>> +	r = build_keys_header();
>> +	if (r)
>> +		return r;
>> +
>> +	kbuf.buffer = keys_header;
>> +	kbuf.bufsz = get_keys_header_size(key_count);
>> +
>> +	kbuf.memsz = kbuf.bufsz;
>> +	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
>> +	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
>> +	r = kexec_add_buffer(&kbuf);
>> +	if (r) {
>> +		kvfree((void *)kbuf.buffer);
>> +		return r;
>> +	}
>> +	image->dm_crypt_keys_addr = kbuf.mem;
>> +	image->dm_crypt_keys_sz = kbuf.bufsz;
>
>Wondering why not assigning kbuf.memsz, but bufsz.

Thanks for the question! I think there is no need to use kbuf.memsz
after reading the code on setting image->elf_headers_sz. Currently all
arches except for x86 CONFIG_CRASH_HOTPLUG assigns kbuf.bufsz to
image->elf_headers_sz. For x86 CONFIG_CRASH_HOTPLUG, if I understand it
correctly, it assigns kbuf.memsz to kbuf.memsz because elfcorehdr
changes when there is memory/CPU hot-plugging. For dm crypt keys, there
is no so such concern, so assigning kbuf.bufsz shall be OK.

-- 
Best regards,
Coiby


