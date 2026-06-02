Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4946CD5BD1
	for <kexec@archiver.kernel.org>; Tue,  2 Jun 2026 17:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BRv5wqV7d5ThaVx6PFMHAXzziIsNyXnz2a/5mWnlXNY=; b=zXAuuzqQsMgB2QkR4MkpeGtbBi
	ALlo13L/aI8YGnI3ax/ROXGWDXu5TSVtYT5Q5LOwto2VLF6+DHhUhIS/IhPwLepjYQUabbuHv5kFq
	2OGrExBR2NlPAkosihqxd544qvQUGSSIiVeJIuTmrV8GzEPJQ3+FEp7AoOw6v2Qm0uOFJAiDsC8kV
	oPvXrdEItln8nrxRwxGDFq3D/B0M59ziWUDCv2NPDc1V+1DYF+Lp/HyN6xmjWEJFGP16fd5dhEQMX
	bolUj1aEodLKvFKWl0vpjn5Vau5P45/FGR5rOF1Ss3thC/zi/JQAtfcYg8lbyBhH7/KAIR1+UzW9i
	N9vfRi5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUSc0-0000000DY9Q-3OsL;
	Tue, 02 Jun 2026 17:09:08 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUSby-0000000DY8o-2izq
	for kexec@lists.infradead.org;
	Tue, 02 Jun 2026 17:09:07 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 3CE6143E3B;
	Tue,  2 Jun 2026 17:09:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC01E1F00893;
	Tue,  2 Jun 2026 17:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780420146;
	bh=BRv5wqV7d5ThaVx6PFMHAXzziIsNyXnz2a/5mWnlXNY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=dYU/G6bjFW/SvwsoB8Fox13WuOwWByQF38mc9908oJll8d3LF82iDed3Mp8B0LMBT
	 3IHRQPcn2JcFzJBp/WWHWqiQEnlZnBeun2NzG1u6zgaAoQTMiSxmHAdIeENbMQj4bP
	 6RIafSAw4DLXs8SeJSFtoD9qJv4Sypq9Ip7PlRS90P6/trIMkwseDtjtLihNoGleQE
	 zkLbgRGGAZYanQ6AsFak9ZrJzRP7s4DJSpC6MmAmULyI8mqUhw2bz2RiKvBx4AnTJD
	 O+eGyE63NoUBPBKAD1KLjWogkh8Q4kmNWhf8BzB9XGzKDHouxqtXN9qgyF+h8y4JzR
	 OGhE6xUJtlB7A==
From: Pratyush Yadav <pratyush@kernel.org>
To: =?utf-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  Baoquan He <bhe@redhat.com>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  Mike Rapoport <rppt@kernel.org>,
  kexec@lists.infradead.org
Subject: Re: [PATCH] kho: try to allocate contiguous memory for kexec segments
In-Reply-To: <CAAi7L5fDmbXgvZunn6hq2GoZqFGZ-YdJtgmSLD6pa06baF-KCQ@mail.gmail.com>
	(=?utf-8?Q?=22Micha=C5=82_C=C5=82api=C5=84ski=22's?= message of "Tue, 2 Jun
 2026 19:08:09 +0200")
References: <20260601193014.896405-1-mclapinski@google.com>
	<2vxz4ijkev5f.fsf@kernel.org>
	<CAAi7L5fDmbXgvZunn6hq2GoZqFGZ-YdJtgmSLD6pa06baF-KCQ@mail.gmail.com>
Date: Tue, 02 Jun 2026 19:09:03 +0200
Message-ID: <2vxzjysgdg40.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260602_100906_707281_FDE4AC0E 
X-CRM114-Status: GOOD (  13.57  )
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

On Tue, Jun 02 2026, Micha=C5=82 C=C5=82api=C5=84ski wrote:

> On Tue, Jun 2, 2026 at 6:58=E2=80=AFPM Pratyush Yadav <pratyush@kernel.or=
g> wrote:
>>
>> On Mon, Jun 01 2026, Michal Clapinski wrote:
>>
>> > This allows us to skip relocations (and maybe checksum calculation
>> > in the future).
>>
>> I'm confused. Doesn't your patch "kexec_file: skip checksum verification
>> when safe" [0] skip the checksum for KHO already? So this only skips the
>> relocations part then?
>>
>> And based on the discussion on that thread, relocations don't seem to
>> take much time. So is there a real need for this patch?
>
> I sent this patch out yesterday, then realized it wasn't going to work
> so I abandoned this approach.
> Today I sent patch [0] that skips the checksum for KHO, so this patch
> is no longer needed.

Makes sense, thanks for clarifying.

[...]

--=20
Regards,
Pratyush Yadav

