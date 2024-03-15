Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2829DCD1288
	for <kexec@archiver.kernel.org>; Wed, 27 Mar 2024 19:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References:Message-Id
	:MIME-Version:Subject:Date:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nJCAxdk6V0WJmRS7u/Xx5Tt03eEAYG7xwGB1/F20l1g=; b=SoJ2O+EwDlh+mI
	LhbB7769PGZ4O94vzTCoiS6PE3Ne8ika/mOzu7hIry1BnIgXQywLmo6qdrqpnBZ4/7zDbPYib1rKT
	rajG6MoJSDPtQEuAwsZ04c1f5VfVPcOGKajkPIL64uCHvZA2tmdSeI8XpOepbZF7f12WzCLR8g4WF
	D218uW4c/XfN3zuyygypzs2OPyN4/WF1fb54qlH4f6MOnr3iSQV9VBblcYZBGXcGxmZpuZB4ii21C
	osECZtLTUGD/0mJAG8olzdfvMEL7J5UR2lhbU6LsMHYVK544m0okEUP02dnPuXyTuLkEsHL8Vn94w
	2ENfTi49r3c6pCwcodIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpYYX-0000000Ahfc-3Ghj;
	Wed, 27 Mar 2024 19:03:25 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rlETn-00000001XF0-1bcJ;
	Fri, 15 Mar 2024 20:48:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Sender:Reply-To:Content-ID:Content-Description;
	bh=FbpW8OtDAenCttGekYaNBp6p0kgmPGbT5dc9uTJshoA=; b=ceTOd88NwTw+3unU4XbPlSk/Ej
	9sX5O67IpIYG2xt4TheHqxxZmNmpCJrFpHRs16MLm+B/TwNnY1dCUqa1cUwh+UIWnmJTRBympbuyv
	F/OEgEKSrI3YElAYfAPCW17wP2sTBZUfn/ZjoGEDPjErfLDvi7tSo3BaA/C+5I5r0rGLF092Uy6sC
	151mEut8t0tEtzGV4UrlKmKVYeDRFhkqmQJRBA7OihhP4zzIi83jkEHZ4jgJCjEZErs8dyFX0u2Rb
	8CSkqwadbyuwxuFCwkkFS4Nzii/CPYo6qU/C/t3QHHw8FFuQilh/qJddEFbMtJI6DvUneM3IQOTrG
	vJqfdmVQ==;
Received: from todd.t-8ch.de ([2a01:4f8:c010:41de::1])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rlETh-0000000BBKT-49hy;
	Fri, 15 Mar 2024 20:48:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1710535698;
	bh=yGyEnmkHG4K/QBZUE+wYC6PI0MysqQBf2jxKv03Uqeg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FizCPf3SLAP8QJl7MKFLQmc5kz5/Ber5gPk8JnKK898Pgfacl6e7Q9zZ8wapuxDxV
	 TQWvxZCydhPkPxx+WAYMk6TZp7HXP9SWmdfrZU1oYK6fsVpzjHLFaMHd2iiXqD6aYq
	 mvnmhabBstRavzIG/FFHz4xiVL036JzBS8Q+3twI=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Fri, 15 Mar 2024 21:48:04 +0100
Subject: [PATCH 06/11] ipv4/sysctl: constify ctl_table arguments of utility
 functions
MIME-Version: 1.0
Message-Id: <20240315-sysctl-const-handler-v1-6-1322ac7cb03d@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710535695; l=1269;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=yGyEnmkHG4K/QBZUE+wYC6PI0MysqQBf2jxKv03Uqeg=;
 b=WplrulYKd7B5TGswqzcDZbw2m/RyDv+HhOXZKHSfdG38pZxdNlsfrZeeItPHEYHA5eD5Kt+EM
 V7+s8EbXwZLDElxohBqz8CxV4en1zqMOoIPQsYqfboOMLt8tzBvHJKe
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240315_204834_249042_F5CAC6E9 
X-CRM114-Status: GOOD (  13.28  )
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
c2NodWggPGxpbnV4QHdlaXNzc2NodWgubmV0PgotLS0KIG5ldC9pcHY0L3N5c2N0bF9uZXRfaXB2
NC5jIHwgNiArKysrLS0KIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDIgZGVsZXRp
b25zKC0pCgpkaWZmIC0tZ2l0IGEvbmV0L2lwdjQvc3lzY3RsX25ldF9pcHY0LmMgYi9uZXQvaXB2
NC9zeXNjdGxfbmV0X2lwdjQuYwppbmRleCA3ZTRmMTZhN2RjYzEuLjM2M2RjMmE0ODdhYyAxMDA2
NDQKLS0tIGEvbmV0L2lwdjQvc3lzY3RsX25ldF9pcHY0LmMKKysrIGIvbmV0L2lwdjQvc3lzY3Rs
X25ldF9pcHY0LmMKQEAgLTEzMCw3ICsxMzAsOCBAQCBzdGF0aWMgaW50IGlwdjRfcHJpdmlsZWdl
ZF9wb3J0cyhzdHJ1Y3QgY3RsX3RhYmxlICp0YWJsZSwgaW50IHdyaXRlLAogCXJldHVybiByZXQ7
CiB9CiAKLXN0YXRpYyB2b2lkIGluZXRfZ2V0X3BpbmdfZ3JvdXBfcmFuZ2VfdGFibGUoc3RydWN0
IGN0bF90YWJsZSAqdGFibGUsIGtnaWRfdCAqbG93LCBrZ2lkX3QgKmhpZ2gpCitzdGF0aWMgdm9p
ZCBpbmV0X2dldF9waW5nX2dyb3VwX3JhbmdlX3RhYmxlKGNvbnN0IHN0cnVjdCBjdGxfdGFibGUg
KnRhYmxlLAorCQkJCQkgICAga2dpZF90ICpsb3csIGtnaWRfdCAqaGlnaCkKIHsKIAlrZ2lkX3Qg
KmRhdGEgPSB0YWJsZS0+ZGF0YTsKIAlzdHJ1Y3QgbmV0ICpuZXQgPQpAQCAtMTQ1LDcgKzE0Niw4
IEBAIHN0YXRpYyB2b2lkIGluZXRfZ2V0X3BpbmdfZ3JvdXBfcmFuZ2VfdGFibGUoc3RydWN0IGN0
bF90YWJsZSAqdGFibGUsIGtnaWRfdCAqbG93CiB9CiAKIC8qIFVwZGF0ZSBzeXN0ZW0gdmlzaWJs
ZSBJUCBwb3J0IHJhbmdlICovCi1zdGF0aWMgdm9pZCBzZXRfcGluZ19ncm91cF9yYW5nZShzdHJ1
Y3QgY3RsX3RhYmxlICp0YWJsZSwga2dpZF90IGxvdywga2dpZF90IGhpZ2gpCitzdGF0aWMgdm9p
ZCBzZXRfcGluZ19ncm91cF9yYW5nZShjb25zdCBzdHJ1Y3QgY3RsX3RhYmxlICp0YWJsZSwKKwkJ
CQkga2dpZF90IGxvdywga2dpZF90IGhpZ2gpCiB7CiAJa2dpZF90ICpkYXRhID0gdGFibGUtPmRh
dGE7CiAJc3RydWN0IG5ldCAqbmV0ID0KCi0tIAoyLjQ0LjAKCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlz
dHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2tleGVjCg==
