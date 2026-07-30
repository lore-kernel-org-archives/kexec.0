Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33C8EC5516E
	for <kexec@archiver.kernel.org>; Thu, 30 Jul 2026 17:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:MIME-Version:References:In-Reply-To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UOih8CBVKjn02CmrfoiIHS5zm6Wg61jRZNK4KLcmhAA=; b=NqnfkE9UCeHbzMDMZh9wM2dFon
	Ry1gnJA0ltLqvfzIhiVt7lEAT0ajzwnWuDG0CMEt4703Bp75Qf5EQvCa02yxTYqmw2lFYkUobDKUA
	CnMMOqkF2bNIzJbRAyc9uYwLzcWoN8U6Xp8N1deBuqSL9SdqSrfTb7OrYBFadt7ljDtqAhrJvcZfS
	k4Pt85jYhbo0FIOUksm+cAw4NJNlsvbtXlmQ9Qo139g5OFXOAo/f+qSipRU+wNUbjcoKB/UvOB3Z9
	q6tDsps7yN6gKBGMOmk9/HdGJDKmGzHcDUuPe9+KvUB7pcWLCgTgvvX4AQlOrH/LxWgHlffcf1I9y
	ItTSPOEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpUpy-0000000B72h-0Hmv;
	Thu, 30 Jul 2026 17:46:30 +0000
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpUpv-0000000B72E-1VkI
	for kexec@lists.infradead.org;
	Thu, 30 Jul 2026 17:46:28 +0000
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-ca97d139d8dso37435a12.2
        for <kexec@lists.infradead.org>; Thu, 30 Jul 2026 10:46:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785433586; cv=none;
        d=google.com; s=arc-20260327;
        b=H9/HhI/pqa7mpF9m3pQhpszW2BUpN41NtdhWwoeK6HFSc9YHj8eexKf0S2OmjCtyLh
         a/WEfkVgZZ5CSKTp/0KiI+Qw1LoM720EPsSWREUjlPbIchJGD/irSddXrIlfE7zHnq0/
         T2xAx9trYLdpNDWiToBqB8O/3QgOsz53jC9w/iTeyxPVUpZyglnl12ouV9/1SJgZ19yP
         oLhOyC+TbxJ4y8OaAKha2xNoBMLLjInFzUtcrBRiZEN1X3ztcryQwAHNpNKSKj0xDIbU
         EtLzlQOThDYRZ6z2M731W89MjtYOiMxBL7mhhIPG0vX9yjB+2BHeZvHVO7zHfb7WMSBK
         eO1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=UOih8CBVKjn02CmrfoiIHS5zm6Wg61jRZNK4KLcmhAA=;
        fh=u2hUlUqWU9moIKsBTEAEs4NAXzeV/qWlJ3MUGd89JOM=;
        b=Cd0+Z8/22zVZy1+zem+vED/j7d3ZsaAH9ggfcUVKndPEkePxlkrk+KvKmH0me6fErX
         NBL+RUi1wrBnO+vtYPIftI2rNYByK957D0meBoRmbZw/yxwS67rcmEW2l+lNbwOkbNrL
         0iNUPeMhrWRuRPZ6qJw0AIwTZ9yzlXtBtnx1BBFZ+GLDvCllGTqfcBNFrG2EhcI0M0Tf
         +1BGH/a4LxiYsBqELzMKCM7ZANHDvb8WVVjXrZIfS2NgLdd+OPV7O3piC9uvkY3qhGDl
         x7TYl8Jj4CwyQBV3vNYFpHyX9N7M90OnmccuYht0VvtAlDlNaO6OYWr5MxF+mLbuC8fh
         83xA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785433586; x=1786038386; darn=lists.infradead.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UOih8CBVKjn02CmrfoiIHS5zm6Wg61jRZNK4KLcmhAA=;
        b=TQTzbD4K0yj3Xccl85H91rGMTmvuSoauhOLelwVVVEGDbidhy9yX2KhxwYbGKHZd+7
         N6qU+qt3VXebZ6RMY42RrrYBqYq+kPqDFBAPYXy/lNsiziVU28PhIh+iUAD75merJiQG
         HsCvQ3jka5jGNQNlmaM2I5MbbBkhN6kNFhuJfuebsCa4/5guAAfC/uGYK6rjPzToMLA1
         /cmeM2GjyQEtQg9gWFhkA/XSgNEY+/HY6uAJKgJyejptpags9WVWtX3bnUc5WSjLW4Pk
         T/ci8GZSoGyP0vLdNw/1FrphxCi1RZ/pi4SzpgHXoCbFzkKWOfzddgf/mZOCnCmTrQsO
         JCig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785433586; x=1786038386;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UOih8CBVKjn02CmrfoiIHS5zm6Wg61jRZNK4KLcmhAA=;
        b=XN6lToYZBolZV/U7ndKHgh4vtQ3WJZBOXDIg+01WtbGx5RSBY2eKvPxxGaqtqR2vn5
         oP09CNetyhl8/Ns+NNRG8k/yYAg5Ms/ExEFs69+ABmdgoeSw8kk1D67mdC1gtgmhmVqF
         mS7XsNjC6UJ7Sz5l8iAb9tcVwjecM2E9PawXMdZx7CuWkusap1/RkeCnxU3qN3G9GmGx
         EWqcd/FaHDUZkBfULGC/VfAFCqqh37vHY3jtfqFrAKjHVj4JZhcefELx76Hg9Zj+CgL1
         pG+dIAEqg/1gixbt8/Z9jtJ1djhQY+uu6ywTsTdMalZ2Djg8ewSpUoDQS43ZHuty1iPn
         +MvQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqc1llsrDC2zMfgTu+X9et0xrql5WTVVL5lsXPfZTFm5LZU9h/K9GQN41GSuUqR4jGI6ruocQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YxnrFs74ndZ+IvOAQtZV57FUOeHTYYWyz13qF1BdN1t+4PmzMW1
	pH4NdEVsaXTCZ2UExBqDDuhC293h76JpHh/H07Ao6cOOFE4ZeKPEAB0zM3b95o3iyBSGfAmAeqX
	T+Vn81lfb6rT/FsGOKoUjXOHpXHbLjtpUvr9I3HnQ
X-Gm-Gg: AR+sD12CdEkoWCk2ZvXT/IrADi7MiHx0tsa4E8qhTqH3ubI3uMKyvN9nETXiBAeBzPG
	gj9RpUHDcTdR4avR17bwtI0Yz8o7j5CUyCzHJR8mcn3eZ8QR6RLe8ZB1nkYIVozA8rLBO7wfj4j
	BtNnZtV57HR/mYyyFsYBwEYKVwaf8ratNSTJJ9iSGBN6BryVPX+POsFkKg7O6m+K4bzdAY115tL
	E6AFdKaBoxnx2nHjWhKNAszp5UZSVF9UZ6b8XfLt5miCJe2Tjk4wmF6QSvpe1jcqME9lz5VOJ3c
	Tw82ArGTGJg3jq8z+Ne3sfNf53W7wQbn+wZ/haCo+9WMkUgMm9eLxB870P1dPfDl+BCTkI7+gft
	bMQmCp1lEjuPrIB6WoPWBi2Oio0SYzspLow==
X-Received: by 2002:a05:6a21:e8b:b0:3bf:6ac8:8d29 with SMTP id
 adf61e73a8af0-3c9006bb981mr3748982637.21.1785433585760; Thu, 30 Jul 2026
 10:46:25 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 30 Jul 2026 10:46:24 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 30 Jul 2026 10:46:24 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260728121138.1103610-8-tarunsahu@google.com>
References: <20260728121138.1103610-1-tarunsahu@google.com> <20260728121138.1103610-8-tarunsahu@google.com>
MIME-Version: 1.0
Date: Thu, 30 Jul 2026 10:46:24 -0700
X-Gm-Features: AUfX_mxSA02wZmCDGZHkTAv1sqG45AQrWdNvcUlNspdo9IevcZmmfeKZDjs0tR8
Message-ID: <CAEvNRgHvBTKaG4G5J=sMFGYepEnOFaeCBtjkzN6xmGtZ+o6XxA@mail.gmail.com>
Subject: Re: [PATCH v4 07/11] KVM: guest_memfd: Add support for freezing mappings
To: Tarun Sahu <tarunsahu@google.com>, fuad.tabba@linux.dev, 
	Andrew Morton <akpm@linux-foundation.org>, seanjc@google.com, dmatlack@google.com, 
	Shuah Khan <skhan@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, david@redhat.com, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, sagis@google.com, 
	Paolo Bonzini <pbonzini@redhat.com>, Mike Rapoport <rppt@kernel.org>, Alexander Graf <graf@amazon.com>
Cc: linux-kselftest@vger.kernel.org, andre.przywara@arm.com, 
	michael.roth@amd.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	will@kernel.org, vannapurve@google.com, maz@kernel.org, fvdl@google.com, 
	kvm@vger.kernel.org, oliver.upton@linux.dev, kvmarm@lists.linux.dev, 
	alexandru.elisei@arm.com, skhawaja@google.com, aneesh.kumar@kernel.org, 
	linux-doc@vger.kernel.org, David Hildenbrand <david@kernel.org>, yan.y.zhao@intel.com, 
	kexec@lists.infradead.org, suzuki.poulose@arm.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260730_104627_410070_06A47269 
X-CRM114-Status: UNSURE (   7.18  )
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

Tarun Sahu <tarunsahu@google.com> writes:

> Introduce kvm_gmem_freeze() to freeze a guest_memfd inode's mapping,
> which prevents fallocate() operations and new page fault allocations
> during preservation.
>
> Use a global SRCU (`kvm_gmem_freeze_srcu`) to synchronize freeze state
> checkers without incurring per-fault locking overhead or risking per-CPU
> memory exhaustion (as per-CPU structure not counted in cgroup) from
> per-inode SRCU structures by faulty/compromised VMM.
>

I wonder if everything to do with freezing should be gated behind
CONFIG_LIVEUPDATE_GUEST_MEMFD. What do people think?

> Signed-off-by: Tarun Sahu <tarunsahu@google.com>
>
> [...snip...]
>

