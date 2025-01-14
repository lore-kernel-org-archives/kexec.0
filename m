Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CCCAE77188
	for <kexec@archiver.kernel.org>; Tue, 14 Jan 2025 11:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vpxidfqOBX1Do6ztrJgLAfObKOjR19nBSRmfTkVX9MY=; b=nFHShd3klzwi2QR4kULLG8E2M7
	ayBz0GjnPXYvSLrJV59mn56ZzcGFmaLgRWhxmgBHFEYzIjyQYcDCMFdnG/OUit7i3w7otRcYQUefB
	KNH1RFfuOScDlmDpVzQ5sTj+CWJ/S3uWA7v+XXim+5RirvZ5HkJQGhc1V4yJBsuDl2Q4awVqGA9hh
	8kPVYOWRJEExFVjrFUpIwVA9rsXGTYvhdbHHquZDjWIMQ/H30r7yWGQZQnlOcyYJ1JTEGx2TyF23I
	YtVKCYYPD7rHfQ7x2pqRmD26R2PjxyV8FKJ+SUWxBz2djjm0cJ6CacpdU+S4xipOmwjm5gdw/Jtxh
	S0eHmx+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tXfUZ-00000008Jl7-0B9T;
	Tue, 14 Jan 2025 11:53:55 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tXfUX-00000008Jku-4ByX
	for kexec@bombadil.infradead.org;
	Tue, 14 Jan 2025 11:53:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=vpxidfqOBX1Do6ztrJgLAfObKOjR19nBSRmfTkVX9MY=; b=bLtgCkx+osk4isM6qtgExB9BUw
	IYzutVBgJLnvPYa5mxO+CVj7+6uSqvvT05qfdMLqFWzwbOF5vzQ/wlO6WHbwry41HmPaUS6N1rt/Z
	1A4YsS7Ywt/TPDN/HICONzbPrZ1z7hk9wYc8YQjQLYqCx/+Fv8MiYNmHeEhpSqMASfUI5dCVXZzjN
	z1+yJ/1HD1OrCltZUxVSgcZVJ/bs3OtqfUsOtCF+J+GN95H4TYJ2MvtJMwpTwOa7nJEtt2s7vlOI0
	AFJZFPDD8cWC0BOU6D5cmDVg/fWRy/BngCNS8WdZAEd4M+yc4yczjEsnEgunoSprY0Xsxttu1BuHf
	bLBQQcwg==;
Received: from [31.94.26.142] (helo=[127.0.0.1])
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tXfUS-0000000ASFt-02EX;
	Tue, 14 Jan 2025 11:53:48 +0000
Date: Tue, 14 Jan 2025 12:53:45 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: Borislav Petkov <bp@alien8.de>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H . Peter Anvin" <hpa@zytor.com>, Eric Biederman <ebiederm@xmission.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
 Yuntao Wang <ytcoode@gmail.com>, David Kaplan <david.kaplan@amd.com>,
 Tao Liu <ltao@redhat.com>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Kai Huang <kai.huang@intel.com>, Ard Biesheuvel <ardb@kernel.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Breno Leitao <leitao@debian.org>,
 Wei Yang <richard.weiyang@gmail.com>, Rong Xu <xur@google.com>,
 =?ISO-8859-1?Q?Thomas_Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
 linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
 Simon Horman <horms@kernel.org>, Dave Young <dyoung@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, bsz@amazon.de, nathan@kernel.org
Subject: Re: [PATCH v2 0/9] x86/kexec: Fixes for tip/x86/boot
User-Agent: K-9 Mail for Android
In-Reply-To: <20250114115115.GAZ4ZPs4R-Sw2NBZHL@fat_crate.local>
References: <20250109140757.2841269-1-dwmw2@infradead.org> <a3ca6fb291674f92fd2f94acf45bf3813baa3a49.camel@infradead.org> <20250114115115.GAZ4ZPs4R-Sw2NBZHL@fat_crate.local>
Message-ID: <5E5117F9-2A7A-4100-BC72-7CDE8DD8361A@infradead.org>
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

On 14 January 2025 12:51:15 CET, Borislav Petkov <bp@alien8=2Ede> wrote:
>On Tue, Jan 14, 2025 at 12:34:29PM +0100, David Woodhouse wrote:
>> On Thu, 2025-01-09 at 14:04 +0000, David Woodhouse wrote:
>> > Fix a few bugs introduced by the recent rework of the relocate_kernel=
()
>> > code, and one which has been there in the kjump code from the beginni=
ng=2E
>>=20
>> Ping?
>
>I'm going through them as we speak=2E
>

Thank you=2E Once the dust settles on these I can resend the debugging stu=
ff which is actually what I came here to do=2E

