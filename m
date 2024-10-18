Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA47BD3C53F
	for <kexec@archiver.kernel.org>; Fri, 18 Oct 2024 01:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/+e0T8s9D+ACS8lBwf8DYuRcnFnID2Nnc6aiRn1Bfrs=; b=K49fLJmLNOkQ2lVc0WeN0ovzKK
	fwWWhA0Vlq/jy1KkDQttL2h28Y9d8RkyD/MHL5d0T+jYGBrEyvmUYRf5L48Jj7+rNP4AXb5mZRsfY
	LzjqeqgTuzNJGQx4CbYkeUceIwa+hw/vIX1WvKLaCP1y8JTZllXjKeoAUxvQfcPWZhnAUw1BNOIE0
	fVtY4URBPvuS/AJ1Y0N4jKHwrN176qLRZ+oGwc2GmfyKuy7XXFSaQawNCOA+sA4/86Cj3+ksnennX
	PaCIPVypR9H20cnBcrazdw+5z+oFRy5Pfy4cz3LTzdLNWRHWODVrVk6lCuvbAysQorS1OgpOlxshG
	5TDqXI4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1c3U-0000000GbMx-3fUq;
	Fri, 18 Oct 2024 01:45:28 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1c3R-0000000GbMH-1KuJ
	for kexec@lists.infradead.org;
	Fri, 18 Oct 2024 01:45:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729215924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kF9L/0/jEWIqoyh3hjUFK/h0JiArykMrlHze3wNZf+8=;
	b=aXicDse8Er+6wHLzNqOJExUdftCaq915PJM5BNb5GQ1QlLZtQUTyES9CLrIiVD4JGKunC6
	/pMXQUZSi0cf6WA+K4bgnuv+uV730v1uNUYIeyJ82pJQU38UV9r9+PllC0bLKv2tHZ0+Jq
	QB+LYmrDOfw5e2jxPNegrVS46Pzvnj0=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-ByELLT_7NsKtOpfw_FkTcQ-1; Thu, 17 Oct 2024 21:45:23 -0400
X-MC-Unique: ByELLT_7NsKtOpfw_FkTcQ-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-7ea8baba4d5so1902536a12.2
        for <kexec@lists.infradead.org>; Thu, 17 Oct 2024 18:45:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729215922; x=1729820722;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kF9L/0/jEWIqoyh3hjUFK/h0JiArykMrlHze3wNZf+8=;
        b=devjroDhqbIz/py42ai7Mal+J4SSzrATI+4hfTXkSWVECMCUpwv9qUy3iOp7PcCgL7
         +EUI8Iv6cbrmJsfRQglU8UDs2u8m1vxE0g30nraNroA6PgYtyvYNPN8AhIG302Tab+v5
         hyCCdP/SFKzItTmi3RMuJBdVOfDuicfDRRhHSgNVJMdHc6ZdyPB8hIvWdsuDEtpMtvHA
         pOhapI/781PBaJO15+6QjxJCmB7Tn3alxJhXCFtIHBEvnemLyj1aFtLtSs+NSHJFp+XB
         kF6xdbZ/Edps2mVcwvIIDas95Q6hl57X7YbsipU23zYCJFXRpCJuu7rN7WeDXd5R07E4
         WJCw==
X-Gm-Message-State: AOJu0YzCS5q6sX57SULT1zhwWDtB5779p7YIyK+pLg5XljJOOD9PAwkW
	UmGH56CtzthHm7pSEkyN7aPrlifV0rgOnpwHbDs9O+Nt2TpB2mUQoWKGl3DXxHY68GRNHsLXXl4
	ER7EZwXwisFp4r/uoCfLFP0yRlF4IHb8BQPit+gigVwXIFIRVFyHiAfe5Tw==
X-Received: by 2002:a05:6a21:1706:b0:1d8:b076:d9ad with SMTP id adf61e73a8af0-1d92c57bcfemr1283441637.40.1729215922018;
        Thu, 17 Oct 2024 18:45:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELXI3rWpUnWGTn+OFPj0VKUMIIHmOrQ9N8JxvRbg/oBYI+G6/m6Fxjefu3RxKAlgaDRIhjcA==
X-Received: by 2002:a05:6a21:1706:b0:1d8:b076:d9ad with SMTP id adf61e73a8af0-1d92c57bcfemr1283424637.40.1729215921594;
        Thu, 17 Oct 2024 18:45:21 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ea345b45fsm333944b3a.177.2024.10.17.18.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 18:45:21 -0700 (PDT)
Date: Fri, 18 Oct 2024 09:44:37 +0800
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
Message-ID: <enehvyzptsb2daxnsybmkv5byeqrebgcgwpz3tlmqwpwfaxtmm@ca57dtcsmyna>
References: <20240523050451.788754-1-coxu@redhat.com>
 <20240523050451.788754-3-coxu@redhat.com>
 <Zl7Vd3BqxDXdMHkL@MiWiFi-R3L-srv>
 <epa3mtnac3ekyoq7zykyjnhu3i27mivbtlkss6mbjyaa3kmhof@qwbfshfbtei4>
 <ZmZeJVa/kpyfZ47g@MiWiFi-R3L-srv>
MIME-Version: 1.0
In-Reply-To: <ZmZeJVa/kpyfZ47g@MiWiFi-R3L-srv>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241017_184525_456749_4CACE529 
X-CRM114-Status: GOOD (  38.44  )
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

On Mon, Jun 10, 2024 at 10:00:05AM +0800, Baoquan He wrote:
>On 06/07/24 at 08:27pm, Coiby Xu wrote:
>> On Tue, Jun 04, 2024 at 04:51:03PM +0800, Baoquan He wrote:
>> > Hi Coiby,
>>
>> Hi Baoquan,
>>
>> >
>> > On 05/23/24 at 01:04pm, Coiby Xu wrote:
>> > > A sysfs /sys/kernel/crash_dm_crypt_keys is provided for user space to make
>> > > the dm crypt keys persist for the kdump kernel. User space can send the
>> > > following commands,
>> > > - "init KEY_NUM"
>> > >   Initialize needed structures
>> > > - "record KEY_DESC"
>> > >   Record a key description. The key must be a logon key.
>> > >
>> > > User space can also read this API to learn about current state.
>> >
>> > From the subject, can I think the luks keys will persist forever? or
>> > only for a while?
>>
>> Yes, you are right. The keys need to stay in kdump reserved memory.
>
>Hmm, there are two different concepts we may need differentiate. From
>security keys's point of view, the keys need be stored for a while so
>that kdump loading take action to get it, that's done through sysfs;
>Froom kdump's point of view, the keys need be stored forever till kdump
>kernel use it. I can't see what you are referring to from the subject,
>esepcially you stress the newly added sysfs
>/sys/kernel/crash_dm_crypt_keys.

Thanks for the suggestion! The patch set's goal is make the kdump kernel
to be able to unlock encrypted volumes so the keys have always to be
there to be ready for the kdump kernel. In fact, the 1st kernel also
keeps the keys in runtime memory because I/O data could be written back
to disk anytime and thus needs to be encrypted with the keys anytime.
But keys are sensitive data so we try to make it as safe as possible and
one measure for example to make it stay in the keyring for relatively
short time.  I'll add a note in next version's commit message. Together
with the info of the life cycle of keys, hopefully it will bring some
clarities

>
>>
>> > If need and can only keep it for a while, can you
>> > mention it and tell why and how it will be used. Because you add a lot
>> > of codes, but only simply mention the sysfs, that doesn't make sense.
>>
>> Thanks for raising the concern! I've added
>> Documentation/ABI/testing/crash_dm_crypt_keys and copy some text in the
>> cover letter to this patch in v5.
>>
>> >
>> > >
>> > > Signed-off-by: Coiby Xu <coxu@redhat.com>
>> > > ---
>> > >  include/linux/crash_core.h   |   5 +-
>> > >  kernel/Kconfig.kexec         |   8 +++
>> > >  kernel/Makefile              |   1 +
>> > >  kernel/crash_dump_dm_crypt.c | 113 +++++++++++++++++++++++++++++++++++
>> > >  kernel/ksysfs.c              |  22 +++++++
>> > >  5 files changed, 148 insertions(+), 1 deletion(-)
>> > >  create mode 100644 kernel/crash_dump_dm_crypt.c
>> > >
>> > > diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
>> > > index 44305336314e..6bff1c24efa3 100644
>> > > --- a/include/linux/crash_core.h
>> > > +++ b/include/linux/crash_core.h
>> > > @@ -34,7 +34,10 @@ static inline void arch_kexec_protect_crashkres(void) { }
>> > >  static inline void arch_kexec_unprotect_crashkres(void) { }
>> > >  #endif
>> [...]
>> > > +static int init(const char *buf)
>> >              ~~~~ A more interesting name with more description?
>>
>> Thanks for the suggestion! I've added some comments for this function
>> in v5. But I can't come up with a better name after looking at current
>> kernel code. You are welcome to suggest any better name:)
>
>Usually init() is for the whole driver module. Your init() here only
>receive the passed total keys number, and allocate the key_header, how
>can you simply name it init()? If you call it init_keys_header(), I
>would think it's much more meaningful.

Good suggestion! Yes, init_keys_header would be a much better choice!
Unfortunately a new version will switch to configfs. So I will keep this
lesson in mind and try to apply it to similar cases in the future.

>
>>
>> > > +static int process_cmd(const char *buf, size_t count)
>> >                                                  ~~~~
>> > If nobody use the count, why do you add it?
>>
>> Good catch! Yes, this is no need to use count in v4. But v5 now needs it to avoid
>> buffer overflow.
>
>OK, did you add code comment telling what 'count' stands for?
>
>And the name 'process_cmd()' is also ambiguous. We may need avoid this
>kind of name, e.g process_cmd, do_things, handle_stuff. Can you add a
>more specific name?

As new version will switch to configfs, process_cmd will no longer be
needed. But I'll try coming up with better names in the future. Thanks!

-- 
Best regards,
Coiby


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
