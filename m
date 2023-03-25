Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0445C6FD1C
	for <kexec@archiver.kernel.org>; Sat, 25 Mar 2023 19:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mkxHCDxEGwQk1fzIL8JHVhfEL72payvCkUfar1XVl54=; b=mB2zJjT3IAicS0
	CuEeYNR273tcw7uCHLZMOhhCkOEPAAQNwE7avETQsgHcZYUVUkZS2riRFrrs9x5A/m35qVdxlyeWB
	cVWMWAZrc3yd5bGt7/ZW4xsxmdzUiTzPp5hxKhxUnN99m+xjA76skQjhtK6Vekl+no04PuoPMP8dB
	dPTot2ksWyIXegUkd7awlDJePbRmrqiHJ81dlVz5C2edhyr5xtI0v+s9KRUkQ2A0B1AXBK9bPPD+/
	XNX05/eX8pUaZftb308rz5OE7N1kZnClaXwoa5IxnkPM2KDEcCkiff0gYnJI2iSR1f9AD5KGqZ5CG
	J7/p+Fx/wuj2acHpah/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pg9WK-007DsN-08;
	Sat, 25 Mar 2023 19:25:44 +0000
Received: from out3-smtp.messagingengine.com ([66.111.4.27])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pg9WG-007Dok-16
	for kexec@lists.infradead.org;
	Sat, 25 Mar 2023 19:25:41 +0000
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 401EC5C0054;
	Sat, 25 Mar 2023 15:25:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sat, 25 Mar 2023 15:25:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm3; t=1679772329; x=
	1679858729; bh=F20hN5cmoUb7ZMiQCIUcAf557ZHjOrjpfezAUz/+nzY=; b=C
	Gmc+c3g2DEkoY4krwTCYYXVNEm+SGdPUafJ/YisY5tj9vOW/nG8lJeb8ujJmXhgt
	WaFn1p3ENyvGzc7a+Agl7amh4dxpKoh9fXmL9QgMxiwL0XdWlGh1PHZnInZVzYrV
	k7h6ZuY9q8KVdN+0aZUbUSGs7JacG1oqxuUDpoDaUcY5YmBovRT4GrWeaW+k3KJN
	Kys82rcorrTbJb4KWv2elly7uN4w/JQzuycfp3H4YfWJeBQnq63qXtVZbvNgAYmk
	mx16ervjNfDHp0Kv/Jzsyrm5WAEjPwd8iezXDVVbswidLnooTW2NiNa3QM0pg0cW
	q/ylnuCpIXoc0b2znYjRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1679772329; x=1679858729; bh=F20hN5cmoUb7Z
	MiQCIUcAf557ZHjOrjpfezAUz/+nzY=; b=EeoXI1YzVWVTVkWRPBhlqMVKiYj1m
	OEO7NioGTasn/v6KcdceRJfqBWBs8iSQTYgCxKTfYDDn4FHh+HsENI/nqSBc0aqA
	kNMYWigMUqg//mXOHhOY4QcHMCbg36mNpw9yQFHRz696PZP5pTqqkFxg1JwCindz
	ohCO+8650NTj22LgHZCujr1+NT5Ua/HQPw/TpBVCtqQuwvEkP8O3W0nvNhLOb+Ib
	d8UVHgMLiq9wbAJ+pSiu8YdF9m3Mib9uyIioFqB+LDjHLiWzdUwoxto0MtP+jp1A
	Y0sZouOYrXSFNITmxhVdlQVeydyU0w9lN+8BnH0fQn7OhQxWLhCwVQD6w==
X-ME-Sender: <xms:qEofZFbj3ZwkojFP_FtkKRlkASPhBaZjbTNCCDyGrJDax7PtziRn8Q>
    <xme:qEofZMYr95OvaMveRgxrWiMVPiuJzPZK4df54sxZr1hnGl7I1DfTUZj872gvLHBUj
    _CRoJroVF80ZFfI_Dg>
X-ME-Received: <xmr:qEofZH_feRcMb5omIRCp7IS3Jpzc4r8J3dEtrLJWuRdHSCMDcbvxw6SzlWwWoe4kPDcNcA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdegkedguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpedfmfhi
    rhhilhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllhesshhhuhhtvghmohhvrd
    hnrghmvgeqnecuggftrfgrthhtvghrnhepkedvvdejffehteegtddvgfeijeeivdegjeei
    teejheeiheevffeukeefheffvdevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:qEofZDqvp-0wO6OYQc43RDh8s_Jcxaj87GPSdKgh6GCNDkYZ26Q9Qg>
    <xmx:qEofZAp8j-mVWsJh15v_keUQ3eYUmOaKKJ2EpMeYo0lwB-2Kp5bdhw>
    <xmx:qEofZJRop-GA93lYkhH5yI5dzfDoqqlKyYq1GFUqt9-7xPgQpIFJnQ>
    <xmx:qUofZMel6wZsOl35SUCqFcc5Nqu553awLhZgPgpSeFtGFKmywS3uMQ>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 25 Mar 2023 15:25:27 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
	id 3965210A607; Sat, 25 Mar 2023 22:25:24 +0300 (+03)
Date: Sat, 25 Mar 2023 22:25:24 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Dave Hansen <dave.hansen@intel.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
	Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: Disable kexec for TDX guests
Message-ID: <20230325192524.wetlbycbcsxc4plk@box>
References: <20230325160128.21857-1-kirill.shutemov@linux.intel.com>
 <ebead33b-0594-73df-56ae-f40473ac0ffc@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ebead33b-0594-73df-56ae-f40473ac0ffc@intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230325_122540_450719_036ECCFE 
X-CRM114-Status: GOOD (  20.71  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Sat, Mar 25, 2023 at 09:25:36AM -0700, Dave Hansen wrote:
> On 3/25/23 09:01, Kirill A. Shutemov wrote:
> > The last item is tricky. TDX guests use ACPI MADT MPWK to bring up
> > secondary CPUs. The mechanism doesn't allow to put a CPU back offline if
> > it has woken up.
> ...
> > +int arch_kexec_load(void)
> > +{
> > +	if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST)) {
> > +		pr_warn_once("Disable kexec: not yet supported in TDX guest\n");
> > +		return -EOPNOTSUPP;
> > +	}
> > +
> > +	return 0;
> > +}
> 
> So, let's put all this together:
> 
> 1. TDX implementations use MADT for wakeup exclusively right now (but
>    are not necessarily _required_ to do so forever)
> 2. MADT doesn't support CPU offlining
> 3. kexec() requires offlining
> 
> Thus, current TDX implementations can't support TDX guests.  This
> *doesn't* say that TDX will always use the MADT for wakeups.
> 
> Yet, the check you have here is for TDX and *not* for the MADT.

As I described in the commit message there are more than MADT that is
required to get kexec in TDX guest.

> That seems wrong.
> 
> Let's say SEV or arm64 comes along and uses the MADT for their guests.
> They'll add another arch_kexec_load(), with a check for *their* feature.
> 
> This all seems like you should be disabling kexec() the moment the MADT
> CPU wakeup is used instead of making it based on TDX.

I guess we can go this path if you are fine with taking CR4.MCE and shared
memory reverting patches (they require some rework, but I can get them
into shape quickly). After that we can forbid kexec on machines with MADT
if nr_cpus > 1.

Sounds good?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
