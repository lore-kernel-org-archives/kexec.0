Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2640EF513E9
	for <kexec@archiver.kernel.org>; Fri,  6 Mar 2026 02:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ku+fyGp/YTBjGS772gug0NvDgqgMuQqPxeBeDkG1f5g=; b=n9PUu/kVOMdWUgidLDOpuFBTAe
	lb4JbTf/sd2FlUaSTOe5IC5KvSJadhrnfLdftH9O07b98SU5djr9iT0jBu8i8DH2dHFwN24jZEmT3
	+QfUltnYbTgsoX35e7MQiAeQ5P6SzUKLUn/zOuuvF4tcbpekI8rL+tpoWN9pCc9UB5Mr5wGNaN3oY
	DESSzpI6wyhpu7uuOvgQNiwi09f5tMb1V9w99xeBPHswNWphGlUztKYuJM6EDMgU9ykT9sUzHFiTF
	9/YeFVIeiANDcDIBh437cQyJD58h1YjttahvquGmYr1Y38l+F987Fg36XNRv9F8zQ0xCq+9bLGUwW
	RTrxyUag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vyKZz-00000002rXP-3PGC;
	Fri, 06 Mar 2026 02:06:15 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vyKZp-00000002rWH-2Sb6
	for kexec@lists.infradead.org;
	Fri, 06 Mar 2026 02:06:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772762761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ku+fyGp/YTBjGS772gug0NvDgqgMuQqPxeBeDkG1f5g=;
	b=E508wJt0qGTzrujD0o55CRPTtYE90O1ujN5akgXx+A/FWZf+Un7ZqmIlffNkJKErelWWXx
	GxWt9Y7GJznz78ZIDdm5Ob0PF0JUL5EXJNbmdGY+9IwqX5rXVznFiB5X9m7BjjcXXcCKzG
	qkFjgkxZrELJUK0dOeIchURsoONh19k=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-BQJffWw3OCSbj_vnr1E2hw-1; Thu, 05 Mar 2026 21:05:57 -0500
X-MC-Unique: BQJffWw3OCSbj_vnr1E2hw-1
X-Mimecast-MFC-AGG-ID: BQJffWw3OCSbj_vnr1E2hw_1772762756
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ae62c87973so160132185ad.1
        for <kexec@lists.infradead.org>; Thu, 05 Mar 2026 18:05:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772762756; x=1773367556;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ku+fyGp/YTBjGS772gug0NvDgqgMuQqPxeBeDkG1f5g=;
        b=aPa6xo5qFsYd6tvLRCIbDPQjOcZ+yLrHQjCw324BzVFnFHoAV0H4wD2U9yzZbhNO1+
         d/qQsbae0NlRPneBRl5vdMqeE7nLflQDp6xITrLEuMTOi8VlVj+q14AsMfGimW6tM5H+
         tTFEhB8DOQy25AIRX8lII6o6Ww4Cs3+kXcLA55z3kJ8w2Zyca8+S7+byK+4imiuIl+T6
         AAGB7kduOu1r3mfIKuKEVIm56g8zRPnQlP/9Iabf1YwXeSCLcR0s5ivjNcs6mO65jT6i
         lTuJKWw30sIUU28yzrW58DBiUYvdA4fA7oSM0Gyjl3BbuFqB92M/ouo96k/V2yiI6xYd
         Tgmg==
X-Forwarded-Encrypted: i=1; AJvYcCWPH+BNKjJTUNPnlrLwBOZ0T5tSNeJ1neZLfqTh2eRbluR345h8QznhMi+5YRLfVFhtEEf30A==@lists.infradead.org
X-Gm-Message-State: AOJu0YxLhDYFjtIt9+nPROGvJfYfFxynP5Rxn3ry9CKuHSRpFrhxTCaF
	SAHJCRMwVQVBPO6YiQC6nTXi/j387ClWEyzPY/JpvFF9ZCj4LJhBq9WXYQb25a2yJ9+YNMZ2pm3
	XWzzgdXsH4vnxbapKtz9qQpLaSWMsAFn2P+W4b4bFB7yKExHc+vN/F3cFGGdOdg==
X-Gm-Gg: ATEYQzxy8561cXdVytkgtP+wTBXDbF4yTFi0I/p1C9wqLjDjKcx2QvN0K+J87L8fQdl
	hPS4ZqhWCxLN0pCxZq9Te5v+prtDQeVjc/2t4eywF7GyDXpd0+Wb2neN2B6AlyTz1TUYR/fqhH+
	sv+pMkPKnrrLEKCgXwXBuxdgLLeLg6D+dHBw+3cY93gJQNZ5QRcXYP1VTJCWFKzEZaFhFvQA+xx
	/hy7upv0tiZr72+0SEpLk4ZT0TGQi4ZQx06xJ0T8P9g0tdJuhkgzze0AEbQvx6iZw9ibybaRnUR
	x+kFw2sbr4A9XqXPq/hzOYLkhv6pYMo2V3+yLIWvKn6sMXKWQ4FXLmi7EjSEzomzQTyp7UJsu2P
	EeGaIhFLQYEKh
X-Received: by 2002:a17:903:19e5:b0:2ae:61bb:425c with SMTP id d9443c01a7336-2ae8242cfa9mr6322995ad.35.1772762756412;
        Thu, 05 Mar 2026 18:05:56 -0800 (PST)
X-Received: by 2002:a17:903:19e5:b0:2ae:61bb:425c with SMTP id d9443c01a7336-2ae8242cfa9mr6322775ad.35.1772762755920;
        Thu, 05 Mar 2026 18:05:55 -0800 (PST)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83f77350sm517165ad.51.2026.03.05.18.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 18:05:55 -0800 (PST)
Date: Fri, 6 Mar 2026 10:00:12 +0800
From: Coiby Xu <coxu@redhat.com>
To: Baoquan He <bhe@redhat.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>, 
	stable@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crash_dump: Don't log dm-crypt key bytes in
 read_key_from_user_keying
Message-ID: <aaoyu2ZnZNHMVb8n@Rk>
References: <20260227230008.858641-2-thorsten.blum@linux.dev>
 <aaUIhtN0oUkP5ALi@MiWiFi-R3L-srv>
MIME-Version: 1.0
In-Reply-To: <aaUIhtN0oUkP5ALi@MiWiFi-R3L-srv>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4Pfg1cqN7GS7_FMlgwANwz1sWWXNIumKskqjtTHxcQg_1772762756
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260305_180606_090132_B348D9A1 
X-CRM114-Status: GOOD (  15.96  )
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

On Mon, Mar 02, 2026 at 11:48:22AM +0800, Baoquan He wrote:
>On 02/28/26 at 12:00am, Thorsten Blum wrote:
>> When debug logging is enabled, read_key_from_user_keying() logs the
>> first 8 bytes of the key payload and partially exposes the dm-crypt key.
>> Stop logging any key bytes.
>>
>> Fixes: 479e58549b0f ("crash_dump: store dm crypt keys in kdump reserved memory")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
>> ---
>>  kernel/crash_dump_dm_crypt.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
>> index 27a144920562..5ce958d069dd 100644
>> --- a/kernel/crash_dump_dm_crypt.c
>> +++ b/kernel/crash_dump_dm_crypt.c
>> @@ -168,8 +168,8 @@ static int read_key_from_user_keying(struct dm_crypt_key *dm_key)
>>
>>  	memcpy(dm_key->data, ukp->data, ukp->datalen);
>>  	dm_key->key_size = ukp->datalen;
>> -	kexec_dprintk("Get dm crypt key (size=%u) %s: %8ph\n", dm_key->key_size,
>> -		      dm_key->key_desc, dm_key->data);
>> +	kexec_dprintk("Get dm crypt key (size=%u) %s\n", dm_key->key_size,
>
>Make sense to me.
>
>The kexec_dprintk() is only for debug printing. We can remove above line
>or change it to pr_debug() if security is worried.
>
>Coiby, what do you think?

I think we can assume a key can be reliably read thus no need to print
the first 8 bytes to check it. So this patch looks good to me. And
thanks to Thorsten for suggesting multiple improvements on
kernel/crash_dump_dm_crypt.c!

>
>Thanks
>Baoquan
>

-- 
Best regards,
Coiby


