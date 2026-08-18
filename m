Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF07CC5DF70
	for <kexec@archiver.kernel.org>; Tue, 18 Aug 2026 09:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+go879+lhtz6kjxYEfCYEUcFeNEXpMv/Ou7ia8zyV34=; b=HtGcp2y12zsFVNdxxudZiO45Rm
	NRj7nASxXrab3dRwxE6XKyWD6i9xw4O5fcmKBfhmV6c4U/FmrLSaR+ig18lxQaClXTu1BHOSCqQyH
	utHHhbeqUJxUulCwC/TIDdNu6l5dm0443jjkJvqdfQGjbSkruzs/+a4xCeLSflR0/ht/1bivww4LG
	2Nk574HrEPSs1dmTj477wZx9q3d05PNKn6vtvH1z0R9LOMPZHdZoIZogaIEIvebUJq2J16vCBnFhY
	UU5aS5ZZcm6/K2OyE/Do6Te9WBTi/tSOsLQ7p+3+b2nSAQSWCNVGnKuyylMYiUW6hup8lnXzckXz/
	Sf9woekQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwGNA-00000007ecw-2brP;
	Tue, 18 Aug 2026 09:44:44 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwGN2-00000007eXZ-2Ewb;
	Tue, 18 Aug 2026 09:44:36 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 81C7E601E0;
	Tue, 18 Aug 2026 09:44:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2E791F000E9;
	Tue, 18 Aug 2026 09:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787046275;
	bh=+go879+lhtz6kjxYEfCYEUcFeNEXpMv/Ou7ia8zyV34=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=K//PAmYi6FmyIoB1+cGsrleQfa6mHr3F/LzlNWNkFMMpAsD+2U5Xr47D+YJr9ApqM
	 3hOtr22TLx8Q/syRCMtIuz/SGWwOiOZdPbQme4kIxxPj8GoFBFBNsy+n1x5j3wcrE1
	 rtGItxvsvNnmFTfH4ZBC5rdEJhy+wAURFYM5IgSjilq8RJKJZzYLST5QoYsq7loMcN
	 lWHE4lUGhC+qcoet9tRSDwgzgnNzqwofXtXMs2gfVkeFXjYM8ndYHYx6gHFMpudiQV
	 z/fjmBER/G7YvT8D3Wusziy4fJ6G8JWO1Yr3vouso/fofoKH4gyScZsbsmJtE4j/iU
	 LYSGQKiZUiZUQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mukesh Pilaniya <mpilaniy@redhat.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Catalin Marinas
 <catalin.marinas@arm.com>,  Will Deacon <will@kernel.org>,  Mark Rutland
 <mark.rutland@arm.com>,  Huacai Chen <chenhuacai@kernel.org>,  WANG Xuerui
 <kernel@xen0n.name>,  Paul Walmsley <pjw@kernel.org>,  Palmer Dabbelt
 <palmer@dabbelt.com>,  Albert Ou <aou@eecs.berkeley.edu>,  Alexandre Ghiti
 <alex@ghiti.fr>,  Andrew Morton <akpm@linux-foundation.org>,  Baoquan He
 <baoquan.he@linux.dev>,  Mike Rapoport <rppt@kernel.org>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  Tao Liu <ltao@redhat.com>,  Philipp Rudo
 <prudo@redhat.com>,  linux-arm-kernel@lists.infradead.org,
  linux-kernel@vger.kernel.org,  loongarch@lists.linux.dev,
  linux-riscv@lists.infradead.org,  kexec@lists.infradead.org
Subject: Re: [PATCH] kexec: return -ENOEXEC from image probe functions on
 mismatch
In-Reply-To: <9cbe111c-ff63-4f24-b518-094ddd7cea30@redhat.com> (Mukesh
	Pilaniya's message of "Fri, 14 Aug 2026 22:57:36 +0530")
References: <20260813-mpilaniy-v1-1-777d4d0e30f7@redhat.com>
	<2vxzv79c23j6.fsf@kernel.org>
	<9cbe111c-ff63-4f24-b518-094ddd7cea30@redhat.com>
Date: Tue, 18 Aug 2026 11:44:30 +0200
Message-ID: <2vxzbjaz2269.fsf@kernel.org>
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

On Fri, Aug 14 2026, Mukesh Pilaniya wrote:

> Hi Pratyush,
> On 14/08/26 7:43 pm, Pratyush Yadav wrote:
>> On Thu, Aug 13 2026, Mukesh Pilaniya wrote:
>> 
>>> Several kexec_file_load() image probe functions return -EINVAL when
>>> they do not recognize the image format.  A probe function that rejects
>>> an image should return -ENOEXEC to indicate that the image is not a
>>> recognized executable format.  -EINVAL implies a problem with the
>>> syscall parameters, not with image recognition.
>>>
>>> kexec_image_probe_default() iterates through registered loaders and
>>> returns the last probe's error code to the caller.  That error
>>> propagates as the kexec_file_load() return value to userspace.
>>> Returning -EINVAL from a probe when no loader matches is semantically
>>> incorrect and misleads userspace about the nature of the failure.
>>>
>>> Return -ENOEXEC from all probe functions and their helpers when the
>>> image format is not recognized.
>> 
>> Sounds fine in principle but can you please also share what the real
>> problem you face is and how changing these return codes helps? These
>> error codes are uAPI and while we _can_ change them as long as we don't
>> break something, there should be a clear motivation for doing so.
>> 
>> [...]
>> 
> While debugging a misleading error on s390x where kexec -s reported
> "syscall kexec_file_load not available" instead of the actual EINVAL
> from a kernel command line that exceeded the architecture limit, we
> traced the problem to the kexec-tools userspace utility treating
> EINVAL the same as ENOSYS and ENOEXEC -- as a signal to silently fall
> back to kexec_load().
>
> kexec-tools supports two syscalls: kexec_file_load() and the older
> kexec_load(). With -a (the default), it tries kexec_file_load()
> first and falls back to kexec_load() when the syscall is not
> implemented (ENOSYS) or the kernel does not have a loader for the
> image format. With -s, it uses kexec_file_load() only with no
> fallback.
>
> When the kernel returns -EINVAL it means something went wrong while
> loading the image, not that the syscall is missing or the image
> format is unrecognized. kexec-tools should not fall back to the
> older syscall in that case. However, some kernel probe functions
> currently return -EINVAL when the image header does not match,
> instead of returning -ENOEXEC. Keeping EINVAL in the fallback set
> to accommodate these probes has the side effect of also hiding
> genuine loading errors like an oversized command line.
>
> kexec-tools should only fall back when kexec_file_load() is not
> implemented or does not have a matching loader -- not when something
> goes wrong during load.
>
> The fix on the kexec-tools side is to remove EINVAL from the fallback
> set, but that requires the kernel to be clean first -- probe functions
> must return -ENOEXEC when they do not recognize an image format, not -EINVAL.

Okay, the idea makes sense. Though I am curious if in practice there are
images that kexec_file_load() can't load but kexec-tools can.

But then I went and looked at the code. The only caller of the probe
functions I can see is kexec_image_probe_default(). Looking at its code:

  int kexec_image_probe_default(struct kimage *image, void *buf,
  			      unsigned long buf_len)
  {
  	const struct kexec_file_ops * const *fops;
  	int ret = -ENOEXEC;
  
  	for (fops = &kexec_file_loaders[0]; *fops && (*fops)->probe; ++fops) {
  		ret = (*fops)->probe(buf, buf_len);
  		if (!ret) {
  			image->fops = *fops;
  			return ret;
  		}
  	}
  
  	return ret;
  }

It defaults ret to -ENOEXEC, which makes sense, but then lets it be
over-written by each loader. So in practice, it returns what the _last_
loader returned. _This_ makes no sense. Why should the last loader be
any special?

From reading the code, I think what the author of this wanted to do is
to try all loaders, and return -ENOEXEC if none succeeded. But the code
of course strays from that and ends up returning the last loader's
value.

So how about the below diff instead? (** only compile tested **)

--- 8< ---
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 2bfbb2d144e6..cfb2b8cd5679 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -67,17 +67,16 @@ int kexec_image_probe_default(struct kimage *image, void *buf,
 			      unsigned long buf_len)
 {
 	const struct kexec_file_ops * const *fops;
-	int ret = -ENOEXEC;
 
 	for (fops = &kexec_file_loaders[0]; *fops && (*fops)->probe; ++fops) {
-		ret = (*fops)->probe(buf, buf_len);
-		if (!ret) {
+		if (!(*fops)->probe(buf, buf_len)) {
 			image->fops = *fops;
-			return ret;
+			return 0;
 		}
 	}
 
-	return ret;
+	/* No loader found. */
+	return -ENOEXEC;
 }
 
 static void *kexec_image_load_default(struct kimage *image)

-- 
Regards,
Pratyush Yadav

