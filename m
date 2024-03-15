Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2715CD1283
	for <kexec@archiver.kernel.org>; Wed, 27 Mar 2024 18:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References:Message-Id
	:MIME-Version:Subject:Date:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rq2TdgSH+8ifDs6Hpe45TM09WwIa0NVnDo3vORjKBmI=; b=QBIg79aqgDc8o4
	Y3UTN0SgHDsOjXhvyn0yKMe1vuGCZP7arkv3RzoakGhd88h7r4GpU1WoC1DfPIXL+8f6eFeYlvpY3
	cph3bbQvd19vo4jQycAQUrLCUXgg8t6k/YGxGz/pMLII8NH298T6yyTRtuiF30RRTFdgrXB45GFtF
	RBFC7vfCD8Fwgb2lx9Zt3T0oNLgkFexxB5YohAtiu9yzN/am7BDgtfr5BVwDXW2kkE7mDRKBwQVWh
	aAUnEXN+yqMdy4yoraH7V5Nb7vmDk9R30o9JnrGXO6oNr3Gtde8nEP0b4tcAnLohgSYOQVfUbFMCq
	56lH6tAAGHi92S9yneGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpXb2-0000000ARbP-2IP9;
	Wed, 27 Mar 2024 18:01:56 +0000
Received: from todd.t-8ch.de ([2a01:4f8:c010:41de::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rlEUZ-00000001Xdn-3jVw;
	Fri, 15 Mar 2024 20:49:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1710535766;
	bh=ioYxjFgUhmgN64D7EqS9neBKa6VPb6OHx0+I2+vtq58=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=e0gHJn00rSPUSnJb+Jx6Ue3JxL9G0ZFpDZfWcshPnrqNLXF6mANtn7ZfmJdYtl2NH
	 YF0nBfN7moHOVik9J5dzylQWjTUZQmTvqHZPgWQvbx9+WfDiZxC6O7h1e5C9Jdj55S
	 lS7uTWKuOD2g2Cdt0l4N3qosPhGD2Ex77cb84CDs=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Fri, 15 Mar 2024 21:48:08 +0100
Subject: [PATCH 10/11] sysctl: constify ctl_table arguments of utility
 function
MIME-Version: 1.0
Message-Id: <20240315-sysctl-const-handler-v1-10-1322ac7cb03d@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710535695; l=4555;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=ioYxjFgUhmgN64D7EqS9neBKa6VPb6OHx0+I2+vtq58=;
 b=3ezsimD4t+3/T0cNPSQ4+FYpRTQhNYyohAK+Rbgx8HlPQ+xGzze+WEFqLcmmpL3mfNQxqYUX7
 1t4oHVoJb7wAVyGZrGoUFlfOOhXQ+0lakf0I5Pzjxrct2orfuAx6LgW
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240315_134928_151854_5BA40FE1 
X-CRM114-Status: GOOD (  15.61  )
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
IGFkYXB0IHRoZSBpbnRlcm5hbApoZWxwZXIuCgpTaWduZWQtb2ZmLWJ5OiBUaG9tYXMgV2Vpw59z
Y2h1aCA8bGludXhAd2Vpc3NzY2h1aC5uZXQ+Ci0tLQogaW5jbHVkZS9saW51eC9zeXNjdGwuaCB8
ICAyICstCiBrZXJuZWwvc3lzY3RsLmMgICAgICAgIHwgMjEgKysrKysrKysrKystLS0tLS0tLS0t
CiAyIGZpbGVzIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQoKZGlm
ZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvc3lzY3RsLmggYi9pbmNsdWRlL2xpbnV4L3N5c2N0bC5o
CmluZGV4IGVlN2QzM2I4OWU5ZS4uOTllYTI2YjE2YzBkIDEwMDY0NAotLS0gYS9pbmNsdWRlL2xp
bnV4L3N5c2N0bC5oCisrKyBiL2luY2x1ZGUvbGludXgvc3lzY3RsLmgKQEAgLTIzOCw3ICsyMzgs
NyBAQCBleHRlcm4gc3RydWN0IGN0bF90YWJsZV9oZWFkZXIgKnJlZ2lzdGVyX3N5c2N0bF9tb3Vu
dF9wb2ludChjb25zdCBjaGFyICpwYXRoKTsKIAogdm9pZCBkb19zeXNjdGxfYXJncyh2b2lkKTsK
IGJvb2wgc3lzY3RsX2lzX2FsaWFzKGNoYXIgKnBhcmFtKTsKLWludCBkb19wcm9jX2RvdWludHZl
YyhzdHJ1Y3QgY3RsX3RhYmxlICp0YWJsZSwgaW50IHdyaXRlLAoraW50IGRvX3Byb2NfZG91aW50
dmVjKGNvbnN0IHN0cnVjdCBjdGxfdGFibGUgKnRhYmxlLCBpbnQgd3JpdGUsCiAJCSAgICAgIHZv
aWQgKmJ1ZmZlciwgc2l6ZV90ICpsZW5wLCBsb2ZmX3QgKnBwb3MsCiAJCSAgICAgIGludCAoKmNv
bnYpKHVuc2lnbmVkIGxvbmcgKmx2YWxwLAogCQkJCSAgdW5zaWduZWQgaW50ICp2YWxwLApkaWZm
IC0tZ2l0IGEva2VybmVsL3N5c2N0bC5jIGIva2VybmVsL3N5c2N0bC5jCmluZGV4IDE1N2Y3Y2Uy
OTQyZC4uOTM4MjRkOGEzNjM2IDEwMDY0NAotLS0gYS9rZXJuZWwvc3lzY3RsLmMKKysrIGIva2Vy
bmVsL3N5c2N0bC5jCkBAIC0yMDUsNyArMjA1LDcgQEAgc3RhdGljIGludCBfcHJvY19kb19zdHJp
bmcoY2hhciAqZGF0YSwgaW50IG1heGxlbiwgaW50IHdyaXRlLAogCXJldHVybiAwOwogfQogCi1z
dGF0aWMgdm9pZCB3YXJuX3N5c2N0bF93cml0ZShzdHJ1Y3QgY3RsX3RhYmxlICp0YWJsZSkKK3N0
YXRpYyB2b2lkIHdhcm5fc3lzY3RsX3dyaXRlKGNvbnN0IHN0cnVjdCBjdGxfdGFibGUgKnRhYmxl
KQogewogCXByX3dhcm5fb25jZSgiJXMgd3JvdGUgdG8gJXMgd2hlbiBmaWxlIHBvc2l0aW9uIHdh
cyBub3QgMCFcbiIKIAkJIlRoaXMgd2lsbCBub3QgYmUgc3VwcG9ydGVkIGluIHRoZSBmdXR1cmUu
IFRvIHNpbGVuY2UgdGhpc1xuIgpAQCAtMjIzLDcgKzIyMyw3IEBAIHN0YXRpYyB2b2lkIHdhcm5f
c3lzY3RsX3dyaXRlKHN0cnVjdCBjdGxfdGFibGUgKnRhYmxlKQogICogaGFuZGxlcnMgY2FuIGln
bm9yZSB0aGUgcmV0dXJuIHZhbHVlLgogICovCiBzdGF0aWMgYm9vbCBwcm9jX2ZpcnN0X3Bvc19u
b25femVyb19pZ25vcmUobG9mZl90ICpwcG9zLAotCQkJCQkgICBzdHJ1Y3QgY3RsX3RhYmxlICp0
YWJsZSkKKwkJCQkJICAgY29uc3Qgc3RydWN0IGN0bF90YWJsZSAqdGFibGUpCiB7CiAJaWYgKCEq
cHBvcykKIAkJcmV0dXJuIGZhbHNlOwpAQCAtNDY4LDcgKzQ2OCw3IEBAIHN0YXRpYyBpbnQgZG9f
cHJvY19kb3VpbnR2ZWNfY29udih1bnNpZ25lZCBsb25nICpsdmFscCwKIAogc3RhdGljIGNvbnN0
IGNoYXIgcHJvY193c3BhY2Vfc2VwW10gPSB7ICcgJywgJ1x0JywgJ1xuJyB9OwogCi1zdGF0aWMg
aW50IF9fZG9fcHJvY19kb2ludHZlYyh2b2lkICp0YmxfZGF0YSwgc3RydWN0IGN0bF90YWJsZSAq
dGFibGUsCitzdGF0aWMgaW50IF9fZG9fcHJvY19kb2ludHZlYyh2b2lkICp0YmxfZGF0YSwgY29u
c3Qgc3RydWN0IGN0bF90YWJsZSAqdGFibGUsCiAJCSAgaW50IHdyaXRlLCB2b2lkICpidWZmZXIs
CiAJCSAgc2l6ZV90ICpsZW5wLCBsb2ZmX3QgKnBwb3MsCiAJCSAgaW50ICgqY29udikoYm9vbCAq
bmVncCwgdW5zaWduZWQgbG9uZyAqbHZhbHAsIGludCAqdmFscCwKQEAgLTU0MSw3ICs1NDEsNyBA
QCBzdGF0aWMgaW50IF9fZG9fcHJvY19kb2ludHZlYyh2b2lkICp0YmxfZGF0YSwgc3RydWN0IGN0
bF90YWJsZSAqdGFibGUsCiAJcmV0dXJuIGVycjsKIH0KIAotc3RhdGljIGludCBkb19wcm9jX2Rv
aW50dmVjKHN0cnVjdCBjdGxfdGFibGUgKnRhYmxlLCBpbnQgd3JpdGUsCitzdGF0aWMgaW50IGRv
X3Byb2NfZG9pbnR2ZWMoY29uc3Qgc3RydWN0IGN0bF90YWJsZSAqdGFibGUsIGludCB3cml0ZSwK
IAkJICB2b2lkICpidWZmZXIsIHNpemVfdCAqbGVucCwgbG9mZl90ICpwcG9zLAogCQkgIGludCAo
KmNvbnYpKGJvb2wgKm5lZ3AsIHVuc2lnbmVkIGxvbmcgKmx2YWxwLCBpbnQgKnZhbHAsCiAJCQkg
ICAgICBpbnQgd3JpdGUsIHZvaWQgKmRhdGEpLApAQCAtNTUyLDcgKzU1Miw3IEBAIHN0YXRpYyBp
bnQgZG9fcHJvY19kb2ludHZlYyhzdHJ1Y3QgY3RsX3RhYmxlICp0YWJsZSwgaW50IHdyaXRlLAog
fQogCiBzdGF0aWMgaW50IGRvX3Byb2NfZG91aW50dmVjX3codW5zaWduZWQgaW50ICp0YmxfZGF0
YSwKLQkJCSAgICAgICBzdHJ1Y3QgY3RsX3RhYmxlICp0YWJsZSwKKwkJCSAgICAgICBjb25zdCBz
dHJ1Y3QgY3RsX3RhYmxlICp0YWJsZSwKIAkJCSAgICAgICB2b2lkICpidWZmZXIsCiAJCQkgICAg
ICAgc2l6ZV90ICpsZW5wLCBsb2ZmX3QgKnBwb3MsCiAJCQkgICAgICAgaW50ICgqY29udikodW5z
aWduZWQgbG9uZyAqbHZhbHAsCkBAIC02MzksNyArNjM5LDcgQEAgc3RhdGljIGludCBkb19wcm9j
X2RvdWludHZlY19yKHVuc2lnbmVkIGludCAqdGJsX2RhdGEsIHZvaWQgKmJ1ZmZlciwKIAlyZXR1
cm4gZXJyOwogfQogCi1zdGF0aWMgaW50IF9fZG9fcHJvY19kb3VpbnR2ZWModm9pZCAqdGJsX2Rh
dGEsIHN0cnVjdCBjdGxfdGFibGUgKnRhYmxlLAorc3RhdGljIGludCBfX2RvX3Byb2NfZG91aW50
dmVjKHZvaWQgKnRibF9kYXRhLCBjb25zdCBzdHJ1Y3QgY3RsX3RhYmxlICp0YWJsZSwKIAkJCSAg
ICAgICBpbnQgd3JpdGUsIHZvaWQgKmJ1ZmZlciwKIAkJCSAgICAgICBzaXplX3QgKmxlbnAsIGxv
ZmZfdCAqcHBvcywKIAkJCSAgICAgICBpbnQgKCpjb252KSh1bnNpZ25lZCBsb25nICpsdmFscCwK
QEAgLTY3NSw3ICs2NzUsNyBAQCBzdGF0aWMgaW50IF9fZG9fcHJvY19kb3VpbnR2ZWModm9pZCAq
dGJsX2RhdGEsIHN0cnVjdCBjdGxfdGFibGUgKnRhYmxlLAogCXJldHVybiBkb19wcm9jX2RvdWlu
dHZlY19yKGksIGJ1ZmZlciwgbGVucCwgcHBvcywgY29udiwgZGF0YSk7CiB9CiAKLWludCBkb19w
cm9jX2RvdWludHZlYyhzdHJ1Y3QgY3RsX3RhYmxlICp0YWJsZSwgaW50IHdyaXRlLAoraW50IGRv
X3Byb2NfZG91aW50dmVjKGNvbnN0IHN0cnVjdCBjdGxfdGFibGUgKnRhYmxlLCBpbnQgd3JpdGUs
CiAJCSAgICAgIHZvaWQgKmJ1ZmZlciwgc2l6ZV90ICpsZW5wLCBsb2ZmX3QgKnBwb3MsCiAJCSAg
ICAgIGludCAoKmNvbnYpKHVuc2lnbmVkIGxvbmcgKmx2YWxwLAogCQkJCSAgdW5zaWduZWQgaW50
ICp2YWxwLApAQCAtMTAyMyw4ICsxMDIzLDkgQEAgc3RhdGljIGludCBzeXNycV9zeXNjdGxfaGFu
ZGxlcihzdHJ1Y3QgY3RsX3RhYmxlICp0YWJsZSwgaW50IHdyaXRlLAogfQogI2VuZGlmCiAKLXN0
YXRpYyBpbnQgX19kb19wcm9jX2RvdWxvbmd2ZWNfbWlubWF4KHZvaWQgKmRhdGEsIHN0cnVjdCBj
dGxfdGFibGUgKnRhYmxlLAotCQlpbnQgd3JpdGUsIHZvaWQgKmJ1ZmZlciwgc2l6ZV90ICpsZW5w
LCBsb2ZmX3QgKnBwb3MsCitzdGF0aWMgaW50IF9fZG9fcHJvY19kb3Vsb25ndmVjX21pbm1heCh2
b2lkICpkYXRhLAorCQljb25zdCBzdHJ1Y3QgY3RsX3RhYmxlICp0YWJsZSwgaW50IHdyaXRlLAor
CQl2b2lkICpidWZmZXIsIHNpemVfdCAqbGVucCwgbG9mZl90ICpwcG9zLAogCQl1bnNpZ25lZCBs
b25nIGNvbnZtdWwsIHVuc2lnbmVkIGxvbmcgY29udmRpdikKIHsKIAl1bnNpZ25lZCBsb25nICpp
LCAqbWluLCAqbWF4OwpAQCAtMTA5Niw3ICsxMDk3LDcgQEAgc3RhdGljIGludCBfX2RvX3Byb2Nf
ZG91bG9uZ3ZlY19taW5tYXgodm9pZCAqZGF0YSwgc3RydWN0IGN0bF90YWJsZSAqdGFibGUsCiAJ
cmV0dXJuIGVycjsKIH0KIAotc3RhdGljIGludCBkb19wcm9jX2RvdWxvbmd2ZWNfbWlubWF4KHN0
cnVjdCBjdGxfdGFibGUgKnRhYmxlLCBpbnQgd3JpdGUsCitzdGF0aWMgaW50IGRvX3Byb2NfZG91
bG9uZ3ZlY19taW5tYXgoY29uc3Qgc3RydWN0IGN0bF90YWJsZSAqdGFibGUsIGludCB3cml0ZSwK
IAkJdm9pZCAqYnVmZmVyLCBzaXplX3QgKmxlbnAsIGxvZmZfdCAqcHBvcywgdW5zaWduZWQgbG9u
ZyBjb252bXVsLAogCQl1bnNpZ25lZCBsb25nIGNvbnZkaXYpCiB7CgotLSAKMi40NC4wCgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGlu
ZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5v
cmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
