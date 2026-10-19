Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C39606A32A
	for <kexec@archiver.kernel.org>; Mon, 19 Oct 2026 19:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=uIc0sAFu;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=dnUOr4Tk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=brXSmDy6U/oRKvH40grJe8uDEK1S7rGaavMW9jk3fYA=; b=uIc0sAFuHT7mIXsJapapIbkC/i
	uqPhJc/WbyfSuGatkCugTd/y4GTGSkyReqAhDk41ZJlxwGkOx/yqD6MLL8EySYqOCYwirZVuoBZcd
	ikqYjj5+IFN6X/+5Ub0rxOSD1VWYfYRPL4i8IDLhLd40AaQlGH78+1y/yvT76NoQq/iRFLp0cGIWm
	3rgJl2Va7zB1dlWZXCMZ4jVlAL1fT5whXa6F+CkHqZod1EewEuAmwMGjlzxeL8ilvlTIq23TNaWdq
	5aqXzqhnbabry0DXL72kEps8DUP802iJWoCDEnekvyJp1aCJw98Ni/y9XnZyyHJWxm+8kp0oHOz1j
	cJP0vqYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIsmO-00000008EH1-2TSN;
	Mon, 19 Oct 2026 19:12:16 +0000
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIsmM-00000008EGb-0BD5
	for kexec@lists.infradead.org;
	Mon, 19 Oct 2026 19:12:15 +0000
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-6aa9164072cso3345262a12.2
        for <kexec@lists.infradead.org>; Mon, 19 Oct 2026 12:12:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792437132; cv=none;
        d=google.com; s=arc-20260327;
        b=ltk/sjoLJNJGMyo7tZuxFcs/s+J3hiIZ0TqLVGqlLkZXdxmBEeRIdJiz9QtIR5M8ez
         8q5B0xtOdsU/Sa8bZ+TobhV/JV8v0C980u0W7PrsTJ086LCHeyBv5v22GsuI8YybdxjD
         PhfZ1NQ3NipF/jJY4rc/pi6MamHN/+KXh3k9UByVM7CfsYyPk4iK8vflqGshgisAhL8C
         Y7B8LX6BO7pwtqbelnrGk2eIWF2VFu+/mgc1FeeFVpW/Pqp36MFfmOBNVI/Q2JQ0z5AS
         Jrcyte14RB0jpfLiYVh6fO7HjYMKjnjnQr6Y30WuXSFGz+U3u/yptmfCJ2N+v0AflPDH
         gVCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=brXSmDy6U/oRKvH40grJe8uDEK1S7rGaavMW9jk3fYA=;
        fh=UGGwx9zgjfN7aqEqqKFDnH5FgKjIdR1+yO/0pk9kOew=;
        b=mnKrqg+HYqzUBgtx8VHlR6RZPb05nE9/b83hrGkd0aiPhkRPBnUZiwqNpKl44TSzsC
         6UdrRdxkREbakkXkML87ZFD2zNLk8UNTMyFDF46SYopKuvsVlhqQ1XpnEMjNEDwx5J4T
         IKsQOzm++kdBqDe6oHu7DyiAqcQHbu0Fi+7X4pckW+w98F0Osd+Y/0otVA7lUom2ZwHr
         860NUJrUPDH38vbwnV7lWndRbdz8s8BRoai5YF+ycomgRX2p1SObW44RPvcG1zEwQoGL
         d5oEEjho7Jh2SXJ3gmiLb2bx/nim+WX3a1eHrem4VJhhvqFqmg8xP8t4XNeZTnpUIXv8
         bvug==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792437132; x=1793041932; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=brXSmDy6U/oRKvH40grJe8uDEK1S7rGaavMW9jk3fYA=;
        b=dnUOr4Tkxobg4cAcB4j3ZFHWGL33FofUlVSO0Gym/pP1CFQWwCUFujxppnOixdERLE
         8LlNdRcx05c8a/tH5Zvq0p3f85IVJiL+JxpfFXqucPwIVklp0ZjKqtBYV/DtCzSqlmac
         UjiUg4nqslNOcUfMjVTR8xX+Cg77J8/wHiMrBoGE9nrWYxGtf2l1EXODkPIS42CUyINb
         pWFgDwCup0/emoUNYBnwNlb428lljF2RzOK2Tswpe2Unh9652zod682OZe+vCXRvSlqI
         hAnmKdYZYpZRhgzLvRn3w1ySjozI7AKxIPtEFzveLL7JpOnS6s95emNfsZ69+mFdoiP4
         OVEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792437132; x=1793041932;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=brXSmDy6U/oRKvH40grJe8uDEK1S7rGaavMW9jk3fYA=;
        b=AYFx+Nc8FaRlhnnN7nL6yppdW8Qg+EPT9egm4sj6ot47Xc2Ww8Mw1pZGH/XzTEhD0O
         1hD4/6fGJMu70aUYjwF9QeZF2sBmevGhmbrCWaYSKVeIQ/TarBPa3NS727PS8YznFKnt
         TXOcxyhBJ7eQJ8kvFxCLqVxOuHmSxn27vUeBLybctLuepElaNgx3wvHG1lokTMbpLwFf
         VMhcQO41lvND69zX9wt4+7RyCma5DoncMU656KuwdaYOz3ELDFyMkAFQw6EIxYlKE7OL
         HncV1fqjUXgphLP9DYXcmbGZ5Yh+V6GgInboUA1K8jexMscIqWdKEwnEdXwn9kz40Jx9
         eKpw==
X-Forwarded-Encrypted: i=1; AKwUvBzCf5klSmbMYTazy2v0NWkPT20iqoXGWPEs/7OdCl+GifY0iS4osnD5TgdHiFwG3d6jYumaJQ==@lists.infradead.org
X-Gm-Message-State: AFq9FYLve51hNI2wSHDoq+F7vWl7J7QpeaHr7cFiBR4OCFwX0wfjRIKt
	ixquJbiqKsOBpuN5eQc5XNPMQt5A6H1AsW1B+FlwpZN+FNaZdI3oggjYxMMwQ6fjMIrOtGJDutU
	ZrPoGU1fVXaz4y0wT3IHEec2gbo5PtUn+Da0McGuMUg==
X-Gm-Gg: AYBFou1ASd553oPTbT1u+8B2bum8M92H0cbYGtg88hPe9cCmEPTe7+J8nce7HPqOAHk
	p6EnCsC5HmFhPI2PGv+BsGNlgRhN1dvfLwCEgQNce0ae3GDdtHAKKp1Z7WVILqmtMAN4rOVg/oU
	rsA1ofw7xPIiQ9uCPVVUCYTTEo/13QUqbldAKfLFdJTy2CyEL7T91kgUFaHkrc5TCJBb2yzj1IC
	voJEExGplNSLw4zzum/YRigEpN8BiIb61IQr1fUUXwqv2xk0hzTW1QBhggadBEE3KXIwwxlcEUj
	BqdL6Y8idkKiJUvzBASmKKSTwFu6XuQgQQIQkzGbd29XK2t8pHA2eT8oOsKHzPItE+WcUzDlQOz
	dBFq7cwGVKgRRN38ZwS0FRJmWu+ycOi8AP6YuXsoNChVESq0ARJ5+oI71KSOoid2nxM8F2vj8xY
	i8j8pmYxaUExbY
X-Received: by 2002:a05:6402:a295:20b0:6b1:c6ad:ae3f with SMTP id
 4fb4d7f45d1cf-6b3a8199b12mr3606189a12.35.1792437131823; Mon, 19 Oct 2026
 12:12:11 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261019011446.834487-1-pasha.tatashin@soleen.com> <SJ1PR11MB608365E406C4DA7CB91858A4FC982@SJ1PR11MB6083.namprd11.prod.outlook.com>
In-Reply-To: <SJ1PR11MB608365E406C4DA7CB91858A4FC982@SJ1PR11MB6083.namprd11.prod.outlook.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 19 Oct 2026 15:11:32 -0400
X-Gm-Features: AclHuK81i0D--1zvoLFLDSEjKdb8OtLyg3_R_Omdu6BLSuefBq3mveb_0VEz-04
Message-ID: <CA+CK2bAQr=Ak1u-Aiwbw=DZ22Nk8oRDqnC2AnRaez7nOyJj0-w@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] x86, sched, mm: Speed up CPU hotplug on large systems
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "kees@kernel.org" <kees@kernel.org>, "rppt@kernel.org" <rppt@kernel.org>, 
	"juri.lelli@redhat.com" <juri.lelli@redhat.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>, 
	"tglx@kernel.org" <tglx@kernel.org>, "vschneid@redhat.com" <vschneid@redhat.com>, 
	"kprateek.nayak@amd.com" <kprateek.nayak@amd.com>, 
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>, "bp@alien8.de" <bp@alien8.de>, 
	"jpoimboe@kernel.org" <jpoimboe@kernel.org>, "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, 
	"david@kernel.org" <david@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"seanjc@google.com" <seanjc@google.com>, "ljs@kernel.org" <ljs@kernel.org>, 
	"zhangguopeng@kylinos.cn" <zhangguopeng@kylinos.cn>, 
	"dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>, "mhocko@suse.com" <mhocko@suse.com>, 
	"Gomes, Vinicius" <vinicius.gomes@intel.com>, "vbabka@kernel.org" <vbabka@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"peterz@infradead.org" <peterz@infradead.org>, "surenb@google.com" <surenb@google.com>, 
	"hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>, 
	"dmatlack@google.com" <dmatlack@google.com>, 
	"tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>, 
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>, "pratyush@kernel.org" <pratyush@kernel.org>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "rostedt@goodmis.org" <rostedt@goodmis.org>, 
	"gmonaco@redhat.com" <gmonaco@redhat.com>, "jgross@suse.com" <jgross@suse.com>, 
	"mgorman@suse.de" <mgorman@suse.de>, "Graf, Alexander" <graf@amazon.com>, 
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, "liam@infradead.org" <liam@infradead.org>, 
	"ridong.chen@linux.dev" <ridong.chen@linux.dev>, "blum@kernel.org" <blum@kernel.org>, 
	"longman@redhat.com" <longman@redhat.com>, "bsegall@google.com" <bsegall@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261019_121214_124008_3BC8C290 
X-CRM114-Status: GOOD (  14.63  )
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
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 19, 2026 at 2:22=E2=80=AFPM Luck, Tony <tony.luck@intel.com> wr=
ote:
>
> > Benchmark workload (mean of 10 runs per step):
> >
> >  # echo 1 > /sys/kernel/rcu_expedited
> >  # for i in {1..N}; do echo 0 > /sys/devices/system/cpu/cpu$i/online; d=
one
>
> Side question. Have you had issues with this step failing on large system=
s with "smart" I/O
> devices that support many interrupt vectors?
>
> Some validation folks inside Intel had some tests that looped taking all =
CPUs offline and
> bringing them back. They complained starting around Sapphire Rapids this =
their test
> would get down to just CPU 0 and CPU 1 and fail to take CPU 1 offline bec=
ause there
> were too many interrupts to fit into just a single CPUs available vectors=
.
>
> It was a while ago, so maybe something changed in interrupt code to handl=
e this.

Hi Tony,

I didn't encounter that issue while collecting the benchmark data.

For the Live Update work I'm currently doing, I leave 8 CPUs on the
host to perform kexec while the AP CPUs are removed from the
scheduler. In the future, I plan to leave only one host CPU and have
the remaining CPUs manage the VMs in Caretaker mode.

Best,
Pasha

>
> -Tony
>
>
>

