Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47F0BC35FFC
	for <kexec@archiver.kernel.org>; Tue, 25 Mar 2025 15:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DlSm/XJ+691y9WK83MK+K+VAhVyt9Uh+O14MYitCEMU=; b=ky2bQx5Fml5d6mOcjH/JP8UIix
	iPzwnQU+p5wmsX69+twQZmiNo0WOUoIhojymse855KvnsxqKoy+MNiFvTIraiLQR+PciRL8eLx5pX
	GA6GoJjGQaPWHzF1BqKmHYeVqxxYDdnVle1y3LgHkmnRatAq/0FncZzSnNoD1na01oZIjxf8C4KpK
	wIlBKOf4JkW0PFvq5ONJLatTDckuDATsyWRFW4k/B8rdXyosxw6wqSoZUhSCIFmwdGv+LfhOBCrae
	jf6K+xG46xwzqGWNbJkrqzla6t8S9048LnoiVJkOy/0sxtBiqr5ZBtCJxSuOJAY9pVkvTCqWSZXAW
	1s0jrRXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tx5pQ-00000006HJk-428n;
	Tue, 25 Mar 2025 15:04:32 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tx5pM-00000006HJB-49zp;
	Tue, 25 Mar 2025 15:04:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=DlSm/XJ+691y9WK83MK+K+VAhVyt9Uh+O14MYitCEMU=; b=MG3FMRdQ9KEwjCTKj0nAjeKnrQ
	/rhwAMjbQsLfUYBpqN+GQ562J1fOiT5RLll8cQ5fS6UME3kaFnpFYom+OwGa+x6jCooTilTeQwITp
	+80KN32y5Du6kmS828W6l+JzZfQHZGQHWrD2WYTPSQwxEdNp2QEPf2yDFzX5kkKlt1sAdRzckTl9r
	oFpwg/eOmm7rV+dC1hSx4L5y71CvyPfj3Nvh2Ll/4ezbchZin/G3+hADcdNEbdt7gUaIpdHn1k+ab
	fpnPpEtxd6qyY5rbrXxZaHHwOv0ws5FN0JqclXw3ZvLvu5dUF5pL5xRfSTwRQLnV740g6S8OoeyPP
	xqeEddDQ==;
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tx5ox-00000005XR2-2A34;
	Tue, 25 Mar 2025 15:04:14 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id CC9F55C5DD3;
	Tue, 25 Mar 2025 15:01:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1174BC4CEEE;
	Tue, 25 Mar 2025 15:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742915038;
	bh=DlSm/XJ+691y9WK83MK+K+VAhVyt9Uh+O14MYitCEMU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=pUrY9lz+D3qAxxjKU9sRrd3biaS0OmEhrrBkwmx4kPkTpUCMHpy/mzaWypb8rfZ4e
	 WLOGhPmrBt3fs8APit625QUMpFR+e16CpN6BEITDKRtEtwtexF6oaMn3wIkjYwgOeN
	 6FizHB25INbj95+5G1l44Aav81PK0heFxnEewIbWf7WuxLUokYDYAlKxW2nVNlvXo0
	 +ZLGoHASqyFS74gwKSkv05fI01LQ9Iii2kDieVumQb9V4b3kd16w0Zxcxjv9wGWtEc
	 lDYZMXceQTr71M7lM3D0LYTuesBJusjWuB+LWuX05PUAjv37EulHMnN5n7zgzuy3C2
	 93XGDsyQIeifg==
Date: Tue, 25 Mar 2025 11:03:21 -0400
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>,
 Changyuan Lyu <changyuanl@google.com>
CC: linux-kernel@vger.kernel.org, graf@amazon.com, akpm@linux-foundation.org,
 luto@kernel.org, anthony.yznaga@oracle.com, arnd@arndb.de,
 ashish.kalra@amd.com, benh@kernel.crashing.org, bp@alien8.de,
 catalin.marinas@arm.com, dave.hansen@linux.intel.com, dwmw2@infradead.org,
 ebiederm@xmission.com, mingo@redhat.com, jgowans@amazon.com, corbet@lwn.net,
 krzk@kernel.org, mark.rutland@arm.com, pbonzini@redhat.com, hpa@zytor.com,
 peterz@infradead.org, ptyadav@amazon.de, robh+dt@kernel.org, robh@kernel.org,
 saravanak@google.com, skinsburskii@linux.microsoft.com, rostedt@goodmis.org,
 tglx@linutronix.de, thomas.lendacky@amd.com, usama.arif@bytedance.com,
 will@kernel.org, devicetree@vger.kernel.org, kexec@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v5 00/16] kexec: introduce Kexec HandOver (KHO)
User-Agent: K-9 Mail for Android
In-Reply-To: <CA+CK2bDtBk=49hbz+C=fDswz_Nbtj8kVjsY-pTsmBt+O8YPLmg@mail.gmail.com>
References: <20250320015551.2157511-1-changyuanl@google.com> <CA+CK2bDtBk=49hbz+C=fDswz_Nbtj8kVjsY-pTsmBt+O8YPLmg@mail.gmail.com>
Message-ID: <01864D3D-C935-4AA6-85A9-363B14EA5443@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250325_150406_087809_1BA852D3 
X-CRM114-Status: GOOD (  10.71  )
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



On March 25, 2025 10:19:53 AM EDT, Pasha Tatashin <pasha=2Etatashin@soleen=
=2Ecom> wrote:
>> To use the code, please boot the kernel with the "kho=3Don" command lin=
e
>> parameter=2E
>> KHO will automatically create scratch regions=2E If you want to set the
>> scratch size explicitly you can use "kho_scratch=3D" command line param=
eter=2E
>> For instance, "kho_scratch=3D16M,512M,256M" will reserve a 16 MiB low
>> memory scratch area, a 512 MiB global scratch region, and 256 MiB
>> per NUMA node scratch regions on boot=2E
>
>kho_scratch=3D is confusing=2E It should be renamed to what this memory
>actually represents, which is memory that cannot be preserved by KHO=2E
>
>I suggest renaming all references to "scratch" and this parameter to:
>
>kho_nopersistent=3D or kho_nopreserve=3D

I'm leaning towards kho_bootstrap

>This way, we can also add checks that early allocations done by the
>kernel in this memory do not get preserved=2E We can also add checks to
>ensure that scarce low DMA memory does not get preserved across
>reboots, and we avoid adding fragmentation to that region=2E
>
>Pasha
>

--=20
Sincerely yours,
Mike

