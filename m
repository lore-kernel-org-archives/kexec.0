Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D03E2C43458
	for <kexec@archiver.kernel.org>; Wed,  8 Jul 2026 00:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Fwb6T7QVdGDxs2wP5yfln48hkZneD+IuZNOtsCtvSik=; b=h7f5dT1EmIJq/0GW7b21Mv3sA0
	JmkB4T4mOUWlm0eh4HLYIjiTmNOhy4nxdz6k8fUt++/iiOXVUGKVPOIyM8CtO50CYWMfPv3v4d0ni
	0C7BjVn+dZV3/QsCxQSxlcnHUxJE5vIZVleZSiZnYQtS8dsgoRwgxyuVqvaVAMU7XljXvzSakD/OC
	HVpSAhqTOWQ9xvt+nB0WlNv73kZ26UsEOB7hHTjKWHD1rTgj6Mh7KDZolHpQQmfhWNGmb8I5n8rha
	xRNULjNSN9oEvPmIFtvVIIXBuaJHJtlIk1VGvFqhkWATTIRgsbtEV079dUjFCbuvvKXPKbt2et/Eb
	SiIT8sqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whG56-0000000G3OT-0yow;
	Wed, 08 Jul 2026 00:24:04 +0000
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whG53-0000000G3O5-368N
	for kexec@lists.infradead.org;
	Wed, 08 Jul 2026 00:24:02 +0000
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-2cacef7d299so20835ad.1
        for <kexec@lists.infradead.org>; Tue, 07 Jul 2026 17:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783470240; x=1784075040; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Fwb6T7QVdGDxs2wP5yfln48hkZneD+IuZNOtsCtvSik=;
        b=Ibp0gh3fgm80NW7Fb81jdribWoh8CD3dhE5ivVe0+8CXOywQTLyDI61UpJZ+gmgXny
         ykUKdhjdpljVMT65piKj8L9f5uGtJfzbKMUE8wqacKSyZopuzqaNgZd06Xz1+iehnLtk
         Vx2moB5DSFW4y9EnfkwfGG892L14OMNfmAwGabOF2YPQmrQvq1cl89eDCykRz/Ino5RF
         E9wjweLKMjZouQH18s2BLZKsIDi/KIRfbi2ArBRlFmYs3vTCRBfia/HtyUayGY27OwG+
         pFv9eLXR/EpcScwr9Yb6QSMvizKhF8IieGkKLWGoWU4UrIPzQB4rc5fMmRhwXi+HJvFh
         mOfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783470240; x=1784075040;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fwb6T7QVdGDxs2wP5yfln48hkZneD+IuZNOtsCtvSik=;
        b=tTwpFUbFt+jfJ2hu/STmFypwrQuZnZElHheL5+6KCHv2SmMV99vXB+VZNHZ1x9LcqQ
         7kpfgMNi/m1JFsCFk3J383EaSMoU0jXxnW9M4JiBdflbtyglhyj7EMv7D/WeNBVIQAFo
         JTmI/ez31sJ0bnRZaRcvycmGx3ejnd+apeagTcLqaTCk56wJfVPmjeDDl9tnyVPkOotR
         O65A+Lx1mpmHeaIpvTEsYF91Isq2xJHdH/RlPP94cwJRdIlkfW+ls3RJAc9iYZLgpCUZ
         XDJtmiN+DpzN4cSivuU1KNOwZdtFahGKIgY4MN38kcveMnrUdAEBi9TmEwe+w51WLcXR
         efzg==
X-Forwarded-Encrypted: i=1; AHgh+Rp5Aon73tlMmPPVuxhplvjzyaFPEVE1GHWo6eVk2918JhmmVTR29kRlbotlkMAeRNWAFhYJ+A==@lists.infradead.org
X-Gm-Message-State: AOJu0YzDgd9R+qSEfnd4DFtboNghBsP9PACsGxhkLJduJDxoA9jJ8g9Q
	wvj2Rst+wiGx3PUon0y9303EAg0PMinGkluQzYFEIiQqNc/eXeJRDA9ByDz2zccmsg==
X-Gm-Gg: AfdE7cmKXjb6lK8Wbbyy5Oi05VUS5Gu5QvensG7tj91RAnKzPNiSdBo4uLINzoT9MA4
	08w9pAUoofJEZfKI+jaZPraq6ufk7hO+JKM/ZDMJXpwC8ruBWHYuiYBGcaQctygtnJxmQbi4j9n
	V5Z+gW9Q/6hZfja1NTTeI3fdL3mQbxbBktV0atxYW/t1in9kfngh3ivVqeOigPDuLrLbwPBYxwH
	T1WzS2sRBNWkxb6CTsVyFSzlDV7dLdZ+i4sgNCWMU1SMxLZZ4j2XeDj+U5eqRw8WnlVUN0cHh5O
	VCQnyoi2Ftn9rsi/y+MKwr5VDNnqLdksSGfTeEMcR3S/YKM1kOrOY3VUlOKn2CNzsW24/xy99O8
	KLoAWtJNqQmz3xINC0kaZo8ceGBD8S5a/9Ixh7UtxdZ/PxIJSnyGp1sx5hqzXuDiej28yuQJMeM
	ZdWeTjVyhr0York8Zz+1EvRhAGIOCdSvxX9etsuG5w6WgLGD8ICFjc4GaM0vf3/md/G2snG25Or
	s8uarq/Dxk=
X-Received: by 2002:a17:902:d589:b0:2bf:3579:cdaa with SMTP id d9443c01a7336-2ccc9c2d137mr5761425ad.10.1783470239360;
        Tue, 07 Jul 2026 17:23:59 -0700 (PDT)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6dd9237sm6303930b3a.59.2026.07.07.17.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 17:23:58 -0700 (PDT)
Date: Wed, 8 Jul 2026 00:23:55 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pranjal Shrivastava <praan@google.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Alexander Graf <graf@amazon.com>, David Matlack <dmatlack@google.com>, kexec@lists.infradead.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 4/4] kho: Introduce kho_split_preserved_pages() helper
Message-ID: <ak2YXFNGvCGo4oz6@google.com>
References: <20260703020832.1731864-1-praan@google.com>
 <20260703020832.1731864-5-praan@google.com>
 <178341290877.3292146.993563652569119942.b4-review@b4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <178341290877.3292146.993563652569119942.b4-review@b4>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260707_172401_831063_B814BD66 
X-CRM114-Status: GOOD (  13.60  )
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

On Tue, Jul 07, 2026 at 11:28:28AM +0300, Mike Rapoport wrote:
>> A driver may need to split a high-order allocation that has already
>> been preserved. If the pages are split using split_page() manually,
>
>Why?
>Are there particular examples?
>
>> the refcounts would change but KHO won't record the change in the
>> preserved page-type, resulting in a metadata mismatch during
>> restoration in the new kernel.
>>
>> Introduce kho_split_preserved_pages() to handle splitting of preserved
>> pages. The helper follows an unpreserve -> split -> re-preserve sequence,
>> while ensuring that the KHO radix tree is updated with the correct
>> KHO_PAGE_SPLIT type bits.
>>
>> The helper returns 0 on success, or a negative error code if the
>> re-preservation fails. Callers must ensure the provided order matches
>> the original allocation and that the operation is serialized against
>> other preservation API calls.
>
>Let's put this on hold until there are actual users.

+1

I think we discussed in this in one of the hypervisor liveudpate meeting
sessions and it was concluded that the split of preseved pages is not
needed.
>
>-- 
>Sincerely yours,
>Mike.
>

