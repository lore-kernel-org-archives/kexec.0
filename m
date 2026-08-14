Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35A72C5CFDB
	for <kexec@archiver.kernel.org>; Fri, 14 Aug 2026 14:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+bcbWdhEjG87MX2EDCpS7KjqQqoX5OV3WWLuViRbRgg=; b=O4aKoY/kfv7hI9va3oz3NFzdy4
	OxqeQ8HuqBrRdejYb2HyopbmaPrrnntnEo9mK7tj+5yI/k0rutA7AmZW6J1R9dLsYlCZDEhZs6PTb
	BBGvB0gGm0ZTWML2858DPWK5tF3yVZBCIGb9CZBcUV09oqzMgf1oNmIpxJQnV3Hw6M/LOb+Sr2HoC
	xqc4MqpfqRwVmHVI9DlxRQzx38EsB9E4eJ4flEJYOy8K+X7hDKuAqRjNeP2iFfUyoFF/UoT8cikYk
	z4YHicBjuNixZJrMLNa55SUBwjhGxmxAIsnun3lk59B5+mtdAu00u0hfLN2iE3y1qM7O0E51xRfmc
	sxWfdcHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wusfT-00000002lnN-0xBo;
	Fri, 14 Aug 2026 14:13:55 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wusfS-00000002ln6-3CaR;
	Fri, 14 Aug 2026 14:13:54 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 141C242EAB;
	Fri, 14 Aug 2026 14:13:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D8171F00ADB;
	Fri, 14 Aug 2026 14:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786716834;
	bh=+bcbWdhEjG87MX2EDCpS7KjqQqoX5OV3WWLuViRbRgg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=VRIsCI+wsyEJPBVrNxqIkYblBa0FJMS39qhQqpJVSpaa68D+KRJoneTkVv9Wg01nK
	 +qyA6K77Yht+pbPVqui1YNP/9292nCif/6kF7yvT7ne4ZGaV6FExvwv2owHiZxFx5q
	 AEjiFLNWibXageWnmRHWprOz+aGcR64gT2twrAWt8V39APc24rl5j/PAdRmEiGCxDw
	 ZRr5tYhhaknltz5tF5igLnjglzhmOsgkf6d4b75sTSgxlMUYuFNNduZ++JCsD+JT4C
	 IutIJIsr13BP1wADQsVBbyYSSvKbDW8cvFSskjxprq4txm+DsrUeK8Kkv0V0LnjKw3
	 x5P5qtohP3Tog==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mukesh Pilaniya <mpilaniy@redhat.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,  Will Deacon
 <will@kernel.org>,  Mark Rutland <mark.rutland@arm.com>,  Huacai Chen
 <chenhuacai@kernel.org>,  WANG Xuerui <kernel@xen0n.name>,  Paul Walmsley
 <pjw@kernel.org>,  Palmer Dabbelt <palmer@dabbelt.com>,  Albert Ou
 <aou@eecs.berkeley.edu>,  Alexandre Ghiti <alex@ghiti.fr>,  Andrew Morton
 <akpm@linux-foundation.org>,  Baoquan He <baoquan.he@linux.dev>,  Mike
 Rapoport <rppt@kernel.org>,  Pasha Tatashin <pasha.tatashin@soleen.com>,
  Pratyush Yadav <pratyush@kernel.org>,  Tao Liu <ltao@redhat.com>,
  Philipp Rudo <prudo@redhat.com>,  linux-arm-kernel@lists.infradead.org,
  linux-kernel@vger.kernel.org,  loongarch@lists.linux.dev,
  linux-riscv@lists.infradead.org,  kexec@lists.infradead.org
Subject: Re: [PATCH] kexec: return -ENOEXEC from image probe functions on
 mismatch
In-Reply-To: <20260813-mpilaniy-v1-1-777d4d0e30f7@redhat.com> (Mukesh
	Pilaniya's message of "Thu, 13 Aug 2026 12:36:29 +0530")
References: <20260813-mpilaniy-v1-1-777d4d0e30f7@redhat.com>
Date: Fri, 14 Aug 2026 16:13:49 +0200
Message-ID: <2vxzv79c23j6.fsf@kernel.org>
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

On Thu, Aug 13 2026, Mukesh Pilaniya wrote:

> Several kexec_file_load() image probe functions return -EINVAL when
> they do not recognize the image format.  A probe function that rejects
> an image should return -ENOEXEC to indicate that the image is not a
> recognized executable format.  -EINVAL implies a problem with the
> syscall parameters, not with image recognition.
>
> kexec_image_probe_default() iterates through registered loaders and
> returns the last probe's error code to the caller.  That error
> propagates as the kexec_file_load() return value to userspace.
> Returning -EINVAL from a probe when no loader matches is semantically
> incorrect and misleads userspace about the nature of the failure.
>
> Return -ENOEXEC from all probe functions and their helpers when the
> image format is not recognized.

Sounds fine in principle but can you please also share what the real
problem you face is and how changing these return codes helps? These
error codes are uAPI and while we _can_ change them as long as we don't
break something, there should be a clear motivation for doing so.

[...]

-- 
Regards,
Pratyush Yadav

