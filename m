Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51D3FCD6E57
	for <kexec@archiver.kernel.org>; Wed,  3 Jun 2026 14:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3JBFLHHchSf6Ugt56GZlS5cZe18tTPuP1JId2xHEinc=; b=mrDlj23f2ZW1FJYw3ipPlUJfYr
	7eQRzyPROueub5c16eFCRFhz8E+7c3i0v6TVm8bA2BSPinw90KtyPa19bkGxd8NTK6D0X9G2h4KPV
	A0KFIVR7asr6a7PTNFoO81BC5wVNSI3bhQws3Ucxpmc5GP/C0LVMew2kzy2t/O8U7QYIwKQeuUbnP
	geRsrNMeuarnlgVwm0Ln55+r5AKuSG8MD/xbrqCwFfKOlayQqBopZMkDf6D1AO4m+K0Z16YnMR/yq
	1awazaSvrtRyRt2zNTQOBqfoaekfgYcZ4a5y+My3prGp46NeGCF7bKHcbsFokND9KT8g7e7/E9gdD
	VhQ+3Z+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUmJl-0000000FE2O-2Zjs;
	Wed, 03 Jun 2026 14:11:37 +0000
Received: from mail-qk1-x736.google.com ([2607:f8b0:4864:20::736])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUmJi-0000000FE1r-2eP8
	for kexec@lists.infradead.org;
	Wed, 03 Jun 2026 14:11:35 +0000
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-915906a4becso71566685a.2
        for <kexec@lists.infradead.org>; Wed, 03 Jun 2026 07:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1780495893; x=1781100693; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3JBFLHHchSf6Ugt56GZlS5cZe18tTPuP1JId2xHEinc=;
        b=WGa/qTKCg/JRVAKOwYnL6OiWb7Sv1hz9BWk3I3dc0oefiVWTr2np5IRuWoVN3Z1TGy
         hitfx3cpbd+2bFLyEd4Nz//2PVCs7ouzaP6jIQnUo3weZQVV1B302bnHlZJEgh71RPmU
         ECK2uvnjCBBtupTNah/y8zZdfNEn/rQRwSlRqVGT859mKIgP8ZzWMMbK6TfZ5XXMKjck
         3kIyTBLWzYloZw9ug46kVn4f1cZNar+Mwv6bOs/asz9TASQRESFwzDMGmA0B8cRLmnCp
         H9f/DErGa4MV4RIseTXj5zS8n7U+abkt+Unu7XcYGINCeCpYX2R+f3Qcokvsoi9J1Gyp
         y8Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780495893; x=1781100693;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3JBFLHHchSf6Ugt56GZlS5cZe18tTPuP1JId2xHEinc=;
        b=gyA1KgJUyZ0E/I1KplL5YdjDshZiPhq9G6VKlDJ5aAlUxNqEXtL/ZEkEWO83cdCoce
         psSLYUlsOrUUYV10WK9E/f7XXODONZwcp8QUyUjMArpSWJ06C5crNwXHOheIhWLclljV
         haCc4JxIHuk8ADIkVIM+DXAJk+trZnS8ljU3mLHCXVHI7whfxPK5XCd2EE+VfZBidchQ
         a+QrM4nRGwe+GiMVNEzNblliXzyA2wMuXtpOF1FoGrKOmdGln6VqGYuPS2abkC8kC5ih
         zoEfLjQhpv7O/GnBpvAbbsyrXsl+S0/yb+T0G6jQalhi+2Q/RHYH3G+lClvCq6f9/R8E
         0vaA==
X-Forwarded-Encrypted: i=1; AFNElJ+H3BLzKIzfMml0WVsoxzxK99nt2NE1/Zf4binSgJJqxoMJmtKyxXSZrMiLkcbq1aY/xCzr6w==@lists.infradead.org
X-Gm-Message-State: AOJu0YylQyVnH2e1Ndvvqh01wWXpllfyrF413rkon2dafAYJ02XaYQVx
	IPV3utvEJcC2YoyxekR2gsTMQHkXFQE5qJHeFoWv3A8aGeeDNbIOi8Xq1TKiUmJB/bY=
X-Gm-Gg: Acq92OEhm1Ool+0F6TWQV9uq3E5e6+4w8GJnho+2ib/I3EvOmes/7qiYvYCrXUNiX2l
	ibwWhUhNSUdQUGP8Gv5ujM3wgAEdBWbsQYejW4koXrM6SEPm1JFBy12DdNIEuSBTtFAEIa4+hFD
	vlhWB1znHf9aRYuY14GJqrJh7W3f3Q/QbR982swRf3NrSXjYOfbcBEvdrXILpMtDsjy1xMWLjr9
	w/EoI9/MIdmyVDgzg2C6RFTmscuFXoCF/s9vWjJ7mR+pWlWOo9Eajx7zZhPGBCz2HF04/mL+fiw
	b4h4Y+5uYACWwUBFKmIgYGdK1YgAQYdO88vTOWKEvV82+x0BppsrIkGuvrgUhTWbfaRmw5px76h
	ulVAOEoJ2PM3LBvEV99Ew87+O+wJ/G/Tc4Xn3n0OqHN+OYRGmpB6ko5QUNAbqz2t6NaelotUKIg
	TvI1DB3zsCpPQKooW2mjIhjHFWv2X9UGD+HwkRnpe8mYlCiXyXcITYkK7mgvzjyQ==
X-Received: by 2002:a05:620a:4613:b0:915:4ca3:61bd with SMTP id af79cd13be357-9158a83f992mr602997485a.59.1780495893289;
        Wed, 03 Jun 2026 07:11:33 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a402ff9sm248774285a.45.2026.06.03.07.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 07:11:32 -0700 (PDT)
Date: Wed, 3 Jun 2026 14:11:31 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, 
	linux-kselftest@vger.kernel.org, shuah@kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org, 
	skhan@linuxfoundation.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	corbet@lwn.net, dmatlack@google.com, kexec@lists.infradead.org, 
	pratyush@kernel.org, skhawaja@google.com, graf@amazon.com
Subject: Re: [PATCH v6 07/13] kho: add support for linked-block serialization
Message-ID: <aiA1slnqPnC4_8XY@plex>
References: <20260603032905.344462-1-pasha.tatashin@soleen.com>
 <20260603032905.344462-8-pasha.tatashin@soleen.com>
 <178046937151.468621.13398573538792303093.b4-review@b4>
 <aiANtYRRDr5iO5QR@plex>
 <aiAzT9TvGYjITiB8@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiAzT9TvGYjITiB8@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260603_071134_687101_6DF147DF 
X-CRM114-Status: GOOD (  23.46  )
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

On 06-03 16:59, Mike Rapoport wrote:
> On Wed, Jun 03, 2026 at 12:05:04PM +0000, Pasha Tatashin wrote:
> > On 06-03 09:49, Mike Rapoport wrote:
> > > On Wed, 03 Jun 2026 03:28:58 +0000, Pasha Tatashin <pasha.tatashin@soleen.com> wrote:
> > > > diff --git a/include/linux/kho/abi/block.h b/include/linux/kho/abi/block.h
> > > > new file mode 100644
> > > > index 000000000000..8641c20b379b
> > > > --- /dev/null
> > > > +++ b/include/linux/kho/abi/block.h
> > > > @@ -0,0 +1,56 @@
> > > > [ ... skip 25 lines ... ]
> > > > +#define _LINUX_KHO_ABI_BLOCK_H
> > > > +
> > > > +#include <asm/page.h>
> > > > +#include <linux/types.h>
> > > > +
> > > > +#define KHO_BLOCK_ABI_COMPATIBLE	"kho-block-v1"
> > > 
> > > It's never used by block set and after looking at the following patches I
> > > found that it's appended to LUO compatible string.
> > > 
> > > While this works for LUO, I think it should be kho_block_set_restore()
> > > responsibility to verify the compatibility.
> > 
> > It should work for any component that relies on  kho_block. My proposal 
> > is to use this method for other common KHO data structures (e.g.,  kho 
> > vmalloc,  kho radix, future kho xarray). There is no need for them to 
> > carry the compatibility string in their metadata, as whoever uses them 
> > will include their compatibility string.
> 
> So if, say, memfd_luo uses kho vmalloc, xarray and blocks it'll have five
> compatibility strings glued together?

That is correct, but it will be in only one place: the header of the 
client's KHO subtree. Since it is dynamically sized and 8-byte aligned, 
it should be safe to include in any struct.

Pasha

>  
> > For now, reviewers will have to make sure that if the ABI header content 
> > is changed, the compatibility string is updated.
> 
> -- 
> Sincerely yours,
> Mike.

