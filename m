Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F21B3C10F16
	for <kexec@archiver.kernel.org>; Tue, 30 Apr 2024 18:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=z99t2fjsEdUtqfTRtEqlYRP1nOTU1meVl23auOXhWaw=; b=0a9sZbBXTngsp9
	FMoYRTjSIO47F3OG8fKYOTk+VMeHe7DGtbV6ecvHN+Dgh206LRU9+Jz40Ay7V+lTXnJ7Uc7PZX7xE
	tL1eCS0f9edUdpcVc9agUOUgQTEDzky0Pa+CInvOtZ3dCIosxFr1CYIDitwbOCmiX0Fjdj0tm+yNQ
	rxUmYGc+0aUyStoN2r/+ljfEB+pAJD2ezN4cGOwmL94YCQ+SvJbagbrjr7xCEyEOxbxkC0ajul0dc
	+FbBVwYXJ8essI70byf7krv2VCMelzK7S1Vaw3AP+cyjne8rKe9eBjXp+6q1GtjB5yh0IY5cqKKDs
	hwAcBT+du3484q6Gq3Jw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1sD9-00000007ZuI-47Oc;
	Tue, 30 Apr 2024 18:28:16 +0000
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ryueH-0000000Dust-1yAy
	for kexec@lists.infradead.org;
	Mon, 22 Apr 2024 14:28:03 +0000
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-51b09c3a111so1907826e87.1
        for <kexec@lists.infradead.org>; Mon, 22 Apr 2024 07:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713796072; x=1714400872; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UNBjOTY0qs0uiF8EORx5BtyTGJtQ6MyutJpELBAOp5E=;
        b=ZbaRFXyKdfHUv35MaDzjxM8dAvdNcUtNsrw+zvC2QnT8lFhagUfqHki+T4OvjeS/dA
         OL9aGNZhMcJ9FyVk+0nY86F7Td/e9H83bEI/h/iNt54qIwuO16bgW8ItPCZoOiYQfYjF
         2Lm+C0T2vpUkgGWl0y0ho/t3Aoh9rBkGdsQD1LkOmMpvy27CKg+mIwJRHifdlYgeJi50
         XY+kyReShftO+Izwpy8VE+zHvXZr5Dr1HJzcjjP3ypO13Ulxw8+tmXClgFMtUWhT0/bX
         dqnQ9e2AgALW/9tpSXlaF1hM27xJHcuOOMr0CISpqngOwQkzXjr/phHn/HX5Zuy82gOa
         Nhnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713796072; x=1714400872;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UNBjOTY0qs0uiF8EORx5BtyTGJtQ6MyutJpELBAOp5E=;
        b=GopiJoPdx4e6gxuP4AXvolXroRSr7Aqg3GqjAtBayGmPBH2PI+M+zJf1QJyHFDQQUe
         8iq6mKG/DqpI0FxtNaueiGNtu0HVUBScGtFbauizUhiR16eq4Fxd2tfcHAYJOk3vS2Up
         peGjH581k5gyyQNlPnHkD7IwPaq+VoPoP34r49uyXwl27qYM7QDhF/XosTWLdEzEvUpA
         mOTIXi934ysFhzUImpDGepMTTXlkmkbE1O6/47pSJjmVXNcw7wVBwsGpxQ1N+YUhsxGj
         wp+y81kDpnyupTtXzG/TrPyOnuky9wH7l+Kq/mOc6VHrCqSmDuYzpC0G12johGuNY9XK
         7KJg==
X-Forwarded-Encrypted: i=1; AJvYcCWP6yGFCRuxTRaLMosQCjj/A9iGnEg3w8TXAXCGspISyOa7EFnb89tvhk4vvHG/Ypyzx30NYN9qnQ4gUpDB0KucFLn+pr37SIEB
X-Gm-Message-State: AOJu0Yy4qSjWqqMWElgwvbdQQdkJOtK2snzb4vhO2Pyc9+EfooLsMgxb
	raXGcmWCA4i+EHG+Vu+SoMcxWV1rYCrC9cGDQvcBftetvo+ScMTujSJuN4ulOWs=
X-Google-Smtp-Source: AGHT+IEkN6CNdQTBKxKxXZBn2HlML3rafBsTIUTuTxt2ocrHVbXK17h0QDhg5Z61h1NNgJ6JKtrQow==
X-Received: by 2002:a2e:805a:0:b0:2db:99e4:dbdd with SMTP id p26-20020a2e805a000000b002db99e4dbddmr5541085ljg.53.1713796072319;
        Mon, 22 Apr 2024 07:27:52 -0700 (PDT)
Received: from [172.30.205.46] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id p5-20020a2e93c5000000b002dce3eab848sm1076631ljh.47.2024.04.22.07.27.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 07:27:51 -0700 (PDT)
Message-ID: <36a1ea2f-92c2-4183-a892-00c5b48c419b@linaro.org>
Date: Mon, 22 Apr 2024 16:27:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/10] sysctl: Remove sentinel elements from kernel dir
To: Joel Granados <j.granados@samsung.com>,
 Luis Chamberlain <mcgrof@kernel.org>, josh@joshtriplett.org,
 Kees Cook <keescook@chromium.org>, Eric Biederman <ebiederm@xmission.com>,
 Iurii Zaikin <yzaikin@google.com>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>, John Stultz <jstultz@google.com>,
 Stephen Boyd <sboyd@kernel.org>, Andy Lutomirski <luto@amacapital.net>,
 Will Drewry <wad@chromium.org>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Valentin Schneider <vschneid@redhat.com>, Petr Mladek <pmladek@suse.com>,
 John Ogness <john.ogness@linutronix.de>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Balbir Singh
 <bsingharora@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, tools@kernel.org
References: <20240328-jag-sysctl_remove_empty_elem_kernel-v3-0-285d273912fe@samsung.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240328-jag-sysctl_remove_empty_elem_kernel-v3-0-285d273912fe@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240422_072801_525598_FCF1594F 
X-CRM114-Status: GOOD (  12.56  )
X-Mailman-Approved-At: Tue, 30 Apr 2024 11:28:14 -0700
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org



On 3/28/24 16:44, Joel Granados wrote:
> What?
> These commits remove the sentinel element (last empty element) from the
> sysctl arrays of all the files under the "kernel/" directory that use a
> sysctl array for registration. The merging of the preparation patches
> [1] to mainline allows us to remove sentinel elements without changing
> behavior. This is safe because the sysctl registration code
> (register_sysctl() and friends) use the array size in addition to
> checking for a sentinel [2].

Hi,

looks like *this* "patch" made it to the sysctl tree [1], breaking b4
for everyone else (as there's a "--- b4-submit-tracking ---" magic in
the tree history now) on next-20240422

Please drop it (again, I'm only talking about this empty cover letter).

Konrad

[1] https://git.kernel.org/pub/scm/linux/kernel/git/sysctl/sysctl.git/commit/?h=sysctl-next&id=ec04a7fa09ddedc1d6c8b86ae281897256c7fdf0

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
