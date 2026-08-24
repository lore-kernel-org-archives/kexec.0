Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D6ECC5DF81
	for <kexec@archiver.kernel.org>; Mon, 24 Aug 2026 11:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FU4cz5CWcQHkRlr+8xKLmqs8z7dRnApbdwmY9dOZjDo=; b=hxpHVVjCunmyLQG/om6aaba1Q4
	DI22mcQg6ZdUWcux9Gnm3o99zctOaJF2y0p4JpIVdpUz6V7JHXpID4cmKoo8ltIUXUJSCxGpKPKI5
	1moVJHMV8MOyqaWy4erYxJsOIm3v8sMK2PtmeI4D2zsKcwQaMtIfFG38q954Iom/hmtjXUdM52R9q
	NTDULUAIFs4Qr/jNPtG1Y7Yx+7uYqBd3g+nBOBLVTb6t5RBgoAGeH56LdkVfpnfUId+khXx4/JLFl
	pow2Pp46rEtfuMRBazdcpEU92e+Fgn483e+EsgFFQxWfoCTkRDKsO6TTWTFh2qd2LJ9ZKVXAY61uZ
	40pnd4CA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wySTJ-0000000GRlo-3lzo;
	Mon, 24 Aug 2026 11:04:09 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wySTH-0000000GRl6-0XfS
	for kexec@lists.infradead.org;
	Mon, 24 Aug 2026 11:04:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787569444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FU4cz5CWcQHkRlr+8xKLmqs8z7dRnApbdwmY9dOZjDo=;
	b=XDetrfQlWCKeaKMt7vpJk6xtqALvh6Wgm6hvqE3RKcXbmpUvBmBzHoa5nUUBMi8o4cUExL
	hF9D8ni1XbS2t4mE5EMpwgoEV3CxH+P/HaHtZWNTNumYlxu7cuPOaokaLmIZ8I/0x/oYUq
	nhUoJQIWsfLecoruQVUlwFqefIah1iI=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-JbddOUg0Mweku7-RtWqBuA-1; Mon, 24 Aug 2026 07:04:02 -0400
X-MC-Unique: JbddOUg0Mweku7-RtWqBuA-1
X-Mimecast-MFC-AGG-ID: JbddOUg0Mweku7-RtWqBuA_1787569442
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38e4758ab46so5359128a91.0
        for <kexec@lists.infradead.org>; Mon, 24 Aug 2026 04:04:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787569442; x=1788174242;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FU4cz5CWcQHkRlr+8xKLmqs8z7dRnApbdwmY9dOZjDo=;
        b=fqD0eUS28SyOmB7YCNH7SE1GndF7JPwo/eVpGCzdck6QxW8kIPssbU+ZeRpSCn6lkz
         OKBLtMXUjiU+tlTYHJGHZMWLY2gr+DKpYwJ48tTKK02xDWWcAFxheM/8lLPSA5/8RCQJ
         KNbpeCfkbWP6mv/P98vMCkmntcTCHfxegsEKwVCQ2w2ooVcAJoxKXYLUYXUUXnuNkuZ2
         dNOrbrqkDtXdwcYVxpH0KF55MfVz79PDTWizTT3ivaTrEVG0h1Acn7Xiv2EpgQZzRsSB
         GdUI+EPWK5bxo+uaNTNeRm2kaGwIhhcZudXYBO/N3U8cpmkx/wf/UFk4cV1kqfgMtBoX
         Vv+w==
X-Forwarded-Encrypted: i=1; AHgh+RrYQLD5hYg/DGhGkNwjLJ8ixYnKxpUukRfN8g7gcHWgaRRr0k/4+36YT9+2deLcrsnQxhZ+Sw==@lists.infradead.org
X-Gm-Message-State: AFuF++lMmk9/KvEQA9EGKAlWd6WNH1agcIhI6T68E8hsSmmGgk9ES3uT
	YfTiudIsFZK0BKuGb+FhNpK7pTwWUaZcy/s7AukxPX27+rq9P+80PynjdCgtNJCxNhqwRDn/M5h
	896KNVO81hacKaODzjl4wq1yOJuADyvlHjjr59YAPV+zt1o1IrXFT4I3m2xs6lQ==
X-Gm-Gg: AR+sD13tdkGhII4qDWca89tDlkFuzfl+pehumeS6CQZHnjlmouznLaL4GJZelTeYvgM
	SqlCcbWQOkVDvQJR9K2DdqwJLARHgDpVjPNa0jHj7tEZBfwSJcunwPfkGazUFtdupmDH/01ZZTa
	7iImtsFpKPxtfqX97AdK8hEBzPth3HsbF/m7UoYy9sfZcoH2hyDIshDcqgRXDAm3Ss0TSgea35F
	1FHfMI6Ltixq2+dNMtBEaRt3pMnb+wvaii1CjYTdMBdrId9rEvgKDPrflmuWV3Zw7r39mb18fTm
	AaM8oSur0yxvVmOzNXboC2duv427gpXxrGgywPBlg1rVENewGT7u00VPR+tGMz6O6z1CX3rMilR
	PkdFLF4CV9HlcP0hq8Q==
X-Received: by 2002:a17:90b:2e8e:b0:38d:ddc2:7ccb with SMTP id 98e67ed59e1d1-395c3377610mr50635873a91.1.1787569441371;
        Mon, 24 Aug 2026 04:04:01 -0700 (PDT)
X-Received: by 2002:a17:90b:2e8e:b0:38d:ddc2:7ccb with SMTP id 98e67ed59e1d1-395c3377610mr50635708a91.1.1787569440733;
        Mon, 24 Aug 2026 04:04:00 -0700 (PDT)
Received: from [192.168.1.4] ([122.171.18.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395e49985fcsm9789043a91.7.2026.08.24.04.03.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2026 04:04:00 -0700 (PDT)
Message-ID: <a2958690-4d20-463d-a0f8-c1a18f58e286@redhat.com>
Date: Mon, 24 Aug 2026 16:33:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kexec: fix kexec_file_load fallback error handling
To: Bradley Morgan <include@grrlz.net>
Cc: horms@kernel.org, kexec@lists.infradead.org, ltao@redhat.com,
 prudo@redhat.com
References: <AD2F7A1F-3D15-424E-9F3A-6E8D2A937E6F@grrlz.net>
From: Mukesh Pilaniya <mpilaniy@redhat.com>
In-Reply-To: <AD2F7A1F-3D15-424E-9F3A-6E8D2A937E6F@grrlz.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: sKBVVLongLkx9d4UCZLARoYSUr8EW9bKzLy9FcOa1J0_1787569442
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260824_040407_251063_8DFC1199 
X-CRM114-Status: GOOD (  23.00  )
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

Hi Bradley, thanks for review.

On 22/08/26 12:44 am, Bradley Morgan wrote:
> On 14 August 2026 08:53:29 BST, Mukesh Pilaniya <mpilaniy@redhat.com>
> wrote:
>> With the default -a (--kexec-syscall-auto) option, kexec-tools first
>> tries kexec_file_load() and falls back to kexec_load() when the syscall
>> is not implemented (ENOSYS) or the kernel does not have a loader for the
>> image format (ENOEXEC/ENOTSUP). [...] Falling back on EINVAL hides the
>> real error, because EINVAL means something went wrong during loading.
>>
>> Remove EINVAL from the fallback path.
> 
> Hiding the real error behind a fallback is exactly what makes this one
> hurt to debug, so good direction.
> 
>> Several kexec_file_load() image probe functions incorrectly return
>> -EINVAL rather than -ENOEXEC when encountering an unrecognized image
>> format. This kernel patch fixes the issue:
>> https://lore.kernel.org/all/20260813-mpilaniy-v1-1-777d4d0e30f7@redhat.com/
> 
> That one is still being reworked, Pratyush just LGTM'd the
> probe_default change a couple days ago and the fix isn't in any tree
> yet. And until it is, the arm64 probe and the riscv image probe still
> return -EINVAL, and that last errno is what kexec_image_probe_default()
> leaks to userspace (I checked the loader lists in the tree). So if this
> lands on tools before the kernel fix lands, an image that used to
> silently fall back to kexec_load() on those arches now just fails with
> EINVAL.
> 
> Is the plan to hold this one until the kernel side is in? Because right
> now it looks like it can race ahead of its dependency.
> 
Yes, the kernel patch will merge first, then this one. I will follow up
on the same thread once the kernel fix is merged.

>> Print the actual errno for ENOEXEC/ENOTSUP before falling back
> 
> Good, that is the part that makes the s390 command line case visible.
> 
> The my_load/k_unload ENOSYS message hunks are unrelated cosmetics, fine
> but could be their own patch if you feel like splitting.
>
The my_load/k_unload ENOSYS hunks are not just cosmetic, they address a
misleading error output. Today, when kexec_load is absent, my_load dumps
the entry pointer, flags, and all segments, which is debug noise for
what is simply an unsupported syscall. Similar, k_unload prints "kexec
unload failed: Function not implemented", which reads like something
went wrong rather than the syscall not being available.

I'm happy to split this if you'd prefer, but since they're small and
directly related to the error-path cleanup, I kept them together.

> Its a good patch, I just want the ordering question answered first.
> 
> Thanks!

-- 
Regards,
Mukesh Pilaniya


