Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B11CCD128A
	for <kexec@archiver.kernel.org>; Wed, 27 Mar 2024 19:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References:Message-Id
	:MIME-Version:Subject:Date:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mMKGotnimEE7gl2AW93s1heAyQ0zzQpFYOMNA0gqKNg=; b=EBHCz9VOzFm3u+
	WxR99b3gr40FjBYrLgiI7EPUukGP6TPBa1emnXVA6UPiWg6dTi8ceNpeyqFEzk3+rZ81k/Oj+F+L9
	lGV0L/JKliBxAv1EWzx6dva0azbFzrfq9AQKGrsMxtL3rmXK7z0n/p+46Ya0eO5wAsXRKRFdZzg1d
	ZZ8EO4bm0Seqz8x4LUivbmrTLjM9cQOglOWKGpmgCL932TWgzJehLPZ+CbYBsDFfi6CpRPKN5gTBV
	/hlKDKJsb9VFDtafXjDw6ih/4LW6N3LXddH87z3vGY3ZzgT5NsBDHUPoPKxmpw2vYC94hnDpGUVkz
	XeeGfI4C731iBa7FGDhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpYYY-0000000AhgF-3DIS;
	Wed, 27 Mar 2024 19:03:26 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rlETn-00000001XEz-1UGp;
	Fri, 15 Mar 2024 20:48:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Sender:Reply-To:Content-ID:Content-Description;
	bh=ANWB3THTVGUwkCzekT5wEk35tYYqEGjvGDQoY9noUUU=; b=HlRp2s+AdyjlnevBdLIhQuZIfx
	S5CFA5q1Xtyc7bH6XwFF76FzeRznOByYqLeprNqKPMcZ8DuXrCpVeZPZ+rHmkAq8HiqrFRlTn3/QY
	X6REUoRJwMx9WcRIYlhD7AtOOQz0OvvM/4IObrJBFEQpnkctVAsn2xvTXovXy8/cfqqcywNbG3h34
	0hltHbPxR+c742VQ9npGdRxEIrGSNYEJONVNAKOlU9oKp08+GOK/Pb1MOb7yDAy2lJEb96CB/lo2r
	GgoEfui9a+ReeTRM5kbifo9cvGNQpJ8ntIV/AlCJnf1g6uzzJdJjYAStH3AGaPAu3qRZezcKqs+Bz
	g79ilElA==;
Received: from todd.t-8ch.de ([2a01:4f8:c010:41de::1])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rlETh-0000000BBKY-49eZ;
	Fri, 15 Mar 2024 20:48:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1710535698;
	bh=7M7T8qGemL/J5YUUwWJ0cC9nJ/50fjpcJlm81ezvXMY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fXx71L6JuiqeYvuZyYbzXSU8ULmJtg70CnofWoEiwBlN41Bqml1Gn5WgRnQq6Ajn5
	 qDRqHOKkbjZnx3OuwYfASjLfdLsDv6kvpZD8exd4YCHBoXJOczJAyokASCokeIgyZB
	 Md/qSjV+tOfVMb7Hd80eciTQw4KJ1N/ByH4nv8Ww=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Fri, 15 Mar 2024 21:48:05 +0100
Subject: [PATCH 07/11] ipv6/addrconf: constify ctl_table arguments of
 utility functions
MIME-Version: 1.0
Message-Id: <20240315-sysctl-const-handler-v1-7-1322ac7cb03d@weissschuh.net>
References: <20240315-sysctl-const-handler-v1-0-1322ac7cb03d@weissschuh.net>
In-Reply-To: <20240315-sysctl-const-handler-v1-0-1322ac7cb03d@weissschuh.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kees Cook <keescook@chromium.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, Simon Horman <horms@verge.net.au>, Julian Anastasov <ja@ssi.bg>, Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, Florian Westphal <fw@strlen.de>, Luis Chamberlain <mcgrof@kernel.org>, Joel Granados <j.granados@samsung.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Phillip Potter <phil@philpotter.co.uk>, Theodore Ts'o <tytso@mit.edu>, "Jason A. Donenfeld" <Jason@zx2c4.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Atish Patra <atishp@atishpatra.org>, Anup Patel <anup@brainfault.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Eric Biederman <ebiederm@xmission.com>, Chandan Babu R <chandan.babu@oracle.com>, "Darrick J. Wong" <djwong@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, Balbir Singh <bsingharora@gmail.com>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, Petr Mladek <pmladek@suse.com>, John Ogness <john.ogness@linutronix.de>, Sergey Senozhatsky <senozhatsky@chromium.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>, Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, Remi Denis-Courmont <courmisch@gmail.com>, Allison Henderson <allison.henderson@oracle.com>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, Trond Myklebust <trond.myklebust@hammerspace.com>, Anna Schumaker <anna@kernel.org>, John Johansen <john.johansen@canonical.com>, Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Alexander Popov <alex.popov@linux.com>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, 
 lvs-devel@vger.kernel.org, netfilter-devel@vger.kernel.org, 
 coreteam@netfilter.org, linux-fsdevel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
 linux-xfs@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, kexec@lists.infradead.org, 
 bridge@lists.linux.dev, linux-rdma@vger.kernel.org, 
 rds-devel@oss.oracle.com, linux-sctp@vger.kernel.org, 
 linux-nfs@vger.kernel.org, apparmor@lists.ubuntu.com, 
 linux-security-module@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710535695; l=1733;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=7M7T8qGemL/J5YUUwWJ0cC9nJ/50fjpcJlm81ezvXMY=;
 b=tDrRFBvycsbBg1b0VjT1utAvA72vW/Pfn/OG8rmdlBPllpN3zp995mmaLodLsZ9cR6UItDzEG
 934FLotKWacC+9a11IwVotmGV7cUQDZTwgtBLcNNphSOBq2Q6lt1ZQr
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240315_204834_254105_20F92D76 
X-CRM114-Status: GOOD (  12.74  )
X-Mailman-Approved-At: Wed, 27 Mar 2024 11:01:50 -0700
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

SW4gYSBmdXR1cmUgY29tbWl0IHRoZSBwcm9jX2hhbmRsZXJzIHRoZW1zZWx2ZXMgd2lsbCBjaGFu
Z2UgdG8KImNvbnN0IHN0cnVjdCBjdGxfdGFibGUiLiBBcyBhIHByZXBhcmF0aW9uIGZvciB0aGF0
IGFkYXB0IHRoZSBpbnRlcm5hbApoZWxwZXJzLgoKU2lnbmVkLW9mZi1ieTogVGhvbWFzIFdlacOf
c2NodWggPGxpbnV4QHdlaXNzc2NodWgubmV0PgotLS0KIG5ldC9pcHY2L2FkZHJjb25mLmMgfCA4
ICsrKystLS0tCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygt
KQoKZGlmZiAtLWdpdCBhL25ldC9pcHY2L2FkZHJjb25mLmMgYi9uZXQvaXB2Ni9hZGRyY29uZi5j
CmluZGV4IDI0N2JkNGQ4ZWU0NS4uYzcyZjNiNjNlNDFkIDEwMDY0NAotLS0gYS9uZXQvaXB2Ni9h
ZGRyY29uZi5jCisrKyBiL25ldC9pcHY2L2FkZHJjb25mLmMKQEAgLTg2Miw3ICs4NjIsNyBAQCBz
dGF0aWMgdm9pZCBhZGRyY29uZl9mb3J3YXJkX2NoYW5nZShzdHJ1Y3QgbmV0ICpuZXQsIF9fczMy
IG5ld2YpCiAJfQogfQogCi1zdGF0aWMgaW50IGFkZHJjb25mX2ZpeHVwX2ZvcndhcmRpbmcoc3Ry
dWN0IGN0bF90YWJsZSAqdGFibGUsIGludCAqcCwgaW50IG5ld2YpCitzdGF0aWMgaW50IGFkZHJj
b25mX2ZpeHVwX2ZvcndhcmRpbmcoY29uc3Qgc3RydWN0IGN0bF90YWJsZSAqdGFibGUsIGludCAq
cCwgaW50IG5ld2YpCiB7CiAJc3RydWN0IG5ldCAqbmV0OwogCWludCBvbGQ7CkBAIC05MzAsNyAr
OTMwLDcgQEAgc3RhdGljIHZvaWQgYWRkcmNvbmZfbGlua2Rvd25fY2hhbmdlKHN0cnVjdCBuZXQg
Km5ldCwgX19zMzIgbmV3ZikKIAl9CiB9CiAKLXN0YXRpYyBpbnQgYWRkcmNvbmZfZml4dXBfbGlu
a2Rvd24oc3RydWN0IGN0bF90YWJsZSAqdGFibGUsIGludCAqcCwgaW50IG5ld2YpCitzdGF0aWMg
aW50IGFkZHJjb25mX2ZpeHVwX2xpbmtkb3duKGNvbnN0IHN0cnVjdCBjdGxfdGFibGUgKnRhYmxl
LCBpbnQgKnAsIGludCBuZXdmKQogewogCXN0cnVjdCBuZXQgKm5ldDsKIAlpbnQgb2xkOwpAQCAt
NjM3NSw3ICs2Mzc1LDcgQEAgc3RhdGljIHZvaWQgYWRkcmNvbmZfZGlzYWJsZV9jaGFuZ2Uoc3Ry
dWN0IG5ldCAqbmV0LCBfX3MzMiBuZXdmKQogCX0KIH0KIAotc3RhdGljIGludCBhZGRyY29uZl9k
aXNhYmxlX2lwdjYoc3RydWN0IGN0bF90YWJsZSAqdGFibGUsIGludCAqcCwgaW50IG5ld2YpCitz
dGF0aWMgaW50IGFkZHJjb25mX2Rpc2FibGVfaXB2Nihjb25zdCBzdHJ1Y3QgY3RsX3RhYmxlICp0
YWJsZSwgaW50ICpwLCBpbnQgbmV3ZikKIHsKIAlzdHJ1Y3QgbmV0ICpuZXQgPSAoc3RydWN0IG5l
dCAqKXRhYmxlLT5leHRyYTI7CiAJaW50IG9sZDsKQEAgLTY2NjYsNyArNjY2Niw3IEBAIHZvaWQg
YWRkcmNvbmZfZGlzYWJsZV9wb2xpY3lfaWRldihzdHJ1Y3QgaW5ldDZfZGV2ICppZGV2LCBpbnQg
dmFsKQogfQogCiBzdGF0aWMKLWludCBhZGRyY29uZl9kaXNhYmxlX3BvbGljeShzdHJ1Y3QgY3Rs
X3RhYmxlICpjdGwsIGludCAqdmFscCwgaW50IHZhbCkKK2ludCBhZGRyY29uZl9kaXNhYmxlX3Bv
bGljeShjb25zdCBzdHJ1Y3QgY3RsX3RhYmxlICpjdGwsIGludCAqdmFscCwgaW50IHZhbCkKIHsK
IAlzdHJ1Y3QgbmV0ICpuZXQgPSAoc3RydWN0IG5ldCAqKWN0bC0+ZXh0cmEyOwogCXN0cnVjdCBp
bmV0Nl9kZXYgKmlkZXY7CgotLSAKMi40NC4wCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJh
ZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhl
Ywo=
