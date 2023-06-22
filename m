Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 228F3EB64DD
	for <kexec@archiver.kernel.org>; Wed, 28 Jun 2023 15:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	References:In-Reply-To:MIME-Version:Message-ID:Subject:CC:To:From:Date:
	Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
	:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5wAV0Y84nczrlHJu5SBj8tVaWhTgYwwT9wlurIY66jc=; b=d76lmdogwk4ndCtBpdIIM4rwZB
	rArZu9AG8XE5OPlsLP01TZiO8rVvA9PRotYG5zfCM2onANMPg3WhI5KmasBFQ2//tL598Zjx8wA5T
	4u8FVSm43LRhCfHh0TpZA7TYmTPM+44w2AZdxSlX/vKRUK72RdLv6yLRqJIZqEUv84MHgRIzECawW
	82GhtdxinujPux3T1ol5Q7RO1+6iNky+UF5XkEpiBgNsAZ/r8Wx7xatE1bx+E4KDZUFEXIeRQ23un
	heZZ2d6y6sbYV+RpkIKphYx0odcftySnJPcOHYPxFdNhXkzQJN6ZcVf98m8K+WgEgda166CMW1l4L
	dLcvh3Nw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qEWub-00FxMT-0e;
	Wed, 28 Jun 2023 15:16:53 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qCKqO-000sfO-3D
	for kexec@lists.infradead.org;
	Thu, 22 Jun 2023 13:59:31 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230622135925euoutp0193c764677365193732cff7102e07abf0~q-_QYCpHV1007310073euoutp01i;
	Thu, 22 Jun 2023 13:59:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230622135925euoutp0193c764677365193732cff7102e07abf0~q-_QYCpHV1007310073euoutp01i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1687442365;
	bh=FZnb8S33JjksmIfYm3E5lklQ7FIXL+oW6Nyq0JJAKBM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=t6Uh6clH0l6Jhe5RLXOofV2xwDntn2r+HoVPUUEPlqDK7jO1nzAnWoHUEUpAo1BUu
	 dVLGa/izcPBMxaVCaSLhzS4W8zdE17wfVCG9tIyhjoIEBEq3Y+MgSehyeV8xiBpwQC
	 aGyXhR/wgb5uybNTJL1n9YpeuhiIyyf1sA1iwbLo=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20230622135925eucas1p1965ce04eb11398457f845672d7b4ddff~q-_QCkGCB3261832618eucas1p1B;
	Thu, 22 Jun 2023 13:59:25 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 18.44.11320.CB354946; Thu, 22
	Jun 2023 14:59:24 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20230622135924eucas1p1d4431c0a3f0579a57ff4c2c294e64382~q-_Pbyc5N2569425694eucas1p1D;
	Thu, 22 Jun 2023 13:59:24 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20230622135924eusmtrp17afa1bb714e2a8676835938e107bcca8~q-_PaJV6n1116511165eusmtrp1a;
	Thu, 22 Jun 2023 13:59:24 +0000 (GMT)
X-AuditID: cbfec7f4-993ff70000022c38-b4-649453bcec07
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id A6.CE.10549.CB354946; Thu, 22
	Jun 2023 14:59:24 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20230622135924eusmtip2150ff2284551867127b5e5f2b335b36c~q-_PA6bPk2868428684eusmtip2r;
	Thu, 22 Jun 2023 13:59:24 +0000 (GMT)
Received: from localhost (106.110.32.133) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Thu, 22 Jun 2023 14:59:23 +0100
Date: Thu, 22 Jun 2023 15:59:22 +0200
From: Joel Granados <j.granados@samsung.com>
To: Jiri Slaby <jirislaby@kernel.org>
CC: <mcgrof@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, Theodore Ts'o
	<tytso@mit.edu>, "Jason A. Donenfeld" <Jason@zx2c4.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Juergen Gross <jgross@suse.com>, Stefano
	Stabellini <sstabellini@kernel.org>, Benjamin LaHaise <bcrl@kvack.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
	<brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>, Chuck Lever
	<chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>, Kees Cook
	<keescook@chromium.org>, Iurii Zaikin <yzaikin@google.com>, Alexei
	Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii
	Nakryiko <andrii@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Eric
	Biederman <ebiederm@xmission.com>, "Naveen N. Rao"
	<naveen.n.rao@linux.ibm.com>, Anil S Keshavamurthy
	<anil.s.keshavamurthy@intel.com>, "David S. Miller" <davem@davemloft.net>,
	Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, Will Deacon <will@kernel.org>, Petr Mladek
	<pmladek@suse.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, Juri
	Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	Steven Rostedt <rostedt@goodmis.org>, Andrew Morton
	<akpm@linux-foundation.org>, Mike Kravetz <mike.kravetz@oracle.com>, Muchun
	Song <muchun.song@linux.dev>, Naoya Horiguchi <naoya.horiguchi@nec.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, David Howells
	<dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>, Paul Moore
	<paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn"
	<serge@hallyn.com>, "H. Peter Anvin" <hpa@zytor.com>, Oleksandr Tyshchenko
	<oleksandr_tyshchenko@epam.com>, Amir Goldstein <amir73il@gmail.com>, John
	Fastabend <john.fastabend@gmail.com>, Martin KaFai Lau
	<martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
	<yhs@fb.com>, KP Singh <kpsingh@kernel.org>, Stanislav Fomichev
	<sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, John
	Ogness <john.ogness@linutronix.de>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin
	Schneider <vschneid@redhat.com>, Andy Lutomirski <luto@amacapital.net>, Will
	Drewry <wad@chromium.org>, Mark Rutland <mark.rutland@arm.com>, Miaohe Lin
	<linmiaohe@huawei.com>, <linux-kernel@vger.kernel.org>,
	<xen-devel@lists.xenproject.org>, <linux-aio@kvack.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
	<bpf@vger.kernel.org>, <kexec@lists.infradead.org>,
	<linux-trace-kernel@vger.kernel.org>, <keyrings@vger.kernel.org>,
	<linux-security-module@vger.kernel.org>
Subject: Re: [PATCH 08/11] sysctl: Add size to register_sysctl_init
Message-ID: <20230622135922.xtvaiy3isvq576hw@localhost>
MIME-Version: 1.0
In-Reply-To: <68038b83-3221-e351-909c-7f2722b612df@kernel.org>
X-Originating-IP: [106.110.32.133]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA2WTa1ATVxTHvZu7u5EaZ4mOuYO2tKl1HLFYra2nI2id1pkdP6gVx1enrVHW
	x8hDE1HKtA6EWBUfpAEMQipRSoIkAlJgwKAwFOUlKoj1SSqCgBoQJRApBQqsts702//8/+d3
	zzkfrlQiT5X6SLeH7RbUYaoQJeOFCy/3X/2wJCgx+CND0kIw5dgZuJ5tQ+AZSJWAo+MeBnf/
	PRbihvIx2PNjKOjJHWKgp6KSgae/v0DQ0HKTAePjGAymx1dYGG5qpyD9VJ8EOnIPIDBd02Ho
	0g5geKQvkMBwoY6F2PQcBsorS1k4fk4BqcZYCgz9egQPbvqA6c486PplGvRbsljIzkmnQFuU
	SUFhYxqCisQUCTTFJ2G4cjgUHLW9FBTc1zLQfvEoBYc8GRgSj2sRlFyoxnDjvIkBp32Yhu4j
	DxmoyKnDUHu5CoPtbDQNGbfqKbAfOkPDbf0jBAldbQjSrTPgeWkQNJSZKbAUN2OojylDYEsc
	ZOHlwAAN9wxGDJVHyygYbuml4eLBBxQ0vHyKwXHuNPP5Ct6z/xjm/3QNYt5+0o741Oh6zOef
	uUPx9zOKEf9zbBfLF6c0sbzu4l2WN+dF8H841vO6ik6a/y1zFp9e8pji4243SPi8rEPMypkb
	vAKChZDtewT1nEUbvbbV97XTOwcUkfaiMjoaWSbHofFSws0n2rSTbBzyksq5TERa2k4zYuFG
	pKu0HYtFDyJl1kuS14i+r40WAysimQmX6X+7LhW5XyH5iAzWNNKjCOY+IK6WujGc4WaTa677
	Y3ryiG8pzhobKOH6phCtwcKMBpO4L8iF2NYxWMYtIINuOyVqb1J9ohWPagkXSXoa/xp5SDqi
	pxLrkHTUHs8tIk3mPiSuqiS9rqO0qH8kNfl3qdFZhKufQFLcRiwGX5KDT+Jf3TaJPKnMZ0U9
	jdQmHMEikIBI6VA3KxY2RCwxvZTYtZDoGltfEUtIptaARjci3ERyu9NbXHQiMRQaJaItIwd/
	kovdM4jN6cJ69H7KG6elvHFayn+nifZsYna8YP5n+xHLqacSUQeS7Oxn2IzYLKQQIjShWwXN
	vDBhr79GFaqJCNvqvzk8NA+N/NnaoUp3EbI+ee5fjigpKkfTR+CHubbryAeHhYcJysmyt/MM
	wXJZsOr7KEEd/p06IkTQlKOpUqxUyPwCqzfLua2q3cIOQdgpqF+nlHS8TzSlyI389K0WxtF0
	o6hZy3ifXbW6ou6rgknOuUl1IZ/4b6pios5fnXsG09NPVPvtifddFuXas09Xb7Nk3CjvcMYN
	7/X4msz+CVb3Z8+63409sHxpiJcscr2CXrBuSs2D4K+Tq5Z5jUs+9l7AFuU3CcqlrXolv9EU
	V6T6Vb5msU63yxOVRnmzzS3Na8MbLL5c55IfSqakXQjYNW6xZo4n8W/pBmNGIHFOaKsadq7e
	tGLHhi3z/RonyFJbu6r7ggb2v5PsmqaWe9Z1KgtKFqVtq52579tAl9W51uXYFHSzY1zi4fgh
	ffeqpFvG/oCJqjVato2+GrD84/3Z5rzelRt9DZ01ilMoS4k121RzZ0nUGtU/zr4xyS4FAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA2WTeUyTdxjH93v769ti1lgO5RdkapqNLUxry+XDgmTqEl7cgcRkCTObNvIG
	yKB1LcUrSyhHuDyqQ42lIIcgR+USGhBEUglowCEgyqmCgnKMCXJYkbJCXWay/z75fvP9Pk+e
	5OFzHIw8F36EPJpVymWRInoNbrW0PN5avy89VFL9di3oyww03C8tQbCwmMGBupf9GGbN/TxI
	tVRhMFRpKHhdbqHhdVMLDRO3ZxB0Puum4eKYBoN+rI0Hy4MvKMjLmefAy/IkBPr2BAxTcYsY
	RrTVHFg2JvAgPq+MBlPLLR5cqHCGjIvxFJwzaxE87XYBfa8HTGW6grmgmAelZXkUxNUUUmB8
	cBlBU7qOA4NnzmNoS4uCutY5CqoH4mh40XCKgpSFfAzpF+IQ1N+8i6Hrhp6Gx4ZlLrw6OUxD
	U9k9DK3NdzCUXIvlQv6jDgoMKUVc6NGOIPhjahRB3lU3mL61DzobsykoqB3C0KFpRFCSvsSD
	N4uLXOg/dxFDy6lGCpafzXGhIfkpBZ1vJjDUVeTSXwcxC4mnMfNkcgkzhiwDYjJiOzBTVdRL
	MQP5tYg5Gz/FY2p1gzwmoaGPx2RXqpmHdSFMQtNfXOZ6oTuTVz9GMak9nRymsjiF3vvFT2I/
	pUIdzW4OV6iid4j2S8FDLPUFsYeXr1jquf3nrzy8Rdv8/ULZyIgYVrnN/6A4XH9lDh82Ox/t
	tZRyY9EVp1RkxydCL6KdH+WmojV8B2E+IpNnMrHNcCUVs91cGzuSdw9T6RV2EE4j8mjshC1Q
	hUh9QQdaMbDwMzL57B5nhWnhFtI+ObDKTla9oLaYXglwhDPrydhJ7eoER+FucjP++eoEgXA7
	WZo1ULbWXorozG/fG/bk7qXnqwGOMIZ03blg1flW3kCuWvgrsp3QnwxmzyPbpiIyN3nq/da/
	k9dLo0iLHHUfNOk+aNL912ST3UmPZYz6n/wlKciZ4Nh4Bykt/RtnI14xcmLVqqiwKJVUrJJF
	qdTyMPEhRVQlsj6Nsdl8vQZljU+LTYjiIxP61JocLi+5j1ywXCFnRU6CTyrPhToIQmXHjrNK
	xQGlOpJVmZC39YxnOS7rDimsHyiPPiD1kXhLvXx8Jd6+Pp4iZ0Hg4WSZgzBMFs3+yrKHWeW/
	OYpv5xJL7crt70o2VxeOfG9fHuXmKXGZG7bQNErT1q8NcupJ8bvxzbXw8U0h9tuG49o2Bgns
	VSP+OUe+a/w82EAPCZSJ/eez9g4Ibmog17SlWjGaufsXE26uHdp+4+G6J8GGGPfHRnmtXeXO
	AGKKieybJkcOtrO6+BNpWeF5vonSH7wbkg9Qyt6APUE1TzX8ha19GVP9mbP1m332nJbwZ4yb
	ko7ndDw45lmU821gWl3IkcG2pLmPoseb9U0/ql37gt1erffOMlyeJ4fGj2luV6zbt1EdIdmf
	rdgVkKaa+TisUXNwQ9K7cfynpbTdbSZw6KhRHbHp8m8RNZLJ9sCdXoP7rwVIsvaIsCpcJnXn
	KFWyfwAWXMkTyQQAAA==
X-CMS-MailID: 20230622135924eucas1p1d4431c0a3f0579a57ff4c2c294e64382
X-Msg-Generator: CA
X-RootMTR: 20230621091037eucas1p188e11d8064526a5a0549217d5a419647
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230621091037eucas1p188e11d8064526a5a0549217d5a419647
References: <20230621091000.424843-1-j.granados@samsung.com>
	<CGME20230621091037eucas1p188e11d8064526a5a0549217d5a419647@eucas1p1.samsung.com>
	<20230621091000.424843-9-j.granados@samsung.com>
	<36fae2b0-4cd2-58b5-cc12-9abdd5ce235b@kernel.org>
	<20230621131147.c3jegl4hgjplcrpu@localhost>
	<68038b83-3221-e351-909c-7f2722b612df@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230622_065929_451246_EF96AA24 
X-CRM114-Status: GOOD (  28.99  )
X-Mailman-Approved-At: Wed, 28 Jun 2023 08:16:38 -0700
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
Content-Type: multipart/mixed; boundary="===============5297295782982444323=="
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

--===============5297295782982444323==
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="2bee3c5qj77ur3kk"
Content-Disposition: inline

--2bee3c5qj77ur3kk
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 22, 2023 at 06:25:15AM +0200, Jiri Slaby wrote:
> On 21. 06. 23, 15:11, Joel Granados wrote:
> > On Wed, Jun 21, 2023 at 11:56:03AM +0200, Jiri Slaby wrote:
> > > On 21. 06. 23, 11:09, Joel Granados wrote:
> > > > In order to remove the end element from the ctl_table struct arrays=
, we
> > > > explicitly define the size when registering the targes. We add a si=
ze
> > > > argument to the register_sysctl_init call and pass an ARRAY_SIZE fo=
r all
> > > > the callers.
> > >=20
> > > Hi, I am missing here (or in 00/00) _why_ you are doing that. Is it b=
y a
> > Not sure what happened. I used the kernels get_maintainers.pl script
> > together with git-send-email. These are my settings:
> >=20
> > "
> > tocmd =3D"`pwd`/scripts/get_maintainer.pl --nogit --nogit-fallback --no=
rolestats --m --nol --nor"
> > cccmd =3D"`pwd`/scripts/get_maintainer.pl --nogit --nogit-fallback --no=
rolestats --l --r --nom"
> > "
> >=20
> > Could it be that there is an error in MAINTAINERS?
>=20
> Sorry, I don't see what you are asking about. I was asking about motivati=
on
I thought you were telling me that you were missing in the 00/00 :). I
misread, sorry.

> behind the series. That is a must in commit logs.
I see now that just saying "this is part of the effort to remove the
last empty element", does not put all this in to context. I spent some
time looking into the lists for some context and I think Luis summarizes
it quite nicely here
https://lore.kernel.org/all/20230302204612.782387-1-mcgrof@kernel.org/.

As I read it removing the last empty element from the ctl_table arrays
is part of a greater effort to remove the clutter in kernel/sysctl.c.

Here is one that actually hints at the ARRAY_SIZE solution.
https://lore.kernel.org/all/20230302202826.776286-1-mcgrof@kernel.org/

Here are some other threads that mention the overall effort:
https://lore.kernel.org/all/20230321130908.6972-1-frank.li@vivo.com
https://lore.kernel.org/all/20220220060626.15885-1-tangmeng@uniontech.com

I will add a better motivational part to V2

Thx for the feedback

--

Joel Granados

--2bee3c5qj77ur3kk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmSUU7MACgkQupfNUreW
QU8a6gv+P22nDM5KW7F6fOtYuHg1js1rXfyJtnPUPw4k0zUH2LYvUiJe8q/eKL17
du2WA7madGH/uqDWh7u2DMVnSQlbt+sw8m4tV5JUrCuA0iRCsCw+ZumZg9RYEKWT
Qy6H7fHNgeWv1/nc+/QBHzdZAoGJOT4I92UW8N1YobXgdCk4z4iSWX+dEoLf5rca
FdKqlGW4OUV9XMUruBvy/WkO1DaeOLgsIkUb6zaHFE5qETf+cNkOgGI/taVweaAL
zPIGkg51JYrejtvQkwTxS/nM02ZRihbqMM0W7LXiBm5Opumv2mmw7SEBXeid9cU5
MKc54QLz02fQypJWRW29UABnGXQclrILLD1aXOBF1gON4VuqA3Rhnt9YQ7ap0ra7
kW7Zvi17rJFZJ/0HAY/eluUNu/WiNPC6qFItklbhUU/Y8Wko/m3hlxHdoauaBJ4K
Q8I5gvw+Vw6N+yAU+PBPHPS4Ey0fj1Q8k9VBkUI+SF77C4OrqrEeNiAgwAAB7EoR
POrQ+zAc
=Xzhv
-----END PGP SIGNATURE-----

--2bee3c5qj77ur3kk--


--===============5297295782982444323==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============5297295782982444323==--

