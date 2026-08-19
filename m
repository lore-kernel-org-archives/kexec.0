Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C82B9C5DF6D
	for <kexec@archiver.kernel.org>; Wed, 19 Aug 2026 05:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3wN405h1WvQQ42J9aP5itCeH3PDbeYvXDW/m8ee+hMM=; b=xmuYeZ0f2kDa5mANcn7Mjg8Gao
	VxPVKpu4RClOCCwAYKd33JwwRtdP5Lu6boNihdl7JM5+U3hlvZu4NRKpIr6ktlXdXFBJtJLZzIc7f
	GDzSfjKcEWPBE8RWImVG/DV+gnUM1ipaoMNa0yl4oYtj2VpjOIIXYz0jH2mbx1OwI3CRo7MUr349W
	LoXOwDXibNctOGZGHJTJfSKHM9KmfhAgVFmxPRWl//5IaI+Y1MJWIuF99viP+PcIpJyEqMiF5ooBS
	yVyNahIQOM75VcAPQno9HpmyfK6kueaFKB47j2bUwceNkLjVBOu08KVEQ06healwCDtWzhVJJAO2r
	nI/7wfBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwZJn-000000093PF-1foO;
	Wed, 19 Aug 2026 05:58:31 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwZJk-000000093OJ-2hEc
	for kexec@lists.infradead.org;
	Wed, 19 Aug 2026 05:58:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787119106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3wN405h1WvQQ42J9aP5itCeH3PDbeYvXDW/m8ee+hMM=;
	b=CzbFkGoKlZoZtoqVnFcddjA622dsq8CwoCK7hOEpMKhKw0If+miyZmuY1mGQcd5x5IZUWN
	wO1rczHOlB1M4J3kozjG42PrGzKBaM/IVxFd5jEPSUg+FRWVCWNaa/Aaf/kTZQ7pvJh59P
	N77r7gk4WVnD55iuoAtiHCIEXFg+VW0=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-424-l4RgFkCIOWiPWIPym43R3w-1; Wed, 19 Aug 2026 01:58:23 -0400
X-MC-Unique: l4RgFkCIOWiPWIPym43R3w-1
X-Mimecast-MFC-AGG-ID: l4RgFkCIOWiPWIPym43R3w_1787119102
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cd01a14e81so9460375ad.1
        for <kexec@lists.infradead.org>; Tue, 18 Aug 2026 22:58:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787119102; x=1787723902;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3wN405h1WvQQ42J9aP5itCeH3PDbeYvXDW/m8ee+hMM=;
        b=SJhR2vOdIxuewAvX2V1al4iuebpt/wh1+EP8/9/3UicKSfk0ixAQF61uOGklEmfcJ1
         Ca3s9Re/A0yEQAFnXMTbtMaiacWyzezt8SaFkCeRlgWes+NPGp1F9vYOPDKfb2rpJ9N/
         kqfp/OUuy5Ha13UBtEadZFUYp32Z0KVs+uNlwid7pbl/VnliSSoAKoi1gRngvwb2DW8m
         UErxbCu7H7gRQ8DXlk+od0rpgqERlyyVWBVUuUyRAcDGuml16jUY5RtS1JFT5xYGH3Kb
         jea5ta9TX9ohIul0Wu6tE+/SrBjayEF52nSsqUB42w95BrvUMji3tdmObk3AIZzvA16p
         bZpg==
X-Forwarded-Encrypted: i=1; AHgh+RpFSujywO+2fj80MEWGJZY6wczFCbbMeCtk2X6STCE+BSrjS2dBKt4Ko5KQ19tS/eo/POC8Tw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx0PQf8lWCnnWa9f7C2MD8PEfmL6FV1TXi661jlEC+ykD0rU5sV
	C3chUtrrAkOGtyv8XcX65XAILnVTsD/QdFKpuTlH9rI7M4HmW9iUyC+Zzf/i0EZgha1FNFIu3+T
	yWw7WcUDtoGtxiYKqkdQlVWVZ/tgaItrcyvc1Der9BnMoWutX165Veo/O1g4JOg==
X-Gm-Gg: AR+sD11ghV0aAAG9R6cvbHpcMFGucEz68hcDZTealiVsfpxvb1x5Byz87evEbF4wbsB
	zbMatlHRJKrPjirvCVHEGt6o6C5/KMZWQIqsSoaJKpE2oURhnaW1FNOYhIQwMBCYUuwbwT15nCa
	EoDZhqysD/CtGGxjnTUBdZG3+/2DAe0auA95TwrbX3Ks/twhtz8BNbeGUjpGPRkyduHv2/7rHqX
	lx9i+KXnXVjXO2pWszZQWzk+wnvkM+gV1cImU6mAL4+ubRDFgzzZ/3u4m0UuRiw7isqGlWCyArG
	ZBKLVXICXJaFBWvfYFTcQD2ShYQ7Sa3yxanCqHaQaSx0iXIr6FifPCE8nS8mO+u0cObIUHbsVNH
	DmgUrVj/V5u3I55klr+Mp
X-Received: by 2002:a17:902:fd87:b0:2cb:ea0b:9164 with SMTP id d9443c01a7336-2d5fd6b0aebmr41699905ad.6.1787119101976;
        Tue, 18 Aug 2026 22:58:21 -0700 (PDT)
X-Received: by 2002:a17:902:fd87:b0:2cb:ea0b:9164 with SMTP id d9443c01a7336-2d5fd6b0aebmr41699365ad.6.1787119101427;
        Tue, 18 Aug 2026 22:58:21 -0700 (PDT)
Received: from [10.76.99.122] ([115.110.236.142])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d5c1e5506asm20846515ad.43.2026.08.18.22.58.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2026 22:58:20 -0700 (PDT)
Message-ID: <0d7acb43-2eb4-44ec-9bfb-b89440afc605@redhat.com>
Date: Wed, 19 Aug 2026 11:28:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kexec: return -ENOEXEC from image probe functions on
 mismatch
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Andrew Morton <akpm@linux-foundation.org>,
 Baoquan He <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>, Tao Liu <ltao@redhat.com>,
 Philipp Rudo <prudo@redhat.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 linux-riscv@lists.infradead.org, kexec@lists.infradead.org
References: <20260813-mpilaniy-v1-1-777d4d0e30f7@redhat.com>
 <2vxzv79c23j6.fsf@kernel.org>
 <9cbe111c-ff63-4f24-b518-094ddd7cea30@redhat.com>
 <2vxzbjaz2269.fsf@kernel.org>
From: Mukesh Pilaniya <mpilaniy@redhat.com>
In-Reply-To: <2vxzbjaz2269.fsf@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4sdZsGeL8D9RqClOEwDTlrOw3jkjxiqORz6BiYjYIQk_1787119102
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260818_225828_766168_56AEAF55 
X-CRM114-Status: GOOD (  45.59  )
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

Hi Pratyush,

On 18/08/26 3:14 pm, Pratyush Yadav wrote:
> On Fri, Aug 14 2026, Mukesh Pilaniya wrote:
> 
>> Hi Pratyush,
>> On 14/08/26 7:43 pm, Pratyush Yadav wrote:
>>> On Thu, Aug 13 2026, Mukesh Pilaniya wrote:
>>>
>>>> Several kexec_file_load() image probe functions return -EINVAL when
>>>> they do not recognize the image format.  A probe function that rejects
>>>> an image should return -ENOEXEC to indicate that the image is not a
>>>> recognized executable format.  -EINVAL implies a problem with the
>>>> syscall parameters, not with image recognition.
>>>>
>>>> kexec_image_probe_default() iterates through registered loaders and
>>>> returns the last probe's error code to the caller.  That error
>>>> propagates as the kexec_file_load() return value to userspace.
>>>> Returning -EINVAL from a probe when no loader matches is semantically
>>>> incorrect and misleads userspace about the nature of the failure.
>>>>
>>>> Return -ENOEXEC from all probe functions and their helpers when the
>>>> image format is not recognized.
>>>
>>> Sounds fine in principle but can you please also share what the real
>>> problem you face is and how changing these return codes helps? These
>>> error codes are uAPI and while we _can_ change them as long as we don't
>>> break something, there should be a clear motivation for doing so.
>>>
>>> [...]
>>>
>> While debugging a misleading error on s390x where kexec -s reported
>> "syscall kexec_file_load not available" instead of the actual EINVAL
>> from a kernel command line that exceeded the architecture limit, we
>> traced the problem to the kexec-tools userspace utility treating
>> EINVAL the same as ENOSYS and ENOEXEC -- as a signal to silently fall
>> back to kexec_load().
>>
>> kexec-tools supports two syscalls: kexec_file_load() and the older
>> kexec_load(). With -a (the default), it tries kexec_file_load()
>> first and falls back to kexec_load() when the syscall is not
>> implemented (ENOSYS) or the kernel does not have a loader for the
>> image format. With -s, it uses kexec_file_load() only with no
>> fallback.
>>
>> When the kernel returns -EINVAL it means something went wrong while
>> loading the image, not that the syscall is missing or the image
>> format is unrecognized. kexec-tools should not fall back to the
>> older syscall in that case. However, some kernel probe functions
>> currently return -EINVAL when the image header does not match,
>> instead of returning -ENOEXEC. Keeping EINVAL in the fallback set
>> to accommodate these probes has the side effect of also hiding
>> genuine loading errors like an oversized command line.
>>
>> kexec-tools should only fall back when kexec_file_load() is not
>> implemented or does not have a matching loader -- not when something
>> goes wrong during load.
>>
>> The fix on the kexec-tools side is to remove EINVAL from the fallback
>> set, but that requires the kernel to be clean first -- probe functions
>> must return -ENOEXEC when they do not recognize an image format, not -EINVAL.
> 
> Okay, the idea makes sense. Though I am curious if in practice there are
> images that kexec_file_load() can't load but kexec-tools can.
> 
> But then I went and looked at the code. The only caller of the probe
> functions I can see is kexec_image_probe_default(). Looking at its code:
> 
>   int kexec_image_probe_default(struct kimage *image, void *buf,
>   			      unsigned long buf_len)
>   {
>   	const struct kexec_file_ops * const *fops;
>   	int ret = -ENOEXEC;
>   
>   	for (fops = &kexec_file_loaders[0]; *fops && (*fops)->probe; ++fops) {
>   		ret = (*fops)->probe(buf, buf_len);
>   		if (!ret) {
>   			image->fops = *fops;
>   			return ret;
>   		}
>   	}
>   
>   	return ret;
>   }
> 
> It defaults ret to -ENOEXEC, which makes sense, but then lets it be
> over-written by each loader. So in practice, it returns what the _last_
> loader returned. _This_ makes no sense. Why should the last loader be
> any special?
Right, the last loader overwriting ret, the commit message describes
this as well. It makes no sense for the return value to depend on
whichever loader happens to be last in the array.

> 
> From reading the code, I think what the author of this wanted to do is
> to try all loaders, and return -ENOEXEC if none succeeded. But the code
> of course strays from that and ends up returning the last loader's
> value.IMHO the function should only try the next loader when a probe returns
-ENOEXEC, not for any other error like -ENOMEM, which is a real failure
and should be propagated immediately, not silently discarded.

> 
> So how about the below diff instead? (** only compile tested **)
> 
> --- 8< ---
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 2bfbb2d144e6..cfb2b8cd5679 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -67,17 +67,16 @@ int kexec_image_probe_default(struct kimage *image, void *buf,
>  			      unsigned long buf_len)
>  {
>  	const struct kexec_file_ops * const *fops;
> -	int ret = -ENOEXEC;
>  
>  	for (fops = &kexec_file_loaders[0]; *fops && (*fops)->probe; ++fops) {
> -		ret = (*fops)->probe(buf, buf_len);
> -		if (!ret) {
> +		if (!(*fops)->probe(buf, buf_len)) {
>  			image->fops = *fops;
> -			return ret;
> +			return 0;
>  		}
>  	}
>  
> -	return ret;
> +	/* No loader found. */
> +	return -ENOEXEC;
>  }
Nice catch, Pratyush but this discards all non-zero return values from
probe functions, which means real errors get swallowed. For example,
kexec_elf_probe() can return -ENOMEM when kzalloc() fails in
elf_read_phdrs(). With this diff, that -ENOMEM becomes -ENOEXEC, which
tells userspace "no loader found" when the actual problem was a memory
allocation failure.

>  
>  static void *kexec_image_load_default(struct kimage *image)
> 
How about the following instead? It keeps the probe return value and
distinguishes -ENOEXEC (format not recognized, try next loader) from any
other error (real failure, propagate immediately):
﻿
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 59fb9d71e9d8..ceb5c97cedac 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -68,17 +68,19 @@ int kexec_image_probe_default(struct kimage *image,
void *buf,
 			      unsigned long buf_len)
 {
 	const struct kexec_file_ops * const *fops;
-	int ret = -ENOEXEC;
+	int ret;

 	for (fops = &kexec_file_loaders[0]; *fops && (*fops)->probe; ++fops) {
 		ret = (*fops)->probe(buf, buf_len);
-		if (!ret) {
+		if (ret == 0) {
 			image->fops = *fops;
-			return ret;
+			return 0;
 		}
+		if (ret != -ENOEXEC)
+			return ret;
 	}

-	return ret;
+	return -ENOEXEC;
 }

 static void *kexec_image_load_default(struct kimage *image)


This requires probe functions to return -ENOEXEC from fixes in patch 1.
I will add this as a separate patch on top in v2.

Does this looks good to you ?

--
Regards,
Mukesh Pilaniya


