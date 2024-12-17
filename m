Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC35AE7716A
	for <kexec@archiver.kernel.org>; Tue, 17 Dec 2024 10:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fc4wn50i60mq+Dm0Qh6J/tmpBTHkS57i6cRyHCynELE=; b=KOg0NKd8N3QKkJcmQHqCyKw1yb
	5nLB8PjIE7JSzdZvCbpXv4IlVAM2H1szNZfz62n5ExlDy405YxDft7/tdWsoEN9BDvDuF+wt0/DVf
	cgf9Jbl/i3GNBkaydJEDU2rqoh2o9+DQXocOgHdRrXswWWP0Gz5gtsrWCI71B27MwBZXtwiz3aVi3
	cGUMYIhwccmbyhp06DesLM6oRCMb6Sox2iEpk2ICYFWyzqv0pSDQT84WYfC8pc8t3gQKfvHqsM1Bo
	3Gt15TYkeJ5tqibZDpOeranmzqcNEPh53sDDoix3T+82Sdeqaii3VKcStSHPhleZH0SRvLO07Cirk
	RlNdRcug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tNUq3-0000000D7ZO-1fB8;
	Tue, 17 Dec 2024 10:30:03 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNUq1-0000000D7Yv-2PmW
	for kexec@bombadil.infradead.org;
	Tue, 17 Dec 2024 10:30:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=fc4wn50i60mq+Dm0Qh6J/tmpBTHkS57i6cRyHCynELE=; b=Xzz/dgxylPHf8RPZ5bh9svZ0Le
	5cFy2EKzJsc9D9VEO86o3bs4MNTQSUdEtSHCy7QeUw4N/IlUoE8aXqdbYv/owP149oV6I8HJwUu7E
	9HWThw//PWRvlMNFOtpEaUtJKbGs6v58dg0bt1kntfZ0WF4p20R7ovFKSFkTws3VYZBmAtpX7o/pb
	8lGxxOZV+P+ikiVn7oDJVxU6oBDHZsqaSh5de0u8VQ/9t4CenjKiD+LXvYnvDUUFqLFKKCiHt2mRw
	fAWdfISPSiH/qYCBMaiTRYB+nwzS0GBrEoPfX5nE4qmuIkVwp5kts5fqIUVF6wnKYaKGuGfei9cML
	TQmIyi+g==;
Received: from [89.27.170.32] (helo=[127.0.0.1])
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tNUpw-000000053l0-3r0J;
	Tue, 17 Dec 2024 10:29:57 +0000
Date: Tue, 17 Dec 2024 11:29:56 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: Ard Biesheuvel <ardb@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Eric Biederman <ebiederm@xmission.com>, David Woodhouse <dwmw@amazon.co.uk>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
 Yuntao Wang <ytcoode@gmail.com>, David Kaplan <david.kaplan@amd.com>,
 Tao Liu <ltao@redhat.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Kai Huang <kai.huang@intel.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Breno Leitao <leitao@debian.org>, Wei Yang <richard.weiyang@gmail.com>,
 Rong Xu <xur@google.com>,
 =?ISO-8859-1?Q?Thomas_Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
 linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
 Simon Horman <horms@kernel.org>, Dave Young <dyoung@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, bsz@amazon.de, nathan@kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_9/9=5D_x86/kexec=3A_Use_typedef_f?=
 =?US-ASCII?Q?or_relocate=5Fkernel=5Ffn_function_prototype?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAMj1kXE-60BqLx4VH6Cw_s0nt=bkx=oFQuts+m6sZFeziH1sqg@mail.gmail.com>
References: <20241216233704.3208607-1-dwmw2@infradead.org> <20241216233704.3208607-10-dwmw2@infradead.org> <CAMj1kXE2abZ8v83vSr5sDZ1QNF-WMr4XCMRhZoc9EW=JAwvdCA@mail.gmail.com> <A18A8675-B1FB-496E-9D8F-FAD412A3FF65@infradead.org> <CAMj1kXFiZvT1joU5gOhZTC18aYi4dPOnFbX1nsHgmnXNy6c6Wg@mail.gmail.com> <27388506-9BE8-4540-A444-166C49133295@infradead.org> <CAMj1kXE-60BqLx4VH6Cw_s0nt=bkx=oFQuts+m6sZFeziH1sqg@mail.gmail.com>
Message-ID: <74A36EA6-D0C8-4CF3-A00B-77C852AC6527@infradead.org>
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

On 17 December 2024 10:54:19 CET, Ard Biesheuvel <ardb@kernel=2Eorg> wrote:
>On Tue, 17 Dec 2024 at 10:42, David Woodhouse <dwmw2@infradead=2Eorg> wro=
te:
>> Hm, I am perfectly happy to believe that my memory is failing me, espec=
ially when it comes to specifics of i386 assembler code=2E But are you also=
 telling me that
>> <https://kernelnewbies=2Eorg/FAQ/asmlinkage> is a lie?
>>
>
>It seems wildly out of date, at least=2E
>
>Commit 96a388de5dc53a8b2 from 2007 removed the asmlinkage definition
>containing regparm(0) from include/asm-i386/linkage=2Eh,=20

No, it's still there in arch/x86/include/asm/linkage=2Eh:
<https://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/torvalds/linux=2Egit/=
tree/arch/x86/include/asm/linkage=2Eh#n20>

And maybe you're right that it's a poorly named macro and we shouldn't con=
flate calling convention with linkage=2E But I think it *should* be part of=
 the typedef=2E


