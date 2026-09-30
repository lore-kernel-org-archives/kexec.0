Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2EBBCA5FB1
	for <kexec@archiver.kernel.org>; Wed, 30 Sep 2026 11:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:From:Subject:Message-ID:References:Mime-Version:
	In-Reply-To:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MpduhbNkFUuFWigrQQWVYqgTBA32JDerhEvTpfLDHMk=; b=ruj2GzmkkMrbYdX3z/tkBzu8yy
	q5zk+ga8lGATVJN0bDft44eDKbTXXuJne2VTDwd75bfVMTmkOXUtjVjRYDorOVSGQAVc7TRGpRv6L
	VL0bDEdB1ZGwtMgB05/J2JyqcRThLc1cpGS2U7fkDlcrI/pYxTb0aUrJ2QpuEnmfEN9MzrF0oa1j9
	vZIdphQ9SPn/Jia0Ky5EOcSfkbKpwNZmT6ZBRZ9gSVAqi08NZiCRNPZolIaMWbghgdQzWGIlUbh9T
	jGR3Xzcd0KSDERdXmkuB9WnTnNbizJMJjK83Q1mlFpo4Tnqznehv/cVNWpEIclLp1Rtx7A2/yQuB5
	FJiNaj4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBsYk-00000005sve-3cK2;
	Wed, 30 Sep 2026 11:33:14 +0000
Received: from mail-ej1-x648.google.com ([2a00:1450:4864:20::648])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBsYf-00000005suX-47io
	for kexec@lists.infradead.org;
	Wed, 30 Sep 2026 11:33:13 +0000
Received: by mail-ej1-x648.google.com with SMTP id a640c23a62f3a-c2d93b92937so343791766b.1
        for <kexec@lists.infradead.org>; Wed, 30 Sep 2026 04:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790767987; x=1791372787; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MpduhbNkFUuFWigrQQWVYqgTBA32JDerhEvTpfLDHMk=;
        b=IWofizS+gvjfvLEMpeoJ5bZMBtM9tHZERm/eRkxKGVQ9w5QXX1Qrwr1OY93iucEjPO
         yj0jgXYD8UzK5sB0k7Y0DVCD05XdhkCzvHXMhXegg0JRugyItkfKs2t453kKqal0P/5m
         JKleGlGigmF6V04b9TJdWmMAVsFf+QECcru1FZnVhdEYyk9UwUPUCH8BVAVaYJIkjslA
         LLAOjB+2mTiKW8w6N0KsYX1SGmkHW9/RvC9bQcB4BycT4apN+qcb0MsOoR7f9370hs85
         VuE1UXjif9XXzB9gFbNDw6hS58+HFlf1q2B8bOv0HD7jBScsFa1xgvO4ctufqcneIu50
         xymQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790767987; x=1791372787;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MpduhbNkFUuFWigrQQWVYqgTBA32JDerhEvTpfLDHMk=;
        b=SZEuZJimvvAFo9zOmMpy1WcZ8x1vz5bsiP+GU3QKWYm/jIS9xbuwSsDHkxP2HC1xSc
         RAFpAzzFqZ/ZpPH5nv6E7XmiJRasRLw8GOTbz4qF4ElWVGJwWrlTv+fTg4ygCAn89vje
         vHEeAKTYDelowRij+ZEW91pTM/Rp5auP5JdHjYw12Vr3Q1uJ7s+F3IylRMcmbg7ljGnK
         D2zL3/Kr22Rr5ms1W3jBooOMWOwFXRhl3GuINfqJw6nokwtl/5bF3XEsETepAUCh9wPx
         T6bfLHBAzEs72TGVxMKSYZfQfspFynEL07w6c0yElWDkXwA+4WUp6iwEmKfEHNKM4VYs
         xHJg==
X-Gm-Message-State: AFuF++kTlLdXYktXH9YPPtosFHV5TZqtI7Cy4U8uf5cm9CLkv9YGGMXE
	ukaDRovNyMAVw2j/UG4HqBkogQuz/qDByzhWFrA4POVu+ssmq31pgkiT4DQaYbkOrVygOft8Fb8
	8OljJPtGg9pd6Z6fIyQ==
X-Received: from ejcfs31.prod.google.com ([2002:a17:907:601f:b0:c2d:46db:167a])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:3e1a:b0:c25:2d27:5652 with SMTP id a640c23a62f3a-c2e23cae407mr82433966b.11.1790767986551;
 Wed, 30 Sep 2026 04:33:06 -0700 (PDT)
Date: Wed, 30 Sep 2026 11:33:05 +0000
In-Reply-To: <20260926093200.5727C1F000FF@smtp.kernel.org>
Mime-Version: 1.0
References: <20260926092448.4090401-1-tarunsahu@google.com>
 <20260926092448.4090401-2-tarunsahu@google.com> <20260926093200.5727C1F000FF@smtp.kernel.org>
Message-ID: <9huzfqyrrn2m.fsf@tarunix.c.googlers.com>
Subject: Re: [PATCH v3 2/2] memblock: use binary search to locate candidate regions
From: tarunsahu@google.com
To: sashiko-reviews@lists.linux.dev, dmatlack@google.com, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Mike Rapoport <rppt@kernel.org>
Cc: kexec@lists.infradead.org, linux-mm@kvack.org, 
	Pratyush Yadav <pratyush@kernel.org>, linux-kernel@vger.kernel.org, dev.jain@arm.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260930_043310_053148_09C7A75A 
X-CRM114-Status: GOOD (  19.88  )
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

sashiko-bot@kernel.org writes:

> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] mm: commit message falsely claims O(N log N) worst-case comple=
xity
> --
>
> commit ffd047af563941b5aabcd86a52d569f9b40c01ec
> Author: Tarun Sahu <tarunsahu@google.com>
>
> memblock: use binary search to locate candidate regions
>
> This commit introduces a binary search helper, memblock_bsearch_start(),
> to optimize finding candidate regions in memblock_add_range() and
> memblock_isolate_range(), aiming to reduce boot-time overhead during heav=
y
> memory fragmentation.
>
>> Under heavy memory fragmentation (such as KHO page preservation register=
ing
>> hundreds of thousands of disjoint folios), scanning from index 0 on ever=
y
>> insertion and isolation results in O(N^2) complexity, causing boot-time
>> memory retrieval to take several minutes (~268s for 393k pages).
>>
>> Using binary search reduces the worst-case complexity to O(N log N)
>> (and O(N) for sequential appends), cutting KHO memory retrieval time
>> from ~268s to ~50ms.
>
> [Severity: Medium]
> Is the claim of O(N log N) worst-case complexity mathematically accurate =
here?
>
> While the binary search reduces the time to locate the insertion index to
> O(log N), the regions are still stored in a contiguous array. If disjoint
> memory regions are inserted in an order that requires inserting into the
> middle of the array, the subsequent elements still need to be shifted.
>
> Looking at memblock_insert_region() which is called during insertion:
>
> static void __init_memblock memblock_insert_region(...)
> {
>         ...
>         memmove(rgn + 1, rgn, (type->cnt - idx) * sizeof(*rgn));
>         ...
> }
>
> Because this memory move operation guarantees the worst-case complexity o=
f a
> single insertion remains O(N), wouldn't inserting N disjoint regions in
> descending or scattered order still result in an O(N^2) worst-case time
> complexity overall?

Right. Here is the analysis below

KHO preserved regions is sorted in incremental order. So searching the cand=
idate
is O(1) and insertion cost is O(1). So for N insertion is O(N).

for random regions, worst case (invertedly sorted)
Total Cost:
     Sum(log(i) + i, i=3D0, i=3DN)
     OlogN! + O(N(N+1)/2) ~ O (N^2)

hence, sashiko is right, So how can we improve this:  we cannot.

Incoming regions can overlap and there can be already present
regions in memblock_reserved array that might overlap with incoming
regions. So, only possible solution is one-by-by insertion. So here,
finding the location for insertion using binary search is best we can
do with linear arrays.

As KHO is the only user of having large reserved regions which are
sorted, Patch fulfils its purpose. I will update the commit msg to
correctly populate the time complexities.

~Tarun

>
> The described KHO workload sequentially appends regions, which avoids the
> shifting overhead and achieves O(N) overall. Could the commit message be
> updated to clarify that this patch improves sequential insertion to O(N),
> but the worst-case for fragmented insertions remains O(N^2) due to the ar=
ray
> shifting?
>
> --=20
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926092448.40=
90401-1-tarunsahu@google.com?part=3D2

