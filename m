Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40AFCCD1287
	for <kexec@archiver.kernel.org>; Wed, 27 Mar 2024 19:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References:Message-Id
	:MIME-Version:Subject:Date:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=o7LGvbKgSkjLS3ubq+xoJW4hBpC9P1xexsqyW/u0d1k=; b=BRjKQlK6CB8SFk
	TpFQOF4zDRWTcJASeQ1TnlYRAp3ws7u0DxNLK6vSyHd+ysPNVAg3cVIW72QpPp+rViTQh4o27gh+S
	J/bywOJGnOGHeAOnM6OSYD3GokOcPWC0fnvPV/zk9Ifu3F+IyFRdTxCtwIOx3FNDawo4mOHiVSao6
	86TTX690Dit62w/xmvsVse1l6jZd+7uUI0wylXt5N7sEsSoOVFGdyW3Xl0kk6mytTU66f6YLRco4+
	9lvKYFAL+dUH0SRchTl4VvKiPIfXJiM7ULsKI6sMUtp1Wdx87oW6nyJSpfgBlTJlyADDgSZAiuxQe
	Ct4So9J9VpitIH/Q6eaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpYYV-0000000AheE-3lpd;
	Wed, 27 Mar 2024 19:03:23 +0000
Received: from todd.t-8ch.de ([159.69.126.157])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rlETX-00000001X30-04W1;
	Fri, 15 Mar 2024 20:48:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1710535696;
	bh=H2m3CgyPxKp8J+A7s6etu+nqQuMydVMaRq2xUBYcaE4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KAKMyTIrxsBKgzyowba560Va0oJiD0MsSOpq/KKmIhQMjwW/Y1aOE3/Dn8oyWJu3Q
	 ch5t4fh43gRp6lXO3u/WZdPgPrZC1ZY1fTdYnJOWWejpqsv3ZFOQdJBBdBPCMymWyi
	 mjiCD+xXA6BByHT9/rUXPnIE44pC/sa/0O7fCWDk=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Fri, 15 Mar 2024 21:47:59 +0100
Subject: [PATCH 01/11] stackleak: don't modify ctl_table argument
MIME-Version: 1.0
Message-Id: <20240315-sysctl-const-handler-v1-1-1322ac7cb03d@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710535695; l=1205;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=H2m3CgyPxKp8J+A7s6etu+nqQuMydVMaRq2xUBYcaE4=;
 b=DLCpjj80ePju45B1sM6SeMu3SU3+SovEAF9F+apF8HUTZcbHxhK7sFWDz+WraIYUf5lzi8ctP
 25gNqwcr0i1CjOhkjNKarmdmKbieJ/tL+nZegKGxX2K6TvuJVTedQUi
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240315_134823_250822_64933834 
X-CRM114-Status: GOOD (  13.86  )
X-Mailman-Approved-At: Wed, 27 Mar 2024 11:01:49 -0700
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

SW4gYSBmdXR1cmUgY29tbWl0IHRoZSBwcm9jX2hhbmRsZXJzIHdpbGwgY2hhbmdlIHRvCiJjb25z
dCBzdHJ1Y3QgY3RsX3RhYmxlIi4KQXMgYSBwcmVwYXJhdGlvbiBmb3IgdGhhdCBhZGFwdCB0aGUg
bG9naWMgdG8gd29yayB3aXRoIGEgdGVtcG9yYXJ5CnZhcmlhYmxlLCBzaW1pbGFyIHRvIGhvdyBp
dCBpcyBkb25lIGluIG90aGVyIHBhcnRzIG9mIHRoZSBrZXJuZWwuCgpGaXhlczogOTY0YzlkZmYw
MDkxICgic3RhY2tsZWFrOiBBbGxvdyBydW50aW1lIGRpc2FibGluZyBvZiBrZXJuZWwgc3RhY2sg
ZXJhc2luZyIpCkFja2VkLWJ5OiBLZWVzIENvb2sgPGtlZXNjb29rQGNocm9taXVtLm9yZz4KU2ln
bmVkLW9mZi1ieTogVGhvbWFzIFdlacOfc2NodWggPGxpbnV4QHdlaXNzc2NodWgubmV0PgotLS0K
IGtlcm5lbC9zdGFja2xlYWsuYyB8IDcgKysrKy0tLQogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0
aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9rZXJuZWwvc3RhY2tsZWFrLmMg
Yi9rZXJuZWwvc3RhY2tsZWFrLmMKaW5kZXggMzRjOWQ4MWVlYTk0Li5iMjkyZTVjYTBiN2QgMTAw
NjQ0Ci0tLSBhL2tlcm5lbC9zdGFja2xlYWsuYworKysgYi9rZXJuZWwvc3RhY2tsZWFrLmMKQEAg
LTI3LDEwICsyNywxMSBAQCBzdGF0aWMgaW50IHN0YWNrX2VyYXNpbmdfc3lzY3RsKHN0cnVjdCBj
dGxfdGFibGUgKnRhYmxlLCBpbnQgd3JpdGUsCiAJaW50IHJldCA9IDA7CiAJaW50IHN0YXRlID0g
IXN0YXRpY19icmFuY2hfdW5saWtlbHkoJnN0YWNrX2VyYXNpbmdfYnlwYXNzKTsKIAlpbnQgcHJl
dl9zdGF0ZSA9IHN0YXRlOworCXN0cnVjdCBjdGxfdGFibGUgdG1wID0gKnRhYmxlOwogCi0JdGFi
bGUtPmRhdGEgPSAmc3RhdGU7Ci0JdGFibGUtPm1heGxlbiA9IHNpemVvZihpbnQpOwotCXJldCA9
IHByb2NfZG9pbnR2ZWNfbWlubWF4KHRhYmxlLCB3cml0ZSwgYnVmZmVyLCBsZW5wLCBwcG9zKTsK
Kwl0bXAuZGF0YSA9ICZzdGF0ZTsKKwl0bXAubWF4bGVuID0gc2l6ZW9mKGludCk7CisJcmV0ID0g
cHJvY19kb2ludHZlY19taW5tYXgoJnRtcCwgd3JpdGUsIGJ1ZmZlciwgbGVucCwgcHBvcyk7CiAJ
c3RhdGUgPSAhIXN0YXRlOwogCWlmIChyZXQgfHwgIXdyaXRlIHx8IHN0YXRlID09IHByZXZfc3Rh
dGUpCiAJCXJldHVybiByZXQ7CgotLSAKMi40NC4wCgoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmlu
ZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9r
ZXhlYwo=
