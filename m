Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6A5606BA40
	for <kexec@archiver.kernel.org>; Mon,  2 Nov 2026 15:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=MMqG5nch;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=B9TgqN2d
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=CSiCxUqhbAqe66y/0HULgn+K+b0JD3EtNzUt5xk4rYo=; b=MMqG5nchegearN
	T3pbcgnbPevwfXgyVXERU/eVSWF5iBxbWhhKB4bHRrI4gbOQRCPheI7kHh2EwW0WgcQHAKFoT+BDq
	bppSnkpfUAiInLn+Zuzbdzh2DrHU2yLeECCFRQ1/zkKQ23vLL5omVGBW2V6rZyV8oZs2FheaLyRLb
	JyJkZ7wYhIUbuSlhn6yUELQo/ftc8hFnm/TCf7KSYmA0CbSzxpn0j/hIcTD7kVsslegJrXFi1VefF
	ZtMAAbZAGhLNrUGJxeVZOXC7TUtughT+uYn+/3pRuqvywMRhsx3RMdYg97Fn2MHhL+W4/fmmndH3+
	r4nyIwq60i4NvnxV49jw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNu44-0000000H8qf-3wZM;
	Mon, 02 Nov 2026 15:35:17 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNu42-0000000H8pW-1W8A
	for kexec@lists.infradead.org;
	Mon, 02 Nov 2026 15:35:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793633713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CSiCxUqhbAqe66y/0HULgn+K+b0JD3EtNzUt5xk4rYo=;
	b=B9TgqN2dcCe4omKVVINnJTZ226m6ahHzYwURpqyodb5XkcmptSVGjtfEUUEP2zkrty6nrf
	mTrMX2lKwhSUtg+NRweDjRsP4fOnQARau1EmoJOuauuQGOVCuyEJMCgIDb8YQ6aS+PfF79
	XhbJxaB1SZvkyJcXezqAsMSiw4W6DTg=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-PnUQVvfdNPuulN7W_s7PSg-1; Mon, 02 Nov 2026 10:35:12 -0500
X-MC-Unique: PnUQVvfdNPuulN7W_s7PSg-1
X-Mimecast-MFC-AGG-ID: PnUQVvfdNPuulN7W_s7PSg_1793633711
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3acd21ba24eso2093013a91.3
        for <kexec@lists.infradead.org>; Mon, 02 Nov 2026 07:35:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793633711; x=1794238511;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CSiCxUqhbAqe66y/0HULgn+K+b0JD3EtNzUt5xk4rYo=;
        b=omdrSlA21XNnXHroU68zB2r4v5fi6TxM44ey5LAKWP9we+3ioM2IUBP8LgRyUfFNq6
         GY2wU2Ui/iVEJtag4mbLzlJmn3CE62vvMfF3JLt/UFuSCgxoMIgUpXPOnmRimoB2WaYu
         UECnEJcrEPjDY+J1BiiZwuF+fmNR4jrOxcz6kzv11upVkSAD4QWDLWIJdnMi1jsK0roh
         EClaO2gRCMdTlltPWpCiij1LR+9gW4GZW7hxPXrxTCBc25vB9k7ssCuUJjQK1afYix3s
         gbc5eBoRdJHckGOAyDQgMHBTXNShh0FwAIm1Dq/d+A1nsL3cv8quvl7x5DXFyf7kpkJx
         oGLw==
X-Forwarded-Encrypted: i=1; AKwUvBwcjMSI8R6lPShntgYo9xvspBiebwMTG97MTh1QdzAVqLndYNiW1gjkdlCxPg42XpsibDcaSQ==@lists.infradead.org
X-Gm-Message-State: APuU4Z9KtPXxUcFbgyFDd7R3FOma+L14X2GpkM/urb4kBXZ9Pct5371J
	iWbCV/ovqXdzwQY8SQEqU6AOM5/8FLpZqtgSY4t8rxwXo440D7hhZgjPijHkXi8kja75F8FB0yd
	+3TzEm3vCVfIQZY+R6x33P968qGh++8XJENs1jKkW/G3hVwr4Ncz5WH/W/FbcQA==
X-Gm-Gg: AYBFou0whE9oDpJFHaRpsm6VRpvS+8WWQL4Zq17fOewuNy/4eCTcRhGHUE+VNIJjbRv
	AF2k2LUPva2ModhM1IwSqHJr3n2QkQ76deOg0xNr6pyfLyrktSLCkpzVl7ZEf9dcGgBTEfIY/07
	BterLgVkwz1auhnXPpz80NqyEjsdjysV4ObWjvxIgG0JSCMEmZ19qDqBRbulnqC0oFh1jZNjZpi
	+X/AkoVeiCKxH0Aj09iNeHDWYirvVmEJqbF7A5qERXVZXnt5nJdSvZFBWNVoewvn6ECDs+UUskH
	njN1QPYniKPXzEBPAUmRAfPtwBi/CrXAQxW260AM3u7L5oAIzZ0LXvtKsd87KTa7j7C65hNG/E1
	0/RWgzQcI8zzC9GPDKOXMElQUGzrgBWUMLba820UTq+rZUdIjO5sJPpPKqm5SmbmWnJCQyp9FnT
	Bj0hRZNQuEE/JPUZaiVxhg+PLnozOjwKojmDgCKOCiFQI=
X-Received: by 2002:a17:90b:2691:b0:3ac:aa8d:19f2 with SMTP id 98e67ed59e1d1-3ae8985390bmr7983247a91.62.1793633710843;
        Mon, 02 Nov 2026 07:35:10 -0800 (PST)
X-Received: by 2002:a17:90b:2691:b0:3ac:aa8d:19f2 with SMTP id 98e67ed59e1d1-3ae8985390bmr7983225a91.62.1793633710362;
        Mon, 02 Nov 2026 07:35:10 -0800 (PST)
Received: from ?IPV6:2401:4900:1cc4:ec63:d913:9793:cfad:cfb8? ([2401:4900:1cc4:ec63:d913:9793:cfad:cfb8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e949077sm19269008a91.9.2026.11.02.07.35.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 07:35:09 -0800 (PST)
Message-ID: <4c36ffdc-ec1e-4247-9b34-bf7caafd46c7@redhat.com>
Date: Mon, 2 Nov 2026 21:05:03 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/liveupdate: Preserve VM workspaces with
 run-vmtests.sh -k
To: George Guo <dongtai.guo@linux.dev>, pasha.tatashin@soleen.com,
 rppt@kernel.org, pratyush@kernel.org, shuah@kernel.org
Cc: guodongtai@kylinos.cn, kexec@lists.infradead.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261029090542.13283-1-dongtai.guo@linux.dev>
From: Mukesh Pilaniya <mpilaniy@redhat.com>
In-Reply-To: <20261029090542.13283-1-dongtai.guo@linux.dev>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NDhXkUeqLOxMyswL-aJgfabUgdzYTudINI5aQ8LQFpE_1793633711
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261102_073514_648466_E7935386 
X-CRM114-Status: GOOD (  16.71  )
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
Please feel free to use Reviewed-by: Mukesh Pilaniya
<mpilaniy@redhat.com> for this patch.

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


