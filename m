Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B8BEC5B56A
	for <kexec@archiver.kernel.org>; Tue, 11 Aug 2026 14:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xDhehgrrAOSRIdcwgmYMsgv1I5rPT085cxMqoCOwSbU=; b=mqrVZ2+mme78sILi+2YN0s8DYS
	chWWoSE+UL/HSISVFXenS4hSAG58D7ITztmivZE38bK0opGK+MVLyC5Q3s+rbmd8RboLa/I9uC3L/
	bsR51ehsgv0SiS5KDgZKGTcXWtkYaexwsMU67rrdzZ8dhBDos+bjNJwIzXhdNrGgEGAEXJ058pyn9
	0KfSCmln+04lwdj+G4FJ3TJywzoaV92RO08Bx0ONE5OgmQ5H0IO3Wqm1MdZMs4rwR8iILJKP337U+
	n/S0CuPuP/IwMbsWmQuxJKjH97ltjGFxudf5jZ1Ixm/1BbKgpGVm9pZlkZRPaTvIFm+VeVUM8ixsf
	sESv8DfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtnpx-0000000EFnp-1yI3;
	Tue, 11 Aug 2026 14:52:17 +0000
Received: from shelob.surriel.com ([96.67.55.147])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtnpv-0000000EFme-1KNy
	for kexec@lists.infradead.org;
	Tue, 11 Aug 2026 14:52:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=surriel.com
	; s=mail; h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=xDhehgrrAOSRIdcwgmYMsgv1I5rPT085cxMqoCOwSbU=; b=V8GSuDwqveAqI2bqQieqG7EtHg
	eEEnasEdiZliXbP7agGL3h0BTexorRppTEp1vvgcYKNWcQPKxAE+aj6r2kqxu5qt/dCIkReEDkGfk
	Mv39k2CrHgvirJviGuUmpI0rl5In8PV6s/MzvXA6w407ZEF8rImshyHYqTLstwADLO15oulaVOYpa
	k/2Al6fKhV2KN5Y9uc3ST9gqZoUbA7TVvF12pppLqhZxWWIgV8niqXkX3KZ33dryOP8retFs8ljAi
	lD12KJ6b9+T+lsWTYBB9iUdCmdJ1ZXHmnk8KqQEI7u/mrZLS3tcxSF9fzosVw2ITsHnrk/QfPc4Es
	IfcuYK0Q==;
Received: from [96.67.55.146]
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@surriel.com>)
	id 1wtnp0-000000001Gy-1SI4;
	Tue, 11 Aug 2026 10:51:18 -0400
Message-ID: <b04cad808d5dc2a799c363b43a18e9cab18005f5.camel@surriel.com>
Subject: Re: [PATCH v5] kexec: keep the next kernel off hardware-poisoned
 pages
From: Rik van Riel <riel@surriel.com>
To: Kiryl Shutsemau <kas@kernel.org>, Mike Rapoport <rppt@kernel.org>
Cc: Breno Leitao <leitao@debian.org>, Andrew Morton
 <akpm@linux-foundation.org>,  David Hildenbrand	 <david@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett"	 <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, Suren Baghdasaryan	
 <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Baoquan He	
 <baoquan.he@linux.dev>, Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>, Miaohe Lin <linmiaohe@huawei.com>,
 Naoya Horiguchi	 <nao.horiguchi@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, 	kexec@lists.infradead.org, rmikey@meta.com,
 kernel-team@meta.com
Date: Tue, 11 Aug 2026 10:51:18 -0400
In-Reply-To: <ansuaOyItxGTBlTl@thinkstation>
References: <20260810-kexec_posioned-v5-1-95e1b5e2e656@debian.org>
	 <ann9Kcesyb4T9Z8b@kernel.org> <anr59P1ZCAuHxv6x@gmail.com>
	 <anskyrEVUlnTVEgF@kernel.org> <ansuaOyItxGTBlTl@thinkstation>
Autocrypt: addr=riel@surriel.com; prefer-encrypt=mutual;
 keydata=mQENBFIt3aUBCADCK0LicyCYyMa0E1lodCDUBf6G+6C5UXKG1jEYwQu49cc/gUBTTk33A
 eo2hjn4JinVaPF3zfZprnKMEGGv4dHvEOCPWiNhlz5RtqH3SKJllq2dpeMS9RqbMvDA36rlJIIo47
 Z/nl6IA8MDhSqyqdnTY8z7LnQHqq16jAqwo7Ll9qALXz4yG1ZdSCmo80VPetBZZPw7WMjo+1hByv/
 lvdFnLfiQ52tayuuC1r9x2qZ/SYWd2M4p/f5CLmvG9UcnkbYFsKWz8bwOBWKg1PQcaYHLx06sHGdY
 dIDaeVvkIfMFwAprSo5EFU+aes2VB2ZjugOTbkkW2aPSWTRsBhPHhV6dABEBAAG0HlJpayB2YW4gU
 mllbCA8cmllbEByZWRoYXQuY29tPokBHwQwAQIACQUCW5LcVgIdIAAKCRDOed6ShMTeg05SB/986o
 gEgdq4byrtaBQKFg5LWfd8e+h+QzLOg/T8mSS3dJzFXe5JBOfvYg7Bj47xXi9I5sM+I9Lu9+1XVb/
 r2rGJrU1DwA09TnmyFtK76bgMF0sBEh1ECILYNQTEIemzNFwOWLZZlEhZFRJsZyX+mtEp/WQIygHV
 WjwuP69VJw+fPQvLOGn4j8W9QXuvhha7u1QJ7mYx4dLGHrZlHdwDsqpvWsW+3rsIqs1BBe5/Itz9o
 6y9gLNtQzwmSDioV8KhF85VmYInslhv5tUtMEppfdTLyX4SUKh8ftNIVmH9mXyRCZclSoa6IMd635
 Jq1Pj2/Lp64tOzSvN5Y9zaiCc5FucXtB9SaWsgdmFuIFJpZWwgPHJpZWxAc3VycmllbC5jb20+iQE
 +BBMBAgAoBQJSLd2lAhsjBQkSzAMABgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRDOed6ShMTe
 g4PpB/0ZivKYFt0LaB22ssWUrBoeNWCP1NY/lkq2QbPhR3agLB7ZXI97PF2z/5QD9Fuy/FD/jddPx
 KRTvFCtHcEzTOcFjBmf52uqgt3U40H9GM++0IM0yHusd9EzlaWsbp09vsAV2DwdqS69x9RPbvE/Ne
 fO5subhocH76okcF/aQiQ+oj2j6LJZGBJBVigOHg+4zyzdDgKM+jp0bvDI51KQ4XfxV593OhvkS3z
 3FPx0CE7l62WhWrieHyBblqvkTYgJ6dq4bsYpqxxGJOkQ47WpEUx6onH+rImWmPJbSYGhwBzTo0Mm
 G1Nb1qGPG+mTrSmJjDRxrwf1zjmYqQreWVSFEt26tBpSaWsgdmFuIFJpZWwgPHJpZWxAZmIuY29tP
 okBPgQTAQIAKAUCW5LbiAIbIwUJEswDAAYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQznneko
 TE3oOUEQgAsrGxjTC1bGtZyuvyQPcXclap11Ogib6rQywGYu6/Mnkbd6hbyY3wpdyQii/cas2S44N
 cQj8HkGv91JLVE24/Wt0gITPCH3rLVJJDGQxprHTVDs1t1RAbsbp0XTksZPCNWDGYIBo2aHDwErhI
 omYQ0Xluo1WBtH/UmHgirHvclsou1Ks9jyTxiPyUKRfae7GNOFiX99+ZlB27P3t8CjtSO831Ij0Ip
 QrfooZ21YVlUKw0Wy6Ll8EyefyrEYSh8KTm8dQj4O7xxvdg865TLeLpho5PwDRF+/mR3qi8CdGbkE
 c4pYZQO8UDXUN4S+pe0aTeTqlYw8rRHWF9TnvtpcNzZw==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260811_075215_357550_1C9C0ED3 
X-CRM114-Status: GOOD (  12.07  )
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

On Tue, 2026-08-11 at 15:21 +0100, Kiryl Shutsemau wrote:
> On Tue, Aug 11, 2026 at 04:34:02PM +0300, Mike Rapoport wrote:
> > On Tue, Aug 11, 2026 at 04:17:41AM -0700, Breno Leitao wrote:
> > > > >=20
> > > But I honestly don't have a strong opinion here, though, happy to
> > > batch
> > > it if you prefer. Would this one look better?:
> > >=20
> > > 	if (!(pfn % MAX_ORDER_NR_PAGES))
> > > 		cond_resched();
> >=20
> > Can't say I know the magic number here, but I think it's better to
> > batch.
>=20
> Hm. I thought cond_resched() deal with this internally, no?
>=20
> We call it in pretty tight loops, like clear_contig_highpages() or
> copy_folio_from_user().
>=20
> I think adding external batching might be a bad move.
>=20
cond_resched() should be really cheap, indeed.

It gets compiled out completely with PREEMPT_LAZY
or PREEMPT_FULL.

--=20
All Rights Reversed.

