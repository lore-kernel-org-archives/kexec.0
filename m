Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A5360805B3
	for <kexec@archiver.kernel.org>; Mon,  2 Nov 2026 15:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=K+NiXtG2;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FGVXtx2l
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=SERWfo+CWfVylpcb5SSH7tU3Bq6GtJcVFRC89lRnVyE=; b=K+NiXtG2JdAWLj
	Z7sbG7qnj3ZvFz9YxcPy0ZSMLUQ4LrZ0z0fKetBL/nzlOzTvpHHvS8VEETzTrgt59mTKKOLUcmgPR
	qw1Nmd7sry2qGZt42J8WTKGHC1J6WwT24d0iQK9QegcTnF+ijSDCByf486j88ClEarXCWwyIIR/9J
	4SPPMpRDbxAPhhNjb/TCl0ZawwtdMAZcHPBECBXFkp9js/bpRR0PSiqn5eSGzB848JZ4yetZDaPSL
	9J55Q8nlKdtghiATVDTBeIkmCxsq3u3t6h64sJHrpwrInooG4SmBSQsuDjxPxGIRu0mAVYGsvjydf
	ASfktj0xXX5rbRO4FXjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNtrK-0000000H3yo-3XY0;
	Mon, 02 Nov 2026 15:22:06 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNtrG-0000000H3vv-3v2J
	for kexec@lists.infradead.org;
	Mon, 02 Nov 2026 15:22:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793632919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SERWfo+CWfVylpcb5SSH7tU3Bq6GtJcVFRC89lRnVyE=;
	b=FGVXtx2l6XNickHJWeKppED1CgLV76PQioDYOyH4FzoGJQp/S0m+91w4l+sBdzfpqADA0C
	IUq1wr3JxqDzU9MO0kjKUnSZuSIb8lRgrrDvTksaW51t73D7wDLWzO/j2j8ufGR8OfdEbZ
	ySwso1AGeFTykb4yelUZe6o6IvvohvQ=
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-ZVIz_TnIMGOPCfatn7rH7Q-1; Mon, 02 Nov 2026 10:21:58 -0500
X-MC-Unique: ZVIz_TnIMGOPCfatn7rH7Q-1
X-Mimecast-MFC-AGG-ID: ZVIz_TnIMGOPCfatn7rH7Q_1793632917
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-351788121cfso3066462eec.0
        for <kexec@lists.infradead.org>; Mon, 02 Nov 2026 07:21:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793632917; x=1794237717;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SERWfo+CWfVylpcb5SSH7tU3Bq6GtJcVFRC89lRnVyE=;
        b=S8UWGBv5dQB3r516t0weOttFft9jp0lvOArlM6KAvA8NineGFJ3e1oK7apHIPYElu0
         RiomOhQqSsnFaRLIljnVPVg3cJPGZZCU20WeZxbVuNQ+FA35h8dzbT3GQ8XCQKmsfp7n
         CgfT600FeU9w4rmiFI6F8/Jh8SNZ4QxMivh3+E04kIkcnbNL+wAOSgFFd0V+l0gQMIbt
         Pp1Pvc8qTgLvUBskKxiBYKjE1DkS9BM1b/PP1z4qMWOC234REqVulYiBwmUUwFXLfiBZ
         FAALHooxiOjkyh6m94rMIGd1b0y/IeDvW5MTI0NVecCmHz8Rknc06utAw6WfXwI5v3zN
         JR/g==
X-Gm-Message-State: AFq9FYISDpGtB9GbxWlAqqGrvnn67w8v7Ak1AWCRmtFgcb8Ak1TNUyBD
	ZB9kMsMICc5WFEiv1vSgiStJ/wR7DeTbqdJwMkJJ8WjrdEklrPYEd20B5nPSjZCI+PDnBA1Co0x
	ohmMPusDXfu0aDZIYdpI0lwReuFnshrxUaHs6SMpPtYx6KCqMd43C6KxkGY7epA1exgSgO9dKdB
	ugW5SuABFvckF/AhYBhvgQf6ufWt0XZMLUCptkzHutrx37UQ==
X-Gm-Gg: AYBFou2QhF03m6bJqj9xwRVGdRXlzyldtxXYLRxoLgW26GKPBQhLuARdlBlrRA0HYrR
	9bu6Y/wozkyh3NTs+KWPTDib7BCNtGZ2kYh0e1VSBW1o3xysOIZxT3Pgb021jMSfN2HpLilgBDo
	r7sYcyXcQNFHWE33hOxh7jmBAbtXlgHYjtercakyqj7Hksrb9D2qLoDT7vF6WI7+ajooILShSqK
	R2nv6CCyMDkfAfQUBw1Kg3Zki5w1ayRl+NdXCjO8qHRLZgnFqO1I/ImcrCMJTlB4Y6LC5mcxyYL
	um1goa14yLPusAPzcyXWmyTXO97j+wjbaxvGIHJWrpBpfBUmw/aPDOeuEZ/GRPYE5SyxKcaOLV8
	p7kWSQ9Q2Do2mQbiJ0rd1322qU/aZ3l4ywICw47QsTNdVuR/xhZ5Ir4icH2agXpEpl7oCNZ+In0
	vrv7wT0hVsUOT6sNXjJ+WSxpxaR5m6fODcf9PCjwKnDxE=
X-Received: by 2002:a05:7022:eb55:10b0:168:3243:c90c with SMTP id a92af1059eb24-1ac59dd356cmr16566506c88.15.1793632916855;
        Mon, 02 Nov 2026 07:21:56 -0800 (PST)
X-Received: by 2002:a05:7022:eb55:10b0:168:3243:c90c with SMTP id a92af1059eb24-1ac59dd356cmr16566438c88.15.1793632915716;
        Mon, 02 Nov 2026 07:21:55 -0800 (PST)
Received: from ?IPV6:2401:4900:1cc4:ec63:d913:9793:cfad:cfb8? ([2401:4900:1cc4:ec63:d913:9793:cfad:cfb8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1b38ac58sm33734923c88.23.2026.11.02.07.21.52
        for <kexec@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 07:21:53 -0800 (PST)
Message-ID: <dcd72c30-06d7-453b-83bc-28ae2cfdb6ce@redhat.com>
Date: Mon, 2 Nov 2026 20:51:51 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/liveupdate: Preserve VM workspaces with
 run-vmtests.sh -k
To: kexec@lists.infradead.org
References: <20261029090542.13283-1-dongtai.guo@linux.dev>
From: Mukesh Pilaniya <mpilaniy@redhat.com>
In-Reply-To: <20261029090542.13283-1-dongtai.guo@linux.dev>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LDvoLI8X2iEgEEPNSJ_MggWuxmmJMM6R96OtMBNoPi8_1793632917
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261102_072203_058463_F3DB3AE1 
X-CRM114-Status: GOOD (  20.03  )
X-Spam-Score: -2.8 (--)
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
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi George,

On 29/10/26 2:35 pm, George Guo wrote:
> From: George Guo <guodongtai@kylinos.cn>
> 
> run-vmtests.sh -k keeps the test output logs, but vmtest.sh still
> removes its workspace and qemu.serial, losing the guest output needed
> to debug failures.
> 
> Forward -k to vmtest.sh when keeping logs and update the help texts to
> match.
> 
> Signed-off-by: George Guo <guodongtai@kylinos.cn>
> ---
>  tools/testing/selftests/liveupdate/run-vmtests.sh | 7 +++++--
>  tools/testing/selftests/liveupdate/vmtest.sh      | 2 +-
>  2 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/liveupdate/run-vmtests.sh b/tools/testing/selftests/liveupdate/run-vmtests.sh
> index d656ce58c5a7..6f592aec0f85 100755
> --- a/tools/testing/selftests/liveupdate/run-vmtests.sh
> +++ b/tools/testing/selftests/liveupdate/run-vmtests.sh
> @@ -26,7 +26,7 @@ function usage() {
>  	cat <<EOF
>  $0 [-k] [-o output_dir] [-h]
>  Options:
> -	-k)	keep logs
> +	-k)	keep logs and VM workspaces, including guest serial logs
>  	-o)	specify output directory
>  	-h)	display this help
>  EOF
> @@ -48,6 +48,8 @@ function fail() {
>  }
>  
>  function main() {
> +	local -a vmtest_args=()
> +
>  	while getopts 'hko:' opt; do
>  		case $opt in
>  		k) keep_logs=1 ;;
> @@ -59,6 +61,7 @@ function main() {
>  	done
>  
>  	if [ -n "$keep_logs" ]; then
> +		vmtest_args+=(-k)
>  		if [ -z "$output_dir" ]; then
>  			output_dir="$SCRIPT_DIR/results_$(date +%Y%m%d_%H%M%S)"
>  		fi;
> @@ -74,7 +77,7 @@ function main() {
>  
>  			printf "  -> %-8s %-24s ... " "$arch" "$test_name"
>  
> -			"$TEST_RUNNER" -t "$arch" -T "$test_name" &> "$log"
> +			"$TEST_RUNNER" "${vmtest_args[@]}" -t "$arch" -T "$test_name" &> "$log"
>  			exit_code=$?
>  
>  			case $exit_code in
the "4) skip;;" branch in run-vmtests.sh can never be hit.

vmtest.sh's skip() exits with $KSFT_SKIP, but the EXIT trap runs
cleanup(),which calls ktap_finished(), and that exits with $KSFT_PASS
when the counts add up to the plan. So "./vmtest.sh -k -t bogus" prints
"ok 1 ... # SKIP" and still exits 0 (and leaves an empty /tmp/luo-test.*
with -k).

That's a pre-existing bug, not caused by forwarding -k, so it may
require a separate fix that keeps the exit status in cleanup()?
Something like saving $? at the top and exiting with it, calling
ktap_finished() only when it's 0. kho/vmtest.sh has the same pattern, so
it probably wants the same fix.

> diff --git a/tools/testing/selftests/liveupdate/vmtest.sh b/tools/testing/selftests/liveupdate/vmtest.sh
> index 69beda6c961d..bd7032c4b122 100755
> --- a/tools/testing/selftests/liveupdate/vmtest.sh
> +++ b/tools/testing/selftests/liveupdate/vmtest.sh
> @@ -40,7 +40,7 @@ Options:
>  	-t)	run test for target_arch (aarch64, x86_64)
>  	-T)	test name to run (default: luo_kexec_simple)
>  	-w)	custom workspace directory (default: creates temp dir)
> -	-k)	keep workspace directory after successful test
> +	-k)	keep workspace directory
>  	-h)	display this help
>  EOF
>  }
> 
> base-commit: 9a6a70aefe77f6fb9ff2b3037dcf87f6dff65c8c

-- 
Regards,
Mukesh Pilaniya


