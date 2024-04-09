Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B6E1C04FF6
	for <kexec@archiver.kernel.org>; Tue, 16 Apr 2024 09:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Message-ID:Date:References:MIME-Version
	:In-Reply-To:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=n/Sx517FOKZKPhbfA+vdu59hj2FjXl4F6gDSFK7XrDY=; b=V2tSH/gnlYxzrK
	iW4m5uKkV2u5K+GC6FT2jgxh47hblGaRr2ZI/P/PPOzzJnDF4S7ZCtCW3yCfi8vLMJBYXbHwTdcZN
	CwkrAQWd0W2AivizxBOdNrYfBOf5FBOY2exhrjUMCjZ6r+y7lQyuCnKyZYba3dKkJSnOaPpMN8iCk
	2UgkIY3VHWvSxRWkdrAPcWKBfGeri0mkhQcGz/ccW9Uh6OobrjNDzHESRf+Yx2QEcWT1ua2O7bsMS
	SpUEHfsd5spWZNovbPTFT/rNHY687JtFfnZ+Im6cxJG4vFetruvq1iSVZQ6obzStSdKaoVcL6sKQo
	lNjleTHbGOzWC6CXjFyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwfOh-0000000BeSd-2LIO;
	Tue, 16 Apr 2024 09:46:39 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ru7N2-000000016s6-3HIk
	for kexec@lists.infradead.org;
	Tue, 09 Apr 2024 09:02:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712653335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=euhpq35wFK9rmemS5feCCQzrNuJRo+rAgFPHnTkC0AQ=;
	b=KpQFxEST1MCnVLCSyly/XAxCsNUpnTs2CPXMKqFo4q83hy1A0QgReJY/wklwqGYqFDeuyE
	MTEKNSii8HspAk6j3HdSc1M4c69DgXbbajeFMpTa4X2/iPR8EZ8C6gCpyaYmLELklgOg+Y
	rdw4WryVTm5KOVY4B3+vge7HWWS7oUA=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63--a7t__BtPt-nGnDBejabBA-1; Tue, 09 Apr 2024 05:02:14 -0400
X-MC-Unique: -a7t__BtPt-nGnDBejabBA-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-78d3352237cso770252185a.1
        for <kexec@lists.infradead.org>; Tue, 09 Apr 2024 02:02:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712653333; x=1713258133;
        h=message-id:date:references:mime-version:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=euhpq35wFK9rmemS5feCCQzrNuJRo+rAgFPHnTkC0AQ=;
        b=DF0lcmrZsL/QMqHq3EXur/krt4i42CWjauKneRYtCsNG2ZZWoUCbJ0FvzdmXpuJuPx
         VdU/g803N073BUJUm+5I0BMN/2A8sojXCCli0s4xci7HL3fEKbuA2nObyXeQwlbxvyoy
         aeFgjnJU6hdueWpIb9gy6yDzKX+i3J8cee81wIqjnwb+rXM0fpmZFjsLCDH76BeflooC
         MVRmx6j8AtKmMUqnosgafBDqu2KzfulbiP2P6+t3oEaEv7C8okeQp2fQkRdgeZgASCHu
         EUVf5sxuBbB5hZSUZSmDnFyJMYolz5fo39vNZByQ0FeOkx7Efz91FRpLBjCCL/IW0nXO
         Erqg==
X-Forwarded-Encrypted: i=1; AJvYcCVYJ+vEjkFVCnUD+WeNSSDVqb2sTpcBnIaA9RRZdzJ2VXlEoBn/2OOnPcwKlCi9pTemtOsciXG/826aoOzVlZcGXNf+h4P0WqEl
X-Gm-Message-State: AOJu0Yzx9MrNr9Z0pN+wsEsyppSIXerTi8BB4nalLmXUu4HQKm3mcvAU
	EU+/t4OJAQSZMPF/svXkXb+DdLu2h8f0xzMqXZV5ljRAdJ7CUKk2qdSf3UByXp98EjkzZ/keR+9
	AXMMq4wBj5MOIVH8o0rfbTlWDLd8bs/CivhTQ+C3+E5sGsb+hOwYDckuSuQ==
X-Received: by 2002:a05:620a:198e:b0:78b:b0c2:17b6 with SMTP id bm14-20020a05620a198e00b0078bb0c217b6mr3048003qkb.11.1712653333558;
        Tue, 09 Apr 2024 02:02:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfJ9YI9fXu3bzCu+1ZKDrEFWqdCINgH4B4WK2Fj7Lg7ZxEGYh8Q7hvW22usdjnP1/pni2urA==
X-Received: by 2002:a05:620a:198e:b0:78b:b0c2:17b6 with SMTP id bm14-20020a05620a198e00b0078bb0c217b6mr3047929qkb.11.1712653333008;
        Tue, 09 Apr 2024 02:02:13 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id h6-20020ac85486000000b004347d76f43csm2678126qtq.79.2024.04.09.02.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 02:02:12 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, josh@joshtriplett.org, Kees Cook
 <keescook@chromium.org>, Eric Biederman <ebiederm@xmission.com>, Iurii
 Zaikin <yzaikin@google.com>, Steven Rostedt <rostedt@goodmis.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>, John Stultz <jstultz@google.com>,
 Stephen Boyd <sboyd@kernel.org>, Andy Lutomirski <luto@amacapital.net>,
 Will Drewry <wad@chromium.org>, Ingo Molnar <mingo@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, Mel Gorman
 <mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>, Petr
 Mladek <pmladek@suse.com>, John Ogness <john.ogness@linutronix.de>, Sergey
 Senozhatsky <senozhatsky@chromium.org>, "Naveen N. Rao"
 <naveen.n.rao@linux.ibm.com>, Anil S Keshavamurthy
 <anil.s.keshavamurthy@intel.com>, "David S. Miller" <davem@davemloft.net>,
 Balbir Singh <bsingharora@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong
 Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Joel Granados <j.granados@samsung.com>
Subject: Re: [PATCH v3 06/10] scheduler: Remove the now superfluous sentinel
 elements from ctl_table array
In-Reply-To: <20240328-jag-sysctl_remove_empty_elem_kernel-v3-6-285d273912fe@samsung.com>
MIME-Version: 1.0
References: <20240328-jag-sysctl_remove_empty_elem_kernel-v3-0-285d273912fe@samsung.com>
 <20240328-jag-sysctl_remove_empty_elem_kernel-v3-6-285d273912fe@samsung.com>
Date: Tue, 09 Apr 2024 11:02:04 +0200
Message-ID: <xhsmhil0qaoz7.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240409_020224_929940_762B1ACD 
X-CRM114-Status: GOOD (  10.65  )
X-Mailman-Approved-At: Tue, 16 Apr 2024 02:46:37 -0700
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

On 28/03/24 16:44, Joel Granados via B4 Relay wrote:
> From: Joel Granados <j.granados@samsung.com>
>
> This commit comes at the tail end of a greater effort to remove the
> empty elements at the end of the ctl_table arrays (sentinels) which
> will reduce the overall build time size of the kernel and run time
> memory bloat by ~64 bytes per sentinel (further information Link :
> https://lore.kernel.org/all/ZO5Yx5JFogGi%2FcBo@bombadil.infradead.org/)
>
> rm sentinel element from ctl_table arrays
>
> Acked-by: "Peter Zijlstra (Intel)" <peterz@infradead.org>

Tested-by: Valentin Schneider <vschneid@redhat.com>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>

> Signed-off-by: Joel Granados <j.granados@samsung.com>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
