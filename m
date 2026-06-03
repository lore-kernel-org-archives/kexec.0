Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ECC4CD6E55
	for <kexec@archiver.kernel.org>; Wed,  3 Jun 2026 22:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:MIME-Version:References:In-Reply-To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V6pazkEL6DFXw7u78OwlQURha9CAXkBpjIcDT/R6oxE=; b=tjhOCFf7LtNBMVePzfiIs89I+2
	FDQjdSwYZ99b9gB7SLz8TWcclVJpSwi2KjdCl1JWgzC8ZTCOLOrHesH9Vtud8kDFn51hfi1f73igS
	9MSC1F0MRDqN9rUaQLmb9UtoEfazHkEgIYofsziEUNEDkfluDM9ACEM9m2Ob8qcWstQI8Xh0xWES8
	NyNSOF4lcpbuNGHiWzkc5B89KO5ktwOjlBNEni3EsvNm44xjh4yuaBpEqE1NL5RD3lHptW2kS6tia
	rJ4zrOgMdnuekDXV/wwYCzriUA6HY30NOYc4N/LJb2U76g8LkBG0Y1krrdAyKwaHgnSoc5FCvUlEU
	qpqvSoDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUttj-0000000Fsuj-2Z8S;
	Wed, 03 Jun 2026 22:17:15 +0000
Received: from mail-dl1-x1233.google.com ([2607:f8b0:4864:20::1233])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUtte-0000000FsuF-0SpK
	for kexec@lists.infradead.org;
	Wed, 03 Jun 2026 22:17:11 +0000
Received: by mail-dl1-x1233.google.com with SMTP id a92af1059eb24-13721dfd471so59617c88.1
        for <kexec@lists.infradead.org>; Wed, 03 Jun 2026 15:17:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780525028; cv=none;
        d=google.com; s=arc-20240605;
        b=J9Dw3NP0gVcq5z2aK52HcnQRjISw2pANvk9d6aTzIew5Ad5UEKTvz69jc1DoeMI/GN
         RnYhN/dLiwJC9/hW844t63z7QDjtdQg0+ekOOpyVPpyqlU4m2rDI+W4YikaF07QE/Qto
         o7sKhJ1gW7CQ/fr4b0fobonXb8DQB4/91dQSVAqlsXl1LfLh46kDQlwJmzquKhuYMqY4
         TOKCcYpMXTjo2GyAXR3AZFWCnZsTvSQWDRTYJleZSeiQU2q1iY67RZQKpsJyMDKnfXnU
         3D6mHxOEeqsp7/PpegSk7oVqPv4twXMqX0tzEyfRK9p68MaWlNDJ9n+7KipL4mW4hPro
         2wYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=V6pazkEL6DFXw7u78OwlQURha9CAXkBpjIcDT/R6oxE=;
        fh=mZTeV2NmX6AyCVRERgCXr72TZ9FrgFw5V5gQPVNC/ec=;
        b=Z126rgg/jMIL+aMs0Eeg4epqunFmaSDR8BwWpYZ6+6Nj6DUblfnwwS+8DjJIFua42G
         P2LSw67PHZuuuZTa5YbQ27d2eKisHf6eTSuw6WFZPwbLulmReKgRU59G6G8akMGJ2DGQ
         a0pp7+FIkQzT0mv6xudhGzZHn/UMN6zEplmk+3JG2jQiKhGM9Xc/sEHMUeJmVRz6jbVq
         aF8POTTxbvOBe2mF6JRhtnuDr5QpgZt0LFLZsaJW1rVqTlw5Wu7n6XnvpRK+oSVOAnw7
         j80DoMQRrTeskQwv4nNwo93ZY3w2uv+wkyenTgIWZS9hSJiE9RQlU1syc+T+6tq/ZtSW
         tt0w==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780525028; x=1781129828; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=V6pazkEL6DFXw7u78OwlQURha9CAXkBpjIcDT/R6oxE=;
        b=V3OmNprIeHaHACN/uzSsrfU99SQmlbSZozBPXzlDDchqkvf0z3BHG75IU36jqHCi3p
         hV+vq+0w+mfhQVeniJZoa/jPklOkt0obRoCO0l2d5zM6KxEig/6qPTQbTAxug1wnrGhx
         mxwMBMlJYqCSiCzw+ttp4LnSQsGyqUBRBdk1xFSyLHuxY+rC/cgHUSt6vyCEMgc/ctHW
         NdNNibdR0LoXd6Hao2eggINM4OzhQS2lw5XtBV1oHNwBI1heLe+obaOj8283q5I8vLC8
         EOJhIxCjO5ykqRQlJxo96Q9B4VK5ILpo4EoozFM6MwwIvWq9dLOyoqoW3LRsAqWY1iXZ
         X1bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780525028; x=1781129828;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V6pazkEL6DFXw7u78OwlQURha9CAXkBpjIcDT/R6oxE=;
        b=GxhJUZGRCoWQaffbCvpFFI5NClwhaZn7aTQq/zi6sggJZAi8EGLfdzRhjXNuEaWY5+
         LwYcfX/X+Rw3QaOplhXpv5SUljtbuVcNioBGUER4+nq0yvGrOAhcFo30ejMWPC75LkPB
         YfROVAzXPt5FhT/O5+0TtqMnzBoLh9ZOCMh6b8KLPVrtnIZk4XE3P8DVXBXUFhzDo9lW
         WgD6NjqS7ASHVCOPMKkIu6MpBkGVijCdu4CQdOuaHavXL4lt6iRgaRI7TWIrUBB970ei
         j68o55AnscRMoldeuDEKazGEAkccel+HgtLa8OsPdiHVWYLA41TD5fsSWOU4vd6kQPhF
         QUkw==
X-Forwarded-Encrypted: i=1; AFNElJ8jAC8EBJW62qjTt9hQhb4fSLQQCAKRcoy1CtVoWcRIArBj306qEC7cD4UQvcpoRfcVmowxuw==@lists.infradead.org
X-Gm-Message-State: AOJu0YwKhhPPcMHQNy7BZ4ctWkzoLQnIcLCYaEkiiyZG2SIzE0pfFQvk
	D9URRfiOX0z2rqSxFYCbwRCR4aIWWDVH3vXnl8TrhPPHNds9vdWStG8X+BWqMj3BazLDEqAqKNi
	Zkynbxek9ouVsih1JFn/8qGlRXEAw9Xl4tRCNEzf7
X-Gm-Gg: Acq92OHyE473+v1fkXB4arTcC4oBVa1ILcfuiTg2Npg/oSYmHuCysF3+j590ospKi74
	7h2kwwE+uEBxvDHC7B7JbDcEGw/YnAAPdiJDtWyRtrfStsbWgYhzJhLZReo5gpsKTXk7ajV+Vau
	08m1LksjnwMIHJdSllbC5NVy2L2BVB8aPfa+d8p1FPXKHN40aRcbIEV9oDfSsqoqsh7XIURpXtg
	RJ1FReOdI3tunUmBWPr6KFZSSNh0tVNj8BtVyyeI79i8W08++tKcxFpEEnatcnhlwpjnJRQ2EZ5
	+7v6uzRHZrTC9KeojKuEBsYd5scS1OxtF1UAuWfaNXT2RtR4f3ClcECq9AekZosX4qxBtflBqim
	fbdoS
X-Received: by 2002:a05:7022:7f19:b0:137:ef27:e29d with SMTP id
 a92af1059eb24-137f6c126b1mr1478374c88.31.1780525027812; Wed, 03 Jun 2026
 15:17:07 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 3 Jun 2026 15:17:06 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 3 Jun 2026 15:17:06 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <ahmbVaCUcBrYK8qO@google.com>
References: <cover.1779080766.git.tarunsahu@google.com> <9huzwlwnbgdd.fsf@tarunix.c.googlers.com>
 <ahmbVaCUcBrYK8qO@google.com>
MIME-Version: 1.0
Date: Wed, 3 Jun 2026 15:17:06 -0700
X-Gm-Features: AVHnY4KwIBznOQxPeeZp-k-7DNYvQD8SHlCWDjhKoWsxt_QvgGRs8hmrB0P3Bno
Message-ID: <CAEvNRgHsJbGz8k8vgCn_HSxeeQ8agEm4oBYQQ0+b3gFb-aVokg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/8] liveupdate: kvm: Guest_memfd preservation
To: Sean Christopherson <seanjc@google.com>, tarunsahu@google.com
Cc: axelrasmussen@google.com, mark.rutland@arm.com, skhawaja@google.com, 
	Mike Rapoport <rppt@kernel.org>, sagis@google.com, Jason Gunthorpe <jgg@ziepe.ca>, 
	Shuah Khan <shuah@kernel.org>, corbet@lwn.net, dmatlack@google.com, 
	Paolo Bonzini <pbonzini@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, vannapurve@google.com, 
	Pratyush Yadav <pratyush@kernel.org>, david@redhat.com, aneesh.kumar@kernel.org, 
	vipinsh@google.com, Alexander Graf <graf@amazon.com>, David Hildenbrand <david@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kexec@lists.infradead.org, 
	linux-kselftest@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260603_151710_173154_59453B17 
X-CRM114-Status: UNSURE (   7.81  )
X-CRM114-Notice: Please train this message.
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

Sean Christopherson <seanjc@google.com> writes:

>>
>> [...snip...]
>>
>> we have one open Question left:
>> 1. How to check guest_memfd is fully shared.
>>
>> [...snip...]
>>
>
> Given that lack of support isn't going to be limited to _just_ guest_memfd,
> simply disallow preservation if the VM supports private memory:
>
> 	if (kvm_arch_has_private_mem(kvm))
> 		return -EOPNOTSUPP;

Makes sense. Tarun this was the other option that I was suggesting when
we discussed offline.

I think (?) it is possible to create a fully-private guest_memfd for a
non-Confidential VM, and even after conversion lands, for both
vm_memory_attributes=true and vm_memory_attributes=false.

In that case, your preservation series can still preserve memory tracked
as private by guest_memfd but not used as private, right?

I don't think anyone will use this combination before guest_memfd
write() support lands, we just need to make sure there's no kernel crash
or corruption in this case.

