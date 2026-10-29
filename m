Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3530606A31A
	for <kexec@archiver.kernel.org>; Thu, 29 Oct 2026 09:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=r6+icaSZ;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=YuiZSbAB
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=go4dra+4YH06N3EmUqzNTwrDp7mjFjmaeDVnD3tSruE=; b=r6+icaSZQnKx/TLRfYviD3TqWd
	8FLd9GbgUmS/80kriq6H0WFWIlGsK9IVVlCs/wmygKzCwJLmXeIVxym8mQysKyPsJnf5514lwwqry
	fKoB/9GU1sku07kjjBn+JUjGSgMoCw9cCRG/K1cpYEat2o6w7Qardbf4lYvbR1RBVZ1g7USvf/qQt
	XjxZs1uAvmqZdIQdHtdk3AbgN7lz+J+fbwb3u8SjZ1xqcH7usotQNeVFirZWmL7vy6bwQ23TI9Jpk
	y5bl/Sin8+568DT36JXGb75IXJnqDoHEYsuhKbwDWDLhfjV4jRpiy4vne+s7yEk56ioxsenP30nmq
	dSi+yezw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMM5N-00000008o82-1qPH;
	Thu, 29 Oct 2026 09:06:13 +0000
Received: from out-81.mta1.migadu.com ([95.215.58.81] helo=mta1.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMM5F-00000008o6n-074P
	for kexec@lists.infradead.org;
	Thu, 29 Oct 2026 09:06:11 +0000
X-Envelope-To: kexec@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=DYXaWemXvBwC95FCj8igDWaYEMt1wgMdHlRzj74nyZo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793264760; v=1; x=1793869560;
 b=YuiZSbABTER+omjjyXPzKhHlur2Uqj1Jta1IouI2KDmN4MHDWjbGkTD5cwLw/5v2XlxD8xce
 kvkXCgD9BomAqNyvzox09YHSQLdTyQ72qUwNZxOrQ4RpZdU25z01QqEljCpeJW3NqRJSc6SevDY
 7AMwL0Z+MaFZrhhHJqa9nH9A=
X-Envelope-To: kexec@lists.infradead.org
Received: by smtp.migadu.com with ESMTPS id 44560a5e9cf9788f;
	Thu, 29 Oct 2026 09:05:59 +0000
X-Mizu-Trace-ID: 44560a5e9cf9788f
X-Migadu-Flow: FLOW_OUT
From: George Guo <dongtai.guo@linux.dev>
To: pasha.tatashin@soleen.com,
	rppt@kernel.org,
	pratyush@kernel.org,
	shuah@kernel.org
Cc: guodongtai@kylinos.cn,
	kexec@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/liveupdate: Preserve VM workspaces with run-vmtests.sh -k
Date: Thu, 29 Oct 2026 18:05:42 +0900
Message-ID: <20261029090542.13283-1-dongtai.guo@linux.dev>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261029_020606_200168_AE658513 
X-CRM114-Status: UNSURE (   8.73  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -2.1 (--)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: George Guo <guodongtai@kylinos.cn>

run-vmtests.sh -k keeps the test output logs, but vmtest.sh still
removes its workspace and qemu.serial, losing the guest output needed
to debug failures.

Forward -k to vmtest.sh when keeping logs and update the help texts to
match.

Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 tools/testing/selftests/liveupdate/run-vmtests.sh | 7 +++++--
 tools/testing/selftests/liveupdate/vmtest.sh      | 2 +-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/liveupdate/run-vmtests.sh b/tools/testing/selftests/liveupdate/run-vmtests.sh
index d656ce58c5a7..6f592aec0f85 100755
--- a/tools/testing/selftests/liveupdate/run-vmtests.sh
+++ b/tools/testing/selftests/liveupdate/run-vmtests.sh
@@ -26,7 +26,7 @@ function usage() {
 	cat <<EOF
 $0 [-k] [-o output_dir] [-h]
 Options:
-	-k)	keep logs
+	-k)	keep logs and VM workspaces, including guest serial logs
 	-o)	specify output directory
 	-h)	display this help
 EOF
@@ -48,6 +48,8 @@ function fail() {
 }
 
 function main() {
+	local -a vmtest_args=()
+
 	while getopts 'hko:' opt; do
 		case $opt in
 		k) keep_logs=1 ;;
@@ -59,6 +61,7 @@ function main() {
 	done
 
 	if [ -n "$keep_logs" ]; then
+		vmtest_args+=(-k)
 		if [ -z "$output_dir" ]; then
 			output_dir="$SCRIPT_DIR/results_$(date +%Y%m%d_%H%M%S)"
 		fi;
@@ -74,7 +77,7 @@ function main() {
 
 			printf "  -> %-8s %-24s ... " "$arch" "$test_name"
 
-			"$TEST_RUNNER" -t "$arch" -T "$test_name" &> "$log"
+			"$TEST_RUNNER" "${vmtest_args[@]}" -t "$arch" -T "$test_name" &> "$log"
 			exit_code=$?
 
 			case $exit_code in
diff --git a/tools/testing/selftests/liveupdate/vmtest.sh b/tools/testing/selftests/liveupdate/vmtest.sh
index 69beda6c961d..bd7032c4b122 100755
--- a/tools/testing/selftests/liveupdate/vmtest.sh
+++ b/tools/testing/selftests/liveupdate/vmtest.sh
@@ -40,7 +40,7 @@ Options:
 	-t)	run test for target_arch (aarch64, x86_64)
 	-T)	test name to run (default: luo_kexec_simple)
 	-w)	custom workspace directory (default: creates temp dir)
-	-k)	keep workspace directory after successful test
+	-k)	keep workspace directory
 	-h)	display this help
 EOF
 }

base-commit: 9a6a70aefe77f6fb9ff2b3037dcf87f6dff65c8c
-- 
2.53.0


