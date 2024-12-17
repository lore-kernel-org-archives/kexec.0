Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17A92E7717F
	for <kexec@archiver.kernel.org>; Tue, 17 Dec 2024 12:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Hmju1iOLKKopVgXqpmGGz1rnfVBjAnp4yWxkW52/q7A=; b=iprJYeb1LzI2NWfVjKT5kuCIV/
	r3VqPaqkMRC6fY9hvyWbf1p9ynH/hzGz8AMpuhPb7kIFe3CQBSH74fdcM6iPZpgGOVAwasxUqcaDS
	1H9HrxWKvKTJmlJL4RXKjV90h0y7Z1+Huppeiujytz6TMq31Nl6aKAL8TPgN99Ux14pwV6GzSGueN
	hqGcZhT/LSBGKTAC1sQtf3b0jiOVSW/3prgh248g0ZghzZI84TQsF3Ife6UZXQlxJAWav3rxgFpZb
	UNx0huc2zypC8Dn+rGCDZQl2BBcu6PizZruUj8UdbSVo8y1UdrgVCfjhFQgVRCWDoDlBTfqQU6cSP
	4kVPM3Og==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tNWqy-0000000DPKz-2lgo;
	Tue, 17 Dec 2024 12:39:08 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNWqx-0000000DPKr-17Ag
	for kexec@bombadil.infradead.org;
	Tue, 17 Dec 2024 12:39:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=Hmju1iOLKKopVgXqpmGGz1rnfVBjAnp4yWxkW52/q7A=; b=KoYWFBPNKhf9S+KxTOkzRGkST2
	KfkIqDW5feg+r6JZDH7KRqzjKyOpLD6o+kKPCiRjQZgLkW7NKessOFMr4OmNg3zHW01CGwnAEzjBT
	F0OzBqcvKVMAh8CFxrWzB8S+W+HVtaAkV7kEw3yP9l3TvXtZxPO4X0eiaxLmCynuG0ePVrfj++hgB
	t3aDmtY2RvOOywtH0ocUupjUoNTt1pApDfD1GbQw5pY/O4jKFIWpUDTu4OGuY37/fGg9UGaATNJWV
	HC6FtZCWf8E9mH+D4KQMqli6rhdfzoPTgXMPW7kmg9X/l3cSHA5Tu4HjzhSOScqQybHRm6Pn1eycF
	dHHBiQng==;
Received: from [89.27.170.32] (helo=[127.0.0.1])
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tNWqr-000000054da-32wx;
	Tue, 17 Dec 2024 12:39:01 +0000
Date: Tue, 17 Dec 2024 13:39:01 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Eric Biederman <ebiederm@xmission.com>, David Woodhouse <dwmw@amazon.co.uk>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
 Yuntao Wang <ytcoode@gmail.com>, David Kaplan <david.kaplan@amd.com>,
 Tao Liu <ltao@redhat.com>, Kai Huang <kai.huang@intel.com>,
 Ard Biesheuvel <ardb@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Breno Leitao <leitao@debian.org>, Wei Yang <richard.weiyang@gmail.com>,
 Rong Xu <xur@google.com>,
 =?ISO-8859-1?Q?Thomas_Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
 linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
 Simon Horman <horms@kernel.org>, Dave Young <dyoung@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, bsz@amazon.de, nathan@kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_1/9=5D_x86/kexec=3A_Disable_glob?=
 =?US-ASCII?Q?al_pages_before_writing_to_control_page?=
User-Agent: K-9 Mail for Android
In-Reply-To: <tksesvqt266x6a6mnoi5aqa3fhsoyo7mbp277elrrft5eieoba@7ospdizq22y6>
References: <20241216233704.3208607-1-dwmw2@infradead.org> <20241216233704.3208607-2-dwmw2@infradead.org> <tksesvqt266x6a6mnoi5aqa3fhsoyo7mbp277elrrft5eieoba@7ospdizq22y6>
Message-ID: <D5246E62-F850-4869-8365-0399E0C1C82A@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html
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

On 17 December 2024 13:25:48 CET, "Kirill A=2E Shutemov" <kirill=2Eshutemov=
@linux=2Eintel=2Ecom> wrote:
>On Mon, Dec 16, 2024 at 11:24:08PM +0000, David Woodhouse wrote:
>> From: David Woodhouse <dwmw@amazon=2Eco=2Euk>
>>=20
>> The kernel switches to a new set of page tables during kexec=2E The glo=
bal
>> mappings (_PAGE_GLOBAL=3D=3D1) can remain in the TLB after this switch=
=2E This
>> is generally not a problem because the new page tables use a different
>> portion of the virtual address space than the normal kernel mappings=2E
>>=20
>> The critical exception to that generalisation (and the only mapping
>> which isn't an identity mapping) is the kexec control page itself =E2=
=80=94
>> which was ROX in the original kernel mapping, but should be RWX in the
>> new page tables=2E If there is a global TLB entry for that in its prior
>> read-only state, it definitely needs to be flushed before attempting to
>> write through that virtual mapping=2E
>>=20
>> It would be possible to just avoid writing to the virtual address of th=
e
>> page and defer all writes until they can be done through the identity
>> mapping=2E But there's no good reason to keep the old TLB entries aroun=
d,
>> as they can cause nothing but trouble=2E
>>=20
>> Clear the PGE bit in %cr4 early, before storing data in the control pag=
e=2E
>
>It worth noting that flipping CR4=2EPGE triggers TLB flush=2E I was not s=
ure
>if CR3 write is required to make it happen=2E


Well, until we flip to the new CR3 the read-only PTE can just get reloaded=
=2E But after CR4=2EPGE is cleared, of course they won't be global any more=
=2E So they will get flushed (again) when CR3 is reloaded=2E

Maybe it could run a tiny bit faster if we change CR3 before CR4? I don't =
know that we care about microbenchmarking kexec to that degree, but I may t=
ake a look=2E=2E=2E


